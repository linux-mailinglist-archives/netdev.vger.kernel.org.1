Return-Path: <netdev+bounces-177265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA4A6E6C7
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98991752F3
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DAA1F0E43;
	Mon, 24 Mar 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+N7hCwp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848551F0E33
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856390; cv=none; b=uIz7ZXHaP3ier6lwfgMh+1DCBWEoB6Oo2O+Wt4ImqgYY8tUddvv1wmCQ8jpeaB5eWxZs6+by4JJBY710RsQUQEN7mJWBdosHDrEXHd6NlW/vKMjNWI6UoMW0TchNq7j+QYEROlYP/SsGEDZw+7PI9XhqR9/vW7ZVP7ROA87n0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856390; c=relaxed/simple;
	bh=ZMamlOjj30l+91Ix7h1ymxQ9VxErzprFR5DvNK34rEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5DDJCvg9MkvdZ3QM4RTnI2xPPSwu1dMlvd1k5pln6KkIpH2LAMjy+KOBiWus9ob/7IQuxRgiGCXARjyVpsV2tWR1l6gHQ6G1tYyqyPXtyBe0zQW/nZI6/QVYCYqy9ROupqRhIrCST3OXescVf9Ce3KErdmlmzyGksTn/RHGtxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+N7hCwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B987C4CEDD;
	Mon, 24 Mar 2025 22:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856390;
	bh=ZMamlOjj30l+91Ix7h1ymxQ9VxErzprFR5DvNK34rEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+N7hCwpMak8UhPhPmlmeo8ILxLEBfIzDgiion2oc9fR+wRKD2T/Re6D74XZg716Z
	 CR4v2K+4yYnu+zzEY4tun+No/D8zINE6HhX1fHItoAfU6dt1lGydlhrCvykU23uRSE
	 mi6mBkmkBrun1Y3n1fQkft8iogojEg3URAKxPftO8jevQ/DCGEiycdcI2CaNl8dZTN
	 6EeZCKyxLku4j/fYsKRAyC1GYX7EVsVMKftY5+u0KExGQ5g5tk/5J4zi27GPFrWhmI
	 r0qYump9BWNZ+fHAXBTYUEnfvtAebYl5/kOXkrpOOEHFCGBi2T1V6oHQhDPctwLHMt
	 nLcd78PldAoDQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/11] netdev: don't hold rtnl_lock over nl queue info get when possible
Date: Mon, 24 Mar 2025 15:45:37 -0700
Message-ID: <20250324224537.248800-12-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324224537.248800-1-kuba@kernel.org>
References: <20250324224537.248800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netdev queue dump accesses: NAPI, memory providers, XSk pointers.
All three are "ops protected" now, switch to the op compat locking.
rtnl lock does not have to be taken for "ops locked" devices.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fd1cfa9707dc..39f52a311f07 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -481,18 +481,15 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!rsp)
 		return -ENOMEM;
 
-	rtnl_lock();
-
-	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	netdev = netdev_get_by_index_lock_ops_compat(genl_info_net(info),
+						     ifindex);
 	if (netdev) {
 		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
-		netdev_unlock(netdev);
+		netdev_unlock_ops_compat(netdev);
 	} else {
 		err = -ENODEV;
 	}
 
-	rtnl_unlock();
-
 	if (err)
 		goto err_free_msg;
 
@@ -541,17 +538,17 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
 		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
 
-	rtnl_lock();
 	if (ifindex) {
-		netdev = netdev_get_by_index_lock(net, ifindex);
+		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
 		if (netdev) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
-			netdev_unlock(netdev);
+			netdev_unlock_ops_compat(netdev);
 		} else {
 			err = -ENODEV;
 		}
 	} else {
-		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
+		for_each_netdev_lock_ops_compat_scoped(net, netdev,
+						       ctx->ifindex) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
@@ -559,7 +556,6 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ctx->txq_idx = 0;
 		}
 	}
-	rtnl_unlock();
 
 	return err;
 }
-- 
2.49.0


