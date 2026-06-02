Return-Path: <netdev+bounces-294366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jFUwEropH2o7iQAAu9opvQ
	(envelope-from <netdev+bounces-294366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:06:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EAA6314AA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:06:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=QUUJtD2P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294366-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294366-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CC05301F998
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166313A6B9D;
	Tue,  2 Jun 2026 19:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1A3A63E3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:04:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427084; cv=none; b=XoMr5JAI+xNmIfdQGWoEX80fsXjoE4/8eo6Oi+NzVnvNujm21Xc/fQXbaSKL1DYE1439uwyJYND9slTzf98icfHMWS9lr+wG6e6sZJCcOOCrqwMiwOT41F906QZGdBCv5fQDi6KF/ob74Jla68TJaprmW+5M2hlmAF9sQnl5HaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427084; c=relaxed/simple;
	bh=Zgif0igdQQMspA1oBTWsmEZzC0rgoGUZtBv0C48908c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WWVL2dR4wmXbvX5q46qwIwRW3uOp5Evlzn6d6F0HRYdgVQC3/LO/WmJC/WOZvVR8bazVwJxvysDgN9aeFa41T92TWNPJQAfGDLV96JwL1fpS0Aq0qpqqIkdIFJFERhb8bYq49RhilqRrHl4gib2/+FdgvkhORKNxfP9ygQhz1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUUJtD2P; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2f19558so1953754a12.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780427082; x=1781031882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnSI4J+CBWDclbQGZosSxbGTKid6nBzQTErk+VxUuNM=;
        b=QUUJtD2PDDsgpv+JDQccoubWES0YQZ2tC8Mea51V4+dhE+00hbbgIA+qrNYofGoixg
         PlYy8xERGkd5rLQmPv4QzhPObmlEU087tg7iB/mpf0825HFDF1qEH6kvbxddOG86d72z
         /xqiEXlUA9JBjE2pC4V+F4rcCGCEPxGmLRlbfBOJTS6qz3Zw/6sx6iDIx7vr7WYTfY7u
         iKxO2Lf+OagniYkIytBV0DqTu+Qzc2VzLsd5DXDcsI/5CSoeKUank//sTX3GbYyLBUon
         JjqSDXOEP6qny5wHAyz/qFm7hhAGdmUbOgxTn930xu7Y8LeSy7GD6EgKRBn7pbC4MRvx
         EdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780427082; x=1781031882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnSI4J+CBWDclbQGZosSxbGTKid6nBzQTErk+VxUuNM=;
        b=luRMKgcW4Xv9i36CERvvrQhz4gw2ovFOKgxxl7lXmZQ4JQ9+deXDJHJ8OxL9TRJQLP
         0OG3m0b4et0ipfw0rKJLYYs+p98WTsbVFb3jNwjBZI/tv07+ELWShwWfbnDHdmiWJkpQ
         MBgnFuYSslr8aDiMVqBw2FJCLbV1F9e3RzW1cVqkGCWnCIqqszsV+lXpFZA/IUrkf4aq
         AecwRFHteeZljmiNH0VEMRLBbilP/WJ9WYQwqsAnflMrhFrj1m1dNOlSRbcyCAQ8uerM
         hnHba/FgU8n+xE7pjnVH8Q0IT6sYf2N8S4JlvWIo/n/KLSLnB0kzjy1LvmytiuTlBeWa
         2xkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Yx+1YPeVgUzhBqUKhkcvmMO+dgdH+wfwJzP+8NFNmuIiO7dQdtdnx5TfoAL9c2cPXQkSBsM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfmlP6YLYaAHRajfgiahFI7Y+XZ5f/oyGD1ZDINbWPwlheL5z
	pe0SMoadIBPDEWtRXab/75g9MM4kp3k/ZBGbgA7y9ppy/IdxbW6d1JrguwHeqc8zN4h916+ulrt
	rZU4b2w==
X-Received: from pldt6.prod.google.com ([2002:a17:903:40c6:b0:2bf:189e:7110])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a28:b0:2bf:9760:b963
 with SMTP id d9443c01a7336-2c1644cbf25mr476125ad.26.1780427081614; Tue, 02
 Jun 2026 12:04:41 -0700 (PDT)
Date: Tue,  2 Jun 2026 19:03:44 +0000
In-Reply-To: <20260602190436.139591-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602190436.139591-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602190436.139591-5-kuniyu@google.com>
Subject: [PATCH v5 net-next 4/5] geneve: Add dualstack flag to struct geneve_config.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294366-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40EAA6314AA

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
2.54.0.1013.g208068f2d8-goog


