Return-Path: <netdev+bounces-294574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y2D7NgvIH2pwpwAAu9opvQ
	(envelope-from <netdev+bounces-294574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:22:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EB06349D7
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:22:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="murJXmy/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294574-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294574-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC1DD304F3B6
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEDA391E7E;
	Wed,  3 Jun 2026 06:20:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C403F54DF
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467658; cv=none; b=TC4Etvb2713c4RTU4BqNwogxZk09Ox/YwyEztxHwaFcYWyZ4+Bt2Va+/u/F1D0WAtrWRKgHqEySJ7WAah6TEih+gpCe69rdvkryUMcAapVzCD6m1jgHR31amijgqHa+htRGpyJtEH81QQWNcKwsh7MUaho0XhjDZBp8vjRnBcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467658; c=relaxed/simple;
	bh=LSuy9b1fGok3PfIIU/tNPymxIysfZmAhymqP09Xrx/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ls4WAqoMfoPikmFIydubeotBukZYYdh3/YQWG+6Q3QXxkS3lAhcA+xiXoNPtmkvvZjJULovp93tHbWsEc7ENCvcDP6fHgTMLZHTg6JjlwCJ0yLZeC3p6EHj81n23tQodwA0dzpvaWtD/8oS4uDdYYaiDlQ2PYu+SS1EclIVGkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=murJXmy/; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-914b4036b15so2173631385a.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467651; x=1781072451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BeqI20pd92uXTHi8WfNjS+J3ndB0Kb5QA4GefcLnqk=;
        b=murJXmy/vY6yucrZGsa12h3B7Pnb8bW96fUkBWuc1MFIIgDInEmtwNhzLxinV2/GyL
         6j1yUSHnjceZ04du0e4c4jgepTRy01XO0zaR9jrPrYhajTMh1es9O3Jmnb3kOruxw/+6
         EqrJk6Dmi9ilpJzHyWny9peUcZlqEb/b/NFSAWCRmMLDnvmpxwXnnSKg9i7u/yv2eV+/
         83FEJ2m/4iKnYsgk/x7ZedCjqlSzekMCuTdAZHn8fo64F2osWdYaEuTVAOuk2kMS/6gV
         7L31ZPtoCcdLGy2ecbOjz8OGGcaOaq7Rexmnh+cLGZ3q3zVfeW5YKc2P1i+ePnlj/Fkw
         6rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467651; x=1781072451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BeqI20pd92uXTHi8WfNjS+J3ndB0Kb5QA4GefcLnqk=;
        b=CsySAkqznSExMOk9CjGj7ClKq+rlTLAjYldMQORp7yTlELiz1oyv1hNbu/2OBmIbf8
         p0MH3qYOacfQL1vv5P1GgwQiHbL2SlIrbcvCtK6DEImlzR1daMIqjQS8v/OcqJtRhT6N
         /nDnAY/Khpm+l9lLgV8/KZTvB3n1yN/8Wdarqcy5/bQka9VKWkZ97Po7kHwJcCLmbPON
         GmpTdR55sQCPbuaKeHz3Tzf+ic78djQIOzJBlNJN41FfVohxoC40flFjLR6xE6n46n4o
         M4qeESTC88r+la2D/29OguhPVYTSPYaNgb011z0cbnPv3LKSkD2Zi/oOO6LRVDTIwt5q
         X2SA==
X-Forwarded-Encrypted: i=1; AFNElJ++thzp0l8XemWVEChGiNWZKUqLPml3r8pM45VAKb0wlUuYwtIOpFeOPuPZZ33Tlqz/3493wsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8WSSAN5sPA4bLnvtiTsNhXu0+EaxN2P+LNjRhA6ohjVdtlJv
	2kAjKSbmnYXwcTWeRetpgwNs3eVwwdCvs+fEIJsxgBiwyh5Y3mDJjILlEB7cr9E/FSKITMjnG4E
	UdrjCI5/AxLv51A==
X-Received: from qknqx8.prod.google.com ([2002:a05:620a:8b88:b0:915:8e08:f270])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6505:b0:914:e3dd:17e1 with SMTP id af79cd13be357-9158a64470cmr359687485a.5.1780467651434;
 Tue, 02 Jun 2026 23:20:51 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:36 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/11] bridge: use BR_ADMIN_COST_BIT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294574-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58EB06349D7

Use set_bit() and test_bit() lockless functions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_if.c     | 2 +-
 net/bridge/br_stp_if.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 3169fab686a534cf2a6458ff228eee2b6fc7e7e4..0bd5cf925fa321b785e3578d6e99d8d7003fa89f 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -75,7 +75,7 @@ void br_port_carrier_check(struct net_bridge_port *p, bool *notified)
 	struct net_device *dev = p->dev;
 	struct net_bridge *br = p->br;
 
-	if (!(p->flags & BR_ADMIN_COST) &&
+	if (!test_bit(BR_ADMIN_COST_BIT, &p->flags) &&
 	    netif_running(dev) && netif_oper_up(dev))
 		p->path_cost = port_cost(dev);
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 28c1d3f7e22f6e0a0edd8b3b3f501ea7acc31394..b29dc97b9ad8a5b5c56517d34fe426abd00e2ad6 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -340,7 +340,7 @@ int br_stp_set_path_cost(struct net_bridge_port *p, unsigned long path_cost)
 	    path_cost > BR_MAX_PATH_COST)
 		return -ERANGE;
 
-	p->flags |= BR_ADMIN_COST;
+	set_bit(BR_ADMIN_COST_BIT, &p->flags);
 	p->path_cost = path_cost;
 	br_configuration_update(p->br);
 	br_port_state_selection(p->br);
-- 
2.54.0.1013.g208068f2d8-goog


