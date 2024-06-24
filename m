Return-Path: <netdev+bounces-106179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161A9150D7
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0685B285ECD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E121A00EA;
	Mon, 24 Jun 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="olr4n3fz"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF219FA97;
	Mon, 24 Jun 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240440; cv=fail; b=ik9r/7ozwbeyy6wrIOQYA2gx/Q5Fk2k1TngNLpBLs+p+BATp6O1PjZLfJeEzJakGSzOkW0kjvYAKWQf9JjoaPJfUVCLgIXCpCabVyyyoI9sNPtCJ8zoCFjJn+8GKdc8l5czzBEfnBkMMNJfQTGf+Yn/jEccSvTqvzcyyMsGRUE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240440; c=relaxed/simple;
	bh=z6Hf1Yp+zK72VPsyGMaXPxWDTrjoGe5jqMYtJoUZKKE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EFl7CM9X2kYJeJKxZelAWurxE0QtlMhlTjpSkR+QI1oIoUs64lUcCjbCl7Xk+z62iAE0NDVeR7rg7dyoESCo4oINX6b5+/9KyJRMMCQ5fY0QNAxXVzk1GVTtRS4VrCnaKmnrI/2aSvmTWngbHViyBJ4k5zEChBD9pHTi5P107jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=olr4n3fz; arc=fail smtp.client-ip=40.107.104.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CySzgmODrCgbgn66BSWr9xR84ErmyIxIc69Qn54diwybvW+lag2e6jeffXUpAzYRdUeyvmglEXap+0T2LEDbNd6ktZuTnXv2jwy1uGebiPIK5mhcuuC77rO0Y1flzIMKc8rMRb+pGFeooh2Vn7uZqIYGLqvhG/5U2by5H4mIkLm7R5NphK2hDE8oJMO8aFSiIQmV9jVT+zqWzXL9MxdTY9QHm5FUAbUFZBrj0VFSpTWHEDCQ6sIOuIwb3+2zZKv4EyNpTsoJ10N5Y8QBO9BH/Woi/MNuABGPMAb6/C/xOxYCfynwebnVOr0YwEkEQ3rN0WGsQpdap9i3eFaIQ2xQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKf58Qp+Q/d2Kpho8jxSODsXI1kyXdz+P/2HpUfmq1c=;
 b=F48Gol0FWDWnzSforxtC810CPBmvpPpC7mMAJV0RJbAsmRPZ2Vjx7m80h/3igbIfFstmQkNDQtYCz0i2zt6/H+q8sir1Lo7QVz9pUADVeHa+ChQTI0ywvjTcDTwy6sFuyJX9dXvWgShkzp+terWujaoTXgR1jLcTkSjFYb8OqsONKCg1mSFRLJTFS/qLiBk/NxBLi8nG6Q3LySwT/7fqLYU1fRNA4Au0j77KWryYMTJb97QnvCIUjK+GBYKOgOQSu31vqS9ErStb9p9JOA0xkDKtVSIVy6eDzItpr3Z6onPuqz3wrMJQTieQxeAqQp5qedTkmFsE27Zn5N9eEBD9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKf58Qp+Q/d2Kpho8jxSODsXI1kyXdz+P/2HpUfmq1c=;
 b=olr4n3fzUf2qkR41GIXWkwKNoH3hTD/KhRSXZC2HFRIk6xqWAY/dXyv6o9Nn0LMQgL6NKdHuGLO/ld8lt2xboxXy4DJ9fA77JYZ496+Iq2U4jKgSlA9AS9UoXZ9I+K1kFHn6HhBgT8oNBby2/5q5Vq77esG3wASc++zbGBpleX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10253.eurprd04.prod.outlook.com (2603:10a6:800:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 14:47:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Mon, 24 Jun 2024
 14:47:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: netdev@vger.kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	robh@kernel.org,
	sean.anderson@seco.com,
	yangbo.lu@nxp.com
Subject: [PATCH 1/1] MAINTAINERS: Change fsl-fman.yaml to fsl,fman.yaml
Date: Mon, 24 Jun 2024 10:46:55 -0400
Message-Id: <20240624144655.801607-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10253:EE_
X-MS-Office365-Filtering-Correlation-Id: 878b04ea-1dc8-4110-6d0f-08dc945c89c0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?4PaM6gtN/ZdpDbcaFmJC5aEshU+flnHjNgcIlMZZklEm6pgPZAp9hOKg5CqY?=
 =?us-ascii?Q?4uGOx87q2K1lfTgvl7vlA8At6zpM3zdO9ZmG6C1CB6Cq7IbhZm0MPHcqUn1G?=
 =?us-ascii?Q?LcncVFZpi9Hu17hwNDkRSg3911G6eKvoW3QE8riVGXbZmaAv72wCy6C6SreG?=
 =?us-ascii?Q?DN7s6M5e+HfegZItEb3gWGPRg21gk9UBLpKFgHAU1+2191EcC0TPJZaMy3g2?=
 =?us-ascii?Q?zbrBy1CYxuofacsR4CniXpNlCrTqBB9/KcI+iesjv6AJCPxj1Q+NDUA4XyRT?=
 =?us-ascii?Q?Mm+qIoatb4DKofXdEgUz/ERfpYGpxMKkY+o7UD28SFfFz2Vr1M5B5YOFB7jE?=
 =?us-ascii?Q?ARnMA5oiQLAWA5F8g8tWXIs6Yi6yUvHHQwVmyo7fVPY1Z0XXgypbT2cTpcHy?=
 =?us-ascii?Q?pi2fpSNUFAPgGA4LI/1PG0wkKk57Fy456Dx/xqop2xgUJ8VUOoPlux6/eaP8?=
 =?us-ascii?Q?tFRBt4TqsjWmAk2ogSEhZE7SVCURleWNngevIZh3S8d+5U8hY9UpK386X/EU?=
 =?us-ascii?Q?Kw5pHCorpTyoCItB3tp0xZTz/vPkhX/zfA6EnnzxP1uPZYVp5MzcCvoauA+4?=
 =?us-ascii?Q?PUHc5psl2n7IscGA4Awd/W8DOqFq3RCRrtRQgYyG8nIBPd7LeAV4ER3JtN1N?=
 =?us-ascii?Q?iIbEyTGQ0eaI6Vfe2bgACWy4lPeBBdz/4i4t6ygCdH8ovqQsUQU4Rix+ar5c?=
 =?us-ascii?Q?k+6KU9TCzVWp7iy6SWgYTBXi1muUyA9o+j8lp8DDz9UtkV/ZtjMTtm19tsL5?=
 =?us-ascii?Q?SmFhk6FnZOX/GLU1MWer7n4IVUpKqTeekzF0IdtOzii0buJ8qBi5M6klsnQv?=
 =?us-ascii?Q?t0nFB7t2B0EIPMJzbEYYNwANjrJYeqHJZGzERlRVjgJ3iM7lCXaeMNUC60Pg?=
 =?us-ascii?Q?8FDVmiYg1ml4vBn6RYTlkvpGaaWpnMmsp+eodYNZyU0CkQT6iJIqL4jwL2QZ?=
 =?us-ascii?Q?LR1hvnugS17LcUSDjZd/o2kS7hlZfIN8D5FBYCuCFqcyp2KJDRPQGjkOtriJ?=
 =?us-ascii?Q?39d8nifFRTmTA1G3DyqeMyDQwVCGFWtzYFGe3jA6KDdtnu5wBixURWs7kxNT?=
 =?us-ascii?Q?rUL+bDKdyBg3Rjonm9yFUMU573KBXABXmXVz0Q3NEnaQ92bUA9Jpq7beWWYh?=
 =?us-ascii?Q?eVd4sa+nuZLUgmKX+NxpNPV2ll2eH+dGLyrlOvCtviCiWuC1wuC4trgGqgwk?=
 =?us-ascii?Q?z/A24GyWNmugrQIbbCTaAHTg/wfduRMwWTiB08i0vE87r0pRsN1oEk+HoESA?=
 =?us-ascii?Q?Exi/PgXxlBJJ3FoclzD5gtHxgJFIOZR29Pp61z/mC5YuwEu4ljVHBdeDlT2l?=
 =?us-ascii?Q?P+GKvUTcJYilNJui/pn0uTWB?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?VvZTebiFLsczoa10Zkv+PTJnQtZpU3mJWrSRBz1dfIP8uigaTv8rVjMZSn57?=
 =?us-ascii?Q?3qwVgEBiCyelh+MPbBFbFQMsVsl2YhilYzl9TSGdlhohQ4953YX31be8RsyD?=
 =?us-ascii?Q?xFApP1VYY2IO32Aw2z1KzHQv4MEWoJHEkT/2HGjhKjmksaTZBWPSzs/LncIp?=
 =?us-ascii?Q?UVTjLo6FRgMuvLjvNAhalD+yBzfBhVDiNZBvmKaTRk0G0OZWbqUaXx7P1y5z?=
 =?us-ascii?Q?/v2q1pATT3pfH1tli5FrAgQK04XQyidaI0flWgBFbTOYfeJAx9WQ+BD0Rnz0?=
 =?us-ascii?Q?z1ZAf7UG9VmK/VRve1LgNdUhPPHfEAmWJFb9Y9eOb8CkMBKo3aZkL1gZ+aho?=
 =?us-ascii?Q?XT6Wh7ZxoBc2IvEKEnrwuFlywn34xe42lmNRwQNiZyCMz5rC7jaAGYQzGrJc?=
 =?us-ascii?Q?wFgH6LTbMGjycBhXq3GbgqA3Y4ijal007IrVaXujGo+n+VKnnjfsVS2kGKc8?=
 =?us-ascii?Q?YxBxVjqGOZnTrhv6VwZsY3YEphmzTrNLvtyRZjlHiuW71pweYfaDcFB3atR+?=
 =?us-ascii?Q?8yR6YrP8bOeQfOyiHaAdbIvOnE4RraT5dkzCV/YSoMVsQHJIbJ5gh9RdUukZ?=
 =?us-ascii?Q?apR2LEgM7T9sZZt1ODcz5/GlxYIQYHwvvLyj3hFR1WtHkItDB0SphvZtgiQo?=
 =?us-ascii?Q?4XV2D1oef06t3vthfYrWzRLe1WlNkGVc2o1a0xSXIoR+lVUbox2WWLFgS5GN?=
 =?us-ascii?Q?M8PwKV6wxiTYQ4BsIBclyCgFZvEl91YYV7q+gLtJVS335bLn18Imbna5UwJs?=
 =?us-ascii?Q?ivlD5sHu2xtTmh+2M1OH+f8mXOQlg6Haf+gsXDn12eWPmtS8b3B5kAoJRFWt?=
 =?us-ascii?Q?5x4hfCBzB69r1PEHcgBYRbmcPP1Gjjxb0mEO32o41gNjCTB0EcS0YJmO87Bj?=
 =?us-ascii?Q?5pkymPMmamZqo/W+a9WJARqKzupkPOWmIWL3cmW2nEZgVe76P32eb8utSgC0?=
 =?us-ascii?Q?qjf2wmGuN6nXFx7LoCYIR+0lgBlbl7sD1odSPZknKWxND7WAstPgvKPFBl4Y?=
 =?us-ascii?Q?v12Q7EzNAk7jB0C8dlP34iVbXjvtQmqUzrAnJ+XIXXg4wUhAz6kS/4s0r9dY?=
 =?us-ascii?Q?taCtTBkgBxG0GdT69faz7NeUIXu/tqzzVd/nbSrQ/6kGHKMCAz++4ONXwpjx?=
 =?us-ascii?Q?Xe6hy8rkTkkFzA6OjvSX5z42YdlVkapILGfEI1ikg3APpY0a2Hs4ciKZCEtV?=
 =?us-ascii?Q?PA3LofZMd1rdnvtqaEsDzJB/Yj4yYEhr9+qgASKTJOiH/c9vP9Ae5gxiZOQC?=
 =?us-ascii?Q?iQJRj3aUWqwIaD1F63m7VYLayA6xqBl+0/hL7CxvNxaAM/75VeHgz4U+SGc2?=
 =?us-ascii?Q?YDxUqZ3l5B7gue0dhlhj6RWVQljDhctwooGgkuMRwNk19W6yR+ZC5Fu4l+Fl?=
 =?us-ascii?Q?guWsUluyzCnqcLdjFh5KlNXmveKiNvzujC2NGAZ0G3dZus1JqNqSnv5gOtH4?=
 =?us-ascii?Q?MFSFGX9h+oTqPpIL7d56gKvsI3NUbszHCEHVJsriVfZBSMq5Ms93moDrd3hu?=
 =?us-ascii?Q?zgBdKLcNqqoQv7O6N1yIkAIAnn7218pzvP8GUNDUGI3Ui47TYrbOQF9FVLta?=
 =?us-ascii?Q?IHgRbFKRY5N2dhZ/NfoAT0u6WLUhM+TvSruKyJu9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878b04ea-1dc8-4110-6d0f-08dc945c89c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:47:15.3208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsMsnoM54dksKoBrRMMj/W991PDNhM2Z8UjsDK095KPeOykyyQx1Qk7A8arwY5NfL5QIJyg23bTcOCDM1TeZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10253

fsl-fman.yaml is typo. "-" should be ",". Fix below warning.

Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/fsl-fman.yaml

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406211320.diuZ3XYk-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 807feae089c4d..7da4c469c14d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8874,7 +8874,7 @@ M:	Madalin Bucur <madalin.bucur@nxp.com>
 R:	Sean Anderson <sean.anderson@seco.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/fsl-fman.yaml
+F:	Documentation/devicetree/bindings/net/fsl,fman.yaml
 F:	drivers/net/ethernet/freescale/fman
 
 FREESCALE QORIQ PTP CLOCK DRIVER
-- 
2.34.1


