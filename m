Return-Path: <netdev+bounces-294579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T9X8Af7IH2qepwAAu9opvQ
	(envelope-from <netdev+bounces-294579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:26:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ABC634A37
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:26:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=DMtGJOVW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294579-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294579-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96ED13110822
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020863F9A1E;
	Wed,  3 Jun 2026 06:21:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E96331A7B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:21:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467663; cv=none; b=F6KWC3JuNs8BMw44ewXEc6txhE7e3s4W6466j4RUwcCUNqJIcSlVNmt+3Fvnd/onTdLUO3YxXcSdA+AOJvxXwWDsCRuHC4Eyag0AxCsZOnmsM+rH4qveSSlWPRIpXLZCt/2DSv2d2x4mQ7KyjdcRsfwH/l94FLVkoEyKMUn2DVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467663; c=relaxed/simple;
	bh=37dYseTBJ3qtvhHw84eO5OhCMorR8W7PuHtZbxgUvCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZpSsB/80wSFM7nV+76TZAWR0W1L3GMuFadnYHCax/6wSSr+KZ4V3dSe+mlZv8V4J/02kKyu2hevjybkLNm9skR4rNRj2v7633m4Z3f27hoVkRWniS5p4Vvy8DkU9wW54nqqBWKFGtuzdo6q9KINjgmmFHaQS227HPxHFNaMxjoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMtGJOVW; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5176cc5bf2aso21008391cf.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467662; x=1781072462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W61nrj3kd0RTpYPrBH9HWVse8n+RRFsy6wqLuJq3N8g=;
        b=DMtGJOVW+58gXjZpv8DDu7sDDLQzMV0y3ZYqCaBBLE4RlHMjSZ5ErND4LbaAtHVJAq
         mpXdnAOAAPEocmWKCgF0CVTjk5U64gLR2CoYEAiwwK44RXbNjqzEO8jpJ2zCufqvB3QD
         lJvHR2XT08uCANNxGSliqooOxd0G8LITdwYkrJiON9pVPCEqYSA4EmB5vEvaWyPo5lt/
         k7cixQzIeVvv4XFKxefTUYP6kxyd7a0QxMg8AYcd6BmLu5iOaT3k8dCkabrCCxH2JpjP
         9SkqkQx9zrGtgJtgALQnREyoa2TdXo7jh2GOY+7CWwliwcTXli/QIjZBIc9cHplhVpa1
         86SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467662; x=1781072462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W61nrj3kd0RTpYPrBH9HWVse8n+RRFsy6wqLuJq3N8g=;
        b=scwFcbkQ8bix7y1Tiix8TgNWyoWVQMKMbJ2VTOG4ngnERO6XEFzT1yUJZtRdcjl7am
         5coCuBRerQCsYElPbeQlEuBSeAYpfRfSAqvAOajCjbO8808c/9e9lu5S7UiNX26nOlME
         2Fxmoo4h7eEWneUZ1e9Ar0NQSbi2hoqTqeSzgfFk1ET2DDLe+E0FVnKV3jAx+9TMXFnU
         6lp8TnJ/7x7JC/uj0aDrhPJ+ED36CxT3grhHakZLWv3KWTanC6HgMdmWHwE6nsNGvX2g
         Gjqvq5Mr/UgMQApdNWK1/CEOGbyd5V5K37RJc/2jfvRLLDqzGmrt1TBlaLZl/viN9c19
         jnHg==
X-Forwarded-Encrypted: i=1; AFNElJ/1rqyJgcMiKbVDreDdqfkDHTNj58/tIQ48cCHtaVX5vVRve0+mtZd34szKmraAcN/CIB2QoxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyThrKfNAtYjqralsssj/cvi+51GsF8CUzsDOf877POP87qCd/R
	lvElACQMc/u8rLYc23WwvI+/iC7cU1yzJjHoXL7y1cjOq62PKFWwD3cTnRKrCfYW/TZ93Skzlyh
	OGq98efQpWxZ1yw==
X-Received: from qtns11.prod.google.com ([2002:ac8:528b:0:b0:517:710d:afde])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1391:b0:517:7063:49d4 with SMTP id d75a77b69052e-5177873be2bmr31841751cf.47.1780467661572;
 Tue, 02 Jun 2026 23:21:01 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:43 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/11] bridge: read p->flags once in br_port_fill_attrs()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294579-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53ABC634A37

We might run br_port_fill_attrs() locklessly in the future.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_netlink.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index ead66dbe1bb7679af18d5f0c2fdea6be2574727d..7cb24de9c77d3d15892723f77288c27a15a6a0ad 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -234,7 +234,8 @@ static inline size_t br_nlmsg_size(struct net_device *dev, u32 filter_mask)
 static int br_port_fill_attrs(struct sk_buff *skb,
 			      const struct net_bridge_port *p)
 {
-	u8 mode = !!(p->flags & BR_HAIRPIN_MODE);
+	unsigned long flags = READ_ONCE(p->flags);
+	u8 mode = !!(flags & BR_HAIRPIN_MODE);
 	struct net_bridge_port *backup_p;
 	u64 timerval;
 
@@ -242,23 +243,23 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put_u16(skb, IFLA_BRPORT_PRIORITY, READ_ONCE(p->priority)) ||
 	    nla_put_u32(skb, IFLA_BRPORT_COST, READ_ONCE(p->path_cost)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MODE, mode) ||
-	    nla_put_u8(skb, IFLA_BRPORT_GUARD, !!(p->flags & BR_BPDU_GUARD)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_GUARD, !!(flags & BR_BPDU_GUARD)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_PROTECT,
-		       !!(p->flags & BR_ROOT_BLOCK)) ||
+		       !!(flags & BR_ROOT_BLOCK)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_FAST_LEAVE,
-		       !!(p->flags & BR_MULTICAST_FAST_LEAVE)) ||
+		       !!(flags & BR_MULTICAST_FAST_LEAVE)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MCAST_TO_UCAST,
-		       !!(p->flags & BR_MULTICAST_TO_UNICAST)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_LEARNING, !!(p->flags & BR_LEARNING)) ||
+		       !!(flags & BR_MULTICAST_TO_UNICAST)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_LEARNING, !!(flags & BR_LEARNING)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_UNICAST_FLOOD,
-		       !!(p->flags & BR_FLOOD)) ||
+		       !!(flags & BR_FLOOD)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MCAST_FLOOD,
-		       !!(p->flags & BR_MCAST_FLOOD)) ||
+		       !!(flags & BR_MCAST_FLOOD)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_BCAST_FLOOD,
-		       !!(p->flags & BR_BCAST_FLOOD)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_PROXYARP, !!(p->flags & BR_PROXYARP)) ||
+		       !!(flags & BR_BCAST_FLOOD)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_PROXYARP, !!(flags & BR_PROXYARP)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_PROXYARP_WIFI,
-		       !!(p->flags & BR_PROXYARP_WIFI)) ||
+		       !!(flags & BR_PROXYARP_WIFI)) ||
 	    nla_put(skb, IFLA_BRPORT_ROOT_ID, sizeof(struct ifla_bridge_id),
 		    &p->designated_root) ||
 	    nla_put(skb, IFLA_BRPORT_BRIDGE_ID, sizeof(struct ifla_bridge_id),
@@ -272,22 +273,22 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put_u8(skb, IFLA_BRPORT_TOPOLOGY_CHANGE_ACK,
 		       p->topology_change_ack) ||
 	    nla_put_u8(skb, IFLA_BRPORT_CONFIG_PENDING, READ_ONCE(p->config_pending)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_VLAN_TUNNEL, !!(p->flags &
+	    nla_put_u8(skb, IFLA_BRPORT_VLAN_TUNNEL, !!(flags &
 							BR_VLAN_TUNNEL)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_GROUP_FWD_MASK, p->group_fwd_mask) ||
 	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_SUPPRESS,
-		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, !!(p->flags &
+		       !!(flags & BR_NEIGH_SUPPRESS)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, !!(flags &
 							  BR_MRP_LOST_CONT)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
-		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & BR_PORT_LOCKED)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_MAB, !!(p->flags & BR_PORT_MAB)) ||
+		       !!(flags & BR_MRP_LOST_IN_CONT)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(flags & BR_ISOLATED)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(flags & BR_PORT_LOCKED)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_MAB, !!(flags & BR_PORT_MAB)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
-		       !!(p->flags & BR_NEIGH_VLAN_SUPPRESS)) ||
+		       !!(flags & BR_NEIGH_VLAN_SUPPRESS)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
-		       !!(p->flags & BR_NEIGH_FORWARD_GRAT)))
+		       !!(flags & BR_NEIGH_FORWARD_GRAT)))
 		return -EMSGSIZE;
 
 	timerval = br_timer_value(&p->message_age_timer);
-- 
2.54.0.1013.g208068f2d8-goog


