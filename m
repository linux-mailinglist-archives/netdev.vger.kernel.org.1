Return-Path: <netdev+bounces-281799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJCLB4GX8GmrVQEAu9opvQ
	(envelope-from <netdev+bounces-281799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:18:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA9483832
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B78232AAAD3
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4BB3F165A;
	Tue, 28 Apr 2026 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYENpmII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C13DA7CC
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374451; cv=none; b=bT4mxyGsSN6EhmJxRusHvjn5yW1z7RYnNf3tEzGmbB+1sslGjGXNF525p853GxTLGOOHK77h6rLmwK4KryTTJEtEeXa8M4YD3f2y3AkysAydy7FRhHkUih+L3Zqin4P4HB/KEj8FAKCD/bvNs7HoL2jlVe5j9S3qcrowGCT0iTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374451; c=relaxed/simple;
	bh=t1J1G0DPTGU3Nq5IK8gdpkJgcqUbwU/dQwACfaQ8rfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDh47/ub4iAiGUf+fgtzBu3ZFkpZbSgUsQb5UMBl2aUyuyn6JtcVQSN8u54NOtmqRVCDhftk8Ocg2UKna5FUcL0pscbJ3qcKSBvxkKEO+3Um6X+UWob290AsfzPuk+xl+2XphF8sJXXyK2tQmjRKvclyZwOzw+GRuk/rmx6B1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYENpmII; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-362e30526f8so2129170a91.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777374443; x=1777979243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbbMQ0UaEkffRakuaSv0SsaIDp6XiWs2fQ+ORE2pX24=;
        b=rYENpmIImf6ID+SbAViIxp/ggJ2TcTkqLd72/oZO2O9PeO8JbTLlv10ujnRP5lJ3JL
         GToWdPOoJxsBm+wkrnFswdeDtWGEbpFejQv12DWD+4Xfv85qsLhKsOKuPaf7vsjKlBKn
         e8Tro0FEKbz2EXLa0p77Z2hxiyY96mxIfq7eIMrOFE8KKMV2Qk1fw3abqtYmiFwMfAj8
         VtlOoNAJJNefcKnaNjD0eIgpM/iqZldcs7n5tcRlZ/c/rwCX0ZU0kPA8+Ilk2xWwAby4
         1GGCP7L+kjE5CYVP8T7PXFMdGVFfjREbp+6Buo1DYHiNL28rPm4fTxNxftyMvl+JnvSJ
         5lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374443; x=1777979243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbbMQ0UaEkffRakuaSv0SsaIDp6XiWs2fQ+ORE2pX24=;
        b=c7zXFgIzA/O/pj1dzN7WUXXtEEP+prHnYIJIYfeSRjpmVF1dFXD33iO+WwqV4DfzuD
         Cz7SPqeJl/nL+8Y93nYaA3L6yj2DCtKyW1e9flXHL3JIpvQPNVRLbrdHNsa14i4r14Ez
         U3OcqQo8B/94JmwIQa04M0dY/j45ALkAbVp1NL261f+weCcaYK6o9dyJxAygy4R2KhuA
         jyehgDaPy/o8nu8QNTyEIYsaXRvzFzs/xVw1jXmrfKD9xTlrQ+fmI0ESk5nh4hwCLibj
         TpnDICn4kGueZUEF3RHDnrhafo+k/NNZYOAe6T3ubNLUfZV3RvlpPY5AuWuGb2KYVVFR
         Prng==
X-Gm-Message-State: AOJu0YwV8Fi98Vy//ejcjBJ6kza/+An7I0lyK6ZW9rRKjcMBzlvpkjfi
	cT0YWlmMTQtwGtc4oV5ZX8FtRIYG43m0aEetd1tXJkvsLSVyVGPALYsiE0u9Rpmm
X-Gm-Gg: AeBDietXuamO40Gx3ZYHJjYLVHt9l/6Gl+xXgajFXL7ELrFWcro6SDaG5h3fpNZREBk
	ylwYLpzxJdUnYXDF/Rz345Sw8HfNn6Jkq1N5c0m1DpPdAgzkgXseaoNZYFMDtgJHz8ZoaE9j8/s
	KKQmRUQSo0vT6FIT+P+xjaGl8RGuNezIPSROAkzmDWNlaYvf4ceYj97jARuDimZpP4aII66o/TL
	42fYyesn/pQGBoofLVw8itBmGdwoOqaEflreYU6JtQt2zn8XFkAcNZHvo4NniziBwgyf3uiDS9L
	OvUpia0Eoae1OX+Q6KeNDkJtSfjUVeXjaL99Wx7+DpiuQZav7vqrh245gHGf8Q75sdQvpmpCvvJ
	Ocx+jg/mVWsKsVVmeuiiguTDiQoCtqbjiilUKbxbr07w0oXCWMEY8wFkOZy5ilnwAVkPD3roaCK
	blqP2rI7v5xq+ELvBpuW0lNs9NE4wOSu/miOkqCtHd+REWIjEx/JCvyuUTUMo=
X-Received: by 2002:a17:90b:4c86:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-36491fbc102mr2653279a91.12.1777374442873;
        Tue, 28 Apr 2026 04:07:22 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc33d4e11sm2023328a12.24.2026.04.28.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:07:22 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	shaw.leon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org
Subject: [PATCH net 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
Date: Tue, 28 Apr 2026 19:07:12 +0800
Message-Id: <20260428110713.2550315-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B9CA9483832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281799-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:email]

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


