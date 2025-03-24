Return-Path: <netdev+bounces-177262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C15A6E6C2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0622175BAA
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FBB1EFFBE;
	Mon, 24 Mar 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjfSEg5S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220771EFFB4
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856379; cv=none; b=l2JX0W7PD7nc/bW1r0ke21M59F25fzaxolNMWlrmw3ZyeYrAZtXkvZeBlR2cWslAuPW2rDtCcCwIj0LZ6soSfL+hcn0S7RAPKExtjdxcOTYlc/GY6GIaY8d60WYkBUB6NiKHZ4Pbym3JI4UrOLrkyx9Xdmru3bDWBhtcvjECn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856379; c=relaxed/simple;
	bh=gy4V265Rzlh5uqWJcjwtsQl8QJYZ6Ht2/0ulv0joOBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSMORB13kOyHBeKu7cudS+Yw/FaOhauINWl/yOD97vVytp7yEPhEHgqic3P6jHNgZOhHuFPXbegLlKNmhuPHhsJ2gUUEfiYrHy+FVgoy/wexZAKxauxDNl4iRJt2/ACJuSyPyAK8Nv3bclhMMOTWSOX7AgcLS75iJnC7DVudGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjfSEg5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31C1C4CEED;
	Mon, 24 Mar 2025 22:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856379;
	bh=gy4V265Rzlh5uqWJcjwtsQl8QJYZ6Ht2/0ulv0joOBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjfSEg5SIcN7Z80CWgMT0PLArf5/LRCxtefl33Y9AxZZ2SzRo/K9e7YZRdqcsF/Jo
	 BPfx4Dm1wWhcsgfETfeyWa/Sx90vVOlxpeLo5Qkig6K/y6xctkB2xsSWQwD2/rxSNj
	 e3VdY4H2C19CbxzNkZw+EgKmpk2uslKY8wCFjdYzyz6cPRfjSY91SgS12AKXzCTwCF
	 Jz9q2KcCa0Zyck1Npv6yeq30wPWWI9kiV5MAFEceqg3HQT3jgqrgvV7ffzs9d3MXC4
	 cqdqc23h6qkdd4Oi+WcrU7/hCbm78FRIWIV7FLLvcciz7nW1zopbDYPSfcqbZua3Gg
	 Wx78O5xai5gDA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 08/11] net: make NETDEV_UNREGISTER and instance lock more consistent
Date: Mon, 24 Mar 2025 15:45:34 -0700
Message-ID: <20250324224537.248800-9-kuba@kernel.org>
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

The NETDEV_UNREGISTER notifier gets called under the ops lock
when device changes namespace but not during real unregistration.
Take it consistently, XSK tries to poke at netdev queue state
from this notifier.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 652f2c6f5674..7bd8bd82f66f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1848,7 +1848,9 @@ static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
 					dev);
 		call_netdevice_notifier(nb, NETDEV_DOWN, dev);
 	}
+	netdev_lock_ops(dev);
 	call_netdevice_notifier(nb, NETDEV_UNREGISTER, dev);
+	netdev_unlock_ops(dev);
 }
 
 static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
@@ -11174,8 +11176,11 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 			rtnl_lock();
 
 			/* Rebroadcast unregister notification */
-			list_for_each_entry(dev, list, todo_list)
+			list_for_each_entry(dev, list, todo_list) {
+				netdev_lock_ops(dev);
 				call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+				netdev_unlock_ops(dev);
+			}
 
 			__rtnl_unlock();
 			rcu_barrier();
@@ -11966,7 +11971,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* Notify protocols, that we are about to destroy
 		 * this device. They should clean all the things.
 		 */
+		netdev_lock_ops(dev);
 		call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+		netdev_unlock_ops(dev);
 
 		if (!dev->rtnl_link_ops ||
 		    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
-- 
2.49.0


