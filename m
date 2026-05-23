Return-Path: <netdev+bounces-291047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLiAHZZGEWqUjQYAu9opvQ
	(envelope-from <netdev+bounces-291047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:17:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D65D25BD68E
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45293023376
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A13128CF;
	Sat, 23 May 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7JnmbZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629623EAA6
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779517023; cv=none; b=qbC8Veltp1fUidA1y4DZIVNtpcKnWiSzNhnqIpkV5k4dRT6Wbca730D2SUzKcd3bOWsUTrJiltF1i4eGzEihehzoKkS5s7W+oq2jT20vBO7XuKoJcQGE+0L6SW4RN3ofOhTPHnzbDo0b+HFSqkO9+EWyzDIKWZR7ns7wotGfweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779517023; c=relaxed/simple;
	bh=y8yg8GuY9kqQXLKBG3U7p4oto8Fqv6s+1oCdNotfPio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F4sbU3B81RxDr7gS0FEGtxsGM+ftrTZhu3IW3ZBReoUmKnCWxa0YtlxVIGCfrkGZjngjofKAaT6YU+mYX6jjetH7Kwpv3/KOV2km2O9S4zS7wZRDfX+otyV1XjWcE41YxNFSNrVRDfpcqCzv24brObUHs9JSCHxyyXQMuW4sA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7JnmbZu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8294d8c48eso4916938a12.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779517020; x=1780121820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYO8+8zxJ3QQw8arFuD8GTO4j7pac3bXoLBif3H3GA4=;
        b=V7JnmbZuWpHKt3RjLPqJne8VFdzfW+0SlqPBXEL02FGBuHGJqpl1c2COWiR9ufsCy2
         24PNSew+w4x6UqNu7TCUS16RWZ/XWy6+ln62W7njaF7GjC4vesB+7yv8zHkRBph4lzcx
         wAhAWsXjXPsAJ+bSiJChUg6Wy6JD0MVJ9o9Oh76p4HEJ5VKPcB8FmOgvfxJRqB21NdS3
         PA6XjUolMQegvevcWRawsPBPVCayYlcCRGFLN0Q8+5NiNGvXSyixZ5F+O7ItJaaBWE/P
         wkFBWqIEwNTml/N+bJP/jpUi8nEUvJyu4+BxLO0DjxZVtd7jBgfMZn+9pxMiu0zxRu1G
         qNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779517020; x=1780121820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYO8+8zxJ3QQw8arFuD8GTO4j7pac3bXoLBif3H3GA4=;
        b=OfS4NaAtvUnOgN3HuEpq4DBJM/dNn2iwEpwQF/l0Uw5viK3H46nAOv1EyMOpSb0kD6
         5SLeyx8XxwhnmLyVK3Xu3Zvloa4KO/XK+xRb2YbBxUInf8fyHS6Nf+Hl5XHGOR8WEHJ2
         uHH823ga00kzJkcFRf/F1vafYeZmuApwA+z8mn6uacA06jsp4xLSlVoWxkGdVAB4NPbV
         QdNiuDyN6LFO0avaE/oglhpKirr0uf+bFpvDFPzs4JsayzqNI3IMpWcDLQ+iOoJYvIHh
         lQwmxcfnnG5w+KQvEX7Q8WjAOB6MzFpHZxW+el1Ht4aZIcx/ECK32IaNTMg8BRMUem8Y
         9giw==
X-Forwarded-Encrypted: i=1; AFNElJ+vpWVygm/naHHFPgQr7hOl2vxpEdFwreQ2iYAU3IYy1Wulzm+lfQ4h07lnpRxsLRzdlZhusV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuD2fEVYVKUEHJK+xSXzYG46fCjHAQgTYqNNAJxCFjJAGHhr4
	OT5bS1xSNXeEueW/qhRrjrd+n5/Fd4vXdzNPbE+osM+Y6r8wV1Sh8ThGLWOzbiOGtP56PrsPefE
	TIeX5gw==
X-Received: from pjvn10.prod.google.com ([2002:a17:90a:de8a:b0:368:2074:b7c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d05:b0:368:433:b697
 with SMTP id 98e67ed59e1d1-36a67624a8cmr6260230a91.19.1779517019876; Fri, 22
 May 2026 23:16:59 -0700 (PDT)
Date: Sat, 23 May 2026 06:16:27 +0000
In-Reply-To: <20260523061654.2767060-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523061654.2767060-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523061654.2767060-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/5] geneve: Add dualstack flag to struct geneve_config.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291047-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D65D25BD68E
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

Note that IFLA_GENEVE_COLLECT_METADATA processing is moved up
in geneve_nl2info() for the next patch to overwrite dualstack
to false while keeping collect_md true.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 4bf787607a91..0b0bd3321e57 100644
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
+	ipv4 = !geneve->cfg.info.mode || dualstack;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
 		ret = geneve_sock_add(geneve, true);
@@ -1907,6 +1908,16 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 	int addr_type;
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
@@ -1927,6 +1938,8 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 					    "Remote IPv4 address cannot be Multicast");
 			return -EINVAL;
 		}
+
+		cfg->dualstack = false;
 	}
 
 	if (data[IFLA_GENEVE_REMOTE6]) {
@@ -1951,7 +1964,10 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 					    "Remote IPv6 address cannot be Multicast");
 			return -EINVAL;
 		}
+
 		__set_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
+
+		cfg->dualstack = false;
 		cfg->use_udp6_rx_checksums = true;
 #else
 		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_REMOTE6],
@@ -2024,14 +2040,6 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
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
@@ -2152,6 +2160,7 @@ static int geneve_newlink(struct net_device *dev,
 		.use_udp6_rx_checksums = false,
 		.ttl_inherit = false,
 		.collect_md = false,
+		.dualstack = false,
 		.port_min = 1,
 		.port_max = USHRT_MAX,
 	};
@@ -2381,6 +2390,7 @@ struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
 		.use_udp6_rx_checksums = true,
 		.ttl_inherit = false,
 		.collect_md = true,
+		.dualstack = true,
 		.port_min = 1,
 		.port_max = USHRT_MAX,
 	};
-- 
2.54.0.746.g67dd491aae-goog


