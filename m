Return-Path: <netdev+bounces-89916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4478AC2E3
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 05:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983B61F20F25
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C0D52E;
	Mon, 22 Apr 2024 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WorXnl0D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB16AB8;
	Mon, 22 Apr 2024 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754897; cv=none; b=UDJg8cqX8NyjbfI7FpXC0265vyFxncQaP0ZobBGeVK1LdcdtttfcF3LjeZJg0gUq66cZxBTZOoy6wLwKwHphGR2uLfYTHaklcLIkd85E36pb6UOXqdI7Qw4Bq5RWKDMsx+W2muAuMyHlxhAj6RFJSjNM9UEqcfrz1TC4zLqf6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754897; c=relaxed/simple;
	bh=k0ERIGBUgeH1hzUQytdBB0A2E1f9gLeaMQ8795U1+Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAWvdFuZ9P7m0coQKon6Gay/El2Yb63MDsmfxo9tDlaPMx6wB0ymvNqNCQdILf2u4OVM3afXyOt41gi/GsyL/Nwyh4CGaTo8XNpduJzRyJd6oQqeEqZ2KqYfQ+dJbHwmhcHNSFAqf7c65SFSHi9DJ0Zhs0gH8+T7CcL9BRyNn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WorXnl0D; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3c9300c65so33160015ad.0;
        Sun, 21 Apr 2024 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754895; x=1714359695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCngxkU1s9o07re7lCIfglS+wHbbPf9d21EG5EVN+Mc=;
        b=WorXnl0DdQYlmNioTwULqsZGbR8k9rIl//H5a64x9DMhGT11dW2k0Ka7dLeB93UBO3
         pH8rmTODfP03aN1ODLR5D1tT23PNJ1oH7pEU56i12OywfhTqLN377xaVdmIWY2BL8cbS
         7tfb9Ssu65/rUrDeUUiNju1kGb3GyWBAaY1lnzwlnzS7DY9DCAR3QskUiVDvD5Rc0oj8
         jjqQLtAwIguKeBUo1FfIg0oXDCzMvPD3FYYR0WIMHgkWbajMiv+ucRWydAPDnwihU2/P
         Pa/plGHH+CSwgoep8hmCt1ZMItYL8W0JlGrLB7/9yemunB9Wp+AchVXTmuSywW+kbqIi
         PGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754895; x=1714359695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCngxkU1s9o07re7lCIfglS+wHbbPf9d21EG5EVN+Mc=;
        b=wk/GX+OrscwhZxcz+GSz+dKHyTm1UEOuSVGoHvqNIJAZUOuSJgYD7BP1NEA0HMTnSe
         0odFR1Yc0cMAegRlmkR3IxP0FS8e1l4EyfIibScQ3BfKty10b0FZQBXeoXPlRBgNCqbI
         zryfaCjWVpSdtGYm1R4HQm4IKVl8LydnEA/kxMdgYeJw8oTeezYJzPqsa4J2hzbfMwLP
         lUTMYwNWnRcA1bm0BubfxkbbKgblkYgz/ZrwhYW1JMvOkfagq4HJ6LquwSKGsHZMX/9e
         jD4tWYVms9aCH5NeHV2sKKOTsqVlCKnd1JSTtu7ysyYVgjxUJ1yM9UfiP4jE9VrhsPu0
         5tjA==
X-Forwarded-Encrypted: i=1; AJvYcCXk/vLmo5SXKhIiEk43vVX0vBftGFDxCt3NlQlY/zlzsh4mNwsjJJ2JCFdhSce2h6qfx1Lvn11tl6t4g0+uCRkSMLlOfcx5KTrARxihIpeYUBmGeyyein+/PZdxIPYGn4L+uwj+SOeYsUcB
X-Gm-Message-State: AOJu0YzLRCpnKm/IfDU7zOsvcQo3UEt4ysOQvVe7Q2mxxyvpjZqGeysh
	0gKI3xOnjHbE74DoiQjE+0/zFVTY9M6eR9djsu29yaV3ZzNV+WDf
X-Google-Smtp-Source: AGHT+IHFrBQ6LpYbYQDtrmuEM6FLFdib/x3xhL+60q54S/e5KhAUcWqxvXJEMLq5A42vH4XJeJ/GXA==
X-Received: by 2002:a17:902:f547:b0:1e7:d482:9e09 with SMTP id h7-20020a170902f54700b001e7d4829e09mr9853379plf.7.1713754895401;
        Sun, 21 Apr 2024 20:01:35 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:34 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v7 4/7] tcp: support rstreason for passive reset
Date: Mon, 22 Apr 2024 11:01:06 +0800
Message-Id: <20240422030109.12891-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240422030109.12891-1-kerneljasonxing@gmail.com>
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Reuse the dropreason logic to show the exact reason of tcp reset,
so we can finally display the corresponding item in enum sk_reset_reason
instead of reinventing new reset reasons. This patch replaces all
the prior NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 net/ipv6/tcp_ipv6.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 418d11902fa7..06f8a24801b2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v4_send_reset(rsk, skb, convert_dropreason(reason));
 discard:
 	kfree_skb_reason(skb, reason);
 	/* Be careful here. If this function gets more complicated and
@@ -2278,7 +2278,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v4_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v4_send_reset(nsk, skb,
+						  convert_dropreason(drop_reason));
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -2357,7 +2358,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v4_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(NULL, skb, convert_dropreason(drop_reason));
 	}
 
 discard_it:
@@ -2409,7 +2410,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v4_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v4_send_reset(sk, skb, convert_dropreason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 017f6293b5f4..d8c74e90698b 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1680,7 +1680,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 reset:
-	tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	tcp_v6_send_reset(sk, skb, convert_dropreason(reason));
 discard:
 	if (opt_skb)
 		__kfree_skb(opt_skb);
@@ -1865,7 +1865,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		} else {
 			drop_reason = tcp_child_process(sk, nsk, skb);
 			if (drop_reason) {
-				tcp_v6_send_reset(nsk, skb, SK_RST_REASON_NOT_SPECIFIED);
+				tcp_v6_send_reset(nsk, skb,
+						  convert_dropreason(drop_reason));
 				goto discard_and_relse;
 			}
 			sock_put(sk);
@@ -1942,7 +1943,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 bad_packet:
 		__TCP_INC_STATS(net, TCP_MIB_INERRS);
 	} else {
-		tcp_v6_send_reset(NULL, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(NULL, skb, convert_dropreason(drop_reason));
 	}
 
 discard_it:
@@ -1998,7 +1999,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		tcp_v6_send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		tcp_v6_send_reset(sk, skb, convert_dropreason(drop_reason));
 		inet_twsk_deschedule_put(inet_twsk(sk));
 		goto discard_it;
 	case TCP_TW_SUCCESS:
-- 
2.37.3


