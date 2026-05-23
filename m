Return-Path: <netdev+bounces-291046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBFcL3xGEWqUjQYAu9opvQ
	(envelope-from <netdev+bounces-291046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:17:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2075F5BD684
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A893D301DE19
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E1335081;
	Sat, 23 May 2026 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OugNyNCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACFD262A6
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779517020; cv=none; b=HRodLEzPJeBieDaqu1JiCTpj6DhYgJApzjM62K0pwoDdzxg9OzCAxmub4m20Ei/u5tRJXiRF8SsNxhDo6htH6/B23OwTxW25IRRvR6n9sX0s4/xWhI47CWMHx9dtcNfrXLV6yHnQQKpP9D2egqJzmyjLMMf3kf9MnZyvNWsCuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779517020; c=relaxed/simple;
	bh=i6PssPJdZRpqSmWY/DZ1fi7NNeAzIRRSgk39bakpink=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YNckf0FAclEzQEnhhh4eGmDSj2yR8DwdBc/8dYLdhRvRQtQajDQ5KJVQbkhpFKR+njsaTlRsvrek34imHgHAL9/KkJFPWSuS/kkOtzIsTQCwTuJ8w4CkUMkVkaeMSihRZeXjnehHoSkS6tAp/cyG0RYdAwIcmywAq1shV3jivp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OugNyNCj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so3965530a12.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779517018; x=1780121818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjlD1jjyfwuT09Y/j7n+KF+qUU88uHkXLBTG37/CDu0=;
        b=OugNyNCjdO28VQETd24SB6Z4h8lmw0pMsWg+YcQUxH13Lrk15w90d0lhWzXOU0IBZc
         vjf8n9VKUF2nrQq6V5GAn24N4XVCPiiMQ0TNXDkexZ1Tc2svijFNzu+26ZhNq59qG2No
         YDDE0z1MdYNZAGG+J3txFRy+3TZ2A5V4m4dhUtZdPsBpCI5dJylgoU8c0Qu47GCtauY9
         wNa0vacBAmjWSJIh6T4SsceCYmjlp3MFu3kl+o2Pnah10gur1Beq9EmHVZsSo+7Uv+TQ
         05WZdErMo3XGd+ArlzL47+crYK2JQPKwoxsbw0zwpSroX+3GfzERw6KWGjqmCcmm1saE
         /SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779517018; x=1780121818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjlD1jjyfwuT09Y/j7n+KF+qUU88uHkXLBTG37/CDu0=;
        b=N3RdcOPAX1zsZLhSHMPfR7Vh+tNoJQ0TCo2mnt4MxalI40/DEdWRAF2KGNaqDNRQ+r
         w1mEqp4mnuhsZM7j5aIQOoTPgrnIcivBSIv3zziLDW3uote4sAU3W59JazvjNhMDvJgx
         MWaqQR3XaWrR/3MS7Gs1JWhIIoNYuKK1O32JXK8kK82j23eHqWkIZxKGYFxYGbNpjnaR
         FfmhhN4BHACPjg2PnsNVMQmrL913sKH5VN//T1DheojVw228paNyiLRJYFAc6nlYWhlQ
         CFP8Sk+K6EQfS/Lb8wMT8PHiqkQl4aGw7JyWYkxUOJxjk7m7L1fp30nupATbUqM6Epuf
         hwbg==
X-Forwarded-Encrypted: i=1; AFNElJ/qNLPc1wtxpsfDcsu6mO+k3G88+CsLO6YHdQqmLhmJvarniRKIIbu6odWG6LP2vTBogMjgv5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiqv8t02I+iXX5DI7Iug56Lu8q8EL3ACxfvJ/PKT/s50SDSwLI
	SWYadyOhce/LvUuI1jIqYWa2P/6GPisAguaUDCp91yiYYNgrmEnvsM7XacPum3zkN9Y0lHRrNss
	RjrYPWQ==
X-Received: from pgcp4.prod.google.com ([2002:a63:7404:0:b0:c80:2541:2de8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244c:b0:3b2:a86f:d38e
 with SMTP id adf61e73a8af0-3b328f382a0mr7061193637.36.1779517018173; Fri, 22
 May 2026 23:16:58 -0700 (PDT)
Date: Sat, 23 May 2026 06:16:25 +0000
In-Reply-To: <20260523061654.2767060-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523061654.2767060-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523061654.2767060-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/5] geneve: Pass struct geneve_dev to geneve_create_sock().
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
	TAGGED_FROM(0.00)[bounces-291046-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,udp_conf.family:url]
X-Rspamd-Queue-Id: 2075F5BD684
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
index 16b5f9e13859..6cfdb2b249e1 100644
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


