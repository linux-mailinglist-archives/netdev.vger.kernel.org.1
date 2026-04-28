Return-Path: <netdev+bounces-281683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM+1F+lk8GmWSwEAu9opvQ
	(envelope-from <netdev+bounces-281683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:42:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D69CA47F169
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4394D3170438
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935263DA5C9;
	Tue, 28 Apr 2026 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm+ync1M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858823D3CE2;
	Tue, 28 Apr 2026 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360936; cv=none; b=AbAaM+SQIDPMezL08ckekcxesXPIvV3pz9839iPNWLRMLoLX3Ojwk6XseRM8xe6XPmtBX6uIIcjZxF3MNa1ivUH40L0CR2KX7WYUXd5eqodqrlNnXRq1FKqNOHgllKRN0ThHJeKtloADLuLTv3IEfYyllYgmTgofMKo1L26y3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360936; c=relaxed/simple;
	bh=r+B/thzkNXyzFYtme/OIZkWSrnFaUmpj2YxmWtsupAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RibM9KbayFHwWO1sSgjdVGCaRoWfCsecdHxcZLs+nlPSA/IhyQA83BKClVE6csU8qOp4VwkGmcOd1gOmJ143CnUNxJ7KGt0Ly4encZ6TKe5o1SeO6vPtxezQTy5bAAfmYfGbu+Sc4GMwfwhaMFXZGxcCzNjWGdAmxkPn4KXwR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm+ync1M; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777360934; x=1808896934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+B/thzkNXyzFYtme/OIZkWSrnFaUmpj2YxmWtsupAw=;
  b=Lm+ync1MnYEkg+wP20fSWaQnmN7R59zQBqvMwdPvK5moC1DlP9UA4zHT
   MWVw6F0gpgua8McoK5SVL35YSqdLk7RuiZPl2t2t3XJb8YWtWSWnpoq1D
   7FnmeO8VI3rOs+Di/Gay6O9HjbOdsdG1ctqahQ/i9L7ffF2D67EZ3dTYf
   T94uMPn1QUYNNpQP9uzOwjfRgApB6/yopAKkaIzk6EEUSgFt5Rq9Ek82C
   ADaBnjnf6ThXpUupSVEVScZQFCwqWHinsE386uKL7Wc4BaBqXzIVZ6pjh
   jYfCpYWW4dLJKRjv0ahHzwgpwTyap1LjB65GqhIMDj4BwNt6Wm376+a0A
   w==;
X-CSE-ConnectionGUID: 5AY4KnlsQ8agcf+cj2t+BQ==
X-CSE-MsgGUID: QRpS/2vrTRS+WRCEhW+cBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82126030"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82126030"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:22:13 -0700
X-CSE-ConnectionGUID: hhuu/p7pSZWSOFlBNahEBA==
X-CSE-MsgGUID: RIXWXRZXTAeh+ec8t1+RkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229308638"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 28 Apr 2026 00:22:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 05A2D9B; Tue, 28 Apr 2026 09:22:10 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/9] thunderbolt: Allow service drivers to specify their own properties
Date: Tue, 28 Apr 2026 09:22:03 +0200
Message-ID: <20260428072209.3084930-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D69CA47F169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281683-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]

The XDomain properties can be useful for service drivers, for example to
implement a registry for the services they expose. So far there has been
no need for service drivers to specify these but with the USB4STREAM
driver that we are going to use them.

This adds remote and local side properties that the service drivers have
access to. Remote side is read-only but the local side can be changed by
a service driver. Also provide a mechanism to notify the remote side
that there are changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/xdomain.c | 95 ++++++++++++++++++++++++++++++-----
 include/linux/thunderbolt.h   | 12 +++++
 2 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 6e83f93eee83..781d88d06b93 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -640,6 +640,32 @@ void tb_unregister_protocol_handler(struct tb_protocol_handler *handler)
 }
 EXPORT_SYMBOL_GPL(tb_unregister_protocol_handler);
 
+static int update_service_properties(struct device *dev, void *data)
+{
+	struct tb_property_dir *root = data;
+	struct tb_service *svc;
+	struct tb_property *p;
+
+	svc = tb_to_service(dev);
+	if (!svc)
+		return 0;
+
+	guard(mutex)(&svc->lock);
+
+	/*
+	 * Replace the static service properties with the dynamic one.
+	 * Typically this is the same but service drivers can add their
+	 * own dynamic properties here too.
+	 */
+	p = tb_property_find(root, svc->key, TB_PROPERTY_TYPE_DIRECTORY);
+	if (!p)
+		return 0;
+	if (svc->local_properties)
+		return tb_property_merge_dir(p->value.dir,
+					     svc->local_properties, false);
+	return 0;
+}
+
 static void update_property_block(struct tb_xdomain *xd)
 {
 	mutex_lock(&xdomain_lock);
@@ -664,6 +690,9 @@ static void update_property_block(struct tb_xdomain *xd)
 		tb_property_add_text(dir, "deviceid", utsname()->nodename);
 		tb_property_add_immediate(dir, "maxhopid", xd->local_max_hopid);
 
+		/* Add service specific dynamic properties */
+		device_for_each_child(&xd->dev, dir, update_service_properties);
+
 		ret = tb_property_format_dir(dir, NULL, 0);
 		if (ret < 0) {
 			dev_warn(&xd->dev, "local property block creation failed\n");
@@ -936,6 +965,40 @@ void tb_unregister_service_driver(struct tb_service_driver *drv)
 }
 EXPORT_SYMBOL_GPL(tb_unregister_service_driver);
 
+static int update_xdomain(struct device *dev, void *data)
+{
+	struct tb_xdomain *xd;
+
+	xd = tb_to_xdomain(dev);
+	if (xd) {
+		queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
+				   msecs_to_jiffies(50));
+	}
+
+	return 0;
+}
+
+/**
+ * tb_service_properties_changed() - Notify the other host about changes
+ * @svc: Service whose properties changed
+ *
+ * Notifies the other host that service properties may have been
+ * changed. This should be called whenever @svc->local_properties is
+ * updated.
+ */
+void tb_service_properties_changed(struct tb_service *svc)
+{
+	struct tb_xdomain *xd = tb_service_parent(svc);
+
+	if (xd->is_unplugged)
+		return;
+
+	scoped_guard(mutex, &xdomain_lock)
+		xdomain_property_block_gen++;
+	update_xdomain(&xd->dev, NULL);
+}
+EXPORT_SYMBOL_GPL(tb_service_properties_changed);
+
 static ssize_t key_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
@@ -1035,6 +1098,7 @@ static void tb_service_release(struct device *dev)
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 	struct tb_xdomain *xd = tb_service_parent(svc);
 
+	tb_property_free_dir(svc->remote_properties);
 	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
@@ -1049,6 +1113,16 @@ const struct device_type tb_service_type = {
 };
 EXPORT_SYMBOL_GPL(tb_service_type);
 
+static void update_service(struct tb_service *svc, struct tb_property *property)
+{
+	struct tb_property_dir *dir = property->value.dir;
+
+	guard(mutex)(&svc->lock);
+	tb_property_free_dir(svc->remote_properties);
+	svc->remote_properties = tb_property_copy_dir(dir);
+	kobject_uevent(&svc->dev.kobj, KOBJ_CHANGE);
+}
+
 static void __unregister_service(struct device *dev)
 {
 	struct tb_service *svc = tb_to_service(dev);
@@ -1109,6 +1183,12 @@ static int populate_service(struct tb_service *svc,
 	if (!svc->key)
 		return -ENOMEM;
 
+	svc->remote_properties = tb_property_copy_dir(dir);
+	if (!svc->remote_properties) {
+		kfree(svc->key);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -1133,6 +1213,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		/* If the service exists already we are fine */
 		dev = device_find_child(&xd->dev, p, find_service);
 		if (dev) {
+			update_service(tb_to_service(dev), p);
 			put_device(dev);
 			continue;
 		}
@@ -1156,6 +1237,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
 		svc->dev.parent = get_device(&xd->dev);
+		mutex_init(&svc->lock);
 		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
 
 		tb_service_debugfs_init(svc);
@@ -2549,19 +2631,6 @@ bool tb_xdomain_handle_request(struct tb *tb, enum tb_cfg_pkg_type type,
 	return ret > 0;
 }
 
-static int update_xdomain(struct device *dev, void *data)
-{
-	struct tb_xdomain *xd;
-
-	xd = tb_to_xdomain(dev);
-	if (xd) {
-		queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
-				   msecs_to_jiffies(50));
-	}
-
-	return 0;
-}
-
 static void update_all_xdomains(void)
 {
 	bus_for_each_dev(&tb_bus_type, NULL, NULL, update_xdomain);
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index e98d569779f9..f60e3a1aecae 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -397,6 +397,10 @@ void tb_unregister_protocol_handler(struct tb_protocol_handler *handler);
  * @prtcvers: Protocol version from the properties directory
  * @prtcrevs: Protocol software revision from the properties directory
  * @prtcstns: Protocol settings mask from the properties directory
+ * @lock: Protects this structure
+ * @local_properties: Properties owned by the service driver
+ * @remote_properties: Properties read from the remote service. These
+ *		       are read-only.
  * @debugfs_dir: Pointer to the service debugfs directory. Always created
  *		 when debugfs is enabled. Can be used by service drivers to
  *		 add their own entries under the service.
@@ -404,6 +408,9 @@ void tb_unregister_protocol_handler(struct tb_protocol_handler *handler);
  * Each domain exposes set of services it supports as collection of
  * properties. For each service there will be one corresponding
  * &struct tb_service. Service drivers are bound to these.
+ *
+ * Service drivers can add their own dynamic properties to
+ * @local_properties but whenever they do so @lock must be held.
  */
 struct tb_service {
 	struct device dev;
@@ -413,6 +420,9 @@ struct tb_service {
 	u32 prtcvers;
 	u32 prtcrevs;
 	u32 prtcstns;
+	struct mutex lock;
+	struct tb_property_dir *local_properties;
+	struct tb_property_dir *remote_properties;
 	struct dentry *debugfs_dir;
 };
 
@@ -481,6 +491,8 @@ static inline struct tb_xdomain *tb_service_parent(struct tb_service *svc)
 	return tb_to_xdomain(svc->dev.parent);
 }
 
+void tb_service_properties_changed(struct tb_service *svc);
+
 /**
  * struct tb_nhi - thunderbolt native host interface
  * @lock: Must be held during ring creation/destruction. Is acquired by
-- 
2.50.1


