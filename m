Return-Path: <netdev+bounces-53018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B88011F2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA3EB20FB8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626594E619;
	Fri,  1 Dec 2023 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="X8ZvwL7B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B382103
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:43:17 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a338dfca7so13927536d6.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701452596; x=1702057396; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbX2X80nmyjZX82rv/r7YFYgyku+kUEoXFmQeyn/H7Y=;
        b=X8ZvwL7BMXHp9Sbo9kVdeGBTJAMfweMWYRyy9FPtSowLQwQ0dT+mYADrFdkYorLI6e
         mXX1y8ECbcv3/lEe2G8XH7VvfuuGMQjS4N097L8Oy8Ebpeyoy+Cmcc0fHhb0qWT2G6Yf
         ilmbJfUB8XDwXADTFFx9SucMHsm/1HnXectlx2LfEK0/ltqr4FBYYpm1Shd7ic6jbwyy
         861/Mfcw6V8ylUptlqUsXVsae/ge6oQGn1TrnUwfUdV+w82MaX5R/csvtF0+43vgDa0B
         QXPZCp83ByN9PU6lG+/qKHoSQ3sv8lmwPSSoluShw5VoLlCxXcOIMcoYccey6LkRuXzw
         9pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452596; x=1702057396;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbX2X80nmyjZX82rv/r7YFYgyku+kUEoXFmQeyn/H7Y=;
        b=N6m18cAHmFYWP4GOtn7K9NudXnJ4vFXAMQVdhEEQw4IUlLZEzbaOEEDQSJ3BVUNXGd
         YEEAV+yPAtCrx+rI9YbCpryy7bvgf/ZYEuBAyc9S7rgYcLaFY9LHSVcxCDNa0PxWh5PK
         qX20mDiq/x4dTDxaOKW1D21spaoH5mw2RvV7qgcrgXHewyGVgk5TpzcbuFZIOr20vFnr
         z//QYMRExQnbSnS1bOJ8lPGF6lHE4kqJ5zCoklVC+QWWWSX1mVg0tihcsiRA5s1Nzfe3
         yHWJFKbUAoxY/SyNO0UnT4tZsOKqdLwRg13+F7XhGmoPc+beZaGZ/YMOHgAtkkVjeliE
         wg3w==
X-Gm-Message-State: AOJu0YyTwg089iQpMm8NcVPBZy7TScvkZHcn4TQzz1nlDM/0QaDSXY9i
	AZ1BP8Z01/+Mn9XTGdRCUrYd3niZg1TWoBSIvjdykQ==
X-Google-Smtp-Source: AGHT+IGu4Er+xeVXSE1h8is2v9BrjwsKZ9cQMUM1k6ZT00jp5F62wWeWZY8MJe82t7LpGeQcJ8Hm+Q==
X-Received: by 2002:a05:6214:518a:b0:67a:9895:3aeb with SMTP id kl10-20020a056214518a00b0067a98953aebmr3093893qvb.53.1701452595831;
        Fri, 01 Dec 2023 09:43:15 -0800 (PST)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id k7-20020a0cabc7000000b0067a3e703e3asm1702786qvb.37.2023.12.01.09.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:43:15 -0800 (PST)
Date: Fri, 1 Dec 2023 09:43:13 -0800
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Weongyo Jeong <weongyo.linux@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Brouer <jesper@cloudflare.com>
Subject: [PATCH v2 net-next] packet: add a generic drop reason for receive
Message-ID: <ZWobMUp22oTpP3FW@debian.debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
from consume_skb to kfree_skb to improve error handling. However, this
could bring a lot of noises when we monitor real packet drops in
kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
can be freed, not actual packets.

Adding a generic drop reason to allow distinguish these "clone drops".

[1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/
Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/net/dropreason-core.h |  6 ++++++
 net/packet/af_packet.c        | 22 +++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3c70ad53a49c..278e4c7d465c 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -86,6 +86,7 @@
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
 	FN(TC_ERROR)			\
+	FN(PACKET_SOCK_ERROR)		\
 	FNe(MAX)
 
 /**
@@ -378,6 +379,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_QUEUE_PURGE,
 	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
 	SKB_DROP_REASON_TC_ERROR,
+	/**
+	 * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket errors
+	 * after its filter matches an incoming packet.
+	 */
+	SKB_DROP_REASON_PACKET_SOCK_ERROR,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a84e00b5904b..0a7c05d8fe9f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2128,6 +2128,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	int skb_len = skb->len;
 	unsigned int snaplen, res;
 	bool is_drop_n_account = false;
+	enum skb_drop_reason drop_reason = SKB_CONSUMED;
 
 	if (skb->pkt_type == PACKET_LOOPBACK)
 		goto drop;
@@ -2161,6 +2162,10 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
 		goto drop_n_restore;
+
+	/* skb will only be "consumed" not "dropped" before this */
+	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
+
 	if (snaplen > res)
 		snaplen = res;
 
@@ -2227,10 +2232,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	if (!is_drop_n_account)
-		consume_skb(skb);
-	else
-		kfree_skb(skb);
+	kfree_skb_reason(skb, drop_reason);
 	return 0;
 }
 
@@ -2253,6 +2255,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	bool is_drop_n_account = false;
 	unsigned int slot_id = 0;
 	int vnet_hdr_sz = 0;
+	enum skb_drop_reason drop_reason = SKB_CONSUMED;
 
 	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
 	 * We may add members to them until current aligned size without forcing
@@ -2355,6 +2358,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			vnet_hdr_sz = 0;
 		}
 	}
+
+	/* skb will only be "consumed" not "dropped" before this */
+	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
+
 	spin_lock(&sk->sk_receive_queue.lock);
 	h.raw = packet_current_rx_frame(po, skb,
 					TP_STATUS_KERNEL, (macoff+snaplen));
@@ -2498,10 +2505,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	if (!is_drop_n_account)
-		consume_skb(skb);
-	else
-		kfree_skb(skb);
+	kfree_skb_reason(skb, drop_reason);
 	return 0;
 
 drop_n_account:
@@ -2510,7 +2514,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	is_drop_n_account = true;
 
 	sk->sk_data_ready(sk);
-	kfree_skb(copy_skb);
+	kfree_skb_reason(copy_skb, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2


