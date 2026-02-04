Return-Path: <netdev+bounces-256764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIW/HtN1g2mFmwMAu9opvQ
	(envelope-from <netdev+bounces-256764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:37:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6408EA595
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCD863051855
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617042F068C;
	Wed,  4 Feb 2026 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3BG/bUE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141582D061B
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222638; cv=none; b=KZr7VQ5yoRPqTYZFTNGQlU13S/pvy1Jqz+2QH8zL742j0AyfR3eL39vDwAPvUTh6G2eXNYxXnSVSm5Gai7cJLCzgUFDUcym2xMMNtM0in6IIjIgJka2kBMhnSvhm/tSvuFIHPL/09Pu/s5a7pdq8KjKAqNuCICBFQKQhUHNzbzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222638; c=relaxed/simple;
	bh=ljusHhYew9UX9U88QokVmA3WLr60lUQyhJuT/P1++Lk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K0FzpEP36i1fwukLAGTL2z8CyRr2qBVeXLbbCW284n/MXBT1yxZW0aySaOFORCB4KYy2GyvL9GIaV8derwyvzCAwskny9QL21871v/wkRQjDwirNKTZzgOh/wUnzwmvoIGexGNP47nESOdQG0GMuipthdCuVC+6qwBr1BHcBUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3BG/bUE; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5014b22d678so405331cf.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 08:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770222637; x=1770827437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vI6nAk9GKIRaCIG/V3pg1epMkn+/SqlNMe8sYio9wEM=;
        b=o3BG/bUEQ//nbjZKGU/LLXxml6wIm5XEPbKFZ0k+XAP8aZ4lbv2N+N+epajtav/B5i
         ElxlBaa2TwCHaAmhu8KiYkVlc/JFiOTbD9wwptgtaNwVAQnABjM1ppbf/sVNxvvSMzUc
         H6h6WHNY08UG5KV96XOfRO1GF46t0btwcJgxzFj0Z8H/GlbLUqpOTPGeRFDAV8itQsQc
         LtCljGev5LGkVkI09iByJMUAaDz0MieoJwVYLgMcjIbPpzyHgf81lRdgbZjF/X8bL3Tp
         rNHNLTMTUEsQZDr3FqtF9eOdlH2MmF7Dq/aPKT4zWIB2cKaHDsUWsNgSOX7ErvGv77s8
         gsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222637; x=1770827437;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vI6nAk9GKIRaCIG/V3pg1epMkn+/SqlNMe8sYio9wEM=;
        b=Ta0GGJLTjZmxtQuY3QCmELE6HRBdLEFonbmWGlPbPmxoKIYN/XZK3H2UEGRAT+oH11
         SB3tMX6q3eadekGYnbFHV+DV+tkwxI0jBeaOVwWSiSmV1PZhtJskzHsx3yBFekNM4bdK
         SVLaxmFYqTju6pRI1YQ9Dv8qGe6pVLdA2vgmyZPhYpwEN4SL5+8U8JZ4suYIecCEoN9R
         4PTwNyj88aec10lZKacFmVpQigmGND9vBnc3DmwQQo0gXgjg9zPKMqIj85rRNumbass7
         jaAxSuXWie7or7uxBS/SuU0S1IqeRUQVRt08mo1gHCtb1Uc2kOIfMYQE8Hmmp0pc/LT3
         qixA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ90RrDAZqgMr4yMjwI4j4umciEo4MeoGLzuNP+vaHNEr3zpWuoQkc579aD3GOl6z0Wi/udtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHP1KU5BDNFLccJ5ePSD2U3Da7JsfWDsIgxlIAX/DsWeTElRS4
	/ug8Xtvx3gyNFTG40JgFrHuW078O7YA4EVqYVV/QwW1XV9CFjx8uvchbrewLfGzOKKVdZlhfdGH
	4Hmad1aTsEWVceA==
X-Received: from qtg27.prod.google.com ([2002:a05:622a:d1b:b0:501:45c9:19d7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a0e:0:b0:4ee:428e:bf0f with SMTP id d75a77b69052e-5061c0c7563mr45094781cf.2.1770222636930;
 Wed, 04 Feb 2026 08:30:36 -0800 (PST)
Date: Wed,  4 Feb 2026 16:30:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204163035.4123817-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: change inet6_sk_rebuild_header() to use inet->cork.fl.u.ip6
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256764-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6408EA595
X-Rspamd-Action: no action

TCP v6 spends a good amount of time rebuilding a fresh fl6 at each
transmit in inet6_csk_xmit()/inet6_csk_route_socket().

TCP v4 caches the information in inet->cork.fl.u.ip4 instead.

This patch is a first step converting IPv6 to the same strategy:

Before this patch inet6_sk_rebuild_header() only validated/rebuilt
a dst. Automatic variable @fl6 content was lost.

After this patch inet6_sk_rebuild_header() also initializes
inet->cork.fl.u.ip6, which can be reused in the future.

This makes inet6_sk_rebuild_header() very similar to
inet_sk_rebuild_header().

Also remove the EXPORT_SYMBOL_GPL(), inet6_sk_rebuild_header()
is not called from any module.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
CC: Matthieu Baerts <matttbe@kernel.org>
---
 net/ipv6/af_inet6.c | 57 +++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index bd29840659f34b5754a182303d2871c5f884dfce..0476dbc8edb2b8273fd337b15c8196e9597753ef 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -824,45 +824,42 @@ EXPORT_SYMBOL(inet6_unregister_protosw);
 int inet6_sk_rebuild_header(struct sock *sk)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct inet_sock *inet = inet_sk(sk);
+	struct in6_addr *final_p, final;
 	struct dst_entry *dst;
+	struct flowi6 *fl6;
 
 	dst = __sk_dst_check(sk, np->dst_cookie);
+	if (dst)
+		return 0;
+
+	fl6 = &inet->cork.fl.u.ip6;
+	memset(fl6, 0, sizeof(*fl6));
+	fl6->flowi6_proto = sk->sk_protocol;
+	fl6->daddr = sk->sk_v6_daddr;
+	fl6->saddr = np->saddr;
+	fl6->flowlabel = np->flow_label;
+	fl6->flowi6_oif = sk->sk_bound_dev_if;
+	fl6->flowi6_mark = sk->sk_mark;
+	fl6->fl6_dport = inet->inet_dport;
+	fl6->fl6_sport = inet->inet_sport;
+	fl6->flowi6_uid = sk_uid(sk);
+	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
-	if (!dst) {
-		struct inet_sock *inet = inet_sk(sk);
-		struct in6_addr *final_p, final;
-		struct flowi6 fl6;
-
-		memset(&fl6, 0, sizeof(fl6));
-		fl6.flowi6_proto = sk->sk_protocol;
-		fl6.daddr = sk->sk_v6_daddr;
-		fl6.saddr = np->saddr;
-		fl6.flowlabel = np->flow_label;
-		fl6.flowi6_oif = sk->sk_bound_dev_if;
-		fl6.flowi6_mark = sk->sk_mark;
-		fl6.fl6_dport = inet->inet_dport;
-		fl6.fl6_sport = inet->inet_sport;
-		fl6.flowi6_uid = sk_uid(sk);
-		security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
-
-		rcu_read_lock();
-		final_p = fl6_update_dst(&fl6, rcu_dereference(np->opt),
-					 &final);
-		rcu_read_unlock();
-
-		dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, final_p);
-		if (IS_ERR(dst)) {
-			sk->sk_route_caps = 0;
-			WRITE_ONCE(sk->sk_err_soft, -PTR_ERR(dst));
-			return PTR_ERR(dst);
-		}
+	rcu_read_lock();
+	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &final);
+	rcu_read_unlock();
 
-		ip6_dst_store(sk, dst, false, false);
+	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
+	if (IS_ERR(dst)) {
+		sk->sk_route_caps = 0;
+		WRITE_ONCE(sk->sk_err_soft, -PTR_ERR(dst));
+		return PTR_ERR(dst);
 	}
 
+	ip6_dst_store(sk, dst, false, false);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(inet6_sk_rebuild_header);
 
 bool ipv6_opt_accepted(const struct sock *sk, const struct sk_buff *skb,
 		       const struct inet6_skb_parm *opt)
-- 
2.53.0.rc2.204.g2597b5adb4-goog


