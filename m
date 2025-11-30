Return-Path: <netdev+bounces-242800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F6C94FF3
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F10D64E15F0
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0903027FB03;
	Sun, 30 Nov 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RbVxH++B"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63227A10F
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508664; cv=fail; b=pvZYxoU+nYNpYKCnhRZhNtFWeNpK14k8dv6L/QOtc9db44pILRFr/+ddYqn+cVSztiFVG2wWsb+yLjO+7p7qbB9gjKeCtLqbd+BJZX8Gplc+hPJjK5q+J7XGV7H/Yn3u5GAexpwkUDG62YWaPyMtQbdK6H7s/TMjKLC93/0ujBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508664; c=relaxed/simple;
	bh=5XdLp97DPYCxrLZ2SQlxQDHJn5gRtR5a862e5tSnRQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6xWcJm/NFb3V4YF2ueruEdUXrcTdnyClMzLpiqzHulK/RoBwhnuUpPxOLq1Eha3ShcmbQlZNqO494DGLhKTcoWjvQzi2RUJSfvRzfM8MyIpYDy+MEfMVYvU6lgZ/1vSyiPIQPCmV580JFu7fx2BhYZM4FBVbpqke3Yqq8MSkhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RbVxH++B; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/ZYnQDezmPJlstL7aBBOA2wFKvSonG3UM0MQbaioQ/8nXUYvFPKKUKJjbI0/Mm+FC57mgze2PSirOG9aIr4EUHAsrQc6Rqu0RXJBvQOoYgRJej94YlvKL7eRL/36wQEriRVi3GmrDdBruyRpQibX43CBYBEL7zmRZeTbO5TAB+4dkZMNpBSlxt5Wm64+XadA5IQadu0XaVOSpLwGO6yOEmKaYCpwJZTyUIQ2cUxdmd465kZqYttpqwEcL7mkBlhM6F3mNGVcecuqauAvz142HW+dKMpi/lCkIkaJHYDSKqN83XPyzsVCJfR9Cn9Kek7qQ+23ozdX7kkSg1o7rPDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FieO+r5Q88YtvuV0TxECGo5xi0q9FTIqw4OpCf6oGSs=;
 b=jrJXVd69Veah6zdvkGvJxBSm8vMKNrrvBfsf/x3uQvXqpFi75rZOS2nyPGdsion8odGqoZYDLgQz0EdESBS/wgqFu5oZc33RJTqhrM2VALBSOXAv/KF7oJOxxeC+i01SoGSttptw6hJ4q4ksPOwWg5l2mMdmRQrew0YyGS352/9+lE5jiQ+at0MiVYI19zq+FIPQcJAjsIupNt23QDA+ucRLcamtD5ettas2os+mf0GOJm6g76Ov/+giMqtkMrkKeG5u6PySGr3Vv/CL5KWyGmgSNHKIW59Gj/L3NTKA3lxJLQUDRs49hiObe5W/ZZN6E/4eHQMhkLRBqwld3FBUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FieO+r5Q88YtvuV0TxECGo5xi0q9FTIqw4OpCf6oGSs=;
 b=RbVxH++Bzn/l/IfynTMja1e7NJEmiv0i2nqp41UAjUegzLWi15Scrc5Xb8VmZrMIoaL7iQQUMOlTePJZWdomP0kUMS61bCBCQLh8d5Wl/jcm6NqUmzcj+qDlFuxZ2kvlKDlcgmpc7hC3VezV+Uk2wNawQwrigRwom7/FCOqggW5wvfsOoEOOHQLt6JjJbw5kalxVHQY9XUiRtwDiSBe/7CTHZ7FFi3KwvkWCnLidOBc8wlW0i9QwdGZkOXBGwvs/G9tfTTlAsvxLojtDmrNgIHtoMD/xcwxu2fAfXPbXag0o0D+5wtO4alY4ydepG5/FOLbQpJ3CYfJmCCaKnMkOcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:35 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH net-next 06/15] net: dsa: yt921x: use simple HSR offloading helpers
Date: Sun, 30 Nov 2025 15:16:48 +0200
Message-Id: <20251130131657.65080-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: af9d538e-30ff-4f07-2715-08de3012d36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2lS4+yrLdRgXzezZ5uqf2pW89p7Wa0/qmbLBqk6bJhJ05hXXRSbTDi7uEv+q?=
 =?us-ascii?Q?UlYrHg1fGywcmXDfs8cBzNvuOnPfFrLsNRpyac5/TuanGX5tYxsR3KHwGmwq?=
 =?us-ascii?Q?ZiSYccpyAcHiqqTytYVrio9B6kkftnsFxOtyICCm+bOYm4e1IUZlUP2MGKwJ?=
 =?us-ascii?Q?nE7J4jPRQyCmR/pxnwDztE1eSOEFnthR+WST9HmRTMWH3/tcEsWceY7V3OKd?=
 =?us-ascii?Q?BA2KpkeoXdSCRpkpDW5GueBcp6UnbhtNboIh2vDee35CBxS9qJETMq5Oe1s9?=
 =?us-ascii?Q?v5segt5Txgi58Wpl/fdA2APlFCN1LSSIyAmrKrrT627Z7koJ+d5XbXH4I12+?=
 =?us-ascii?Q?XIocqvvooLTElJ4Oyko8Ul9sSsXKxp5wdLE59EQQ8tbgJB5cAGHbixH3Lk8l?=
 =?us-ascii?Q?2oxUufGr7u+O2vNjvrSzW0d6mVKvKVlhrETY9kyV0puDPkLCtdDz1Zhn867B?=
 =?us-ascii?Q?VsWtI0Ttlo6DqTk081h1iZHopgoJLgYsAbWPQIOnzryyxtI4Zp0d66yhSLR3?=
 =?us-ascii?Q?k7VgB2XXBL5TTmbUwR25vuWaPw+XF5as5XJBAZWjAg3IkXr90J7vf+mB3BiA?=
 =?us-ascii?Q?Y1D7fH7fjgp0NDrVjvlUoJeTaXToDH+Fr2n450qlhfmiR91bYDrm5GIy8ilk?=
 =?us-ascii?Q?fDHRgCy9xnCMQUCmZ3m3+WM1ks0JgeKr/IPkDmsuAOsQoBv6ymGsaM2BnHwc?=
 =?us-ascii?Q?ckV1LmvaBoWbN2J/CceD/DIRZ0tQTQwPd64X/a799r+Kn9E7hiGflm/kvhZD?=
 =?us-ascii?Q?Vc/BQrG0ZrKog5BzZybja8+wHdqRxLjGVxuRigJVDFQ9lVJWF508NB/eWTnF?=
 =?us-ascii?Q?Tp5hKYwoLd7c2Pkkec6xBTV1RAdBWUGplO07qvr13M8pFRCN8WijiDqQxRpX?=
 =?us-ascii?Q?TS9Q0VKMpeVRRgAH6QXxHGuDCnChd9Lh1hoBV1wIC8B7PvjmcImk4EOeRu3k?=
 =?us-ascii?Q?rFYH2+nA+X5ccdElAkF98neXgddO0yPsvtgVdQPhbCBEl740SNw6kL6gAdqQ?=
 =?us-ascii?Q?9VxKhqCi+r7iPok8qKZp3kSm3EXSX+0So/95iFrilL3jcnE9glH2bJRzQMZy?=
 =?us-ascii?Q?tNwHB+Hf6FROdeVQ2HeALrzWgG0VbKSvS6I+CYgRargz7jKr1CZUD+zHo0bd?=
 =?us-ascii?Q?5wW9etB+T6vuSWFyNGzVOIxvYQo7VNikdiEBmuWIX6MYcM3gGdSmaAVE8BjV?=
 =?us-ascii?Q?8Px9eJMyKEnhSwuyQc82H7stT7psn4KHrqVPDas9IJoOroMwtusZqGNUGQEB?=
 =?us-ascii?Q?3ykvjYRhxjx+QLT/JqXKJMRXVO+e3dpznXr2KxguwuWF70jwfPWJgmdFTmUt?=
 =?us-ascii?Q?Hta1U9T5gLwDI0BGDFFCAxD8V0YuR9gS8d51nof33bdQzb5K3CJsiB26epO+?=
 =?us-ascii?Q?qj84TjJTrUH2+xHX2o9gI9cYoMEW+dN2o+Jdhp3ZYDNeOA32l5Ns4/TplrfU?=
 =?us-ascii?Q?4c0KsMu/W1R1NQuyQQHtMYItjJb1Qytg1zkGRrdtc428shNJFKxCjJ4wtcAG?=
 =?us-ascii?Q?fR15jltUWtFEg/Fp5fTb0BOWOwcUtuGy9kEE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DumO43eVOmGQ8qDtQs6Vh5MLRsa9MBL8RcwBmT5mVG6bjAS1USpkug8d13/+?=
 =?us-ascii?Q?GAY7oF87kbcNkTDVkjfhi2UwQQA9Bb+YVo19Lc2h6K+DH/J62qTW55bPQfZo?=
 =?us-ascii?Q?I261uq8MSRcY//+sk0ThqeSBptHaHKXe5tUmkNvavnerYUto+r73ycZBcLkJ?=
 =?us-ascii?Q?6/UCB1eLTRbJqzr4MyQIHDeAZsLX78VXBcl1UhrHP4MrcU1pKU3kXE94th7H?=
 =?us-ascii?Q?gZzNalgVGnXU3IA9QDuSb31A/Qb4c/CMTFoGCjVzfZzrreBXAu6DJtzP9Fe0?=
 =?us-ascii?Q?ATV7FaFKdCaq5x6BGIOKBhWBEFdf8YCyc4GX00QpdfYNGh+ex66gay75SM1q?=
 =?us-ascii?Q?wYNpStOdleT2mNCp3LZ2RUnV03Ud49gahQW0svz1KwpqgW8rez75AOvUAkGY?=
 =?us-ascii?Q?m1g8BnN9RLsRi7EDOAqbpPgI5Z8EHrXLhUEwrpGVKLwUXylpBuI/0O2uGJWg?=
 =?us-ascii?Q?D80PWkeZ4y/EKOadQCyaFuSvZ73yftLq+hjCKhDfKbmhE2wlW7iHexke1EBt?=
 =?us-ascii?Q?F1MgXoilaNY2Kw4Qsub3PJmHlGeU641HQzEzA1GHApLKWMPTOawCe14PNOd7?=
 =?us-ascii?Q?yD1U79yWPLPJBcNRHATZVSpjspmiqbVtHHDfnfkUoEl3NhS0Eky9q7FC6NLs?=
 =?us-ascii?Q?Qndt6IKbeDZVYYBY1Ja5P/ryK/uSmbrWFRjL5TggEOotQ7QdXVIS6M869WpM?=
 =?us-ascii?Q?HVn8/Bc9doQkoN+SwNvb67T4BL/368C50Rxy0+r0AimXqi/f3qvQ9LgxHVC8?=
 =?us-ascii?Q?OpaIalFNlSSGZnqPhqspQv7USdbUKzJLU8LYZt+CR7dMLjvcNpVtphtqGWq3?=
 =?us-ascii?Q?ke3MkT/eDbPyrS+V9ixCyMFipT1BfLJy1JyS7E5GY8dwqUnIfZlnRMPJQWHe?=
 =?us-ascii?Q?MfTu7q5+lgAeCwxXQmfFr5rgKC2Tt90YjbL5f9MN6IrMKsPi8BokGd83vSYM?=
 =?us-ascii?Q?384EcUydwfAiNOt4JWBQt4ErxtqC2xrPmNboaEEf8xt4FQNV2S9zr5ajTE9j?=
 =?us-ascii?Q?9CV1DrkuMrvjrA1UaLMhppzQks5sTErDWFjPfDHGxlo9bFkCbuJhQLE1hLu1?=
 =?us-ascii?Q?as/6arZ7S1V9+9M9WO3WWI3GaKX+jMvkMSdsUqtoOhsPB4+6Mp9Xi6xukU4f?=
 =?us-ascii?Q?B+gFBp77wco6IA6L1/wT7F2yqvPSP1R1VH130HlkRxyrbRX3Y++YpI5gJZkX?=
 =?us-ascii?Q?eYdKPcm0tG8rZX99/rcRVTeC/GT0NZ7LXB+6lNT+YrRM3a5TDcsJSePm5JIW?=
 =?us-ascii?Q?gps1htSTk17gGirGOAOd11cEKBDnEjSIHYyEhb/8Z4ztOASfJ3cTauB95CJl?=
 =?us-ascii?Q?KnYfx6FELZJX+QLlNPwYjNor8WE8+5zmrRNeR8QZew/3YN2fQIeKwB5P8euF?=
 =?us-ascii?Q?eqQXuszg72ssBApc22TcZwct3eGoW6HrbcnRtZRRAeeGqdk80hkXA0i5RRtR?=
 =?us-ascii?Q?eDGt1ebgAp01NwneQVqcUJ7psw2lIPkWiWtTKp3A8Fdi+hV1tB8VMfm37v/w?=
 =?us-ascii?Q?Wox41C/BSq9MU4OHWrqWovPbFLU57gaunPTbG9U1k05yM86B9EGeSI2a2272?=
 =?us-ascii?Q?n951KngXJoSPp/nfkAl4V54bk1Qjkop6gJghjjWWXdV7Xij1rxJWr+PY8SrE?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9d538e-30ff-4f07-2715-08de3012d36c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:34.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dk5EuLeB6REnXR5sivUN+wlx9h/R7HHY0PXbTFT+KYRQTzThSZHfcubliU/CX7asXMegA/QE4MJq+G3JBY/QRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

Accelerate TX packet duplication with HSR rings.

Cc: David Yang <mmyangfl@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/yt921x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ebfd34f72314..51089615244d 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -2763,6 +2763,9 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* mtu */
 	.port_change_mtu	= yt921x_dsa_port_change_mtu,
 	.port_max_mtu		= yt921x_dsa_port_max_mtu,
+	/* hsr */
+	.port_hsr_leave		= dsa_port_simple_hsr_leave,
+	.port_hsr_join		= dsa_port_simple_hsr_join,
 	/* mirror */
 	.port_mirror_del	= yt921x_dsa_port_mirror_del,
 	.port_mirror_add	= yt921x_dsa_port_mirror_add,
-- 
2.34.1


