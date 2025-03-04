Return-Path: <netdev+bounces-171462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17ADA4D04D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D155C7A0FDE
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2440C33C9;
	Tue,  4 Mar 2025 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0jBQxJY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47342AE97
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049082; cv=none; b=DSkMnbmEyMMmYTxPfSHpxREN/I3z/f8sViHobBdESqBilh2vCUcy9zqFjoaJCmGhx1z9OqdloJiebe4a7HZkcBQ52wsFMOYzqSqR2G3dWf8s5ger+s406BliAg1W5xUiIFp4cIQid4FktKE5o2CPICfgDlXqtOnsn8FPNWKXTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049082; c=relaxed/simple;
	bh=EY1i8YfBx2P/OlPXguYON8pLPDLRAJ+WvNp3iJIOQdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jIt2u11B/c+KcEhIYsvJ7lTbuMfMQ0IQF28xTGy5qgiKCzMgUPGMv0jtO7QpT2X1wqy2JbO44wTZjMXgTRouFRvFEsBtOaysNS6/yICwyjVled/IYnK5tz3m59dYhKgsNFjqk6pJ3n4VGNUT8X3s6NGm90iAEObMJB9YIc/+sIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0jBQxJY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234daaf269so69323135ad.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 16:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741049080; x=1741653880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKQkk6rNLvrCjSW4oCi2m0sDBh5VbSHvMwJxlLliEbY=;
        b=a0jBQxJYmCA2/cG4FHwTXuDSldjDkQ5oU8gbUj/Bjujqb9C1dUpW7+iseQ3SDEEMIt
         FTyPEzr+dt4eyfYHVBeKAsk3wwpgp2QkOvdQq7HSQvg7Q1Nf2bnO4RamjlBaSBNxfwsT
         twf12KGFFRWNqqDF0NU8W+FSFJStCTOyqRHLGh6bOVT7K2zoy7eFRk2qqcXPUI7Y4Q5s
         WPYYkLgMd3ZQmVMmnrnRP4wVx6VHYpArvekmKXOi7TVQSqzk6JsZDirh+F11fqpkNP3h
         7Wxg0Vj6vNOR/ul2gphpsmvgLBLt9qODYCv0KGSUDwn5a4MGd+vshQEB5n2SDwQOmoOy
         uinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741049080; x=1741653880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKQkk6rNLvrCjSW4oCi2m0sDBh5VbSHvMwJxlLliEbY=;
        b=gj8d6QmmoTKirSMRFGPNq3oOoGIv1n7MPSfsnhpunurC3tIkpvroWVcwW5dJ8b4TzY
         iBci+oJn4fmJIjSRu2z27u0gFGvbYzwlNop1DypWqeoczTwZId7qbhVFpb+AAhk+/1gL
         DIzUwTAZ7VuW5/7ad58Gy8QPc0hzqFdfipHGuHM4FocCxujbuuw3Rh2JGmZIBMhIFegE
         qfrnLqwhzPa1NOObWr/EH4bLqJ4BonHEQSmXxWlCtHidFIz6GHb2G4ws9TRrofRL1wOo
         cYolhRnxt7p0ZhVlWO1ujbTiWIRK+Q2K6TC6sHagO1E1pymOE5EKiV4Wxho8jP6BBzR+
         qAYg==
X-Gm-Message-State: AOJu0Yzds8OQXAL9oijXXzKuxfJxlUoFSY/wt3t1bZ31isge8w7Zyj00
	LNrqC6ziAB8eGugSF6y8V5OQEflJII/6G2CqkqdLJGbQSklMpLHR
X-Gm-Gg: ASbGnctlmuQKGEREuJFoYgLBCbctXOqXhXbBX8POYV7I7df5Q2w/DjtoOLIzoIwHQzT
	f6G2SldgD5kEnSvmXhxLG8DElsRYSnoetdpwiy/i0RDRdsdGVehLpCFj7YTKlzHln4da87rCNtQ
	ZRp7IKvONCsjc9jYWTAgOsh2Cl/irRjtM1L7U97HajCbKYocYE6h+fw0aBIYxUdw0qu1M3BrKio
	H2JTKFASd4H8Rlz5nlgVU08vDh5K35mWwceY3/MGiy/tCDGzbzB6ioLwga0mHsGHcDFbG/mHl7m
	sQpkz+1uUyiswoVxIHowpfwOsOb1WzKj3zua1oAGk5ht2Ig9GIr02Dq+q0tEC93zSLkEnaEVhSo
	RmmUWE04=
X-Google-Smtp-Source: AGHT+IEmI5eEyMy5UCLSaQNeIsgCocS85VfDp9op9yMfUzlg28AuxEVWv934ewcr1a+i5vH7S6R94A==
X-Received: by 2002:a05:6a00:1395:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-73634a28a41mr17885531b3a.24.1741049079792;
        Mon, 03 Mar 2025 16:44:39 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48858sm9859459b3a.51.2025.03.03.16.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:44:39 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	kuniyu@amazon.com,
	dsahern@kernel.org,
	willemb@google.com,
	willemdebruijn.kernel@gmail.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net v2] net-timestamp: support TCP GSO case for a few missing flags
Date: Tue,  4 Mar 2025 08:44:29 +0800
Message-Id: <20250304004429.71477-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I read through the TSO codes, I found out that we probably
miss initializing the tx_flags of last seg when TSO is turned
off, which means at the following points no more timestamp
(for this last one) will be generated. There are three flags
to be handled in this patch:
1. SKBTX_HW_TSTAMP
2. SKBTX_BPF
3. SKBTX_SCHED_TSTAMP
Note that SKBTX_BPF[1] was added in 6.14.0-rc2 by commit
6b98ec7e882af ("bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback")
and only belongs to net-next branch material for now. The common
issue of the above three flags can be fixed by this single patch.

This patch initializes the tx_flags to SKBTX_ANY_TSTAMP like what
the UDP GSO does to make the newly segmented last skb inherit the
tx_flags so that requested timestamp will be generated in each
certain layer, or else that last one has zero value of tx_flags
which leads to no timestamp at all.

Fixes: 4ed2d765dfacc ("net-timestamp: TCP timestamping")
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
v2
Link: https://lore.kernel.org/all/20250228164904.47511-1-kerneljasonxing@gmail.com/
1. remove unnecessary parentheses
2. adjust commit log
3. target net branch
4. add Fixes tag
---
 net/ipv4/tcp_offload.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..2dfac79dc78b 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -13,12 +13,15 @@
 #include <net/tcp.h>
 #include <net/protocol.h>
 
-static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
+static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
 			   unsigned int seq, unsigned int mss)
 {
+	u32 flags = skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
+	u32 ts_seq = skb_shinfo(gso_skb)->tskey;
+
 	while (skb) {
 		if (before(ts_seq, seq + mss)) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_SW_TSTAMP;
+			skb_shinfo(skb)->tx_flags |= flags;
 			skb_shinfo(skb)->tskey = ts_seq;
 			return;
 		}
@@ -193,8 +196,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	th = tcp_hdr(skb);
 	seq = ntohl(th->seq);
 
-	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
-		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
+	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP))
+		tcp_gso_tstamp(segs, gso_skb, seq, mss);
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
-- 
2.43.5


