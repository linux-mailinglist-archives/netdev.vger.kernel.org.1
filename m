Return-Path: <netdev+bounces-201548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBCAE9D92
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016143AA079
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F54B2E11BF;
	Thu, 26 Jun 2025 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="meheOvcp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782DA2E11A7
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941267; cv=none; b=OsaIgV/4n261pTs87qg9yt2LT5/et7tFDEJ/QWFyY809A7QUbDPn8TnAdXnWEK1/K7WRP9Wt36jCgDWQHQ90gL0pBY5q0RqJk3gbKGkRW55yUq35z9vQ80gGqiLvxWJ80/Kz1/My2Ef8fCcNyh4R4V5x2mdJHC6kGo5E/UNMYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941267; c=relaxed/simple;
	bh=NO32gC+M4+BmKdQiYJIUR2+yGQVQ25+Ve+Vbf/3uJ9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eUgBoMBsOU4A4mb7nTNMXMdeOsKzmruLDjlgXkXyNkdVTzXzo7e0UwAVJJQypKPuMrf/x1WXN/JAnxrLJUyZ4QW4J5kWPjzLl5pOGUAdAq6Ke0i1cQEc1lcoiW0dGtbjVfBnpb3BmA3ffxYoDpxKWvgfz+2NHnPz9yd9M6agsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=meheOvcp; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d099c1779dso128422585a.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750941264; x=1751546064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfKox8f/wTe+eC1RirGH/VIzuIjDtwcucHF7Q8nUM+Y=;
        b=meheOvcp11sz92DeqqkFN2vf5JuHX0V3OL8TyVYHNlzDhXvlSBxbNE6SWid+CQMDjN
         eatfPQbKspkHpu0wSMOPFiaDfZMi8B3mkgXZxzQ5bylM0hHcoysyypMpqygzikgUQRDX
         qTxajPz2PxVR7sIXONBhqWQ+uNORGQqh/m6oVgcmdCIyhsr64PVY7pEaUFCo4R0mu3Wg
         35PRQ4OG9FFGtr/1k/y6fnsmIeFI3AqgPz5NdkM9Vqh6J7POsBvCThcSTJsOVGQNXGv2
         Y/hcDM7RynxiHHrNVCrRcebTfoKHf6s2qNL7DMgOnUoUxZ/9by8WTcIqz449IrvkR3BJ
         jdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750941264; x=1751546064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfKox8f/wTe+eC1RirGH/VIzuIjDtwcucHF7Q8nUM+Y=;
        b=ip9lNvMCdXLvpiPvZB55llHhOUYS9tZjpGgH/lpfa6x01ZpUDUKxr+IPA+CLq1ilLX
         cdjht6TSnUcYxoO19cEtYbdS4jwaU2w2MPrlxoCg3WHqsOFofoIxrORJYJ3TdP2wNaHn
         HpeIYzsy5yNboGtmVv3vozFTwGoexJ0MX3VcLp3y+q+PJOGz/nGixO1MN9yGh94zjI9D
         SS0n/Elqjm2R0tmzQ4DSYuRfNRcC2fWPjzHNrljgQ+Q4mSAdsxZRKBgvoO0racpCIrlG
         ZdUyQ4TOG4oUYwz0J3QXySrOIMqT7g1ua7XPTorUGIi535/OVTSnbObZSVA91FXoQPlB
         uS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoTlnSDU2OO8NUCTaRhOxHSAyLpTZwBxYji2vnPC1JqtcyPXGYsaswVg6EL2WZj4o6pkiK3hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzmi4rCkq3XrDVBADt4m4Kfm6/sWPvZpK9RJ+KfjpH1lO9vxr4
	au3AGSY85RsKtEMlNCucVEbIuHfnWZdpMvMyZD+nCCFrNXIzKRuDtGrnqCI3ibBHpFRV66ytFav
	XHUBrb7dv5TtTLg==
X-Google-Smtp-Source: AGHT+IHwbfhfAOIw/aK89fYtqwirUGw0aV4JsbYZog8PPVz+AEu/wkJ4TroiccRvqT934j8Ss6WqTnSycs0PPg==
X-Received: from qknpo3.prod.google.com ([2002:a05:620a:3843:b0:7ce:bf03:df81])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:278f:b0:7d3:8dc9:f438 with SMTP id af79cd13be357-7d4296ee5a2mr862786685a.17.1750941263672;
 Thu, 26 Jun 2025 05:34:23 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:34:19 +0000
In-Reply-To: <20250626123420.1933835-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626123420.1933835-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626123420.1933835-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: fix tcp_ofo_queue() to avoid including too
 much DUP SACK range
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, "xin.guo" <guoxin0309@gmail.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

From: "xin.guo" <guoxin0309@gmail.com>

If the new coming segment covers more than one skbs in the ofo queue,
and which seq is equal to rcv_nxt, then the sequence range
that is duplicated will be sent as DUP SACK, the detail as below,
in step6, the {501,2001} range is clearly including too much
DUP SACK range, in violation of RFC 2883 rules.

1. client > server: Flags [.], seq 501:1001, ack 1325288529, win 20000, length 500
2. server > client: Flags [.], ack 1, [nop,nop,sack 1 {501:1001}], length 0
3. client > server: Flags [.], seq 1501:2001, ack 1325288529, win 20000, length 500
4. server > client: Flags [.], ack 1, [nop,nop,sack 2 {1501:2001} {501:1001}], length 0
5. client > server: Flags [.], seq 1:2001, ack 1325288529, win 20000, length 2000
6. server > client: Flags [.], ack 2001, [nop,nop,sack 1 {501:2001}], length 0

After this fix, the final ACK is as below:

6. server > client: Flags [.], ack 2001, options [nop,nop,sack 1 {501:1001}], length 0

[edumazet] added a new packetdrill test in the following patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: xin.guo <guoxin0309@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 19a1542883dfba7211e08dcb44c82b4564d76f04..79e3bfb0108fd4e21de2295e879fbd521daa62f9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4845,8 +4845,9 @@ static void tcp_ofo_queue(struct sock *sk)
 
 		if (before(TCP_SKB_CB(skb)->seq, dsack_high)) {
 			__u32 dsack = dsack_high;
+
 			if (before(TCP_SKB_CB(skb)->end_seq, dsack_high))
-				dsack_high = TCP_SKB_CB(skb)->end_seq;
+				dsack = TCP_SKB_CB(skb)->end_seq;
 			tcp_dsack_extend(sk, TCP_SKB_CB(skb)->seq, dsack);
 		}
 		p = rb_next(p);
-- 
2.50.0.727.gbf7dc18ff4-goog


