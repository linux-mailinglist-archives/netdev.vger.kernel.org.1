Return-Path: <netdev+bounces-284661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAnNJPqg+mk9QgMAu9opvQ
	(envelope-from <netdev+bounces-284661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:01:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7704D583A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25DC630229F6
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 02:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2361A27AC4C;
	Wed,  6 May 2026 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="RFNePBe8"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07A2459DC;
	Wed,  6 May 2026 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032823; cv=fail; b=ZebqDnFLYKQsz3u853bJL+lFq6pI86PsnIwKv+oTylwl4KluQ4IOJxEbCJO0hRQx1NcrImUTAB2HPFsMl8fe6oaxvaVmQ93RngKFgh1VQbjjDg5ITJl0ZL+uTvkC0vqOX8o8J/mpeJ7CfdPyb60h7YOcSTaTLXmfGL+N1t8Zo7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032823; c=relaxed/simple;
	bh=Tq6axefYy7EVn1HDCHwTyrAvC2jFkF7f5XpqSh6fBIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BoZDcGXfD8xy+H2xtER6cnoLyU7zD8JPXvvm2fmLJNDiEqv4LMa50Pm0+vVCs172Tyce3zzqyjqcfAJwEJZQ4rlLP7/YXnvjNekxW8pdHawJHujem5VPFxFxCkH2GWvpvYdWRw2V8Sk3OKVEkegsICJM3T8IOVLJbSByCYRu6Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RFNePBe8; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prPUG6eYwEHw3//u+7qoX8Tv8w3bv0vTGhea78YWPpT3u2lpXuV2AmhJWKLoAGp4WXvqxNjtsHCtqaudpE3FPr8kz/TSowBWnzauYAHuvVOIVebqcB5jRQ+GdgyfVe0Vb/r/UecaRpaGdfj5Rd7S6tMbafQdGQx6gZutVxVFxmDUBt9Rv2ktBsbEVCPytuLHBVVu3+UZXHv0BjEnK9IGu3sClDj12aoSp/txA2/WBLgpkicRFVgvAbNDuK4xRR3VBHw2ZDcUE4+V8Ct+ltMJWINDLCkocHSLoj4UClARJVMRrzPwqegUU3VlhENcLVTqhUBQm51WMYY7IWfIt8BEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6rIKtwbBTjCCCss43G7gPPtd++DcQPNFh0/UziJGhI=;
 b=kuwGHIqIAlx3V2gPD3oNhXReuDJl/5VY53LcisZA6oWWQMktkqqCuuNcIN7kwfCnQA9IA6gXW4sF3TUve+dJ+XGqv6KDd++Ehj//GlyM/QdFDYdaKqsANx148UH8GF/lFnbLgBc0ntbkybArSYM8cBmm3I06bHqzU+A4gXpDR9RbGS1DHPiXO1d/8SDwqgKXRvzElDQXOHEuZ7HIriRv0d2lUDGaHQWXnx0CS+r/9VE5KHDJZKzHX6/0H5WvqQroIJzJ09vay28EaRupRZruw6fJIpKkUk0V3Mw6yzW9yfO1yb1ikw47TLqGSgr5qFzMtSyGSZIH7mJlaoLl+ccTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6rIKtwbBTjCCCss43G7gPPtd++DcQPNFh0/UziJGhI=;
 b=RFNePBe8HqHyLfHR6ab/eARJWbk7IVmgK6TT5tVwMrA7pWm6/nr0X2yuwJ9onRXoUWyTefM7LUi1ZyCXKSzNkZfKBr7Nn81qctSabbZAeFAFQtHnAedAKLei40VzMuNZ6zDfQAWj3SGmwMn/MRvggr1iFcK+MdUA+9D08rWkZZuVhiVcmCRnT7GTDz6DhXyR/yvDQ23tTQnHeoTBn5OYILpXZG+EdfDXlD/DobDwwi63PB2iwidYlx9uPYyLzF+97IfFa+x48CoQIMvelneKae+1c9owKE+RRXbeHvTkAsxxY7K7yOS/I1iG6lt/4C21I3MpHQv0ronq4yQeLVhu5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS0PR03MB8200.namprd03.prod.outlook.com (2603:10b6:8:293::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 02:00:19 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 02:00:19 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: stmmac: Add support for TX/RX channel interrupt
Date: Tue,  5 May 2026 19:00:18 -0700
Message-ID: <20260506020018.25014-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DS0PR03MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 283e684e-8453-4570-91c0-08deab13399a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UrT3trGLL9A6ksCJYUo+lbC3mUSw5BRrA619cwemUbidKYlxAIvnL7HMoRYBZWHDFvEwsDT0FABvfzERLZtUdC7IhTA84BwlD3Ec6AbslyqP7gSp7FeYBiR4vWe46u+RkEdjCwKauxd2MhLCZ10Xru6AFgSFWu+/nBMZiLyPyXpoImRyujlu8/S+fKtfZca5qSFnIClEPfD5t2o4Vp7Z+YKZ4tJAeTYSdYycUNtwf5JQx8zoXso5UNnALo718B82ZoAabIghVnrJFjudb7dxMYsJICZSKhRaKeTWPeFFOeZmmBu5Udj4uNFe0vuN6dVCGCvk79aQxFN6mXxVoMc8kIlM9+yBJNfEYahb3cFqSBrgneharOot9V69XHNZUXZX5Qq6KgqsN6Pfs+ftL2goDzVuRb6KLesqaXb505Z1rdanPFc635SXO06nbDLjKXzRG3TS6Lbj1h5gQ5Q2g0jwjM35ACkYTNDmMh2xlCcn5ss2C0OvXJzlKYSg0wvBwpbCCQOKsLQ8J0EEGgpSR3OOfJ6vJ5xaRydA385t10yWUq946sipTJ+guz7L5wBy8wYRdwrseZTCRgP8khyV5S5Ik2tjE1N+qJT+y/PXrl7UjVYO1PAi9PGe8hKdZs9LmmQpgVhQuPDT9iVBhf7fRyW6GrMhwPREgX/WcsDYIO6OIQE5Q+7htKsweFzYL/+ol3J3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ByUqHfzchKObjkTSYp/lMAuxbHzLytOep4Vpqn+7QbUBvn2v7iE7H/UicYq1?=
 =?us-ascii?Q?lL5Pt10ysClxakHAm6FZDOH93AwjMHsUKjauAPn5yGOt/MOxa5Ae5zHyju28?=
 =?us-ascii?Q?Fwn0OOE/1rrpEYYu4fDBHxTHu13W1JFubsCgb1joHeNMAJSsszuK6NWghw5R?=
 =?us-ascii?Q?6P8lPiajVkdbfwjchSgXF5V2Pwg4iL49ZF2px6A4uml2mzzoIIzzXB45MBLs?=
 =?us-ascii?Q?Ik7/sQGCjOf9S5vvoGhoxlv4QEHx1CWC1iMcYtl4fpX8s855i8zKLoybm6bs?=
 =?us-ascii?Q?6T2YSAe4jaJHu6IqlAm2mgmMnBXdDkF+yg/EIcex2DOhaT9R7gjIRWhQ4YEg?=
 =?us-ascii?Q?qg7BRQf2yLtDcUKzo1shbEtRX0p8qXi6ccofufawzrvCUSopI5bE+Dg0dOea?=
 =?us-ascii?Q?qLURBpS5qbT2qCxq79SRufGtmpIgxUdKAUOhoZtXovt1YHT6MbcodyX2Qz4a?=
 =?us-ascii?Q?oBPyK+yf6nPpEKFmcEXeQXiKLuYr+4xL8mWBltuLvDk1Rm5VF+bR+nFJXsZx?=
 =?us-ascii?Q?Qr5rJc1EUJnHkUdy0viYV+wUaycc3pu+wLtOwsqHTb/BWh48NECQ2IeNEKly?=
 =?us-ascii?Q?dJ1DX2PPep80q2deJCn7E2oBNbG0zlrrqocdwGFEmcuAEK5XIVwpSEgujllB?=
 =?us-ascii?Q?d0yTj5RyNikmtmlzW2Jas0Bjmt++Uee5/Dv+kMqoAiVtQSMMgA66wfxdw2Y2?=
 =?us-ascii?Q?izpFoSj9VR10vB+Z6v4irNXfwICA1TksqI7YCB+H82xIw/XJ59P91BFk+b/N?=
 =?us-ascii?Q?ldregk9mw6Tyo4s/FY/O7QPX6tM98uw2FHKba4eCr0ZFRbs5M7T9Jrb/Utyf?=
 =?us-ascii?Q?aaxxLBI8wrQTkKHh+pmJcwPNFYGMJrMZK4htXVZUEGY+5zhXSBBeTqdlPvw9?=
 =?us-ascii?Q?CVaP5ZcTOBK422Yd3QZYsgqoMSnPOIy8SE0dqp6VEiWBIJdQO26syznWpF45?=
 =?us-ascii?Q?AwGEiVMyITUZeHvSJ/cKRTJCjVwNHItSYVoNx71pDyxPKTD7IU7uFDpWUC0o?=
 =?us-ascii?Q?tdyHjUk06oabJPXUwFkrZmEkSwPDKmCFN0JnMtUBVeOCc2ZrBPFpaVFiimkj?=
 =?us-ascii?Q?dufUfNWpk5yARSz9UZUKE98xIFJy+vaHKr7zi5E31wKw9BgFGIhY8SWByBFK?=
 =?us-ascii?Q?eLxUTpb6pGJGYgLfI1LvHOK+43zScrWTkGBsKpI2AIf1lvFVcMqFsUAfyhf6?=
 =?us-ascii?Q?dg9trx6mLpl6KF8h6Q6ygG3kvbuRtGb2gDHg30tQAfMydhyWUCwmDTzG5YF7?=
 =?us-ascii?Q?D7FxA1u2b3rVNR+5wfCLntBrzwsxEWkb/b6giSEL4naVi1kdLgBnObxArry6?=
 =?us-ascii?Q?cBYg6an7OZTWTkR/MklO0Ma+vOQrvIOz7blNjVXX3Ez76N2B2cbAKbcQ3dp0?=
 =?us-ascii?Q?oQi1sTxyCRhT0FTEyCy+W+3nMLik8xU5IQ/aRlDZdofny2cfT0E/vn6LTVIs?=
 =?us-ascii?Q?Omf+iz/8GMcx79Emm2/81t0JP3rEqRdwWPzFbrn2LUJ4d0vNRjaGSCkQv5Ai?=
 =?us-ascii?Q?W8icQz23R7EqMkJZyv1uhlgszqecB3IBMh8ti8WsVEuKkXHN+XVXAFQRRBDF?=
 =?us-ascii?Q?aMarNgfmjzkrtm9SpKOibogdsWV3IfMARfh9LdDB6VeOYVe9ydy6HyWMMRZx?=
 =?us-ascii?Q?IiDy+VpYqGHAHvUmRDtjwr0ycN06aYeNXK37nNOIpITX+kk64HfcVsyr+zyK?=
 =?us-ascii?Q?CVu5uN38YCWP4t/gPs+iR8AebYwnvErSF7trxrdngQUBkflmnKZB8HKsObWm?=
 =?us-ascii?Q?LGSguWU7BBnU2VHJ+YUOSm87FRbrbIB2AW5IKT7Z3tewlBb8jUteEAeEO4dL?=
X-MS-Exchange-AntiSpam-MessageData-1: YmSeLOmxLReVGQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283e684e-8453-4570-91c0-08deab13399a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 02:00:19.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf2b8aKyHpgu3V1XXnmZ8Mcio4EdSHTLCYU6SsqUUY8HdATfvcwD+EGSlRl8dPIcMN6G0KXXdt4ZrQplii6PYQKBPW7RJsLzFywlVo0bIugSJpQHU7c68iUIBJe2aPaSbXfb5XzK15SPxL7h7SkSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8200
X-Rspamd-Queue-Id: 3C7704D583A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284661-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Enable TX/RX channel interrupt registration for MAC that interrupts CPU
through shared peripheral interrupt (SPI).

Per-channel interrupts and interrupt-names are registered as follows,
e.g. 4 TX and 4 RX channels:
interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
interrupt-names = "dma_tx0",
                  "dma_tx1",
                  "dma_tx2",
                  "dma_tx3",
                  "dma_rx0",
                  "dma_rx1",
                  "dma_rx2",
                  "dma_rx3";

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v3:
- Add net-next tree prefix to subject line.
- Fix variable declarations to follow Reverse Christmas Tree order.

Changes in v2:
- Use -ENXIO to detect when interrupt name is not present,
  and return any other negative error code to the caller.
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5cae2aa72906..9039e207ddbd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -732,6 +732,9 @@ static int stmmac_pltfr_get_irq_array(struct platform_device *pdev,
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
+	char irq_name[9];
+	int ret;
+	int irq;
+	int i;
 
 	memset(stmmac_res, 0, sizeof(*stmmac_res));
@@ -767,6 +770,30 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ sfty not found\n");
 	}
 
+	/* For RX Channel */
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq == -ENXIO)
+			break;
+		else if (irq < 0)
+			return irq;
+
+		stmmac_res->rx_irq[i] = irq;
+	}
+
+	/* For TX Channel */
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+		snprintf(irq_name, sizeof(irq_name), "dma_tx%i", i);
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq == -ENXIO)
+			break;
+		else if (irq < 0)
+			return irq;
+
+		stmmac_res->tx_irq[i] = irq;
+	}
+
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	if (IS_ERR(stmmac_res->addr))
-- 
2.43.7


