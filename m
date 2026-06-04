Return-Path: <netdev+bounces-295274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uZNENluKIWrkIQEAu9opvQ
	(envelope-from <netdev+bounces-295274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:23:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F82B640D05
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:23:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GJ8vJKXA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295274-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295274-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E10A2300FB65
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404C047DF84;
	Thu,  4 Jun 2026 14:13:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB3480DEC
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582438; cv=none; b=Lq3lulwelDSkzfpgv5b5Gle1EHXQTP4Jv8ZjUp7Iz0BebWM7HKuys9r+CydH7IGuU2et2bhvX3b+cEUWVT3HDSg+ule4fh3A0bOBQbT6ioUVgxbDoVP0dDL+OxxRAS312HXK/M2a4GB/8ITHd7jMM4KFyWewZUPORm9RFZecN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582438; c=relaxed/simple;
	bh=JJAyCzr2Ms5q02lL1wcBykL/03uLnSwGRV5lO3cwnok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iMq56jyyp6KlUT0tBCeTfvVCJaZA2JB1Drgx8slTrE6WCKHOjxbS9Bo4+PeFTDB6vOENNU+vaOWw5ZAejG0i95Y29kWQR1tmabymyEgpCNV7oYUdJKrTiOL4zpLiWSzEWO9ICKELCHNPnFEOv6hSQ1j5wWdHU6jGY+7wjhNCwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJ8vJKXA; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8cceaca5671so19027996d6.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582433; x=1781187233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0ErtnGqwCrDj0++WOhDpCRhAXkucY+DdnmEuEhSWkU=;
        b=GJ8vJKXAhQ5bROSD8An411Jcy4QrZePnk9ENsi2t+61MO93xErwKTzwz2yqDHnWrVA
         yATqjtcGM6hcVIfODfQAlOoIO/Vc+KVzJ9k9Nn1R09ejoaDqlK3JvvflDUFTBYnZ+/2l
         XBfdo6WPS6fK3BXRbHYKVF04GLe6F4DtHf0hxblDsQ6viQmb7ozTN2NOwM65WMTJm6Fp
         5gfAQK068/Zz2893pub18GUtCGLjRPUwgzmHvoBMAx7wx62nDEsYlsyHQ6O7cpLCUaxG
         QvGii6rblqmec/j2GYa8EIrDASaA7xCKnrCnjBsvVjynLwrvjNkzo2i5lELbmJrkQNSz
         g4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582433; x=1781187233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0ErtnGqwCrDj0++WOhDpCRhAXkucY+DdnmEuEhSWkU=;
        b=g9m/WGv/oMYugoPD9ckApbPaPlRaH9f+nSgS3+S6Hc4G+zklOVML6w2cyd4AMuh4mA
         zOumLNwgGsMGpEGcIRjg+HGJYQJ00988y/89BZc0ffdZYoovL3NI1hA7xLnyxH2wXI5O
         msIIF6o7hOk6GESPm4rkQyc34n6Y/dDsYvVFmYQ1E4e2kB2CLupP7qCPwBiPFUoGIPIn
         Ci/bsXPXwUBjVh6XscpcpotgOGGCOVpnrxptlqTaUHCmDDOkqNp0nKRWPw2kQLa3NRBQ
         3vAkSzs5dNpK2o7KlZ4K/4LLV3mNDWNcxp4xwQqLpYNS92KMjVGwgD+MgJsw2prBiB5R
         0SNg==
X-Forwarded-Encrypted: i=1; AFNElJ8iyQxrGAuZkBrNEVSHw0TvVw3UmhNvZyJtsPI2OG84Fy0/tmBSkT5eQSIXJAyt74nIp9Jvu8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK31cGoxR+pVbNmzuKoTJsb4rxPD0/H88IcqPVIUD4fy4H5pqe
	LyReAyH6N0528PzLzJtN3Q5sGvFsCckcufaKbLvhG+WblWrS+5PC4sya4VbkT1CY8O2Or+1qZNr
	SKKvRJCVZ6+AaXA==
X-Received: from qkav7.prod.google.com ([2002:a05:620a:a287:b0:915:a3f6:54d3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f01:b0:912:c611:8109 with SMTP id af79cd13be357-9158a82d429mr1323103785a.55.1780582432874;
 Thu, 04 Jun 2026 07:13:52 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:37 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-6-edumazet@google.com>
Subject: [PATCH v3 net-next 05/11] bridge: provide lockless access to p->path_cost
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
	TAGGED_FROM(0.00)[bounces-295274-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F82B640D05

Add READ_ONCE()/WRITE_ONCE() annotations around p->path_cost.

This is needed at least for sysfs show_path_cost(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_if.c       |  2 +-
 net/bridge/br_ioctl.c    |  2 +-
 net/bridge/br_netlink.c  |  2 +-
 net/bridge/br_stp.c      | 17 +++++++++++------
 net/bridge/br_stp_if.c   |  2 +-
 net/bridge/br_sysfs_if.c |  2 +-
 6 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 0bd5cf925fa321b785e3578d6e99d8d7003fa89f..ab012e4762998fe8a133dd551e7f4f0efc6718c6 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -77,7 +77,7 @@ void br_port_carrier_check(struct net_bridge_port *p, bool *notified)
 
 	if (!test_bit(BR_ADMIN_COST_BIT, &p->flags) &&
 	    netif_running(dev) && netif_oper_up(dev))
-		p->path_cost = port_cost(dev);
+		WRITE_ONCE(p->path_cost, port_cost(dev));
 
 	*notified = false;
 	if (!netif_running(br->dev))
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 766c43b327af830a80fba11c940ba34eb03c50c9..07cfcb821e27ebcb72901a365a3f06491f8b0bc3 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -259,7 +259,7 @@ int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 		memcpy(&p.designated_bridge, &pt->designated_bridge, 8);
 		p.port_id = pt->port_id;
 		p.designated_port = pt->designated_port;
-		p.path_cost = pt->path_cost;
+		p.path_cost = READ_ONCE(pt->path_cost);
 		p.designated_cost = pt->designated_cost;
 		p.state = pt->state;
 		p.top_change_ack = pt->topology_change_ack;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index a104b25c871d263e4b5701f1be05cb17fbfce28f..08718ebe282aa1d089a127cdc7c24fda5a0a38a5 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -240,7 +240,7 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 
 	if (nla_put_u8(skb, IFLA_BRPORT_STATE, p->state) ||
 	    nla_put_u16(skb, IFLA_BRPORT_PRIORITY, p->priority) ||
-	    nla_put_u32(skb, IFLA_BRPORT_COST, p->path_cost) ||
+	    nla_put_u32(skb, IFLA_BRPORT_COST, READ_ONCE(p->path_cost)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MODE, mode) ||
 	    nla_put_u8(skb, IFLA_BRPORT_GUARD, !!(p->flags & BR_BPDU_GUARD)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_PROTECT,
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 024210f95468308066827ac2ae71f68f99fa77f5..2d9d0823aa56b63a62ed51c49df54055294e82ad 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -102,8 +102,9 @@ struct net_bridge_port *br_get_port(struct net_bridge *br, u16 port_no)
 static int br_should_become_root_port(const struct net_bridge_port *p,
 				      u16 root_port)
 {
-	struct net_bridge *br;
+	u32 p_path_cost, rp_path_cost;
 	struct net_bridge_port *rp;
+	struct net_bridge *br;
 	int t;
 
 	br = p->br;
@@ -125,11 +126,14 @@ static int br_should_become_root_port(const struct net_bridge_port *p,
 	else if (t > 0)
 		return 0;
 
-	if (p->designated_cost + p->path_cost <
-	    rp->designated_cost + rp->path_cost)
+	p_path_cost = READ_ONCE(p->path_cost);
+	rp_path_cost = READ_ONCE(rp->path_cost);
+
+	if (p->designated_cost + p_path_cost <
+	    rp->designated_cost + rp_path_cost)
 		return 1;
-	else if (p->designated_cost + p->path_cost >
-		 rp->designated_cost + rp->path_cost)
+	else if (p->designated_cost + p_path_cost >
+		 rp->designated_cost + rp_path_cost)
 		return 0;
 
 	t = memcmp(&p->designated_bridge, &rp->designated_bridge, 8);
@@ -187,7 +191,8 @@ static void br_root_selection(struct net_bridge *br)
 	} else {
 		p = br_get_port(br, root_port);
 		br->designated_root = p->designated_root;
-		br->root_path_cost = p->designated_cost + p->path_cost;
+		br->root_path_cost = p->designated_cost +
+				     READ_ONCE(p->path_cost);
 	}
 }
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index b29dc97b9ad8a5b5c56517d34fe426abd00e2ad6..e5d43492d2dcf0615ee984bc190d7ce2264aaab0 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -341,7 +341,7 @@ int br_stp_set_path_cost(struct net_bridge_port *p, unsigned long path_cost)
 		return -ERANGE;
 
 	set_bit(BR_ADMIN_COST_BIT, &p->flags);
-	p->path_cost = path_cost;
+	WRITE_ONCE(p->path_cost, path_cost);
 	br_configuration_update(p->br);
 	br_port_state_selection(p->br);
 	return 0;
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index d6df81fa0d13fe7e732b69f881b947da2066d9ef..23574476d7f701080452777ab2c23a42b4defba4 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -83,7 +83,7 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 
 static ssize_t show_path_cost(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->path_cost);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->path_cost));
 }
 
 static int store_path_cost(struct net_bridge_port *p, unsigned long v)
-- 
2.54.0.1032.g2f8565e1d1-goog


