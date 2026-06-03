Return-Path: <netdev+bounces-294578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PMtvJPPIH2qbpwAAu9opvQ
	(envelope-from <netdev+bounces-294578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:25:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2831B634A31
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:25:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=BuzogvLX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294578-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294578-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2592F310C376
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9003F9272;
	Wed,  3 Jun 2026 06:21:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33513F9260
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467663; cv=none; b=CoNEDVUL1kJJ1wb/TumBMqywnQUViznCB0Ms+hy0Jo4I8dg3W29IcQoX63gSyLdm+AkGNf0YfPcMSpb7LuenNMDtnP2X0KLb/WYTtycDutp7WmEhtHeFKJAYzUEU5ei+/T96EhDLCeEf2wcUXZo/2FWk9ok4f559GCpcGyGwXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467663; c=relaxed/simple;
	bh=nehgdKPTsYCzHUmFBTg1U4vwvVUZ7q4D2OO0RZZQFOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UNy3ERdiapuXV1G74AEZm1qSOqRU2rG2F0q5mS/SKnSHniTaMqx3qGlgtp9LpRVy4Odt4prMl02z40wwm4U/ZswB5rdGJ0vgzikYFxDZvuK/hpFO9I4lA/YR6yZQeqxjR+9s1ma8mZ8TCAfPSDaYVz20rihTpm4iF1eoaZJuvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuzogvLX; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5176d5d7222so30188281cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467656; x=1781072456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SwnFDChCCYANYPsTbj6wM0EsPwbDKBNzatyRpARMViE=;
        b=BuzogvLXtNsQMtiT7YsNaLDlWxMfpfk0A36P03pEJcouUvig4sYImuNPtYueTvByQT
         H7TWyEy8h1krj8rcLzDCfEgn2QntDXzhq2wdqpsP/J/vA1NTzm7eY30ei0t893N8YfD4
         w+6owQlz32kIlkcxVw8fhGr/gT0UbdSnSD2XoyiNH2hPykeoA1saK2dPjO+6d89tNX7l
         LmLZ7LKXAFO5mB6SNGgxrNwLGFRuU1SIJO6Fw9EEIKnjsj2WgXz2ARuztdehnNSCqzEB
         auQYxQGjPE+0X4qjxInAZSkn96YMN+hR0Rnyp+aGCPbX18lzg9SDvwLYsMbyAmayaCJc
         BDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467656; x=1781072456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwnFDChCCYANYPsTbj6wM0EsPwbDKBNzatyRpARMViE=;
        b=eFyrPr86SX29L5iaZ514GNNSCpL4ul8dvi779Xp1clL8l3TyOCaajK5cQGcuQHWb6s
         j+bT46RaQvbAVFTzhGifbUHFJbLXzT+8Qq4I2x+d9GiUvKetHf7wZ29vsleUtwD37Xgg
         O+pVxywB4+o7Rs4jMyki09kAXvZua0qlWt8+QO6p+gR+F00uodgUHVqxm9oQqilC/HZY
         lSM4XOn7ox40IZQLydQv69ju7/YdNzjLx0QysK9r8u3/T0qFjDNnhi1THxWVn/ATKmBC
         nkv41jTEjWxZDX67eKMXI40MnjAbi/dDKBC28x7ABwrXPMb/1QS2ucdeWkcwkehb+5A3
         gzhA==
X-Forwarded-Encrypted: i=1; AFNElJ/XR8yeanpIWFafIxgTsBYTdd/CKdmtUN09IZmbHTybq9wgFPaHLknpqXmpA64HpC+qbmL47xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+vBMzTVT7DnFnFH49lTg6C5yJtr3iaNlkGm4yavhec2NbTJq
	dakuda8obvW74ny0SR9y61O4ozyTsgsre52LsqWpC9HOc9iXuFfT18ELlp5FLMsjKAAtkKjLVyZ
	UK2u22RYTvxHT1g==
X-Received: from qto11.prod.google.com ([2002:a05:622a:a6cb:b0:517:6007:8eef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1244:b0:517:5f04:f248 with SMTP id d75a77b69052e-517785d75e2mr34297861cf.9.1780467655489;
 Tue, 02 Jun 2026 23:20:55 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:39 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/11] bridge: provide lockless access to p->designated_port
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
	TAGGED_FROM(0.00)[bounces-294578-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2831B634A31

Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_port

This is needed at least for sysfs show_designated_port(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_ioctl.c    | 2 +-
 net/bridge/br_netlink.c  | 3 ++-
 net/bridge/br_stp.c      | 4 ++--
 net/bridge/br_stp_if.c   | 2 +-
 net/bridge/br_sysfs_if.c | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index a507c7b369ac49803019cdca7836c7fb9ef4459e..2be802991f70ab3ce48ade5da6d1488e072dbec6 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -258,7 +258,7 @@ int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 		memcpy(&p.designated_root, &pt->designated_root, 8);
 		memcpy(&p.designated_bridge, &pt->designated_bridge, 8);
 		p.port_id = pt->port_id;
-		p.designated_port = pt->designated_port;
+		p.designated_port = READ_ONCE(pt->designated_port);
 		p.path_cost = READ_ONCE(pt->path_cost);
 		p.designated_cost = READ_ONCE(pt->designated_cost);
 		p.state = pt->state;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 296f62ebdd4a6f3d404b5902fe661995bd1ca0f5..a722db89aef6bbb6ecc77c7e0f173dc79418797f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -263,7 +263,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 		    &p->designated_root) ||
 	    nla_put(skb, IFLA_BRPORT_BRIDGE_ID, sizeof(struct ifla_bridge_id),
 		    &p->designated_bridge) ||
-	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_PORT, p->designated_port) ||
+	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_PORT,
+			READ_ONCE(p->designated_port)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_COST,
 			READ_ONCE(p->designated_cost)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_ID, p->port_id) ||
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 88da86a6ba4406ac77d0b13e0a340e87e281c11a..f5ea14bb8fb865045d50fb09296d0db466e8fc6e 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -261,7 +261,7 @@ static void br_record_config_information(struct net_bridge_port *p,
 	p->designated_root = bpdu->root;
 	WRITE_ONCE(p->designated_cost, bpdu->root_path_cost);
 	p->designated_bridge = bpdu->bridge_id;
-	p->designated_port = bpdu->port_id;
+	WRITE_ONCE(p->designated_port, bpdu->port_id);
 	p->designated_age = jiffies - bpdu->message_age;
 
 	mod_timer(&p->message_age_timer, jiffies
@@ -432,7 +432,7 @@ void br_become_designated_port(struct net_bridge_port *p)
 	p->designated_root = br->designated_root;
 	WRITE_ONCE(p->designated_cost, br->root_path_cost);
 	p->designated_bridge = br->bridge_id;
-	p->designated_port = p->port_id;
+	WRITE_ONCE(p->designated_port, p->port_id);
 }
 
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index e5d43492d2dcf0615ee984bc190d7ce2264aaab0..7b0d1a334785047905a00694fd65e3212b160e5d 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -320,7 +320,7 @@ int br_stp_set_port_priority(struct net_bridge_port *p, unsigned long newprio)
 
 	new_port_id = br_make_port_id(newprio, p->port_no);
 	if (br_is_designated_port(p))
-		p->designated_port = new_port_id;
+		WRITE_ONCE(p->designated_port, new_port_id);
 
 	p->port_id = new_port_id;
 	p->priority = newprio;
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 36b832902d33a492e91d53a4248778b3ee2322ca..1023f97b1c9a22a1f79c3c734aef9bd41832ea39 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -129,7 +129,7 @@ static BRPORT_ATTR(designated_bridge, 0444, show_designated_bridge, NULL);
 
 static ssize_t show_designated_port(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->designated_port);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->designated_port));
 }
 static BRPORT_ATTR(designated_port, 0444, show_designated_port, NULL);
 
-- 
2.54.0.1013.g208068f2d8-goog


