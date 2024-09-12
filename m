Return-Path: <netdev+bounces-127709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA853976273
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEDEB23838
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 07:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1086F18BB86;
	Thu, 12 Sep 2024 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DYP5jAsn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799A188598
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125435; cv=none; b=QuKoNZ0QGczHC7s4bWjyHU0XC/VbMrxBE54pO8V788NFvH+YY3RE5dtd5BwmslvscA5En7XH18UMuWpkaY4iJgP0iV3baNZDe+P67OpuWTj/aSV3tg+XJ3Hn27z2TT+ySCR2ludOXfxIk+2Z0vhS+VFKFwXyQ9D7IfBEhPl0Y6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125435; c=relaxed/simple;
	bh=8wrhh9zO+IOIiRT1Tc8hptVoqoDpX7vb4PV5hO9B2lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z//72AzZTbG/k9k2KGi4wrwSLRxnyoZVECh5rzzCqdX+kmOcWsVvl4+Uqk3jM03RCkBgFA2KA6pqIhXvQ3mCMcnLe6Z5H5LbyAwnbeusXDRki+ibLYzw/4CtHzLtdj5YM4OykKgffjSIVDE6xkKH9I8h7Krrw34Af6HgEy50jtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DYP5jAsn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9DF6F3F31D
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 07:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726125430;
	bh=yLNtSqSUcGh901eDSIADJN9Uf8pd4Z89WuxSzdAhfHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=DYP5jAsnCHYjCpivUBUgkVHHlr1R0XUcOXUeSvrtbdkSeXjyEC25AgtAJ9XbhW9eL
	 /ivomWHdP3DglCnnU6xcsKZ6gXViFYfrtr11qD2lnocrYYpvwzLcmv7+QH/1Y51QKC
	 Q3sl3h+BrTAsvicXSwLrOk5u3UYsDDJmyl4Ub8k5LrOqCf8vIlAmNCFKghe5BRRodt
	 mHT01S2PDcR/ocB0ypXcvjf7jEdKMVQF/bIJp3AUDBYGpL9TVds0LePnlo8l9oTvl7
	 4uIIy+d+vdst2LyCq9JfvrknKbxQgYD6l8I4aya/OhKnzQPJj3N71PEDcr0nmeZqR0
	 42eAljG8+BChA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fd6d695662so10944435ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 00:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726125429; x=1726730229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLNtSqSUcGh901eDSIADJN9Uf8pd4Z89WuxSzdAhfHg=;
        b=iFIyJ5DWjNnafJIeajgfTm9kH8cqIwpv6VaR0lo4AmDY5r+hkdTkQCWE9J+Xntt0Gr
         Ss/hbJRF1wKRUO12al3LCOSrugvTGbu4hs7R84+HhsiC9UGu/qEjH4eq+pd8xmL6OLhz
         GuE0GUgdIDY1cAKHmm5eg+hWyNxeV1DUZYefXal4BkitwJ9pyuy7OqkOL1SkNkcZz2KJ
         CzcNFeXaY5ZOR6jtp6a2Di3kRa9FKvtB7TkMhI6l0aeLp2s7903/Dz5Fx2FsSnYcQ5aF
         DfbRdZY1Z5yMdLUVFLt+BYFHJciY6+8LpDqQBVbDVf1ufNa/FSxpfFptg8+nsXHifUW7
         pUXw==
X-Gm-Message-State: AOJu0YyTEpAfEz5qsGNFplpLzYHFyhcd0NYlZkgcqi/ucPfkwS3PbAQy
	MEfv+r2U98oK2j/d0LFAMYnQaYcmMj/KpvbQfpakPjRPktFOBVgiKghC/tOIZZOBOLeyMGxwhga
	nwNAqUx2Cv3zgKaFu75ivdqizyXP8+hd6Pwa5/YHlB3xzADYRdqC1hn3VR7RBG0fFWPdKCQ==
X-Received: by 2002:a17:903:18f:b0:205:810a:190a with SMTP id d9443c01a7336-2076e305f90mr32810795ad.2.1726125429096;
        Thu, 12 Sep 2024 00:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEht7kfrwcB9dSSIld1WoYxq0KheqQr6Rm0A0E/7K78AVLKkI58Ko0dsXyBvg489CW657ptVA==
X-Received: by 2002:a17:903:18f:b0:205:810a:190a with SMTP id d9443c01a7336-2076e305f90mr32810445ad.2.1726125428657;
        Thu, 12 Sep 2024 00:17:08 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af47662sm9275685ad.93.2024.09.12.00.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:17:08 -0700 (PDT)
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
Subject: [PATCH ipsec v2] xfrm: check MAC header is shown with both skb->mac_len and skb_mac_header_was_set()
Date: Thu, 12 Sep 2024 15:17:02 +0800
Message-ID: <20240912071702.221128-1-en-wei.wu@canonical.com>
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
Changes in v2:
* Change the title from "xfrm: avoid using skb->mac_len to decide if mac header is shown"
* Remain skb->mac_len check
* Apply fix on ipv6 path too
---
 net/xfrm/xfrm_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 749e7eea99e4..eef0145c73a7 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -251,7 +251,7 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	if (skb->mac_len)
+	if (skb->mac_len && skb_mac_header_was_set(skb))
 		eth_hdr(skb)->h_proto = skb->protocol;
 
 	err = 0;
@@ -288,7 +288,7 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
 
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
-	if (skb->mac_len)
+	if (skb->mac_len && skb_mac_header_was_set(skb))
 		eth_hdr(skb)->h_proto = skb->protocol;
 
 	err = 0;
-- 
2.43.0


