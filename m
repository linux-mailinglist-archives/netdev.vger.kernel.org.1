Return-Path: <netdev+bounces-257632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIfUH+cmhmlSKAQAu9opvQ
	(envelope-from <netdev+bounces-257632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:37:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B571012D8
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A00D3062424
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26E423A80;
	Fri,  6 Feb 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxrxzGSF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3E426692
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399289; cv=none; b=dIFaQVdCbn7WITBWWgnfErtgWCqIbbz5IvGY74jFYFQg+PxPm4dW1rHaJRpCviYxIoJjNgWwVtzk9fxDWA+IuqTtj8DcSCngj1mXYmkUzGF2RB+a4TBCaGJU5nakDFyXZeXMnzyCzETsWEOFZjc0PNBLLyTBgO/P4e0pnKnqWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399289; c=relaxed/simple;
	bh=QP4RWBEkq4WlI0fGc5Y6UghIWySCxpN1HC1wni0hKAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XBhe2ENEwOhzuS7sZ5JoTaSgeVY4ymc0yE2iNefKO1LizsTyRJJv0pWVs6H/dfdb+CRvEb27dEgxK+irN9Pm0hLMtk7ALf8D8dVcuXhO0qL/ZggcSFT/svpQ8y6pNnPoM05/a5+rsZK8T348Ez5hjaaGXMG9D/DwaJQ8pX4Odgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxrxzGSF; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-894a861fd7cso34960186d6.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770399288; x=1771004088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c//bZww2Xrje+/Gt43mIICYVH84oIzPngzflKSwD0pY=;
        b=dxrxzGSF9IbLvI9clnxbkkoTLXVbCcd991EYwE6EWYcjpAnXqdQ/zTwieW29mOWvB5
         DKjLYZp1UcZ44RsNANYM5B2JHdAoLDL/w/x7TJBIGuc5jQQubVXcE5sZPRU/9CUks/xI
         4gARbsexw/AN9IhP0wOMZVjpRw/pGx1i6hJkKzD1uV+yenOwqQPhuRSclsdCqtZvSszQ
         vhwXCd1ein8cd9sXG6HKJiYHyHSaACzzqTKB4OSXU/Nvv6For4LoPzl1EYkEo/S4hXrI
         AAC2pfKVdKP/idSMFWopDoMepgsNuWK6MLIjbgrxymE6N1gxf7q3+bXVwygzgf4gPmab
         CE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399288; x=1771004088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c//bZww2Xrje+/Gt43mIICYVH84oIzPngzflKSwD0pY=;
        b=ldTpdA4nCkoV0NSsy1uiXqm976zH8m79ALyBfhw4x+P6Nu6AKwwfpQuZ95LYEL8Ovf
         gTZJtdP2tpRfSWfvpZnEkFKZLNOOo7I6OvjBU8q4M5vwjon064lxeG5LgLMA1oFKSrjJ
         55bAxIROtmEVQMWXuOozkCwbQ8uWDuyhPXHmnd/VsqezQwlxduWIk8TCb7cblwH9Xtgh
         NYWSxpYTbhtvGNKC0lKpdWDcJtjVJCGy8MLhHaipf0cGOKY7WB8nIUPKdP5XqwNeORxi
         XkVK0uwUOFIcfz5HFI4fGzFj8wCSL9RMQrPRLVvVivA84a/xNcLD63mDR1tZs8T4Bq/Q
         U2zA==
X-Forwarded-Encrypted: i=1; AJvYcCUflCwGeGRIjpFwwXSlLo+rtxz4lwFwDj2VbT6gx4VOXqsYIVI5MrREmUJoJs65XaI3fePzf9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6YYp9mcpcf+HtNXTYVXLirLrdyLJdq1Fv6bEaUq12g24mw59y
	uz4wC9CKLqVMi2f6MIMAT34Huxqz+GwmpuelP2NvBlynP1WJLynfzd053nvnP49AY+QET3nJHpm
	G2Weda6O4SEurow==
X-Received: from qkbec26.prod.google.com ([2002:a05:620a:485a:b0:8ca:3170:e839])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4443:b0:8ca:d5cb:6835 with SMTP id af79cd13be357-8caf0961045mr460634785a.48.1770399287680;
 Fri, 06 Feb 2026 09:34:47 -0800 (PST)
Date: Fri,  6 Feb 2026 17:34:23 +0000
In-Reply-To: <20260206173426.1638518-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206173426.1638518-5-edumazet@google.com>
Subject: [PATCH net-next 4/7] ipv6: inet6_csk_xmit() and inet6_csk_update_pmtu()
 use inet->cork.fl.u.ip6
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257632-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6B571012D8
X-Rspamd-Action: no action

Convert inet6_csk_route_socket() to use np->final instead of an
automatic variable to get rid of a stack canary.

Convert inet6_csk_xmit() and inet6_csk_update_pmtu() to use
inet->cork.fl.u.ip6 instead of @fl6 automatic variable.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/inet6_connection_sock.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index e30172e634a64d85cc774d1cdcad1ee36c1f7e7a..03e307d5b6b9a2085b1e6b3e3c743795aa16879c 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -60,7 +60,7 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 {
 	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct in6_addr *final_p, final;
+	struct in6_addr *final_p;
 	struct dst_entry *dst;
 
 	memset(fl6, 0, sizeof(*fl6));
@@ -77,7 +77,7 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
 	rcu_read_lock();
-	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &final);
+	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
 
 	dst = __sk_dst_check(sk, np->dst_cookie);
@@ -92,12 +92,12 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 
 int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl_unused)
 {
+	struct flowi6 *fl6 = &inet_sk(sk)->cork.fl.u.ip6;
 	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct flowi6 fl6;
 	struct dst_entry *dst;
 	int res;
 
-	dst = inet6_csk_route_socket(sk, &fl6);
+	dst = inet6_csk_route_socket(sk, fl6);
 	if (IS_ERR(dst)) {
 		WRITE_ONCE(sk->sk_err_soft, -PTR_ERR(dst));
 		sk->sk_route_caps = 0;
@@ -109,9 +109,9 @@ int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl_unused
 	skb_dst_set_noref(skb, dst);
 
 	/* Restore final destination back after routing done */
-	fl6.daddr = sk->sk_v6_daddr;
+	fl6->daddr = sk->sk_v6_daddr;
 
-	res = ip6_xmit(sk, skb, &fl6, sk->sk_mark, rcu_dereference(np->opt),
+	res = ip6_xmit(sk, skb, fl6, sk->sk_mark, rcu_dereference(np->opt),
 		       np->tclass, READ_ONCE(sk->sk_priority));
 	rcu_read_unlock();
 	return res;
@@ -120,13 +120,15 @@ EXPORT_SYMBOL_GPL(inet6_csk_xmit);
 
 struct dst_entry *inet6_csk_update_pmtu(struct sock *sk, u32 mtu)
 {
-	struct flowi6 fl6;
-	struct dst_entry *dst = inet6_csk_route_socket(sk, &fl6);
+	struct flowi6 *fl6 = &inet_sk(sk)->cork.fl.u.ip6;
+	struct dst_entry *dst;
+
+	dst = inet6_csk_route_socket(sk, fl6);
 
 	if (IS_ERR(dst))
 		return NULL;
 	dst->ops->update_pmtu(dst, sk, NULL, mtu, true);
 
-	dst = inet6_csk_route_socket(sk, &fl6);
+	dst = inet6_csk_route_socket(sk, fl6);
 	return IS_ERR(dst) ? NULL : dst;
 }
-- 
2.53.0.rc2.204.g2597b5adb4-goog


