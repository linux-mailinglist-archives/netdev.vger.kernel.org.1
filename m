Return-Path: <netdev+bounces-297767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qlz+HFOQKWqiZgMAu9opvQ
	(envelope-from <netdev+bounces-297767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:26:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447A66B75B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:26:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="U73/dZ/C";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297767-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297767-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10A6130A3C0D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A02EC090;
	Wed, 10 Jun 2026 16:18:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6E2F8E99
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:18:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108333; cv=none; b=BY4PuSFlKheOVj8dnfUZ5CtjGPCixk29J1+rZFWh5gKxMWYGpbQI9OQBa8gZtNsYd7Y/m7l8dbyoBt2QLr2mJn/dYNDzyRbYEoZh4Mho/UW46R5V5imQpZ3/nsVa4iGqVONvY3IyJG5fjG8Zo/nKrAC2TdkjT/L42UA66NKMQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108333; c=relaxed/simple;
	bh=TxylYeIg+o+2g015PlPvNyXDBGk26bOq3kTbmcusPp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AV4xK24jXepm9E4i4bFeR7S7A65HevpApF8oaN+VICPsVnx/KKWLX5yy360ANy9odg6TGxksABdVgffwLy7Xq/cNjQQaqyaMNs6nY6uKdINwy3nKAdhIy+KUw4MqCLPfDLRGfU/WHriJY4mixcCQjusqbKybIjFpa1jhnAlAsxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U73/dZ/C; arc=none smtp.client-ip=209.85.222.74
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-9661acbf65cso189042241.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108331; x=1781713131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2SpdGS6cUZ67Z9aXW36+XA+icCdJmYBV9QD5TQMf0vg=;
        b=U73/dZ/CEO+1E7dgE7g4+QnMO58iCEItCTueV6Nl8egQkE9c1Jb3k+g2L7dvYwfVM+
         D7o4GfYS4nRG/JOTykyYvKOqHG3+g3cPLGu3xYUokCoJVS5k4wf/oF7zLUweiFsWV/NO
         nn3Q9kJXv35Wkj6mcqAb5wa4vo+dme4Lc31BJZWt4C68jD1+lG74myB42SgoRSoE1PmT
         yj4CPXgQhHU8Tse3La0XCRVmwxso+c54rqeT7tYh8ug1AaeBW7tVdp6TaNc+/+9D8qfe
         qXZLaB7yP5FDO075hsMEPLZvtp2GNnqjxcHWWhYIPPZrHqoVa01yXIObX+Ym3TaAT3pl
         CxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108331; x=1781713131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SpdGS6cUZ67Z9aXW36+XA+icCdJmYBV9QD5TQMf0vg=;
        b=P8AYIeGs7fM8uiOo6/liDzTmlQbbZ+VMhTAdN69uRYffdUJZPaEH3YpHkuR7MeZMy3
         pWE36r9wd5uuTHE3NosC3odmWK/Ind+qjQXRzzY9y5GODiAuxvcYJUlotk+4BeDRkS8O
         QqciPw54fpCG2Bnoee6BNzZ/cH9WW3mfhRu0+YxOxx+AORc6lA7CYKoHJ5VdXMWhlE0+
         +YfOlA/2BA4TepxlHRCh8R79yZMWmqyJq1QKMQ1foU1I7k+/uI2qaKV3txPM38+Vv92D
         LZCBS4/T66TofeGzzduUIi4yIPTvDHxqTl3YEmfQdvFcsOivbSH54aqyNNr5AMNS1Ujr
         dPvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/smZDfUWOPBbTyOs1nYXtG0+LSQQBIuUFTnN+BQgBpinJCW0R+J+Tkz/kthNo4XFg6pqFR4ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTpZIjiYi5G8AW1RLz0ytczdfyoZ5DWunermWCa7yQeyQJOmL
	KAW1WjsdlxXczc+A8byyFyZlkTMLCrtTdSDz+7RxTSqLWwNgKsln5hn7ivdF3q5/1/Rpqyc8Tya
	Smjop1HVkKqPoDw==
X-Received: from qvui14.prod.google.com ([2002:a05:6214:30e:b0:8c7:2924:29a6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:808f:b0:635:420c:9b00 with SMTP id ada2fe7eead31-6fef04ef441mr15992440137.10.1781108330643;
 Wed, 10 Jun 2026 09:18:50 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:18:33 +0000
In-Reply-To: <20260610161836.1275531-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610161836.1275531-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610161836.1275531-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/5] bridge: use atomic ops to read/change
 p->flags in br_netlink.c
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297767-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0447A66B75B

Change net/bridge/br_netlink.c to use atomic operations
to read/change bits in p->flags.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_netlink.c | 97 ++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 7cb24de9c77d3d15892723f77288c27a15a6a0ad..12850f60bfcb418918508612070a6b0266ffbe6b 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -113,7 +113,7 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 	num_vlan_infos = br_get_num_vlan_infos(vg, filter_mask);
 	rcu_read_unlock();
 
-	if (p && (p->flags & BR_VLAN_TUNNEL))
+	if (p && test_bit(BR_VLAN_TUNNEL_BIT, &p->flags))
 		vinfo_sz += br_get_vlan_tunnel_info_size(vg);
 
 	/* Each VLAN is returned in bridge_vlan_info along with flags */
@@ -823,7 +823,7 @@ static int br_afspec(struct net_bridge *br,
 		err = 0;
 		switch (nla_type(attr)) {
 		case IFLA_BRIDGE_VLAN_TUNNEL_INFO:
-			if (!p || !(p->flags & BR_VLAN_TUNNEL))
+			if (!p || !test_bit(BR_VLAN_TUNNEL_BIT, &p->flags))
 				return -EINVAL;
 			err = br_parse_vlan_tunnel_info(attr, &tinfo_curr);
 			if (err)
@@ -934,58 +934,64 @@ static int br_set_port_state(struct net_bridge_port *p, u8 state)
 }
 
 /* Set/clear or port flags based on attribute */
-static void br_set_port_flag(struct net_bridge_port *p, struct nlattr *tb[],
+static unsigned long br_set_port_flag(unsigned long flags, struct nlattr *tb[],
 			     int attrtype, unsigned long mask)
 {
-	if (!tb[attrtype])
-		return;
-
-	if (nla_get_u8(tb[attrtype]))
-		p->flags |= mask;
-	else
-		p->flags &= ~mask;
+	if (tb[attrtype]) {
+		if (nla_get_u8(tb[attrtype]))
+			flags |= mask;
+		else
+			flags &= ~mask;
+	}
+	return flags;
 }
 
 /* Process bridge protocol info on port */
 static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 		      struct netlink_ext_ack *extack)
 {
-	unsigned long old_flags, changed_mask;
+	unsigned long old_flags, flags, changed_mask;
 	bool br_vlan_tunnel_old;
 	int err;
 
-	old_flags = p->flags;
+retry:
+	flags = old_flags = READ_ONCE(p->flags);
 	br_vlan_tunnel_old = (old_flags & BR_VLAN_TUNNEL) ? true : false;
 
-	br_set_port_flag(p, tb, IFLA_BRPORT_MODE, BR_HAIRPIN_MODE);
-	br_set_port_flag(p, tb, IFLA_BRPORT_GUARD, BR_BPDU_GUARD);
-	br_set_port_flag(p, tb, IFLA_BRPORT_FAST_LEAVE,
-			 BR_MULTICAST_FAST_LEAVE);
-	br_set_port_flag(p, tb, IFLA_BRPORT_PROTECT, BR_ROOT_BLOCK);
-	br_set_port_flag(p, tb, IFLA_BRPORT_LEARNING, BR_LEARNING);
-	br_set_port_flag(p, tb, IFLA_BRPORT_UNICAST_FLOOD, BR_FLOOD);
-	br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_FLOOD, BR_MCAST_FLOOD);
-	br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_TO_UCAST,
-			 BR_MULTICAST_TO_UNICAST);
-	br_set_port_flag(p, tb, IFLA_BRPORT_BCAST_FLOOD, BR_BCAST_FLOOD);
-	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP, BR_PROXYARP);
-	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP_WIFI, BR_PROXYARP_WIFI);
-	br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
-	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
-	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
-	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
-	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
-	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
-			 BR_NEIGH_VLAN_SUPPRESS);
-	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
-			 BR_NEIGH_FORWARD_GRAT);
-
-	if ((p->flags & BR_PORT_MAB) &&
-	    (!(p->flags & BR_PORT_LOCKED) || !(p->flags & BR_LEARNING))) {
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_MODE, BR_HAIRPIN_MODE);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_GUARD, BR_BPDU_GUARD);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_FAST_LEAVE,
+				 BR_MULTICAST_FAST_LEAVE);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_PROTECT, BR_ROOT_BLOCK);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_LEARNING, BR_LEARNING);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_UNICAST_FLOOD, BR_FLOOD);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_MCAST_FLOOD,
+				 BR_MCAST_FLOOD);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_MCAST_TO_UCAST,
+				 BR_MULTICAST_TO_UNICAST);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_BCAST_FLOOD,
+				 BR_BCAST_FLOOD);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_PROXYARP, BR_PROXYARP);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_PROXYARP_WIFI,
+				 BR_PROXYARP_WIFI);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_VLAN_TUNNEL,
+				 BR_VLAN_TUNNEL);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_NEIGH_SUPPRESS,
+				 BR_NEIGH_SUPPRESS);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
+				 BR_NEIGH_VLAN_SUPPRESS);
+	flags = br_set_port_flag(flags, tb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
+				 BR_NEIGH_FORWARD_GRAT);
+
+	if ((flags & BR_PORT_MAB) &&
+	    (!(flags & BR_PORT_LOCKED) || !(flags & BR_LEARNING))) {
 		NL_SET_ERR_MSG(extack, "Bridge port must be locked and have learning enabled when MAB is enabled");
-		p->flags = old_flags;
 		return -EINVAL;
-	} else if (!(p->flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB)) {
+	}
+	if (!(flags & BR_PORT_MAB) && (old_flags & BR_PORT_MAB)) {
 		struct net_bridge_fdb_flush_desc desc = {
 			.flags = BIT(BR_FDB_LOCKED),
 			.flags_mask = BIT(BR_FDB_LOCKED),
@@ -995,15 +1001,16 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 		br_fdb_flush(p->br, &desc);
 	}
 
-	changed_mask = old_flags ^ p->flags;
+	changed_mask = old_flags ^ flags;
 
-	err = br_switchdev_set_port_flag(p, p->flags, changed_mask, extack);
-	if (err) {
-		p->flags = old_flags;
+	err = br_switchdev_set_port_flag(p, flags, changed_mask, extack);
+	if (err)
 		return err;
-	}
 
-	if (br_vlan_tunnel_old && !(p->flags & BR_VLAN_TUNNEL))
+	if (cmpxchg(&p->flags, old_flags, flags) != old_flags)
+		goto retry;
+
+	if (br_vlan_tunnel_old && !(flags & BR_VLAN_TUNNEL))
 		nbp_vlan_tunnel_info_flush(p);
 
 	br_port_flags_change(p, changed_mask);
-- 
2.54.0.1099.g489fc7bff1-goog


