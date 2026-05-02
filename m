Return-Path: <netdev+bounces-283358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHQQH8Fs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:17:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC734B0C6D
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E5C73045027
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172E52D5C91;
	Sat,  2 May 2026 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L358LGpR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60E1E5B68
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691666; cv=none; b=KVNa4WnetaJGtLbp4crohYFfTcjA7f60CSjDnlh5nqdfG+VCMsamcMhaOE17D2GgwQFCG87p7Ii1GMmfWMF4uLpjRNFAoFVhjMrFuPwDcmaDXSvlM+dnAV2s8PCLiXmuJG+GYkDZwUJTUfwbcWLpcIkUN49bUQ7u2YadUrYu23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691666; c=relaxed/simple;
	bh=odQgM9CWs6Dn+iRew5AASLWpsxYjiLN81vO3v7ajB4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fkcg+9y/kbpTZ62R7wt+v/JiDuVbg87lGF6hWKBxu4pfS98BNOTRlQGa0CaULeOEnL4YS3uG8+zyA1Gz5IUltomZL0/kfjVhlXbKOU298dfZzBBch9aKgYvrF8xirLFibaftGj6TZdKiefceGgkKo0I56slhChxvd9dEcHswejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L358LGpR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82d40278103so1636009b3a.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691664; x=1778296464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1NZLuk7H4yLe1GLTp05SyADXOqdPXrI/7Y6XYiGlvw=;
        b=L358LGpRBqsBIW33qIKErQ2jYCRT5uvr0wJnlj8UrSBa4ES1Uup/ZdfJjg9d6McWtn
         NQAlYnHkCjoxKsRzDwEauEMAvdUr9XsIYZenmBNiwq8obQhdJiricbCbBoOjRdsiyJQ6
         qZMJP3SNeJ4rRRIyAU1j7xxlagT+eDjzN8bH1REnlpbunOEBFBQ/2VfgKcUGiH7aw/UX
         tYhHA4JFmgYK3j22uD+ARr2ZKdBNThG9lOeQnCeJig6BwsNH8NMzu1LPd3nOV/kMNNL6
         qbgzPv9eH3wOncNQxGtKBUhu0aco8ukkmzNCJh2fZSph+z1gvplagpLTn+cmzfdhQTOp
         HnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691664; x=1778296464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1NZLuk7H4yLe1GLTp05SyADXOqdPXrI/7Y6XYiGlvw=;
        b=Yzlq2qHl77zPRtaCmktSYnaBFnr5kKEki+hHwcMkhOpx5F8yenV1DOF18JaT+xzIra
         L0VAEdKUQYfBQhHOYkeBXv1sdojQ5mkx3N09T4vzJenWPjY8V9PTqy4pCUVmmvm6ZWCf
         WswDRdxBug4Zdht81PFDsYdrsELkR0Jvwvt+nQw7FGGTHVBAERP3sUXnD8zcbGAedRV+
         AVLJTv+92RiCITbw/puL1uOWB76YsyeRWMT4A8NsXeCEBrql4Y7GtnIkX/HEVI4xeEqL
         ucmLYiUFvO5vhUYD5kzCgFWWyPDOBNQ7tnpgNJa4GPOAJUDz5fo4gPWYwAIXlMrWJ2mi
         HpDw==
X-Forwarded-Encrypted: i=1; AFNElJ/6SRn2jqrhC36io5FmAbVvx/sVc84SkCo99/E9lyElO9UsYyp2Fj0MSN09siV+nV37m89TJPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KKS2YrdeB6+Wu5xA0fHMYFA0f3QUakZ7kTJpPZwV88hhs/PF
	A2RoWNtOI5q5Nz2VTSHnBvlpsNVoSuA/LExP8+BxeMeCsuaWxScOmfXrLYgDs6v/3cDzQf3OuIu
	7F6KTVw==
X-Received: from pfki1.prod.google.com ([2002:a05:6a00:41:b0:82f:344e:386a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:997:b0:829:88e7:c88b
 with SMTP id d2e1a72fcca58-8352d15fe10mr1671994b3a.19.1777691663729; Fri, 01
 May 2026 20:14:23 -0700 (PDT)
Date: Sat,  2 May 2026 03:13:04 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-12-kuniyu@google.com>
Subject: [PATCH v1 net-next 11/15] fou: Store struct sock in struct fou.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DAC734B0C6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283358-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

fou does not need to access struct socket itself in the fast
path; it only reads struct sock, and struct socket is only used
for tunnel setup and teardown.

Let's store struct sock directly in struct fou.

fou_release() frees struct fou with kfree_rcu(), so fou no
longer needs synchronize_rcu() in udp_tunnel_sock_release().

Note that the error path in fou_create() looks buggy; once the
tunnel is set up and fou_add_to_port_list() fails, struct fou
should be freed with kfree_rcu() _after_ udp_tunnel_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fou_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 6bed0e1dbe0e..865bd7205122 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -22,7 +22,7 @@
 #include "fou_nl.h"
 
 struct fou {
-	struct socket *sock;
+	struct sock *sk;
 	u8 protocol;
 	u8 flags;
 	__be16 port;
@@ -508,8 +508,8 @@ static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 
 static bool fou_cfg_cmp(struct fou *fou, struct fou_cfg *cfg)
 {
-	struct sock *sk = fou->sock->sk;
 	struct udp_port_cfg *udp_cfg = &cfg->udp_config;
+	struct sock *sk = fou->sk;
 
 	if (fou->family != udp_cfg->family ||
 	    fou->port != udp_cfg->local_udp_port ||
@@ -559,7 +559,7 @@ static int fou_add_to_port_list(struct net *net, struct fou *fou,
 static void fou_release(struct fou *fou)
 {
 	list_del(&fou->list);
-	udp_tunnel_sock_release(fou->sock->sk);
+	udp_tunnel_sock_release(fou->sk);
 	kfree_rcu(fou, rcu);
 }
 
@@ -590,7 +590,7 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 	fou->family = cfg->udp_config.family;
 	fou->flags = cfg->flags;
 	fou->type = cfg->type;
-	fou->sock = sock;
+	fou->sk = sk;
 
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
 	tunnel_cfg.encap_type = 1;
@@ -776,9 +776,9 @@ int fou_nl_del_doit(struct sk_buff *skb, struct genl_info *info)
 
 static int fou_fill_info(struct fou *fou, struct sk_buff *msg)
 {
-	struct sock *sk = fou->sock->sk;
+	struct sock *sk = fou->sk;
 
-	if (nla_put_u8(msg, FOU_ATTR_AF, fou->sock->sk->sk_family) ||
+	if (nla_put_u8(msg, FOU_ATTR_AF, sk->sk_family) ||
 	    nla_put_be16(msg, FOU_ATTR_PORT, fou->port) ||
 	    nla_put_be16(msg, FOU_ATTR_PEER_PORT, sk->sk_dport) ||
 	    nla_put_u8(msg, FOU_ATTR_IPPROTO, fou->protocol) ||
@@ -790,7 +790,7 @@ static int fou_fill_info(struct fou *fou, struct sk_buff *msg)
 		if (nla_put_flag(msg, FOU_ATTR_REMCSUM_NOPARTIAL))
 			return -1;
 
-	if (fou->sock->sk->sk_family == AF_INET) {
+	if (sk->sk_family == AF_INET) {
 		if (nla_put_in_addr(msg, FOU_ATTR_LOCAL_V4, sk->sk_rcv_saddr))
 			return -1;
 
-- 
2.54.0.545.g6539524ca2-goog


