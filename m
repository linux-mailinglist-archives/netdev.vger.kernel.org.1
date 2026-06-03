Return-Path: <netdev+bounces-294575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zJjmNcHIH2qSpwAAu9opvQ
	(envelope-from <netdev+bounces-294575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:25:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 313AD634A23
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="sC+M/XG3";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294575-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294575-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F2630FA198
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401023F9A1E;
	Wed,  3 Jun 2026 06:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669403F0ABE
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467659; cv=none; b=lS/1bh7ok7XjpoG5q3Oui5lccUGux7Lcb4OtGutYAq6xuE4co2yBU0cNWs+r8Wn1HwzYfSdeMyFJZXBt3b3GRWdcCrKhnDcTsN8mIBW+qZExs+6+XOZgIKxK92U3p6P1BHMNlFMc2KFvWErsDnxsRRsZBFgNipqqV4fim7lz62M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467659; c=relaxed/simple;
	bh=0G93zVY1SLdyma+DCkdcmbT+PJe1SuZ6O1ebb8BObnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=erb4nj3/Q8KgKbgvHG1L3Sc4DHVq+QdaIktJJUd5r8gpIs9fzSXWeYL3iWiynxY+Wo5Y3CEaOpMP1Ezxb+29EF3XbX7kfRdL1PWznG0c32MgJuwh/utS85mf2vUEnjc5p/dWW39MaA0lI+w8Ry8Aj4c5yyteTTJgwazsqP0ftEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sC+M/XG3; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51776d4355cso8473411cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467654; x=1781072454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oT77AGxMjexM6ND0pIvgSYBakklisnkUmzNgDlHbjyw=;
        b=sC+M/XG35H++J8yaJCa/DOkft9z7kKhf5Efm5KOIYTFaGTvfA3s32bkT8IXCPXRV1b
         IY9Sv86AtPHYfT9d0g7tglDrhuMlgyyB7uF/qbOaS/mgAEZOMXFxDq53Rzy2u57hsgyY
         yaOAChzfB4x7hbK/DelZZCh3Xt+Sd/mKajf//k2D1SbLnAWUolmGunj7CqGCFOZQkD2S
         mZOwy3J0skaJPEcfWQTbixT6Q/uhgOhG5skpTUKrbhVK5sk0i0oULFGrLjqwDXgifrVT
         2+TQJrtU2CwwRUc4s5wm8dFzKcSN/arpgPeC7qiE+M2u0oCNxOjSqzxSGL31KvuvpclY
         M5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467654; x=1781072454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT77AGxMjexM6ND0pIvgSYBakklisnkUmzNgDlHbjyw=;
        b=TLN+wbU3e0QnBBFr8HN9Jmac/PtQW6yUNYS3P+xwyqmf74hI70vPRg9pVIzZgt2mOi
         knEztuo+xg2GpDPj7kjrFIYfGCr/aJNwxEdPqi1gG+1YQuvNDyLiztmQ7xAbVxM+TOo0
         BS56dYjZ4ISZRgl+tbVAngKYDzHND1PAHjKOsHafkxjwenAo7e4tHhfl8M3IFkg7zcKU
         Gv6IYVAu9H8+3wQ8zfaBil7XKqSUTVQv0JHRnmPSxfRliiR2lV2wX8den91FYatAL2CK
         +5nOT1hLR87nk7gpLwzEa1uSxzdp+9dkfglm83FNzX7uHtaOD1y+MCsD7MmeaElCC10n
         K3bg==
X-Forwarded-Encrypted: i=1; AFNElJ/8dbHvMPaQMNDEGV63TxMFxSCNuT7Dg3rBodkorkgHhq49l5Mm9aa3NwckVxn19ZHvYoB4XtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrm1JKGpOhT1y/Zh+iywvOtKoIJxNVysEIpxKKCzh8U/tF5duC
	nfWPdoOBsjWbur+HjQhysU0f8z7XfaSfLSaDipbWgFVrOepJFvHvQ8Wdj2Ki1kDsWyoIE7xHmvo
	ubipctMuC9uhvfg==
X-Received: from qto11.prod.google.com ([2002:a05:622a:a6cb:b0:517:6007:8eef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:50e:b0:50d:7ca3:379a with SMTP id d75a77b69052e-5177968b0dbmr24587051cf.3.1780467654164;
 Tue, 02 Jun 2026 23:20:54 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:38 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/11] bridge: provide lockless access to p->designated_cost
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294575-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
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
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 313AD634A23

Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_cost

This is needed at least for sysfs show_designated_cost(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_ioctl.c    |  2 +-
 net/bridge/br_netlink.c  |  3 ++-
 net/bridge/br_stp.c      | 28 ++++++++++++++++------------
 net/bridge/br_sysfs_if.c |  2 +-
 4 files changed, 20 insertions(+), 15 deletions(-)

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
index 2d9d0823aa56b63a62ed51c49df54055294e82ad..88da86a6ba4406ac77d0b13e0a340e87e281c11a 100644
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
@@ -302,9 +304,10 @@ static int br_should_become_designated_port(const struct net_bridge_port *p)
 	if (memcmp(&p->designated_root, &br->designated_root, 8))
 		return 1;
 
-	if (br->root_path_cost < p->designated_cost)
+	t = br->root_path_cost - READ_ONCE(p->designated_cost);
+	if (t < 0)
 		return 1;
-	else if (br->root_path_cost > p->designated_cost)
+	else if (t > 0)
 		return 0;
 
 	t = memcmp(&br->bridge_id, &p->designated_bridge, 8);
@@ -344,9 +347,10 @@ static int br_supersedes_port_info(const struct net_bridge_port *p,
 	else if (t > 0)
 		return 0;
 
-	if (bpdu->root_path_cost < p->designated_cost)
+	t = bpdu->root_path_cost < READ_ONCE(p->designated_cost);
+	if (t < 0)
 		return 1;
-	else if (bpdu->root_path_cost > p->designated_cost)
+	else if (t > 0)
 		return 0;
 
 	t = memcmp(&bpdu->bridge_id, &p->designated_bridge, 8);
@@ -426,7 +430,7 @@ void br_become_designated_port(struct net_bridge_port *p)
 
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
2.54.0.1013.g208068f2d8-goog


