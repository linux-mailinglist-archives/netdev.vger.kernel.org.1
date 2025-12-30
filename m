Return-Path: <netdev+bounces-246307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCBCE92D1
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F0193085C65
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2992E27A47F;
	Tue, 30 Dec 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaIWxcn3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQCLzRkR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244328506F
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085889; cv=none; b=Y7M37XilQ6mvcuEj+WbXFH+RII/r8LTxEIeu7Sy1zXjy6gUY+5MrH3OZAo1FOyDlQXhgqdtLoNXlQc1Y/ajba0L5cUo6iPFfEXUIsJsRj00+CBTR/B4kyJ58FxxWBUA00vTkDzecLWv2TaFbY8fFxX6dH+mfPecNUqbN7qVomLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085889; c=relaxed/simple;
	bh=oYbu0tIYoHG1HcqoOg5987tLiqfGlRkg2cpMxO6DQ5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eR7VCWiqqNY1jlTOwKRmZWA0CUygwxTWtEq+KMghwavxWRVPB966b3fTDgUbmO8QDY0ioiQARhsWZQ3ZkO3q7rFSPlBBfrFpo3KcErOeBd9dyYNsXfsFNjvMtzFi2azjW1qnArVnBkHaf5kdhVGuqSsTN81oYctpG8zMF5lj5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaIWxcn3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQCLzRkR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767085886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tRbSF8f0CRS5s5qA6Hwt7UKsA1Pd5658S3WqT4XAkMw=;
	b=VaIWxcn3C/ncCId329zi+XJhpihn0oJymrjfqqfa9SZLTqyN/0FQBh46Or3mo/HAtCDj45
	oDSfbIsSSPFryrSAxchYcXgmUjAJZgMsfUWV2ZQwvTBi9V34YW14zABnMRcf9FbexdvsvT
	NP0+/D8652jaUqJ++Ul7DuJN7sMay8k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-MvODhlXYNnmRcycitjkgJw-1; Tue, 30 Dec 2025 04:11:24 -0500
X-MC-Unique: MvODhlXYNnmRcycitjkgJw-1
X-Mimecast-MFC-AGG-ID: MvODhlXYNnmRcycitjkgJw_1767085883
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso5714118f8f.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 01:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767085883; x=1767690683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRbSF8f0CRS5s5qA6Hwt7UKsA1Pd5658S3WqT4XAkMw=;
        b=hQCLzRkRtev12Di0xgzX44hmyTM6pBxx0VnhytC95XZVVGQz8RLELP9Is38RjgkYvf
         NBIHZGb/U+lMrX0OE2NBDnKMTyUZJDL3BLgYfB/MU8Yo80VxvnJ8ZF8VMvSrJBO+Zz3a
         ir9RRYPNsoOEHlSjVdGc88JEU8MWvHP8am5AYtzY6ehypcpM4izYMzj75+Uhym3PKHYb
         VLtkcdIz4mkfifYvHX9qFqn8QSV0aP03CfgzX4K07YcJmMKE5JZVMM2jWXQ08NSpUGaz
         ucThZxY6ABi2WFrE/Vk7eh5ihu+9FXOdETQtlt+JWk6FH+ps+/ox7J/2WOwXE+++hK2f
         kfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767085883; x=1767690683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRbSF8f0CRS5s5qA6Hwt7UKsA1Pd5658S3WqT4XAkMw=;
        b=dN1Vu+wl5Gb9pfOb0l72Hud5ICbdEM70iFsKbSrCTIFz8/W+uH6Y30rFMBk+cX5HWT
         OXPNPVuUztbIYr/FqPDdDFpgi3w8qa6y7rK8xg/muE9Ji4hpw7uziuo6cZESyUxt+h/m
         8vw5rCXsg06xHFMO8RP7BqMgN05sE6j8Pf25z0pSR+KGDKtJJJ3IaCnNda6UmIPzXX5J
         tX1JVeKPjhT/mmliZzM17JOZ7vmf7DZ6NXtL7Lv6f+HVjGyiuDd+ldsHIWkAXELyHglA
         Z6IJiHBotv+viRuWj+no0tkQ5noE6HA6oLttsEu3mHjXtwuV+rSc43tk1ahqXUZCP2cV
         IKew==
X-Gm-Message-State: AOJu0Yxwv2RJVF3TmOZc6OoBKT4661le5Vffk99+43EwYUZfxNsqLyAR
	tn7dsKLblPcamwwSJH4r/DRzTgmA7YsdcZ18gKzxuVJfTv0AT6zxJ4/9Is1BaJGoljRx51U9DGI
	98/HEHXXQ+UOP3lesdlDUx5HvfiJHThZNWj//0nS3zZSkN2Mpby4y3EFAcJxML5I1yFfK1NuLaV
	2HPJj9AyRTJI3qsG2V6HG5NjxvFLj/b1lddSlXBg==
X-Gm-Gg: AY/fxX76E+nfXxAb5DvrCnEMnKfp7VOKcWRIbGI6FFM88soAL4+5nVnjXkBitLjnoBT
	O3GUL6QZ3Tm9O5xx//CXVVa93JK9RXaX+H8smTIHWnmGNhBMDXbUW3d3RIkO9ijdWFRGyEv8hdB
	De5mzEus4gLxjjZospbsmZPSp2ULiYUJ+EfP1OknEfv9cs12/Hs2BN6IZeNpxgHQ6X7COT8CiYE
	f+z+kkJuPFKHuGdZO+4JXPbwKfNCyfzCovhF0vWVEe/VP2o0+MpnWOrNxAci9ZkFvP/+oBwXSQX
	bkB3uH/u2hmDBiqpsciWFW+QB7C41lGpsxRp8VZEf/zOW8ggXsaTT3cx72inG6OE+pSZ4yOPGND
	n7fFOX/vQHDhPT7rxoA7WHQ==
X-Received: by 2002:a05:6000:2089:b0:430:f449:5f0e with SMTP id ffacd0b85a97d-4324e4c8efemr35353602f8f.16.1767085883163;
        Tue, 30 Dec 2025 01:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdNYgq3F70FSOCwWlfqAm5cdcGEoQq9Bv+aBqDM/sO/SPrYcJ0XLBNRD0UwPM8Om/8YUCh1g==
X-Received: by 2002:a05:6000:2089:b0:430:f449:5f0e with SMTP id ffacd0b85a97d-4324e4c8efemr35353565f8f.16.1767085882656;
        Tue, 30 Dec 2025 01:11:22 -0800 (PST)
Received: from fedora.redhat.com ([216.128.14.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432613f7e6esm56933907f8f.21.2025.12.30.01.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 01:11:22 -0800 (PST)
From: mheib@redhat.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kernelxing@tencent.com,
	kuniyu@google.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net] net: skbuff: fix truesize and head state corruption in skb_segment_list
Date: Tue, 30 Dec 2025 11:11:07 +0200
Message-ID: <20251230091107.120038-1-mheib@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

When skb_segment_list is called during packet forwarding through
a bridge or VXLAN, it assumes that every fragment in a frag_list
carries its own socket ownership and head state. While this is true for
GSO packets created by the transmit path (via __ip_append_data), it is
not true for packets built by the GRO receive path.

In the GRO path, fragments are "orphans" (skb->sk == NULL) and were
never charged to a socket. However, the current logic in
skb_segment_list unconditionally adds every fragment's truesize to
delta_truesize and subsequently subtracts this from the parent SKB.

This results a memory accounting leak, Since GRO fragments were never
charged to the socket in the first place, the "refund" results in the
parent SKB returning less memory than originally charged when it is
finally freed. This leads to a permanent leak in sk_wmem_alloc, which
prevents the socket from being destroyed, resulting in a persistent memory
leak of the socket object and its related metadata.

The leak can be observed via KMEMLEAK when tearing down the networking
environment:

unreferenced object 0xffff8881e6eb9100 (size 2048):
  comm "ping", pid 6720, jiffies 4295492526
  backtrace:
    kmem_cache_alloc_noprof+0x5c6/0x800
    sk_prot_alloc+0x5b/0x220
    sk_alloc+0x35/0xa00
    inet6_create.part.0+0x303/0x10d0
    __sock_create+0x248/0x640
    __sys_socket+0x11b/0x1d0

This patch modifies skb_segment_list to only perform head state release
and truesize subtraction if the fragment explicitly owns a socket
reference. For GRO-forwarded packets where fragments are not owners,
the parent maintains the full truesize and acts as the single anchor for
the memory refund upon destruction.

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 net/core/skbuff.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a00808f7be6a..aee9be42409b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4641,6 +4641,7 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *nskb, *tmp;
 	int len_diff, err;
+	bool is_flist = !!(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST);
 
 	skb_push(skb, -skb_network_offset(skb) + offset);
 
@@ -4656,7 +4657,15 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 		list_skb = list_skb->next;
 
 		err = 0;
-		delta_truesize += nskb->truesize;
+
+		/* Only track truesize delta if the fragment is being orphaned.
+		 * In the GRO path, fragments don't have a socket owner (sk=NULL),
+		 * so the parent must maintain the total truesize to prevent
+		 * memory accounting leaks.
+		 */
+		if (!is_flist || nskb->sk)
+			delta_truesize += nskb->truesize;
+
 		if (skb_shared(nskb)) {
 			tmp = skb_clone(nskb, GFP_ATOMIC);
 			if (tmp) {
@@ -4684,7 +4693,12 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 
 		skb_push(nskb, -skb_network_offset(nskb) + offset);
 
-		skb_release_head_state(nskb);
+		/* For GRO-forwarded packets, fragments have no head state
+		 * (no sk/destructor) to release. Skip this.
+		 */
+		if (!is_flist || nskb->sk)
+			skb_release_head_state(nskb);
+
 		len_diff = skb_network_header_len(nskb) - skb_network_header_len(skb);
 		__copy_skb_header(nskb, skb);
 
-- 
2.52.0


