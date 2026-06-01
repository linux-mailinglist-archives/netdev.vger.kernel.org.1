Return-Path: <netdev+bounces-293532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAI+Kov/HGqOUwkAu9opvQ
	(envelope-from <netdev+bounces-293532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 05:42:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096B61946E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 05:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3792300B101
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 03:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE87288C2C;
	Mon,  1 Jun 2026 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi+nauqQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE069282F38
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780285318; cv=none; b=stdkhp0QgYt4/gF5Dc25C1LghHeCf2bdLPNMOS+GFOUZA6gYaYrrRSha8V/EgCy2WZDe9L8ZlLJE7bW4JIAt7LupDiB6gk28qqQ7pF0bjixOxrs4jIAiEzAGMTAfenbA6CNb7J05h6XuAqYPz3E/PUFojLqO/6FLSoF/oxV90zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780285318; c=relaxed/simple;
	bh=GEhvFyiVmNJeqdaA6eLWoM9Z2RJA8csZr6MFKMn8Zec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DK1wFdqsCTBQVwquLi+g9eCWBJj7V38TOg90dlWoulkqv5DRM8xYmk0Uqa/JkmF+bApDDAxJbuTl6LqMVDvfc8OlJOTefL5fWgyVxabH88zKlbczMhoCxrLumm0Mzwp7fRvA3me5sT73aloZx8xqoFcV/yOBCZxXKVK8ahx1jbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi+nauqQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36c68964315so767227a91.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 20:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780285315; x=1780890115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZZTE+oP6vZaNBQBkjw1JwOrw7qBKUTRNGV3G9H2hng=;
        b=Vi+nauqQZzyVIC+xrqrREWIqhHFckOf4FHmSDku3s7Ov2TIBIjlQMwrPt4pij2KRsf
         wYa8pRQ6preNqnpcJpJEX1bBE/RZVG7gnFawflbdeU39Au2Sobme6Rukpjnm9RLqQgJQ
         lEbsA/DgLIxe0kzeb+n6v9VlgzPJG3+j7/s5OlNY3jSFZkM1KquFmfYTVHTT6uLTyvqu
         abbwgX87tXaQ/94kaT6OyS0c+dmP+hCfmc0LPTUAYebPTZUqEuWXTAfEM74Z5cpImDrT
         v1SzCW8Hs5LwDKNvgy92Eb8cff50FObRq0deVD7Eo059zNA99hpT48mltOR4vfr8WDnl
         hTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780285315; x=1780890115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZZTE+oP6vZaNBQBkjw1JwOrw7qBKUTRNGV3G9H2hng=;
        b=Sy+JfFLw7CgHRtdNKnRH5pIG71cvNFxFaG4dyhLu1TyNIbHgJ6GQhHdHayO6NgBlzY
         sU3c6f8Yqo88xKBkCWug5t95deH98rkbMuiy+h6pCx12dykJQBdDtgmYkrTMlldmtUyG
         P0K8L2yZIfA9AA2bZtoE7ikAB7u/vxtFNfjQfA2E6k7P4BkZ5Z1ILT9T1avuAUQ6pPxy
         QKC26i+4vrpuhfh4IGbsJYWAO/JZ01jjgSLCats7efGMmJohFyECR99jgByeI7rt551q
         FPp9+iIknJvx3CrzGbBKT6KsdgIUJrYuasNSGO+EOJRhw8S9CWuxL81JGODFG86RP2qU
         wN/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+yEmlbS7JFi38FCevHLBJSSb4HEje8iwSyHJqE+tXNnuzn6WlVg/E/22olwTUP2xj3ZqGiQPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7ajZ0RsCDh0fHcXNHz+0HC5E5OgE2D4cl4QbmZtd7NXnZb5N
	AnM8r4OdfkqEdtc+zLji63ObRiUQerxj0ujX7MGYR+1WlTaEZeD5wVYe
X-Gm-Gg: Acq92OHUMLhQKq2fg/WgDmYAJZ0rqCoV4Cwe4qQYyNg1kWbzjU+s4Nk+yNW6YwLkuyS
	9qgVVY5kSsC6ZvJR6ABkMcxXt2LsiELwwruAsYx/AowOnNMp827uYe87WLdEubvWVOEM21YVHMc
	uxtdeKrdrG6+ixYpeiZVSj3fLGhlIcKOYdugCT4eK5h2CaazJOCXz4H7J5c30y1sCW6Voimusfs
	AtvG/wCg7/ZJD58M4bA6h1YHJZ2mFJezd7pcXnC3yYRTBUKUX+5MPlZfclItBUQnqIJGO9sDM2u
	KvjUIFGwcBq/8AXP+FFeFjURWFUTUJRlaVuWanubu/BwZ1iUVxP9cF8KrtPXXG54dq9t+kztkHL
	gAHsqXX6CtPz4vud20s6/6hRqIG/6+wT6wBQEeCVuvibCoOaXQWtNjcjm0VgsMdZOEQeUZmT6Ce
	ldMfkckO2q6FzcjKc7zx2qEplkPeAuSKynZtsi5J8gQ7CoU0yD0v9EhyZ4+r4=
X-Received: by 2002:a17:90b:1b0a:b0:36d:b662:708e with SMTP id 98e67ed59e1d1-36db6628d75mr2305338a91.9.1780285314995;
        Sun, 31 May 2026 20:41:54 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbfc90570sm9605036a91.4.2026.05.31.20.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 20:41:54 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Mon,  1 Jun 2026 11:41:48 +0800
Message-Id: <20260601034148.1272080-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293532-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ip6_tnl.net:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5096B61946E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A tunnel changelink mutates the tunnel hash of the device's creation
netns. ip_tunnel_changelink(), ip6_tnl_changelink(), vti6_changelink(),
ip6gre_changelink(), ip6erspan_changelink() and xfrmi_changelink() all
look up and update through t->net.

The rtnl path into changelink only checks CAP_NET_ADMIN against
tgt_net. After IFLA_NET_NS_FD migration the creation netns differs from
the caller's netns. A caller with caps only in its current netns can
then rewrite an entry in the creation netns hash. They pick the
endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
vti6_siocdevprivate().") added the same check on the ioctl path. This
adds it on the RTM_NEWLINK path.

Check ns_capable(t->net->user_ns, CAP_NET_ADMIN) in each changelink
before the lookup and update. The newlink path has long checked the
capability in the link netns. The changelink path never did.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
v2: Reworked per Kuniyuki Iwashima's review. v1 gated the check on
    dev->rtnl_link_ops->get_link_net in __rtnl_newlink(). That gate is
    too broad. For peer types like netkit and veth get_link_net returns
    the peer netns, which changelink does not mutate, so the core check
    would wrongly require CAP_NET_ADMIN there. Move the check into the
    changelink path of the tunnel types that mutate t->net, against
    t->net->user_ns. This mirrors the ioctl side in 8b484efd5cb4.

v1: https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@gmail.com/

 net/ipv4/ip_tunnel.c           | 3 +++
 net/ipv6/ip6_gre.c             | 6 ++++++
 net/ipv6/ip6_tunnel.c          | 3 +++
 net/ipv6/ip6_vti.c             | 3 +++
 net/xfrm/xfrm_interface_core.c | 3 +++
 5 files changed, 18 insertions(+)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 50d0f5fe4e4c..51d8787318f3 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1251,6 +1251,9 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = tunnel->net;
 	struct ip_tunnel_net *itn = net_generic(net, tunnel->ip_tnl_net_id);
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (dev == itn->fb_tunnel_dev)
 		return -EINVAL;
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..0de4994bc92f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f..2834004c7011 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2102,6 +2102,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index df793c8bfffb..7b05e0c491db 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1044,6 +1044,9 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct vti6_net *ip6n;
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..a1029a829406 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -869,6 +869,9 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = xi->net;
 	struct xfrm_if_parms p = {};
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	xfrmi_netlink_parms(data, &p);
 	if (!p.if_id) {
 		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-- 
2.34.1


