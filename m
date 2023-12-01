Return-Path: <netdev+bounces-53071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9124D8012D0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D8A282137
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD164E63F;
	Fri,  1 Dec 2023 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="No22P4L6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE4D115
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:32:12 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77dccb3e4baso131593385a.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701455530; x=1702060330; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Se/ndXves5QyU7Kd280hY/G6mHiTGvbKyzTsON38FZU=;
        b=No22P4L6P1iS9ITmJEbjSAWcVeab1tl7nwKTrLCbs07zyPDUBnxSP/F9oUyRN4tgAb
         T3b2W9syUFy6895BsrxB1rqzpwjGsg9WO3Jv4Ah8k3bw6aYvHFfbFTDoe+y68fGTMaDn
         Gv7UjtVboCPIAvHEs87QFpbyAhWrNGNb6WE5utsSd2K6WNDQjNxyHNkjz5IW2FDoIagq
         MoTZqgRXNeeKkMnri5sI1pKdcBYb0UCsBkKy5OPrvrbeAVLsgpDJisa7niEoWrN7Jh3+
         bFwYMrTVva5FJcaCkgJ56zK1tTjkpOlGPi6QW2VrQcNaX5GgMam4qFPUZv4i383QzggB
         VVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455530; x=1702060330;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se/ndXves5QyU7Kd280hY/G6mHiTGvbKyzTsON38FZU=;
        b=K0fQhfHgVdJJkKbqh6Kfncs8Va5G4Py/Ymh8zne78djZmoXiPpOpd299SizrBuApWj
         FVltBnwpQ4f4cK2P9UoGl8hnq6KoC1QOdOdKmN+x9LhSEUn0kj6gA8T8plw3zjObtpiE
         RGk0siVbsjv/CozEBod0kehFE7ooF6Z5j1KWFF2246DZ/hc5Ns+mknEGePkaQ1BjaJlS
         in0aoWoGdnSx5tA+D/h1E16N4pNyLlGtohZ4JWJKitLLkKD24MG5GRcOhL+l5+QFrwOS
         +q2VO76qA6OurRBFFThcCdZra2+mA6mEwRvwLS9Djmzi5nexloBigY+LBApPdSaqzpsC
         GKWA==
X-Gm-Message-State: AOJu0YwGS41sgYC7KWzzE/du5ujENA4fTMbYeB76M/XooOaSg8aKbz+9
	iwJNl5dLjl4NvprKktgwtHC065ZQQvcc0QVoDhw2gg==
X-Google-Smtp-Source: AGHT+IEORihJJKsAMzeOeQM8u2jHMsSKGu9LdqcLRQi3/cRqmmvv7uNzqgzA+49cC7jpM0CFJ15QCQ==
X-Received: by 2002:a05:620a:430c:b0:77a:4606:7541 with SMTP id u12-20020a05620a430c00b0077a46067541mr28920720qko.56.1701455530565;
        Fri, 01 Dec 2023 10:32:10 -0800 (PST)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id pr1-20020a05620a86c100b0077d7cfde46csm1718926qkn.106.2023.12.01.10.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:32:10 -0800 (PST)
Date: Fri, 1 Dec 2023 10:32:08 -0800
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Weongyo Jeong <weongyo.linux@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Brouer <jesper@cloudflare.com>
Subject: [PATCH v3 net-next] packet: add a generic drop reason for receive
Message-ID: <ZWomqO8m4vVcW+ro@debian.debian>
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
v2->v3: removed an unused variable
v1->v2: fixups suggested by Eric Dumazet
v2: https://lore.kernel.org/netdev/ZWobMUp22oTpP3FW@debian.debian/
v1: https://lore.kernel.org/netdev/ZU3EZKQ3dyLE6T8z@debian.debian/
---
 include/net/dropreason-core.h |  6 ++++++
 net/packet/af_packet.c        | 26 +++++++++++++-------------
 2 files changed, 19 insertions(+), 13 deletions(-)

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
index a84e00b5904b..933fdfaacc44 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2127,7 +2127,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	u8 *skb_head = skb->data;
 	int skb_len = skb->len;
 	unsigned int snaplen, res;
-	bool is_drop_n_account = false;
+	enum skb_drop_reason drop_reason = SKB_CONSUMED;
 
 	if (skb->pkt_type == PACKET_LOOPBACK)
 		goto drop;
@@ -2161,6 +2161,10 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	res = run_filter(skb, sk, snaplen);
 	if (!res)
 		goto drop_n_restore;
+
+	/* skb will only be "consumed" not "dropped" before this */
+	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
+
 	if (snaplen > res)
 		snaplen = res;
 
@@ -2217,7 +2221,6 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 
 drop_n_acct:
-	is_drop_n_account = true;
 	atomic_inc(&po->tp_drops);
 	atomic_inc(&sk->sk_drops);
 
@@ -2227,10 +2230,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
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
 
@@ -2250,9 +2250,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct sk_buff *copy_skb = NULL;
 	struct timespec64 ts;
 	__u32 ts_status;
-	bool is_drop_n_account = false;
 	unsigned int slot_id = 0;
 	int vnet_hdr_sz = 0;
+	enum skb_drop_reason drop_reason = SKB_CONSUMED;
 
 	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
 	 * We may add members to them until current aligned size without forcing
@@ -2355,6 +2355,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
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
@@ -2498,19 +2502,15 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
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
 	spin_unlock(&sk->sk_receive_queue.lock);
 	atomic_inc(&po->tp_drops);
-	is_drop_n_account = true;
 
 	sk->sk_data_ready(sk);
-	kfree_skb(copy_skb);
+	kfree_skb_reason(copy_skb, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2


