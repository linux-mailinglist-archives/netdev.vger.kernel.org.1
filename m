Return-Path: <netdev+bounces-266972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAnDJXKNsmkQNgAAu9opvQ
	(envelope-from <netdev+bounces-266972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:54:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1926FEA7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D596830488C2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8438758A;
	Thu, 12 Mar 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVR/Y4oM"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC623B9D9B;
	Thu, 12 Mar 2026 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309167; cv=fail; b=GOg6XmVzeOQQKYVv6tk4K34owjTwavib2EcSIzulhFOhNl2x7ocXZbO9btnnL6nKdInAPs3C6++hxAaeXCC0Ozh16YcuAI0Y0VYf6BlEZTgtoDCuglcrePckmROpsAf7aBu5FT6vy94OsCY3nbQmTYHFDmksUQdDB9A+WeXAejs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309167; c=relaxed/simple;
	bh=P+l9/HI922e+WijG+y7TcBUczt85XREec2fmx9eVBLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nCs+e6o9eGXtsiqLAa+0f1sD+v1Ew18gjRimPiVuiuikbC5TNKiFFMeiMBPUhwbO3Y9i6cgsuXV8g+iwuH9geji0PsMBQ4gYtDjtvBJNMpcehge8YwEhdgb3rFolLCE1U2wLIfYUQebL2b2kwRPYivdQYuuU/sgynU89ZJ+LiF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RVR/Y4oM; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH8L7xUYJt3SFcrhH5KwJaTugzzZafgThq0OK1y+MdHTrfIaIj5dQHiK/bbyR4YaGk98t15HTOh9IN6ra+BDk4VDvLdLmVl4rTLCs8SfJM2M7h6sFQbjwHNzM5IFQt1PHL1OgfqBSLCelu7DTno25mpRMU5/mtDMumDVrtLPqlmsWlisgd4xgAPCoVA0/Xv1EOE0iAYCVjjn14os98WltXZRvmf5acdHbSSxLrDGfhs84cz44iPJTvh3wM+qLppOhNC1Z4HdpTjy6bjzwaych4Br3ZscAeUU+gaWY2I33V1GJuv+Gu3GiKf3Z7EFuE3ATy9MR+knp35tZ9leKfQMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSdDti4M8vTB5IpmBivurz+iVs0cGLs10lo/m6w8OCo=;
 b=uIkBc4JL/j82PAXYwWZ0WOF4yt/Jr/IOz7jICUw8npi56UZ2yyx1AXxYw1qDULKcy1KeEXIOS8dKsg4PD8jeMN+h1UnnF4z6afcUJOxCaXz0RBdWAQIijlDtvKiajkubWDGlUEvpZjX/0LjgYHBySdRHF0zeKZojxGh6JgcT0RROfoHgX3f2CWkaQVDvW05NGlpIoJbSHw8y2zRct0YTxaycYpIMTpIGSJeKfp1s1ujFR7RfMharDr97SiuRktR6nUJB4XAVig7oomA9olyfKfI0eDD6D0vOFtkRg990k0fH/FapH2nW5IcwugfgADLCLifh11OlGmPEqyl0Lj5g/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSdDti4M8vTB5IpmBivurz+iVs0cGLs10lo/m6w8OCo=;
 b=RVR/Y4oMXKBJcNSY2aCwHEDZQPvzWTrq4ZDFCH/aj8+NvcTUTKXnZLZIkR0HUsqG0YOSPrxNH69j74u1+/sW/HD9qVlg0KIvI+pXLN4QZSrftkf9VMhSIctdJ21M8br7weqwYr+NcIw0Hc6y3z6/jiESDDbul2Mt0rDszBY6r3I4ZX9HESTDKQHin5zDSQ6ylZfKl8VgvzwMhv0MSd8myiikmnmn7uwd6M1mb9FXrWF9q/3q+KMoFl3d8pwp8R1CjvbdUlzpsKe3t0Vz3zhDojaLm1Vegd7ozVsJX+5uuGo5DJYJQqwtGlpNCtSsNKT2xc+pSxU786434/1LZ5nOoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 09:52:32 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::dc5a:b0aa:4a1b:c55e%6]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 09:52:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net 1/2] net: enetc: reset PIR and CIR if they are not equal when initializing TX ring
Date: Thu, 12 Mar 2026 17:54:14 +0800
Message-Id: <20260312095415.669128-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312095415.669128-1-wei.fang@nxp.com>
References: <20260312095415.669128-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|AM9PR04MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 3650ead7-0d4a-4425-5ffd-08de801d17f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bxrTs6RH8v/pwe3Fv56bjCX+6/OOVbLazmSm0aHU0TwAMXyN8f1d455RrRp7Xh2b0G08wY8d2QUvoPS28mjfqn8+jX6jBICWSkwbfqEG3jhOoDlb3yuKbgGxxFBthPvUhIcVZq3E4G99U+y274COqJkjZ5NPJQnYQTdWIcrgFi4Wbfp332QWMzNXQ7wIChG63R7pVqYoL/exJWx4UgekYICDoD6n0CUh8k0+s8WSXSAQ/16dKqb5r8NQytYzOCuV2HIoli0D434Rg5lXgUbvTLaCZF+Nurk297RzkPIQ5XgCV3QM+aKR0WjbccwRugXOslDz81SWNhl9HUEo/X3l+zIkw/3/9ThcNHyUdBktNH+fQdbWjhBv8UtWHiT6AAb6em6HC0ds7gIqW/CJGKVmgjmOcQ5HOsTZsA0w1xZgZYQ7LmPvqDD1UYl1Mj83Pa7UN7mdcueiij8/i9R6cEvXGKF6VYHUgml5G6K+E7fLogu7aFnUi3XOQnOCYlaQJ5/oMptxMFT5sbBKfrTY/xZiVSbDTtUrBH9Pb7Do3+JMzeYUvDuf1jKvr67pzAS1mYVHSNDzdGVxvWVqXJqFdp+a55xhjfB8IsKaDpY05RDOuksL2/jvfSj0oHtqTtbEDMpMlG9JdBK+7AjGHWnHOMxWYOYDBlYPf8etE+p5rco7DiTPOzan45Rndvbm5azI7RSgV/VNRJ3mJ4xmtKm3DCkZlZN6mLUiPjNwLB757f9hf2cH2Ge0Hy79DfPTe/5XXPBLxADVWdmMTqzJw/pbgpo8uDFym5/0DasuqIm5+95ab0TB7Z+WnLxHiRAVMOp7+6d6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GX1mVL6IZHlEnoKG1Ta4O46WBc+nAE7UF5fggL6T5HmL284Pcd+sxPVB/qvV?=
 =?us-ascii?Q?GcSHExcRlRagUqBV2vYLiONBYhZzWO/BzREbg2Hb9KZnQDE/6YtyouPU3Zyx?=
 =?us-ascii?Q?cfv3XRasPPOZjoQlZTLlKSkD3ADfZXFN8LcoECBVA5CIoWFAU01TNvkp3gpw?=
 =?us-ascii?Q?Mwn/x4i48lgKvS87cuG+DW1Y8r5y2NvgLVDBnX1rbX+odP81atPJCdNwtB4d?=
 =?us-ascii?Q?v/S7JNXN49sznhNMePe2dhgrt9nNNhx/zN0UYIPsJSGOSS9OHtmdJ0L2Xxl/?=
 =?us-ascii?Q?6unoe5WF0cj/XB1j65gpR/CvsesQjBsu/8LidqbyXSTHApku8peHo0mLzruO?=
 =?us-ascii?Q?kmm+IXCqpRrjeIxTgdz3atLu26UtqoUQGuIHtL2wYgBG9MLGVYsBey7THZ60?=
 =?us-ascii?Q?8kq4wCPoJJi3s3IE9L/sIHkW4mDMU9wN55OkAc/DOyyHmOcdrG7Z0LFkHVb+?=
 =?us-ascii?Q?7xIrH3npNMLVOZHE/IIawS0jgoNRSh4sOqZBkwAcsf8ILgXafslY9EtG/SUg?=
 =?us-ascii?Q?S1qPxqWSO4pAe6wsbL/6aNLb+h6QieU75sF3X6aIquThOwQEGHmWvt6davLM?=
 =?us-ascii?Q?VusYuGFCzmmr4tQCKy67qQHoZAIojr8i3eXjuUSMspOlO6MYMKsVjbpne/i9?=
 =?us-ascii?Q?20v8lIzLvD6ADUIwxJfkDzeVy8ox5kreWixUddiE3MltUhYMHJNX1zYJidoI?=
 =?us-ascii?Q?h9SIGdWk6w+exsNRjWgZJ7oifZv64pwiy8B5lc5vCU3M8T28HUY8M9WQ0sTk?=
 =?us-ascii?Q?uX8tFVawT5AuUvqTyD0t2KAlkKNFewvF5a8nDZMA5H8d7j6Vym+WQKhanKzI?=
 =?us-ascii?Q?7l71ck0YgH7ErrtcgI8sj6sLAj5cmWD2y/bXR9zCysLTpqAgAusRcZwI5drx?=
 =?us-ascii?Q?rZlXjRr6sBKM2V8SVsoZ2NkDyEQUsFgDhlukdZwNWtqCtqnrSVuCubpywOus?=
 =?us-ascii?Q?41vHUOQXlAG84dLTbHI+oyewANVKf2Dw0EABVavNU67SEegIgxanNu+exDmM?=
 =?us-ascii?Q?XsfhvhRw7OGUXQUk0QJIGxQih4R2hGoPX+3OMfUKC/qlmyoH9FgmuS8W+fsI?=
 =?us-ascii?Q?k4P9PUxISJfLENbC3lFNSjoz3I8gnQyHBIwGtjOt5ji88AudQ/GPwt9cmHBu?=
 =?us-ascii?Q?EhhYnqWRY4rqYxtXAmup43muo+7nli6Vw4wupRdwKUEFcJRfR0/lc3zM6kn5?=
 =?us-ascii?Q?blpmCAXUl2SZ2TNB9B9kAi2s99gqzRxGK9r9UUPTgOrPlOUYrFxm3A9ZVCUh?=
 =?us-ascii?Q?HzrYRPIWDb7XvrnbdSdu1BkuYhJWntcrxAPzAqmQgahe1kxpJgmz0hp4elvE?=
 =?us-ascii?Q?aiHVHOEdTddKDZcuGsr4eCeDDx9QTp+aIl2BFuwSSrCu67MobghpnAzuAKj3?=
 =?us-ascii?Q?95CoYbs2NLt3o2F+c6l5uZB7aZmPVm7YIqJPd6fzcSSH8hHnwD3HNAChGdnO?=
 =?us-ascii?Q?yJoiC/78uIZHomz18IZynJwMQYxAvMJQ9oFs6eaUa3nDE2nkya4CII5pF/rj?=
 =?us-ascii?Q?kAhGyP4tcOZByxv3pe5dKSgdHvHvfYpx4JE9C/sMRCAtu/jDX2gKfnendawY?=
 =?us-ascii?Q?jJ8CHAdjdj+YymnW7J7ZK+2cuhBSVU/eJTEzCEHCPrg4JQNFLcR8gJeZhsd7?=
 =?us-ascii?Q?szOCfArGJelIDk2U2l2COjNTk3Hf5qwzrw3Pgqls8b2nbxvw40KWqfuHwhu1?=
 =?us-ascii?Q?9qCy9LWXRMJvsymg4Q+b+fkR1dKGnVVVqlKqX2Bzv2AR7I8xw9UWHF2dqr0C?=
 =?us-ascii?Q?jRstn30mOQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3650ead7-0d4a-4425-5ffd-08de801d17f3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:52:39.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39NeGHY6Tg7IHeNWQjRdwmuKabNa+Tu/3bqTDbQJZOETyBz5S9eVVJA37LIMiw3QrzqIyMl3cASazF1rv7LP4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266972-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: E4B1926FEA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the driver does not reset the producer index register (PIR) and
consumer index register (CIR) when initializing a TX BD ring. The driver
only reads the PIR and CIR and initializes the software indexes. If the
TX BD ring is reinitialized when it still contains unsent frames, its PIR
and CIR will not be equal after the reinitialization. However, the BDs
between CIR and PIR have been freed and become invalid and this can lead
to a hardware malfunction, causing the TX BD ring will not work perperly.

For ENETC v4, it supports software to set the PIR and CIR, so the driver
can reset these two registers if they are not equal when reinitializing
the TX BD ring. Therefore, add this solution for ENETC v4. Note that this
patch does not work for ENETC v1 because it does not support software to
set the PIR and CIR.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index a146ceaf2ed6..aa8a87124b10 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2578,6 +2578,7 @@ EXPORT_SYMBOL_GPL(enetc_free_si_resources);
 
 static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 {
+	struct enetc_si *si = container_of(hw, struct enetc_si, hw);
 	int idx = tx_ring->index;
 	u32 tbmr;
 
@@ -2591,10 +2592,20 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 	enetc_txbdr_wr(hw, idx, ENETC_TBLENR,
 		       ENETC_RTBLENR_LEN(tx_ring->bd_count));
 
-	/* clearing PI/CI registers for Tx not supported, adjust sw indexes */
+	/* For ENETC v1, clearing PI/CI registers for Tx not supported,
+	 * adjust sw indexes
+	 */
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
 	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
 
+	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
+	    !is_enetc_rev1(si)) {
+		tx_ring->next_to_use = 0;
+		tx_ring->next_to_clean = 0;
+		enetc_txbdr_wr(hw, idx, ENETC_TBPIR, 0);
+		enetc_txbdr_wr(hw, idx, ENETC_TBCIR, 0);
+	}
+
 	/* enable Tx ints by setting pkt thr to 1 */
 	enetc_txbdr_wr(hw, idx, ENETC_TBICR0, ENETC_TBICR0_ICEN | 0x1);
 
-- 
2.34.1


