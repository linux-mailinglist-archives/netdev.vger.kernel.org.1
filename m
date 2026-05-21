Return-Path: <netdev+bounces-290442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN4FMAsLD2omEgYAu9opvQ
	(envelope-from <netdev+bounces-290442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:39:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AFF5A60E3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51E713113C48
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B93D5C26;
	Thu, 21 May 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQNVuvQ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9033E1712
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369581; cv=none; b=UoMiDmLCzPpmSXXKVl6kRG9uY+nG+JoDcvBuXJVmZqzC4cssFqsiRZVDG+GofOZS0U9JzLaRStmn4Na+ScMYJuwi9w3jqkyDCrcFGORAlOMXxlVsFamFrYH6Swnt6gs0dWX2xEZ51sf/0bLIJXDuUm1leWDBoOSap8ERCf5cOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369581; c=relaxed/simple;
	bh=iwSo3225Ab4T3QCcjAJqy5T9moRU7fSVY7bYUKYrQAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hQo5ZV++5epiE2ivqq56X5bPjyHQ30SN6FCRxeIjCCxayL02uNMB3j3VvJBfMnu1FkUoEqETIBrblO0JKmHeTPeAW3ypiO6fJVoWDKimtbYH2NTL/m8pge33DYQuyuQMXCTvBoIS/6JP5TuskRUe350umuoKfenhKvhqxP+uF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQNVuvQ/; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-9569b029e1cso3360064241.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369579; x=1779974379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=frn07daoe3BiZ4CSJik1VW975rHPbaXUl0VGErhC9jE=;
        b=dQNVuvQ/xCV3uyaHGx6bIzKql7AooLucJUmw0/W/7QHOV0a84al9pHCHV8Iv66zZHU
         niXcTPCCF11nhcB6aghBz3JA/BdGP/zp8oNQWlXlPeAeGdbdBOFDkz5jPHqwC8RY8ywK
         1K+E8ovfTS6alSbA+5UqHpIjNxz2j0HT880yOPePn/CzgPetKa5jfaQQU782zDLo8f/R
         hssLJGQ/mTNlBuo5BpDX4A6Jw3lB+xG8Rl3mptDq66g/skbaf//2e/1BqRWojTcJHAE/
         5TJv7EPBIb5rsxD5IZF1M3DkMIapRY5BPhw2fK37GTnzkdCDhwX1jr6mJ7msF3dsi7cK
         +BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369579; x=1779974379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frn07daoe3BiZ4CSJik1VW975rHPbaXUl0VGErhC9jE=;
        b=JGJb80ZGTsXfeJblp0Qq6milPHM+wVRThzBt2U9G8qF7xJ8D6Jyv1UH/rbHeIDK8kZ
         t8DZc/ibZUIIGNZ9l31Sj2Rpwh1d0/gcyo+5XC2ZvUYBACu4621J/krjeSyuXFH9+vy5
         pB0IPRZHpx7ur2DlmdNANtayc/uHOJ30p4L8C//fWd+cbCORFJMQsBgo16kHUdb1yHNW
         7KVUxI7AcxzRkLS6PdB03XbPlBaJZDkH6rdfOaRH9BjH3EXWajFCa61pPZKcAQISSyUE
         1YFqgA2KI+EPLEXteZ0Zok9J5TjZb4Eva1J89LyeKqHFtGLz4ncZ0JrCm3RkS3eLToip
         5lGg==
X-Forwarded-Encrypted: i=1; AFNElJ+te5D4vh67QRmbNmIXOR1VeqN3rN9Q29tS2EAQfD7Q1IxnlMK2pnH1D8aB68DbbS98nciFXrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsIS15WpEzQaCAxlDuSQ2iy1JxHjhcXN+zRuZXqE83LlsFQaWG
	OVI587y89iOW3mhg96jHWeEdZPl9I+zhswfhU+AJUa9I14OqXJ/Pp8W9j7/do6tgl6H+qwC1FFg
	1E9+oJua56dYxCA==
X-Received: from qkbec22.prod.google.com ([2002:a05:620a:4856:b0:914:7bd1:50dc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4a94:b0:65b:c17:70b7 with SMTP id ada2fe7eead31-6737b27d455mr1397559137.0.1779369578250;
 Thu, 21 May 2026 06:19:38 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:16 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-12-edumazet@google.com>
Subject: [PATCH net-next 11/11] bridge: read p->flags once in br_port_fill_attrs()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290442-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A0AFF5A60E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We might run br_port_fill_attrs() locklessly in the future.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_netlink.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index cc485b929d983ee4faf2541b661cad88896d39ed..26d3adec2dcbe5d5492ddf961aa221382ded9125 100644
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
2.54.0.669.g59709faab0-goog


