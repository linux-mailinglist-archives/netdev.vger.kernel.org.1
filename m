Return-Path: <netdev+bounces-290437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAmcEv4KD2omEgYAu9opvQ
	(envelope-from <netdev+bounces-290437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:39:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A75A60CC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D56DA31CA378
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816483ECBE8;
	Thu, 21 May 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAzFZB3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896F3E122D
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369572; cv=none; b=PExwjwck44i/NSM3uDOrAaGXkrFthGg37OeXGjSACMipsocR+HhZCeloR8xSlKUAroghmutZsr4zM8kbCeO6cwQsekgRXE/l8SWSSVezkWDjIjGzSesZh2M51t3+jqbiryvxAb2QOoenwtHWbCqfBArGgqaVE3DozPV/DWn4i0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369572; c=relaxed/simple;
	bh=SvSxQ/tYZsIq3giL7Vhur3ZHw6/Yb+X5AI9AitLOh9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jlm6Ddzm/EgDpoafIvYn8GGXlaKrC/mLIN6Sl2FOieBbwtHv2zglqb7UtTZn7uVvf7xWmNGEZVtsTTSuh5rzC8AJ5MawAcZLpRabUyFFCAvWsT1TNtONDCTwQD9IH/7/lRwy8jj8KCryUgxf5QsyznopxbNAFMW+7iqVXgxp/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WAzFZB3X; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-516ccfa109dso3573001cf.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369570; x=1779974370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb+piz4JQitxsODudtwc8/dg4+m/PL7JkkQ4Jn2pwEo=;
        b=WAzFZB3XmZj6TIRUfeJPLAVz8uSB2S2c+01qDT+/LSGHcX/mdEywV3FX+Ng0MjzUZo
         ZGXVgJ87+/CrXrfCE1yeok1HdHc7Zs0y268FQDydRyAwhlNMknkNqv51eZtiz+RSCbkr
         U97fCGvexSQzuOMxVAh+WQ09zSeUJjuc+8OtyFke8tKAVMPiOT0oJUtuwjeeLQ8E/MT8
         WqLUU80Oszl17K80d11CIsqfEpQkpPJEsFIhN8ylqCTG5k9YjmDuFtdzAKgMEyL7NYi5
         mIZzw0N5pjQHO7Cv4cSAXRdkBgvGrPw4VXPge+pMxcIf7PXg7BVfE+29Du2Dkp/uhKaF
         R48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369570; x=1779974370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb+piz4JQitxsODudtwc8/dg4+m/PL7JkkQ4Jn2pwEo=;
        b=VWevNxkvPWGga3B9jATj35JXiGXIRmJfhz1ApcHKHQHWv2Xeq6Iahu7p4LgyAQ1W3i
         xzj7HfwGL8+jFn0IaRxnMgyy6x4FADG29F736cLDuCx5IHGyTgzjxEmBXT4nneJJL+Eu
         P+EvPJTOFurYWNKxA9Mu+HNEF1bdcma7BdoGug4jcTtpfSWoUQYFv33xSUe5sIrqVcGC
         DbXky/GeMEQKgRjE1P9vMpWXDV8QHZ8xXjDIOtjgFLanue1Rry9G7h2Chr6c1ihQN01t
         4G7ONmc0iXYv4ThkHKGSf5lgikKkT9//HaCvn15hgKWU0NUFZXAL2aRkuOb/KVBjqd4Q
         Q6wg==
X-Forwarded-Encrypted: i=1; AFNElJ/k98U1/3lLp7BaowKpeEfmK1Yu/nwj3d9rGYiY02VG6/bxr9ijSMuhjL4bvgX9dI0iZ8TMhwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KcE31WeHhme468JY/Zctax/T68Ocv5/4qc/1CAcqC0KXjvYw
	0BayImLdKHJuVFHqGMsOrRhDwDddZYgVxL/oKu2jSedrEfhzIr70NVHVHx8vfXEHsBXMU46LUUB
	+XYjoIL/JAhjtSA==
X-Received: from qtqb21.prod.google.com ([2002:ac8:5415:0:b0:509:2144:daad])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4cc5:b0:50f:bc91:709 with SMTP id d75a77b69052e-516c559eccemr36999471cf.39.1779369569455;
 Thu, 21 May 2026 06:19:29 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:11 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-7-edumazet@google.com>
Subject: [PATCH net-next 06/11] bridge: provide lockless access to p->designated_cost
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290437-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E17A75A60CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_cost

This is needed at least for sysfs show_designated_cost(), BRCTL_GET_PORT_INFO
and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_ioctl.c    |  2 +-
 net/bridge/br_netlink.c  |  3 ++-
 net/bridge/br_stp.c      | 20 +++++++++++---------
 net/bridge/br_sysfs_if.c |  2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

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
index 1b2fbb3a8f9b18ef6479bd3a0c63fe1e761df9a7..153e1cb0fbb6ea9f65933d884b9a78f5446d0de6 100644
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
index 1367cd3ac4dd6a587d4a6471184453a14af6879c..62dcac1a181c829e2736d7ab8679c870ee676a71 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -125,8 +125,8 @@ static int br_should_become_root_port(const struct net_bridge_port *p,
 	else if (t > 0)
 		return 0;
 
-	t = p->designated_cost + READ_ONCE(p->path_cost) -
-	    (rp->designated_cost + READ_ONCE(rp->path_cost));
+	t = READ_ONCE(p->designated_cost) + READ_ONCE(p->path_cost) -
+	    (READ_ONCE(rp->designated_cost) + READ_ONCE(rp->path_cost));
 
 	if (t < 0)
 		return 1;
@@ -188,7 +188,7 @@ static void br_root_selection(struct net_bridge *br)
 	} else {
 		p = br_get_port(br, root_port);
 		br->designated_root = p->designated_root;
-		br->root_path_cost = p->designated_cost +
+		br->root_path_cost = READ_ONCE(p->designated_cost) +
 				     READ_ONCE(p->path_cost);
 	}
 }
@@ -254,7 +254,7 @@ static void br_record_config_information(struct net_bridge_port *p,
 					 const struct br_config_bpdu *bpdu)
 {
 	p->designated_root = bpdu->root;
-	p->designated_cost = bpdu->root_path_cost;
+	WRITE_ONCE(p->designated_cost, bpdu->root_path_cost);
 	p->designated_bridge = bpdu->bridge_id;
 	p->designated_port = bpdu->port_id;
 	p->designated_age = jiffies - bpdu->message_age;
@@ -299,9 +299,10 @@ static int br_should_become_designated_port(const struct net_bridge_port *p)
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
@@ -341,9 +342,10 @@ static int br_supersedes_port_info(const struct net_bridge_port *p,
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
@@ -423,7 +425,7 @@ void br_become_designated_port(struct net_bridge_port *p)
 
 	br = p->br;
 	p->designated_root = br->designated_root;
-	p->designated_cost = br->root_path_cost;
+	WRITE_ONCE(p->designated_cost, br->root_path_cost);
 	p->designated_bridge = br->bridge_id;
 	p->designated_port = p->port_id;
 }
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 0616036a3ce45d45ba817555362f1613f5f9d6cf..9d560482e558aa1ef4d2f583373f15ae5db8a0f0 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -117,7 +117,7 @@ static BRPORT_ATTR(designated_port, 0444, show_designated_port, NULL);
 
 static ssize_t show_designated_cost(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->designated_cost);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->designated_cost));
 }
 static BRPORT_ATTR(designated_cost, 0444, show_designated_cost, NULL);
 
-- 
2.54.0.669.g59709faab0-goog


