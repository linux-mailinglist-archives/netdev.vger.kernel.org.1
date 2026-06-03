Return-Path: <netdev+bounces-294577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3PoIEe/IH2qapwAAu9opvQ
	(envelope-from <netdev+bounces-294577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:25:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96446634A2E
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tMUHYkgp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294577-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294577-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E580D310AA17
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03633F88B5;
	Wed,  3 Jun 2026 06:21:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A536922D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467663; cv=none; b=uVsrIKTkkg1aCskz/m3+RZZjxhc9rSR6RVwmg+kJtx7SAju1MvACORzgMyZMG22HlPkV8id4Td3lBO4Xj8OHabsJt2vu3mdrP9oKY5TfbrmsIuIzf51diRFej+6c4mjjufKpo0wwH0vTJ8ot0BsCR/ej83Ira5tzeWX5C02Xtw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467663; c=relaxed/simple;
	bh=AmP1t+JlLaSmidYsSfhD3U4FrrzJy3+kfQxb7fut5iE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BZTr/PbUwuGVR/4BqZeG6bAGbOL7W8lJqSS0NjObyvNWJZaBqiPqgWPKjEB4CLfcFP2Q5MhqWo+XPkweVrBlNgKfguHAcan0fSkDmuFi3yQh3ulAap4+FBLXBwfxGCytpu1/Voot5A7lZW5/b4s7hQzeT3zhHghTNyrtilTR61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMUHYkgp; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-914b616c670so1596168385a.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467659; x=1781072459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yP97rsr9rLpkIFKIomLZuarY5tn2NM0TN9r3V4vrnRs=;
        b=tMUHYkgp4CL+AC+qExsWzekUiAz2zHTYnSMuG6VyXmO5jUm1E30lKvWzWGaOLeihuL
         oQrBF/W6SRvcnE+LzXYCEtif/KNCTg9pS3XaD1iwVHeirN1VTD8rIi0gqtkU9eFEM9pM
         S2Ll7GzbL29cR3RO1SAL0LEBQ/MW2YK3/THvcgsUkqQcoPz0ZuxhUQZ8svAmyH0jctb+
         ywHhY+aqnsoMRrGSArcqJrKsJEmQfVdvyPmzE1HeBPth4aGX5kAhWSqve3+m2EGhf50u
         vvdUn1PkDHfR1refSEQfM+G4EWBpr+I+TmqHjKQpKFRedZK7xci3cGHINcnEau8fM3kl
         4ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467659; x=1781072459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yP97rsr9rLpkIFKIomLZuarY5tn2NM0TN9r3V4vrnRs=;
        b=XEeelmDeVK0YjoPD5urEFFJ/UUufVy74bAbOJ76kFuT5ZAWoe5FQ8Noza+EG02RTX3
         LETkx1h7CWhCMGgGmBJDeK8riu+8qcVFN9QHhLRRoZ7ngONJggotJOA9tbEO49HJ60iB
         7g5H0V/1nm2Ds/7jOFnwNOn8a1tur322v6xFSNQP37BpBSFg/80sIgkawrrEKH5wuR8G
         VAJfcsydrQZtOqk9f5/YYWEeA9vXjjBvFt2JCXghAbjcAhGv/iGIqJIb0LkgQHiwuOBx
         k+d3tLb9OQFuTTRzrRygYBqLrRuWtMqfT7q8rYOzHKTFUTvj5p3fSz1NOa0OdtmTxZYI
         LxqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YQreI53LkImgPqEQTcSjln+QEOoLhF/j0nHs23vNQBO8UVpnhMc5K9kWJD4h3xHM3fD4Ucig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EueAxiYodhaqxSOZhpZcjGCwVfNEe8vGMX8aLktXXNm9rU9p
	Uy+sbGse6OoTwYZJX0gWskN1Z/27lUiPei+vZzDOafWWQsn5q9amPq1Um5wppA0ZaEdSKI7mS7O
	9BrLzAPsfEX9B4A==
X-Received: from qknte19-n2.prod.google.com ([2002:a05:620a:2413:20b0:915:24c0:2c55])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:800e:b0:915:5cbd:1d96 with SMTP id af79cd13be357-9158a81255fmr334709485a.33.1780467658472;
 Tue, 02 Jun 2026 23:20:58 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:41 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/11] bridge: provide lockless access to p->port_id
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294577-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 96446634A2E

sysfs show_port_id() and BRCTL_GET_PORT_INFO need this.

This will be needed for upcoming RTNL avoidance in "ip link"
dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_ioctl.c    | 2 +-
 net/bridge/br_netlink.c  | 2 +-
 net/bridge/br_stp_if.c   | 4 ++--
 net/bridge/br_sysfs_if.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 2be802991f70ab3ce48ade5da6d1488e072dbec6..a017374c6e659498d98c6af3f8d8e46a8b93570e 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -257,7 +257,7 @@ int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 		memset(&p, 0, sizeof(struct __port_info));
 		memcpy(&p.designated_root, &pt->designated_root, 8);
 		memcpy(&p.designated_bridge, &pt->designated_bridge, 8);
-		p.port_id = pt->port_id;
+		p.port_id = READ_ONCE(pt->port_id);
 		p.designated_port = READ_ONCE(pt->designated_port);
 		p.path_cost = READ_ONCE(pt->path_cost);
 		p.designated_cost = READ_ONCE(pt->designated_cost);
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index fc25c6b6cc9713080873976f443da1fbd764aafe..f8266a7a9e2b910f1b4e08792b2940ae0fd2bba2 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -267,7 +267,7 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 			READ_ONCE(p->designated_port)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_COST,
 			READ_ONCE(p->designated_cost)) ||
-	    nla_put_u16(skb, IFLA_BRPORT_ID, p->port_id) ||
+	    nla_put_u16(skb, IFLA_BRPORT_ID, READ_ONCE(p->port_id)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_NO, p->port_no) ||
 	    nla_put_u8(skb, IFLA_BRPORT_TOPOLOGY_CHANGE_ACK,
 		       p->topology_change_ack) ||
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 3524bb7e87f0586774a883720be9fa8eb60f0370..8a418f6af423ccba88fae57d2254e35e1ae4a1a0 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -34,7 +34,7 @@ void br_init_port(struct net_bridge_port *p)
 {
 	int err;
 
-	p->port_id = br_make_port_id(p->priority, p->port_no);
+	WRITE_ONCE(p->port_id, br_make_port_id(p->priority, p->port_no));
 	br_become_designated_port(p);
 	br_set_state(p, BR_STATE_BLOCKING);
 	p->topology_change_ack = 0;
@@ -322,7 +322,7 @@ int br_stp_set_port_priority(struct net_bridge_port *p, unsigned long newprio)
 	if (br_is_designated_port(p))
 		WRITE_ONCE(p->designated_port, new_port_id);
 
-	p->port_id = new_port_id;
+	WRITE_ONCE(p->port_id, new_port_id);
 	WRITE_ONCE(p->priority, newprio);
 	if (!memcmp(&p->br->bridge_id, &p->designated_bridge, 8) &&
 	    p->port_id < p->designated_port) {
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 3f666d4fef42324a4751779153ecc48bdb44b85a..1cc474ed0fdc02234a9f9d6b936247c34cbb127d 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -141,7 +141,7 @@ static BRPORT_ATTR(designated_cost, 0444, show_designated_cost, NULL);
 
 static ssize_t show_port_id(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "0x%x\n", p->port_id);
+	return sysfs_emit(buf, "0x%x\n", READ_ONCE(p->port_id));
 }
 static BRPORT_ATTR(port_id, 0444, show_port_id, NULL);
 
-- 
2.54.0.1013.g208068f2d8-goog


