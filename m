Return-Path: <netdev+bounces-295231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jtJMH4J2IWqTGwEAu9opvQ
	(envelope-from <netdev+bounces-295231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:58:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E76401D3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:58:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hbMaw+lm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295231-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295231-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 164B7303D10D
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7266F3F210F;
	Thu,  4 Jun 2026 12:51:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9E436358
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577466; cv=none; b=EsdmSzztAofXTsH7Wmme6zfgMrdo/Kb7rzMZDIIRhznWkFpBChkZo7S6dlyiR/jQsuCUjjFkwiEVYn/1rN8V4MzAo/7HZzMnXSvBsMi3WNsrBi9wF0hLoNxZQ95fqhHYfZiQFNCyH7RObAu93KE3NTpq/BMOMW9nJg/QBDgju3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577466; c=relaxed/simple;
	bh=Ue0t80Atf9FROn1T+Fppzbjlf+qCi8HLopNvvDd8atU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u7sLXY1qJLqk9UPLlFxHrX7ZtiNVS4rCMEebvgvyL/rOxOB71WhpEXdbfoYFaX90BdOdOapGp6K2JaRb4eFCGDeaUaH8/dC14LHGdLxtjbMhjujzieENfTENgl1dgEOS2zw4niuKjGaB+ra20y+OGMFAbUMIuY1H25x6AqmcDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbMaw+lm; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf22d29dabso4664695ad.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577463; x=1781182263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=seUz59e0svXloX8vBJn/Xnyh/69QhVVV1JmT7ssvJbs=;
        b=hbMaw+lmZK8JNCLjk7Mws1+ERpGPqsRK0gZFnPOu0Ix6dSnq2SYLvuW/0GUcnLLZWh
         /l40EFEUZzdm710dRE8jYQEU4KLHnbvzZoqg7oGMHDkitZA0t+gswDhwaG1lVaK/cLO2
         DO9lCu+GDV0H+/IBVbVqPgMWrIBaRJalX+IUrPcOn2UiJqn32ud+nh8JwGW3SQOiHg48
         OvMdo+f3YIu1jntsbZc1NdcaaHk9LQLNWpWyaiwRkdYx4IudPlLZNCzCBKREJYo+O4qU
         KcJ/MtaVb9dxDobksslXY4JHal8ghsK+GEv03zAQLRXla9Y5WN/TJFxT4kf6By1Z+WUV
         YWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577463; x=1781182263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seUz59e0svXloX8vBJn/Xnyh/69QhVVV1JmT7ssvJbs=;
        b=OYRmNhmsNSbWJDW/e62j4k5QdW4EPoLW+bm0mOJs3wZUY2JQRf35DIk0i9fP0g0cPw
         alDIunkQ/lLyRjRPAmpTGBjt40ODhe7qP8+TXQzjq+MQR61St/A5xbJscP6XeWLSC7gA
         ZrY19ZuIhb9qpnsAKEhgMq1MLQOK/erTLwUBvaZS5g/uE3vFArxI5dU1J1RyqeLpmtZt
         cOpcXjK2zyGUObbkZ806q7yCekzrwJcVlDoMWXbxiMx5zTfDHTr/rNoXsfLj1BHX5SZz
         8hgQsNauMQXCzaW3wFDANE/MLYQ2Zdkxq6zwRoTPbhdJNlsDcTbezZ3gU/zaWow+cqLY
         j1ug==
X-Forwarded-Encrypted: i=1; AFNElJ/YhPyWomgOcjWO9NvG73bB6vXJSNrqhvWlc6goUyOETbp3mG4w8YXK4eCq3OSKy9eZ9vF70UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/A5o/SMIaQ5dHZI3GYaU1NUMm9j07mdgLwFq5CtS2hUn3myS
	Z4rrd+Tn+mjxCKa3UbNym/Kg3+yWKCWDFDD5S+nwrpf4ivDuimISNkwI
X-Gm-Gg: Acq92OH2KKICSw7/yZDP19uR1uBcXRqKXijUYRYQ8kAbH2F2stwyDzyRDXGELZT2LpZ
	3ovBZd/JGj1I1SGVak+olQndZYMiJ8mnK0XGcw6xYbhFrS5p6VD9nOo2anjzaJiK9e9U6A/Ckg7
	cOC03RiLo2c/W/8Z69M2SbTLPFOfhLk/CHR5eB71Sk5O8qKaAN/L7sFXGsSi9MzhdY6T66YVHn3
	TagZaYQzG0b36rZVfFWP4Eo944DvmMdTiYhcf/3WEUcOv4jd2nbTSu3HdFvrqpBSYDXzOeQr9Ec
	/Wsfsrq+9iuCs4QwACIuezLSOzGBCGbRhswxXd8nDuGj7KPKkHsl0iapCKCPTBFPNfmy1yTvrER
	W/dbDtz/GAz5XIYUAJ/pnNYWmZ9p4gTmf5fLescA+68W8NsC3LHDgOmfixIBrht3P+mcjxX3gKE
	QONmNaFhhvmryTWPCdA47Dc5jebUXb77KdYt80+wnOiNqqhu/EiF2VaH7fww8=
X-Received: by 2002:a17:903:3b85:b0:2c1:8fea:4dbf with SMTP id d9443c01a7336-2c18fea4df8mr50899115ad.8.1780577463135;
        Thu, 04 Jun 2026 05:51:03 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm57654715ad.20.2026.06.04.05.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:51:02 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: dsahern@kernel.org,
	kuniyu@google.com,
	shaw.leon@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v3] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Thu,  4 Jun 2026 20:50:55 +0800
Message-Id: <20260604125055.3254652-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-295231-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixie.tju@gmail.com,m:shawleon@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E24E76401D3

A tunnel changelink mutates the tunnel state in the device's creation
netns. After an IFLA_NET_NS_FD migration that creation netns differs
from the caller's netns. The rtnl changelink path only checks
CAP_NET_ADMIN against the caller's netns, so a caller with caps only in
its current netns can rewrite a tunnel that lives in the creation netns.
They pick the endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use
ip6_tnl.net in vti6_siocdevprivate().") added the same check on the
ioctl path. This adds it on the RTM_NEWLINK path.

Gate each tunnel changelink on ns_capable against the creation netns, at
the top of the op before any attribute is parsed or applied. The ipv4
types need it there because the parsers can update live tunnel fields
before ip_tunnel_changelink() runs, for example ipgre_netlink_parms()
sets t->collect_md. The check is skipped when the creation netns equals
the device's current netns (net_eq), where the existing CAP_NET_ADMIN
check already applies and no extra LSM hook is wanted.

The newlink path has long checked the capability in the link netns. The
changelink path never did.

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
v3: Per Kuniyuki Iwashima's review. Move the check to the top of each
    changelink op, before any attribute is parsed, because the ipv4
    parsers can update live tunnel fields (ipgre_netlink_parms() sets
    t->collect_md) before ip_tunnel_changelink() runs. v2 placed the
    ipv4 check in ip_tunnel_changelink(), which is too late. Also skip
    the check when net_eq(creation netns, dev_net(dev)), to avoid an
    unnecessary LSM invocation when the netns is unchanged. This also
    answers Xiao Liang's question on CSUM and SEQ only changes: with the
    net_eq guard the capability is required only when the device was
    moved to another netns, and then every changelink writes the
    creation netns tunnel regardless of which attribute changed.
v2: Reworked per Kuniyuki's review. v1 gated on
    dev->rtnl_link_ops->get_link_net in __rtnl_newlink(), which is too
    broad. For peer types like netkit and veth get_link_net returns the
    peer netns, which changelink does not mutate. Moved the check into
    each tunnel changelink against the creation netns.

v1 [PATCH net]:
https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@gmail.com/
v2 [PATCH net]:
https://lore.kernel.org/netdev/20260601034148.1272080-1-maoyixie.tju@gmail.com/

 net/ipv4/ip_gre.c              | 8 ++++++++
 net/ipv4/ip_vti.c              | 4 ++++
 net/ipv4/ipip.c                | 4 ++++
 net/ipv6/ip6_gre.c             | 8 ++++++++
 net/ipv6/ip6_tunnel.c          | 4 ++++
 net/ipv6/ip6_vti.c             | 4 ++++
 net/xfrm/xfrm_interface_core.c | 4 ++++
 7 files changed, 36 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 169e2921a851..02328c9a3c07 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1457,6 +1457,10 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
@@ -1486,6 +1490,10 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	__u32 fwmark = t->fwmark;
 	int err;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..91c6b2ed7d30 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -596,6 +596,10 @@ static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	vti_netlink_parms(data, &p, &fwmark);
 	return ip_tunnel_changelink(dev, tb, &p, fwmark);
 }
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ff95b1b9908e..95976e551bbf 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -494,6 +494,10 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..7b86deda7e1d 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,10 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2270,10 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!net_eq(t->net, dev_net(dev)) &&
+	    !ns_capable(t->net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f..dd1458633ec4 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2102,6 +2102,10 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!net_eq(net, dev_net(dev)) &&
+	    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index df793c8bfffb..d981ec710f0b 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1044,6 +1044,10 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct vti6_net *ip6n;
 
+	if (!net_eq(net, dev_net(dev)) &&
+	    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..f11a22edade9 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -869,6 +869,10 @@ static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct net *net = xi->net;
 	struct xfrm_if_parms p = {};
 
+	if (!net_eq(net, dev_net(dev)) &&
+	    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	xfrmi_netlink_parms(data, &p);
 	if (!p.if_id) {
 		NL_SET_ERR_MSG(extack, "if_id must be non zero");

base-commit: 78ef59e7a6459b16f8102e0ee1c718443323d1af
-- 
2.34.1


