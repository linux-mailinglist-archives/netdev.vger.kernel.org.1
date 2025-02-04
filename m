Return-Path: <netdev+bounces-162538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC60A2733A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB847A4CCC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26BA21ADC6;
	Tue,  4 Feb 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKZcT+w3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73121ADAE
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675460; cv=none; b=R6P8dzMHxrTg9tQRwN4F8tgVdpkv6RxeKnoEwEOLIfquYIgiS4mr1Cccv0/PiX/aUgRtRjm355ug6hauvp4ILSDkaANn1ooqdYNmC0Xg35qebzHBCnYPzdXJgyegNHHeKVvvCKAJBxqKOkCii5Md01iwh5Vbrdg1/PITp6YoYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675460; c=relaxed/simple;
	bh=U2kX53Sg+dT2QzomNtvGlbWRO8/OdC8wBUIn0TCpjBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dIujO+gL2y5t0uataApECPxRzlTRppfpZ3gM+9v33hZ1tXmMat8wOj/p6GYexx5RqnKDKmnm3uXueoUcUG1sifszRqAFBrJ2uNGDnOjM+UcE5wakTq+w8Zk5lVjf0St5AgArEPDUtN9BLWKL2PYDIm8SsDFQi9Z/fOng5AXHnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKZcT+w3; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467a4f0b53bso193816041cf.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675458; x=1739280258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zszYcJFJYdWef4gkJGhQ49R4MBi7sue+kr7ORa+aE30=;
        b=kKZcT+w3/rCfgHdN7v4kBBS/p24eP5PtBOms9U/3u8p3ews6jRcoET/OS810uT/qkW
         KT+Oj5ocWItshGqXIMpofGCRjaom+Xx6SYO9agjh+I7hp6JfCwsguwfeIzWlRQTWzaZW
         r763M0QDlpZkLnLtOiGthuwXe2Ur1HSByL9ol/42+hEyCLGv3iXnGiMnAQ31kR/9p/63
         1hAnHkypMG7F9/eboUSSwkQNGiOYR64fPG+KBcJ10+Pe6dmNjaiQR21kkRXeVjwP+BkG
         oWe/CwSlnQYbLgT9iu8EY1O+ryKaEYTzvLl75gAMBUcizSTW3x1+x9MGSkcKt9pOGdCf
         zYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675458; x=1739280258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zszYcJFJYdWef4gkJGhQ49R4MBi7sue+kr7ORa+aE30=;
        b=xIENuPm+wFG7SY3yLx5gh6h8SXIELtikj6I1zhwsYa5FNCainYpB6ceVO+W6hQOzmu
         dAlb7vZvG8LaH0iMtZI3RyLhIKlHW+y+ABVs/J8nHDxZx5OlXq/V61u9wUBtZt4/oPXL
         ++efBiIO4iXGkw8cagxBNpJPQ//TdNVUOCsKJHgdNT7N0mab5X28r6aI7sCnxU5ycK6s
         pFCWKegFWtYR0PMHOID6P7VUXOC7VD/IY1WLfAEG9WGeAhoJeEP+eTBpIz7PUIOMXHAB
         zw/Ne6Ricdm+Y5kcybQGeeZG6gre2K9M0tUiaLykFE6Bb9f7eDYzdHF0lhrpx+RU0ZfK
         RlVw==
X-Gm-Message-State: AOJu0YxrU4jmLRL02aN46YVsfCjZ6bOJO9RODbXlYcPtlocA6EMAjE9V
	JtCTIm9OOGSDm7r2/llyRE/ZV672BzjNIrRqcIUeITNf4sOqRFz9QnSmwJY+5mzyDEVC9vuilav
	44hkPeTPRzg==
X-Google-Smtp-Source: AGHT+IGc0brTd9OtU/ApZWduYdhIppkzehxQs9pstbdqDrSeAPGOFVHhRukbcE1mnkFe0Sn9oCPmDXjEnfz+zA==
X-Received: from qtbfy14.prod.google.com ([2002:a05:622a:5a0e:b0:467:975e:1ead])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:181e:b0:467:6486:beea with SMTP id d75a77b69052e-46fd0b6dfb7mr411721781cf.38.1738675457921;
 Tue, 04 Feb 2025 05:24:17 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:51 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-11-edumazet@google.com>
Subject: [PATCH v3 net 10/16] ipv6: icmp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icmp6_send() must acquire rcu_read_lock() sooner to ensure
the dev_net() call done from a safe context.

Other ICMPv6 uses of dev_net() seem safe, change them to
dev_net_rcu() to get LOCKDEP support to catch bugs.

Fixes: 9a43b709a230 ("[NETNS][IPV6] icmp6 - make icmpv6_socket per namespace")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/icmp.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a6984a29fdb9dd972a11ca9f8d5e794c443bac6f..4d14ab7f7e99f152cd5f5adaa023f0280957f275 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -76,7 +76,7 @@ static int icmpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	/* icmpv6_notify checks 8 bytes can be pulled, icmp6hdr is 8 bytes */
 	struct icmp6hdr *icmp6 = (struct icmp6hdr *) (skb->data + offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	if (type == ICMPV6_PKT_TOOBIG)
 		ip6_update_pmtu(skb, net, info, skb->dev->ifindex, 0, sock_net_uid(net, NULL));
@@ -473,7 +473,10 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	if (!skb->dev)
 		return;
-	net = dev_net(skb->dev);
+
+	rcu_read_lock();
+
+	net = dev_net_rcu(skb->dev);
 	mark = IP6_REPLY_MARK(net, skb->mark);
 	/*
 	 *	Make sure we respect the rules
@@ -496,7 +499,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		    !(type == ICMPV6_PARAMPROB &&
 		      code == ICMPV6_UNK_OPTION &&
 		      (opt_unrec(skb, info))))
-			return;
+			goto out;
 
 		saddr = NULL;
 	}
@@ -526,7 +529,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	if ((addr_type == IPV6_ADDR_ANY) || (addr_type & IPV6_ADDR_MULTICAST)) {
 		net_dbg_ratelimited("icmp6_send: addr_any/mcast source [%pI6c > %pI6c]\n",
 				    &hdr->saddr, &hdr->daddr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -535,7 +538,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	if (is_ineligible(skb)) {
 		net_dbg_ratelimited("icmp6_send: no reply to icmp error [%pI6c > %pI6c]\n",
 				    &hdr->saddr, &hdr->daddr);
-		return;
+		goto out;
 	}
 
 	/* Needed by both icmpv6_global_allow and icmpv6_xmit_lock */
@@ -582,7 +585,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	np = inet6_sk(sk);
 
 	if (!icmpv6_xrlim_allow(sk, type, &fl6, apply_ratelimit))
-		goto out;
+		goto out_unlock;
 
 	tmp_hdr.icmp6_type = type;
 	tmp_hdr.icmp6_code = code;
@@ -600,7 +603,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	dst = icmpv6_route_lookup(net, skb, sk, &fl6);
 	if (IS_ERR(dst))
-		goto out;
+		goto out_unlock;
 
 	ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 
@@ -616,7 +619,6 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		goto out_dst_release;
 	}
 
-	rcu_read_lock();
 	idev = __in6_dev_get(skb->dev);
 
 	if (ip6_append_data(sk, icmpv6_getfrag, &msg,
@@ -630,13 +632,15 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		icmpv6_push_pending_frames(sk, &fl6, &tmp_hdr,
 					   len + sizeof(struct icmp6hdr));
 	}
-	rcu_read_unlock();
+
 out_dst_release:
 	dst_release(dst);
-out:
+out_unlock:
 	icmpv6_xmit_unlock(sk);
 out_bh_enable:
 	local_bh_enable();
+out:
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(icmp6_send);
 
@@ -679,8 +683,8 @@ int ip6_err_gen_icmpv6_unreach(struct sk_buff *skb, int nhs, int type,
 	skb_pull(skb2, nhs);
 	skb_reset_network_header(skb2);
 
-	rt = rt6_lookup(dev_net(skb->dev), &ipv6_hdr(skb2)->saddr, NULL, 0,
-			skb, 0);
+	rt = rt6_lookup(dev_net_rcu(skb->dev), &ipv6_hdr(skb2)->saddr,
+			NULL, 0, skb, 0);
 
 	if (rt && rt->dst.dev)
 		skb2->dev = rt->dst.dev;
@@ -717,7 +721,7 @@ EXPORT_SYMBOL(ip6_err_gen_icmpv6_unreach);
 
 static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct sock *sk;
 	struct inet6_dev *idev;
 	struct ipv6_pinfo *np;
@@ -832,7 +836,7 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 				   u8 code, __be32 info)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct inet6_protocol *ipprot;
 	enum skb_drop_reason reason;
 	int inner_offset;
@@ -889,7 +893,7 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 static int icmpv6_rcv(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct net_device *dev = icmp6_dev(skb);
 	struct inet6_dev *idev = __in6_dev_get(dev);
 	const struct in6_addr *saddr, *daddr;
@@ -921,7 +925,7 @@ static int icmpv6_rcv(struct sk_buff *skb)
 		skb_set_network_header(skb, nh);
 	}
 
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_INMSGS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INMSGS);
 
 	saddr = &ipv6_hdr(skb)->saddr;
 	daddr = &ipv6_hdr(skb)->daddr;
@@ -939,7 +943,7 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 	type = hdr->icmp6_type;
 
-	ICMP6MSGIN_INC_STATS(dev_net(dev), idev, type);
+	ICMP6MSGIN_INC_STATS(dev_net_rcu(dev), idev, type);
 
 	switch (type) {
 	case ICMPV6_ECHO_REQUEST:
@@ -1034,9 +1038,9 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 csum_error:
 	reason = SKB_DROP_REASON_ICMP_CSUM;
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_CSUMERRORS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_CSUMERRORS);
 discard_it:
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_INERRORS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INERRORS);
 drop_no_count:
 	kfree_skb_reason(skb, reason);
 	return 0;
-- 
2.48.1.362.g079036d154-goog


