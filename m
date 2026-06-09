Return-Path: <netdev+bounces-296961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lX8TG97LJ2p82QIAu9opvQ
	(envelope-from <netdev+bounces-296961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:16:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3265DA54
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:16:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tVRuRBs+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296961-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296961-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53BF13070F29
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6733E92BD;
	Tue,  9 Jun 2026 08:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2683E9C0E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:08:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992527; cv=none; b=TgGSWUbw8BMYawUE96erEQrGjU4U1dQeOD4ALKSLdmvxePwDpclSCB8NH/w3oyDrRVA9naxhZ35DVpoyVzN2BCGPVWpznWucuYpVbtoBiN3ZhxNWFsvx6waykrsq+TK97jwCCOhb5PIk4sE6apa+1y5u2qusSO70PlCZ6A4SoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992527; c=relaxed/simple;
	bh=8WR66mdG2wJIxh3GHsDuBSok2Ne4cq1p54o8TFN78w8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fuVvB6a+LevnDp14icF9XMyg2WIRLSMKCFVcKcWXg7h/DvaWZ9wm6/BjkbTtWamw7j+UGXzWplvJs7EHwpxz7YZh+SS1Yuthe5PqaZWLaCclGSNi0A9CzOae5eJS+G5+Xx1qZFIZHhnVak/NDCosl94zHDSE6O3nLhVXNENo7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVRuRBs+; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5177f07eb05so102573431cf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780992525; x=1781597325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+c2syMm9J81MHCXfam1hqz2H3Vjky7FvytH6D9mv8co=;
        b=tVRuRBs+uuyx05OWGO6MiUpzymbsgpv0B2RVrNWQ3to6W9nQGniVgAvNnkxoU06zBw
         a3cf2xSCjQt4Zn4LWLuqSwEkWQRis7TEHc8ysIYhnO+UsmFMx2JTVeBiHJexA/VacuMp
         IOi1+Zw3AB1vAm8JJY9V/o6R8WmnnGccHFuZ441ESpnWrnlA1uaAUzkowKSu9ry/T7Sg
         0XRUrkHiZqNRzkzuKfC4CETLdmsqt3ii11zHmrexdFqYMWWpMYASQcOSyYv6If1kFtD8
         pagsqb6fUnbAgvD7m7xMZNUWfK+FVsCGuPbtFaSYISx3V795mR+rH3o6CNggF6A5Pbsd
         fRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992525; x=1781597325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+c2syMm9J81MHCXfam1hqz2H3Vjky7FvytH6D9mv8co=;
        b=m5KgwqH7yfng6SN8qC8qrxhl+ylgYUWrvPDL9anq8ZgYX7QS3n4cl6yof4Lk22ebji
         qal9UxkDdwt9c7KPpBSbNdlRvAGEFVDPHuxgexYS3JOQ3JA9EWYMIGtAQXSRZR/dQgI4
         rPZMBe4OPUL+0YkfG9rA0b0v/AP2mldmp4jbOhgNubgkqXW7dj7mqIe7uDBmxnXeQBNE
         F5s6psSRvRYRQfGwIHw8e0Ctg6q7MAXoOLiZsntqAVhm7DiW2kQe1TAegGCEGYWW28M1
         vQx1Fe0tu2EXRAg/Pct0Ing1cAsueMlXJuvH3MUo4pN09HmsuZGyKfmICXUwABOPpbh+
         9WKg==
X-Forwarded-Encrypted: i=1; AFNElJ85anG72HXidEm2cci5oFocouFfCk2Q0Ut/hwAJwXv5qxzPATirNpx5Qu8ztrYhClvIp0o5qFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1B90lqtZzuFOgiJ3MoScZhPf4eWrPEFjkUGr0c+RjGO2W+ns
	Lwxkjbr8gfD7sOmrF/xFcFbpr36o5TprssEF764GQGy7oFFm0rlcZUEg+g/7om7rS1i5T9H8Nx+
	3CCUOD2zAOt+S3g==
X-Received: from qvbel15.prod.google.com ([2002:ad4:59cf:0:b0:8bb:f102:30ab])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:93:b0:517:895f:1935 with SMTP id d75a77b69052e-51795a96a45mr264124431cf.13.1780992524373;
 Tue, 09 Jun 2026 01:08:44 -0700 (PDT)
Date: Tue,  9 Jun 2026 08:08:36 +0000
In-Reply-To: <20260609080839.2506801-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609080839.2506801-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609080839.2506801-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] bridge: use atomic ops to read/change p->flags
 in br_netlink.c
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-296961-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0F3265DA54

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
2.54.0.1064.gd145956f57-goog


