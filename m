Return-Path: <netdev+bounces-200204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F60EAE3B93
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0FE1897782
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284EE246778;
	Mon, 23 Jun 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9xOaBJm"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012024.outbound.protection.outlook.com [52.101.71.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508823C4FD;
	Mon, 23 Jun 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672854; cv=fail; b=m1ULsGsySzgojf+oSZ2rcPREu7Jx07FEzktUMpUxq3SSEkPCCj7bmykB9ZKw1xWSds8IZlv5u4499yCXa0kb/2aY3mbYRs2+Fr8VZMqoBMuDTEbcL0BbDOkQ7mBIA0duJlUoPs4cLBDF8QZNVox2XwmHoIGPWboH85RA46brXjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672854; c=relaxed/simple;
	bh=Bym2gQHb6j49I8326kIOKTQu7SUiXqSe8lZwtwswLfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hnS/yAVwqJdB1U7u2IRqIMF5C7ShYZJVZApYE1DTeMpeLfXEir2wocN6SfA95wSHe2JAYA3vNaZVuzJBdQozsIoxjwuTI5AWgwhgqNE4PIAMa5sLO6MKD8gb5B8zCXoqJB1RMxDzN4rp4Gq0hNdgWZ7O7Ju7D3DPGYt5j8IG3UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j9xOaBJm; arc=fail smtp.client-ip=52.101.71.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeRLjxbNkocWNfjTta6PRpLRIpPmzDHNjf9VxAPoShSW+ZPF87fSTfQ0FbP0KytMMkWuuhSEnJqwkeqcBMy6BEU6t7Mf36ypvkdnv5Pdpt0KnpITxESFLeugIp9SxPjOqw2X9uxkcSrfcJnSx2Sya0WIzind3hckI9uZmS7jHX0118nmjUH4gAIHND/H3nS7wDvDtiLCIPIXwLadDb0TfWIU8L7Q2po3xSjlLWP/c4H/wxrCx4vUBvp+5bYQN04EnYQvO6hsGd94jd1ivpXMkubk5EeYiRnpgN69AcNKRBHYhQBqbNlIc9xvdIO9HV/U6r/HDVOXeLcq1Wr0lPuM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+as3TDdicpuPByR5CsExvW0Ajl9gXav1KnPp9buLHw=;
 b=m4/l53cO4sCaAR04ZYFD1FkCo5ZF0teXXnEVZreqCTLLdISmn4fp6W8/VGmxVVah4JhEMVaO/6WjiDEWQHq0ZQRj8+rHKc6luYZ1T48aCaAC+1Yn+sqqqvaxwHhS+Qf+5QQokkQazds+veKMOYKQrqIFPobSkUIdioUVB/ojqQWM5aO7crF6nkyfBJVvvq1ooi3A+lLzeBbfBHRUPDVSHrb2bVq51XEadPVhntYBq4YbWxduOUN7Gu3sw7r4UT+cByLWAFOgP4hUQ0G5opUXoHf22308o8QKfW8vGg99DcF3ie75L2T4zTcFIHLYlpVss7gyt/Y8gmCTyfirFwx8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+as3TDdicpuPByR5CsExvW0Ajl9gXav1KnPp9buLHw=;
 b=j9xOaBJmBdnHTHfNQHOuFt6Y2qsZmVgsIx+XD3oIEM2wJFHQZ/j34MJKzrfzPyt/Cn0bYTh0DSRhCHpTJD4RXET1YthfsjCtlLHXkNHzIXCQt30bpcB/L/WuhP55eUSIQ3S3wZ9KWTFVBwepNoXuYeUI1NrfRs4kkdnCbCbJ7P+YktT8Yqd9Wt54SH5mznxcXiS7TyTjVQ4duTFwI4w2H2oPOs7VPOFgZhcEtZBtgFMy+zg+d90Nct0maurr0TtsL+VUYJdi3PZZLz44k4RQ3Ht/Q7RB14Nr3FUx6+0KxPIpxNRqN+gzMOSR/lpO+XQ4dBNAMv38oUv9kOE0KMlPOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:00:49 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:00:49 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	ulf.hansson@linaro.org,
	richardcochran@gmail.com,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.or,
	frank.li@nxp.com,
	ye.li@nxp.com,
	ping.bai@nxp.com,
	aisheng.dong@nxp.com
Subject: [PATCH v6 8/9] pmdomain: imx93-blk-ctrl: mask DSI and PXP PD domain register on i.MX91
Date: Mon, 23 Jun 2025 17:57:31 +0800
Message-Id: <20250623095732.2139853-9-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250623095732.2139853-1-joy.zou@nxp.com>
References: <20250623095732.2139853-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 92de07bd-b35e-40db-c464-08ddb23cd49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rVGaFnLsbCYF3Kp/K18CaPczdhzkyXUaSpSxzQ/gzDUK6FXSs8izra2EeAFp?=
 =?us-ascii?Q?zOq2ozGfh74XC/nj9WA+5XYTX+yrI4x9vs62XDqGQt4oEFSoAcst8nUoj8bL?=
 =?us-ascii?Q?c1hcJPAeROIWysr7DU8q5VParkbvD0gQVuyNZz+29ME+2yxGX6P795Y1CpB3?=
 =?us-ascii?Q?gJivWBGkN/TK/hIEoV0aDfhtbtiwPMbycgQmiR2n/Uq+aA1UG0gBOkYdQs6E?=
 =?us-ascii?Q?97npMVcN5l3LIT+hKvHzcjFl5oAK89Rpfc8Se+70j7wZY6RoosE0h2AiQp66?=
 =?us-ascii?Q?Lp2u8ieoCJiWpuYYT7vbdBb3dLF9V+SutQFab3MDbxgqCfZ/Z4CCIdi11Dmb?=
 =?us-ascii?Q?5bqGOLRkIqzqu84QSRMj0kH1kYct9HfqIiVh3vzY0gFXhtcJ601ddEmj8+GB?=
 =?us-ascii?Q?+GhQ/F2r/fpbaOnuNJ0DInnqL2sQN6GO5OVKIyo5NO5dSfqiXT5th0LQctB8?=
 =?us-ascii?Q?hIREDqJqzsGb2J7vIAmCNu3g2hJXpLLbJ1ELSUenBacxt4x9vJPBueKxzQHw?=
 =?us-ascii?Q?g3BuYP3S8EEJGO61Clw2Dv1KKxOwFmQDWoe/rPFm7Ke42RB2KFPJPP9ClyP+?=
 =?us-ascii?Q?En6u043U4zzwV4UDcXNMk/u7hI2twyxxFaf8Aikp5buWGV81+sspf4nXJA+P?=
 =?us-ascii?Q?DqBBapZlMz4syBKfZcTggPGA78fCFxEMp5lVzed6Lk8CvnQmId/4/VEZ0G1O?=
 =?us-ascii?Q?QvjO204fJpx0CuBCmRwj/1IXyODXnwSo4NDFcpyEQyslq+iW49ECtST1tFMR?=
 =?us-ascii?Q?Gm8KNNpE9fx/1JORjevvTN6UASK46Cc57aafq2yi/aphztr12LR9upz66Gtm?=
 =?us-ascii?Q?8nGzKkviHKCr3HoqvcHZGUC6yoRQcyAdx2x0cnW9PP7ukfw9StWqbE7C2hp4?=
 =?us-ascii?Q?uCga0egOb7AvOlah7GTL34JXykZr6XWhYRcftb4Gnkkm1VgXJV0hZxstPgUZ?=
 =?us-ascii?Q?P3Hj4Rqtsrr2gTPER6LRB4Ge0bYHfD/jfvXwCkj6nxy3cuHK1StsH8TSh7XM?=
 =?us-ascii?Q?ETfK4aLvDP/wF518VMAg3SFcP8y9ne8BaO6fJvTXKf467hDHvs59RGL8TWuo?=
 =?us-ascii?Q?MiPvPleGcGzSNeLrRSML07ZbKlmGBs21Pb0WhbCY4+9ckGcsXIuDtW7aP83l?=
 =?us-ascii?Q?DRY2KXTRS3m5XKY/36BTKnch9hgy7uLqMLeUloMa35Bzz79DYwhXnPGm0jqr?=
 =?us-ascii?Q?eCi6puvcVORrqx3VdvXw/fLwwKcfU1rUMZhbPKkuE3KTXpP9U77Tecw76wCV?=
 =?us-ascii?Q?KWkpj3m+yRHwMGkxjRBUuB7txKChy6rt1QL8+Agdk4dnk5t7gACp5NmRqfV5?=
 =?us-ascii?Q?lIB7Gs/IfXOG6gEsXmWyDm1sFCSKCa/heiZtU6VIMmISxKDJ4QJdzzEcD2h/?=
 =?us-ascii?Q?msbTL5yamVsBzjDCEFjDleqSIcRfZfH2DX/ngfMGRYqNNyuEcsc0iscf0fQ2?=
 =?us-ascii?Q?l9oqHNyzp0p1koxMgoELy1rZ/reM+Dv/yU9riDq0jFQXKUr8s8p3GQ8GOZ61?=
 =?us-ascii?Q?bgx97Ef5ZWeFB44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23CQHJTx5L7Il3QW637N4zAYZzSShgzXbHct07gyVtjVabuOmQrGQBXilN6Q?=
 =?us-ascii?Q?EnSFL1ez1BKoeS3izE+rYtZMWVm/JkFJ7rlGEadfEImpcVp2pN02Ei1LGjsU?=
 =?us-ascii?Q?u8kfpa5Qimz8bdrqF7L9CI591HFuX564q8RXXiHoxjat29ddhNJ/AoUjxGgS?=
 =?us-ascii?Q?aHb/tShdppf/DJKq7sRkNnLha2keUc8H7TfSX+ym55DkNZYDgiU1a5wtiNqh?=
 =?us-ascii?Q?B07wBhGbkw00nAj1VwOm5Ksvdf1xOKtF8lu2I5030SuaHJqFIqm48pmW4ezN?=
 =?us-ascii?Q?4Fva9eRhkBp1809YgMVdvN5Ldm6sECCWwRqLsuEKP21IJnVCZ3wPHvoiwOVU?=
 =?us-ascii?Q?g9mKyIAVwYP45nRAVvT3K4bet9DMaa1LKxIzWCWbZHFSnJMTcwOneX1qLDgT?=
 =?us-ascii?Q?Px6Ysf8MaxKHiDyMbt6Qqucfzwu3bO0E2zfKbthBwSZoRbfZ1gPWDIpBtZ+T?=
 =?us-ascii?Q?zijtCaq5uiUclIEu5CY4dCxYXpVHFt95KX+OvcIV8DHAMSFTDie905OIdv0T?=
 =?us-ascii?Q?XtECMSrbq4OVgxBaUJ/SNHDMEXUUjflkn+C5ElmqJemwGp5iIntOqpHIKbRt?=
 =?us-ascii?Q?oWl3vzVjnNmr8lypZ/kTNJuFOliecE0144xkQOOAiWjoH3Qg5wmjvW1LlihQ?=
 =?us-ascii?Q?0NqDXbn1X7Eih9qYkCwtAqi2c3UxmKK7qfviYkBFcv1z/xsu2V9NyLoq8msY?=
 =?us-ascii?Q?Q2cAPhPxJMtJDoLggJZJMoCryse5qlb6svBogwuU69HQsA7i8LCHBLcb8PaK?=
 =?us-ascii?Q?yig18TKPOY0C7AkonHwKUwYNIWe1LGgBDUsNK+P71ghn3NirMPyi+IduR03N?=
 =?us-ascii?Q?TSykyoviJhHm48KIuyAQr823bzj9AOuAPqVsBDUol7xK7VYzSGWR2dpx8OtS?=
 =?us-ascii?Q?qAeggDc4n37kOqa2Ans2zxOTi4sSYl5c16U9FkvqSUDFVHlb5qaIkWriw/nf?=
 =?us-ascii?Q?uvNZxEE8pljV83eFOKnUiaZwr45xSwcwQ+VgQlSOOKWxupTiCq+/705xD3hE?=
 =?us-ascii?Q?NdujW37NRuKnMJbbWKmh90sFx1CMeks8SpExTFtQHu8aMA1zkZ/0ICZAN0aT?=
 =?us-ascii?Q?uxXe5YfDAzSoGp0pKmWkHI0Ixt1zoS8BvGggAcGQUQjZKgetiLu8ti2siaxu?=
 =?us-ascii?Q?MjpmQn3LiVRghn8ezGkXIKVhd70/Ja/Xmh6Bm3sH1ZMazDYyHp5n1DBg8Ilp?=
 =?us-ascii?Q?+HttV7uIu8W4GnEHBaJhGZv9CmsX4n9lhL3QH5EU9kmFi7x5nyiWZW9WOQ+k?=
 =?us-ascii?Q?P5Q20t3VRQ5ntNVGSCoARB9NsmWdmFkmN+8CJGwmY77w93u2HJcV5cIxaeg8?=
 =?us-ascii?Q?gYS6szTAGxwLKaC/k6R7CNl4lSqgPia1bVzFbm8XCnaAWA2OK7x2COF7m4wu?=
 =?us-ascii?Q?WeQfwnm/9wWP4B7qWuEcqc1cUclIIp97eOskdV1IqW4wCDJN9RyyL+5uBa40?=
 =?us-ascii?Q?qn1atGaD0TSD2xG6/Gy4VqKvVAJvLAf4O14LlNNeXB2Ih8x5a8GwOCN315FR?=
 =?us-ascii?Q?+8tLsfaajPoFy94fjbll4WovxvNM3q2ZdgWLWHqIp1WwMakyKWRvJhT5GsHO?=
 =?us-ascii?Q?gw28dpFB5P+hGTZPexp7y6zzUBzUiTiAyd3Sil3E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92de07bd-b35e-40db-c464-08ddb23cd49f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:00:49.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMnJRYcuWoWA+Fqovcqc93UlrZCmtmdRdNfvhATCySjHz+B2MTxZtgxV/R5LWck/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

The i.MX91 is derived from i.MX93, but there is no DSI and PXP in i.MX91,
so mask these.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v5:
1. add imx93-blk-ctrl driver change for imx91 support.
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 0e2ba8ec55d7..04014dd5bd84 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -86,6 +86,7 @@ struct imx93_blk_ctrl_domain {
 
 struct imx93_blk_ctrl_data {
 	const struct imx93_blk_ctrl_domain_data *domains;
+	u32 skip_mask;
 	int num_domains;
 	const char * const *clk_names;
 	int num_clks;
@@ -250,6 +251,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		int j;
 
 		domain->data = data;
+		if (bc_data->skip_mask & BIT(i))
+			continue;
 
 		for (j = 0; j < data->num_clks; j++)
 			domain->clks[j].id = data->clk_names[j];
@@ -418,6 +421,15 @@ static const struct regmap_access_table imx93_media_blk_ctl_access_table = {
 	.n_yes_ranges = ARRAY_SIZE(imx93_media_blk_ctl_yes_ranges),
 };
 
+static const struct imx93_blk_ctrl_data imx91_media_blk_ctl_dev_data = {
+	.domains = imx93_media_blk_ctl_domain_data,
+	.skip_mask = BIT(IMX93_MEDIABLK_PD_MIPI_DSI) | BIT(IMX93_MEDIABLK_PD_PXP),
+	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
+	.clk_names = (const char *[]){ "axi", "apb", "nic", },
+	.num_clks = 3,
+	.reg_access_table = &imx93_media_blk_ctl_access_table,
+};
+
 static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
 	.domains = imx93_media_blk_ctl_domain_data,
 	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
@@ -428,6 +440,9 @@ static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
 
 static const struct of_device_id imx93_blk_ctrl_of_match[] = {
 	{
+		.compatible = "fsl,imx91-media-blk-ctrl",
+		.data = &imx91_media_blk_ctl_dev_data
+	}, {
 		.compatible = "fsl,imx93-media-blk-ctrl",
 		.data = &imx93_media_blk_ctl_dev_data
 	}, {
-- 
2.37.1


