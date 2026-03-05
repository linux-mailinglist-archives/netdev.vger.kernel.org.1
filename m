Return-Path: <netdev+bounces-264566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOd1LxX7qWk7JAEAu9opvQ
	(envelope-from <netdev+bounces-264566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:52:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 431A2218AD2
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90841302DE1C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05A35DA66;
	Thu,  5 Mar 2026 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGn643Ib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0E36164A
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747441; cv=none; b=EnUEIUC25NzHdVb/tqq7ZoPXoZ85DnqmfBQtmv766x/0D6h81wzb/VUEpfUxj3bKUGZveeJFK3Ir6vdgxhArVXGI8RdPDZ/8ArF9/od7Gvc5VN0soyplqMhFMhNHrR7HRSJI7qtJQYuMM7mDRTBQnzOtzw+eoFIWiPgxu8tCP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747441; c=relaxed/simple;
	bh=iWBAv2KRZJ2Jy2J4aaDKyg7bDsv6ncThzy8ttpS0xV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pZyHCfNHOxEnrwvx4vKYbMdE4cSTBLaNdmIjtlSueN3PWxHbPl/262GJgXjTx/7iwSyOlXxQf2xanaTd+D6xLlClFUHRTjwXRZ+PQAfUC/hPYGl/taUbmavROaM72iYEIQdBgbEA7edx8mbI8qK1svVVHcXM44hpK4R8Sg4OzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yGn643Ib; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598518beceso5325548a91.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772747439; x=1773352239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kFyUueHMGY7hDo0BWcRX5W3tscJRPmT8h/cswXzVTY=;
        b=yGn643IbD9xqAnW3NQGQVFKq20+27zr+kvEb9cthkA01uUlaZITr5ibWw9Lb/7ROOZ
         S+ELCF2d5gmwS4HfaNPWTrSEROmLUlZQssDHKMsycZvBY1AEtcWQD9l1Jn+bPPLdeeHh
         5sQ4kyJHQ8CUKvrmGOvH2JmYYHtPdIOPW8c/GPXeWRJsMvf6sRwbjl6udAxsRxAH1oUF
         VkaQwkojeZLuxeuVDX7oyqiwLLZshpy4NyKrN4pnSTS3ikwKx9Fqdm6XoSoGAFpSbCZD
         yXCCeGCWwZMqC6HXavhuxNrO6m32c+K+cyr+UZtOZy4K2cynJeEDdoqkFZAVliERM8Fz
         QjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747439; x=1773352239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kFyUueHMGY7hDo0BWcRX5W3tscJRPmT8h/cswXzVTY=;
        b=OkqLME3vR0T6KdTUCM7vrf2gXXVHn1vjTryTnnrqn0We1iO9Q/T18n0Oemj6nevCFu
         e1K+S/s6ryOGI8xqRqU/9X7hPMlrQhVnX9nWOPbN570WLMdDmrg7GkwpgqnNe/6Yo8FZ
         w2NjhUt3ecic6WoVENfGbu/pUHdjltGKDuUA/y3r65Ua+X0oFIIeAhD5XcW0STHv6MqC
         QaW9oiYEdJxDvE0UX6/MNhFmMxosv9EGCmdrnRfnqTXm/cJ+IbB5EIVLTndKeoh5OeGI
         v2Vm5SqnZcoUV/5zgnrAtSsjOnlUaHJHzjVl14OVdRLZpDKXXtBBZ9jzDJX+Rwa3Cxzj
         mHRg==
X-Forwarded-Encrypted: i=1; AJvYcCUsX/UPj2XSI/Wvp5bG78dJ5y9Xr3Ye2c3rVV2oObHUopy3DrsvhnHn26PPOkMR3lqL2KqMwIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyifgHC4QLE39D9jiT38d8vuBH0InDe2W+BR9KTunpHj+Z5pr4G
	dnrKf2sJ+jt4ib8q/biwxFcsZk1dkLh8xyT88rTjDHn3PfvA/JAogEZdBMoDRcePD0NioksfrFq
	DOheYGw==
X-Received: from pjbmz4.prod.google.com ([2002:a17:90b:3784:b0:358:fc29:4815])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc6:b0:356:8719:f5b8
 with SMTP id 98e67ed59e1d1-359a6a6dcdcmr5270103a91.29.1772747439330; Thu, 05
 Mar 2026 13:50:39 -0800 (PST)
Date: Thu,  5 Mar 2026 21:49:58 +0000
In-Reply-To: <20260305215013.2984628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305215013.2984628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305215013.2984628-13-kuniyu@google.com>
Subject: [PATCH v2 net-next 12/15] udp: Remove dead check in
 __udp[46]_lib_lookup() for BPF.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 431A2218AD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264566-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

BPF socket lookup for SO_REUSEPORT does not support UDP-Lite.

In __udp4_lib_lookup() and __udp6_lib_lookup(), it checks if
the passed udptable pointer is the same as net->ipv4.udp_table,
which is only true for UDP.

Now, the condition is always true.

Let's remove the check.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c | 3 +--
 net/ipv6/udp.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 5ae0d88e3cca..86765a17de67 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -699,8 +699,7 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 		goto done;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
-	    udptable == net->ipv4.udp_table) {
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
 		sk = inet_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
 					       saddr, sport, daddr, hnum, dif,
 					       udp_ehashfn);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 54b5a92b04d0..fb50dcf8a384 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -370,8 +370,7 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 		goto done;
 
 	/* Lookup redirect from BPF */
-	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
-	    udptable == net->ipv4.udp_table) {
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled)) {
 		sk = inet6_lookup_run_sk_lookup(net, IPPROTO_UDP, skb, sizeof(struct udphdr),
 						saddr, sport, daddr, hnum, dif,
 						udp6_ehashfn);
-- 
2.53.0.473.g4a7958ca14-goog


