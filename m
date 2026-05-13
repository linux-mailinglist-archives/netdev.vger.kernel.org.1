Return-Path: <netdev+bounces-287534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK3XKyxZBGozHQIAu9opvQ
	(envelope-from <netdev+bounces-287534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:57:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C8531BA1
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 855E8302FFBA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4343FA5D6;
	Wed, 13 May 2026 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="idwC4X6J"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA83FB040;
	Wed, 13 May 2026 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669830; cv=fail; b=mFpBerUabcBb8h3j3Nw4DLtfIvrq1FSuutKgdzF2T5j1xpBBdoItEeUMxlIE91FsxQrmXxfLMPhGak3Q/bNh2jD7dtMfZ02Ep8fZiHVS8YxAAX+HTnD/4ShSUXif4MkK9g4Np/KHP1Q6wDqw0GDxcP5QwJp2XB8cBPiqVHPA1Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669830; c=relaxed/simple;
	bh=+qmoWEHQGJFcV0Ckc8tN7eMS7M2UtpJpna1x+izfgGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mIYJNuS3eAz6p4rPkIPimxrbyDxxfHJZbNatW/ZbPP3HrLC1aoBe+UuylxVm0C20AAwpVQJNAeoew5VuM7bs3NTsI0TQlQAbKmxkX8vxjSzZGQm7IfrQ6uXnhRc4ejrWApdCsDSROvNlwtpVfcfjoHgijhB10rYtUXpZtzPcSJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=idwC4X6J; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5B9cn1CELFtbhV/kxBpeKHdztmFU3ackTrGgulxnD5KFoHevymZsLt9bgPyN80eMUevbX0wsVCPHG0ZZWNWhysiwKiAEkW+vInZ9lu+VBMtk2WpAG5qnwL4JzqhX03XRnOlr44Bz1QbbKhtIw7Qw+W7W4cCNpTGlO0mk3qhOyL/4EeQwi3hd68a116QubhM6xjvKdATkjLm0zz8kNvaIzFmQrvm6WdFeqONoQVzOmSOyMmqbi05XPM1Dy8vrnNRKoCpZjMTqazpj79VwqGcjppoZWQqmSEd91qnGzoUjuCQ/NgkK2rfsAnwxpUA+moQhzVmhZnnaCSt2eE5/RnanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5up6Q96MH6+oFPXQZWxL/Z/eBOK/+Luh2aBgHGwKesQ=;
 b=OXhNL6kS/ydDvSjY56JsB5cJMYmi6HGKR64uS8xbxsw9GFbs4NvauWjsc4PHjXigY4wsc5ALp8fPCZO0bc8CW7dYZ2Hv6+D02nvZTyY39M3rvtwYZb1nOz7AEyj7mXkEYHy0eXV2R4rj/e/g8ZqbSDMZjmTnbtiN/xfrjVu7E19k4G0M3xNGcDnxWk4XEVyAvKfu0Lqn5a6KD4V2HYBiZCqX6Piolr6EUaGMta8oE4BBRKor1CEaLvpGoNQCVqFbtZnZmxTzJ9wYtUQFQF5YO9OH7JKC87EzkdZbEMI589LdW949BnZFmOXNuude/p2QAuVzk8qGqjMLJ4qbAcmftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5up6Q96MH6+oFPXQZWxL/Z/eBOK/+Luh2aBgHGwKesQ=;
 b=idwC4X6JmUnknRzotFPGkP07KZq4YgRcOw86ppM8c9jkF+4nqRKi2PBtvHUYys/EuP1uTWc4yPIvj1lXcqJnMw0/NDkbBD9LVI7VXQa3XpuQ6nfpUJP03SkQnCr/38hk9nPcOUvAoT3Mm0OgPGa/DEvR/LSh7L1r6BGKIlo2hc84KSeT9th5c2+F4aVpeg8Qp+1nw1WOyBeJiQqdik6uRdHZNosxfNjRRbWTUS5ONGfJmIq0UIt0o6rWHyIko1jYHlQLicGiS7TtYif7B9cZxJjVo0P4pTwpQMhi5dxBQR7OGSWJE017nUUyWiHKjymtu5okYU4ZCoA5SOc74nV1tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI1PR04MB9788.eurprd04.prod.outlook.com (2603:10a6:800:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:57:03 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:57:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH net 3/6] net: enetc: fix use-after-free in mailbox cleanup on interrupt race
Date: Wed, 13 May 2026 18:30:18 +0800
Message-Id: <20260513103021.2190593-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513103021.2190593-1-wei.fang@nxp.com>
References: <20260513103021.2190593-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|VI1PR04MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 5154eebb-b560-4622-4aa5-08deb0de5d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JT+Xg7TWfAWgJ8GXf7nRb8Z+XyRNE4u/J5ZgwU9fArf9LdHHK+fgJwl7WFHvvgiaBO059u7o+wpWQx6m9LXvE5CYzLC1of20WfpfLgYzypGjuF81RZEM949kEZiEUsEHPXSbYq/TlXIuXZWl1CU6JCzcd35psUER6XYGlQag898fNr5qsRC5AafIcXaWqC6ct5KQzSfqBuStygKA0qcEyeXpRS3SWeiLTxsRtd9buGijq/+CywVn4Mk+Ejlx0Kk3JtqSpXztCvv8Zi3u0n1YtDEQJiUjff5C2gRLKeop+YHqQBsjEGuSFfNVFwHbniY+Mk6UdlQ7VwFNYvmxq8nV0YxvNx6zuvu4IYkt0ax7BwQRtK1eVdoEPtGIiTE8/po4yECg+JAz8i/0QpFiWeo7RLakQAsvUVYicJiUUDjN3oImeY5JuK8zx1KMukf5jTMOWsNLq2gPJ3G1ySn4keS5a8aB8u2YSvtKGHWWCKt9fGAL1yVKw+AixT58PgMCOVCCSbRGj1YpS/NxDyIy/2WmOtRajYGvXI746p26PSvOZEzpxr11DPXxY1wAeBBKyYFoowyUYd/NjvKGCXzN/I/kLP8gowhrbkFE3YMJI0jqPKCAV82+CCNb/f3k1StGCeRGKo0x2VmCXC/e/vVEDjSDo/poteV3Ydvz/ixhXiqim6AD4yIUQ2TVEdnQgsXRhbvq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QuPvThMNO5bnSf03IcaqOaf/EbB+p44Rc3qQ+NvigLC3jLLk/62Z1WcUN9m0?=
 =?us-ascii?Q?MIXsi9gUxIZ4r0NLCDIj9R2ubWHwUNRO3Ebzwdj6cYa1Sa1hcm+1TS6dAS+P?=
 =?us-ascii?Q?NTur60lHImOn83y/XKVfB1yxLggD8suyfd12FesgpVADj8IV5AYaFwueUOq7?=
 =?us-ascii?Q?+3tpmt6QE2gZ4Vow4kz2YMYBbdDfdD0e6UrRT+JheVNzNMuYcjxCm8pgFE8a?=
 =?us-ascii?Q?S1aaFQGj1880ZeJoZghSWZCRvpqyj3K7FecUQFoG8c6yIHphrTX+4aYdD43a?=
 =?us-ascii?Q?6jm4fGZFxTdeKBNEzHFFalg6wmAvmFn3FVdw3ci4584Q++PMNM9CrnSvJFQ1?=
 =?us-ascii?Q?QAWvIXA3xn7CumHaZR2wQKrRKH442chmXDlCiHMM+U+lEwcc5akLA/O2Cp6J?=
 =?us-ascii?Q?4vmtigwQk90V54UgiajRc7SbiVlHCkHfRCyhmwcbZjWtio5rIhyBXF8B/reN?=
 =?us-ascii?Q?YPzfMmXXOMa/i8JWdrFO5oRQL2IbGbATpNE84cxcG0SjKDPaIWXMfps7ec0T?=
 =?us-ascii?Q?SF845EzicpKjVF2VxmrXB/PYqp7W676xVAAPFROgBBQFLCQ8h9c4MHI8qZny?=
 =?us-ascii?Q?n/loquZdqvEuFG/XTIexudHk7akWd2EBeVg9k0u3RwPjkIdpZgUeZ96CfZi7?=
 =?us-ascii?Q?ZnSB6qFA8s4e8EIfz2PR7FfNKhadd2S3DsqZmxoByyNnUlcdQcqB4U7Dshwk?=
 =?us-ascii?Q?QTGqSNVa7jsXy8+p6atvCGSSEm2FZhKU6xNG9KoYLp/ITHmlrsNv2wFCyDJW?=
 =?us-ascii?Q?dp4x0+gK62ZoIqKbyc1DLQYR7OTkt0lKTOsVmh73iJdM9ZA3sNJQicApLYWk?=
 =?us-ascii?Q?o8C03BR5ScUF5eR4iynaQG5XYgtIbpZtZb1Bakabn9F34gFVHriv3M6yAzAq?=
 =?us-ascii?Q?r4dc2ZIRQ8TQqd5BoFrvQxQ6dZMxu90trACf1m9AygpOuXQluM3VzyTYqcyV?=
 =?us-ascii?Q?IW2ZTNbAoAQZIOSlbwGJx0pgZI2Q5IoCxzRVc3aYE0zOXnrX6vY+Gy45AtLY?=
 =?us-ascii?Q?x1sDXfMaMtSJP1vPaYac8sCmJadXMmNBBcwcTUlDZYa4k+IyWJoj0UNnmoQJ?=
 =?us-ascii?Q?k+gkB43bLR6RSE28G7He2B2xUlOG2sFJBuuLliUDG0Q8LFs6VAI26KF8UHyC?=
 =?us-ascii?Q?IqZPi0YDOw550J/kT3qP1UDlLOuuKXIn+GTFeFX22pNKbgn9ctqMjQaNE8gC?=
 =?us-ascii?Q?5z9CAqQl5H0oV8r523gDTTwsxFnTlop5dYi7X38N+7KyjUlRowyMOiHiTbqj?=
 =?us-ascii?Q?6t97Fd/AjIKEWwmvMeq0/N+OesVc2EvZG1TXCzBlGVSVGm2E8kuEsccae3rg?=
 =?us-ascii?Q?hk//XLcHgzjn/EafA/a0b1vNKrf8kx83hOx6/5oia7oezJEyxOIGQ4aHbN4K?=
 =?us-ascii?Q?sqs0bDQpB1rjzubnFciNYgfaCMNr4tLkZGDTSfE7cFDUHW2VMJcV2/EXQBaP?=
 =?us-ascii?Q?9amZfPRTICZr87+SHyEY7Yh6AKfLq8vfczc4BnLFA9KwOAicCb9JmJlKJiIx?=
 =?us-ascii?Q?ElQLQ85rYj2ZQLkEK0pvTaciU0EnXaY2jb6l+WQTVJprhMIAdr79bn4BQ85D?=
 =?us-ascii?Q?oX/zamoZ9njZpF2S8BivYyRjBKZv7cp0M7vSBtFXPOnkgFjRlyJe+v0dzMqj?=
 =?us-ascii?Q?AHio3aH6WzR76OhSVYedvQA6nhXasjtNcTWRHuX0s/ymGd7lGw+7d1Khlnqq?=
 =?us-ascii?Q?XKBNpWZTjh8fnmficJk2MLawv5B6g+Kf/lXvCPUvZdw6cNjCM9E9qOa6FZfR?=
 =?us-ascii?Q?iqPXSeDYdQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5154eebb-b560-4622-4aa5-08deb0de5d2e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:57:02.8631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vaszg5tZsTgswf8e82URDHC8LN8Jc8NByo2RXwa4DlhIKjdORzTJjlh+llMHNW8YLIV1OnbZF7jbtCrwHpiDAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9788
X-Rspamd-Queue-Id: B57C8531BA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287534-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sashiko reported a use-after-free issue in the PF mailbox teardown path
due to incorrect shutdown ordering [1].

In enetc_msg_psi_free(), cancel_work_sync() is called before disabling
the hardware MR interrupt and unregistering the interrupt handler via
free_irq(). This creates a race window where:

1. cancel_work_sync() completes and returns
2. A hardware interrupt arrives and enetc_msg_psi_msix() executes
3. The interrupt handler calls schedule_work(&pf->msg_task),
   re-queuing the work
4. enetc_msg_free_mbx() frees the mailbox DMA buffers
5. The re-queued msg_task work runs and accesses freed memory

The timeline of the race:

  CPU0 (teardown)                   CPU1 (interrupt)
  ================                  ================
  cancel_work_sync()
    -> work cancelled
                                    <interrupt>
                                    enetc_msg_psi_msix()
                                      schedule_work() // work re-queued!
  enetc_msg_disable_mr_int()
  enetc_msg_free_mbx()
    -> DMA buffers freed
  free_irq()
                                    worker runs
                                    -> UAF: access freed rxmsg[]

Fix by reordering the teardown sequence to follow proper driver shutdown
discipline:

1. Synchronously unregister interrupt handler (free_irq)
   - Waits for any running handler to complete
   - Guarantees no more schedule_work() calls after this point
2. Cancel pending work (cancel_work_sync)
   - Now safe, as no new work can be queued
3. Free mailbox resources (enetc_msg_free_mbx)
   - All accessors have stopped
4. Disable hardware interrupt source (enetc_msg_disable_mr_int)
   - Clean up hardware state (defense in depth)

After free_irq() returns, the interrupt handler cannot run anymore,
eliminating the possibility of work re-queuing after cancellation. This
ensures mailbox buffers are only freed after all potential accessors
have been shut down.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_msg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 40d22ebe9224..fe9680a97b0e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -151,14 +151,14 @@ void enetc_msg_psi_free(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	int i;
 
-	cancel_work_sync(&pf->msg_task);
+	/* de-register message passing interrupt handler */
+	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 
-	/* disable MR interrupts */
-	enetc_msg_disable_mr_int(&si->hw);
+	cancel_work_sync(&pf->msg_task);
 
 	for (i = 0; i < pf->num_vfs; i++)
 		enetc_msg_free_mbx(si, i);
 
-	/* de-register message passing interrupt handler */
-	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
+	/* disable MR interrupts */
+	enetc_msg_disable_mr_int(&si->hw);
 }
-- 
2.34.1


