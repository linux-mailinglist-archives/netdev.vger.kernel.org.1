Return-Path: <netdev+bounces-291497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMfxMjn+FGp2SAcAu9opvQ
	(envelope-from <netdev+bounces-291497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:58:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247F5CF9A3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE25F3048165
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 01:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC192DECBA;
	Tue, 26 May 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYeHngo0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9F42BE7DC
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760321; cv=none; b=NLOxLMGgw9iXOLrDgw2yYWB52vI/OtkjK+vifGkXcbSF66a2hRPXoPYOwYC+Tjwo+TENiaIleZ10VIhQ1ecx4lXwjGA0LuZxkj/0G2Li5bnhZvo75GIkpJjn/888hPEU+Ctefuc+Ng6lxiaJ8ISdza2Bqjl73lMWzDm52jdieU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760321; c=relaxed/simple;
	bh=/D+5jgxjsaZkHPNtyE8pD1/3L1kxRjxUTEFMh7wVr+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jQElUa/Rp5caUf0q69H5/GmBBFdHl+wGx2FLffFlhXsrzZasXmChCXGR8NFw2VQC4Zo18e7gxphz4hhp/WxVa7JB9ePQuzUQuBYmbLf3ITIMlwHgTxE0ZN/z+/0hjBv6B/kpV8cJtKCQ6h9N3RxsriuhfTWwWm7NR29ky5dMFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYeHngo0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc763c7256so220609985ad.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779760318; x=1780365118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iaSDzKlmI30tM3vzrC91iG6UAQkmcMv9Cxww3HRJAEE=;
        b=WYeHngo0qbiGpI1x5IDMZMMMKEQPk6TxevdggLu9sqgtrZcA2AAjKh5gd3+0lBExAR
         BwJ20B+KgSOTY7KuQkflq5YQ6XoDyuZS2bQEhJZlNDMT3qR8r6Y7Hh7qVrzgtkvsqk0Y
         36WPMpiKuyRC/t01A0JD47EfbX3RA1ZfHEG75k5JOPZ37Wp85Xzc+9SY96MTYzkCEV2X
         4rfp84l/vs6w/6QZ0ESgUFxeM6Jwlf55SRxWhYc7LIP0589tZX4mqzeclLzlNJVqMbJ8
         xUy4QCmwtfnkQk7A3aKnqkgfyHuCNRUOdbqjHEugDNfmalRGmfjWRKM1rCb2Z5gBV0np
         IFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779760318; x=1780365118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaSDzKlmI30tM3vzrC91iG6UAQkmcMv9Cxww3HRJAEE=;
        b=ezEJQT8FrKwvIza7c4QbBlBNP2PS6+KqWGq3AzFWgQs6DrR2HaKumoTHi8T/IjGOWD
         76CMjVSX1kEgpwUhwzIovIeBfJwZDakfUOfNukjrZF0j96QzdKnEliLwwbCyUGvyIrGq
         X31CibqdFMQSFKrW+CJkDLAhyTN2rZm+UQmyEYSj6Yxd1EYMrgX6iIsztmJVsxyJU4Gv
         cwL5xL8AFBeNHIBciQzvMADtqiAAWwckrrFE0fQZ9EdObHwtJWgDjPJ/tIO7nn+z/vpo
         Uxeshi8DhZImxA5OaQiIEUEmXYBoz/3hJUynIxVyGW7yjTvEgU0uPBDqSD7NsXxYIm75
         Vukw==
X-Forwarded-Encrypted: i=1; AFNElJ9RSpAvAzYMfVX89xtidQgr8/O3UEbMG0wRI60aYjSZBC4t8+l5jqCgIvxwEZchlM701Lg8N3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7hi2gK3tEIdNX5Q0J3ytvIozqcfyqx8csMucZbR+mFc5aQRT
	YBSw0aDyYtf7RLALixPwntnNmWPYbNb983TcBtloXobpvv45Boa3JhzATLF4X57V0ECwFlyvpoP
	Uq0zDug==
X-Received: from plcc12.prod.google.com ([2002:a17:902:c1cc:b0:2b2:a715:a848])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c24:b0:2b2:6b58:9317
 with SMTP id d9443c01a7336-2beb0770b5amr181771055ad.39.1779760317738; Mon, 25
 May 2026 18:51:57 -0700 (PDT)
Date: Tue, 26 May 2026 01:51:16 +0000
In-Reply-To: <20260526015152.2409183-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526015152.2409183-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526015152.2409183-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 4/5] geneve: Add dualstack flag to struct geneve_config.
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
	TAGGED_FROM(0.00)[bounces-291497-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3247F5CF9A3
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
2.54.0.746.g67dd491aae-goog


