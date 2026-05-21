Return-Path: <netdev+bounces-290436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEPdBkUND2p7EgYAu9opvQ
	(envelope-from <netdev+bounces-290436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:48:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E55A63F3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D60B32D1AEB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE0C29E0FD;
	Thu, 21 May 2026 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p47HNVjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA83E0245
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369570; cv=none; b=o2uebvNNpSgKc2VewOFR77FDFr4L/zmV3gl/pK/niQ1bp9gOxxj1QKE05X91JVvvpTpOfgSG5NKP6L7LWIM8RX3wd3ozE9x9GjkmWM9soCOeB31vGE55jiPxIrd6Dhpw1mVJtz0oY2lUp3w0c+DkUNtxOp8O9A5kqXL84jRghcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369570; c=relaxed/simple;
	bh=PluQH3UhbOhdSwwHy8khUeh620imreZyrckOxm7V8Ec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uNXiurH136/Jx/eBuWri8P78eY+HrVK9H+fDadubYvWoTstqdnIOuA/nq8NDYIfQCy0BH+m6llRsWeTLyWmkqlevdWR3waI9rqy7Jwpyyr+Sa0qKpVruheHFSC8rApgGMDD7gMEDqXClhwI//khthMMZ6c+sQx+hekYwVjNK698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p47HNVjS; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8b58065ea15so7912266d6.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369568; x=1779974368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1jycji/ayAkcWwSIdIVlly3y8MakL6E3kLtFUixvHy0=;
        b=p47HNVjSKMP2AEBs424Yqb8TBeiysOMvPIUuBD7KtZ2dYszcKRVSqIbwAj73TbI4Il
         bRkxj64G5dgIsSBgJV4RuFIu8kcYz/Ep/jqSEDRSkD1Ft3pu30Zji6BZppBA4bhST9dz
         gpdp5iIs5M7Goy051iFhSSGxQ6RszxN0vB/CY+LZQhw2lqb5TJ9jMH5Mxp2Z9xnnkadQ
         xlzH7sI5IHPAby1xF1MWRtPjyQoz6kkT6am6KNlZmqiifeK4zp9qyttQQwwKaJxgRUXr
         E93bfhE8QPSB7T0mSDthmSzaJJd5FhkJEiroM7k0Q6JMB3urThGwssSVmDRl/cR+I7Sr
         gITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369568; x=1779974368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jycji/ayAkcWwSIdIVlly3y8MakL6E3kLtFUixvHy0=;
        b=HLc4bV6gn3WpuIXvrsIgiZanhP8I/x7gmzYq/LbjWx9wJ3NNTvDHzczf+MZNZIhQqx
         RPs7MrnbtqQN6Zk/e9tNGRrgNerHrQcZS8BS/heyIibyi6qSbyJUnFj5N80bVVh3nfEg
         2ts3oZuT/X6g7UhLk9G0tKj1uz8DlzeNIgMgQgqOMeGHgfijnu7FnIQju4bwltbh88o1
         13jDdJF8Owe6J2JjKpDEFSH9GXrYx4WIWQCpyHEUbE6ABqlzRQRfoNr9wgbNepU/YGMN
         PqFaaigFiH7mclZ0fswaDhrQuvHQ4ML/5Gw3dhsWitZ/qZfKMILRyjdAeAVWyuv1R9aX
         rbGg==
X-Forwarded-Encrypted: i=1; AFNElJ8Qd767N3UvGh0ZAe/wAJ2l5RtVY2b0hvVefsPLjd0IGi5e+yHtUYtR44gni39lsMIMX8+X6GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBoP+Y3ZhsOkYq6sPIVqgHVXR8L8xnHVQzZN0bQVcNvKBzOg8
	BWaS7JOvGcwJ4+A7RRbjqwuNLSbNzedR+JPMD3V+3cSZ0rOCzpDyzGHM2L+lAeunqDEQMx2ndMm
	MhgjrhbltYcb5SQ==
X-Received: from qvbdv5.prod.google.com ([2002:ad4:4ee5:0:b0:8ae:1b92:a1a3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3a8c:b0:8ba:b3b3:971 with SMTP id 6a1803df08f44-8cc6e3846f1mr44106806d6.32.1779369568135;
 Thu, 21 May 2026 06:19:28 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:10 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-6-edumazet@google.com>
Subject: [PATCH net-next 05/11] bridge: provide lockless access to p->path_cost
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290436-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C73E55A63F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add READ_ONCE()/WRITE_ONCE() annotations around p->path_cost.

This is needed at least for sysfs show_path_cost(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_if.c       |  2 +-
 net/bridge/br_ioctl.c    |  2 +-
 net/bridge/br_netlink.c  |  2 +-
 net/bridge/br_stp.c      | 12 +++++++-----
 net/bridge/br_stp_if.c   |  2 +-
 net/bridge/br_sysfs_if.c |  2 +-
 6 files changed, 12 insertions(+), 10 deletions(-)

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
index 898326c201ef99a1dafda820bfbfe3d428ae2bd3..1b2fbb3a8f9b18ef6479bd3a0c63fe1e761df9a7 100644
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
index 024210f95468308066827ac2ae71f68f99fa77f5..1367cd3ac4dd6a587d4a6471184453a14af6879c 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -125,11 +125,12 @@ static int br_should_become_root_port(const struct net_bridge_port *p,
 	else if (t > 0)
 		return 0;
 
-	if (p->designated_cost + p->path_cost <
-	    rp->designated_cost + rp->path_cost)
+	t = p->designated_cost + READ_ONCE(p->path_cost) -
+	    (rp->designated_cost + READ_ONCE(rp->path_cost));
+
+	if (t < 0)
 		return 1;
-	else if (p->designated_cost + p->path_cost >
-		 rp->designated_cost + rp->path_cost)
+	else if (t > 0)
 		return 0;
 
 	t = memcmp(&p->designated_bridge, &rp->designated_bridge, 8);
@@ -187,7 +188,8 @@ static void br_root_selection(struct net_bridge *br)
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
index 1f57c36a7fc097d69cbb8bd7a9348c31be6611aa..0616036a3ce45d45ba817555362f1613f5f9d6cf 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -83,7 +83,7 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 
 static ssize_t show_path_cost(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->path_cost);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->path_cost));
 }
 
 static BRPORT_ATTR(path_cost, 0644,
-- 
2.54.0.669.g59709faab0-goog


