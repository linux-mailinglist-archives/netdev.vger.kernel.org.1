Return-Path: <netdev+bounces-295272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dV17GieKIWrJIQEAu9opvQ
	(envelope-from <netdev+bounces-295272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:22:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E98B6640CD8
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:22:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=n7+23Z1h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295272-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295272-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2569930F1DF5
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464E480DD2;
	Thu,  4 Jun 2026 14:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43947ECF5
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582432; cv=none; b=DWzlsoYpuUsVIRrXTphG7vjcqmDRtOfA34LnoKFAeszv9GH3jOyq7jUdYdUgou73VcVeCYDgo97z21VR5S2vAegF5MAh0l73tVC9U0wo4p7HjbbJPG6xDKlSxCVbCIUe6z3O9sEnpoC9URkC6xGGZbXLgg+xNu3vQIxX48qa1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582432; c=relaxed/simple;
	bh=POr3eyUGAyc5ULaCDNkfRIvdqgVxy5RHMxLSTfYMbsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PnOTT7/V+WdnWDNexhCGodL8u+xdjEniNr4tzu5yEFOEzs+/M1uvyWmSaypSnlCFX8K3T2LxzznSd6Ig6ciLpEhcZwEnLapaGfZE2AVVnaZCHrMpwDt2Z5wV656Q+KWp1kQY5/KoDp/dK9JCMr1mgDWcrM55uA7F7tMZ2w1utZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7+23Z1h; arc=none smtp.client-ip=209.85.217.74
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-6cfdce65690so237271137.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582430; x=1781187230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLGppRKOeTQ5cgIjidrnIM6CQ+1GuyfYOVSxBmi+wAI=;
        b=n7+23Z1h4PQ2Zc4J/qBxQvIB7IVbt/w9fourkMLtzPmvpsiifXreSx5s7FSo3CQ8/7
         jLCJLQ+NDMxgS63PEtSdw+7orRzvCeGEvfSzwTeh/WF82LRISe6Rv6M1rapCeoTZMaRo
         opLAim1A5KhM/D9JC1TcafNJXbPi/EXiSY2AfJKr3uEvAC0iHyDPx4ufVf6/2jULw9b5
         mf57SRaa2GMuWhKeJwJ+v4Go44mf2C4cec6F2GtgWrjhjKtcb28L7kB3OeGJgMEYYh6r
         smKkELRd6RobJPuWTTO2Ly/kgmrTNOljGz2Vmq+QLTwVU9aZpEQV3iIGUWd3YVUw7S7L
         pgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582430; x=1781187230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLGppRKOeTQ5cgIjidrnIM6CQ+1GuyfYOVSxBmi+wAI=;
        b=nj6ZbM1KhXF5xiIOqUGUulguFAfiWugSsMQKXiW1sKAAGQoAnBkkJlFgBy+SGytcGU
         AJ5YpHvU4K37HTusNHpcVp3FENyGZXmVYHoOTOEHAuNd3ea8BpqlPeR/vS86gS5krfZS
         2vKS33j8b5f0IFzYbJeRYWVIlchW31jPGVe2w9UrKniWW9uKEpPTMNN6ID5wcJMLwuOY
         SAjPFN3LqC+6Y+zbRu55VTT8vyJq9lhCH0Nk6ur94VZ2fE1QpI5EkHgpRcDImDtJwLJu
         jhkXO+ZlFq/+3QuVOaQ56AXv7z0kKD5vrVfMLtZt4Dh1WN1So92SNIujBvByE1ZHyEm2
         cX8A==
X-Forwarded-Encrypted: i=1; AFNElJ9MCVpq9iyk68VlEEZwUDMOSQnw9WkNs/cHPhGMYEUDtJ4d4PdjxYO+CqM8BaXnujAHqJ3BxdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyygqv0kT0ORVPTCkhmXfr74SulPkB5KJKeQ4GQj4Les89dROmM
	jlgahKCaO8d07dnKJRkukB2F6MRrgGyfad9e7OLBL3K3JZE6cVzQjerDKiwYFr5IImTgyuaX0TT
	PKUSJwTvg41NpkQ==
X-Received: from qvrc16.prod.google.com ([2002:a05:6214:50:b0:8be:7f13:3987])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5812:b0:632:29a5:2b28 with SMTP id ada2fe7eead31-6ec2b17b508mr4812154137.6.1780582429913;
 Thu, 04 Jun 2026 07:13:49 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:35 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-4-edumazet@google.com>
Subject: [PATCH v3 net-next 03/11] bridge: use BR_PROMISC_BIT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295272-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,blackwall.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E98B6640CD8

Use BR_PROMISC_BIT and set_bit(), clear_bit() and test_bit() lockless
functions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_if.c      | 4 ++--
 net/bridge/br_private.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index d39571e13744431f5e4c67f34ee7de34eb8bb6b0..3169fab686a534cf2a6458ff228eee2b6fc7e7e4 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -110,7 +110,7 @@ static void br_port_set_promisc(struct net_bridge_port *p)
 		return;
 
 	br_fdb_unsync_static(p->br, p);
-	p->flags |= BR_PROMISC;
+	set_bit(BR_PROMISC_BIT, &p->flags);
 }
 
 static void br_port_clear_promisc(struct net_bridge_port *p)
@@ -133,7 +133,7 @@ static void br_port_clear_promisc(struct net_bridge_port *p)
 		return;
 
 	dev_set_promiscuity(p->dev, -1);
-	p->flags &= ~BR_PROMISC;
+	clear_bit(BR_PROMISC_BIT, &p->flags);
 }
 
 /* When a port is added or removed or when certain port flags
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 02671e648dac7ab6fd59b80e044f62b00a8e4a8a..d55ea9516e3e369bb9e0045fca5b8d034ef5a45f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -452,7 +452,7 @@ struct net_bridge_port {
 #define kobj_to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
 
 #define br_auto_port(p) ((p)->flags & BR_AUTO_MASK)
-#define br_promisc_port(p) ((p)->flags & BR_PROMISC)
+#define br_promisc_port(p) test_bit(BR_PROMISC_BIT, &(p)->flags)
 
 static inline struct net_bridge_port *br_port_get_rcu(const struct net_device *dev)
 {
-- 
2.54.0.1032.g2f8565e1d1-goog


