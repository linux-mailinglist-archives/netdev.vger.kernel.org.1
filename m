Return-Path: <netdev+bounces-264024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCH1OJ+IqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A6020718D
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 096F9304AAF1
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE88D3DFC75;
	Wed,  4 Mar 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZzS0EO50"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954723DEAD0
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652658; cv=none; b=HMj35ZDXVFeo+ROJd2eBQ9BwVr2zsJCoNNEzA8RugGA9HXBlmjwfaT8imyto2k6FwIu8lCQWIMqZne1RqfVMfatN4e5v9dinqHOiX+iRZ2quhakLMubPVlTY7EfoIWE++eXpEf7A3hgkmHfKeUipD2Q5R4YXvsytFe0Ch5egz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652658; c=relaxed/simple;
	bh=Oqu4UX5KDXZG935KgjDDWENrgqmypLqS4jbCWZIY39E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GUwpD1+SkdXAJ3a/IsjymgG7C6chPSkdmWupxNiVUpLt4MhDVdWQQbdPAM03CtVKcH/SQrbJBBgT4R8VRn6ue3/oBuJsg5s8I382c92XblOJvedIO+UMAuknu+UvjQeiavip6F5xCSIy38u9zb7YoyEnu1NNlk5pgS4LhjTg+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZzS0EO50; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4e20a414so186041155ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652657; x=1773257457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=poY2mHv8+pbVXGtQjMMfv8agvInpl3EKZQymZlwEevs=;
        b=ZzS0EO503SdhScW/gviUV2HpDcuZzhV4mDTpIoON1KyApX5yMJJ09QJuC5xV44+qGn
         Isfy65WmVlkL/K9DE/nkWyfOISXmp6o8Oo+CiSBvFY7yTJplO+Ujkb/7U17q3+CQmVJj
         TiZvEnxI01TcYLAD4hPlvaIzzzWOx49b0xh7KVI1sLhqa4HL0MMJAkxPQBX/2GqJQqd+
         Q+Y8UYuic+GlEExH5Xm+ro6yxKRBV5D8GPI1W+nXqFyY1ekZCi7iw1ZcsLe8taYphWUX
         DUsV0zpkWm+HKcxN6NE2FBok2Jv/sIoyrBL08m0FzwYE5oTGgyOdN+Iw4PMo4RtOaWJh
         EpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652657; x=1773257457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poY2mHv8+pbVXGtQjMMfv8agvInpl3EKZQymZlwEevs=;
        b=hTdbRRHb7UGWUVSbmt0M/lFngzRP8SZfmA5LG7JAdZLoNeK0kwyfZdSVSe/hAP0oxC
         o0cdQ5kRv98eDeavOkPSHjy12Afl7kBgw6mgHG5IsjYL7bcW+FUDV8DG0lRKIr9+aBVQ
         w7UTMebXM530wnZ2ddlPD7mfbiHhM96vzKXzc9z2ZoWIweVGWKhCDizKWovo5nVu31cg
         fzyQBszA2VLnEJRUKPDLEUAIN0u/9t/b545J7GonKb6JCH8Mw+fDb/yXEYQHGQcWIklG
         5S9InswlwVGeKgS5yZqYhSULr46dnxQtCE+k9AO2x+vVKe85qPa5WTPyr2Cw/n7KB57q
         W4LA==
X-Forwarded-Encrypted: i=1; AJvYcCWgQmUOhct0CJTm6PAg3y7Yg+tachVLk2Ge1pA3wVzemVKDnmXjB/dOmh0uwPCHYeT+n4lqr60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2/33YOOOPLxAfddaLzX+RR/4JRcJKVpllw3QI4uXdqMdg6C1
	7Wg9SMPhXxFfCboMo9nRoU03JTwCNw4EkHcGyVVTDfSXtp9sANcpGcVDHVG3eegjlXEaEtv6+xa
	FjDIFuQ==
X-Received: from plav4.prod.google.com ([2002:a17:902:f0c4:b0:2ae:5d79:a15e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2409:b0:2a9:451d:a69
 with SMTP id d9443c01a7336-2ae6aa0222amr28889885ad.10.1772652656802; Wed, 04
 Mar 2026 11:30:56 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:43 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-13-kuniyu@google.com>
Subject: [PATCH v1 net-next 12/15] udp: Remove dead check in
 __udp[46]_lib_lookup() for BPF.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A0A6020718D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264024-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

BPF socket lookup for SO_REUSEPORT does not support UDP-Lite.

In __udp4_lib_lookup() and __udp6_lib_lookup(), it checks if
the passed udptable pointer is the same as net->ipv4.udp_table,
which is only true for UDP.

Now, the condition is always true.

Let's remove the check.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/udp.c | 3 +--
 net/ipv6/udp.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6076e20f46f0..5b445779b0a0 100644
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


