Return-Path: <netdev+bounces-292880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AwsIfvNGGpjnggAu9opvQ
	(envelope-from <netdev+bounces-292880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3335FB5DC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1D8B30FD410
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81036A340;
	Thu, 28 May 2026 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVRjxFK8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F536B048
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010212; cv=none; b=boJV66opgtyHizKKO8nGaITPSEVl/RNwMDGQIj9099mbfvtOMchkJfPxEaRxiHCf+TI9H1RccwhlFTK6caStQWVO2aRAi4wREwfrEvDckuKlG53BwOPI0Mp4YO3ftPLkF16B4jlxbYoUR3FH9ey32pSZUoSLPrc7Uy0DFzKtiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010212; c=relaxed/simple;
	bh=LOaddzPwb4ErTBqRZxhkFtwRmm7X3CWp4KLICp1X0RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfODn0iyzKMLAQ3m3kPQ6L2JgsYxwnOoVOehdL7gpDn+ZVvBXGyaAq0a5J/hqNzvVaIVbaYOn5MEnFbcV4BlrKi2mgQvVKjBcV8o1zpkPbq0H9rhuErcGcdBH4A3S8xyMuZvHR1FOwKu+1Y/2NmTSRQQxohWZwM5bfkVZoApW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVRjxFK8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDF81F000E9;
	Thu, 28 May 2026 23:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010210;
	bh=iBTy/R6lnS/LJBFnuAjhUsq1Gr/mSXMAs8Tkoj+n0/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YVRjxFK8wMIVdtcMR/fZ4wEt3HAnTRruiim/yDjHgI7WSGqDnEoQp6zWufgazkh2G
	 e+dl0fMo4N1SA5m8D+iLUYL01h27cL3D+P+mKbMiTaptK5cjSpI6xDvTPwUua3VGXZ
	 VCn53XlJFKXiPJ3agoJkzyB5p4rRU53hHc5ChnDEq0H6VSIvRFBHyQnrm/BPhdOP2u
	 YxqAngcjV3MKevsNKWILwNgIExxzZ5eB/L8GzLl4qlcKIh3IOypwA2s9hQBbIaL8TU
	 wSO8z//3TMW5hy06uMocABNae5yrsSRxHKvKw3d/wpIzopKk1PhNVfJzHocoL6KGsp
	 DAFVYpO+EjOmg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/14] net: ethtool: serialize broadcast notification sequence allocation
Date: Thu, 28 May 2026 16:16:26 -0700
Message-ID: <20260528231637.251822-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292880-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2C3335FB5DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ethnl_bcast_seq is a global counter stamped into the nlmsg_seq field
of every multicast notification, allowing userspace to detect dropped
messages. Today the ordering is achieved by using rtnl_lock()

Moving forward we will want ethtool ops to run under just the netdev
instance lock so to establish ordering we need a separate lock
for notifications. With the netdev instance locks operations on
different devices may bypass each other but the expectation is
that it should not matter. What we need to prevent is:
 - notification IDs getting out of order
 - operations on one device getting out of order

For simplicity defer allocating the ID of the notification right
before the notification is delivered. This removes the need for
special handling in ethnl_rss_create_send_ntf().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/netlink.h |  1 -
 net/ethtool/netlink.c | 28 +++++++++++++++++-----------
 net/ethtool/rss.c     |  1 -
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 674c9c19529b..f94aaa66379c 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -10,7 +10,6 @@
 
 struct ethnl_req_info;
 
-u32 ethnl_bcast_seq_next(void);
 int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 			       const struct nlattr *nest, struct net *net,
 			       struct netlink_ext_ack *extack,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 6cbd13b61bd1..902ff7d0a71d 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -13,6 +13,12 @@
 static struct genl_family ethtool_genl_family;
 
 static bool ethnl_ok __read_mostly;
+
+/* Serializes broadcast notification sequence allocation with the multicast
+ * send, so that userspace observes nlmsg_seq monotonic in receive order
+ * regardless of which lock the caller holds (rtnl or instance lock).
+ */
+static DEFINE_MUTEX(ethnl_bcast_lock);
 static u32 ethnl_bcast_seq;
 
 #define ETHTOOL_FLAGS_BASIC (ETHTOOL_FLAG_COMPACT_BITSETS |	\
@@ -82,12 +88,6 @@ static void ethnl_sock_priv_destroy(void *priv)
 	}
 }
 
-u32 ethnl_bcast_seq_next(void)
-{
-	ASSERT_RTNL();
-	return ++ethnl_bcast_seq;
-}
-
 int ethnl_ops_begin(struct net_device *dev)
 {
 	int ret;
@@ -329,8 +329,7 @@ void *ethnl_dump_put(struct sk_buff *skb, struct netlink_callback *cb, u8 cmd)
 
 void *ethnl_bcastmsg_put(struct sk_buff *skb, u8 cmd)
 {
-	return genlmsg_put(skb, 0, ++ethnl_bcast_seq, &ethtool_genl_family, 0,
-			   cmd);
+	return genlmsg_put(skb, 0, 0, &ethtool_genl_family, 0, cmd);
 }
 
 void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd)
@@ -340,8 +339,15 @@ void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd)
 
 int ethnl_multicast(struct sk_buff *skb, struct net_device *dev)
 {
-	return genlmsg_multicast_netns(&ethtool_genl_family, dev_net(dev), skb,
-				       0, ETHNL_MCGRP_MONITOR, GFP_KERNEL);
+	struct nlmsghdr *nlh = nlmsg_hdr(skb);
+	int ret;
+
+	mutex_lock(&ethnl_bcast_lock);
+	nlh->nlmsg_seq = ++ethnl_bcast_seq;
+	ret = genlmsg_multicast_netns(&ethtool_genl_family, dev_net(dev), skb,
+				      0, ETHNL_MCGRP_MONITOR, GFP_KERNEL);
+	mutex_unlock(&ethnl_bcast_lock);
+	return ret;
 }
 
 /* GET request helpers */
@@ -1081,7 +1087,7 @@ void ethnl_notify(struct net_device *dev, unsigned int cmd,
 {
 	if (unlikely(!ethnl_ok))
 		return;
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	if (likely(cmd < ARRAY_SIZE(ethnl_notify_handlers) &&
 		   ethnl_notify_handlers[cmd]))
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 53792f53f922..65bad23d5c59 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -995,7 +995,6 @@ ethnl_rss_create_send_ntf(const struct sk_buff *rsp, struct net_device *dev)
 	nlh = nlmsg_hdr(ntf);
 	/* Convert the reply into a notification */
 	nlh->nlmsg_pid = 0;
-	nlh->nlmsg_seq = ethnl_bcast_seq_next();
 
 	genl_hdr = nlmsg_data(nlh);
 	genl_hdr->cmd =	ETHTOOL_MSG_RSS_CREATE_NTF;
-- 
2.54.0


