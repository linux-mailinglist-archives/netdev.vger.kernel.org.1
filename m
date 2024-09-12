Return-Path: <netdev+bounces-127721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF729763A2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB5B1C203E5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7218FC7F;
	Thu, 12 Sep 2024 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="t8eQsoMH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F118C92F
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127769; cv=none; b=EwCEjM61hV8l9B4wqUTIpqCXpkZ+sLKQl2/liOWFcRR+qX9tSu2qJwvvvO45RwgSzDrjnFhqV6Rc2Rw5p4IgWT3j9x44KI5pvBwwVMcGqm50uD1ZERKWldK9wFqpoi/lwlL6nZmyr1pWdocRUco6vWbYFSjN0+KRza7JqfmT9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127769; c=relaxed/simple;
	bh=dNQQlAVFs2vCdURoAlYQG8QkvzVb13C0bL60G5t9Pho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDsu7BmWVDzaCw3QSNPBPjDlwWLj99OTwX1PAPxRMIK9PfHeAXGQ1pwaOAKp5G7GEr3CEseF4DmsMKBReUKEh17In7bzxV17DzV/9Fgj8PV8c4UuLg0hRBZdIJkwTHWfpDf6GDHgGQgdF7fhEoNoGJzeIsNS3aKbDLlhMR9QP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=t8eQsoMH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3192E3F733
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726127763;
	bh=pbrIxi68gOsMYItiiHH151+Tr1OOehx4s88IlZpapRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=t8eQsoMHSt3uRuOe0Van0eyeB84n5Re+y/aqCng0lszIpVRfAzZqkJv8ZmoreUvX1
	 PIVnHkZXWWGB6+WW8B69LRKn9SY/za1ZGIjjz4zzzUvOOCcvXFdA5wTwfLRCPqJk5c
	 mA4VyaQe/vRZQrLre9PR0KD+BKuWPbM6teXhuKaDu1XqCDVUxi/8KEPvtQHnVdxczv
	 5C3yEXvdh5/agEkxb9OptbP87MdjSRBxxT1dF7aEMsoKpCctb+hXZC51LFuENR1jG/
	 Z0GpqqSLCysPrCea8fG6Pq1k0tBgxIV4APV75IgbnNxYRw0NEv0p0AbgZk1Pp7hJ+C
	 tYsHTkaOVvRAA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d877d7f9b4so757701a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 00:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726127761; x=1726732561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbrIxi68gOsMYItiiHH151+Tr1OOehx4s88IlZpapRw=;
        b=VMGi0pvNq4rZq2Gm9v55FiRBg+LcD9R+PYeWzhqtptb/uWzg02eBK8nAMlwwnonMjz
         W7j/RcOaGbGaVEbs7bZ6Wh0Bz8Xmysk1nKVN6i90tQONZKDDNXJipH8rovMX65fN4f81
         Gwq5urriWNrGd1hrUyeXR36VyNH9bkm1hStDxEj8fPcHx3TIk9Xyb9niDWJRtV+qunDG
         FGX72l1nS1gfOaRYc5z+Oul53dKSKdOJUC6vWIbsKmZmE6iUOdWvAfvXWxvxNczCo4F3
         V06ARUmKakgUlrVpXlYrei5yYb9uarGNArBsaH4pT2gt4wxNE8YI9fIuUrJSj+XeQNIW
         wikQ==
X-Gm-Message-State: AOJu0Yz2ToywBhvbqui4G+5tcC0NS/YekHm2lJM8FeCCq3MgOaVv0ij8
	S47S7HwzvJRrwK1u9cLZpqlavhpw+LaZ+WciMNgb7cSX6Z2Y3PYjE8cUb/wZtHOCeK+LYFSfaA4
	N7c7bNIpGmAvafHxudcF8fuiuIWtOeaFwJe7ylRLzHTSuwgS4oyt/Tkj20UdMr/KFTZ27Sg==
X-Received: by 2002:a17:90a:6089:b0:2d8:ad96:6ef4 with SMTP id 98e67ed59e1d1-2dba0064ee1mr2032189a91.28.1726127760427;
        Thu, 12 Sep 2024 00:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTGWQOfx+oqjbXxi62gyrmCzuhchrID9SkwLSClQzJcML/tmC2EQgjWpXynAcNxAOUNVkdiA==
X-Received: by 2002:a17:90a:6089:b0:2d8:ad96:6ef4 with SMTP id 98e67ed59e1d1-2dba0064ee1mr2032174a91.28.1726127759935;
        Thu, 12 Sep 2024 00:55:59 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadb42e6fasm12033799a91.0.2024.09.12.00.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:55:59 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	en-wei.wu@canonical.com,
	kai.heng.feng@canonical.com,
	chia-lin.kao@canonical.com,
	anthony.wong@canonical.com,
	kuan-ying.lee@canonical.com,
	chris.chiu@canonical.com
Subject: [PATCH ipsec v3] xfrm: check MAC header is shown with both skb->mac_len and skb_mac_header_was_set()
Date: Thu, 12 Sep 2024 15:55:55 +0800
Message-ID: <20240912075555.225316-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we use Intel WWAN with xfrm, our system always hangs after
browsing websites for a few seconds. The error message shows that
it is a slab-out-of-bounds error:

[ 67.162014] BUG: KASAN: slab-out-of-bounds in xfrm_input+0x426e/0x6740
[ 67.162030] Write of size 2 at addr ffff888156cb814b by task ksoftirqd/2/26

[ 67.162043] CPU: 2 UID: 0 PID: 26 Comm: ksoftirqd/2 Not tainted 6.11.0-rc6-c763c4339688+ #2
[ 67.162053] Hardware name: Dell Inc. Latitude 5340/0SG010, BIOS 1.15.0 07/15/2024
[ 67.162058] Call Trace:
[ 67.162062] <TASK>
[ 67.162068] dump_stack_lvl+0x76/0xa0
[ 67.162079] print_report+0xce/0x5f0
[ 67.162088] ? xfrm_input+0x426e/0x6740
[ 67.162096] ? kasan_complete_mode_report_info+0x26/0x200
[ 67.162105] ? xfrm_input+0x426e/0x6740
[ 67.162112] kasan_report+0xbe/0x110
[ 67.162119] ? xfrm_input+0x426e/0x6740
[ 67.162129] __asan_report_store_n_noabort+0x12/0x30
[ 67.162138] xfrm_input+0x426e/0x6740
[ 67.162149] ? __pfx_xfrm_input+0x10/0x10
[ 67.162160] ? __kasan_check_read+0x11/0x20
[ 67.162168] ? __call_rcu_common+0x3e7/0x15b0
[ 67.162178] xfrm4_rcv_encap+0x214/0x470
[ 67.162186] ? __xfrm4_udp_encap_rcv.part.0+0x3cd/0x560
[ 67.162195] xfrm4_udp_encap_rcv+0xdd/0xf0
[ 67.162203] udp_queue_rcv_one_skb+0x880/0x12f0
[ 67.162212] udp_queue_rcv_skb+0x139/0xa90
[ 67.162221] udp_unicast_rcv_skb+0x116/0x350
[ 67.162229] __udp4_lib_rcv+0x213b/0x3410
[ 67.162237] ? ldsem_down_write+0x211/0x4ed
[ 67.162246] ? __pfx___udp4_lib_rcv+0x10/0x10
[ 67.162254] ? __pfx_raw_local_deliver+0x10/0x10
[ 67.162262] ? __pfx_cache_tag_flush_range_np+0x10/0x10
[ 67.162273] udp_rcv+0x86/0xb0
[ 67.162280] ip_protocol_deliver_rcu+0x152/0x380
[ 67.162289] ip_local_deliver_finish+0x282/0x370
[ 67.162296] ip_local_deliver+0x1a8/0x380
[ 67.162303] ? __pfx_ip_local_deliver+0x10/0x10
[ 67.162310] ? ip_rcv_finish_core.constprop.0+0x481/0x1ce0
[ 67.162317] ? ip_rcv_core+0x5df/0xd60
[ 67.162325] ip_rcv+0x2fc/0x380
[ 67.162332] ? __pfx_ip_rcv+0x10/0x10
[ 67.162338] ? __pfx_dma_map_page_attrs+0x10/0x10
[ 67.162346] ? __kasan_check_write+0x14/0x30
[ 67.162354] ? __build_skb_around+0x23a/0x350
[ 67.162363] ? __pfx_ip_rcv+0x10/0x10
[ 67.162369] __netif_receive_skb_one_core+0x173/0x1d0
[ 67.162377] ? __pfx___netif_receive_skb_one_core+0x10/0x10
[ 67.162386] ? __kasan_check_write+0x14/0x30
[ 67.162394] ? _raw_spin_lock_irq+0x8b/0x100
[ 67.162402] __netif_receive_skb+0x21/0x160
[ 67.162409] process_backlog+0x1c0/0x590
[ 67.162417] __napi_poll+0xab/0x550
[ 67.162425] net_rx_action+0x53e/0xd10
[ 67.162434] ? __pfx_net_rx_action+0x10/0x10
[ 67.162443] ? __pfx_wake_up_var+0x10/0x10
[ 67.162453] ? tasklet_action_common.constprop.0+0x22c/0x670
[ 67.162463] handle_softirqs+0x18f/0x5d0
[ 67.162472] ? __pfx_run_ksoftirqd+0x10/0x10
[ 67.162480] run_ksoftirqd+0x3c/0x60
[ 67.162487] smpboot_thread_fn+0x2f3/0x700
[ 67.162497] kthread+0x2b5/0x390
[ 67.162505] ? __pfx_smpboot_thread_fn+0x10/0x10
[ 67.162512] ? __pfx_kthread+0x10/0x10
[ 67.162519] ret_from_fork+0x43/0x90
[ 67.162527] ? __pfx_kthread+0x10/0x10
[ 67.162534] ret_from_fork_asm+0x1a/0x30
[ 67.162544] </TASK>

[ 67.162551] The buggy address belongs to the object at ffff888156cb8000
                which belongs to the cache kmalloc-rnd-09-8k of size 8192
[ 67.162557] The buggy address is located 331 bytes inside of
                allocated 8192-byte region [ffff888156cb8000, ffff888156cba000)

[ 67.162566] The buggy address belongs to the physical page:
[ 67.162570] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x156cb8
[ 67.162578] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 67.162583] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[ 67.162591] page_type: 0xfdffffff(slab)
[ 67.162599] raw: 0017ffffc0000040 ffff888100056780 dead000000000122 0000000000000000
[ 67.162605] raw: 0000000000000000 0000000080020002 00000001fdffffff 0000000000000000
[ 67.162611] head: 0017ffffc0000040 ffff888100056780 dead000000000122 0000000000000000
[ 67.162616] head: 0000000000000000 0000000080020002 00000001fdffffff 0000000000000000
[ 67.162621] head: 0017ffffc0000003 ffffea00055b2e01 ffffffffffffffff 0000000000000000
[ 67.162626] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[ 67.162630] page dumped because: kasan: bad access detected

[ 67.162636] Memory state around the buggy address:
[ 67.162640] ffff888156cb8000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 67.162645] ffff888156cb8080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 67.162650] >ffff888156cb8100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 67.162653] ^
[ 67.162658] ffff888156cb8180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 67.162663] ffff888156cb8200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

The reason is that the eth_hdr(skb) inside if statement evaluated
to an unexpected address with skb->mac_header = ~0U (indicating there
is no MAC header). The unreliability of skb->mac_len causes the if
statement to become true even if there is no MAC header inside the
skb data buffer.

Check both the skb->mac_len and skb_mac_header_was_set(skb) fixes this issue.

Fixes: 87cdf3148b11 ("xfrm: Verify MAC header exists before overwriting eth_hdr(skb)->h_proto")
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
Changes in v3:
* Swap the check: skb->mac_len and skb_mac_header_was_set(skb)
---

 net/xfrm/xfrm_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 749e7eea99e4..e12ba288e6ee 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -251,7 +251,7 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	if (skb->mac_len)
+	if (skb_mac_header_was_set(skb) && skb->mac_len)
 		eth_hdr(skb)->h_proto = skb->protocol;
 
 	err = 0;
@@ -288,7 +288,7 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	if (skb->mac_len)
+	if (skb_mac_header_was_set(skb) && skb->mac_len)
 		eth_hdr(skb)->h_proto = skb->protocol;
 
 	err = 0;
-- 
2.43.0


