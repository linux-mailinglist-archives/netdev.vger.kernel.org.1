Return-Path: <netdev+bounces-167454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC75A3A5AE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341F416904A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A816A17A30D;
	Tue, 18 Feb 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCHw155y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D917A2E2
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903579; cv=none; b=tBt7IPHgdRU5W0nEIyvPyafYgxHY/pbxEx5UjwGaacEcJX6mNOnPx4Jfx13K70J1FZ7Wq1MOSmCdzAHmtoLWoQI3HucAhJtH7VPbclHkPNTSKzEgzvgVQl9phWrVREYaQyDiPCPnv+nJFvnkqXtoQgD2CgPnag+7G0XahHaL8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903579; c=relaxed/simple;
	bh=VPD6BV7dxT9Btmkvne89eQtJUPKWnVSjaW+ZB3AD5sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gag1pD/EUlSQhN/weUIdb1n8tmZFARXG4yns+XGi+uVigK8YgL+epbpCl1BRhfWIWEhq6L6v2kCNZi8J7KeM3Ju7M2kQG3Ay4VGzOTxBc7dvylSDb5Y9EzshToYoS43u7j+z6ozC1nSHRIUMcd8AutcrZMHXvqG3UhKa0y/TVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCHw155y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739903576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uw+/gGCtc1lvlxtnuI7i2Ej4s5gefiax459DKeM7oxw=;
	b=MCHw155yRW4gZTIFVsO1gM2ffl17qDLRE46q884cKFpbkXlnY3LSQpyMK6NRDjpg1FTma2
	bsHeVRn+deUa7KtkPB9ukmF0xZBRKr1aRyoZqOj5G82cTNFGBAsNff3SCb39UbturxYQfF
	ufpmC5GOTAtsWW7sO/mMLtCsvh4dmA8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-J4H3Qk7NPLWRhOfZSHZ5Jg-1; Tue,
 18 Feb 2025 13:32:51 -0500
X-MC-Unique: J4H3Qk7NPLWRhOfZSHZ5Jg-1
X-Mimecast-MFC-AGG-ID: J4H3Qk7NPLWRhOfZSHZ5Jg_1739903569
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F3F51979057;
	Tue, 18 Feb 2025 18:32:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.155])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D65EA19560AE;
	Tue, 18 Feb 2025 18:32:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v2 net 1/2] net: allow small head cache usage with large MAX_SKB_FRAGS values
Date: Tue, 18 Feb 2025 19:29:39 +0100
Message-ID: <7c6b33e4d6e6f2831992bb4631595b1aa1da35c1.1739899357.git.pabeni@redhat.com>
In-Reply-To: <cover.1739899357.git.pabeni@redhat.com>
References: <cover.1739899357.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

on kernel built with MAX_SKB_FRAGS=45, where SKB_WITH_OVERHEAD(1024)
is smaller than GRO_MAX_HEAD.

Such built additionally contains the revert of the single page frag cache
so that napi_get_frags() ends up using the page frag allocator, triggering
the splat.

Note that the underlying issue is independent from the mentioned
revert; address it ensuring that the small head cache will fit either TCP
and GRO allocation and updating napi_alloc_skb() and __netdev_alloc_skb()
to select kmalloc() usage for any allocation fitting such cache.

Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
I preferred moving the GRO_MAX_HEAD definition into the gro.h header
instead of the (suggested) tcp.h, to avoid including such a large file
even from gro.c
---
 include/net/gro.h |  3 +++
 net/core/gro.c    |  3 ---
 net/core/skbuff.c | 10 +++++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index b9b58c1f8d19..7b548f91754b 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -11,6 +11,9 @@
 #include <net/udp.h>
 #include <net/hotdata.h>
 
+/* This should be increased if a protocol with a bigger head is added. */
+#define GRO_MAX_HEAD (MAX_HEADER + 128)
+
 struct napi_gro_cb {
 	union {
 		struct {
diff --git a/net/core/gro.c b/net/core/gro.c
index d1f44084e978..78b320b63174 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -7,9 +7,6 @@
 
 #define MAX_GRO_SKBS 8
 
-/* This should be increased if a protocol with a bigger head is added. */
-#define GRO_MAX_HEAD (MAX_HEADER + 128)
-
 static DEFINE_SPINLOCK(offload_lock);
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..f5a6d50570c4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -69,6 +69,7 @@
 #include <net/dst.h>
 #include <net/sock.h>
 #include <net/checksum.h>
+#include <net/gro.h>
 #include <net/gso.h>
 #include <net/hotdata.h>
 #include <net/ip6_checksum.h>
@@ -95,7 +96,9 @@
 static struct kmem_cache *skbuff_ext_cache __ro_after_init;
 #endif
 
-#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(MAX_TCP_HEADER)
+#define GRO_MAX_HEAD_PAD (GRO_MAX_HEAD + NET_SKB_PAD + NET_IP_ALIGN)
+#define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(max(MAX_TCP_HEADER, \
+					       GRO_MAX_HEAD_PAD))
 
 /* We want SKB_SMALL_HEAD_CACHE_SIZE to not be a power of two.
  * This should ensure that SKB_SMALL_HEAD_HEADROOM is a unique
@@ -736,7 +739,7 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	/* If requested length is either too small or too big,
 	 * we use kmalloc() for skb->head allocation.
 	 */
-	if (len <= SKB_WITH_OVERHEAD(1024) ||
+	if (len <= SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
@@ -816,7 +819,8 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 	 * When the small frag allocator is available, prefer it over kmalloc
 	 * for small fragments
 	 */
-	if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) ||
+	if ((!NAPI_HAS_SMALL_PAGE_FRAG &&
+	     len <= SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI,
-- 
2.48.1


