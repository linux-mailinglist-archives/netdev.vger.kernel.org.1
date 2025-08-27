Return-Path: <netdev+bounces-217180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE1EB37B02
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F3D680910
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA93431A548;
	Wed, 27 Aug 2025 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kY7oCD1N"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6631A07B;
	Wed, 27 Aug 2025 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277745; cv=fail; b=qDswWq4Y/PuIF8F+sqhWEe8P1eMM3GeHnKJn/7iGNGsPzVcVjhiKeh7pqcUMlRx6rKkQ7UWmbCx27JbUS57tmTAMjIkbEhsmU2BGXxK8cbQIjiDq7zh8tX8JQAi8ovP2LMyoYMnswQrn+cF1M9MQi5+l6bZB2paRkcOFqFWIcVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277745; c=relaxed/simple;
	bh=OKS34/AzF/Vk/y3cGHYtqlV52SwpPFWsKwX/zAMT67s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdtnMZsaggMsgKjZoZFiC73UugiCNuVPaZy1cRTJuRgLypktCHITWz/Ka7DA2pxM5ooNC9A5OeMZTH/v8rTAGMXjWVwvTuOAU3lyeVotF2qyyCGZWaptHfp1ZAU+wBkVSCh43Qt61DLCfEmmMjwfmO1mZRQiAxmp2iF4pduB6ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kY7oCD1N; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbfcUwacFKG18DUEBhAg2vMt15u4u58CJcxCGCJlV4Ith9D9tEwUFIlCu+U2108BgRIIiOZHjXaHQDRFrnH4AkGBmxZwLVf4jZot+dIFfOxHx4ZaM7DcfPF0adRPNX05hQeIjhaMRngOSZ5kB/VCYyvHUtCbP5oKBFs758NJV4ahyw4qzktAyq3cZYZenpvqrlK6sBikHlLM3WIlrLYF4E9kO88NHyCttn3jfj1BsvYAt7ql9XyZdOCDhgaIerbjJjqzZLaya/BiMO53lphKL4LbzgID0aqxqXeKx0lyTlbUyMxQJOWbDzu6P7yiyOCNYsZZ24BTvg5L27Nm03uk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiKNmxLheWSPm72dXpg013ONDtNsVvDF5E7BH7O+cUI=;
 b=BE6QiXJ28a78sq1LXsb1bcOOIi6u9x/GFc0ZxJlg27HfTlsu+JYAlWtTeud3IX0lt/i90EKCJaIlXfwzrx4mll4WV1aFtn0w3QravOImlopQDuYxMuRHVVvSkqhlEkqEdxqalmR007ELUva4/ssCm/6NjnYkj7vy9G+7iel7bMeydDVbx8ns2wm763WHOADwpfPzHz/xLv94tWvdFJAUwI3t2JTqadOldfTzzf7uZq/o2B2gNTR9NY9V2HoQ99TIqOeJBGNGprWTjXZEIVe8N2EyGm7WZT5/6aChhETOu5+UqfqVoPn19kihapXjK48rSW3y7RmdUgctsyYrqxXhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiKNmxLheWSPm72dXpg013ONDtNsVvDF5E7BH7O+cUI=;
 b=kY7oCD1N3vDgIyQTbW7RYLrXV1pAB/dHH786fssnRD/5S+uy20LNih9SrK5sWqbUGBWsc8jHZOTDYQJMZ3SAqaCTUBo8AdoqjjBrbaSmd/ArdRgYcEnQsM06JTknKGzAza1B5PFHnXYt+Iq2tdBDN2G/qm4e/g8KzRys5031cCNUKg7GQu9ObOU18CwPyOZDri4CcuWX5qs2KpxtdJRQ2wyD2PEeOSUVw1i+3mYLfaxyXkjNd5Bc0375JsaI3g+QAfJVOI/K2E00rwJsHs5zWdrDcF+Q8g0IWagslLe1PhjfRPV7N2H5d6vjv1Ek1ceaeUQGBfnkeZ7EkpiUYbGCVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:55:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:40 +0000
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
Subject: [PATCH v6 net-next 08/17] ptp: netc: add external trigger stamp support
Date: Wed, 27 Aug 2025 14:33:23 +0800
Message-Id: <20250827063332.1217664-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: abff4c8a-c9d1-405c-d127-08dde536bb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mMDkvFpQMxjLjpRB27YFvTSqbRL5Dc3gafKipdRIzRnQL2PbX4hIRIw/i9oq?=
 =?us-ascii?Q?kssrew4yQaTbqaWIL+2q4vFwB8xgW52KRxFcAD1zPSl8nVbRhyxidHKq8nob?=
 =?us-ascii?Q?2zndIrMM9HTPWiCU2dhAja1dXQekPHbmjTREZUtDtdVwS7aLd7W+/phQALpe?=
 =?us-ascii?Q?G5ifQxp966SYKTk5aDGI91xKw71xiB7Y/6PJW+kLE1OAoe1kyYZ+stcNk0O8?=
 =?us-ascii?Q?5NPkzQlqwPtUxjJTkvAzFT+JOBlOhiM+hmoUv+Q2Em7mdXTEcwbnH2xTqDuJ?=
 =?us-ascii?Q?VVkGZmDiXmx+LERZE9TmW+lxkteLtFs9a/kmzkBY0On8TJJSkpWxKcr4jobc?=
 =?us-ascii?Q?A4wqP0a4fX719pE7SY4xYi845wzJdRIL66pO+kS0vBmqTnsVRy36ji+moLwR?=
 =?us-ascii?Q?Q8sz3EryxMugzU1aiVZ6jA6VMY7pXKNVG5jU/n++rsfZCabW3XatNsoC/H+n?=
 =?us-ascii?Q?Io1dlyztB/VEpsbjhdTHV1FA9I4qUX2vYNLNVGPHY139L/XuXDFvHc3hhq8N?=
 =?us-ascii?Q?4xYsZ5hzbPdFr8jJkFWFGDUJOVLq6sBfWGihC0xWQ0U7YRIGIcovBcYFfowa?=
 =?us-ascii?Q?FoSxht1X53Ij0JzDNCFrME5MwNEBWhVCgODljIlSdWDR1DDtAwlrnoza0RnF?=
 =?us-ascii?Q?vPi2eGht3OlePVSoJEeue6Sl1pRU12GsVmHUEmL3f1YN++SXWG1hvQwnWsJJ?=
 =?us-ascii?Q?Nec0Z5H1ftK/xhPOBt7ROVqaZDPS1nvOQNWQ7f1VLAXLTiloAmIAukEZ8Fgd?=
 =?us-ascii?Q?H2dWPt2eWv0CzJ/CQrSy4XmfZ082+pynkRymtgNlJTs86YilmHQuDo9jHIJm?=
 =?us-ascii?Q?DepZJ9AtNaJ3Ghfy3TSwd5/GP8qjVBeSWLt5gsOQJg8eBZasUqZUSJWtn9uC?=
 =?us-ascii?Q?1J9WlQl+mwiNOkS8YnWadPUFffcEdZNZtwCjsIjKNTio7DvJXdEnRaeH9c2M?=
 =?us-ascii?Q?5ggUZ0cwkkHwQZMO9SeoCUeK7TjuvYDx33xZtU61WZg1WPkTSpSr0Myhydwb?=
 =?us-ascii?Q?gv+bfHpSK+Gny9B2E23Ll1RrzbUV39szirymhCuURRNMziqZ211x/EK7S/lg?=
 =?us-ascii?Q?2tTgzUTpBoLGQ2Ba+54M1tKPrR9n+FOv3XkNi5LuJzjIaDJ9QZun72xg+ig7?=
 =?us-ascii?Q?8Pl6WC1iSJHOSgHZqiYs9Mpd5Mg/uC1n3n12xN0zph7Dpg3anlGBFmdh9OU3?=
 =?us-ascii?Q?ED+5VnG5vl+a0aRyegPpZkDfH7g2Ty+rWdRZ/J/Pm+sz1yKl0D4n+lnOTWKM?=
 =?us-ascii?Q?1EJ+k64oXW/Zo9EK+JFvzHDmmIx5wgUXQFWxqSb+SH6y+iVFHbozyqFw/BUM?=
 =?us-ascii?Q?KcnfWBtHL2Zo/SJghhmtG9wo/ub9MIYDtL+nsgsDdtU8ZZAqWmNmdIAl0UH5?=
 =?us-ascii?Q?L/Y9CfCIfcoSiQ+Kg+deztMTgJpO9AOiFfmbexzWJamU+X9tBkcqCvGMjMoU?=
 =?us-ascii?Q?gAYjhhEJzYBYDYowFuavlROYvfwwMIVAcRCWliueGEgF7nPunTDlncFvn9H0?=
 =?us-ascii?Q?LgXwzbOjraSgaxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/MSUB6+hb8/eQ/pQkIKYw/NO5VfA+c6EXP+Ch6RwLgotcq4qFyqNWjc+BiP?=
 =?us-ascii?Q?yicSpqhwDPS3NiUkvK/crnLB4TIbev6/flWx74cOSlOf8bVI++EPFhBpc8c2?=
 =?us-ascii?Q?BAEcKVJ9wDIP6ixHcdOdKcfinBKupLNzS94Z0fd6s6CPNX+ydd/NxpsyV0ZP?=
 =?us-ascii?Q?zKGVyocVGRwRPUEFHGlZJ0CO15VfOJ4XCnIqpQ/BBkvsLf4wa5BPRpkdS0FG?=
 =?us-ascii?Q?KpppbatRGKrAEEnHMHztlf+VU5PLcwnr7F2bFGhadtZpORcH/aRycq++WM5D?=
 =?us-ascii?Q?aJKJBENaIaWEePoRnVtS5xlt33At6nN8+3HYJbo1Q6rR8C55f9jn31AOHkuD?=
 =?us-ascii?Q?+So5DhX2wP+dRLyyKCLDmg/lcvhkMfp9Zkn8ms7u62ZZx/JiQ/QyRcvt9WQ5?=
 =?us-ascii?Q?tbWOuciiI5J+SS7mi+Ta3z+ds8xlPDCGPDH90TbsrnElxPzENjkBfr5DByCO?=
 =?us-ascii?Q?Awb0rmvpCu5PIQWysCvUYshUbsQzM3laXkNzCCdAqRssfoxfAHxgXIy8TkL7?=
 =?us-ascii?Q?wzv3OOnFBfkJWgi1fBMsIQi6+NSf8t3p6ctHj7+3PeKGSzsx2hU94Yas071R?=
 =?us-ascii?Q?Lay76CJaCFBW8YnxVNfBJNa3Q9DpACQrmlmOGfBPh9MCQfsLdyELXMeChvWJ?=
 =?us-ascii?Q?FB/w2IW+g7dry4piX9sIQ8EDO9o7f7yAugM55IIsgimVbbf4jNDQG7RX0IbG?=
 =?us-ascii?Q?D1G4Gt5I45dIzvdVSoolX7JAIyHLKpWDPSWCbUfIIv5OvDj8zGEzYkZR8EMv?=
 =?us-ascii?Q?sPyn55aT9J1/9zQaNHlM6ikiBFwoMqgIb9VPfpgYIUpUhoNJISp0QXr+G942?=
 =?us-ascii?Q?2kmncyhAOGygRvxSYWXYzkJPlups2h54IRcjGc00hE78mBLtgijn+d9UEwNO?=
 =?us-ascii?Q?qClsawDj4Q9Kpx/JA16AyO5/9QxAEYtih01P1qqgynAH+nctCOpNzMczgbHY?=
 =?us-ascii?Q?3I3IdbZ5nfFyjeYykNsiYs+JenHt8KKeURWRSedbsIewW9920mDmMiOvOuUs?=
 =?us-ascii?Q?JQ0aKlUgKQ9CMSuESQdzm9NBKmN3YY9APpZC2hSGmVAgG+BT/kWGEroLNp3s?=
 =?us-ascii?Q?6HSy0w7gwO+Ev0UXNGHKDfwYuk4L6KBOIfWWhxc1iiXD9ossBuhAcx7wemKh?=
 =?us-ascii?Q?4ge5TB1pPB8yjveqMY2hZU/kjVSA/2ujqf0NAtlLm/Xhgfsn11rbGyjkVDzD?=
 =?us-ascii?Q?/7/trnmeJdnzjJ33ZvLYePQttB0I3X4nYiBU+zzdethHsOmOxmEU1JZP7gfR?=
 =?us-ascii?Q?id9eO98v7l4q9xb0a+Hh1YH/J09Ve/DBnuN0S3TFAhs3tYPjTnbXAGQHyhSn?=
 =?us-ascii?Q?ZrBUBRSvQ+qT0zyjjv1XjnzDWOm60xQ59eolhY/s/ni1yuCw2sW6kqHy1xdX?=
 =?us-ascii?Q?jmLxzrPiKMUsEwx9hjFk+Nk/eYTeRZITsw2WDWOcafZyYXmkVqYr+dVlMOe2?=
 =?us-ascii?Q?MwBIr0ltY8jpoScUCuy5VL7vlmkrNMP2ib4IE+7iVLQ7lOcMNk384hi1nKPb?=
 =?us-ascii?Q?06+adnU34sMQmT+CRpct06hQeKVYHc+j4bIUFpXc74m2auuk1sBPbg2/xnmo?=
 =?us-ascii?Q?AMSn6L58212BKQZ+WEhfBt4U/cAcy2lKWs6vbHja?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abff4c8a-c9d1-405c-d127-08dde536bb5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:40.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2iniKDDyJI8zFhwkXHh5Z4iCXeLzKgoM5mzaajrJmzhO8BKx0c1Vos57gvWD7LjWcPV5M+uHbPGmfdp5dhhtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

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


