Return-Path: <netdev+bounces-295280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AwqOOOyLIWqYIgEAu9opvQ
	(envelope-from <netdev+bounces-295280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B41640E45
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:30:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rEs8Xtdt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295280-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295280-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FEEF318F722
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0494A2E26;
	Thu,  4 Jun 2026 14:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9041481664
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:14:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582450; cv=none; b=aodaDm9gSLHmx5cqg65OJM+XJjJpdYzwPQdU2U1Kpr72xorLev5FSP1nyM3GNdFndjY64FcXbwKoIFQQOTu+nVnYSHqNZYgzjJeeLgk5pD+GCdvDFl7hm3iYozXqUNLXeIRgMPfw+4NvL9Gw8eERucoyLVfOZ9mKO08RYq5RcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582450; c=relaxed/simple;
	bh=VdjvZRMVXFT/QLSDyKdUbHxTN7R1GkYZKxK091jyH60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=juuG3Qfv/ZRpyoLiGBq6obr6QVssoH9uzc7zn0UydHjpH5B2jmJVQVSljS9k7dtzhROuoBfwhcHJWp0cuM7//OtYn2v5PYqahDLi0mnN4GBnkFAuMmH+PwN+L1ofO5dpfIbsRrlV03LKbKjBp5rmHAUWmLKllR6zocIVoYYnZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rEs8Xtdt; arc=none smtp.client-ip=209.85.128.201
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7ea35baee37so12879137b3.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582443; x=1781187243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sp27XDTaPzZKd9BCuczBBXLHFUiAehau4WzTBmOhlsM=;
        b=rEs8XtdtaJDjSrv5SlqrRPA6xKJiH6u+WHYiW63YbsokDVygI8deM4VxJU8TDSCC2g
         d+0hTmROsUJC+2t59IeGmv0Y4nFW5QRPQ5C7s+ra94wU/tG2c6lQnAkf3RzF2e+veT2u
         BNllKaFhhKSspM01LsmG6fA6yMD/bnUBFDViMyABO6tDvRWwGsVsKIUFw7eyzKUgd6tS
         p3y7dWBdSlymkF5hQSQHcM1ZD4T1+3tAlrbqCNBxEF/1yd16RTzA5vWcIamYDffTGpRW
         BrNszUveC46Yg3wA9/RMkNX32T3g/3q0zkAbnxD2Ka7SY80oZWdeCy0IB77ZhieCEBrE
         iWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582443; x=1781187243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sp27XDTaPzZKd9BCuczBBXLHFUiAehau4WzTBmOhlsM=;
        b=U0N8cJ2W569hmIc/lNg+3IyhaKUKDrpf+58LyNemkfv6EMUHOwtZMRNwayLQYzgnSv
         QHqcGuvIK5JgYnXu+yEETFmZO4jXCPHh4G/uiVD4rbUueSXKN/pqJhnjZUjwtrWYl3FW
         b8fGixnh1l24oKQ6iTAj4bxnRh/dzTNYyYVcxgu/fomKK5uz5HUXiYzSjmMOEDPGn5Yi
         DUGPMeN/1nAN1O4zs35IIQ85GSDr444OuTBV0TeXgFhsagif1+QwLEO0EJNtyuBa1vHO
         iUF0fZnT92CEfBwoT0/gHm005/wVVBTd0kPNqre6dUjH3h3btBuo+pith97tbkbHtTiX
         TRmg==
X-Forwarded-Encrypted: i=1; AFNElJ98tljk9nXFKu65PLg6hpgo8C5eofwRweaZn6KYDdtLkuzgiefoVvnbPQnTcgfiOfJTIDXgDv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyar4xxQ7rMS0mqaF963jirYo4bVKepn/niYWkkKGklvrnpLkx+
	lhcuYEVyfiJbxzS8NLZW0Z7jU8sR/4r93zDkozwx2ZNltN1GqTBCtSBDGELtj5Uy6yHzxLihJyW
	H780it1wSL6PBVQ==
X-Received: from ywbft13.prod.google.com ([2002:a05:690c:360d:b0:7b3:a433:3300])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6f0b:b0:7bd:6114:4002 with SMTP id 00721157ae682-7ea4b207ccdmr71925657b3.40.1780582442457;
 Thu, 04 Jun 2026 07:14:02 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:43 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-12-edumazet@google.com>
Subject: [PATCH v3 net-next 11/11] bridge: read p->flags once in br_port_fill_attrs()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295280-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,blackwall.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86B41640E45

We might run br_port_fill_attrs() locklessly in the future.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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
2.54.0.1032.g2f8565e1d1-goog


