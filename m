Return-Path: <netdev+bounces-285144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB5zNvYS/GkjLAAAu9opvQ
	(envelope-from <netdev+bounces-285144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 06:20:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E24E2DB1
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 06:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D652B3001A4B
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 04:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136BB2D0610;
	Thu,  7 May 2026 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ELzT0XEi"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936992C0F75;
	Thu,  7 May 2026 04:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778127601; cv=fail; b=bQxLYVL9gS7v81mp13dvBpXSadexEo112iZGQhmzCHVfC6gHsKWnZ1EdPF3gw2RCDPRd9uYAP9Wal4/B9Uraz5Ryhp4Z/3jR1Yp7egb+ClFpDlKL4lTZ/YNsSpDOL9X/QarBy5DCmkgMCwIpulPmdc1De52/T7zvOVqmVeEBlHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778127601; c=relaxed/simple;
	bh=Tq6axefYy7EVn1HDCHwTyrAvC2jFkF7f5XpqSh6fBIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oY53S4cOEkWVajU+okkyorDbkJtS9gOHQq1IxXmhKFsmm18DnjiCB6wlss95a2u3cCPtNMz8QG4Q2za1P2R4eLZXadQ3GJ7Hv05zYGmgiWwHjNvgs4FuMraaBPHs9SiPuHfRtiHovCv18mPiVtXpL1M9AZ9f9OiE242dgUC1D3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ELzT0XEi; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDF4UOes67ViwNGUm0Wm81NRnPwxcbHeo/0LUHhUVU63JCa2mNs48ZehS0IdLRsHcAj3e78JUGoQDsAK9iBCv0Mo+hOJMfqRWp5DOme1Fcgdbhn4o8CAi8zULmq2z9P3V3nBiI49r6w2l6nH4zdlEIo3g34onsPF10NLy+UxxXFAOroNt7tU5CzYDViANvcc2QYVF5czXc8L8GkQX6/W8+j4wFaQWJD2Gs1+4058y0vkdMv5Z7PAff6hQj08/eFNHkrU9OTRktR1xH7YS0+9tf/LB8YK/4Y7fj/a6F9MGpzwsYNmK6TcIM+IO5nB9UvYuJrd888lC+0hqQR5GZvv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6rIKtwbBTjCCCss43G7gPPtd++DcQPNFh0/UziJGhI=;
 b=Qek0NQH5woelIVowmxUVxJTytuMKYqYCcIhjpvIWPtSHCI9Swb6AAZjqyjsnNlqDLv/d0VWcaujr3dfOdFhxhdd7q8gVgdEQoc2dWN7AxW/yaz2NUAGO5oxZlVxXCrgxbj05QdxND0W3LOm+J2Jj0svz13P9trjYdLPKWaIAtAAJwKcyQLJFF9Liouge56o/Ve4h5Xx+gK536IAAtwE9r/qW+t3Zq54PQouRz6cEHU4V0AQW6CShTp+wyV61YRTVb/fZKqClQJpO/H46sakvdjOopzU5AIsH03LoR/ts9aJYDPv5EpElMvS1nC9oBqCCBIQXtEnuDuBT91dvToLFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6rIKtwbBTjCCCss43G7gPPtd++DcQPNFh0/UziJGhI=;
 b=ELzT0XEieizQ1jBlLJVPmszqRvsWRvBvLJFy1QPYYHyRPZlkB63lkiVf+2vlM8PrvbZsgScAKSxFlO46Iz+HJuc34P2GNpI3X2DgKzngGl58nSqSFdnjjAEEFPy6wH7nunyK8et8fCQhwkhIDPd3thojExijUSLxNx/2Xpnn+iKDcLnGcPCWWko0vUj+ECXkMQFm4KIwGUemt/TOHZs7xzrrW8z0YVcZsOponFYSQlgF5is64UU9j0WKrkG3NZzFDSclC/ZlB1v82oG9YxK0GDlSVmCy9TmhxZD/LQsf2YRS+HBg/4O0eIKcdPLRrzOWyLyexwWmT4vAbIbiysogiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB7050.namprd03.prod.outlook.com (2603:10b6:a03:4d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 04:19:56 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 04:19:56 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: stmmac: Add support for TX/RX channel interrupt
Date: Wed,  6 May 2026 21:19:54 -0700
Message-ID: <20260507041954.25198-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::19) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b2e863-ced3-4c02-1fc7-08deabefe4e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1kvTJ/jeznDLp2ibxvqarnWcUXNFM8Vb7SneCbbnJHSjXHm9u2CAS3hklY85rHDkPCb3hl41u4Nlbd2pI4zaX9HUPEze1NjGvZDs7O6shmQ8/Koyt+MZAwWWZ1w+jetD7PRP0GbsOz1GAEzUUKLnh8j/0iTFWi7HzhMk5yuMeQuYqRm9RROuP5gfzjsNoge1KgfMjREKR+xu7zwtysjjSqJ5dsiJiGjlMjBbpnhkW1qUzQ4y1eZiIBzN8qj1+5xhzVj3glYLHtCUlvKRbZkguJyEBm9bTOo4VtuNEsy38/vBuxwsqDA1SEYMkFDfMvpFJhfSIT90Wursm7FgmwIUNfzYUoffLgYbgSwWUcGKGd3VLvc5TLRW8spMlKY+Dmw+60ZWnLenKZ6K868e1igpvKJdwqyj2rQuEtOogWNBOHWiINodtYY1XvEMIkThOwFEFxKP+Mre6/JFhGaaUFMtos0xk/iwb07VxL0ShPmRD7XRopWNv83UCR5Lbg4aMEN78D1DlCy4wIRQflB023oBXn6dxDXaP56yCUNqQ68nea4ldIkNDOH+FAT++PBdzZcIMLP3hy4QPR32NAr/pifZaVKzTFJx1PzYcXS4gO5LB6tE0Bp8SKnoyrSv4Js0v31i4LUt0WoMy2QXNLkbg0eZnPzviSzt+SjGW4r5ojzNMOHPfNllew+8Gco8qmASnr+d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEhUTti8RYU6hTPmb9ioap4cBVvSaKCY6xownMugk8S730TJOEqPgOnRvv7l?=
 =?us-ascii?Q?d1TOmVsZ/mI+xWXfmUUm+owYo0G00gk9akWR6GEwapy5SLWXd+UCTFWLzmic?=
 =?us-ascii?Q?/obCmXWLCEj3ge4UnCpFh3EjPTTqfxwNiuXJ1OHaYRTtJ7M61SNec5KV7Kx9?=
 =?us-ascii?Q?c7L/SjIGTg6Te1Fls9GMkX+yT9ICzZeRdZ/tCLt/k/EyQKtdmD1njrk9vv2L?=
 =?us-ascii?Q?NQ98rbI615/D4FRjZB3OddkNA+do0BgGjN57GSM7K1ZxjhCPFqQPuKh6aInn?=
 =?us-ascii?Q?8gOwjjrr4oZx4cE9EMl14mykXZbeDKKvCuHWT7cQycmLDjvayf2UxQAR8+kJ?=
 =?us-ascii?Q?mzMtpYb8dHZ7KgTxNWUH9Cbsn8vLFAfaMkN/eW37NO9Yr9svMkbwPFKbH2mD?=
 =?us-ascii?Q?ZaIQKjuBP/rp/zLJiYpPUMPiYrZ7HtIAlOCzWYeBDkAHxWiajSLmlxofr3Qn?=
 =?us-ascii?Q?Wp7RSrPR0pE7RNbH8481MBfnDZyC/wMWF0lg/KpQ1MRGFywgHZ/jxJyBlTqf?=
 =?us-ascii?Q?AX6iRoyf4b/apz5FmxhMdZQYuxCdjvoruSSvn0vD7vsJHd3a3hXNcbTkqhMX?=
 =?us-ascii?Q?2/6Y6m1Yikw3InJ2NWKGXl4BnJd2fLBOjV7PvPlkDB9xwHiRxSLIsV2TQkuc?=
 =?us-ascii?Q?VjottzZyyIQ3y6MSzJ11fKJYCUX1uwyc8r7WpF7h7e7lzzkhj2UFL3VHZw1Q?=
 =?us-ascii?Q?4elg9NeEvh7nT3b7ZWYm+Yigq8yOLx5d1kfk1M0JucaT5Z2hUHRAZe9LqMM5?=
 =?us-ascii?Q?tlpGOXzbxGx+0uvTVJXngUATDjmygyxM+wraeIqOBhjns/1Cjb4j81ChIvDv?=
 =?us-ascii?Q?aXeHzyyTLgxruxscVHjcSD/SYTrB/weYsO2eHRPQHc4aqx00c+4ACeWzU4Mb?=
 =?us-ascii?Q?FSqvMV8B1BILZtbg44AGe52tyyarxF6mQUc4FX8rEANXZhpOP5YrDwTYPbOM?=
 =?us-ascii?Q?PeoexaHaS30eyI/VXPRNnwkwm6CgfDuRr7tChcS0K3ddsk3VCC7XNxR2dfO2?=
 =?us-ascii?Q?unl0pU5eUiG5+H6UEdrucNfHy3GVS5GADSu8//mmUiOGjFn8PmkfeChVnngB?=
 =?us-ascii?Q?qfC2yZpohRTQFyA495XsbLkVRgNd+mopOAHdgZw50FZOOZnftJbfHs42KVt3?=
 =?us-ascii?Q?cTtEzpDKixaUTqGkWEKnDGxyB3+HqG6slpUSEgkWLUl8AKcV8KZvFlKGLWJh?=
 =?us-ascii?Q?Z8/DHe/VqAGUNxJExQ7B4lD4sfC+qtEeNt+TLbFfcoMzch/WLT9ec0kcbOA5?=
 =?us-ascii?Q?27f2EVPWGCjMEb2EBLYwRpE3uXagPTjEk2ADUbi2Y5yvLgqGW1pePkKsQsRM?=
 =?us-ascii?Q?9YMlMy51ddhJ9mNzOnJvdk3u+u1WgtZ+PcjleDED7eNqEoV0bPlEbN7RXt/K?=
 =?us-ascii?Q?6pVpu3NFsrOGoDxu74AoWrhZiAywQY3NG0ICFx0/ULYegfJlzDzaE8B5ubJI?=
 =?us-ascii?Q?5zH7nYqIUdoDXR7vRsAxvrkU/4E00g+9jjriM2qnX6x+Vo/vDiCI5zmYqBLz?=
 =?us-ascii?Q?vBhAm2EJ37ThsnJFZPJ5qLhPpcXYCXuWyM4rCJw6Qf9x6ljfP2vWDFhJOoLY?=
 =?us-ascii?Q?9IwbTPyWd3jCsx51SPOXF8U5/CwYXB18zVxv2BBVK47fyDyFErAwnL/a+nSy?=
 =?us-ascii?Q?4CNmyHpTpUaVdZeWPGSnMG1QNsq3xf5Im7v96wlsYtpJeOxhr2MiuPTaB4FR?=
 =?us-ascii?Q?Ra74bOqyKN0MSVlZUcLVGFoHd0TEJCDaU42V1p3Bj7CZCXaotmK6wv/HHKux?=
 =?us-ascii?Q?ztkYuxkABgfTUxaVTXcWJdzFlfNb2xG7R7CxCuXtqW8zfsEAMTOTzYDWJhvI?=
X-MS-Exchange-AntiSpam-MessageData-1: 1lf500ngiz0eJg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b2e863-ced3-4c02-1fc7-08deabefe4e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 04:19:56.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNJZX2K/7Tg1DRDLW/3rWqLSJ8JtBq/OCM9OcqS9Ai0ZD6vUGOTXwgGmJvE7kUkATT2LLClGd6Ia1O9Qioc524d/tsAbgEgqFvgKXpaklT5S6S9yzp0H0QcBq1vmw12UUFqU3wioof1o9/PB4knvtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7050
X-Rspamd-Queue-Id: DE9E24E2DB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285144-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


