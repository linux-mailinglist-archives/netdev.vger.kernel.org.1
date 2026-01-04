Return-Path: <netdev+bounces-246821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D15C4CF1535
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 22:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195083009814
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6572D46B2;
	Sun,  4 Jan 2026 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGcPYrkt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="njo3G3co"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E4405F7
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767562279; cv=none; b=fRkLuIckSAs1hMy4asrBzExB5Y1cGCFQHfvf5is0UkWglatt4p2TgLAdgiEs8dkj0/YvjWzsx1Ebo9wBLaAIk0nhJArTT6DY9wSkSoF2j/L4XKMJXXc8QFy+BUu2/el9HNR1vcT06dadhv5nONW7HeYG/ADC46yTUnMJHcyWjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767562279; c=relaxed/simple;
	bh=CQzhehrjJwu/lMVMDr53Ce6tdUpBldOvBQcYJ/T4mVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWQ8cC4tUbMhjCKU1IOIh5kW8tM19PmAXg+P+H6FPW0UGgnYFWLx59vW+s8KtwB0T/fI0bnEn8nuzIAHsx52CGxFNGXZKtAQmCOQWeTZUgPmk9WUqUEyxEp7v9AzUv11EU+IP1GYKtnVRvjFzzcWEizE/4C2Bepfm8FtP3XztJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGcPYrkt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=njo3G3co; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767562276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cg43aGbR3JXrsTgimA67mWZ0spasdKK0rUWLisHDo8Q=;
	b=GGcPYrkteQjdITlHjfrai5s/0vlglXgBwxhxRPukRFdrNTmD0eVcwELdVZ17KXLwTIkXNh
	wKc5Ph8AjGcXJCvVD/aDIWCeQw4VVWMoKdnefzzwipeNpvpCkx4pALl4Dl7467HjSFq4Bu
	Aye2H2q5bjeoBC7PqonsVoxtE7uYzdc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-bQ_5IPjaNk2JJyIQS6KCCw-1; Sun, 04 Jan 2026 16:31:15 -0500
X-MC-Unique: bQ_5IPjaNk2JJyIQS6KCCw-1
X-Mimecast-MFC-AGG-ID: bQ_5IPjaNk2JJyIQS6KCCw_1767562274
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso8159953f8f.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 13:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767562274; x=1768167074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg43aGbR3JXrsTgimA67mWZ0spasdKK0rUWLisHDo8Q=;
        b=njo3G3codgaoC4K934FwMtgm1oRIR+rH2cYhqygGjKfGn9R+FkKWoFQteZC2+4CMsl
         DyU6aJtfzCA/LFTrMIgS85XvMeUvhnpA3svp+5JnMBrqH+gORpGdfLREfaU2gOUvzUVa
         auDN+WzfC57SMeNWSYk1XR7pN6L+53O4Qx8Y+xm8EqHQoiH1nbJTAylrzkITOn83QJMc
         eeEEml/vEINHT/zCd6x+Od9a4nzYuWhsKr7dhl+/KUt8S26CvaLK+NszPqiWVWKwQ3hG
         sFiWKsy4ZXp/BHBPOiSlSzb0ps30W3o0uhbm1WQodWSHfS7vch0sfVuAqm/hwLVpt0cw
         Hh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767562274; x=1768167074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg43aGbR3JXrsTgimA67mWZ0spasdKK0rUWLisHDo8Q=;
        b=WYpoc233H+Ksqe1EEuCkUk1YfRNeTazP2f9MPlHeU3e41M8tgd4RM582U3rEMJ8svA
         itTCKuCLjAi+9cHImSroQxaSDHKP5eV12qs889Tve49s+KlAnEXxuhGTku0iV2FqrGZw
         fiFI0O2Uri1nY7j/liAtJ5bJ3goRQ2+J138bW+IrwIDLeFeJdN3krVqM72wvIR6Aoj5v
         PLTgBwPCFRTMjxzNh2lRmHzIrcdMKaPHP/27LWu0fZCjyeS9VODidrOTz/Y8v77X7r8v
         czLPS4WtTE2fM8ZRCKR88T+cFn+Y5svnHtONyu6Pf6cwcXjp80oK5R2GRSzmPu+sCd41
         AIlQ==
X-Gm-Message-State: AOJu0YyGNW1SGK0xZn/Q6ZLU6W6xZVGilbwBwSUB3PzeyDzy7RRUgIZC
	s+ehHCRXTdGoBfO3dRUnMzxnVQdQ/ytRQ7LwwHdi8v6GoQp/nfCSTs4pA/YZJOBYdiLjCvglrYG
	vES1bBz14yUbKd7+A9i1PQncnIlRgL1QDIiWrYkzamb1IQMSFcMcBOL2y7jhwkRdqFzzRiXzY84
	MVc4OGNp0Q1gJKdBgPlpNz0EdDiZwSSUsRaBt+Bg==
X-Gm-Gg: AY/fxX4tF9LHtXwhohs+aQb3gHGoIbph1POmIN4b9uXJntp0R6qYGxv4OpVdu/l4xiW
	Z7D2p7EkuWF/v+u+jFk/AazkOq+OnmyrEfNFsb2/JfZZys2CxMa8lzpK6mO/n3hWLW25s+nYD9u
	53DwfqfeytiwvmPDT1dDNoHBi2IZJYMCFyZvAgvm6Enl054RPWXj9bX1fF2gKkmRpvM/4/WthBl
	QxIK4iTCOTIv69d4tnyArnkTRuVjQ3gOCPvscGkgqS+rrXRSQiaOF6dddKiMyQCngswO8vwhYfb
	WUfaHx/4wBnzkxkCBBQ7Z5TymAzLVsVoSSH0UUHKMXdSbURXgqD4nG4H5lqmXfPkT3ou17sFlqW
	6YQN5m28UrgyQDVUChHkbU8Q=
X-Received: by 2002:a05:6000:40dd:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-4324e4bf6ccmr55463337f8f.2.1767562273679;
        Sun, 04 Jan 2026 13:31:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWmj0RO1WyfknVoPPHt1fISWz0kOATexMkMOf4QSR9WKRHRByFeywdJPrqTk/NmyrrsQ1YCA==
X-Received: by 2002:a05:6000:40dd:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-4324e4bf6ccmr55463309f8f.2.1767562273137;
        Sun, 04 Jan 2026 13:31:13 -0800 (PST)
Received: from fedora.redhat.com ([216.128.14.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82fa1sm93147789f8f.23.2026.01.04.13.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 13:31:12 -0800 (PST)
From: mheib@redhat.com
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kernelxing@tencent.com,
	kuniyu@google.com,
	atenart@kernel.org,
	aleksander.lobakin@intel.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net v3] net: fix memory leak in skb_segment_list for GRO packets
Date: Sun,  4 Jan 2026 23:31:01 +0200
Message-ID: <20260104213101.352887-1-mheib@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

When skb_segment_list() is called during packet forwarding, it handles
packets that were aggregated by the GRO engine.

Historically, the segmentation logic in skb_segment_list assumes that
individual segments are split from a parent SKB and may need to carry
their own socket memory accounting. Accordingly, the code transfers
truesize from the parent to the newly created segments.

Prior to commit ed4cccef64c1 ("gro: fix ownership transfer"), this
truesize subtraction in skb_segment_list() was valid because fragments
still carry a reference to the original socket.

However, commit ed4cccef64c1 ("gro: fix ownership transfer") changed
this behavior by ensuring that fraglist entries are explicitly
orphaned (skb->sk = NULL) to prevent illegal orphaning later in the
stack. This change meant that the entire socket memory charge remained
with the head SKB, but the corresponding accounting logic in
skb_segment_list() was never updated.

As a result, the current code unconditionally adds each fragment's
truesize to delta_truesize and subtracts it from the parent SKB. Since
the fragments are no longer charged to the socket, this subtraction
results in an effective under-count of memory when the head is freed.
This causes sk_wmem_alloc to remain non-zero, preventing socket
destruction and leading to a persistent memory leak.

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

Since skb_segment_list() is exclusively used for SKB_GSO_FRAGLIST
packets constructed by GRO, the truesize adjustment is removed.

The call to skb_release_head_state() must be preserved. As documented in
commit cf673ed0e057 ("net: fix fraglist segmentation reference count
leak"), it is still required to correctly drop references to SKB
extensions that may be overwritten during __copy_skb_header().

Fixes: ed4cccef64c1 ("gro: fix ownership transfer")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
v3:
 - Completely removed delta_truesize tracking.
 - Added DEBUG_NET_WARN_ON_ONCE assertions.
 - Updated commit message with historical context, KMEMLEAK trace, and
    clarification on why skb_release_head_state() is preserved.
v2:
 - Updated Fixes tag.
---
 net/core/skbuff.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a00808f7be6a..a56133902c0d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4636,12 +4636,14 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 {
 	struct sk_buff *list_skb = skb_shinfo(skb)->frag_list;
 	unsigned int tnl_hlen = skb_tnl_header_len(skb);
-	unsigned int delta_truesize = 0;
 	unsigned int delta_len = 0;
 	struct sk_buff *tail = NULL;
 	struct sk_buff *nskb, *tmp;
 	int len_diff, err;
 
+	/* Only skb_gro_receive_list generated skbs arrive here */
+	DEBUG_NET_WARN_ON_ONCE(!(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST));
+
 	skb_push(skb, -skb_network_offset(skb) + offset);
 
 	/* Ensure the head is writeable before touching the shared info */
@@ -4655,8 +4657,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 		nskb = list_skb;
 		list_skb = list_skb->next;
 
+		DEBUG_NET_WARN_ON_ONCE(nskb->sk);
+
 		err = 0;
-		delta_truesize += nskb->truesize;
 		if (skb_shared(nskb)) {
 			tmp = skb_clone(nskb, GFP_ATOMIC);
 			if (tmp) {
@@ -4699,7 +4702,6 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 			goto err_linearize;
 	}
 
-	skb->truesize = skb->truesize - delta_truesize;
 	skb->data_len = skb->data_len - delta_len;
 	skb->len = skb->len - delta_len;
 
-- 
2.52.0


