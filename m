Return-Path: <netdev+bounces-233757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B28C17FAC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0317E4FDE2A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24EA2E8B8F;
	Wed, 29 Oct 2025 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cHSBaIXv"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071F2E8DEF;
	Wed, 29 Oct 2025 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703280; cv=fail; b=qwFBn95KAVnu0L7FMxt6RZ1req4vX0eyQxn5PqnDva8r8XJjcOE/DfUdeJ+hfgba2iq4gfLWXIVbn6DEq3qGFw6pWBQRj3TAq/Mk0sPEaljHJdAVtHtTfzsIbMrCwGRPwxNvsnO+HaVznHxcvyZnVvy3LmRlA2zX78jy0Yf3Al4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703280; c=relaxed/simple;
	bh=FP1P/y7my8T/hNt4yjfAP01XbCJa0tIrY6oh+g6XmQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AV4iNKBqRoLSMEoKbC25HVODRBofN5+89ep8UpU2Rb+uNgpiX8yFqPvB8zIFljhdOO24mPpe0/Km+ZEQYRbDIVj/w637KsT6lnMtajUjWKATtfH0d6ERXYGBHIO8v9enxwArSB1qLXr6NNPzyS+8GDw7qpdsp4nPj0scNI+wcNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cHSBaIXv; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhsY7CvQUlCGGfqfEOQ7Ki800X+mmCZRJCmQxijPWuplsjDVCfXflTrfy/vNxxQpojuUIogGs+CSzAUcLT/aetEDfai1fh//C31RUjwr+R0qjqsSGIRBcY93fImRZTUMEXRJN8WIalkoeQr19nDGm2OmPc1Sd71vxdrmQ6wGD9Xi0vEOupjCU7jJ1hjrYe9OhgnVzam98z92AnnMte6m+aQ3JH4nxZpQ2ClZH4smYrZVUoJBOwhWlAiR8go6u8wPmOcIOFzqHDFidUb0mKEhAI+FFc9J6FAukWfWDLNHJ3POH/wlowkKIGLS1UAGThfQ/mf7aNHCPA6V38ARc3wfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7+KNeDfkoFNkUqTI1glSbFcerzk4r9cw2K9G6/OMQ0=;
 b=bNJNwRbM9tr3BahLe0y1/Z66ddgx0YgxZuKi8RPP+6hmwTPUmdmJ90Z4Jmlr641Au6RWbtrNuZ4/7CdSUSiZLWjivF2vO5RJRk+BNQY1qummfPCFEKzAuifMCE/wtMdJsFJRzJXyCVTeyOx/Euz78sYjJQPeid7shxxS7BgzRHje4HHOIce58hpPD9lR13TZT9ZgTBz2xTrSY3Ea7QuHrXQ4v0TXCxx34Ryphzoky/R/epsUIFuNBevG/uLwv2QrZXjLXciT+ZkzC42UJOr2EdnPblU2eNNrumeRH0FfUPrPO7cyZn58dhK7j5iQvNHB37DqWMxKl372sauSZqj7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7+KNeDfkoFNkUqTI1glSbFcerzk4r9cw2K9G6/OMQ0=;
 b=cHSBaIXvS1SYdxlao8aW1THH0+sNfrOREASLLTyJd6km2WkQLaoG7v6LJV4CLyRWzKlf0DMm/hUNV3EO1+YLfV2bqMZJb39aMj/5WwnrQrB+UvgOPou+qx8W7ZevLBEzM66mzuQ5BhPpPp+HyP+TaQhooMHSTipTaaOUMzia3j0SMH3vfxX2u2b7e4Qas6PbboAKMrsBsqBei8/8bjrmlLaDUdJZF0z0L/xAzLL9bOzuJ1yqcusgnTGj8sqCDFqURESxke1BqzDfd+Zk054H6jztUmFHVYQIFyGl++QiT9CP9LNNGViIWhoZmYATMYK7vmF1s27XBzEByZ/EiMdfMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 02:01:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 02:01:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 net-next 2/6] dt-bindings: net: enetc: add compatible string for ENETC with pseduo MAC
Date: Wed, 29 Oct 2025 09:38:56 +0800
Message-Id: <20251029013900.407583-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029013900.407583-1-wei.fang@nxp.com>
References: <20251029013900.407583-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: 96153829-1585-4941-4bb0-08de168f0a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pdwY6aWX8SeX1gBKi7eDjxWHa/tHCeMauW48axgVhP/z4SLUGFtC3/75ykwG?=
 =?us-ascii?Q?i6VqAPOfnlZ5oiJaTuwcYMIk9dO5gKPtmLgoab+wI3JkhctntGSwejgvkNvm?=
 =?us-ascii?Q?bvBj6UPExnSqiTD+aOTEL7x49Fxu3OTC05lHrm0mXAxli/pc5O/yV+j5cyUQ?=
 =?us-ascii?Q?Wb7y7qsDu0n5rHSITtffmtEFtg4Yi8cbhbhGXbF0qYftjrlP6HBKkztairgu?=
 =?us-ascii?Q?UAHuRm9PcaShV40gyfZxnt4fOBccLUqc0e1fYI67Pi4L5/zNTjtGzCxURtUx?=
 =?us-ascii?Q?wNmPZbL/I7R1nAx9sf8ygsXp52vl86giyk7oO6OSEYMoAURg9b9JTPa7vm0Q?=
 =?us-ascii?Q?vnw1m4XwiFoA61NSPJ3mVlvqdq7ERkmd4A0VNes0wWIh04orZS1AeKGJIKxU?=
 =?us-ascii?Q?/Bo110V8dPsdQSlIRrGLHP6zU6zgxOc89RNr2PMvvJbhoRo1hk1efhV+cip9?=
 =?us-ascii?Q?x8H2fH6HMQvmtic3FmDjG8rTn6yIRWOrVT2X6FkNh0TTNpzfFwD7owrFkRCs?=
 =?us-ascii?Q?J+t6o/2Yy/h6E+BK7OujtNcM+Nr1e2kxghC26cPCup8EEWb5ncPbj+v6otzg?=
 =?us-ascii?Q?nPqukunQs5/dVm3AekUXniolk7t8vffP+IrMdOAR9r/LHFbcseTHg6f5CcJT?=
 =?us-ascii?Q?/PY9KzDqsGH02eQUo5TQbC72HecRMcebyUK2yuNP5N5W+O0g9Ma/WRAEyC+6?=
 =?us-ascii?Q?gqvGlUotWrsqL8kJrg7MgEOzWPa6IPdv3n58dLBqmJ2iEWK7Ee6W+MLY63PN?=
 =?us-ascii?Q?YbMYty01shdLAPr3NIbDd9nSXu7b/pxRkkiCvjzIZyUJUAxhXiXvHzP8Wb65?=
 =?us-ascii?Q?CB+euzo+kmqbqZ/O+1HsyqC/9THgdE2J+kysXdL4XHkfCDiPTN0ogtBf2XKL?=
 =?us-ascii?Q?qUjZf6qzCxx1/yYZQUR0kD5bDuPQREZ7tHDbgEy2Yt8l1W0bVubIv2eT0+W5?=
 =?us-ascii?Q?yZPmtbgAjD64jnr1mAj2AC9Q2UTaXG7yZ+ws/TijA591ut6p0MWG97Zrp6or?=
 =?us-ascii?Q?1nMey7Ku8Yg+00q0ijiKH+1uhpxak4pWi/zF1H6CAofRUtW6R2VrbBcEt2CZ?=
 =?us-ascii?Q?xp8btC3a0ozzId+sKkvdepeh5Lwt+0BBtCjEKaOPAE3tBUWjXWIAEQR5Q9A3?=
 =?us-ascii?Q?maso4Lnj2tiry/en3uau5Y6pFJqfKhcxesZFYbkJIOvyc5b/ge93hIQfbij0?=
 =?us-ascii?Q?bc7tRhPwT/HuZ+G1sRtFhtpDH64/VDptnRSplK+9Y4v1SD8piFqAX2nhf63e?=
 =?us-ascii?Q?dA3i06ca01AMu58E2Mg6Pv4VYigtiXmgPu4dmOCL/K/Gh/hrRqRNrmeO51JD?=
 =?us-ascii?Q?rjZ1ekhKE8HrxezXjeax8cFhXT7tJQBveBpq3p8hyt3e2JYrEjYcmlQxBLvj?=
 =?us-ascii?Q?/e7qbIK2F7tMW24nYfTYrnINYVhyyKNZAzqYzKdRqDDKvn/JGuSbCLO7od8W?=
 =?us-ascii?Q?80H0oPFEozDXyLbytxLV4lvKLyYdymqv+iBI2R5P9U2WP83Ha4FfZ384MJ1W?=
 =?us-ascii?Q?s6jkETO/bUtZ+hjQHWYzLhiUr1ECyT3dup3RQ591krkSqiKyiA4Je3Lehg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mmFwuzJLF1wbc6sk5y4b+eKOJa4AnKTdsZJNBk4f9dZDz8H+9b1o4GsPYoPb?=
 =?us-ascii?Q?mXrMrV5eGzsQYkzv190Dh+jxxcDDV2bcSOcuqBXtxmy2/I7lmBS+FAtxIf38?=
 =?us-ascii?Q?06Nsm8aN0xEGH+6Ul4eV28L0hFOL89X5S4mefkHUzenpskf+0R0VQ6jpxqNa?=
 =?us-ascii?Q?UhlyIMC09gquobuM3paKouzUxqOnCHJAAdlkVOMVPMNVMRsc0B/vBISDj88R?=
 =?us-ascii?Q?48D1SZPHl8pS1syJn5MoB6M5z8wTfWx1lrMsr7thvzi8eUIw0QKzc/wHZXnd?=
 =?us-ascii?Q?lMO1hahvCdC6UId6jpQ6SFSHDh8R7l766OUTg21e0fvUHJERALeS+TyIXjNq?=
 =?us-ascii?Q?vvvSi6LYiOBJIqg+M3MN9/qleu4e5Tqcq2VmG2tlD9L94kp9KbUUTpxYG3UH?=
 =?us-ascii?Q?4krlenIzyMZJ9kVDIKVGY9YjA3KVR+F4iqx8KzF873esWEvA0fLzlCENTJGs?=
 =?us-ascii?Q?DuUizNiAQ/WtSzy7+Fb5m5CHYywg9PCwqhYhI10D+TIDYEYpNgj5utbu1nWN?=
 =?us-ascii?Q?1/Ar0rcBnyh0dJJkyEHcMklDR6yhgyOzswnbbjPnCuUwBVNYh0uaNcuqWwM1?=
 =?us-ascii?Q?ttT7Lsd+4VW4KP2B0zEDH64cnynSRA1EjQN0vxUrXnYW93uTjEA594VNzDkC?=
 =?us-ascii?Q?0+QLcG3+0uXLAIYgoXuEfuLOG7KpWDowyfezC+nVe/kHGgxVPcLiVtNUb5xj?=
 =?us-ascii?Q?igdaaIw/0eazjWM+Ou8vLcEOatW3S1KT8DbEhp93pKxgtUbed4Lq4vTIYJRG?=
 =?us-ascii?Q?qoZ2RmUQYlNpp9RmXLQeSyfAjDYMOCl0nT26bTliT5Ite77unXGoZVamGb62?=
 =?us-ascii?Q?e5pYm62P2p1Vevw++A4WDIc2tg0q6mECi0AsI3b7fZtzsvZnm+k6o9DiEOl+?=
 =?us-ascii?Q?ztO0uJj71UbftxgCcq+mjE12MElieFupW8VaP9pltcmbt8DFyc0F93a31eKx?=
 =?us-ascii?Q?RyWUu4NijMyz0rn58LD6nh4dcS9dguqysEdoAl8lvAF/FVOOjvJHWJ0OsPb9?=
 =?us-ascii?Q?2KPMV2x39OSe0km7Q9OanMPAdgwcBJhWarNKK1zBflQqGBgqzC7RZQ7c6ytb?=
 =?us-ascii?Q?Qr8tTP/ejulNGQNUTwBReGUQyqBXymvRBLM2XosT0+kitQc4k4TInh779Ezq?=
 =?us-ascii?Q?sJEjfvxt8V1R4j/GZwjtVGVgm3bt/MkRwSaXMy84qaULSKJMftp26yO7+oka?=
 =?us-ascii?Q?w72lCli+gyNGRzR4e3mRzmDA9JLlvEGbOsGPnZPTowov3DRMfR1DpdUCHnBd?=
 =?us-ascii?Q?7vRSZNZbYOUflsp9UxS2zXKhyyhKEjPFLUdjwIHnbQm2wA4KmsHZt79EybTX?=
 =?us-ascii?Q?KWyYTb0TmJg9a4FGg5Ujg7ztbi5QYvUnI66JDhwZxgwrgqZpliiEqqBQBvu2?=
 =?us-ascii?Q?Q8WG7Qb2sYh25c/vQSmIBJN60cn7p4ILuS5tmixsUnEx3vHLRshqdjbBsxZS?=
 =?us-ascii?Q?oAAtltSN3QCUON04v4imZ/ySsIFHjH3gIyfcH8jvfz1HPv0G0jdKEtBN57PX?=
 =?us-ascii?Q?EfB9Oue2YiQEeXW3BPCIIR8u3RmKohVAGBfngyvP45+9KlneZu4kWT9Nz7Du?=
 =?us-ascii?Q?rUmMOtEXXGIAXRJIQlS3vPne+yNo1k4b7KZPSWWG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96153829-1585-4941-4bb0-08de168f0a4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 02:01:14.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5YfW2JJwypgxOGZOreeYne3Hfrw5+pDIae3F/x0SVPwYmT31L051jSvlC0poVmeQfgkmmB8/mbOmQugU4Gc+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315

The ENETC with pseudo MAC is used to connect to the CPU port of the NETC
switch. This ENETC has a different PCI device ID, so add a standard PCI
device compatible string to it.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/fsl,enetc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index ca70f0050171..aac20ab72ace 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -27,6 +27,7 @@ properties:
           - const: fsl,enetc
       - enum:
           - pci1131,e101
+          - pci1131,e110
 
   reg:
     maxItems: 1
-- 
2.34.1


