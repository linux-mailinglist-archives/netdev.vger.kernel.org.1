Return-Path: <netdev+bounces-218114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D30B3B27A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC94983E5F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7123AB8A;
	Fri, 29 Aug 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ln7Aqg8i"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B723AB90;
	Fri, 29 Aug 2025 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445276; cv=fail; b=XAcHDUkNvQXWDPcFxHtu1iSAIeWDhYwu+C2LOTRuwm/Rt49bR0C/4KyyQrJ6qNm5sM7GN1gOlizNMFwbdkwDT0VoAFtm5EbeWGZXMjV8QSo0XhbRS62JgLJbO6V1vvYMoNEuFnbEx9/IaSezrlYw9YCUTusHF84c5ktESZM5xRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445276; c=relaxed/simple;
	bh=OKS34/AzF/Vk/y3cGHYtqlV52SwpPFWsKwX/zAMT67s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uer4PbpM/9VbtLqzVkZDbgZGELXBImhDINlNSC080A1qgJMk5VQ2NXKgbdG1MMs1q6FDi3YupencRGJtZOf4NWT+i/aE23Bx6HoAMNUSQB27izJuygIfWHCGJ8GUpCMRLh7J7J/YbMvmhR29i805pL/uMDv4TMTKpgje4t/rCgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ln7Aqg8i; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iy+3XsyDLv8anN0cBJVKKfBOlnFmW6xeQ8QCZZEgp96BdsmGqLvyAEjTresPavwPflqDeGPcG4ERpJpc6Tqkfrwi1c8BEbXQzSnAOFxoruo9BNwvP8XaRkoxsr9V1OidELS8pI1BIe71aUoDVxpXaFy9lSO2gw0Kyaq4wfBBPIL0g7to6rbUR8YDZDGrQGhWtj/p2NWEXCsX9XyGtcWKL1Tb9Q4E6A9JFyKuBTsUqrvN1IKfZVEttohbJuf7GtICGgPCdTt0i+FyJjFhbJuRkTW0qBm2Y4nX2tTmcQSAdsQNyTZPMWOw6KbC7d3mEIdDchZBwKVj8ZSqK7LTDvRpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiKNmxLheWSPm72dXpg013ONDtNsVvDF5E7BH7O+cUI=;
 b=tIbjIuG+dilsor31RWqxDU7IxE1lfuqZrN8PN0BsO3ihIavGdiT0Djkwt1jetFfmrcn9pV8BT24yjZ+ADHh1e/8DbMEeBh8uys8010ulX3iktr1sDXA/FqyriJnPSWclDDyOlqxP+aOYTmSpqe/C0F33U6qK5S00xIhYfa4Fwvgv4cnuqR790og5mqfRcrBSGBlAMK+XiI4doNw/mpFQJCBDJhFs5Fe6SCUtplIavcWEhDaXw5LYLbBVTne7kkZ4BrP77Te67a5apINq1oiQYeYQGqjClMqhC4NhqVEraIBRbq+7QjP1yqNNvj8Du5NNAhjrNSXdl9iiMRWb3ug+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiKNmxLheWSPm72dXpg013ONDtNsVvDF5E7BH7O+cUI=;
 b=ln7Aqg8ip/kvmBCflJVw7siX5zXuFI9cKZFRQvW7m21xZtomSQuzCTKjveecJ59BOAPW9MQK5o/USuOZSGhjUQ55TS/Z4fGKjnsZoRwPY0b5dgtnpDCwIzJ3whUEqCKzeYTy9Sg7QTkXpU/F72JnFlVAC+2NnU3MKtnDbdoDlvw62klo3dQyOw9OxVuxSSGJZ+4rZnO8YATadtBVicjcv4AqCd+ZopmSGJkP/gVdxr2NoVIyQOC9AcDPM0s13PbfPhrTCw6DxQnmP1nI4LG9cTK+PpKDQtbbRU+vdKcoNbu1on7kyjMUzvQDNX3izyl3uapurObJzbYoUfX2u9JCcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:27:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:27:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 07/14] ptp: netc: add external trigger stamp support
Date: Fri, 29 Aug 2025 13:06:08 +0800
Message-Id: <20250829050615.1247468-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f883ed3-de17-4aa1-8607-08dde6bccc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zu8C1apgha3sKn9jI+vL72i0QdoMBVpooFzGlmQbTsPOwlcfa7yDSEbVSr0R?=
 =?us-ascii?Q?e0PSexHbujSg16r14w46YG3Lk5sE2n8+XSQYiscLSuHRos5+8kN802++CKHy?=
 =?us-ascii?Q?2SB+EfioNgnsrKPE+JuqmI4ZqNE8pxLlXf3ELED6kWmy/ENJq6SqjAUM4bfm?=
 =?us-ascii?Q?cksFhJLxE+HhrdzMvXTSt21C9SugFTUbXAF01dVpVlgMNjO94y1+DL2ZhrpG?=
 =?us-ascii?Q?p9PvlfhrjyxS/EBV+bBJHRQzHm4lVQqhQ159smb04YkoMixAt6MFJ6v4Btc1?=
 =?us-ascii?Q?fH3Q9ApXG+gJGw2HiYPS+pLCtNIryohDSoGy1QTw77Moaq1JzFukjVSydmzO?=
 =?us-ascii?Q?iKo6p+beuxlWQBz+go5gHpqipQQ20Y8go7UjfNBASJTWBA7gcQEB60hnTeEo?=
 =?us-ascii?Q?0ekuIGBEdrwvIYa4lkE6PuZgP7BjOcbTPrmplTC01THjo56nFYAtymh45TA5?=
 =?us-ascii?Q?TQux9y8K1y3GxmR7b4yV3WP25S0gLA5E9pLUXuL0+k9ht5jJQDTsEFCVeHgN?=
 =?us-ascii?Q?VO3BWyOHIMFDP+W3KoD5kT/0Mu0bcgN4Pl+lx5QovryDhowY/3pMzheUpA0f?=
 =?us-ascii?Q?/+y8BDxq6qNAfkWTLoVFmIjgWN1sEHTZbya37VaRjZ8uNW3nnC6Xb3qtipJz?=
 =?us-ascii?Q?3CcA5/mKep2j6MoHtMDQxRFaTpiFQUyjVHO/cT8k/pLQe13VGZdwQ7r6vRV3?=
 =?us-ascii?Q?wNI1qPndKxg3lNo4MrqSY9nX0NKdoPw9BQxjPX9etIbBED1iD+I/atLSnwhC?=
 =?us-ascii?Q?3sCP3HGbiHPP5KAS8Bv0Ts53Tm/e0ny9IVFoDSqiVMZBU8q0cbDkW3CWxH6A?=
 =?us-ascii?Q?2rgZU1WwC6gS6oLFxRj9jRCuSEu3ZCVaPdxxggEBjnudvHjJT1buyE9xSzB4?=
 =?us-ascii?Q?C15QK6fBVmtK0kGdqVAQkg53xMPE4hqJusM0kREx/tc0roZmLjxOiBDosK1B?=
 =?us-ascii?Q?EH0VAyZaqsWCP5AZMsa6hLgb1ANUd1AydkxhrJ7RqFezFDhyhzJ2jyeW4qTR?=
 =?us-ascii?Q?hWYlMxme+CGmVcbFNGC+A/WLSH29wQAvvSnf7GXS6HRocADDuI4EHt5w5flS?=
 =?us-ascii?Q?gGBZZ5rlnqee8OPMuJB+v6Ypy/gA5pLtsemwV+mB661y7sNSB/qbmNzsQbbO?=
 =?us-ascii?Q?qQR+GsSLU61X11J9ooV7p84G+8PYk69bUpb63KT/IQI4IdoyEkTRee9EdiGx?=
 =?us-ascii?Q?Po7NC534viwMRiXhaw+EEGQPOFDX4Of459NKo167k9idt6A6nIdmeI8/f8Gw?=
 =?us-ascii?Q?quOCYchLoo5oqT4Uxcxh8PksL23tXVvdzHDnzZw+VaEShWUBn9CrZkv8/NfQ?=
 =?us-ascii?Q?4SevHkK0EwgaoCu6n0wMeWQSwKTu/5fCy6emMm5Gi9Lt0vQmXxCSSwt1HjL4?=
 =?us-ascii?Q?pTC7bKjm10HrNCYgxD2hOwmAuCaYWWsQnDLgujC1RYHbdlTkvpYicpHhkzpw?=
 =?us-ascii?Q?/l6dCxNsOIt+JoPDls5A4EFSShhzypmnuh8MNEkKA/Z78ZuEoF5bkVgXYGi6?=
 =?us-ascii?Q?ZFLdULUxUqS5NNk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oOYLsgPDKOkLGoTHyiES3hA7BOsYjqIj3id79km2q4s2OWPam0r0ksb1f8cU?=
 =?us-ascii?Q?At/ye3jefz0F9lod7iHiK1z0tlgkukqg+vwZ4f27G8uqodI7YHej+2a7Yx06?=
 =?us-ascii?Q?/OxZ1pSOlJP3eqDzo0cOlXmWVLqRn1d7jlhrTtr1BTmShi+WDf1rIDh1IOjk?=
 =?us-ascii?Q?dX2oSR/mLmgaAP6MdqwzhMHF+JLQwgLQtNXeysBGbaSS5G7p8ucU/Ygmbjv1?=
 =?us-ascii?Q?+a2IPzvnaaV8AN4CYEeX+R6WqF0rKIUeK/dMqNOdjzZwdckgxQ8pAketuwCp?=
 =?us-ascii?Q?TM5eQi4rMdJA+OtUIj/3tc4WkKiNxjDGkSeiOqy0BEvBDtJxT0pHHox9PDes?=
 =?us-ascii?Q?VJOr9z9VDIF+Q+xdeJAtneOEaIVaf9EjVRxF5HdtK2qPPVUy3yo4dbyU+6F8?=
 =?us-ascii?Q?U6xfajiaynhmbGswcTxbcZ0/usb6qqHIPJ9vlkVeI4NVXCpsBScKA3v9t+OO?=
 =?us-ascii?Q?vERK3ehzLybKaFPy1DHRTNLGucqh6v/zJQGyvuz13chvd1nFa/Vye+/fz/an?=
 =?us-ascii?Q?BbLEO6gAKa9hmVjv7aClYxf+U2bGlkAw2Vx5228e1iqy7RWeE7xDmDo/oPgh?=
 =?us-ascii?Q?nCsDlnd9TRYGq+YNSAziNVAwDe3PM/+8pVo1XWnc3lkKc04CMgssfl+0V3x3?=
 =?us-ascii?Q?Qr5CFyo/UJBmr0SWjzA84ZnMYnInc/Nx98mSXdqN8EtXaLBG1kE6CrLQ8HOl?=
 =?us-ascii?Q?Z7C/Yg28Cyh0BrSRqQEQc8oJAyWEBMjC89ocewxJ8onE88cHXnkipBNRGmrJ?=
 =?us-ascii?Q?Pchmr7/I9lXl78AkPSyrwIZEDj2/cjNboCwe0aeF72bWB1ZwL+6WTA6Tii3s?=
 =?us-ascii?Q?3T6iNie05jqta+oLIOI5THyDrLLYKROOiOp9f5mGmn9xGEPsx1j2sXcUyMON?=
 =?us-ascii?Q?ruibXy29LAVZ8QE2KyudW4mSYAyCLH+lidjKEnLvxda6IuT4+8/7kCvZTrCM?=
 =?us-ascii?Q?6BWJgk7UPlZKDQW67E4+IUOl05vG1fvAjZvClUP+vSgS4K60pNVu/Lv+rkog?=
 =?us-ascii?Q?ShvnNwPLQXgY7EWSbfnxCKaQcNR9yh8cQDzpJY89wuXu9sZWHtx0SjC7T7oX?=
 =?us-ascii?Q?br83ttfSJXU6+cN4j90q8FNMzwQcEGvlT1DPy9BetiA74T+d/u7pCpe4D+Sj?=
 =?us-ascii?Q?wlw/m+uzw8f/cXXwOnwtan60TT4S6aVDZCdGw6Ltp8OXBKKdOPv18Wz9xfkS?=
 =?us-ascii?Q?5istVdd4Xe3zctVy+EwAAIuNbz8uiuaCob4YS90glMRJ1irqe5XGr6dp+AIm?=
 =?us-ascii?Q?nB+QpxkE4Z+QYC4uXqQWQchJCL74n7mUbXQIiHk5on0WGEkysTkqwxZIdy1V?=
 =?us-ascii?Q?BJ8bCj1Qlx2o3wlnyVWkdLGBPxUN9J3fbRDHkZBOUj3vGFWgUa80j7HNxTlF?=
 =?us-ascii?Q?OY1SearPQaGwDeTm5cExclMVI4xYIhf+S98ypOQqN1lkpDTEkjH/GJhf26IF?=
 =?us-ascii?Q?5ckJHXYheOurfyEV/f1lvQbtoNy5/SCJuADRujnXUOTOrQLjPgnEYe0NYuyl?=
 =?us-ascii?Q?CZIXgoo++WuyYF3syprgSVoAA8CcuJGgcx7VMbsreqdbaZy0C8Ug6HJFMNsF?=
 =?us-ascii?Q?MTunUHhc/KLTP1+dagvMzqWh/mdOuIY72o5UM24E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f883ed3-de17-4aa1-8607-08dde6bccc91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:27:51.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkIbadyscF4wC2zK0d3Fr65K2YMjFfJ33jgKvlAzR0k4wmanCcxPvMxTILWRnPPoVQFyqqcaFDh8QNMJ7S7ATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

From: "F.S. Peng" <fushi.peng@nxp.com>

The NETC Timer is capable of recording the timestamp on receipt of an
external pulse on a GPIO pin. It supports two such external triggers.
The recorded value is saved in a 16 entry FIFO accessed by
TMR_ETTSa_H/L. An interrupt can be generated when the trigger occurs,
when the FIFO reaches a threshold or overflows.

Signed-off-by: F.S. Peng <fushi.peng@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v4,v5 no changes
v3 changes:
1. Rebase this patch and use priv->tmr_emask instead of reading
   TMR_EMASK register
2. Rename related macros
3. Remove the switch statement from netc_timer_enable_extts() and
   netc_timer_handle_etts_event()
---
 drivers/ptp/ptp_netc.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 8f3efdf6f2bb..8c5fea1f43fa 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -18,6 +18,7 @@
 #define NETC_TMR_CTRL			0x0080
 #define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
 #define  TMR_CTRL_TE			BIT(2)
+#define  TMR_ETEP(i)			BIT(8 + (i))
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
 #define  TMR_CTRL_FS			BIT(28)
@@ -26,12 +27,22 @@
 #define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
 #define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
 #define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
+#define  TMR_TEVENT_ETS_THREN(i)	BIT(20 + (i))
+#define  TMR_TEVENT_ETSEN(i)		BIT(24 + (i))
+#define  TMR_TEVENT_ETS_OVEN(i)		BIT(28 + (i))
+#define  TMR_TEVENT_ETS(i)		(TMR_TEVENT_ETS_THREN(i) | \
+					 TMR_TEVENT_ETSEN(i) | \
+					 TMR_TEVENT_ETS_OVEN(i))
 
 #define NETC_TMR_TEMASK			0x0088
+#define NETC_TMR_STAT			0x0094
+#define  TMR_STAT_ETS_VLD(i)		BIT(24 + (i))
+
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
 #define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_ECTRL			0x00ac
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
@@ -49,6 +60,9 @@
 #define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
 #define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
+/* i = 0, 1, i indicates the index of TMR_ETTS */
+#define NETC_TMR_ETTS_L(i)		(0x00e0 + (i) * 8)
+#define NETC_TMR_ETTS_H(i)		(0x00e4 + (i) * 8)
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
@@ -65,6 +79,7 @@
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 #define NETC_TMR_ALARM_NUM		2
+#define NETC_TMR_DEFAULT_ETTF_THR	7
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -476,6 +491,64 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 	return err;
 }
 
+static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
+					 bool update_event)
+{
+	struct ptp_clock_event event;
+	u32 etts_l = 0, etts_h = 0;
+
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
+		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
+		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
+	}
+
+	/* Invalid time stamp */
+	if (!etts_l && !etts_h)
+		return;
+
+	if (update_event) {
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = index;
+		event.timestamp = (u64)etts_h << 32;
+		event.timestamp |= etts_l;
+		ptp_clock_event(priv->clock, &event);
+	}
+}
+
+static int netc_timer_enable_extts(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	int index = rq->extts.index;
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	/* Reject requests to enable time stamping on both edges */
+	if ((rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_handle_etts_event(priv, rq->extts.index, false);
+	if (on) {
+		tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+		if (rq->extts.flags & PTP_FALLING_EDGE)
+			tmr_ctrl |= TMR_ETEP(index);
+		else
+			tmr_ctrl &= ~TMR_ETEP(index);
+
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		priv->tmr_emask |= TMR_TEVENT_ETS(index);
+	} else {
+		priv->tmr_emask &= ~TMR_TEVENT_ETS(index);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
 	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
@@ -529,6 +602,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 		return netc_timer_enable_pps(priv, rq, on);
 	case PTP_CLK_REQ_PEROUT:
 		return net_timer_enable_perout(priv, rq, on);
+	case PTP_CLK_REQ_EXTTS:
+		return netc_timer_enable_extts(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -641,6 +716,9 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_alarm	= 2,
 	.pps		= 1,
 	.n_per_out	= 3,
+	.n_ext_ts	= 2,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_FALLING_EDGE |
+				 PTP_STRICT_FLAGS,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -673,6 +751,7 @@ static void netc_timer_init(struct netc_timer *priv)
 		fiper_ctrl &= ~FIPER_CTRL_PG(i);
 	}
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
 
 	ktime_get_real_ts64(&now);
 	ns = timespec64_to_ns(&now);
@@ -806,6 +885,12 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 		ptp_clock_event(priv->clock, &event);
 	}
 
+	if (tmr_event & TMR_TEVENT_ETS(0))
+		netc_timer_handle_etts_event(priv, 0, true);
+
+	if (tmr_event & TMR_TEVENT_ETS(1))
+		netc_timer_handle_etts_event(priv, 1, true);
+
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
-- 
2.34.1


