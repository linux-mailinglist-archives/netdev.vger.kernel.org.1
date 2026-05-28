Return-Path: <netdev+bounces-292891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF/jNw/OGGpjnggAu9opvQ
	(envelope-from <netdev+bounces-292891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:21:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACC55FB5FA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF685307235D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636937106E;
	Thu, 28 May 2026 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpTLkKjD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33F370D6C
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010222; cv=none; b=O7XlB33eP3FQ2t9dndgmoxXz3oB5heJr0cKJTunYfuHFNhrsi7RmQC8hNQpiZYKP5SZFGyIRswZ+hWVhhLy1Er800xSDEWX5fFE1dbuiJHpl8CnG22rSxWQEt7Pv8JdlBvx6W6lV+ildW+1KFWXkmweVw798zPlQWlTcVEWLnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010222; c=relaxed/simple;
	bh=jsqiGrpU20PIjRopejZUhRBiz1JHsnxpsa2oPxoeLLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZas/ihYIpD6oA8gk44w3sTuGJcZrL7SaRo/G/kGYfe51bpzKQ1yTyiZocU/dRNXyALSfiUCs3FHP5OGzMWfOhlLvaVQmJCcEg+xXhmfZE/IHV/01nBNJve5f7G9ETdFO6c3he5Wz3dIvgo/68DFBPWcUvEVc4YX6ou6QUyvFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpTLkKjD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D74C1F00A3C;
	Thu, 28 May 2026 23:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010221;
	bh=ZOCnHXmTk8MOEMZGUz4wF0xuk4KWTgdnT46dKntBzNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MpTLkKjDIyNOeg8CimoQGWLGSdbK5bndRUJLI8ll3brFbrhBWThZKZNhZQjqM1HWQ
	 8siKSRBbDPjq35/vTix+6QU+LxhfuKRNUSaukSCDY/aziTLrwn5HXb4rcBfM6rjq9y
	 z/5nqROyrqagsu3Sq1cAzOaWBfBC6tHvriEkkAgpF6IETMTa8OikfYkVwk6FY4ozgj
	 RnnOcdPjivOrRiNQGTpaRzwXutFf6hb5jvBuumHbijQVvEe75uVtBcd4y2vPesy0vY
	 UQDxQJU8GIhtDEnmDjNJz8Xhs0czvyRl6oVaFdlNHGfJovMNk31S9/El5cAKHtU8P1
	 n8jqMNI8ho19Q==
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
Subject: [PATCH net-next 14/14] docs: net: ethtool: document ops-locked drivers and op_needs_rtnl
Date: Thu, 28 May 2026 16:16:37 -0700
Message-ID: <20260528231637.251822-15-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292891-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2ACC55FB5FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Catch up various bits of documentation after the locking changes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/netdev-features.rst |  7 +++++++
 Documentation/networking/netdevices.rst      | 17 ++++++++++-------
 include/linux/ethtool.h                      | 10 ++++++++--
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
index 6293d47e5b09..f9e1f3921f53 100644
--- a/Documentation/networking/netdev-features.rst
+++ b/Documentation/networking/netdev-features.rst
@@ -76,6 +76,13 @@ netdev instance lock, that lock must be held as well. This should not be
 done from ndo_*_features callbacks. netdev->features should not be modified
 by driver except by means of ndo_fix_features callback.
 
+For "ops locked" drivers (see Documentation/networking/netdevices.rst),
+ethtool callbacks that may end up invoking netdev_update_features() must
+opt back into rtnl_lock by setting the matching ETHTOOL_OP_NEEDS_RTNL_*
+bit in ``ethtool_ops::op_needs_rtnl``. The ethtool core then keeps
+rtnl_lock held across those SET callbacks so the contract above still
+holds.
+
 ndo_features_check is called for each skb before that skb is passed to
 ndo_start_xmit. Driver may perform any non-trivial checks (e.g. exact
 header geometry / length) and withdraw features like HW_CSUM or TSO,
diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 60492d4df2ee..30a4219041d5 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -351,10 +351,6 @@ virtual and the physical device. To prevent deadlocks, the virtual device's
 lock must always be acquired before the physical device's (see
 ``netdev_nl_queue_create_doit``).
 
-In the future, there will be an option for individual
-drivers to opt out of using ``rtnl_lock`` and instead perform their control
-operations directly under the netdev instance lock.
-
 Device drivers are encouraged to rely on the instance lock where possible.
 
 For the (mostly software) drivers that need to interact with the core stack,
@@ -375,9 +371,16 @@ the instance lock.
 struct ethtool_ops
 ------------------
 
-Similarly to ``ndos`` the instance lock is only held for select drivers.
-For "ops locked" drivers all ethtool ops without exceptions should
-be called under the instance lock.
+For non-"ops locked" drivers ethtool_ops are executed under ``rtnl_lock``.
+
+For "ops locked" drivers ``ethtool_ops``, unlike ``ndos``, run under
+the instance lock **only**. Driver may request that ``rtnl_lock``
+is held around specific operations (both SET and GET) by setting
+appropriate bits in ``ethtool_ops::op_needs_rtnl`` (if necessary
+``ETHTOOL_OP_NEEDS_RTNL_*`` bit doesn't exist just add it). Commonly
+used core helpers which force drivers to selectively opt-in to
+``rtnl_lock`` protection include ``netdev_update_features()``,
+``netif_set_real_num_*_queues()``, and phylink helpers.
 
 struct netdev_stat_ops
 ----------------------
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 35ee57a0e5fa..b62028eaf28e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1177,8 +1177,14 @@ struct kernel_ethtool_ts_info {
  * @get_mm_stats: Query the 802.3 MAC Merge layer statistics.
  *
  * All operations are optional (i.e. the function pointer may be set
- * to %NULL) and callers must take this into account.  Callers must
- * hold the RTNL lock or netdev instance lock (see @op_needs_rtnl).
+ * to %NULL) and callers must take this into account.
+ *
+ * For traditional drivers callers hold ``rtnl_lock`` across the call.
+ * For "ops locked" drivers (see Documentation/networking/netdevices.rst)
+ * callers instead hold the netdev instance lock (``netdev_lock_ops``);
+ * ``rtnl_lock`` is additionally held only for callbacks for which
+ * the driver opts in via the matching ``ETHTOOL_OP_NEEDS_RTNL_*`` bit
+ * in @op_needs_rtnl.
  *
  * See the structures used by these operations for further documentation.
  * Note that for all operations using a structure ending with a zero-
-- 
2.54.0


