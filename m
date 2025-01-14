Return-Path: <netdev+bounces-158175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE71AA10CA8
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978B73A1151
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D87189F3B;
	Tue, 14 Jan 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O4yKsZo3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66C23245F;
	Tue, 14 Jan 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873268; cv=fail; b=N88HTPPu1SV4bMRPsnnhAeOhSHkKXbVUZfJ+hRvkj6/Br6GRn9WOMpsdFTaPIeRfGVOcidyG0seXtztRxHVzLFFu+BXgBQK6P3+VqIfrUoRi98y34NhztdsUdb7B76aRrqa+GlnHKIuBkBv3n1BF6mXSOLpyWk2ol342GfssKAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873268; c=relaxed/simple;
	bh=Ideg3GKQTxywHaEATnmJXotK3Xmb1PJ/b3FEHkW56w8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hAO9hv+q0vmeELpyWn+YL9yvKY9JYcFX4Iz9mf9LYkwEaXK/xX2zRCjvijPMhbf8Jf97ZnDJMWQGl5kFkz6VP4myr4HlzQ6gfpv3plpOmHJfdUQSj8/OrROVRzCWBrOZtpbcQRN57vMNqckk1uJV30kZJhxAqXxSctuIKjvBLYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O4yKsZo3; arc=fail smtp.client-ip=40.107.247.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhoMz42c33++G6nnqsGIopuwgFF4nWVyHJGQym+omCyYOKWbHFvIEUn0WDkm48cg5DDl3epZ5+4/DdL6jGtfGcbRc7qzMYA6Vl0UPuwoxx3xnc7UvZfSFvjfto7Q9PGe9i241uwHZgBoK3JKAy7e+GEBTGvhlPh+MylCNfdT9Q5jqSFiaZV3cvU31uqscdBcuZ4YMrz+JeF97AxpaR5kS96s/Ocuzb2um6ksYwk1U4qY86Qj8n2sckQesGoGTlAO9h8CxIxhAyACTYEk2/KWlGi6YKrE56ORWiUPsgbcuIXOmugGvGnrOMKYvRZmQgAdpeztELQK5Kze6tnLjOjuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcETxrsdQZdZmRlN8+aEk5wgm4Y7acius+plmrO5lQw=;
 b=LVKR9MDZWJ+K/ZvUZghsYIPoey8dtuzHOAGo6/66PfS6T7oDNpG4UEPAUaIK+Kh4f8JpRT6B0rc/wwmIlA7+iJTpIZtpr9lWLddyjQIWbPFKi4jas9kDlQpRgzQ5Knr6zeizF2fVms/4fVcPODYnL7ks3zFTMk3JgjObaUF456xX20n7zepdv2G3k44kNiMZGhFtwaNf5HMnccb++4AlIwDIdYSsM6diMVtK6dakZe/+yNwWRyFVoKqXl75hZkJvqO2t046R9ac/zZrtIryBoJjb6Mc2JGX5vrNMOXiU1cLIkKDvxUKt3JIbbpQDLBTJ1b2qQbE8kVfjqSxajBJT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcETxrsdQZdZmRlN8+aEk5wgm4Y7acius+plmrO5lQw=;
 b=O4yKsZo3f1r9aWbHngosrl/mFy3MNlqvYlXGgYs+n3M71uE67k3/4zjGqDr6rI80pQw8O5QsYdIEx5sOxYZtiJlGXslnZBH/BIpmBFJo2te5k4TVcDbvEYJO2O9xEHySiLhn1VZ+ui3h1jDRtGPIHxmGcqlnQvb+Tc4CSRnUWnsXOUf6UX/w5kBCtQqIX9U4cjGWVEmnxMwkmQX08ofWmtN1uOpVFNduwp+AEpLtM3B0itrbUC4RDBctMbscbiQ3BGqhhc1NILfi65Ju8fND+nV6q4e6R/XqwzJrpx6/CxYTeKyyp1Yc7pSkRSlK4m3h/IWqfgjS7e2Kff2EXkHmFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:47:44 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 16:47:43 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: pcs: xpcs: fix DW_VR_MII_DIG_CTRL1_2G5_EN bit being set for 1G SGMII w/o inband
Date: Tue, 14 Jan 2025 18:47:20 +0200
Message-Id: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:205:1::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: edbb0d00-6899-4472-d69e-08dd34bb2ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u5HCRXBWAJUWularQt1QwXHSt0hQX7uQZVzQhC2BUblOwvH0qZ4u7qfAwHNu?=
 =?us-ascii?Q?k7aYYUFzvadSGAbEGg2K/RQkoegQ63yuphYQEifuQz2P37AkyGxhRwjV79u9?=
 =?us-ascii?Q?JAUfE0dkzR+jY3tZJJjSiaqYRjaXpfTfVdEuW50Tqd5nb8w7iyeCI4Y+zKKb?=
 =?us-ascii?Q?jLOwUJN+rDUl6EWC8cUsxQ0dcqJk0KTNtK7VsLdNJu8N55X6PFYmMRrTbdBk?=
 =?us-ascii?Q?mBG0gOFb96MspGQqgfm79T84keXxyp6uKpVRSH5g9NPcPT6WuSwu7KgCAJc8?=
 =?us-ascii?Q?O69c6fEi6psKT6vmqXuplanX52Tk0Zei1PsJkl2VxxDbvJJjsl+huQz5E3G3?=
 =?us-ascii?Q?t0dktXR7CWRXa/R2837ENMDC9J5o4cJ2kUk4H0v6dOnugdw1aY0u50j+3hsE?=
 =?us-ascii?Q?qtAqoSQ/hwrGBuUDekzAoGzB3n2LNnJ4NXk+izcVciWYUddol5JYNepDQucb?=
 =?us-ascii?Q?1MrRxC5wuR4WVDt5yoc+HBKtCUtEVhPVlL+jeIvVCE2Ln0MsnvWqDqinBt1y?=
 =?us-ascii?Q?kYZ63KZtcOCBqDuoQYAL/XfISh4wkEGtZl/PqLjoMLcjG0y8DDPOJsbtrFeo?=
 =?us-ascii?Q?xgvf/FcNTOW+LEvWEWqn8LODLyQv4OjiaVM4Me/BHYabd6NI3y0tBxKUqANz?=
 =?us-ascii?Q?v38n4aI643cnZfaHWY54g2tIzqNbQyqDNlAstVe5Vbok5j5lbof4z0EmC/Ax?=
 =?us-ascii?Q?wa/sRK5nP6YCoxmlpDboLQ2p3NZUknQ8OkI3AcKa19YExsgYIV+vPCuJhfHE?=
 =?us-ascii?Q?Lz+AyCCuqKJviAc+17gf5g8U2bvXOuc/HpVB7ls/64RNhC6bmtBI2FBQ3T3V?=
 =?us-ascii?Q?/QAFEaqP31Yav88b4AsGxymlAxV+n+ZYzeGvhAEzpQxehGJYqgjSu0F8Q82L?=
 =?us-ascii?Q?XxEPyk/vCrP7MnruMQrV50uPCvF2oakHvcOAWUopMHp+jssFLDfqO9ZwA5cV?=
 =?us-ascii?Q?UFBjy+bc9q5uwU/5trVSDn83o+AVGHV+/kQd/FEIQGbaE7nA8bEYu7XnLlst?=
 =?us-ascii?Q?ALgSrnEO4tyUe852rPy5a49ftEV+oaNOXfLyF98o+pOrIMnEI7eB49E9TQTZ?=
 =?us-ascii?Q?YXqJ4+rPpS4P2Auy1UPm9h2zonhwYCziQnUUAglIAmTM0cLc8JM9osfHD9X/?=
 =?us-ascii?Q?2cIz3dUBR6J0jhu/J3iYtvUSHA4uKmQoffbYK7908qbVfPSRzYzbmbGW/UUQ?=
 =?us-ascii?Q?YWU4v6BatfEO/cJxLvDZp2ZYHc9j20j9tjBnhopW850XmmzBcHrl4EZg9dCc?=
 =?us-ascii?Q?3f80YxQjjD1JdjLrLrA442OU4qB9EYBkHDnOwb2iim5FSm92Cy9lJZ/OTZ31?=
 =?us-ascii?Q?PE6zcOJU+jV7W2y0FDNPuRPxv8sVjBwRBkN6fbyJBHSOFfsD+83qijBXy69k?=
 =?us-ascii?Q?dYqrBycbv63KpZWVw8A8i3NEZqZqrH9FidlY0xtMIrFHfUhx7oeMnrSWjhzr?=
 =?us-ascii?Q?kpzBiDHjgjnpk2kG1IjPr4XOVV2gH3jl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W1uqR3GJDP8Or0wT7EfY8XlCBHIKY3vMDQOHEFMkf6rY52BspsM/9i3zSL62?=
 =?us-ascii?Q?kIDBmnDh8xHNiLqzgzmmxUV4PV1QKVFaBjHRshBidoxr0gFB8lidRoSHaFXA?=
 =?us-ascii?Q?sBhnWBgue+k0patFLK79HdJQrpzHwbaW0ktrexBEoUS+sLY/Qa+ZZV5U45ID?=
 =?us-ascii?Q?BLd2CJbckDQnKtRl0/UfTIm54UaHEnCm0u6InbKXTNPLshwy0rrGRp0JRBJy?=
 =?us-ascii?Q?x5N1d778LmMA1hQNYRQyaekoy/EYawJyVMN8l83qrzATVLTtAOKUcWiQoq93?=
 =?us-ascii?Q?PpCj5+riLC/2J1CeLDS+MemmLuDaUW6zwke4vSpCtAK8SUBs7KA+O/Lclb9g?=
 =?us-ascii?Q?CKFpL4gtNf3oohZZFifwIb8OfeDMzwakCQpKBoxW1mDb4K9/vqoessnHM++R?=
 =?us-ascii?Q?Kr2NWP2bDI4vz2STxcI6L2sFryoUbAmnTKRn09ylwoa+rcLh6aNoAttoT/d0?=
 =?us-ascii?Q?M7rMwxx17yDDXHa0rMePwXQ+cdth2moAL2Qtab+wEtz3+39KHyRzWQMa78nT?=
 =?us-ascii?Q?3SOsieXucNZMHcYkONbO5V67kKWGGsw7TvF2QIp7xtDjiPbBOrQnPcY4LbGO?=
 =?us-ascii?Q?cXs4Io/wBeeOgEdUT/XUFD+rtC2ozJATHtqfL/I8wUCcsjYvWJAA7ug3V2fl?=
 =?us-ascii?Q?SYpM/f92bSDg4L8f2EGRnsL9P6L1l0Jv73oIcpoQbLg0UqzoePgEg9Dmp3CS?=
 =?us-ascii?Q?hw8IDtzxdw1zEy1neC8Vg+PmqG8ld5fpxqqgUmgEQkZCE7azWPdi0yA/IPFK?=
 =?us-ascii?Q?9Rm9dHZcF3snhWIzR0XIFaaXovLGohXYWjjBbBzBFjKFB/52S7ezUpfThN/X?=
 =?us-ascii?Q?By0bg0yUgAxv7XdeSW5MFZKKb38nHr3eqaactywYc8s2XSvrB3IhYXE2qzAL?=
 =?us-ascii?Q?3j4fLY6W9Qc827AlB7HnhtM2Ird/XHij8vBkmG7mSDYHWvHhRizKlYBX6q6H?=
 =?us-ascii?Q?5jINWZ59Ss5g4Mg81/kcSGFDaY316svFWusewtSXavn3SgWH4wdRkbMGBUEW?=
 =?us-ascii?Q?EwTIezOdR4i3I8t6WAqouC3UWnIgx/ZVslSM6GfU5mWJ2bx/OKONKNGVzisQ?=
 =?us-ascii?Q?EJQh0s3f8CAFoOg4X7iuzp0xFdaFpkjkGDN/WcoAfE5iUMCnU+EZyANmEU+C?=
 =?us-ascii?Q?7hSfTfJbtFGvuZr15+9NkHyNASk1N55IxzWN6fwYrg+nmam+toZOUnRDYSDx?=
 =?us-ascii?Q?2hs/eA+8B7bQM+gZVtOW10JC1zNhtFFhyGLKNnMvZxpwSqJ8T3XtcZ+iBGFr?=
 =?us-ascii?Q?rzADlP6ZQw+Blkm+COuYZ7sDN3yKts6gxbZrnXPocLEuJuSUFiZ+Uhw+yuTT?=
 =?us-ascii?Q?Em50MyEzUYLyiMbbM81JkguhZvAvEb66v4shBhKlcE95yGOosoeTDOb9LVvn?=
 =?us-ascii?Q?ONtYwMgzvlhRi9lr3WQGhtevLsF2SeWZGiLax7Z1BsRm7Xnp5eKrblY0Tjpc?=
 =?us-ascii?Q?sve9BFn8qN2po0g4Sfv7MCTVnlJatqZG896aOO21yIs3OJhj9BA6PDDES67K?=
 =?us-ascii?Q?JP0l3+nyD8Aarz3BSihELDDYhnPYw6wzJu2LqucfQX7UcNCE9d+BqxpdbDLb?=
 =?us-ascii?Q?BJO3lDPqFM4It/Z5VgfkdOJSZLhyWG8vVhsld5cnd+3s+VWsdxuO8uFB/28o?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbb0d00-6899-4472-d69e-08dd34bb2ab0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:47:43.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5GA3wnKgf3zf1acsM/D6tDl1mjzF2YhuQzyaaq0X2NUojpIUBuLD2RnH0SAZjevUc2Qz4s/WfRPDGQx3wWBpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205

On a port with SGMII fixed-link at SPEED_1000, DW_VR_MII_DIG_CTRL1 gets
set to 0x2404. This is incorrect, because bit 2 (DW_VR_MII_DIG_CTRL1_2G5_EN)
is set.

It comes from the previous write to DW_VR_MII_AN_CTRL, because the "val"
variable is reused and is dirty. Actually, its value is 0x4, aka
FIELD_PREP(DW_VR_MII_PCS_MODE_MASK, DW_VR_MII_PCS_MODE_C37_SGMII).

Resolve the issue by clearing "val" to 0 when writing to a new register.
After the fix, the register value is 0x2400.

Prior to the blamed commit, when the read-modify-write was open-coded,
the code saved the content of the DW_VR_MII_DIG_CTRL1 register in the
"ret" variable.

Fixes: ce8d6081fcf4 ("net: pcs: xpcs: add _modify() accessors")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-xpcs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e270a75a988c..3de0a25a1eca 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -728,6 +728,7 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	val = 0;
 	mask = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
-- 
2.34.1


