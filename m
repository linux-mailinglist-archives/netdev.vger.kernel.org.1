Return-Path: <netdev+bounces-281747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBttFfJ+8GlSUAEAu9opvQ
	(envelope-from <netdev+bounces-281747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:33:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA254817DD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7B4930AE227
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A8388391;
	Tue, 28 Apr 2026 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8rv1Jwd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9455387359
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368406; cv=none; b=sV4/ATwUcI28VGn3A4YpVpjcRuIMXv7Lz8TRIImOJ/B5yNdccCBFAPYmya3sjZuvMyS/fFV2h4TPnaklKATsDRTjj+q4SLfp+fie3Kt1hT2t0vNfDhFP0pIO/btzY5chcqwJKr9b0Xw34IHiYJOfT2uyVsJEQaVqlSvwbQNF7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368406; c=relaxed/simple;
	bh=yq/s9uKlS46UrpyeneLRebLiJ7P5fmJnlmahGIHlFwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcADcE0rLvr7RYshAnLrCrW81wk5S82kuQMMJhxDjmcYlf3UgEx7M4Rmvpl5vYnaL3XhsAozfChbYeaenG6C8olebn2ncyHtht7DlHv1tP2PDRKgPr8CJeXnp6IvIO1UYya8sYQ2BWbpL4/UTotMti2FkMTd+bLHanh5wEkxGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8rv1Jwd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777368403; x=1808904403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yq/s9uKlS46UrpyeneLRebLiJ7P5fmJnlmahGIHlFwI=;
  b=m8rv1JwdFTe8V1fVsfkReBPZDGBAe90Ms+V+G54mHNw6Qkcb36YRicu2
   b5mZzjF2R+Si9IE7LA6IP/jzH13/ArALLwH82eWQm9n/xc4nUP53YsaRM
   1sJMxKKPD0pEGZu6fzcooNLyicKh0efSs2l0WkcoHea+Lt+GJzIuxfqh4
   SZJs1GliWvkTJoN64iTJsp0m7JsC7q2a4kKqsbOC7kR/HkBQgmqDW6QNW
   EhXksaftxJtGRbW7elG8iSsYMjyLpadu1UMq+3REXQ3Paf7dRlFK2c2Nk
   8W+YwvRwprqlrDQXCq3bY0V+fRxZ6keibmTl6ammww4sVRCvGemhiXYUX
   Q==;
X-CSE-ConnectionGUID: X/WjibfVTwW8lM+AjS1+VQ==
X-CSE-MsgGUID: GcE7lHOzSpu5SaVhAAk0fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="103731759"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="103731759"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:26:37 -0700
X-CSE-ConnectionGUID: ayKi81XLStevZ5V8yU6sHA==
X-CSE-MsgGUID: W81hOHn6TvqsDImOG9nIHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237861390"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 28 Apr 2026 02:26:33 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D68C928188;
	Tue, 28 Apr 2026 10:26:30 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 1/2] devlink, mlx5: add init/fini ops for shared devlink
Date: Tue, 28 Apr 2026 11:09:11 +0200
Message-Id: <20260428090912.3461-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260428090912.3461-1-przemyslaw.kitszel@intel.com>
References: <20260428090912.3461-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CFA254817DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281747-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

Add .shd_init() and .shd_fini() ops, that will be called for the first
devlink_shd_get() (to initialize driver' priv data) and on the last
devlink_shd_put() (to allow for the cleanup). Both ops are optional.

.shd_init() could return an error, which will stop creation of shd
instance. The initializer also gets an additional, optional param,
that driver could use for any needs.

If any of the callbacks will need to get devlink instance, it could
be accessed by shd_priv_to_devlink().

Both callbacks are called with devl_lock held and devlink registered.

Next commit will make use of the callbacks, another one will make use also
of the non-null additional param (outside of this series).

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
first discussed at:
https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com

Sashiko suggested to convert devlink_shd_create() to return ERR_PTR(),
and propagate that up to the driver. It think it will just make code more
verbose for not much benefit. And drivers could just store err if they
want in the passed @init_param.

---
 include/net/devlink.h                         | 26 +++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  2 +-
 net/devlink/sh_dev.c                          | 39 ++++++++++++++++++-
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index bcd31de1f890..5d3a1337bfa1 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1586,6 +1586,30 @@ struct devlink_ops {
 				    struct devlink_rate *parent,
 				    void *priv_child, void *priv_parent,
 				    struct netlink_ext_ack *extack);
+
+	/**
+	 * shd_init: Shared devlink instance initializer
+	 * @priv: shd_devlink' priv
+	 * @init_param: additional param to pass to driver callback
+	 *
+	 * Called once when the shared instance is first created (by the first
+	 * devlink_shd_get() call).
+	 * Should initialize the driver's private data embedded in the shared
+	 * devlink. May be NULL.
+	 *
+	 * Return: 0 on success, negative to prevent shared instance usage.
+	 */
+	int (*shd_init)(void *priv, void *init_param);
+	/**
+	 * shd_fini: Shared devlink instance finalizer
+	 * @priv: shd_devlink' priv
+	 *
+	 * Called once when the last reference is dropped and the shared
+	 * instance is destroyed. Should clean up the driver's private data.
+	 * May be NULL.
+	 */
+	void (*shd_fini)(void *priv);
+
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
@@ -1651,9 +1675,11 @@ void devlink_free(struct devlink *devlink);
 struct devlink *devlink_shd_get(const char *id,
 				const struct devlink_ops *ops,
 				size_t priv_size,
+				void *init_param,
 				const struct device_driver *driver);
 void devlink_shd_put(struct devlink *devlink);
 void *devlink_shd_get_priv(struct devlink *devlink);
+struct devlink *shd_priv_to_devlink(void *priv);
 
 /**
  * struct devlink_port_ops - Port operations
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
index b925364765ac..1b8b1ce7e72d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -43,7 +43,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
 	*end = '\0';
 
 	/* Get or create shared devlink instance */
-	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, NULL, pdev->dev.driver);
 	kfree(sn);
 	if (!devlink)
 		return -ENOMEM;
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
index 85acce97e788..048a2a6adc9e 100644
--- a/net/devlink/sh_dev.c
+++ b/net/devlink/sh_dev.c
@@ -34,6 +34,7 @@ static struct devlink_shd *devlink_shd_lookup(const char *id)
 static struct devlink_shd *devlink_shd_create(const char *id,
 					      const struct devlink_ops *ops,
 					      size_t priv_size,
+					      void *init_param,
 					      const struct device_driver *driver)
 {
 	struct devlink_shd *shd;
@@ -49,16 +50,30 @@ static struct devlink_shd *devlink_shd_create(const char *id,
 	if (!shd->id)
 		goto err_devlink_free;
 	shd->priv_size = priv_size;
-	refcount_set(&shd->refcount, 1);
 
 	devl_lock(devlink);
 	devl_register(devlink);
+
+	if (ops->shd_init) {
+		int err;
+
+		err = ops->shd_init(shd->priv, init_param);
+		if (err)
+			goto err_unregister;
+	}
+
 	devl_unlock(devlink);
 
+	refcount_set(&shd->refcount, 1);
 	list_add_tail(&shd->list, &shd_list);
 
 	return shd;
 
+err_unregister:
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	kfree(shd->id);
+
 err_devlink_free:
 	devlink_free(devlink);
 	return NULL;
@@ -69,7 +84,12 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
 	struct devlink *devlink = priv_to_devlink(shd);
 
 	list_del(&shd->list);
+
 	devl_lock(devlink);
+
+	if (devlink->ops->shd_fini)
+		devlink->ops->shd_fini(shd->priv);
+
 	devl_unregister(devlink);
 	devl_unlock(devlink);
 	kfree(shd->id);
@@ -81,6 +101,7 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
  * @id: Identifier string (e.g., serial number) for the shared instance
  * @ops: Devlink operations structure
  * @priv_size: Size of private data structure
+ * @init_param: Passed to .shd_init() callback alongside driver's priv
  * @driver: Driver associated with the shared devlink instance
  *
  * Get an existing shared devlink instance identified by @id, or create
@@ -96,16 +117,17 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
 struct devlink *devlink_shd_get(const char *id,
 				const struct devlink_ops *ops,
 				size_t priv_size,
+				void *init_param,
 				const struct device_driver *driver)
 {
 	struct devlink *devlink;
 	struct devlink_shd *shd;
 
 	mutex_lock(&shd_mutex);
 
 	shd = devlink_shd_lookup(id);
 	if (!shd) {
-		shd = devlink_shd_create(id, ops, priv_size, driver);
+		shd = devlink_shd_create(id, ops, priv_size, init_param, driver);
 		goto unlock;
 	}
 
@@ -159,3 +181,16 @@ void *devlink_shd_get_priv(struct devlink *devlink)
 	return shd->priv;
 }
 EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
+
+/** shd_priv_to_devlink - Get devlink instance from shd_devlink's priv
+ * @priv: Driver's priv data
+ *
+ * Return: pointer to shared devlink instance the @priv belongs to.
+ */
+struct devlink *shd_priv_to_devlink(void *priv)
+{
+	struct devlink_shd *shd = container_of(priv, struct devlink_shd, priv);
+
+	return priv_to_devlink(shd);
+}
+EXPORT_SYMBOL_GPL(shd_priv_to_devlink);
-- 
2.39.3


