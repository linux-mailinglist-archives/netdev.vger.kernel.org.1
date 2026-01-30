Return-Path: <netdev+bounces-255256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHT5G+gdfWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:08:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE607BEB38
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AB0A306AEF6
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721C3876CC;
	Fri, 30 Jan 2026 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yB3UTr9A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56349387582
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806990; cv=none; b=Q0V9FXw8Ov5P3trrjedRwngIAcEkvIweQ9eHA6iCQPC3vsB+ZYEhd6ZoItDikr5dFiNbLiJusrnrzEhYhYJzRY9Djj+BKsz3wrQYtoE8zfOWGSFPBelysSCIhZm8Pqb3Zmiy8YZl+NQNCX9C3EZ1UZ4d+p1+0CSW+e2t3x3n1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806990; c=relaxed/simple;
	bh=gXab1LauaUn6K+8KT1b+U0Y8Jswet+BwL5W3UeeRbe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXdIdiMO0zQTmrO9LW9rPbUjmgMavlmbxGlk8PvZmhh/fMc8nJM3/gTFbhJm7y9hUqi5fHW693bxdPX6AiADtIga9opXmUmR5U56Q5THXdn4q5VFJ7VQXU5MLEkSzmZgVb36nDI5xXN4b0neJE9XFdof0a/IDav+otzVGXevxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yB3UTr9A; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c70fadd9a3so843951185a.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806988; x=1770411788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/GoSJhINDLed/7WD10AIxGT110SkCLncFEsNHScX1og=;
        b=yB3UTr9AzcYco6n5lGBIL+USAtaNj9flFVH6Ey2mZVg00qL63q3p7iJI1T1QTWAFW5
         d0l14p59pqcPCNh2ZoOtJ+wEHW8shCpBg6XOi4o9cZmYKsIkLw0S+iVpMUF4D+z7JtWS
         Lom4N4EArilHUus+vfxBrJgRPsZAk53cqZM7em8Yz8ldDZtdm+lSqyrdwXjsRrD7rceT
         MRt8UJwywgFcQyQtRdjFZyFrqyhe1uuyl9kKkNbEk4VhXUEmadSOrNjUJCn1lrAlyvYg
         UeBACTP6hXO88hv5B55neXFltxb5jU9tEqVoczau8ZLyyNpEk2tRWRqOlflanMY6d5S6
         sGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806988; x=1770411788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GoSJhINDLed/7WD10AIxGT110SkCLncFEsNHScX1og=;
        b=Pvy4zjVCI0mXJ7t7dIcdbgsmGk4hXODLjpzd/DigxPEp+a9mMgh2X6GteIsbsbQrRE
         pJzOvzmQ9qaa43UnxtZZQW7zS+k8BYNUicaLWA75jW8mZhL8KbVO0DQrZH3E2W416LuY
         SzhtPb9VYoUo7+/RGdopdsEavx2S/20DnRqjpsrAEJTsu41QxIOBvgzA89WdNBUFuws6
         tlb+uNETCdFCdM+fzh79ncxU8a4tlCrYu1M6txPRLcO1lZ6ys9X7cmlOtMaUcpJrGCR3
         mpsZchcErg0O1tWimkBRRyHvoBCmh9vTEqCn4Q22vfEnODVUG3TbYxxG3vS3RqtfWPvr
         fY9A==
X-Forwarded-Encrypted: i=1; AJvYcCVbb6TuPhNjOROziuhKzLpoSnMeQcpL1Emkcp0r07DOLivR2VHCqVL47/xQjz3SO+07xo2CEII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9wjiD2ivo6yCq69Cdfhb/gYhipMK5To4owOVDAYFnXgFLflZ
	VSNc8EEcx1H8xet2TVvVoloZGWRKpwvHuachVZyMNBDuBwh4L9+dgXWCMvFU26a4Juc0YavFqLs
	CUOHlFx+BjSUVJg==
X-Received: from qknqv11.prod.google.com ([2002:a05:620a:8acb:b0:8b2:fb0b:e690])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f05:b0:82e:ef43:38f0 with SMTP id af79cd13be357-8c9eb0f87b5mr556064485a.0.1769806988089;
 Fri, 30 Jan 2026 13:03:08 -0800 (PST)
Date: Fri, 30 Jan 2026 21:02:57 +0000
In-Reply-To: <20260130210303.3888261-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130210303.3888261-3-edumazet@google.com>
Subject: [PATCH net-next 2/8] ipv6: add some unlikely()/likely() clauses in ip6_output.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255256-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE607BEB38
X-Rspamd-Action: no action

1) daddr is unlikely a multicast in ip6_finish_output2().

2) ip6_finish_output_gso_slowpath_drop() should not be called often.

3) ip6_fragment() should not be called often.

4) opt is unlikely to be set.

5) ip6_xmit() and ip6_forward() mostly sends not too big packets.

6) Most __ip6_make_skb() calls are for UDP packets,
   not ICMPV6 ones.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index e4bed95ae5bba173c2418d402cba46e946335219..5c2cfcc3cf6e56192123c5830250865d37e72581 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -80,7 +80,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	hdr = ipv6_hdr(skb);
 	daddr = &hdr->daddr;
-	if (ipv6_addr_is_multicast(daddr)) {
+	if (unlikely(ipv6_addr_is_multicast(daddr))) {
 		if (!(dev->flags & IFF_LOOPBACK) && sk_mc_loop(sk) &&
 		    ((mroute6_is_socket(net, skb) &&
 		     !(IP6CB(skb)->flags & IP6SKB_FORWARDED)) ||
@@ -179,8 +179,8 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
+	if (unlikely(!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
+	    !skb_gso_validate_network_len(skb, mtu)))
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -202,8 +202,8 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 	if (skb_is_gso(skb))
 		return ip6_finish_output_gso(net, sk, skb, mtu);
 
-	if (skb->len > mtu ||
-	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
+	if (unlikely(skb->len > mtu ||
+	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size)))
 		return ip6_fragment(net, sk, skb, ip6_finish_output2);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -301,7 +301,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		}
 	}
 
-	if (opt) {
+	if (unlikely(opt)) {
 		seg_len += opt->opt_nflen + opt->opt_flen;
 
 		if (opt->opt_flen)
@@ -354,7 +354,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	skb->mark = mark;
 
 	mtu = dst_mtu(dst);
-	if ((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb)) {
+	if (likely((skb->len <= mtu) || skb->ignore_df || skb_is_gso(skb))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 		/* if egress device is enslaved to an L3 master device pass the
@@ -654,7 +654,7 @@ int ip6_forward(struct sk_buff *skb)
 	if (mtu < IPV6_MIN_MTU)
 		mtu = IPV6_MIN_MTU;
 
-	if (ip6_pkt_too_big(skb, mtu)) {
+	if (unlikely(ip6_pkt_too_big(skb, mtu))) {
 		/* Again, force OUTPUT device used as source address */
 		skb->dev = dev;
 		icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
@@ -1368,7 +1368,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	/*
 	 * setup for corking
 	 */
-	if (opt) {
+	if (unlikely(opt)) {
 		if (WARN_ON(v6_cork->opt))
 			return -EINVAL;
 
@@ -1885,7 +1885,7 @@ static void ip6_cork_steal_dst(struct sk_buff *skb, struct inet_cork_full *cork)
 static void ip6_cork_release(struct inet_cork_full *cork,
 			     struct inet6_cork *v6_cork)
 {
-	if (v6_cork->opt) {
+	if (unlikely(v6_cork->opt)) {
 		struct ipv6_txoptions *opt = v6_cork->opt;
 
 		kfree(opt->dst0opt);
@@ -1941,7 +1941,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	__skb_pull(skb, skb_network_header_len(skb));
 
 	final_dst = &fl6->daddr;
-	if (opt) {
+	if (unlikely(opt)) {
 		if (opt->opt_flen)
 			proto = ipv6_push_frag_opts(skb, opt, proto);
 		if (opt->opt_nflen)
@@ -1969,7 +1969,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
-	if (proto == IPPROTO_ICMPV6) {
+	if (unlikely(proto == IPPROTO_ICMPV6)) {
 		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
 		u8 icmp6_type;
 
-- 
2.53.0.rc1.225.gd81095ad13-goog


