Return-Path: <netdev+bounces-289446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AACaELpZDGodfwUAu9opvQ
	(envelope-from <netdev+bounces-289446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:38:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B20FA57ED30
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD3E3053751
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4A4DBD61;
	Tue, 19 May 2026 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZivagJr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD84DB561
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194158; cv=none; b=KNtfNAHGpEL3i/p5gad34sDv+2sKBW+c8Yh7MPjRwiS5CvG+QJGeiwxLpcC0C+cq3/NiM6MEW+Nj6iIYGUd2vnJSvpXwUeiTUTfFDuegvFiYwQwAYUpZSl4w04ZvHk8rTuZvMfNBh59flDZaUrYZKtZeFIXsDiVdAXGkSzrbXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194158; c=relaxed/simple;
	bh=Lwq1J62OW8JDcXkwUnsvUVkfs3+XE4erfsJrd0tlMuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsJWYRIjm5As+3l0t/josg4rjxEIPvSDZKAH2lcFqLzSgQbJeaNBt0T4O84wqaKbWTri3MieH9oFUJZpl2f+afhegNWt1ac/DGuCPP/nIvLGYdWdckxtJvsWE00X02IP/ZoX/1UxuVVnS9ukZE5Z32UNCFj/ZFcIuBR+jCBEFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZivagJr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba856db1c0so25220145ad.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194156; x=1779798956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC88S+CqkDEv2HbPYj6bcWrEKRInj078OJU7Uw7Ad6o=;
        b=fZivagJr73DZePSJ3HASnQFf4YT8auxVi98o+vSh2QvA8UxhOsZV7s3cYnYrKmh8on
         k7QPk4sP8Fep3zoC0KaHaW24gUAszwwiHeJMFOjPgkc2DuHBI303LombdB+p9SaBnhZP
         HkXSBYkovB3kjmqKT6k/jKAENrFlHh5TPPvqaw6ypWCJAAYgbqTfNqrtEK1+P62++CWS
         bXsS3ylCZ3cLYwc9fXF4gs3dxJTIKpvnK5LttiryK0nDim/K5dnLjBev6pfY2TpJneL6
         fFmRMoNkX+3fmk7h4m/UI0KcoFwbLXuCmXz8eIMyCbjdaSNwom8ZsjkTw+6quNCO9gUQ
         cFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194156; x=1779798956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NC88S+CqkDEv2HbPYj6bcWrEKRInj078OJU7Uw7Ad6o=;
        b=GytbeTx0pUMZh7NHaiVfM2s17P16f4+COdXUZV1sXwG8HkIZtD6Zc70XBNLKiM07L7
         GGNuxmayYlcdgw0+j+D4eBW0Lks7vxNyQmO1MRuIvIaQD1FHDJr9+kt/aSwfRWlPOTg/
         tI5tur99E3oPc5VACavjXz/no5Ooi9djzDoKDoOTIwD0Iy5hB8jr8g5t0xdigo2R56Ar
         YmTAP8sbs+A+7GNBi7w5FfMiJZbKsfpihfJSROvfpyp5mVRQy3CPCXj+vQtjmeuhNB1q
         NbjyQooHbkiRpWEuvsB2IeQJrBr0hlYjM64hcSbjZ5LnJAaTq+E2knMlUVUG1wjN3kGW
         mpeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kHncijqnoK4gNz6At13sjCVJXDbRWHpbyNhLdr+wA7BWs58NciW9v3H5B7di4i7qm/oabBYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVupScqH9qHL/tO2E93GVo0RKj0lJPQrBVDMN4Hxd65EmyBZ19
	txsY+WuH3fLXif6HI4C9wtta9uNhFCIHciWgUmpqPh7vOZcO9lJt0Z6H
X-Gm-Gg: Acq92OEO/mrtiebNXC3aEPGZ9FPNZ499vikY5OC2dwXay1aScXPeogiq27UZhxhRe3S
	d6yPCBbTBbqwZ2A+dG7ONw18QVYQCFoDFlUDGT7W1TFVmyCzW+yf2vkH5lQvpGsonH6Btek+aMb
	oflRLyDp/ysrG/3dJRIxyE1bCANdHz4rv5NjpucilvRiJ8bdtTbYdFdwen7SQxosr3lh4v6twgA
	sBmGwcZER8ILDl9tReeclb/PEIvTzNMrUva35OxoEJ+OkUxh5RoL/7dvt6p3ZasOqt4KtOYPJLr
	ZeZQ/wjBXEOGO7t6OVhYIalIe42phKjBl5IwOkXxCbL+Hi/nrqU7X0UzKW0mfxGHAO5V4dmJCZh
	eabwgnXN0CnZUl+XPf49TuX/F0tcuvdig6C0h0hKxCKXlqXjZC+W4JQ9CiLiz7xGZ3RyJmzINkB
	dTudN+Qo0T/G/o+C4cfQF2gJ6rAqtD2E6/nORYy4QrI+xXVnTD7km4FfjIang=
X-Received: by 2002:a17:902:da8a:b0:2bd:eb0d:efb7 with SMTP id d9443c01a7336-2bdeb0df7b4mr80270315ad.1.1779194155920;
        Tue, 19 May 2026 05:35:55 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc60sm193216245ad.9.2026.05.19.05.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:35:55 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Shaw Leon <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
Date: Tue, 19 May 2026 20:35:46 +0800
Message-Id: <20260519123547.2055911-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289446-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B20FA57ED30
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

After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
rtnl_link_ops"), vti6_newlink() correctly resolves the per-netns vti6
hash via link_net. vti6_changelink() and vti6_update() were not
converted in that series and still read dev_net(dev) /
dev_net(t->dev), which diverge from the device's creation netns
after IFLA_NET_NS_FD migration. The result is a stale per-netns hash
entry; cleanup_net() of the original netns then walks freed memory.

Reachable from an unprivileged user namespace ("unshare --user
--map-root-user --net"); cross-tenant scope on container hosts.

Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link_ops")
Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_vti.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4..dcb257411 100644
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


