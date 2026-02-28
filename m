Return-Path: <netdev+bounces-262148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBcyGCUCo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:56:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C061C3BE9
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C81530EFEDA
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FC144A714;
	Sat, 28 Feb 2026 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DjhgOA1/"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020106.outbound.protection.outlook.com [52.101.228.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3B44A700;
	Sat, 28 Feb 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290401; cv=fail; b=W3sO9VOBwUVCn1nP43CuKpLUG6kJ7f7q9Iqhb5rQXXAyrspymewG3LDrlpau1+I5GRhf4gCcReIr1cpFQfSDwOd/uE7EnP/YxWU/R8AiaZ6QDtBaG/FIdZJ3emovYFCxpdM3l5e4aGks71hQu2sHbG9t+sg+s/2fBOIdTf88igs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290401; c=relaxed/simple;
	bh=0EtZAPC/oxv6vQ6BvvibkHA+dxPNfFXmBK5JkntZbDY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=odmwIDvLk/fOUzEK7F8c3q/4Eedu27KcSAN/BUJ9lpT0yt0zh0Nsjrzf3nRys1kn0I2DJWg2F8214SIHrN6SlRuVfi9nHvpV04qEorbpFg9uHlEsZYBamMw2yXkCY954Zw7Eu2+H2G+zUAh8bfRSPPHYtXxtB9gP4MFKGHTZjk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DjhgOA1/; arc=fail smtp.client-ip=52.101.228.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM7ZyfueLCHuArmF2R8pteAcaP6gBWrlVTmCcu0aVKkPhENePGgNKKgF6ZU47/ND/H0KuqdUxT7AiuXyk3sdtyrCYgsZK2ktaDsaBYznwv/urO/s7feEPNLfRRrQK8xqL1q0A2lFC+69hUBo1pM4IE1tzWo/Sz0h6+AhzQkfLdrCy3uPkc6DEnU11WAI2AHXYkhng2edmNucYtI/eWxsdehcy8T6+/pHc2RGEKKRFnYtFmWUYiQB1ZnlBVzRmTrAXe3XmoCQ2ROrBcB4Gb4IziE068ZsWXm7Vr3mtyNLnRvv5MBQjo+AH+oW+H3vS/RZX5PfRWv6JbM8ejnQWlrmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv0vQxhC0QTQfKVlQOFe6JRuuYbaa2X7ftnopYeRfos=;
 b=vSssqGPJlWlhJCZSOijE0q84Kmwxunt5qOryFf97aFBTwgaLT1xD3jvhFFCS9O65tcEaoXyHABTnPfwLalwVeE8cQdF0EZM2gcKC+jM9W6pSKLxpWs7OXzNNtONvtzu8tYx1Lt+GaLrGw2wmro5l8n6zNJNwiQ7nS90jaCtweOLns716ro5DBKq3lNwg9uzouPVHOqNVex0ttIKqQmOQHnsinfGD+MrarUpLnaBIPtC9ScfBGBx/EdQn1A5b7aj79njXKIg6+J0vmn74IBDsMqN8YeoeV79w2Rsqndy2qHp0O7EvuwtqqbTLqsXk3gyUX7mKJc8/ZysGIGUrUiV/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv0vQxhC0QTQfKVlQOFe6JRuuYbaa2X7ftnopYeRfos=;
 b=DjhgOA1/abHtq2bR+m+qbpdbsK2xw0ZEFbgKDF7ensFecNytz//uh43t0VjACccupXaNXO27f4sleRt0nl4NjXVWcYwxBSduU3pbz9gYgUoaI2WamUDgRxw0D75qLkHsyPD15VQAsM0GpEsXVk56VPGdVnIVHeDi6bLHY/4G8XQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5237.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 14:53:17 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Sat, 28 Feb 2026
 14:53:16 +0000
From: Koichiro Den <den@valinux.co.jp>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs
Date: Sat, 28 Feb 2026 23:53:07 +0900
Message-ID: <20260228145307.3955532-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0243.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b627e2e-ddd9-473f-9b4f-08de76d91aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	imT0S2puStSEjivN013TJaB37MUnYZbT5AU0n++HGhsWsk4Gy1MTBwkbKOZjjDvubg8cnKg+VEkD3aYlo2pKllvqu+0lJayJoDj9AjG5Nvpl4NK3LWegR/M0i++CCpA6p83d+NwNn6+ka8/WsaYU9v1W9G3Gw9OxLYaPHxW8GvZOkktVigywfo6VcFDvZTG842E3m6SIkQQ1xXjaoQjxI9D880df75oeOgwDKSlDECN2dAkJVnIKF3tGKYccCgEvl0CHuVBCUPIvVl2e4eLKTBxxQuuPNT9f+y31OvvfZSlK7f6Z8LW97JXsvHM/zPc+2X0Wrm1OT+iqr9lrjrfStOLPN0r5Yx3/t2rsSWZ4X0r7x/i45z4c8y1KemInE6PzzT0NrI6dqxCAquCayGjD6zk4wsu5Kyt5tQSLlGIeUaA9cvkI+nIGfQjoLA6sH1DjooNdQqbDILsPZ03TWy8C7vNVsTDANAPww7nvOgeSpUc8aUWN16LIKHDmrJHO+eVN6geQtvazZWg/1IHSrEbj8Qas2OO1qOEEpjneLnRnzG18hd/Zneda0rdhYVDIegYr5MRxvDJ41z/7P5Lnc6mjdosM5BDnXI+zc9u/vt7sb5BAJJmyiyDq+ohe6EgL6L6G695TzMVQv7y86XXV+q36OZdcp4fzk88OwOjLIC/aCeqxBEUzvPXDsWyyrJO/RHBfPelHN9PpCdcb49ESz9BeWI9vVx+YtjMCZ5lElunZd5c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EeBznwPcHyzHYUfwFPG5Yd8BKIuZrkjyFsQz49eHuXhI6NoptGdQUtXUDL1y?=
 =?us-ascii?Q?O40FFS283XPc2lvcgzjtghGyEQYud2LKBWLykUbBJaLF9nHsNtVHGn09C7av?=
 =?us-ascii?Q?niqsK9fxD02oJn/FkDK/lr/ttR3Yf5Ld49nrJPi3ZbIuyA19+Hfe+f9v9A+P?=
 =?us-ascii?Q?VdDz2Xvg1Q61FdP0fswLHx822/QJkjhCnuUztPyaAavbOshzQ9Zm/ZxSc4Le?=
 =?us-ascii?Q?w5m0qeTBpQbL4flxdkUQk1fty0GaVjRdplyfmRqm5vFEGnAve5LcsQW3XUs8?=
 =?us-ascii?Q?57V5RST+gZDbIA/AFldJ0QE0jT9TKKxf5+djztRQaE6WNRP8pUGOFP618Yiu?=
 =?us-ascii?Q?yPHtoWtNG7N+ExNftamIQlKq8rOmGTH/lYs/Tg1PR/VJfzMOpp3uSC8HL83h?=
 =?us-ascii?Q?ZZMxwC4I+Q/nlSDlEryfVYYeLTO0xAAu8/adWEjYUXoODGpMmShA0gbBNmJb?=
 =?us-ascii?Q?hPsd6V+++ctbr/k1d52zRpNUuVRacSzc8WmPyRlpESrQB3BLq08zlQTLiytr?=
 =?us-ascii?Q?fxftbVljIz3zha/rHPw3bWSp5n4JVoxCLCbAmKzE6no/C+f7e0FsHMFEtVSB?=
 =?us-ascii?Q?wv01ZyeyK5EZjA9EEhEIX463XADxustIJOUGgQIWmVdDUzUxMKwOX4QbeLgr?=
 =?us-ascii?Q?BraYlUtdFDkgjIxTzD32bbfJtckTa0gMMy0c/nJ6lK9W7ZLV33QsRLgkv4bi?=
 =?us-ascii?Q?Fd7WVgr+mwqwAQbXV3CR1GhIq24ohZ4GRuC9/IuADVXz+1yh07uwTWfMeRMq?=
 =?us-ascii?Q?kYcI8djkE1FSeubEsaunzRCnvqYGukaVMO7hIY75PuEUxmRp7aDjQpl0+U9e?=
 =?us-ascii?Q?fhN9U6j8/4GirdqjxQIgML7fenrFCTJXfKpzHnxaJcLVkMKqqDX7f6uXg1vM?=
 =?us-ascii?Q?JCxaXXKgiVwhirl2yB4g3fV3NroWMAyC2ipm1Z8efydbZPGZCG3UhmiYv0aH?=
 =?us-ascii?Q?hgwWG4+yUQKNwuZHWX9mm6T+nc7996QKHIr+yG1pf4yFujYewEU5fmveoSTo?=
 =?us-ascii?Q?04aewKVvIP1ehaxqszdCUcn5dmvMIy12Tf2rHbrue1CfwwVOxElKt/uCZpBt?=
 =?us-ascii?Q?TD+l2gth9XHTGsTCcmBIE8JLKLC4urufxQ5h1/ReigNPEdpYyUJcVgK4Jwfw?=
 =?us-ascii?Q?a7ANbK9d2P+jB2y94WZkK2s7+IyHyHdvcixMgxyf55CirVWyzX2h2D5QoRyJ?=
 =?us-ascii?Q?7SQ9F7ecg09pvPc2riYpFAFLwS/VD0LgZOAqxSD9y04frg90RbZ1ipjosqhO?=
 =?us-ascii?Q?ClfBXAMUoUGmzczeZRiFh55Ag/zn2sOih7YX6FfZqp0Xur4x66CZEZ9MHyGu?=
 =?us-ascii?Q?el1y4DIoBQBrJq2YkdRE1/DBDX68eUX1vOfO1Ba9vT8xXXiZTuKVGmERhjpH?=
 =?us-ascii?Q?2AuWALxVtJ4M70HZp+L4RLyzclKxNgnm+Bdymh5KJ24ro2LPSxFMsZ/ewfYR?=
 =?us-ascii?Q?GjsRJtVSDEttTfvazns16D2aJTsQdvhZcXNJRr9B7BHN+7EG5ZqmKC34PP8g?=
 =?us-ascii?Q?djqAkpEtLnyShmcE2fcN2sze1fvLk9j++yV/jKec/ZXwskDHx59ote57M7zs?=
 =?us-ascii?Q?lHru67qzRSzCc/pjbdZpMUGUZ7gZrRLq1W0XWqR5uLI2hsfVQAJQDXtL0xog?=
 =?us-ascii?Q?ddYgqDacV1LxnVKBUrICkWzdVq4+hr7QZ2K/fQmSdl8WVe97EAxVfbW4y0ZS?=
 =?us-ascii?Q?BRkbu+v0Z1MQ2REujz+VYY+cLYa61RqS0cUe8kFyuEWWBpu7YO1+Z5121V5s?=
 =?us-ascii?Q?FY4xnQ04MshWQxrg1ETkgDxYZ7t90yP+ELv5vs+0+YpjnsJpLC/6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b627e2e-ddd9-473f-9b4f-08de76d91aa8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 14:53:16.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2afgoohDFMzUiiOoq7utJJS3x2rEQRKvSvuyNjMczWP6z1ClWH8rTZdq+InN58dc6HrqXGijd7gKP1WCCFbqCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5237
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-262148-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: C1C061C3BE9
X-Rspamd-Action: no action

When shrinking the number of real tx queues,
netif_set_real_num_tx_queues() calls qdisc_reset_all_tx_gt() to flush
qdiscs for queues which will no longer be used.

qdisc_reset_all_tx_gt() currently serializes qdisc_reset() with
qdisc_lock(). However, for lockless qdiscs, the dequeue path is
serialized by qdisc_run_begin/end() using qdisc->seqlock instead, so
qdisc_reset() can run concurrently with __qdisc_run() and free skbs
while they are still being dequeued, leading to UAF.

This can easily be reproduced on e.g. virtio-net by imposing heavy
traffic while frequently changing the number of queue pairs:

  iperf3 -ub0 -c $peer -t 0 &
  while :; do
    ethtool -L eth0 combined 1
    ethtool -L eth0 combined 2
  done

With KASAN enabled, this leads to reports like:

  BUG: KASAN: slab-use-after-free in __qdisc_run+0x133f/0x1760
  ...
  Call Trace:
   <TASK>
   ...
   __qdisc_run+0x133f/0x1760
   __dev_queue_xmit+0x248f/0x3550
   ip_finish_output2+0xa42/0x2110
   ip_output+0x1a7/0x410
   ip_send_skb+0x2e6/0x480
   udp_send_skb+0xb0a/0x1590
   udp_sendmsg+0x13c9/0x1fc0
   ...
   </TASK>

  Allocated by task 1270 on cpu 5 at 44.558414s:
   ...
   alloc_skb_with_frags+0x84/0x7c0
   sock_alloc_send_pskb+0x69a/0x830
   __ip_append_data+0x1b86/0x48c0
   ip_make_skb+0x1e8/0x2b0
   udp_sendmsg+0x13a6/0x1fc0
   ...

  Freed by task 1306 on cpu 3 at 44.558445s:
   ...
   kmem_cache_free+0x117/0x5e0
   pfifo_fast_reset+0x14d/0x580
   qdisc_reset+0x9e/0x5f0
   netif_set_real_num_tx_queues+0x303/0x840
   virtnet_set_channels+0x1bf/0x260 [virtio_net]
   ethnl_set_channels+0x684/0xae0
   ethnl_default_set_doit+0x31a/0x890
   ...

Serialize qdisc_reset_all_tx_gt() against the lockless dequeue path by
taking qdisc->seqlock for TCQ_F_NOLOCK qdiscs, matching the
serialization model already used by dev_reset_queue().

Additionally clear QDISC_STATE_NON_EMPTY after reset so the qdisc state
reflects an empty queue, avoiding needless re-scheduling.

Fixes: 6b3ba9146fe6 ("net: sched: allow qdiscs to handle locking")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/net/sch_generic.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c3a7268b567e..d5d55cb21686 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -778,13 +778,23 @@ static inline bool skb_skip_tc_classify(struct sk_buff *skb)
 static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
 {
 	struct Qdisc *qdisc;
+	bool nolock;
 
 	for (; i < dev->num_tx_queues; i++) {
 		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, i)->qdisc);
 		if (qdisc) {
+			nolock = qdisc->flags & TCQ_F_NOLOCK;
+
+			if (nolock)
+				spin_lock_bh(&qdisc->seqlock);
 			spin_lock_bh(qdisc_lock(qdisc));
 			qdisc_reset(qdisc);
 			spin_unlock_bh(qdisc_lock(qdisc));
+			if (nolock) {
+				clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
+				clear_bit(__QDISC_STATE_DRAINING, &qdisc->state);
+				spin_unlock_bh(&qdisc->seqlock);
+			}
 		}
 	}
 }
-- 
2.51.0


