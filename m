Return-Path: <netdev+bounces-292881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Vr9IQzOGGqunggAu9opvQ
	(envelope-from <netdev+bounces-292881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:21:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC94C5FB5EB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75B9F3100DEE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBA36AB4B;
	Thu, 28 May 2026 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI/4jU1t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A136D9F1
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010213; cv=none; b=bCiMQEcTGu1d3EtxAN8KXrUbOq8OTrmrFgO7PaezCSUJLLyS4g12jtrnBKjGG6RgbWUk7SAT9yAyE2Mc42pt70wP8wZX9Pd4PY/ZVgMoyg8gm3mIej09URVEIA3JEB9AILS6lc8vjzU/DhVKXJ3FgjJDsT5JDWup2qcE0brm6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010213; c=relaxed/simple;
	bh=zfyyHeJnDdRWKIc4vkSawWyAhpq+EFNvhd4x6nIBXzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJkibMfCzfiUyoKLmub5+t6uuM8VwTop6JjsilYVYIe5g40iYoQlaMGAP27QtciRoUNKC2rZF6H/5pgExxqeQFYBi9sXZWKw1350ZJmsK+VeGCt2nqwoGWu/jLRTp1w56QOKbgstjTWkKuQR1iM+opFaKYKKqBu3G1t7s9f87ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI/4jU1t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEF11F00A3E;
	Thu, 28 May 2026 23:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010211;
	bh=nHOlKwzIquzQ01+xq/KHcOSCbRPLnYWPsrIfFWV0qBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EI/4jU1tqgxP5MKcIKNkFaNmYLNTfXiXkjaobFf7u7aaDY088drW3ftLvAHVYBe1z
	 Fafh0CrYgxJ3AKNG7Gk53msqwA10H/dVl2hwfsbk71ocWAwfSexm9HsdfLmYQngqgK
	 MkXkKsae4tr2zNYYA9c0KOzaAvE1p+h+y9YRrbGjBjuVpPRRPH3Muznwmh50N1tNCs
	 qMee+Vo+fO539UpQm/GoUl1L/f3YrQanFVHDlq+b9XxRr961Y+JosV/9IJn+IZRcT4
	 B2UIN+WrAGOpxJUhxQtvZMNQh0kAS7Uw2hHx0Dis/AIq/s1q0x7liWVP8A/1EEVt1h
	 LC+UxmfdqKK+A==
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
Subject: [PATCH net-next 04/14] net: ethtool: relax ethnl_req_get_phydev() locking assertion
Date: Thu, 28 May 2026 16:16:27 -0700
Message-ID: <20260528231637.251822-5-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292881-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC94C5FB5EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

phydev <> netdev linking and lifecycle depends on rtnl_lock.
We want to switch to instance locks for most ethtool ops.
Let's add an assert that ops locked devices don't use phydev
today. If one does we can either opt the phy ops out of
being purely ops locked, or do deeper surgery to make phy
locking ops-compatible. I don't think there's any fundamental
challenge to make that work.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/phy_link_topology.h   | 5 +++++
 drivers/net/phy/phy_link_topology.c | 8 ++++++++
 net/ethtool/netlink.c               | 6 ++++--
 net/ethtool/phy.c                   | 1 -
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 68a59e25821c..95575f68d5bc 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -36,6 +36,11 @@ struct phy_device_node {
 	struct phy_device *phy;
 };
 
+static inline bool phy_link_topo_empty(struct net_device *dev)
+{
+	return !dev->link_topo;
+}
+
 #if IS_ENABLED(CONFIG_PHYLIB)
 int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 1f1eb5d59b38..aed3b26c1674 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -10,6 +10,7 @@
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/xarray.h>
+#include <net/netdev_lock.h>
 
 static int netdev_alloc_phy_link_topology(struct net_device *dev)
 {
@@ -35,6 +36,13 @@ int phy_link_topo_add_phy(struct net_device *dev,
 	struct phy_device_node *pdn;
 	int ret;
 
+	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
+	 * currently protects the PHY topology. No driver currently mixes
+	 * the two, flag if someone tries. See also ethnl_req_get_phydev().
+	 */
+	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
+		return -EOPNOTSUPP;
+
 	if (!topo) {
 		ret = netdev_alloc_phy_link_topology(dev);
 		if (ret)
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 902ff7d0a71d..a91cc4bc964f 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -226,11 +226,13 @@ struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
 {
 	struct phy_device *phydev;
 
-	ASSERT_RTNL();
-
 	if (!req_info->dev)
 		return NULL;
 
+	/* If there is no PHY in sight there's no need for assert locking */
+	if (!phy_link_topo_empty(req_info->dev))
+		ASSERT_RTNL();
+
 	if (!req_info->phy_index)
 		return req_info->dev->phydev;
 
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index ddc6eab701ed..018b0412be86 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -78,7 +78,6 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	struct phy_device *phydev;
 	int ret;
 
-	/* RTNL is held by the caller */
 	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PHY_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev))
-- 
2.54.0


