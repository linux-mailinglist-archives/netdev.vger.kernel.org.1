Return-Path: <netdev+bounces-290421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE6bBMwHD2qFEQYAu9opvQ
	(envelope-from <netdev+bounces-290421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:25:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6742B5A5B60
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B0E32121B6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A8C3E9C2F;
	Thu, 21 May 2026 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK7in4bI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80C3E7BCD
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368765; cv=none; b=W4zjrA+fU7/S/tusdeaKLWExsSTQ1i93hCXl/hyTszyOqqo7pdFJ1fkHMaMyrr5iTKcsBJO5Mpw79eo2YFkGC9IJj7ITP2JH2G4QbS0sI+pJm/Sk1JxCDbe7rdHOmqfTmA6QgkKwJ2agf9OTlUuh/eXyiOrZPkE2sJbEiNHXdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368765; c=relaxed/simple;
	bh=o0+Uc1eRtmlTav0dVo/A4qHTGC+dTGpAF8PyhhZm7+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ei1LJ2bYizI+js7fOieH9FXo0OnoLaPz1dYYMSrSLEPf85pxfIy7/entDTt3/F5H2DIkGJkgKT9X6rsx24bgkpsVXlYnOFW1drNx4o+jIwqpOkysbE98mN2qW639kBoIo/QcM5efyE7S+LkBBTT+RuPCJuDhLyscOA+omiMOl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK7in4bI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-835c98b659eso5299833b3a.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368763; x=1779973563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tgtXH02C6zRbkOdG+i0RmY3ValCYoij0GD+Hz/Vc9g=;
        b=cK7in4bIs4TuLszQ+fRTJ9Dt/L4Qu5FTqdp04ooxQdsPZ8RQCd+2HFL2Cq2/LEZVVM
         y2q59LUKw8s8Mk3HMs8PIiktc9HlIPGqb87XfAplqjQPYmeVnokD2kYIYUj5O8LpHjAW
         Ga6a3tZvZkErmKSq36JZth6fCMsyJ4yy11nrg2v2qt46Ial/K3vwG64BYv8SSavyiXwv
         I45fASOzlO+UYoRV48ufEtAMZ3JeB7iWkbdywMIrHVHkq4USKV5MfJFxPTmS1e6sl0ui
         0JaanlzthHvDXlzIoutM+SJkuwmfcmAiyy1648pJssPvG2CF2Lvv/AyCMcXA6iWQR3RN
         0Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368763; x=1779973563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tgtXH02C6zRbkOdG+i0RmY3ValCYoij0GD+Hz/Vc9g=;
        b=DNlOqQ3+kdMOY84fBN5qnKrAAJMmgoDL/9aVZiZMG3GJKxwt6JreyZhuRUTpv5b/Bp
         QSl9GQnjr9CnBP9XmL5yaCf0GZF51ukV8+9rTfhZWEqd3P0diGmnHnY2F+L8+6FelZcR
         4AO/2J3yHJlxwL3r45g2n1xyOqvFMvzTgRXQ5JeUp2NB15PMPifZJU2Z4PBtLvYmwc0L
         7JGlgspP5T/NUPZew0/g6W7DJtwvM/bm64SruXlE9nKDYVRbfvrSiFtx7jszUlJR0h+f
         F2lSaEQKhZ4qR3TQnE0FhV7YxL5yw+1++4VmKJ4RUyhx+YZXvYrV18r0qG8h1hEKJx8m
         1PJg==
X-Forwarded-Encrypted: i=1; AFNElJ/BXAjwQPGs897pD29JYkQ0BuNnpgFuNI6obMZxhmBP9PHKPsonWKAJiyZvDvczVaKk/L+yuy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0sCubdjxlSFi68A7aL8Z+BASO9d7o69zA4ZNRD5jXALDvSNo
	eZRRQ1QxC5SWz9zN23O2Q35kaGejyw2SZlb7x/uPDhhTo2Er8wT5Bwk4
X-Gm-Gg: Acq92OHWphZ5Fw0FsCtQhhpuYZq/JMw6LszzrXWOFII8r5xbVTBCbuKnhVxdXD4X4ER
	SfYhDUrh89Wv1X24AmyIT4o1jHpkcR004U02v6qfr7qoLoadgWfxE2h9czd4Rn/QSLc1dHJzTvf
	IeHPvLmbRzYSlXRolSYV+FavUIadelxzg2DPMpm5bIdirnY1pDVeBTgk+18062KODkbX0Vy0+97
	/IzP2NxIQ8Fv6bJbTyr3V6EA0wBRfQlr4wTgMdQL5HOFZ9KhKzxFlSO0qDjp6Unz7KHWC2tY0kJ
	AxyqfFrIRoNWhQ69wd5Y907pnbAvwxq2CvaGa4wkA6tfNGskO7QsYvK/pSkxPRfa0HCDWUhvx6j
	2W4gUgWMyNioUYeZa/eHth9E70vzz1hk5EuCoMtK1p+ozj4iZQr+bb8NDbx0JqXM8SLp/Oetz4x
	ZTUQFqa+eCE6FdvAtABZHokjXESFcAW+M2ArFGtDLEcmYmbK51
X-Received: by 2002:a05:6a00:850:b0:835:41f3:f449 with SMTP id d2e1a72fcca58-8414acda757mr2821717b3a.13.1779368763468;
        Thu, 21 May 2026 06:06:03 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549be20fsm1693993b3a.12.2026.05.21.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:06:03 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
Date: Thu, 21 May 2026 21:05:54 +0800
Message-Id: <20260521130555.3421684-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
References: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290421-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,secunet.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6742B5A5B60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kuniyuki Iwashima <kuniyu@google.com>

ip netns add ns1
ip netns add ns2
ip -n ns1 link add vti6_test type vti6 remote ::1 local ::2 key 7
ip -n ns1 link set vti6_test netns ns2
ip -n ns2 link set vti6_test type vti6 remote ::3 local ::4 key 9
ip netns del ns2
ip netns del ns1
[  132.495484] ------------[ cut here ]------------
[  132.497609] kernel BUG at net/core/dev.c:12376!

Commit 61220ab34948 ("vti6: Enable namespace changing") dropped
NETIF_F_NETNS_LOCAL from vti6 devices. A vti6 tunnel can then
move through IFLA_NET_NS_FD. After the move dev_net(dev) points
at the new netns while t->net stays at the creation netns.

vti6_changelink() and vti6_update() still use dev_net(dev) and
dev_net(t->dev). They unlink from one per netns hash and relink
into another. The creation netns is left with a stale entry.
cleanup_net() of that netns later walks freed memory.

Reachable from an unprivileged user namespace (unshare --user
--map-root-user --net). Cross tenant scope on container hosts.

Fixes: 61220ab34948 ("vti6: Enable namespace changing")
Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_vti.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..dcb257411d6e 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -722,10 +722,11 @@ vti6_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p,
 static int vti6_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
 		       bool keep_mtu)
 {
-	struct net *net = dev_net(t->dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct net *net = t->net;
+	struct vti6_net *ip6n;
 	int err;
 
+	ip6n = net_generic(net, vti6_net_id);
 	vti6_tnl_unlink(ip6n, t);
 	synchronize_net();
 	err = vti6_tnl_change(t, p, keep_mtu);
@@ -1031,11 +1032,12 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 			   struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
-	struct ip6_tnl *t;
+	struct ip6_tnl *t = netdev_priv(dev);
+	struct net *net = t->net;
 	struct __ip6_tnl_parm p;
-	struct net *net = dev_net(dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct vti6_net *ip6n;
 
+	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-- 
2.34.1


