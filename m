Return-Path: <netdev+bounces-121338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62D95CC97
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AB7282A9F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26971865E3;
	Fri, 23 Aug 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="u5r4ew5e"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EC566A;
	Fri, 23 Aug 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416978; cv=fail; b=d3bS818xvIuNLUp4Tzc//f2ZXpabkr0PDojSFRoEbx02OcIVe2XwZK+XfCuLkuIANIb0Omht6rpZplA5eH+nD47u+KC228hXzXfbbhcbepUEXe6Xk3lvy5NmGl6Kk41etO7SbcoI4x4EGt7hJ78czKRA0fBTMPS4Omx4xUJAsVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416978; c=relaxed/simple;
	bh=qFeohQtiqgPnJ8WFgHXVTSiwokkFSUPxUwQX2Pm2Yvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NUL+Gb9pSnm2T72bn8ypqDjtIJJUxPdh1ZFfdMaonBl4g3BYCwBPxOM8IcuKpa49eWgBpL+qzy2GXyCU3Qn3CqSS4sXB8JiEkxIJr0Eb53r/S1LZlMKLSgD1W8n7uMNLPDmBxIfxJQIbVpqqe2ejiKSvJPLto/7ArezM1Tx4n5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=u5r4ew5e; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY5vMQge9Y2L9EeUoOgvqGqlknkBO5/zt3PUFtvkOur0fPRBne8t50kmQq0tBOtxlidIkvNXabmwx4hoUROOKMha0nycvS4/lo5kw+Ove201yvPZrVLR56nvPK9Z65jfMI/F450LSEaDZK2ea24A/3pGUJOBjFcRooFUUq0NN2SMsOJeB7YKnsbIKdiVI0pZm//Fzecvwg1Z7v0ilDQHrG/EdpbzY9Z13xuumgvenSUU5oVFgIRl/crnkFNBtOiWet8lSTS+kVxEpi0ItCX2bYPJhlJxp3KFDrA2UjkBA9jQXGCihlU75zaxz/FdeY+uguD9By0WSTNdPPt0XZ6FwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOuedaJwgTweDSr6meloy9y/hSWTHmo139oBre89Rxk=;
 b=QPIgza/LRhSM+v/mH3y8N4VCVLrIAe0v6emEhU7g/1fE72pxTqOlivyeBaXOEHBGFys4WzFWwvQsy9K+kqtmO+uJ/l8EgC2j7qYu6MSxoYoL60Cmb0AXi1n42pF3iMJh2872u1zMZlcYnj+DVdOUyJFHEkwiWhEGzvHy4OokdNpV0Dw8ohavvFIUdhXWerFqpt8TopRmgAPFToY+yNd/fBjnPoNDibDPLrzVIwTOsshSEayGIET5F7WZ2si3Mauc+tFqjEkQ8QQESmEwSguZKd4OOMuud5pegKuyMHLfxp9YpEFteurBME6kL+65fHuSddlBggl6m9Uh8rtCXhfgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOuedaJwgTweDSr6meloy9y/hSWTHmo139oBre89Rxk=;
 b=u5r4ew5e2QtIO7ynoCysdRr7ZnrWUo483qfPkc3C107VKhPiuMIJpmWu0v+YMOyQGyjaG6yEj1Fs0zd3ail8Drq+z+zaVDUReWPLpY7J/97BlWTPDXja6/I5dgM9wis/lH1hTLvGFNMv1eMHHcp+YMXkd4DGlMpdBQzqOsfIZG4=
Received: from AM0PR02CA0118.eurprd02.prod.outlook.com (2603:10a6:20b:28c::15)
 by PA4PR06MB7328.eurprd06.prod.outlook.com (2603:10a6:102:d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 12:42:52 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::bc) by AM0PR02CA0118.outlook.office365.com
 (2603:10a6:20b:28c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Fri, 23 Aug 2024 12:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 12:42:51 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 23 Aug 2024 14:42:51 +0200
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	customers.leicageo@pengutronix.de,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH next 1/2] dt-bindings: net: bluetooth: nxp: support multiple init baudrates
Date: Fri, 23 Aug 2024 14:42:38 +0200
Message-Id: <20240823124239.2263107-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Aug 2024 12:42:51.0601 (UTC) FILETIME=[F79D0C10:01DAF559]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A60:EE_|PA4PR06MB7328:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9204f9da-dfb1-4c4d-9dc0-08dcc3711a38
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ZLDnrjM56DaSyEbzzwJcqN4Ou8iaxKOXZzq8RRbI97/6SRqAaN0leyD9OKq?=
 =?us-ascii?Q?TODWGGKkzYYJSMmCFwtSxbIzDT1kGfVIP+UCQoQnrEdqugZzai4dR2+ItADl?=
 =?us-ascii?Q?3zDEu/u0CJhk1nnKW/bZjIgKs6JqJT8c56mb/j8/QqqXLKWanDmom+6lhI9J?=
 =?us-ascii?Q?xZIggjY4yHU/u+Qw06rHnx8CvescVhXIYe9RkXjI2Unwptl5Z4n79jLXILlL?=
 =?us-ascii?Q?hewXA0cdqaJ9rtrnvxohXtzlN7G9PRkSTbnQg8YC6YM1JOpFfwZU1Z/dyCJU?=
 =?us-ascii?Q?rmez1T47y/1qhCrwpIATrmF0P3LQajpUwz4t9dtCC0kw0lelRkSwXnk9FiUf?=
 =?us-ascii?Q?9gdUp1eE39y97TzrskUqhaIkNlpwnbdINcd8vnkJ42ioxqvW2xsr0+3jLAwo?=
 =?us-ascii?Q?XaVcXplpC7WXnWvuqoqIlbCoow5+s6z32xFJEkMblG8ZLRUEowfU4yB+hcTP?=
 =?us-ascii?Q?9URLiHibQ+7E/D52qEFyn1geMVmbAfmdXoOEWzBLekVkicniKvxzbN0whhl0?=
 =?us-ascii?Q?pDLcXBkRYGrgCeohxIYGkzUUxzOan9qXDT4Z42czNrBfxSw6LWDSxg54r2x8?=
 =?us-ascii?Q?qQG/ilMTPxtomLB7ZKBMmi+F+RkISQg+2qwFk73LG19BFHuC0FY8IcZWBy1l?=
 =?us-ascii?Q?uRJ1JOlT2IpXBbhiwPGXGHNDwbq/7KyJqUVh2kEUYhQ7VrxycmjFM8h848l0?=
 =?us-ascii?Q?zUwPjE0841mYPO9b10qIVp+zbN8XJ3mddR8H2IwpEdd2DLKPqFDgSm8eIU6b?=
 =?us-ascii?Q?gRc6/0hjui1J9NBcds8bVoMzRIDMrrgPUScl4z0hj/Uj+vZzALibHCOMDw8B?=
 =?us-ascii?Q?Kipv7ofmEj5ntPfVkdDEcjLDzeJ3bID4TZfR20EACbzd/zUAoqXe6tRc0GOs?=
 =?us-ascii?Q?yPVPliDJGT0mmwv5sLKHk6DdYYaaFdwYg3ZP3mRkm9X4pSyImzhG0MYpk3St?=
 =?us-ascii?Q?9qNTWuEp60N618nncb3ZfjKM9EHMq8ZSTWmvshGK0itK6UwNwtPyavioOhnH?=
 =?us-ascii?Q?81geSgUFfe9Zb2m0JBk7CFD3gvztckDei2tiD7mgqZ1I1WNOrq7kq5NVzST3?=
 =?us-ascii?Q?J5DEVDSD4p2fUclyQQ3pc7Dc7xxynbx1+XieO1qa8nTb8+rO7E7tuVzk/x9X?=
 =?us-ascii?Q?9+sgz9we0oxoV0/PXGZ9o5YcfoZ4UGm/Cq3S3VRX/zX/2Iv9XEQ8zmP7SdVm?=
 =?us-ascii?Q?CENrNhPleSp7rp2Ly0lx19TGycKrmm1oeAS6CxfV4pp08maZ+h9KAW4j3+Ye?=
 =?us-ascii?Q?UQlu+FX1OK0GWLDl+aW9y8CWUc53Q997hcvkYWJPy5xuo2Rmui25sW13vAS6?=
 =?us-ascii?Q?40FSUdC2Qkan9YLOzZ1Qnm07azNHhBhnTSNBjqt7tvyq615WbqpAKMQxC0aY?=
 =?us-ascii?Q?8Of6CDlwLuSnv6oW1KD4YgQ0ghX0zvHtAn3ydTQ9IAHxXIuSjPwRTITEe5un?=
 =?us-ascii?Q?zmZ0sew7ltWeveZxAZvhPiXnIj/bYjqoM3eBMQAAnPn4gt47vFMljg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 12:42:51.7469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9204f9da-dfb1-4c4d-9dc0-08dcc3711a38
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7328

Make "fw-init-baudrate" a list of baudrates in order to support chips
using different baudrates assuming that we could not detect the
supported baudrate otherwise.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 37a65badb448..42e3713927de 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -25,11 +25,12 @@ properties:
 
   fw-init-baudrate:
     $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 8
     default: 115200
     description:
-      Chip baudrate after FW is downloaded and initialized.
-      This property depends on the module vendor's
-      configuration.
+      List of chip baudrates after FW is downloaded and initialized.
+      The driver goes through the list until it founds a working baudrate.
+      This property depends on the module vendor's configuration.
 
   firmware-name:
     maxItems: 1

base-commit: c79c85875f1af04040fe4492ed94ce37ad729c4d
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


