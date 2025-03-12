Return-Path: <netdev+bounces-174401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7064AA5E788
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31ABD7A9457
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F411F0E47;
	Wed, 12 Mar 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rco06rUi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411D1F03E4
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818938; cv=none; b=qG6VCNICFTlCP1xNZOc8SwPsEWiPhcmLNpX6Bczhzb2fAoOfPHYiaUBCAkikpJwCKyVFfNhYBGiRBVBEY3hGEHxOMRxKcVPFhXb1XV6gkCjqogYhNkGkSYVWb7oLFvyVhW1N2dRmdL/Ssdy8uU8MFkYpa5cC467QoSphQZFMLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818938; c=relaxed/simple;
	bh=AfbgA0hnPzi8/W4YlY1M32nuTyl1QpocHbaVMT0a0rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojqEujScGokkW295gnDOycrFQyRQ7bPL+FtFe0YD96QddQNZau7E8li4WOK2LlhazffQ/WLn2OBjQY3JA5lIG19bQFmu5NfQvbngOan1h00+pQ1ykDNynWAP4fl4e5GnXxZKkhHb5T2FK8gBFdIYqLNrHDsPxhH0Zoexm38w8zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rco06rUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFDEC4CEEB;
	Wed, 12 Mar 2025 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818937;
	bh=AfbgA0hnPzi8/W4YlY1M32nuTyl1QpocHbaVMT0a0rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rco06rUid5bhG2UC2mwOEdwfNnWZeJh4fZDz3swYxcTkzDFAJzNsGveyecrBaSDxa
	 L/abYeh6l1MFvZ+PyKmcyprp+AzQVzpfs/yVlOCHAqEaIK42i94mKYgGyv4Pgwy0Hm
	 /tgZT5qQp1J1LHgXIFPsCHsJq0WUKDl24fDPYv8aZqihc3zJhxhKkeFvwSWACxT+Gx
	 L9y02gvRvdhj6krq6BDqyjGDTe2+tV2ysLwFHbEmR2dnBbwb8Fcl0Ng7D/9ZvCSxy4
	 6JdXJVJR/WoApZ/n+3vn6sQRzrwHziVxdOQsFVVlSPqOAWyPOtHryeFvePFv8SIxrY
	 ze0IIn4Wubyiw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/11] net: make NETDEV_UNREGISTER and instance lock more consistent
Date: Wed, 12 Mar 2025 23:35:04 +0100
Message-ID: <20250312223507.805719-9-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312223507.805719-1-kuba@kernel.org>
References: <20250312223507.805719-1-kuba@kernel.org>
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
index ded6ffbda965..8296b4c159fe 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1856,7 +1856,9 @@ static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
 					dev);
 		call_netdevice_notifier(nb, NETDEV_DOWN, dev);
 	}
+	netdev_lock_ops(dev);
 	call_netdevice_notifier(nb, NETDEV_UNREGISTER, dev);
+	netdev_unlock_ops(dev);
 }
 
 static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
@@ -11155,8 +11157,11 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
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
@@ -11947,7 +11952,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* Notify protocols, that we are about to destroy
 		 * this device. They should clean all the things.
 		 */
+		netdev_lock_ops(dev);
 		call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+		netdev_unlock_ops(dev);
 
 		if (!dev->rtnl_link_ops ||
 		    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
-- 
2.48.1


