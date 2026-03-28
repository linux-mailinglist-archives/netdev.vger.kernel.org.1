Return-Path: <netdev+bounces-272783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEihJun4x2lMfQUAu9opvQ
	(envelope-from <netdev+bounces-272783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:51:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B3C34F00F
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25E2300F532
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007634C81F;
	Sat, 28 Mar 2026 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2XeDzUe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A3237A4F
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712875; cv=none; b=WYApWI2J29hE1qrWQscA2/fPHUTSYyATfc6bLDex4csCJkGIpKlWVIg4ddH0hS3FdVxYVjt6QWoNaLIz6gUQ2w8+XjTsZKQTU0YriNCmXFjvtQ0Vougs5UDppHLbs4ZTcPoL6MRraHz12rL1q3RulXo2c9OT0hi4AlYdH0KJqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712875; c=relaxed/simple;
	bh=Yev9UV/I8swSwv3LUCQDvu20G+cSD5KmPOhjN/tcxOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CG8OhZygBvr6Z9Y5KebLN00s43mLNOkatK7qBpnHkf5XDyLh9sxFaPl5n1pzyTqW7AkeL7RScglOjPu/jjrZXbhS2/cpYsZatN7aeJw8Im56bsldLqu5Zrys5ag7F9i2gL1KyOca1+rB3BUNZ61Y3V+m1EkmvyIpiUiAuBeT0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2XeDzUe; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9a0762ed5fso426719966b.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712871; x=1775317671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xnJLgLPDdJ1GsL2xUFaC/e6C6O7gdTvGVWbkMiWCSI=;
        b=T2XeDzUetMb/Oa6zznFkTsRfaAupYKgCyHZGbCQJkWrh/4cf7bnjX3AbtbZFGfohHH
         f6gcscfTFJNjx6bx72i1tA2NbhiqW6gjuPKjdsWLR4dSxwll1QLDdGEVwiOwyzsiu82D
         zN+6JHhxQuopp04GimH0kmvA9Q7zhCAXV4BwU+CDIcPXNTckNBru9R1p/FbsGeTuVnUB
         2yXW58Uo40ROd6ICilctH77kny/LcbsOOMA1V23MInydnnGRM4ARJ0WIiW+ydEkR91kx
         SH5FNW/f4KOWC9MuVX6WgZP0ziZuCKdmGkpTQ/VVvpDpM3y5VHRsRZZekbZLja4yHbXK
         B+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712871; x=1775317671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xnJLgLPDdJ1GsL2xUFaC/e6C6O7gdTvGVWbkMiWCSI=;
        b=FpRhfFP91H4gcIoo09GiBcgqLTj65UGb4USNREsPGBzAG6VgMfnGfoG1YWbqg0o4EK
         iasBz/Vvvq0X5fBho3QaozprX1aNVhgB45NuQmlkP6h7DgfWhOPFsoDcq9jztvIoVeQL
         jFe7v6rCEZj3zvMGHoaG1ySW4Q1WFNUfbfJXuX4WBAMGqZNTa+hRXxR6eOky0KHEcs/x
         dYBws0cFmFeTxP6Havu+z8fNnYoDiCpkgc4MesEMEwcYloqS6NiDOz9KZogSBitpyUla
         Dtoz4YafSEg0hX/tiEDtTQ+L3jp074UbCIs6Pu18lqXvRCCXDpNZE+sfFhzRk0fvLdqt
         cF4Q==
X-Gm-Message-State: AOJu0YwGe6YanAjcxt8ExPp2YEMt+fCylKewMTykcDFQ35dIh/0LhseP
	Tw1iTu7j3alpBwcYSQmFFI/WUwuhXBQlnNUpHsnOj1YtNs+dztMV8KzXfmsovL2q
X-Gm-Gg: ATEYQzy7XtyEbILSSEiaib/ioWyiR+W622QeXN+iURIV8vPKeXlbNQDzvwxCVlD8mnw
	KH68ZzqzECIV6llBvRsrbtAPLINggaGQJeYiWaI7CeNwkPYUrzB2sQyFkHz0zdvoLu3F+DIs+34
	809d05Q5oigSwb1vwnAgcLaOvtd42pA91HYFh8c5YjmtnTEr9yEQsdc3PpIvlOsrSDumEylfYAs
	2r8IllGh8eeClGa3LmnYcvmP/TzKa6svAf3YAhPvGhnrYsKLtZaK1y9Z1QIlzhUdIklcllI6g3O
	/8cmK7HQS3mFDYG1Fyje7crXoCHrH6EQKGfvOSqZE6uFTMGbrOCznOxMpFQCY1ZHo/+LMShBhS6
	p6hPKHSMpUDPqDpKVLHRkgGLI6unoJa1JYxXnma3p8ZOtD/ncf58Wq8jnzCCDTfo22620OoPgA3
	twEIrX4fd0h1i8y8/LX8YipKcyhfwp7WU16fUFFVWRkYs1PcpLBx8Ldv2HWv+q2SkA8EKlkI2re
	nzPw3t4kAQ=
X-Received: by 2002:a05:6512:3b2c:b0:5a2:7b8b:8a80 with SMTP id 2adb3069b0e04-5a2abc3eedfmr1920106e87.3.1774705957433;
        Sat, 28 Mar 2026 06:52:37 -0700 (PDT)
Received: from pop-os.. ([2a02:2121:86b:dd40:8edb:ab33:1974:67a6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b1456dffsm459537e87.70.2026.03.28.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 06:52:35 -0700 (PDT)
From: Nikolaos Gkarlis <nickgarlis@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	nickgarlis@gmail.com,
	kuniyu@google.com
Subject: [PATCH net v3] rtnetlink: add missing netlink_ns_capable() check for peer netns
Date: Sat, 28 Mar 2026 14:52:15 +0100
Message-Id: <20260328135215.901879-1-nickgarlis@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272783-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35B3C34F00F
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

 net/core/rtnetlink.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index fae8034efbf..4be7fc6e23a 100644
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
@@ -3915,7 +3917,19 @@ static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
 			return ERR_PTR(err);
 	}
 
-	return rtnl_link_get_net_ifla(tb);
+	net = rtnl_link_get_net_ifla(tb);
+	if (IS_ERR(net))
+		return net;
+
+	if (!net)
+		return NULL;
+
+	if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
+		put_net(net);
+		return ERR_PTR(-EPERM);
+	}
+
+	return net;
 }
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -4054,7 +4068,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		if (ops->peer_type) {
-			peer_net = rtnl_get_peer_net(ops, tb, data, extack);
+			peer_net = rtnl_get_peer_net(skb, ops, tb, data, extack);
 			if (IS_ERR(peer_net)) {
 				ret = PTR_ERR(peer_net);
 				goto put_ops;
-- 
2.34.1


