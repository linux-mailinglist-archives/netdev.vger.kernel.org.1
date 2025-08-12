Return-Path: <netdev+bounces-212854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB4FB2242F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1479D505E03
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26C92ED144;
	Tue, 12 Aug 2025 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VHPmTGIa"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20D2EAD09;
	Tue, 12 Aug 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993292; cv=fail; b=DfjlyUisZj0nqnfk4uus15eDuRMctD5vH3Bq4qZwtCCPyq/BgrUdpnT0FDF6wAohMEU8htJaccCgbjDDTiV6AiDxtZZUynMs4iEmf3fiVL0M6dyqDhzlsH58swqEFoV36upH/17zOpw6BzHkrhmKMl2l8C9agtfA1KaJCCzqbW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993292; c=relaxed/simple;
	bh=igFircCqHapidBgLDtDsxWrbBtW4qKIDw+V49iTwZhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kLKTwYP6BwSHS3WChBQ9ztdthMxy8t8NRHXroB0M2I1npaFbj4ujScIj/a55EqGfSYlb+hlmeAT+orZlw4luUIZ5ej3q5dLBKrvUDUDOM5OYZR4gCPgyrRB2EtEUrCd9XA1fSX4NuxNotQEx0EKF366HrQSqgAQnX/PL9Tl0e88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VHPmTGIa; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqJPAY6c+Y9uN5/NDcxGDTBHuIxsgmgeOzQfrNLCRSD5HQNOa2Xy+0oLeeLGkW/hiMUpTEgWvs4MR6KnfwF4JMG3PcIfpUkmBZYUgap39M2caehSkZEiz26XZGadiC+ldgrlKvffuizPoYrJubqcRLHiJwSipo3qzLIoSSg9l0b1YCvhh1Wno9yOIPu9hI8KXEb/NHGgjhtlitdQGeSon771M5pcK4ijjNEkO2azrwm4uI7yBqLMIRzIbKxZLuog9N+qtZqfRR/UG3SQ0U5+CORSEyBu7u7eViQNZlqFI0i5XhGCbFtJNOJPhR/UgQTkua63jYlK2O06jxmkfYofMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csZ8fZTkGYg3znB71szXbYnwMMD3+Dow3LK9nTYz3c8=;
 b=ZhE3PsQG55QLC/FjPw53CL2QVmQQS5gpvM3DcfmuQstohCsMjTYVlTl27+/RQY/3QPn3KUaIwUmTmW3QZ6Z5+DDDSsVrQs1w1Iu12WWSSf/SaCjto7XUQWrrZXDJXbj5vhoAMT1GbWmRkah73C2DSzI9u2wl2IkRGr9elofq41YQu4VrbsWYfFKQOIOTgVjh/ZLIbHWL8NBOLzkkZpUuDD1KZmSfS7c6AtF240ybxULL1WGsjpr32QiNIdYzOEfoJPYUCRMPZqLCFWK7IlsNUe4VpMJunhcn7RGQCYvJjlEKCiMaWXUEAZGUoyNmzAChBQ1nv5LkaxjBU8bAVRBkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csZ8fZTkGYg3znB71szXbYnwMMD3+Dow3LK9nTYz3c8=;
 b=VHPmTGIatnKX7ZkoAHxndmLEcgWR7FcQMdj1YGm0XM7Btt2FYEzdb3wjudkvGBZNWelwTffGg1cUp++8vGOT58QOYbmpRLhkMGmk59DIOzjfNJSuEpdf1vuBTLdHexi8qseRZRg6FITSWBlf6942wWRFMcRX8ReohN5UiSnQGTO+yOhbQRykOfBaI4u5cR5l/jaYJJoptrhk9VglQHngheTYKS/5y5g9ERhzvGWj5I3RXTbPEtPmPLczFH2LeresTaseA1czDG/9V9/14hG+68u088VhHDjl6zlMfqyudu0czZCgRW/dL/Posznju5611EU1E/LBHRllHKJSjFbS0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:08:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:08:08 +0000
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
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 net-next 10/15] net: enetc: save the parsed information of PTP packet to skb->cb
Date: Tue, 12 Aug 2025 17:46:29 +0800
Message-Id: <20250812094634.489901-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1abc79-797e-455a-a08f-08ddd98822a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rxc/ES3CqRolb0aWjgUp/xW8iTCTj4atYiJloSx/lwwNyyHQFLJUEJI2+8om?=
 =?us-ascii?Q?B5wDCwWoCbzCRf2lfhs90CGPeEKIOqHo9YSjTlwEJEW/fP1CMDJCCM76Iy+s?=
 =?us-ascii?Q?+O9voQtzxDc+Dptaj7mUl+mfgXti/AWTzB8gJRcvM1wmTSGk6LfX7+zKLp8f?=
 =?us-ascii?Q?Xm0qStglC7tqgiFTbir09xYQUFIhUFRZT95HFmYfGanKIRjXYe2TUUIOnApf?=
 =?us-ascii?Q?DyZv3IeV6Bm7HHZu0HYBZHLR6nujfpaTGELE5OzCQ9st0YY55+hUeaLzoKNY?=
 =?us-ascii?Q?oXsV2hbaadg3O5xnCvuC+sOuc+o4z3L7Flwqkhpcw5obWLtGx/NL8QxidQm/?=
 =?us-ascii?Q?ZMRRcCY3C97ej1QP035gOmiKn5KG1dJjEpM6SfwMZOeH5NizyxcSBFD4i124?=
 =?us-ascii?Q?IDY4ZRD+majf3YgoJE5NdSFtoTnKF51JluisiWYs/SRKoHyOybAK699mbt1y?=
 =?us-ascii?Q?QT1zD60bgeXYlHj/ETz9beNff2mpj9cedUCL5uAHC/dqD5348H8AxnHikvTy?=
 =?us-ascii?Q?7O8DgJKJJGV8WHBe/GdBB+7dQM86SLnpTQlQewR96CZr4EwlHf97OogWN6qi?=
 =?us-ascii?Q?XHFFNOJH3R+5qJktb1+rO+LDbMNwgJpLq/lxZ3/zWX3uR4DgVl/B+Crqv2jC?=
 =?us-ascii?Q?5b4xV/V9rUI3YdprhgqvDnZauw93/rPOFHkLp9Lz885Hc5PJRWU+2ubPguM5?=
 =?us-ascii?Q?3niqLmaIHwAIjIqLQYfvWpK2nvtTnc6FSk5E4XCIRMdZiS/ZWpcfYdFY0R2Q?=
 =?us-ascii?Q?ukDC0RrdRHBMrp/SSFdC5IFQnE9QASAtkZ0xVytfOv8Iv4V4yFvwaV2OCIcn?=
 =?us-ascii?Q?KOZU3WWC5dXaiN0l8mvgVxwWlVu8OATG02b7DMin4shDRY0amlIAAFnyKwBQ?=
 =?us-ascii?Q?/D4CxYSGI5+HJmeTvB6wMo1JB1xw2uUi27mTTYVoZ4DbqCdCD0m2QjwaioHe?=
 =?us-ascii?Q?CchZNn3kBuJlgU4E4c4whC42axAqbJQbIAXLMr0cflJ/05oMZuS9XCxKXxos?=
 =?us-ascii?Q?kiGnPd+sm1dSQ44bPwMY+9qL0+rK37YipUqh+8gaQ29uMDgAzUhVykj0rXy7?=
 =?us-ascii?Q?2nTwMFQ3lXyH1EQXIAknPhp8lDelfLfcpWzNkprWieE6caREqK+OruvQH8dQ?=
 =?us-ascii?Q?a7vWgty5jCU7vs85fDQpS8/wv6dTvgF7ofMB9i4hrbki6MrFkwmynfjJzRMy?=
 =?us-ascii?Q?FnxCK09RU5s1q8J68IoTMwdH4765laqdPyMh5V0b8byc0BofnXV8QYMTIkSI?=
 =?us-ascii?Q?ppoBFhfvwZfl5lGGkR9MxoqiTsaNkyq0kcy4FPW6upyGVKGXiIFQEQvDUJYE?=
 =?us-ascii?Q?RxOBejWw+fu1IayeuML/upiZxljJHZcmOq4nw6pQSTkJfG+7AmqYdm8vCadZ?=
 =?us-ascii?Q?BR83oZUtz1Ce5dD/aPv/MLQckj5MPl5PC4vtrRtY3xTs5RFMBTRhdG3QAkry?=
 =?us-ascii?Q?4HWUUDgodclaWODJR5nQQu/6D3Vq0wus6iUusdxoO2ZrLL7Iyc+05opbmohL?=
 =?us-ascii?Q?hJqMEvNXhRhwxZY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yt+5ZA3ReOGhxTDxkk++EljQlb1spez8tbuwgtHx0IxgpQLFkAUYavpMYFMh?=
 =?us-ascii?Q?RTFob4WG4lOdph0WBqzWaQxYFpNV0Ob79z8n05sXOw/fc5fwq0Emr/+FnZ4i?=
 =?us-ascii?Q?sDzzh6Zk12qjX7MMeSPPehjejlsnmVY7obZQQ3ZzlsW/1/aa2YcHtOEeGuaW?=
 =?us-ascii?Q?wDwsevf8BF6WekSTaecY4FiUYbGpvM36QY4P/kczs8nekWExwX5uRosCvGPz?=
 =?us-ascii?Q?2hBOXtrdRDIWo55xRJtQyx27dqukM3MhmS+NyVlSuiTtCDi3bQzKbS8xaYfT?=
 =?us-ascii?Q?OEAUEENXaWsFfyOHO5AridVCIGo7ltdqbnKSzopeAmSkSl0A1pFTmxxLGuri?=
 =?us-ascii?Q?ywVKrEsjD55U/baBpZGxFe9Wsmi7NiyjFK/itcjl64HZ6y06bfUSejxXoCoF?=
 =?us-ascii?Q?EtJKOI3E/kURM+VL01AoPqWECYDM30FdcugKK2ycagx/aXTUiamwUeDo84L7?=
 =?us-ascii?Q?xnPmG7lyPbN+se2g6aiu/ruJxlmODoWEizv632yUpRPB5adO9Wq3/IoSfjeh?=
 =?us-ascii?Q?V/H46VQDpFifDtBjNMlKNkUCw1V8wwRex0uYYvC1GHOVOyTDOoUKiYGhGnYL?=
 =?us-ascii?Q?76zJv2C9FtdPzuzMhj1W0QbgkAtr6agrofX4xZvmxKikhYzO+Nopi204c9zp?=
 =?us-ascii?Q?f4Y3VIyZPvccNyRiPBGtTh7zWcV4Wz0uJi04KiZBtg8BcFjIdMpjnbPjkaSt?=
 =?us-ascii?Q?XVzR/ISAujMpOTfEDsjy78Pel+kj2KbwMn4UkLi6lV032UDRf/W2u5rksVsM?=
 =?us-ascii?Q?Sj+iBQB225dS+PZRkmw+TTwwkyF0oYOTN2FMVs4RFMMwj67sgPkly5F3CtYD?=
 =?us-ascii?Q?aMRDHc84OjbyehOuoApXUgNUUScs/kPbIqH/t3NMV0BYBCd3ySdb3+M2gYt/?=
 =?us-ascii?Q?y8WHE/kgWZXTf3s0mSdMxBqOx6T8SzNGxkoYqWsDrqYLWR9HhpmhdGN/vhvd?=
 =?us-ascii?Q?JmYo3QKYsnZ1OeJQC8UBguVMbRqiWEZlU/wLYVxfOVsiyRNDNnCzSCeNz5S3?=
 =?us-ascii?Q?fMJ+8Q3Rym1dFJhLID4Px976qFNXd0OpHMkDrWQWXNIVFs4eoT3swIUKtZDX?=
 =?us-ascii?Q?UkNh4ikOuyJlK61qSzXs9nJryUiU2Wn6tfGXfoDVWTOnE0MMt072MFPwVKS5?=
 =?us-ascii?Q?Z0+AdnkswTLr96Yry003ni3sPUiQ+GCKcCh003fP37gfUbT+TSNOrrlbl1Le?=
 =?us-ascii?Q?bMauntidqZgP4Oop6T2lFjmEnWS9/P2Ur29pT6qdxeMAzKtBUrMIyT+JDHdw?=
 =?us-ascii?Q?A2TUvCvzIgqRX2Xn2GzUQR0278HR2FGnDaSb0KWdwZNTNjZGLNQVRAxO7QZi?=
 =?us-ascii?Q?w8/zT8ljlxQqOjERWU8FHSbVI2txe4QaKrAtFBisFAtXBU4XENiOtVAGB6tQ?=
 =?us-ascii?Q?i4pqbJA/NGx5CN16cQTp43OYKPKuuJSdoslyT82QHp//e3WdsmY4xhvBlw9t?=
 =?us-ascii?Q?JGaWfLVn+hcVns1oa43D9RHCffgkozY7F2+mECJ17SiovOeR9tVVAK8gERp9?=
 =?us-ascii?Q?5G9ockzE0z3W2Xdo7ChdV83f29rTlxd76HFIZbXNG1OUXpn73Vujxy6KppVN?=
 =?us-ascii?Q?xZmS7xz3r/SoOiFPINzaVAYw6ZWUxDv5iaXMC6HC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1abc79-797e-455a-a08f-08ddd98822a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:08:08.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4yuRKJMFXYh1sB2hoGnD7VSYBSLS8JB31Wv2bewzZpXIsejBtcGtGNu4hUkGJ1V3et9JIWpPEiF05HmEs2hEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

Currently, the Tx PTP packets are parsed twice in the enetc driver, once
in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
and is unnecessary, since the parsed information can be saved to skb->cb
so that enetc_map_tx_buffs() can get the previously parsed data from
skb->cb. Therefore, add struct enetc_skb_cb as the format of the data
in the skb->cb buffer to save the parsed information of PTP packet. Use
saved information in enetc_map_tx_buffs() to avoid parsing data again.

In addition, rename variables offset1 and offset2 in enetc_map_tx_buffs()
to corr_off and tstamp_off for better readability.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Add description of offset1 and offset2 being renamed in the commit
message.
v3 changes:
1. Improve the commit message
2. Fix the error the patch, there were two "++" in the patch
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
 drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..54ccd7c57961 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -225,13 +225,12 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
-	u8 msgtype, twostep, udp;
 	union enetc_tx_bd *txbd;
-	u16 offset1, offset2;
 	int i, count = 0;
 	skb_frag_t *frag;
 	unsigned int f;
@@ -280,16 +279,10 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
-		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep, &offset1,
-				    &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep)
-			WARN_ONCE(1, "Bad packet for one-step timestamping\n");
-		else
-			do_onestep_tstamp = true;
-	} else if (skb->cb[0] & ENETC_F_TX_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
+		do_onestep_tstamp = true;
+	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
 		do_twostep_tstamp = true;
-	}
 
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
@@ -333,6 +326,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
+			u16 tstamp_off = enetc_cb->origin_tstamp_off;
+			u16 corr_off = enetc_cb->correction_off;
 			__be32 new_sec_l, new_nsec;
 			u32 lo, hi, nsec, val;
 			__be16 new_sec_h;
@@ -362,32 +357,32 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			new_sec_h = htons((sec >> 32) & 0xffff);
 			new_sec_l = htonl(sec & 0xffffffff);
 			new_nsec = htonl(nsec);
-			if (udp) {
+			if (enetc_cb->udp) {
 				struct udphdr *uh = udp_hdr(skb);
 				__be32 old_sec_l, old_nsec;
 				__be16 old_sec_h;
 
-				old_sec_h = *(__be16 *)(data + offset2);
+				old_sec_h = *(__be16 *)(data + tstamp_off);
 				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
 							 new_sec_h, false);
 
-				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
 				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
 							 new_sec_l, false);
 
-				old_nsec = *(__be32 *)(data + offset2 + 6);
+				old_nsec = *(__be32 *)(data + tstamp_off + 6);
 				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
 							 new_nsec, false);
 			}
 
-			*(__be16 *)(data + offset2) = new_sec_h;
-			*(__be32 *)(data + offset2 + 2) = new_sec_l;
-			*(__be32 *)(data + offset2 + 6) = new_nsec;
+			*(__be16 *)(data + tstamp_off) = new_sec_h;
+			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(offset1);
-			if (udp)
+			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+			if (enetc_cb->udp)
 				val |= ENETC_PM0_SINGLE_STEP_CH;
 
 			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
@@ -938,12 +933,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 				    struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
 	int count;
 
 	/* Queue one-step Sync packet if already locked */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
 					  &priv->flags)) {
 			skb_queue_tail(&priv->tx_skbs, skb);
@@ -1005,24 +1001,29 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 
 netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	u8 udp, msgtype, twostep;
 	u16 offset1, offset2;
 
-	/* Mark tx timestamp type on skb->cb[0] if requires */
+	/* Mark tx timestamp type on enetc_cb->flag if requires */
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK)) {
-		skb->cb[0] = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
-	} else {
-		skb->cb[0] = 0;
-	}
+	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
+		enetc_cb->flag = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
+	else
+		enetc_cb->flag = 0;
 
 	/* Fall back to two-step timestamp if not one-step Sync packet */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
 				    &offset1, &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0)
-			skb->cb[0] = ENETC_F_TX_TSTAMP;
+		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
+			enetc_cb->flag = ENETC_F_TX_TSTAMP;
+		} else {
+			enetc_cb->udp = !!udp;
+			enetc_cb->correction_off = offset1;
+			enetc_cb->origin_tstamp_off = offset2;
+		}
 	}
 
 	return enetc_start_xmit(skb, ndev);
@@ -1214,7 +1215,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 		if (xdp_frame) {
 			xdp_return_frame(xdp_frame);
 		} else if (skb) {
-			if (unlikely(skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
+			struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+
+			if (unlikely(enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
 				/* Start work to release lock for next one-step
 				 * timestamping packet. And send one skb in
 				 * tx_skbs queue if has.
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 62e8ee4d2f04..ce3fed95091b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -54,6 +54,15 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_skb_cb {
+	u8 flag;
+	bool udp;
+	u16 correction_off;
+	u16 origin_tstamp_off;
+};
+
+#define ENETC_SKB_CB(skb) ((struct enetc_skb_cb *)((skb)->cb))
+
 struct enetc_lso_t {
 	bool	ipv6;
 	bool	tcp;
-- 
2.34.1


