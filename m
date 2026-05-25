Return-Path: <netdev+bounces-291221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCKQEz2VE2oqDwcAu9opvQ
	(envelope-from <netdev+bounces-291221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:18:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E39CC5C5001
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E215E3004DDC
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0731A9FB7;
	Mon, 25 May 2026 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnRIPMuN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCE1547C0
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779668274; cv=none; b=iu6+s4esZqgE950HLNhJYg3oVuF24w58PuKCAA4UR964SjWW5WHAQrMv22/t2i+QGK3bf72SHTomLp9Eczy7H7FDZsf4dxLtj+vtD4msgFaAsygPemruHTdjxGodRoLB86EJiKqjHdzofP8pDGdROvlHlBHP8I9d7aGZhfck09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779668274; c=relaxed/simple;
	bh=b1oUlgZB/FjjwGoqgrfAdpNGJqF29lLIHSuEfss3iiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q3Q2ov050DCQtGcPmAPG1WJwDSMuTFWteyg1qgBQco9Wt6ej//ufBV5Ae+VTFizz3I5kp/6EhnmDcd1IXnCxw6OXWswxcPSWBs/wJnNNX+OSl4RkZd/6tA/wZHW9dS3KIOWrZbHeoePM/9qVDh/X16fIWMj54aeAaEpj7PSNFzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnRIPMuN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc763c7256so201067365ad.3
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 17:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779668273; x=1780273073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsTOHYRjSx/ENl/emOtG7n4VjAU4UcEcGp+RYrOAECc=;
        b=fnRIPMuNi6Zo2GVBaGqdUQBPRuqNE1KXcYJZ/6+htosskU55R9oti54nNQebK6so/t
         8fvnD92GFbYidntubi6uVTI1Sfx4BuWQT8fmY5kR5cff/l/lAAl+tryEKSVy4ieN4Laz
         MqMiS5PgGpPlaawVjK08zmUUYAoyhm+QcLloATkKb67T2Mjc8njFqakp884ZULc5fTA0
         YCtkZiXo39kHI8BhcskUTxLE9o33By+SwOzJg+vo5AWRcKmzv5jgIhvmksLA1DxV+15D
         +w6uHbADgPEOeZFs2cheCuhGjG6L23ROmJ374vQQ6DFpp/S5MvUEvGCEgTTE2DZKW8qt
         IiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779668273; x=1780273073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsTOHYRjSx/ENl/emOtG7n4VjAU4UcEcGp+RYrOAECc=;
        b=bQfgXWkWJ0TlZ8PEbbP2lN1WWyM+jxps8rqv9gNUKu38aj0iWBzAviOkGHcw019n6j
         kbiSLD5M0EaCYhFAOIYo/RcFwTfpMG03Ehkn+lxZHGglzqPKGEISeJEfPE5o8cYsSFUy
         pQyt6/BpdOZ5uImwmR6gK09znO4uRweUi+IBfODheR8gzHaxWzgxpWpjczHougogkD3J
         LK11qblw9SRWC/6zAIfzxfdRkPDgaw9cp57N4BYViQE0a0q2TPiqVd9Zq1bVoA9T1/EH
         RyTOODGFituVhRSY59qUnBw8NbFlHwPuwb1hoB1xyvaH8xbPqYlntBS11wqG3ErqjIS6
         8x1w==
X-Forwarded-Encrypted: i=1; AFNElJ86BV39pkx7dtAAjldkhr1sGvUh7Tts55mQ1f08AadNoxSvJVpRDCkL2VnM09VuekBnfH4fiB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywt36yDKlcYzAZGK6S/THvVTrNw7rYquZUtXrekjBz0uqZLPb8
	eWAkJjWhulS/R9ogMOKJ8D2klTWCAC+gS6waX9K6xb08OKO7nL7e2YFrPKSIu4DggcQJ5DFjez8
	B13V2Bw==
X-Received: from plti6.prod.google.com ([2002:a17:902:6ac6:b0:2ae:41d1:278d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:246:b0:2bd:8395:fed8
 with SMTP id d9443c01a7336-2beb0722b38mr139048915ad.27.1779668272879; Sun, 24
 May 2026 17:17:52 -0700 (PDT)
Date: Mon, 25 May 2026 00:17:20 +0000
In-Reply-To: <20260525001745.1251640-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525001745.1251640-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525001745.1251640-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/5] geneve: Pass struct geneve_dev to geneve_create_sock().
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291221-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,udp_conf.family:url]
X-Rspamd-Queue-Id: E39CC5C5001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a prep patch to make a subsequent patch clean.

We will need to access geneve_dev->cfg.info.key.u.{ipv4,ipv6}.src
in geneve_create_sock() later.

Let's pass down struct geneve_dev from geneve_sock_add() to
geneve_create_sock() instead of individual config fields.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 8413c21fee6f..7e8c3023842e 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -760,9 +760,10 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 	return -EPFNOSUPPORT;
 }
 
-static struct sock *geneve_create_sock(struct net *net, bool ipv6,
-				       __be16 port, bool ipv6_rx_csum)
+static struct sock *geneve_create_sock(struct net *net,
+				       struct geneve_dev *geneve, bool ipv6)
 {
+	struct ip_tunnel_info *info = &geneve->cfg.info;
 	struct udp_port_cfg udp_conf;
 	struct socket *sock;
 	int err;
@@ -772,13 +773,13 @@ static struct sock *geneve_create_sock(struct net *net, bool ipv6,
 	if (ipv6) {
 		udp_conf.family = AF_INET6;
 		udp_conf.ipv6_v6only = 1;
-		udp_conf.use_udp6_rx_checksums = ipv6_rx_csum;
+		udp_conf.use_udp6_rx_checksums = geneve->cfg.use_udp6_rx_checksums;
 	} else {
 		udp_conf.family = AF_INET;
 		udp_conf.local_ip.s_addr = htonl(INADDR_ANY);
 	}
 
-	udp_conf.local_udp_port = port;
+	udp_conf.local_udp_port = info->key.tp_dst;
 
 	/* Open UDP socket */
 	err = udp_sock_create(net, &udp_conf, &sock);
@@ -970,8 +971,8 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 }
 
 /* Create new listen socket if needed */
-static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
-						bool ipv6, bool ipv6_rx_csum)
+static struct geneve_sock *geneve_socket_create(struct net *net,
+						struct geneve_dev *geneve, bool ipv6)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct udp_tunnel_sock_cfg tunnel_cfg;
@@ -983,7 +984,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 	if (!gs)
 		return ERR_PTR(-ENOMEM);
 
-	sk = geneve_create_sock(net, ipv6, port, ipv6_rx_csum);
+	sk = geneve_create_sock(net, geneve, ipv6);
 	if (IS_ERR(sk)) {
 		kfree(gs);
 		return ERR_CAST(sk);
@@ -1073,8 +1074,7 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 		goto out;
 	}
 
-	gs = geneve_socket_create(net, geneve->cfg.info.key.tp_dst, ipv6,
-				  geneve->cfg.use_udp6_rx_checksums);
+	gs = geneve_socket_create(net, geneve, ipv6);
 	if (IS_ERR(gs))
 		return PTR_ERR(gs);
 
-- 
2.54.0.746.g67dd491aae-goog


