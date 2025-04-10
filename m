Return-Path: <netdev+bounces-180986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A73A835DE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDFC189E6D1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70047198A2F;
	Thu, 10 Apr 2025 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ7xFxuJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B054BA33
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249369; cv=none; b=TgKE+cUYPZcXrP4G32L0PDlZlwVtH1fzRy/drGoD1AfIH5gz+hMAW3nGzBmJ/BggAk1tdgOFf48fqD9IWMdNibNMxmg8UMWFAg0rfTMSkLyamiF8vok15xtrVoM2KCMX1PSYsHab7LzF9c1RiiHPH01wqfUH3B9Q0GXEhU5aR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249369; c=relaxed/simple;
	bh=ZFjZP6b7jXXyGF7nBqOtOt14X+Y6V4wTmhhopewqOC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1Hqrk9MizDA0fEsjJ6W2esyyYCOOZ4g2/IpuOvbknIuhPlLktzjknZiIWiyD/o5eiKH7kJyBm5ezwpqTJYkj3m4dL/RnmKN9QCijcMKjARZq6gEPPBxtiJuHjQKgNNEcPRaV9YFlE8YUl5+s2D8mXw9XbKtIfe5yVfXjC9BOQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ7xFxuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBCAC4CEE2;
	Thu, 10 Apr 2025 01:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249368;
	bh=ZFjZP6b7jXXyGF7nBqOtOt14X+Y6V4wTmhhopewqOC8=;
	h=From:To:Cc:Subject:Date:From;
	b=tJ7xFxuJmlAwXg73Tm/7To/ohOEZGXdjXgiogQ7o4P3AcXNoGVWfsUfvccU5Azzh7
	 Klxeqlrq/mTU0AsaMOfXFnXkMhTn20zJ23z3/A6L2TmkFHVANJjfZKScGzOALPkLOQ
	 5T/3JlcsYuXxmvxlJrLH+Yd8z+/20EPppgyr7fJCVrbo1NUMBoGKdnsH+NU5356xra
	 1+5LEMge/PBV+WWd6DfArdDvmmdPXxEfMCohj2xywdt+Pdh/jJ6ri94rpuzr7rRXwq
	 EqNia2mPc3cvgCEajtctOTiZVSqJ4WNagHtbAnzxlbkng+mIDcdH1AFZSWUNEApdjY
	 YP3u3vSGbzlvA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	sdf@fomichev.me,
	kuniyu@amazon.com
Subject: [PATCH net-next] net: convert dev->rtnl_link_state to a bool
Date: Wed,  9 Apr 2025 18:42:46 -0700
Message-ID: <20250410014246.780885-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdevice reg_state was split into two 16 bit enums back in 2010
in commit a2835763e130 ("rtnetlink: handle rtnl_link netlink
notifications manually"). Since the split the fields have been
moved apart, and last year we converted reg_state to a normal
u8 in commit 4d42b37def70 ("net: convert dev->reg_state to u8").

rtnl_link_state being a 16 bitfield makes no sense. Convert it
to a single bool, it seems very unlikely after 15 years that
we'll need more values in it.

We could drop dev->rtnl_link_ops from the conditions but feels
like having it there more clearly points at the reason for this
hack.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sdf@fomichev.me
CC: kuniyu@amazon.com
---
 .../networking/net_cachelines/net_device.rst      |  2 +-
 include/linux/netdevice.h                         | 10 ++--------
 net/core/dev.c                                    |  6 ++----
 net/core/rtnetlink.c                              | 15 ++++++++-------
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 6327e689e8a8..ca8605eb82ff 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -131,7 +131,7 @@ struct ref_tracker_dir              refcnt_tracker
 struct list_head                    link_watch_list
 enum:8                              reg_state
 bool                                dismantle
-enum:16                             rtnl_link_state
+bool                                rtnl_link_initilizing
 bool                                needs_free_netdev
 void*priv_destructor                struct net_device
 struct netpoll_info*                npinfo                                          read_mostly         napi_poll/napi_poll_lock
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dece2ae396a1..d3478e27e350 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1946,9 +1946,6 @@ enum netdev_reg_state {
  *
  *	@reg_state:		Register/unregister state machine
  *	@dismantle:		Device is going to be freed
- *	@rtnl_link_state:	This enum represents the phases of creating
- *				a new link
- *
  *	@needs_free_netdev:	Should unregister perform free_netdev?
  *	@priv_destructor:	Called from unregister
  *	@npinfo:		XXX: need comments on this one
@@ -2363,11 +2360,8 @@ struct net_device {
 
 	/** @moving_ns: device is changing netns, protected by @lock */
 	bool moving_ns;
-
-	enum {
-		RTNL_LINK_INITIALIZED,
-		RTNL_LINK_INITIALIZING,
-	} rtnl_link_state:16;
+	/** @rtnl_link_initializing: Device being created, suppress events */
+	bool rtnl_link_initializing;
 
 	bool needs_free_netdev;
 	void (*priv_destructor)(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index b52efa4cec56..bd23559bdd82 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11119,8 +11119,7 @@ int register_netdevice(struct net_device *dev)
 	 *	Prevent userspace races by waiting until the network
 	 *	device is fully setup before sending notifications.
 	 */
-	if (!dev->rtnl_link_ops ||
-	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
+	if (!(dev->rtnl_link_ops && dev->rtnl_link_initializing))
 		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
 
 out:
@@ -12034,8 +12033,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		 */
 		call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
 
-		if (!dev->rtnl_link_ops ||
-		    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
+		if (!(dev->rtnl_link_ops && dev->rtnl_link_initializing))
 			skb = rtmsg_ifinfo_build_skb(RTM_DELLINK, dev, ~0U, 0,
 						     GFP_KERNEL, NULL, 0,
 						     portid, nlh);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c23852835050..572cacbb39bd 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3580,7 +3580,7 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 			u32 portid, const struct nlmsghdr *nlh)
 {
-	unsigned int old_flags;
+	unsigned int old_flags, changed;
 	int err;
 
 	old_flags = dev->flags;
@@ -3591,12 +3591,13 @@ int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 			return err;
 	}
 
-	if (dev->rtnl_link_state == RTNL_LINK_INITIALIZED) {
-		__dev_notify_flags(dev, old_flags, (old_flags ^ dev->flags), portid, nlh);
-	} else {
-		dev->rtnl_link_state = RTNL_LINK_INITIALIZED;
-		__dev_notify_flags(dev, old_flags, ~0U, portid, nlh);
+	changed = old_flags ^ dev->flags;
+	if (dev->rtnl_link_initializing) {
+		dev->rtnl_link_initializing = false;
+		changed = ~0U;
 	}
+
+	__dev_notify_flags(dev, old_flags, changed, portid, nlh);
 	return 0;
 }
 EXPORT_SYMBOL(rtnl_configure_link);
@@ -3654,7 +3655,7 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 
 	dev_net_set(dev, net);
 	dev->rtnl_link_ops = ops;
-	dev->rtnl_link_state = RTNL_LINK_INITIALIZING;
+	dev->rtnl_link_initializing = true;
 
 	if (tb[IFLA_MTU]) {
 		u32 mtu = nla_get_u32(tb[IFLA_MTU]);
-- 
2.49.0


