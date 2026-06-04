Return-Path: <netdev+bounces-295275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z0JZBgiKIWq7IQEAu9opvQ
	(envelope-from <netdev+bounces-295275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:22:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB49640CC3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:21:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WsJiriEp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295275-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295275-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C376230B6592
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239F480351;
	Thu,  4 Jun 2026 14:13:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001ED480DD9
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582439; cv=none; b=YyUnO5Fk3vYZKtJuU+dRO+x8HhOxbdlqYiVFdpZh0x6NDeXggloSRYUdbmsCfn2UhRhqFQsJEGuSEZrHrTg0aCA+d/9lOqA8bSX+inRReN7ZIgXG8heTHVwMG4aQD/iZ6zO4LrxY8bM0ewLUDOQqjcg2gDxQTvoeGy+gbkDLb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582439; c=relaxed/simple;
	bh=7VHWPKqAs+lFmD6EjUp4srr0peJ0LC1wrO8uSy6+CC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NA1yagqiuD7Uk54J1zgavzvHvBipuALeKnP3LRi3uxogMOfppRyyFONQQRZQ3mkpS/YONAdWVdXyxCD53WKLuIo77TBKGMIO3OQyF/f4J0rdyBqwxOA6dtx+gJbJ+dDw+XwOJXrgFDSO1a+S+fhXDvGUFbeFQvatYXw+57FVGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WsJiriEp; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ce9df49c6bso11327956d6.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582435; x=1781187235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFGnhIAQXoOgLxSPkBbaqHxTMFsQ3SubAoulQhXM8yg=;
        b=WsJiriEpuETl/7pAR82SK2Rx0btvKY8RBGKMb22DESJSryHD8TdFDAvmvzPWv9Aks0
         +aovOvGWJLB6pK67zv2cdHv+M6koImepCicIc8Qzeo4Wqh7eqfx4/L4AmHxIEZgKJ3rx
         5czmwK1bbm95982NCsnynLhSX9NeuHXEvTW3AgOy2C3rcvJNHNzjaAVjUAwv+R+Tw3uJ
         9yIqQipyVcmKCn/VB8hrJ499w091tC0s4/LEpwYYnf/Z2quDYmXn77SzID8abhkTwcDR
         EvQhbZKSefUjOwJL4j20/pBPr6ppFRTniQ3XByaEg5CEKi28LqhIa0GCWom89kbOkzl7
         UGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582435; x=1781187235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFGnhIAQXoOgLxSPkBbaqHxTMFsQ3SubAoulQhXM8yg=;
        b=lB8G5WMed9FOpfxdne3bsgGcT5FKbwF2od5UbEkiF1rfrvsZ6J5KFBoAVdwNTP4Gf5
         2RQOPxdtMI7S9r0glHP86zW94qDH2txI5ZtrJDCmUJVu9wcY1aEYveNzd2sqk5tVvO26
         RsL4Wl5HCJSwGE0oQ3iAvlPIZ10gXCu2ImUT/bPP5kt1IH5hA5aaNQsYhsYWwWTRaIhW
         6q+cpvUdLXre3aAB1LCHjwlCaU6ptVs+Pe7kVAWhpT/QV9ghlMLNmbI0Ne06daB5NvMb
         gYWxjEQ5lKeem0IU3qYCWA/lDXAQ3ZMuGKaG+EXudSbsLuYafpqMm7gfDBbdIhrPYgHV
         Bkeg==
X-Forwarded-Encrypted: i=1; AFNElJ8gyqKEHGj1p3Pd3iO2aH/VIe2IfSihpou4NBenDtDSyfPwGCuXUg//OmUoVrzIgpJpih6VVUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoaImcIpqaPDGu5Ucmvjerqi6MqI5+ORHlB9or9BElAFs+6wrH
	t1PnMaN6PtDOie6Bbqf7bgXBx3wQXbfCm2sK2v60yc9beB+kdvkaT+iOz7FCMpOnoZe74OUshcV
	BqGtTB6s/Uci1Gg==
X-Received: from qvbpc12.prod.google.com ([2002:a05:6214:488c:b0:8ce:ba08:fbef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:578a:b0:8cc:f7b7:bf8c with SMTP id 6a1803df08f44-8cecdbfce32mr131870076d6.5.1780582434445;
 Thu, 04 Jun 2026 07:13:54 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:38 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-7-edumazet@google.com>
Subject: [PATCH v3 net-next 06/11] bridge: provide lockless access to p->designated_cost
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295275-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEB49640CC3

Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_cost

This is needed at least for sysfs show_designated_cost(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_ioctl.c    |  2 +-
 net/bridge/br_netlink.c  |  3 ++-
 net/bridge/br_stp.c      | 30 ++++++++++++++++++------------
 net/bridge/br_sysfs_if.c |  2 +-
 4 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 07cfcb821e27ebcb72901a365a3f06491f8b0bc3..a507c7b369ac49803019cdca7836c7fb9ef4459e 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -260,7 +260,7 @@ int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 		p.port_id = pt->port_id;
 		p.designated_port = pt->designated_port;
 		p.path_cost = READ_ONCE(pt->path_cost);
-		p.designated_cost = pt->designated_cost;
+		p.designated_cost = READ_ONCE(pt->designated_cost);
 		p.state = pt->state;
 		p.top_change_ack = pt->topology_change_ack;
 		p.config_pending = pt->config_pending;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 08718ebe282aa1d089a127cdc7c24fda5a0a38a5..296f62ebdd4a6f3d404b5902fe661995bd1ca0f5 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -264,7 +264,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put(skb, IFLA_BRPORT_BRIDGE_ID, sizeof(struct ifla_bridge_id),
 		    &p->designated_bridge) ||
 	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_PORT, p->designated_port) ||
-	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_COST, p->designated_cost) ||
+	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_COST,
+			READ_ONCE(p->designated_cost)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_ID, p->port_id) ||
 	    nla_put_u16(skb, IFLA_BRPORT_NO, p->port_no) ||
 	    nla_put_u8(skb, IFLA_BRPORT_TOPOLOGY_CHANGE_ACK,
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 2d9d0823aa56b63a62ed51c49df54055294e82ad..ced8d23f05d1ee262d1760c768e5c88868f13178 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -102,7 +102,7 @@ struct net_bridge_port *br_get_port(struct net_bridge *br, u16 port_no)
 static int br_should_become_root_port(const struct net_bridge_port *p,
 				      u16 root_port)
 {
-	u32 p_path_cost, rp_path_cost;
+	u32 p_path_cost, rp_path_cost, p_designated_cost, rp_designated_cost;
 	struct net_bridge_port *rp;
 	struct net_bridge *br;
 	int t;
@@ -128,12 +128,14 @@ static int br_should_become_root_port(const struct net_bridge_port *p,
 
 	p_path_cost = READ_ONCE(p->path_cost);
 	rp_path_cost = READ_ONCE(rp->path_cost);
+	p_designated_cost = READ_ONCE(p->designated_cost);
+	rp_designated_cost = READ_ONCE(rp->designated_cost);
 
-	if (p->designated_cost + p_path_cost <
-	    rp->designated_cost + rp_path_cost)
+	if (p_designated_cost + p_path_cost <
+	    rp_designated_cost + rp_path_cost)
 		return 1;
-	else if (p->designated_cost + p_path_cost >
-		 rp->designated_cost + rp_path_cost)
+	else if (p_designated_cost + p_path_cost >
+		 rp_designated_cost + rp_path_cost)
 		return 0;
 
 	t = memcmp(&p->designated_bridge, &rp->designated_bridge, 8);
@@ -191,7 +193,7 @@ static void br_root_selection(struct net_bridge *br)
 	} else {
 		p = br_get_port(br, root_port);
 		br->designated_root = p->designated_root;
-		br->root_path_cost = p->designated_cost +
+		br->root_path_cost = READ_ONCE(p->designated_cost) +
 				     READ_ONCE(p->path_cost);
 	}
 }
@@ -257,7 +259,7 @@ static void br_record_config_information(struct net_bridge_port *p,
 					 const struct br_config_bpdu *bpdu)
 {
 	p->designated_root = bpdu->root;
-	p->designated_cost = bpdu->root_path_cost;
+	WRITE_ONCE(p->designated_cost, bpdu->root_path_cost);
 	p->designated_bridge = bpdu->bridge_id;
 	p->designated_port = bpdu->port_id;
 	p->designated_age = jiffies - bpdu->message_age;
@@ -293,6 +295,7 @@ void br_transmit_tcn(struct net_bridge *br)
 static int br_should_become_designated_port(const struct net_bridge_port *p)
 {
 	struct net_bridge *br;
+	u32 p_designated_cost;
 	int t;
 
 	br = p->br;
@@ -302,9 +305,10 @@ static int br_should_become_designated_port(const struct net_bridge_port *p)
 	if (memcmp(&p->designated_root, &br->designated_root, 8))
 		return 1;
 
-	if (br->root_path_cost < p->designated_cost)
+	p_designated_cost = READ_ONCE(p->designated_cost);
+	if (br->root_path_cost < p_designated_cost)
 		return 1;
-	else if (br->root_path_cost > p->designated_cost)
+	else if (br->root_path_cost > p_designated_cost)
 		return 0;
 
 	t = memcmp(&br->bridge_id, &p->designated_bridge, 8);
@@ -336,6 +340,7 @@ static void br_designated_port_selection(struct net_bridge *br)
 static int br_supersedes_port_info(const struct net_bridge_port *p,
 				   const struct br_config_bpdu *bpdu)
 {
+	u32 p_designated_cost;
 	int t;
 
 	t = memcmp(&bpdu->root, &p->designated_root, 8);
@@ -344,9 +349,10 @@ static int br_supersedes_port_info(const struct net_bridge_port *p,
 	else if (t > 0)
 		return 0;
 
-	if (bpdu->root_path_cost < p->designated_cost)
+	p_designated_cost = READ_ONCE(p->designated_cost);
+	if (bpdu->root_path_cost < p_designated_cost)
 		return 1;
-	else if (bpdu->root_path_cost > p->designated_cost)
+	else if (bpdu->root_path_cost > p_designated_cost)
 		return 0;
 
 	t = memcmp(&bpdu->bridge_id, &p->designated_bridge, 8);
@@ -426,7 +432,7 @@ void br_become_designated_port(struct net_bridge_port *p)
 
 	br = p->br;
 	p->designated_root = br->designated_root;
-	p->designated_cost = br->root_path_cost;
+	WRITE_ONCE(p->designated_cost, br->root_path_cost);
 	p->designated_bridge = br->bridge_id;
 	p->designated_port = p->port_id;
 }
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 23574476d7f701080452777ab2c23a42b4defba4..36b832902d33a492e91d53a4248778b3ee2322ca 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -135,7 +135,7 @@ static BRPORT_ATTR(designated_port, 0444, show_designated_port, NULL);
 
 static ssize_t show_designated_cost(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->designated_cost);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->designated_cost));
 }
 static BRPORT_ATTR(designated_cost, 0444, show_designated_cost, NULL);
 
-- 
2.54.0.1032.g2f8565e1d1-goog


