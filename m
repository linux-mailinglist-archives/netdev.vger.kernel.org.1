Return-Path: <netdev+bounces-260939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP0VF8n4nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:27:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24BE1980FC
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 224EA311B86F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC293B8D48;
	Wed, 25 Feb 2026 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6UAeff9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395F3B5319
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025803; cv=none; b=urzG7Wj3QP8faRXSZ77XIdkVF/QilPMfkgpQsHuhOSZtAsPyc2ht+DIhBb/eU0T1OB6y064O0lYN7UjAlR/U5msPs0V49Hm0nF+7mX1c4girINvXbo1t10vcXnlm69hDUDxOuWFpoYt4BoQIDWVjU/6rDHKd3HmeM8S1hK7pUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025803; c=relaxed/simple;
	bh=EDvvMJnXQra5tEuY/SmcZgpW0zOulJCc2wCVrofLAeU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AIzowK4lKjMgEHqWO1PaGjm/ykqfbM/JxewLuXh66DUwxb3St1gar1C/qwV+Pre/98xamCLGle3hpU5o52DnXY6GCiqw2eTUdJ7UTj6wrefhMCh+NLbWFbEoIu/E0iuDDC+4GbzsQ7aIMjhIygdKjqWw1lSN/Hnd/IA+n/9dT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6UAeff9; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64c9a6c8be7so3146398d50.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772025801; x=1772630601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gvFzdvfLXphXqn/1tN6RKBp/6lv+fHrWozsbx5t7T1Q=;
        b=r6UAeff9wJlhSmROEUVP2znPfzRAnhDhBSYDSz0PDvKRr82fakJec8zl+pgwquE6hz
         rKYH8NEk8c1qDApyc0jjDvl0xV4O7yH2oP7l3+R5GqqpXC1ZrvjRqHwgOq5/kKSUgsQi
         XATD1oxts6UbB3pEtgZ/ERDNbv5itxK4Sv4v35NbjAWcs3w1hZExmwxr/mFkS4LD+Duw
         KewuuCJ71uTJv2WAc2jJZ3yx4JyDVKA3JxefChtmGZUz9c2hOHHvf58ei2uda1ei1eKZ
         WbRdo6pLmaRog+lmdaHMV973RzuAZe+D7Ad2K6nSHP5tO5yC62cG98BV0VDezsWzDHnq
         8MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772025801; x=1772630601;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvFzdvfLXphXqn/1tN6RKBp/6lv+fHrWozsbx5t7T1Q=;
        b=JMwzoHEkx0kDGWd7K8d8U32tJZrXFptG+Psh+Xy1FoptOLRYyYrBFNLZTJV6am9KQV
         AuU1K8YOy2A59BRqA4339YR0LYMp+aaKV0VW7D1LbcJNwu2+NsWFmQgHDmo2+2Hl/oGt
         B5YklN6jYA6KxvZnPn6jvVM/tLYBfWCQxoJw7WT91Wmrwy8EwOJ2TE7AzRzjehKnFPPh
         H4jTfSdgiINLbxmymZUmDqx2HknHHB6SZsoweV8wFGnYjWlRwUGHsMxQqti30s/dMzf4
         V3HOx4qiLsMSRzvuI08bK1GsLT2OjjhLh9ZrWSnXH8hZjcNYUnI3lpcKp0SNo85RQ5xe
         1Jdg==
X-Gm-Message-State: AOJu0YwU6jDvyEHTZYg7E7OYzz6hGUAZX7iOlpbc9voOqZ1FAkfxD0IC
	9TIObFenWwkY+qnGBCAz2ZEfm2UzkTYKM/y4xI0+FroOQRel0ZuKMYDcN8YakffZGOVkhCU3OfO
	a8i+cKxSPVVJoLw==
X-Received: from yxpk16.prod.google.com ([2002:a53:e810:0:b0:64c:a65a:b147])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:2058:b0:649:cbdc:c491 with SMTP id 956f58d0204a3-64cb25aeb0fmr294514d50.84.1772025801046;
 Wed, 25 Feb 2026 05:23:21 -0800 (PST)
Date: Wed, 25 Feb 2026 13:23:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225132319.1108400-1-edumazet@google.com>
Subject: [PATCH v2 nf-next] netfilter: xt_owner: no longer acquire
 sk_callback_lock in mt_owner()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260939-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B24BE1980FC
X-Rspamd-Action: no action

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in mt_owner()
to avoid touching sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/xt_owner.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index 50332888c8d233aab0915a31f2f616f3171da45e..5bfb4843df66361a930b0b2ed8ad936d5a38eeba 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -63,11 +63,12 @@ static bool
 owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct xt_owner_match_info *info = par->matchinfo;
-	const struct file *filp;
 	struct sock *sk = skb_to_full_sk(skb);
 	struct net *net = xt_net(par);
+	const struct socket *sock;
+	const struct file *filp;
 
-	if (!sk || !sk->sk_socket || !net_eq(net, sock_net(sk)))
+	if (!sk || !READ_ONCE(sk->sk_socket) || !net_eq(net, sock_net(sk)))
 		return (info->match ^ info->invert) == 0;
 	else if (info->match & info->invert & XT_OWNER_SOCKET)
 		/*
@@ -76,23 +77,25 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		 */
 		return false;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	filp = sk->sk_socket ? sk->sk_socket->file : NULL;
-	if (filp == NULL) {
-		read_unlock_bh(&sk->sk_callback_lock);
+	/* The sk pointer remains valid as long as the skb is. The sk_socket and
+	 * file pointer may become NULL if the socket is closed. Both structures
+	 * (including file->cred) are RCU freed which means they can be accessed
+	 * within a RCU read section.
+	 */
+	sock = READ_ONCE(sk->sk_socket);
+	filp = sock ? READ_ONCE(sock->file) : NULL;
+	if (filp == NULL)
 		return ((info->match ^ info->invert) &
 		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
-	}
 
 	if (info->match & XT_OWNER_UID) {
 		kuid_t uid_min = make_kuid(net->user_ns, info->uid_min);
 		kuid_t uid_max = make_kuid(net->user_ns, info->uid_max);
+
 		if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
 		     uid_lte(filp->f_cred->fsuid, uid_max)) ^
-		    !(info->invert & XT_OWNER_UID)) {
-			read_unlock_bh(&sk->sk_callback_lock);
+		    !(info->invert & XT_OWNER_UID))
 			return false;
-		}
 	}
 
 	if (info->match & XT_OWNER_GID) {
@@ -117,13 +120,10 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			}
 		}
 
-		if (match ^ !(info->invert & XT_OWNER_GID)) {
-			read_unlock_bh(&sk->sk_callback_lock);
+		if (match ^ !(info->invert & XT_OWNER_GID))
 			return false;
-		}
 	}
 
-	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
-- 
2.53.0.414.gf7e9f6c205-goog


