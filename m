Return-Path: <netdev+bounces-165623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B440A32DAF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DD91886A6A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C325C718;
	Wed, 12 Feb 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDp5X9FR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D625A35E
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382175; cv=none; b=NsLrSauYyrkh4AMiDKI3DUsTfgsUWRGHNH7pECceQUr3fOmednI5xc6H4jqkB3AV0nrER+rYLeHke8Yz9qhvob14itlfQuPe2n4Skg/QnvUMqQlKaKyWRABUcPhkxQrrFxk7m+Mhrq3XcN/Q9OzZ+dxSFgMiy+8k2DXcTpgimJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382175; c=relaxed/simple;
	bh=cFVjTnrBFZ29R9fM9ym1OGKlwlDseY4yYFwww8wOgXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQjfWG4FnV4RBsuMGKMJ9I2zaFnJcn45jtrXWW8ggvAC0INKTNOlla6kJsIwmi+udUSPMCUqqFFUHQDsjlJOCmjT4XAFKPOm607vjpkowegp1oA8nXtZnHvJugZLlxLgSPbwjVdbUyTlO9QXHod3+kxG70ZlsPAqTH8A+1acm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDp5X9FR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739382171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BBjestB/6yAiyimbrN+FhxgWi21vyAUwfoacKXfmaTI=;
	b=FDp5X9FRKqP31V4fB5/fTBdYgg/XLKtchGtGxrgWYy8OKJvdP+avVZNos6ou4fmLZW1cD0
	7djTTyRB8ZowYQHuG37J5RgxsoL27Aft8X9qUGN0SoMgcAMznxVv58TuECs0cTJBMpJmu2
	ct7dTYV8bwVg4ePyt7RWV4C+lXaM4xM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-mZe1c6X-NMiIqWeAUZpemQ-1; Wed,
 12 Feb 2025 12:42:48 -0500
X-MC-Unique: mZe1c6X-NMiIqWeAUZpemQ-1
X-Mimecast-MFC-AGG-ID: mZe1c6X-NMiIqWeAUZpemQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADDE119560AE;
	Wed, 12 Feb 2025 17:42:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.167])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16BDA18004A7;
	Wed, 12 Feb 2025 17:42:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net] net: allow small head cache usage with large MAX_SKB_FRAGS values
Date: Wed, 12 Feb 2025 18:42:32 +0100
Message-ID: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Sabrina reported the following splat:

    WARNING: CPU: 0 PID: 1 at net/core/dev.c:6935 netif_napi_add_weight_locked+0x8f2/0xba0
    Modules linked in:
    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc1-net-00092-g011b03359038 #996
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
    RIP: 0010:netif_napi_add_weight_locked+0x8f2/0xba0
    Code: e8 c3 e6 6a fe 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc c7 44 24 10 ff ff ff ff e9 8f fb ff ff e8 9e e6 6a fe <0f> 0b e9 d3 fe ff ff e8 92 e6 6a fe 48 8b 04 24 be ff ff ff ff 48
    RSP: 0000:ffffc9000001fc60 EFLAGS: 00010293
    RAX: 0000000000000000 RBX: ffff88806ce48128 RCX: 1ffff11001664b9e
    RDX: ffff888008f00040 RSI: ffffffff8317ca42 RDI: ffff88800b325cb6
    RBP: ffff88800b325c40 R08: 0000000000000001 R09: ffffed100167502c
    R10: ffff88800b3a8163 R11: 0000000000000000 R12: ffff88800ac1c168
    R13: ffff88800ac1c168 R14: ffff88800ac1c168 R15: 0000000000000007
    FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffff888008201000 CR3: 0000000004c94001 CR4: 0000000000370ef0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
    <TASK>
    gro_cells_init+0x1ba/0x270
    xfrm_input_init+0x4b/0x2a0
    xfrm_init+0x38/0x50
    ip_rt_init+0x2d7/0x350
    ip_init+0xf/0x20
    inet_init+0x406/0x590
    do_one_initcall+0x9d/0x2e0
    do_initcalls+0x23b/0x280
    kernel_init_freeable+0x445/0x490
    kernel_init+0x20/0x1d0
    ret_from_fork+0x46/0x80
    ret_from_fork_asm+0x1a/0x30
    </TASK>
    irq event stamp: 584330
    hardirqs last  enabled at (584338): [<ffffffff8168bf87>] __up_console_sem+0x77/0xb0
    hardirqs last disabled at (584345): [<ffffffff8168bf6c>] __up_console_sem+0x5c/0xb0
    softirqs last  enabled at (583242): [<ffffffff833ee96d>] netlink_insert+0x14d/0x470
    softirqs last disabled at (583754): [<ffffffff8317c8cd>] netif_napi_add_weight_locked+0x77d/0xba0

on kernel built with MAX_SKB_FRAGS=45.

In such built, SKB_WITH_OVERHEAD(1024) is smaller than GRO_MAX_HEAD, and
thus after commit 011b03359038 ("Revert "net: skb: introduce and use a
single page frag cache"") napi_get_frags() ends up using the page frag
allocator, triggering the splat.

Address the issue updating napi_alloc_skb() and __netdev_alloc_skb() to
allow kmalloc() usage for GRO_MAX_HEAD allocation, regardless of the
configured MAX_SKB_FRAGS value.

Note that even before the mentioned revert, __netdev_alloc_skb() was
not using the small head cache for GRO_MAX_HEAD-size allocation for
MAX_SKB_FRAGS=45 kernel build, which is sort of unexpected.

Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Fixes: 011b03359038 ("Revert "net: skb: introduce and use a single page frag cache"")
Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/skbuff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6a99c453397f..6afd99a2736d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -661,7 +661,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	/* If requested length is either too small or too big,
 	 * we use kmalloc() for skb->head allocation.
 	 */
-	if (len <= SKB_WITH_OVERHEAD(1024) ||
+	if (len <= SKB_WITH_OVERHEAD(max(1024, SKB_SMALL_HEAD_CACHE_SIZE)) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
@@ -739,7 +739,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 	/* If requested length is either too small or too big,
 	 * we use kmalloc() for skb->head allocation.
 	 */
-	if (len <= SKB_WITH_OVERHEAD(1024) ||
+	if (len <= SKB_WITH_OVERHEAD(max(1024, SKB_SMALL_HEAD_CACHE_SIZE)) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI,
-- 
2.48.1


