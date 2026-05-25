Return-Path: <netdev+bounces-291223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JSqFmKVE2oqDwcAu9opvQ
	(envelope-from <netdev+bounces-291223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:18:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C84DA5C5018
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64B1E30156EC
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8FC1E22E9;
	Mon, 25 May 2026 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klJtFGrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BEF1BD9C9
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779668276; cv=none; b=h/Ixj5mEXXwnjjgRwTJOxEdnn/bw1BfRF76LjytDhL6X4E4BI2ZKAVbMF/l4ZwjQ1UObzcgYl7+v6T2/OqjCYsqjUNqRiV7o/YIcgjFfwb3WIcUmyd8XyjHHads9ExlvvR6CQgu0ZP+xTBafMZAC12zdU7xnVUQShheGIeJ4XUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779668276; c=relaxed/simple;
	bh=/D+5jgxjsaZkHPNtyE8pD1/3L1kxRjxUTEFMh7wVr+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GEe/crN4LXd6kjci+GkhKAud8mw3XrsNgwaS3o/7recniecH1vnxrJgHK3OVMsXD+D2heKzz8QO3P+npiB09hSCVYA2D2cjznX28CP2pV5/qTgAzvy/tWod3IOgmgH+7cYLai02Lfoc9x+AoHYRjq4ozBfChpmppJIcwt+GEhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klJtFGrl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83ef22f8e8bso5692381b3a.0
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 17:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779668275; x=1780273075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iaSDzKlmI30tM3vzrC91iG6UAQkmcMv9Cxww3HRJAEE=;
        b=klJtFGrlS6C1bYV1Z4T7Fwsw12X/rTv3gC3yaRVdy7PFBSQaYRzcQb8mGQjJ9E/uTI
         rDbcF9qAUp/OiESL7YeZQBKkdUn+6xdg3TeaqFjjfHEnTwDOGqW5EkuWnXV8GyZB5HIu
         9qJzprRYGIivwa5pe6qvI/b7F2/MHmX5hM9w/amsZ6bZNv1miuA60ouuiKI7bEVPRXq9
         2aR3h/0m20oQgiS5ULchs9Yv5e1OpsIry7NoQVNtxBCGlg8J58+sxtj6eQB7A6+C6M1i
         mAjUqW3eqFIJu1SMh+2Y9WqSXE1Dyv+MTdTdSiobfbm6hG5jEGP8tRTC/g6ORj/CORU+
         Gw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779668275; x=1780273075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaSDzKlmI30tM3vzrC91iG6UAQkmcMv9Cxww3HRJAEE=;
        b=q6IS1kgmi5zrbqtiFALg33sfksWRIC+dcofO9acD7FYbvKx4UaYzij4bSKaSprQatq
         hTqQ42N+iFMRkRaJdbg1yH0hNj1pwg8xrDf+evBsc4nzoERTc85su6Phi5Yda+KZrgMF
         S6TUxT+JR+pHbWcZCEeS8xshSbnj3/gBRvqXqs73Njo0OW+L66zEsijReCsm82Y7WbU8
         C3Hp28+GSCh/2ga5YcpbX9vViWdOrHKoif33HHbEqZod294p3k8JXQODX44fUpIUN1o5
         5/Ml5yEzgZETxRhQB9y7qGHSb5SNnzeHWO9MlW220FnfvMxzuHKmMj5C9CE+xCgZ/JUj
         toOA==
X-Forwarded-Encrypted: i=1; AFNElJ/BtacURJOxjcoPLIAkYgoztSpyow4y72O0RhGHR9YJJZTIdgnxbGsT+H09KBgpMfxG5O13EeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBylPITSsJzZxJ244D/eomsbtHrhIY6QA5kcgcbzxphjj3wzC
	2LktQgJLcH97OYTq5HlbTv84Vg/aITsG1NJZ//sTgveQtZk85FLsx51A9hYM+O8bZJ3Vapy9Qua
	9bV5ZWw==
X-Received: from pfoa25.prod.google.com ([2002:aa7:8659:0:b0:82f:49f6:76e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a0a:b0:841:5701:16d8
 with SMTP id d2e1a72fcca58-8415f6aca3dmr11576256b3a.38.1779668274724; Sun, 24
 May 2026 17:17:54 -0700 (PDT)
Date: Mon, 25 May 2026 00:17:22 +0000
In-Reply-To: <20260525001745.1251640-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525001745.1251640-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525001745.1251640-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 4/5] geneve: Add dualstack flag to struct geneve_config.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291223-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.944];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C84DA5C5018
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


