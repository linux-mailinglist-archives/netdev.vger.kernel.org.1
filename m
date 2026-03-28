Return-Path: <netdev+bounces-272820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dkjnKKhJyGlVjgUAu9opvQ
	(envelope-from <netdev+bounces-272820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:35:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6F8350022
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4179A3011C59
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824B30E821;
	Sat, 28 Mar 2026 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qD9ZHCM8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F4370D5E
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733733; cv=none; b=V67xU3rvwZKjsm9N5WgQ7VfLlKsys32y6GH7DuZA6n/7+auXaJUSdiiPut1R/BrmyA4QPX22ZmNZ+ssuDUrp1glS1+5CFUYtYnWg7rlNQ8TMSIW28V69hygsD1nMla0Wqp6XKA90ow/AwN++WjjI1MzFplSYGdTAvxBztl2Yqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733733; c=relaxed/simple;
	bh=fK5QM1My0YC2GlNxIJC2hC8aFiWYrPPNpGIZfwPjJ0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m4rRSfntpNzd33wu7t8ML4FNunDSon6qCDf5r5sGZulu5jYGbI5mii6WEaNxQ8EW2Lc4op8OTqfz9sOMSfepAB6ROjrNKbaJSwlm45sss5HxCvT3f9R7JMkKJP1XYT0j2fWoN63JL8Srlzl33AF3X1yCak30LqTDPdeefuBeDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qD9ZHCM8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so3946974e87.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774733729; x=1775338529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lW1RSHqU3lWbMAmtEVsZl45PeXhpdKuHCCKF3JwoGic=;
        b=qD9ZHCM8SmGT2hwIjm7WV3JDHQkRG/zpb9a9TZwDIS/4g6Or854T3lXTuN3kHTYs7n
         SPXK0/1CdAE/F4GBniTsDJXIKW7nQRnYcktGtdUvOOtwHDuVfsxLySQv4Tgpn2ZgzEuE
         43kRPyqZe0WYZa2ye5FNQZYXqSu6X5CF6DnztBRL+wYjr996Zir6sK5t8XviqIph5xVV
         M7ol+Zl5+VHzNjhdUxNJXPJixbqsVQIeBh3sBF7rRE0WizIoA6/h3PhNYdMdG23WCH/H
         T98l+sgYgKYuL6YSoJHYGxmLLzIMjU6LLi8CaUQTlcaiqe19vGX9fwU6Imv9IyUHZmdY
         c//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774733729; x=1775338529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lW1RSHqU3lWbMAmtEVsZl45PeXhpdKuHCCKF3JwoGic=;
        b=anYtOJXtdsNfX3yzIBJhYpxkUkxKywjKWR8Gaj1OHHlKpfZYiPpqrkWKqIH3SC/1ID
         Jh69XpeYzj8ulvW0oBQl890h+na8t3rLgHtVadF91E/p7swsYbNJQe7f16SiO/ugDJ6h
         bqxi7NVDeJIDW4+5z6NdvUZk65hgrnqbiOeIuNhVHguw0pG3MnIJRMB7ltRcoQd1xLof
         6iC9NmBP4MK8ccUPrE5wYiATO+RvskCIulGQt6cFQG5xIaKKwOLA27DA0uedJST31hlp
         3CiHwpJCGCWD/fP4yGGAJL4alRXhO0Lkk/o47dmivG3savGgAWOiv5SYMeqChkgF1KF6
         Q5wQ==
X-Gm-Message-State: AOJu0YxV3K2BkPQHvEIA28q29EGc1b0JfBb8OHkmvYYyQEBuzVyU817o
	0s7GK6r1yWzMRK4/d79AofAbcsi4qOIeXK5BhifAMOCtWXkxZEwXSJvK9GFJevHeQfs=
X-Gm-Gg: ATEYQzzWqBt+sLoyinx2EI7NJQmlRz4+u+Kje701spmT6/X0mnK2HQyLSKqO0nKnrSS
	P5GuqbUPm+HRpLhSP83ru6wYSSaznIpf3tEh8QuEk8XRbhpAvxKrYkro21au9YnxTsF/SqR9SXW
	kyz589Tw3s1OIxgQN0qhZPumbtcFWXy+o+H4YZ2mnEz7yE5ZKtY2NcdAUqnIhipXzi48Zg5dAF8
	thGuy4oo5ViSMVibZwCqC0CZsfQofJ7SfB+ZY7SM0bU/DQeMHwA1I3xMLdbYR5+aauwwb1GqrMA
	Tlgyo2suQZ2OXvAJPZAh1/mpf/GHRcm1WlV10PDE/eHmGPn8wl8N+sAezZ3gIlaM3A5G7to7pjd
	raXGZnUYTY0Us6wM4uBHSeMDX901iW4fuBdjIZeDO3JAGIkHvygDMCnkYvvx8H0CzrDWrQqa6xT
	0/y0BaIrN2RpCCga3ZKY69mxCVlKLRqogH0XFVYoyuvf9LjEpiFwSkLUOEzIJTndIxWHFYNoaW6
	WO7iXQjC3vMJJ28cAJLv/UdfLmrLuLEy/UqcsVezra4qFf9gCD81aE=
X-Received: by 2002:a05:6512:33ca:b0:5a2:9b44:1cb with SMTP id 2adb3069b0e04-5a2ab7ef7e0mr2773474e87.2.1774733728683;
        Sat, 28 Mar 2026 14:35:28 -0700 (PDT)
Received: from localhost.localdomain (ti0034a401-0790.bb.online.no. [85.165.210.26])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b1403f69sm668426e87.29.2026.03.28.14.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:35:27 -0700 (PDT)
From: Nikolaos Gkarlis <nickgarlis@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	nickgarlis@gmail.com,
	kuniyu@google.com
Subject: [PATCH net v4] rtnetlink: add missing netlink_ns_capable() check for peer netns
Date: Sat, 28 Mar 2026 22:33:38 +0100
Message-Id: <20260328213338.450601-1-nickgarlis@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272820-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nickgarlis@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED6F8350022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtnl_newlink() lacks a CAP_NET_ADMIN capability check on the peer
network namespace when creating paired devices (veth, vxcan,
netkit). This allows an unprivileged user with a user namespace
to create interfaces in arbitrary network namespaces, including
init_net.

Add a netlink_ns_capable() check for CAP_NET_ADMIN in the peer
namespace before allowing device creation to proceed.

Fixes: 81adee47dfb6 ("net: Support specifying the network namespace upon device creation.")
Signed-off-by: Nikolaos Gkarlis <nickgarlis@gmail.com>
---
v4:
  - Use IS_ERR_OR_NULL instead of IS_ERR + null check.
v3:
  - Move netlink_ns_capable() check from rtnl_newlink() into
    rtnl_get_peer_net(), after the last rtnl_link_get_net_ifla(tb)
    call. The tbp path is already covered by rtnl_link_get_net_capable()
    in the caller. (suggested by Kuniyuki)
  - Pass skb to rtnl_get_peer_net() for the capability check.
  - Add IS_ERR() check on rtnl_link_get_net_ifla(tb) return value.
v2:
  - Removed "Reported-by" tag
  - Fixed "Fixes" tag with the help of Kuniyuki Iwashima (thanks !)

 net/core/rtnetlink.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index fae8034efbf..a4d8fd8232e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3894,12 +3894,14 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	goto out;
 }
 
-static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
+static struct net *rtnl_get_peer_net(struct sk_buff *skb,
+				     const struct rtnl_link_ops *ops,
 				     struct nlattr *tbp[],
 				     struct nlattr *data[],
 				     struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[IFLA_MAX + 1];
+	struct net *net;
 	int err;
 
 	if (!data || !data[ops->peer_type])
@@ -3915,7 +3917,16 @@ static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
 			return ERR_PTR(err);
 	}
 
-	return rtnl_link_get_net_ifla(tb);
+	net = rtnl_link_get_net_ifla(tb);
+	if (IS_ERR_OR_NULL(net))
+		return net;
+
+	if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
+		put_net(net);
+		return ERR_PTR(-EPERM);
+	}
+
+	return net;
 }
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -4054,7 +4065,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		if (ops->peer_type) {
-			peer_net = rtnl_get_peer_net(ops, tb, data, extack);
+			peer_net = rtnl_get_peer_net(skb, ops, tb, data, extack);
 			if (IS_ERR(peer_net)) {
 				ret = PTR_ERR(peer_net);
 				goto put_ops;
-- 
2.34.1


