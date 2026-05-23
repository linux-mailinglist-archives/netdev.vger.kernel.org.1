Return-Path: <netdev+bounces-291048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI5nGZtGEWqUjQYAu9opvQ
	(envelope-from <netdev+bounces-291048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:18:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F4C5BD695
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090CD302450E
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3555B312837;
	Sat, 23 May 2026 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDyIV1T4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D5332EA0
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779517024; cv=none; b=gUxXMqG2raPLSndHD/R+XSZdoC31fLdcJDWsQL5zBPawhd+rkDM9SqhK7HUd7ZA86neVAZFs9RhcY+1+6w1HapARB0eSDYRMxIHZHuUrbOCTkUr9Ybmf56zEaZqL40KucLBjjvbC59VH8J7kLjs6p+a5fp0uQB9s8er5Gy7aRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779517024; c=relaxed/simple;
	bh=NTqhimJWSrvM+qhlOFbRdmliX3MUMIDK9bWN3uOJbio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t9OR8RgrL1rrr4GbZ4kRl5jYRE0askU9vq2LFusigaoFf89NfXw6zxueyq/Y3WfwyP0teeBrEX0UeDcOslBoGnZBOZ6ekQHy/MZta3g1XDsy/G2pIfXTJ5hDqt6r9GA8OisiBmydsiIuhSmD4nhNDgd4qSMd8DXgiTJ3rsS8em0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDyIV1T4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3684cb22502so7457273a91.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779517019; x=1780121819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BE71nk5aWsiLLr4A8hcdDF4FVZ1MLE0aFPac1YfwXvE=;
        b=LDyIV1T4I+u98sbzF63nwQfe/vbgitl7HofysO6cw4S5sdBTWwi13zjnoQZh/ynIlx
         WwXkztXUfdUZ7x+MjUh5lcWn4e/9lsBOaVBwNvt1lsN7P1xRXzPwTPVbX8OsQfll+jqR
         xKulbWRdNHzkVt43CrmGIfaw2u0LNh87aNfq8EHxthrVKKAmyVJNgiVjRigqQPLH4K9u
         7xq8/xapRiqi4s9xaFCLDn823H4nQ3OK/23NzRkQSHe3l12LkfQg2jURAPzMtxgioEmg
         /LIGor0Jnto+EDnDHjJC0pnfNvgrdnOUVq/ZtcicHSoaOe49vSxd3/8dBlHII/v6O3Yv
         iB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779517019; x=1780121819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BE71nk5aWsiLLr4A8hcdDF4FVZ1MLE0aFPac1YfwXvE=;
        b=tRbb31aWj94h7b/5ExkSyf1BM+VCu6CphJsWYa9YXY9Ruy8QBx165ZWLkDVMXg87bO
         m52Hb1EG5DUCnF+B+xd5eFfIhuQ8I8xxViY1QWdMaO24bA9L8dFV2ZXoHyaUi1mzQ2W6
         BJW6Kk9+B9E45GaVOONG9nn+6t54wTD2+bkDwrihPHcbv3QPoS3151DqjUB/ZECdniBP
         sDchaC9alvJ73fyPENZmKf9ik+0CyGuJmE/xkvWA0+jTtJrYiiG53HMKNXby06wLdrpx
         j131Q3vzCKj9mc3RW1it0NJRDP2sKdlMZyukqRX3x4OXaDMvGS8/FgLG1QUtgfw7g5oW
         0YIw==
X-Forwarded-Encrypted: i=1; AFNElJ8H8BRcGLXdUzLaWcjwE8H0ebrYamGZN8PsNU21FcEwmaTblLLTEGzpBdBGxp/Zd09x06ouWb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfdtkn5foMpt+rBWXFOi8QbWp3w+mKd30j6UkiMh8qLRqiypji
	nD8+dmEpgzudWl3aeRPy2HE1bS+DYQbXuXxL1gfS9lo5AbqmUfg7J8zQ0DXk6tzoonmNHxP3tfY
	yzgXj7Q==
X-Received: from pjbpw17.prod.google.com ([2002:a17:90b:2791:b0:366:3a03:b66d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f4f:b0:368:1566:1ba5
 with SMTP id 98e67ed59e1d1-36a6745c264mr6765456a91.7.1779517019129; Fri, 22
 May 2026 23:16:59 -0700 (PDT)
Date: Sat, 23 May 2026 06:16:26 +0000
In-Reply-To: <20260523061654.2767060-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523061654.2767060-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523061654.2767060-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/5] geneve: Pass struct geneve_dev to geneve_find_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291048-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.945];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 06F4C5BD695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a prep patch to make a subsequent patch clean.

We will need to access geneve_dev->cfg.info.key.u.{ipv4,ipv6}.src
in geneve_find_sock() later and extend conditions there.

Let's pass down struct geneve from geneve_sock_add() to
geneve_find_sock() and flatten the conditional logic.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 6cfdb2b249e1..4bf787607a91 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1040,35 +1040,41 @@ static void geneve_sock_release(struct geneve_dev *geneve)
 #endif
 }
 
-static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
-					    sa_family_t family,
-					    __be16 dst_port,
-					    bool gro_hint)
+static struct geneve_sock *geneve_find_sock(struct net *net,
+					    struct geneve_dev *geneve, bool ipv6)
 {
+	struct geneve_net *gn = net_generic(net, geneve_net_id);
+	struct ip_tunnel_info *info = &geneve->cfg.info;
+	sa_family_t family = ipv6 ? AF_INET6 : AF_INET;
+	bool gro_hint = geneve->cfg.gro_hint;
+	__be16 dst_port = info->key.tp_dst;
 	struct geneve_sock *gs;
 
 	list_for_each_entry(gs, &gn->sock_list, list) {
-		if (inet_sk(gs->sk)->inet_sport == dst_port &&
-		    geneve_get_sk_family(gs) == family &&
-		    gs->gro_hint == gro_hint) {
-			return gs;
-		}
+		if (inet_sk(gs->sk)->inet_sport != dst_port)
+			continue;
+
+		if (geneve_get_sk_family(gs) != family)
+			continue;
+
+		if (gs->gro_hint != gro_hint)
+			continue;
+
+		return gs;
 	}
+
 	return NULL;
 }
 
 static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 {
 	struct net *net = geneve->net;
-	struct geneve_net *gn = net_generic(net, geneve_net_id);
-	bool gro_hint = geneve->cfg.gro_hint;
 	struct geneve_dev_node *node;
 	struct geneve_sock *gs;
 	__u8 vni[3];
 	__u32 hash;
 
-	gs = geneve_find_sock(gn, ipv6 ? AF_INET6 : AF_INET,
-			      geneve->cfg.info.key.tp_dst, gro_hint);
+	gs = geneve_find_sock(net, geneve, ipv6);
 	if (gs) {
 		gs->refcnt++;
 		goto out;
@@ -1080,7 +1086,7 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 
 out:
 	gs->collect_md = geneve->cfg.collect_md;
-	gs->gro_hint = gro_hint;
+	gs->gro_hint = geneve->cfg.gro_hint;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
 		rcu_assign_pointer(geneve->sock6, gs);
-- 
2.54.0.746.g67dd491aae-goog


