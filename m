Return-Path: <netdev+bounces-198332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A740ADBDB5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364B13B4DB0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6D2367D2;
	Mon, 16 Jun 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHO3Wgx6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B52356CE
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116888; cv=none; b=bnBjhDfRcWNeuv9IlHfnrvGz/Z5eZ8Edrjl/nhyA6uB8Zrod1ExaxQfsUaXjKzkPiDzSKubJ9ndiBUtYX5ikU7lZ/ubGlQdKYOGcX2k3EogOIOBmQQ8IvGT8JlhycBHRLZKk91SGPRl6TPUege8XDlBV98gS0FUO+2lINGaJt1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116888; c=relaxed/simple;
	bh=0OEySdVR+r3/HnH6GCZmZWQ/TRNVG2bfVk0rJKJcjq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfC7g/L4ttQZa9yUkf1xyimNdgWoTDlDLdqdb5BQLnMJTKDVE45dFT2IlpV84tlBEyZ/r4PY/5o3lNMebAge1RNSpBKG5tSiVXJkK6QMjPRotMFx56tPXRn9lvvmil+TRrC/dQOjQ4/sULqQ+ahuEsIO4JC0MFY2oTzp3jLY8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHO3Wgx6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235f9e87f78so53091945ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116886; x=1750721686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNie8OgHgUOYpafww08f6fDRmCy2YystADTitoReSA0=;
        b=UHO3Wgx6fw79zukExIuEy2ILRDG5hpgdZfGgqUk5lYl74HysVzVQNWHx2VR0ijlXxQ
         pXbreqIiNr0iWegwJjtvp3Nh7yGDOnyLXNdWbo0tX52YSe8eFQaGipTtCFG2yYCwKOWM
         QgdPAf4q2TqnHjErEaGAIubthdJbogOxpP/MDtHZ1czPnoDGi6iOLdUjg/nqsDkepbUM
         IAuA+SsDbSJUprg9Dczz/89/0m38k0nvez/YIfyVMhaTUTTRxh2RT04iqbkWXu3Cek8t
         YJM6EQpqDWgA3bStcB3ExT29L9F7Gr7CZpbkXu2Sc4rvtkVFeGqo59EnSUiJHPITwhh+
         VQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116886; x=1750721686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNie8OgHgUOYpafww08f6fDRmCy2YystADTitoReSA0=;
        b=g6GA7Q8laYoohr1Eyo3GeZwC3kHUxkdnsyuRHGKdC0LXFwbp8abvk+7lshdW8VHXNZ
         0sOL5XePyqxy3e8jpgWLHT/oOngxR/VZftpm5ph8Wxn7MZZKPrCUxwwp+zUAiMZMywDP
         hawaGCFsAFFiIRN1W9haMm6H+kbgVksgIQsfCbbmElxZOLe3v39VrRWEHGaqlWpjNAl+
         gKnGebRnsaEyTX4oyu+zkeYZ+jMW19zTK/+QysdPyvGbaAqeJgdCrIdE2oQdNQN9KSCY
         OqCrDJv53pPULLmgXK6QRraPJTLotUZNMYeNa+NxTxRPVMg4D8HXKpvNyPi8DgET7pSk
         eWyw==
X-Forwarded-Encrypted: i=1; AJvYcCUwri7hLgRm28L2yeDxhv908l1ANV+ae7IX2B5xfn8nN54rRWCAuRk+GmkseYetPR/5r5LcanA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuAwjmA8qID9iq0o/W/DgorlafaKnfHykjcUK4uo8ScSz6VsyZ
	GYPfttDrgry+3gzBz9EFO6ta2/LLIJK6+cWj0Qe/8hdqKnjESighSo8=
X-Gm-Gg: ASbGncshrLXoOLHWN2jvIpcIIb3hd4ka3eladj5k6B8kMhi0i0Bzf+yAE9f2agAZe8R
	y4Q+wmPUvWBgTBkfkyMyHgxjZDc7F248oZJ+CPhoCkHFpJ2LfedmWvyFUOUnC6ClAnJaYiMeMJA
	KWK3W93l3pLoIDXlV5YLyQEy28IpnaCPm8UqSIcczcEDb0F31AOEFlYBSrCKilFKUj/TmRGGMt/
	aD27hcMwpdGtkmTMFqK2mSziai+zCp+cLVZQqOhmuHWm8OU5ifqiHyitUA6iu05e0YUe/AxWpSu
	ilXxZ6e3WyBE7bYdSL5uldKED7AXw2Cx7j5PnQk=
X-Google-Smtp-Source: AGHT+IFZ+wlW6uTYli+rKbjiNMRKE3XVC2eNU0zJ+9OGPToLFdxNX00ZfVqvG4mUaY6XyP8mil6+zA==
X-Received: by 2002:a17:902:da8b:b0:235:15f3:ef16 with SMTP id d9443c01a7336-2366affb2e4mr151823895ad.13.1750116886001;
        Mon, 16 Jun 2025 16:34:46 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:45 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 net-next 06/15] ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
Date: Mon, 16 Jun 2025 16:28:35 -0700
Message-ID: <20250616233417.1153427-7-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

In __ipv6_sock_mc_join(), per-socket mld data is protected by lock_sock(),
and only __dev_get_by_index() requires RTNL.

Let's use dev_get_by_index() and drop RTNL for IPV6_ADD_MEMBERSHIP and
MCAST_JOIN_GROUP.

Note that when we fetch dev from rt6_lookup(), we can call dev_hold()
safely for rt->dst.dev as it already holds refcnt for the dev if exists.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ipv6_sockglue.c |  2 --
 net/ipv6/mcast.c         | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 1e225e6489ea..cb0dc885cbe4 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -121,11 +121,9 @@ static bool setsockopt_needs_rtnl(int optname)
 {
 	switch (optname) {
 	case IPV6_ADDRFORM:
-	case IPV6_ADD_MEMBERSHIP:
 	case IPV6_DROP_MEMBERSHIP:
 	case IPV6_JOIN_ANYCAST:
 	case IPV6_LEAVE_ANYCAST:
-	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
 	case MCAST_JOIN_SOURCE_GROUP:
 	case MCAST_LEAVE_SOURCE_GROUP:
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b3f063b5ffd7..f36ab672fe72 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -175,14 +175,12 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 			       const struct in6_addr *addr, unsigned int mode)
 {
-	struct net_device *dev = NULL;
-	struct ipv6_mc_socklist *mc_lst;
 	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_mc_socklist *mc_lst;
 	struct net *net = sock_net(sk);
+	struct net_device *dev = NULL;
 	int err;
 
-	ASSERT_RTNL();
-
 	if (!ipv6_addr_is_multicast(addr))
 		return -EINVAL;
 
@@ -202,13 +200,16 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 
 	if (ifindex == 0) {
 		struct rt6_info *rt;
+
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
 			dev = rt->dst.dev;
+			dev_hold(dev);
 			ip6_rt_put(rt);
 		}
-	} else
-		dev = __dev_get_by_index(net, ifindex);
+	} else {
+		dev = dev_get_by_index(net, ifindex);
+	}
 
 	if (!dev) {
 		sock_kfree_s(sk, mc_lst, sizeof(*mc_lst));
@@ -219,12 +220,11 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 	mc_lst->sfmode = mode;
 	RCU_INIT_POINTER(mc_lst->sflist, NULL);
 
-	/*
-	 *	now add/increase the group membership on the device
-	 */
-
+	/* now add/increase the group membership on the device */
 	err = __ipv6_dev_mc_inc(dev, addr, mode);
 
+	dev_put(dev);
+
 	if (err) {
 		sock_kfree_s(sk, mc_lst, sizeof(*mc_lst));
 		return err;
-- 
2.49.0


