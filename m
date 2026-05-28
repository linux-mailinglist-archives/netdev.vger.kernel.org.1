Return-Path: <netdev+bounces-292503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nzrdAPSSF2p1JwgAu9opvQ
	(envelope-from <netdev+bounces-292503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0615EB710
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E743030117BF
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192E224B04;
	Thu, 28 May 2026 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3BNIhWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6E229B12
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929825; cv=none; b=HYDElF4uOFTzpJkZ2e+w5DSUz04xb2zo71MX+88kxODFTBq0DDAL9abu2vXOf33r1fkKENxA5uEkGPWSMCbpF1AOM+4dXVQC2qcuZE1edVsFwwvllPiX6fWw5H4Vmi2WVGFG3UqdY/kJFSt1iyOBtk2C55lYLAfIhDNqqsVx3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929825; c=relaxed/simple;
	bh=ILcXfUzW7UaoCGycWzKsy/ivNYHFduhBgSONLKiHjPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QRghHiCSgDPptMWLiLCOAYX3jXmjNZrw+gQWh4fBdMCvEgmNvB6xKsuCFRbgK3y/lqI8uiMGAh53hve6EKcxpofOeZaNVblP18PTMBIwj16qC3HRarcS3vJMGrnGmFuRyOjnxHrEZAfK8OeO2n9PfxrVknTxkw9oLVjElZo6jaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3BNIhWY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd6aeb3637so279309785ad.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779929823; x=1780534623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjxKGvSv8jIQ0ejcOE61hUr2q6ZSFtELF8XF2SZ31Vw=;
        b=b3BNIhWYhjo5g84aJKcARE8yVVknzsgm8O+n0p99sYQ7kwxm4JlvYRyzQNmZa4OZiF
         2QSM067k5AJ0Zc76x2C7cx0PrG13+0r7BT8cJZ9anZE4t8YewNwrkFUWc1i8AaDygrEI
         CGUTx6zfLLjOJDPDcT2rfupXcbTpZ4KYE26M9+Y/OtEuaE1ho4HCmM3CagvrZ1LHVRsz
         dhz8WEp7+kUA8Xu8Cn9svRTnID5QKZaU+zx9HO37m5zEssT8nJYJXmcYsFZ2nk873PTw
         6HoM41jhaAgakzRD6QI5m96a/YpOblbhyy7tqz44Y0s45OcN2ZX83c5+OIaDBK7Yof7W
         p8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929823; x=1780534623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjxKGvSv8jIQ0ejcOE61hUr2q6ZSFtELF8XF2SZ31Vw=;
        b=nW2Jpc+unUcUPNWN6uPpQd2SygIfC4i2y7QXlR4aiHEFZbjNPlFxNmoetLasKs6JkL
         YRcYD0Ja3O71d+eoNQkttyVgVsWl91ZPstO1XA06z7nZUVNRUbm9iEyYilm+sp2jNNvq
         dXqgd7fYSH2kM+qKNIbBGwroxS7V0UVSEFM+zOlFNOxgAo04lWohfIvf6eZ7hnmF+YDd
         MV0XvRDLePApr/mHPBksbxImBjHXEwjKuW4iCEf65XD5Nqv0bBUsthSXfq9QKJG6wq1X
         Pdw81T0QPsyJJTywEd5VW+rTl54+k9d6W4Uvh2Q64uEOPl3E5P5RIZGErvGvzh2uzTQa
         QB3w==
X-Forwarded-Encrypted: i=1; AFNElJ/GYWl0jSjGHwFsQbIJJcrhRq7eGcgmlCiep8IZXjNl5Hl4VycF9s7JEGZ4fR1bojnphZpsB8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwplyG4pFnlgXoomDQ0sTpPOIL8lcJnjmY+DASj3o7UTzdnvMUJ
	5HQLM8aVBKBrOTgRX2aapVHZQVfAKdy2tc57ah/mID393c7sHr+MENlu/v+pmR9hhtJW4gcxq30
	kies74g==
X-Received: from plblq6.prod.google.com ([2002:a17:903:1446:b0:2bd:34d1:ea8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244d:b0:2bc:810b:5c0c
 with SMTP id d9443c01a7336-2beb076651amr280932585ad.34.1779929823121; Wed, 27
 May 2026 17:57:03 -0700 (PDT)
Date: Thu, 28 May 2026 00:56:47 +0000
In-Reply-To: <20260528005658.1756248-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528005658.1756248-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528005658.1756248-5-kuniyu@google.com>
Subject: [PATCH v4 net-next 4/5] geneve: Add dualstack flag to struct geneve_config.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292503-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9E0615EB710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When collect metadata mode (IFLA_GENEVE_COLLECT_METADATA) is
enabled, the GENEVE device creates both IPv4 and IPv6 sockets
and bind()s them to wildcard addresses.

The next patch allows creating only one socket bound to a
specific address even when the collect metadata mode is
enabled.

Then, we need a flag to distinguish dualstack GENEVE devices
to detect local address conflict.

Let's add the dualstack flag to struct geneve_config.

IFLA_GENEVE_COLLECT_METADATA processing is moved up in
geneve_nl2info() for the next patch to overwrite dualstack
to false while keeping collect_md true.

Note that IFLA_GENEVE_REMOTE and IFLA_GENEVE_REMOTE6 does not
set cfg->dualstack to false since is_tnl_info_zero() ignores
the wildcard remote address:

  # ip link add geneve0 type geneve external remote 0.0.0.1
  Error: Device is externally controlled, so attributes (VNI, Port, and so on) must not be specified.

  # ip link add geneve0 type geneve external remote 0.0.0.0
  # ss -ua | grep geneve
  UNCONN 0      0            0.0.0.0:geneve      0.0.0.0:*
  UNCONN 0      0                  *:geneve            *:*

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Don't set cfg->dualstack for IFLA_GENEVE_REMOTE6?
---
 drivers/net/geneve.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 4f841eced028..3a62d132a8c4 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -73,6 +73,7 @@ struct geneve_dev_node {
 
 struct geneve_config {
 	bool			collect_md;
+	bool			dualstack;
 	bool			use_udp6_rx_checksums;
 	bool			ttl_inherit;
 	bool			gro_hint;
@@ -1108,12 +1109,12 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 static int geneve_open(struct net_device *dev)
 {
 	struct geneve_dev *geneve = netdev_priv(dev);
-	bool metadata = geneve->cfg.collect_md;
+	bool dualstack = geneve->cfg.dualstack;
 	bool ipv4, ipv6;
 	int ret = 0;
 
-	ipv6 = geneve->cfg.info.mode & IP_TUNNEL_INFO_IPV6 || metadata;
-	ipv4 = !ipv6 || metadata;
+	ipv6 = geneve->cfg.info.mode & IP_TUNNEL_INFO_IPV6 || dualstack;
+	ipv4 = !ipv6 || dualstack;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
 		ret = geneve_sock_add(geneve, true);
@@ -1906,6 +1907,16 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 	struct ip_tunnel_info *info = &cfg->info;
 	int attrtype;
 
+	if (data[IFLA_GENEVE_COLLECT_METADATA]) {
+		if (changelink) {
+			attrtype = IFLA_GENEVE_COLLECT_METADATA;
+			goto change_notsup;
+		}
+
+		cfg->collect_md = true;
+		cfg->dualstack = true;
+	}
+
 	if (data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_REMOTE6]) {
 		NL_SET_ERR_MSG(extack,
 			       "Cannot specify both IPv4 and IPv6 Remote addresses");
@@ -2025,14 +2036,6 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 		cfg->port_max = ntohs(p->high);
 	}
 
-	if (data[IFLA_GENEVE_COLLECT_METADATA]) {
-		if (changelink) {
-			attrtype = IFLA_GENEVE_COLLECT_METADATA;
-			goto change_notsup;
-		}
-		cfg->collect_md = true;
-	}
-
 	if (data[IFLA_GENEVE_UDP_CSUM]) {
 		if (changelink) {
 			attrtype = IFLA_GENEVE_UDP_CSUM;
@@ -2153,6 +2156,7 @@ static int geneve_newlink(struct net_device *dev,
 		.use_udp6_rx_checksums = false,
 		.ttl_inherit = false,
 		.collect_md = false,
+		.dualstack = false,
 		.port_min = 1,
 		.port_max = USHRT_MAX,
 	};
@@ -2382,6 +2386,7 @@ struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
 		.use_udp6_rx_checksums = true,
 		.ttl_inherit = false,
 		.collect_md = true,
+		.dualstack = true,
 		.port_min = 1,
 		.port_max = USHRT_MAX,
 	};
-- 
2.54.0.794.g4f17f83d09-goog


