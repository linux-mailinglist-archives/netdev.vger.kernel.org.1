Return-Path: <netdev+bounces-294573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kkoiGXDIH2p+pwAAu9opvQ
	(envelope-from <netdev+bounces-294573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:23:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF36349FF
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:23:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=hcg+UMcD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294573-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294573-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2528300E3BE
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BB3F8EC3;
	Wed,  3 Jun 2026 06:20:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946D3F54C3
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467655; cv=none; b=Pu9/whjsRD1+2G9pK7dJjvkXOApiMJPIbfxF4idlGNgtrm34WjuP37MR4XVsEKIRx3xEN7X/NtgCRU7DsazkYVaXprVkAG5toRWEZN5NlvxuQCQHr1QTXCdl7ZkS+FLLH7UZHXlgdBXNttYLE758uLLY/ZS20Cyl43ZpwgEhGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467655; c=relaxed/simple;
	bh=d6n7Vl1jTydvct7TlwCBMQ/CXDzuo/bCLpen20DWzF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hfi2E+jVzqoFlxKoGhVTvgD9IUqKYMWXLmFlPxbj25v4E2kbR6xTP/BeCtVaaSm6gufKBhgwpoN6pyCqZlEaig1XSHw1XtwECHr32Nf3IchHaCsZs6aBpIis8ZuORlOntEJNEsMmD6luvQoozqG2Wruw+IIRjrNuMpI6U00o1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcg+UMcD; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-9157ae36434so273111885a.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467653; x=1781072453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5p5wR1WAxrF2smYm/DJM232M/Fl2LwG4jjSzzxq6EY=;
        b=hcg+UMcDsyQkGe9sG7nn5I+tIDx2VyG3vEfwUI6kAwoVVJco3RtKBKQS+vh5Z+iSnx
         +wj87gtW8ANbtZm3wnHEV9tHcPETH5gEdZMXCMQlvnmVDTjZrg+R9q8LzuRiQVjtEwEG
         HMWCcYINjTMR5TjiWBfoBZnd1kk6hhUBvbP81cBQxg3ppFEDGipn/W3o0vLrBoOXAy9W
         nCUQJR7by8QupJrkO6ERAd0XWIlCBCxOtPdalITjhvtcxQG5PiqTPS65wga+aDvL8kKX
         qWj2+zesElJuSXA09TKytCfl1Yy4x6WGXmcOzDmijevL3UDV8KYhBFBHkplJvkivjWXZ
         v69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467653; x=1781072453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5p5wR1WAxrF2smYm/DJM232M/Fl2LwG4jjSzzxq6EY=;
        b=W20Xsf82im3xnUB4J6yU155DKVcns1K8wIfLxCXMePJmIrRVjyNsD9hFydrRlbvtE4
         sXZzw80ZvPp+INDdaklJHsPoWdFEJldyciDnTIThdi1VXPdcW4XBEx35itbcx+aDAhZg
         X2+sJtFhgWSETFMAAxLnFHDpnAPsXNIYnnAsiR/3qIMp7ywfmUw0omwDo7UcLevkOst5
         7x24EEw+IMClyKX5ZI6d4sIDJxjQSak58tN8xuLH+uPYjN9oq1BdeDXLJ/uwB8lZ1BU6
         Hcmb7RaHVGYBAWNzZdNPp0QN+7xvsS7twhGIjt4sFOdG4pfTIBFOEemwrXg9RlJRmlIK
         LSdw==
X-Forwarded-Encrypted: i=1; AFNElJ+uPgwD8uFnCt5q+XUT026NV4+/sAuLKR4SP9xO+T9SN656aVa0trI6m/XN0Dnn+UnU3xc6NfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeP0OViG2+3ilJod43Ghf5p6VIzp91MQPAvP/RMYCbDwrhhVCz
	cTWfWTQXmYVW7y3NvRV9QBgWxPuEdkbJBPt2qmPKSw6NRQzlkIq7X+JKTx07NTrSPD97xb9SnfG
	98ltagqhtccV5bA==
X-Received: from qkbp5.prod.google.com ([2002:a05:620a:6f45:b0:915:7ded:9f6d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:28c9:b0:8d7:cf69:3bf5 with SMTP id af79cd13be357-9158a68d218mr349345185a.14.1780467652726;
 Tue, 02 Jun 2026 23:20:52 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:37 +0000
In-Reply-To: <20260603062043.3911278-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603062043.3911278-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/11] bridge: provide lockless access to p->path_cost
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
	TAGGED_FROM(0.00)[bounces-294573-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BABF36349FF

Add READ_ONCE()/WRITE_ONCE() annotations around p->path_cost.

This is needed at least for sysfs show_path_cost(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
2.54.0.1013.g208068f2d8-goog


