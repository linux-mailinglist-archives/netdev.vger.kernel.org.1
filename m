Return-Path: <netdev+bounces-147811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD089DBF7F
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 07:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857C7281CF0
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB894204E;
	Fri, 29 Nov 2024 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpFmr7AO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF40BA4B
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732861897; cv=none; b=LqzJlXew+292MPB2ErLq7mXk82a6AxUuSvp7lBk0zzCmRvJv52Iwv5s2BiRZARKfiBh5/yt7ETOZI67aN4NHqo/T4BrL4gp+sjmjpvyMD3Ge23gu7R9A2vhxfVMpQ7qCpETY1cdvTwoDGzMD5EGfjmlk2i9XriEN4MeBaMzwQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732861897; c=relaxed/simple;
	bh=ObgqX2kspr3KtR6xY7eAW6Ko6OzyPxHQac059NIe5gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PXcRYrqE7cf9GXm8nnBySEKdhbxf+MBzFKuZGLojlDx3MAWwi6IB21SyNz5RkW6HVTRUE9tqG7kk4FC4CAub7pdxjTWUtX0lar6pGoje2qgFS/ZzXONFpoBOYJXSgd5sZolNRLn+5Rk6k27c6nxFvvDyH2yBy9LU9Alvt1o8Qv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpFmr7AO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2153e642114so3577215ad.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 22:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732861895; x=1733466695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCfZDA2SrJbnV3TIEDcrVIHAOg/aMmLsNkdtweqEN7A=;
        b=KpFmr7AOXvnaKo/Imv4hzY9IXLIHC8MTbOqF/2bCOhdChaHvchgrbhetmXN6G3Lksm
         1GsISycoAWL0xWdnjv1Hfbzeu6m+/cBiTL1IIPOYNMFb8nDPTsDCD5DhSivWCvv48Ete
         eHMQ8pcdefCPLhO/vHCLwQmi3HEG3WS3sCeAzNFH/jsK/9QNwn/8JcL8r4IZr1HxL2Y9
         CrsH+2XUyVE+feuuZtOZJ3uX6Pt0tzmrMOh5nImXy/UPSRHrcnwytVFfZ4qHgNyWN2Rs
         7ch/xgnz/5ikoDU3y1aVxQuVWu4TB82pB9u/Z5xJMNl9FyiD1XkUawBM/jJVKtUOG1wN
         3Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732861895; x=1733466695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCfZDA2SrJbnV3TIEDcrVIHAOg/aMmLsNkdtweqEN7A=;
        b=j5izNe5OCy8dEzvPGBloozO8vGOxIz/daOkbp5OpofZ/2M2+Z92Xn3xaIDYlcNU2Uk
         yeYLdDuVb3QiYBgLkZytD3mCeEl+bWEF3O2cGsRts9PjTCzvNrXwkQmmnUTfMfruZcXd
         5388OoyoAt6Gu4ae9s8rsAOphH6aWG5MaAw/hCTnODWLyEV4kqamYxoRZFXla1zsHK6y
         GTbTn9anSH37o9siG0KH3gsqn5l4V0gonJrEV6lOz44ssh3EuPsSd5pioFSfN7kOqMNL
         lCMxzau9oYLyLqXkgn5rYETefulp7Q5dcP/zGsCR+jeKpJNAngOB64FvqIfMddeWltI+
         d5TA==
X-Gm-Message-State: AOJu0YxMK3+QXY0B0Q68KhLOg7cqR/hzUJ2iPSWE3LL3xl8HBeEIQ0YZ
	A7nJrFE1EAVQKaizP8T1LzrC3BkpukzqxbL0QY09XvXAzLZIg+4bnefywQ==
X-Gm-Gg: ASbGnctSmKGcYLFlomDI6911MeEzIgZCYH/sNH6OytIihS2ICjiuii+BfC97zYOi3h4
	m80R/vs7a5q36KNSryIPg6UpZwaoESV55G6geIFXTziIL4N7WVWy/S9daNTSMTdWuu+wL0jm2+F
	6Qfx413Kx1c/WxLhpuvWckYDoN+2br1PgQyNnp/sbU1EHMdFY1uWu63PINwnCTbNxdBrvDZCfjf
	c72/IXhwS1c2IwDMdML49w+Agf8PbNCeEv6fBrHS2I4hengh1bdCmll2rae0/KnbBdAtQehAzGU
	EuY=
X-Google-Smtp-Source: AGHT+IFEQzUFhsSAxCdTFBsadB0wvUarHLAQ41nsbh9DTyJs3ziT+YbJFMva3VftkggUZes8B/Y7cg==
X-Received: by 2002:a17:902:fc8d:b0:202:26d:146c with SMTP id d9443c01a7336-21501086f0bmr133547365ad.5.1732861894996;
        Thu, 28 Nov 2024 22:31:34 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:f167:44c5:4190:90c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f485bsm23768145ad.31.2024.11.28.22.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 22:31:34 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>,
	syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [Patch net] rtnetlink: catch error pointer for rtnl_link_get_net()
Date: Thu, 28 Nov 2024 22:31:12 -0800
Message-Id: <20241129063112.763095-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Currently all callers of rtnl_link_get_net() assume that it always
returns a valid netns pointer, when rtnl_link_get_net_ifla() fails,
it uses 'src_net' as a fallback.

This is not true, because rtnl_link_get_net_ifla() can return an
error pointer too, we need to handle this error case and propagate
the error code to its callers.

Add a comment to better document its return value.

Reported-by: syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=21ba4d5adff0b6a7cfc6
Fixes: 0eb87b02a705 ("veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.")
Fixes: 6b84e558e95d ("vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.")
Fixes: fefd5d082172 ("netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.")
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 drivers/net/can/vxcan.c |  3 +++
 drivers/net/netkit.c    |  3 +++
 drivers/net/veth.c      |  3 +++
 net/core/rtnetlink.c    | 12 ++++++++++++
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index da7c72105fb6..6d03a5314034 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -204,6 +204,9 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 	}
 
 	peer_net = rtnl_link_get_net(net, tbp);
+	if (IS_ERR(peer_net))
+		return PTR_ERR(peer_net);
+
 	peer = rtnl_create_link(peer_net, ifname, name_assign_type,
 				&vxcan_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index bb07725d1c72..44fe99a82ac3 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -386,6 +386,9 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	net = rtnl_link_get_net(src_net, tbp);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
 	peer = rtnl_create_link(net, ifname, ifname_assign_type,
 				&netkit_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0d6d0d749d44..3a42a982c638 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1801,6 +1801,9 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 	}
 
 	net = rtnl_link_get_net(src_net, tbp);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
 	peer = rtnl_create_link(net, ifname, name_assign_type,
 				&veth_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index dd142f444659..6a4363276117 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2527,6 +2527,18 @@ static struct net *rtnl_link_get_net_ifla(struct nlattr *tb[])
 	return net;
 }
 
+/**
+ * rtnl_link_get_net - Get the network namespace from the netlink attributes
+ * or just @src_net.
+ *
+ * @src_net: the source network namespace
+ * @tb: the netlink attributes
+ *
+ * Returns:
+ *   The network namespace specified in the netlink attributes,
+ *   in case of error, an error pointer is returned.
+ *   Or, @src_net if no netns attributes were passed.
+ */
 struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
 {
 	struct net *net = rtnl_link_get_net_ifla(tb);
-- 
2.34.1


