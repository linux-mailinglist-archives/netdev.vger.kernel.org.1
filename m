Return-Path: <netdev+bounces-167806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CCFA3C67E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24103B76F2
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A2A2147F4;
	Wed, 19 Feb 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLvlm4nO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544619CC33;
	Wed, 19 Feb 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987179; cv=none; b=Ctr1+/floHoydFFmxBiYDumTOoRQEgJdZvJasu2OpmKIBbEu3bf6XmsKsy7tsIKzlig5o5yIjh+FUYcIMkty+JdubvHXOhfVVCekRfxgrW19x1cPd9OyGzqL4M7cH4+wg0aYHBO3gMUCnWWCT9G6HfMBCucs8r0oKJy0PeFUyoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987179; c=relaxed/simple;
	bh=MwD19ihbKaz4IBkMTRxc/PBUn4IuzdESisvBCresR44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ21Mclpk/ioxzYngMmIBHM9vQXSXF7RqrzxkdiEThjA+Hv7rubndpUKiXq+UJvP0GoaOVf3PhzaONpHkwsgod4IyVckZxfWfGdC+4QAEIdxeK3lmjKFn+KUqivPQSESojcvnlzQJtpMsuBX0pNnyyz9Ehoo5hqPaCxiqAsVJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLvlm4nO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739987178; x=1771523178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MwD19ihbKaz4IBkMTRxc/PBUn4IuzdESisvBCresR44=;
  b=CLvlm4nO5TEwjKrt4mBiV4y+7S+atYFqK0RjjU35ugunmNglyXEams0m
   wI9b3G5IdfOyvXm0/XTJXMtwQAN6NZ+p7l6dn79LPTi5AUTW1HgMqW+8B
   sWQKxPA/Ldwh/8d0DIUrERKuOhmFlT3H+bTpn4EyGwSKbKhfEqRz584om
   Iwdq50/EqVUoRsmwMGLdocaThKG3XZ2MkZ+ZCJ++OfmKRV8dmRuZyc75o
   A4XAbRLlHa2kSrzsS6X1Vu6vE37PtcqTdWprpRaNNynFOv9pX4E1JT0+Y
   NMg0KfSRsRs6lxiG5Zzu1uidEXAS5aU3l1nnsbV5TDICN+82VJR35XlwN
   Q==;
X-CSE-ConnectionGUID: IwAdkIkEQlW6TRwLCFCYvA==
X-CSE-MsgGUID: 5E+qTyDkRBOctPBl1ZCa5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="50953011"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="50953011"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:46:14 -0800
X-CSE-ConnectionGUID: YOtOd1d7QwCLO2vwn6JMHg==
X-CSE-MsgGUID: uUBZIoz/QmWhN/9y7wplPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119427317"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 19 Feb 2025 08:44:32 -0800
Received: from pkitszel-desk.intel.com (unknown [10.245.246.109])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A28D134302;
	Wed, 19 Feb 2025 16:44:21 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	ITP Upstream <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC net-next v2 2/2] devlink: give user option to allocate resources
Date: Wed, 19 Feb 2025 17:32:55 +0100
Message-ID: <20250219164410.35665-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current devlink resources are designed as a thing that user could limit,
but there is not much otherwise that could be done with them.
Perhaps that's the reason there is no much adoption despite API being
there for multiple years.

Add new mode of operation, where user could allocate/assign resources
(from a common pool) to specific devices.

That requires "occ set" support, triggered by user.
To support that mode, "occ get" is (only then) turned into a simple
"get/show" operation, as opposed to "ask driver about current occupation"
in the "legacy" mode.

Naming advice welcomed, for now the modes are reffered as:
legacy/static-occ/mlx vs new/ice/dynamic-occ
Perhaps "user-settable" for the new mode and "driver-only" for the legacy?
Does not matter much, as this will be only embedded in the
net/devlink/resource.c file as names/comments for clarity.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/devlink/resource.c | 94 +++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 20 deletions(-)

diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 2d6324f3d91f..c81d05427e12 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -14,25 +14,30 @@
  * @size_new: updated size of the resource, reload is needed
  * @size_valid: valid in case the total size of the resource is valid
  *              including its children
+ * @occ_mode: false for static occ mode == legacy mlx like
+ *            true for dynamic occ mode == new one for intel
  * @parent: parent resource
  * @size_params: size parameters
  * @list: parent list
  * @resource_list: list of child resources
  * @occ_get: occupancy getter callback
- * @occ_get_priv: occupancy getter callback priv
+ * @occ_set: occupancy setter callback
+ * @occ_priv: occupancy callbacks priv
  */
 struct devlink_resource {
 	const char *name;
 	u64 id;
 	u64 size;
 	u64 size_new;
 	bool size_valid;
+	bool occ_mode;
 	struct devlink_resource *parent;
 	struct devlink_resource_size_params size_params;
 	struct list_head list;
 	struct list_head resource_list;
 	devlink_resource_occ_get_t *occ_get;
-	void *occ_get_priv;
+	devlink_resource_occ_set_t *occ_set;
+	void *occ_priv;
 };
 
 static struct devlink_resource *
@@ -127,6 +132,9 @@ int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	if (resource->occ_set)
+		return resource->occ_set(size, info->extack, resource->occ_priv);
+
 	resource->size_new = size;
 	devlink_resource_validate_children(resource);
 	if (resource->parent)
@@ -152,13 +160,46 @@ devlink_resource_size_params_put(struct devlink_resource *resource,
 	return 0;
 }
 
-static int devlink_resource_occ_put(struct devlink_resource *resource,
-				    struct sk_buff *skb)
+static
+int devlink_resource_occ_size_put_legacy(struct devlink_resource *resource,
+					 struct sk_buff *skb)
+{
+	int err;
+
+	if (resource->occ_get) {
+		err = devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
+					 resource->occ_get(resource->occ_priv));
+		if (err)
+			return err;
+	}
+
+	if (resource->size != resource->size_new) {
+	    err = devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
+				     resource->size_new);
+		if (err)
+			return err;
+	}
+
+	err = nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_SIZE_VALID,
+			 resource->size_valid);
+	if (err)
+		return err;
+
+
+	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE,
+				  resource->size);
+}
+
+static int devlink_resource_occ_size_put(struct devlink_resource *resource,
+					 struct sk_buff *skb)
 {
-	if (!resource->occ_get)
-		return 0;
-	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
-				  resource->occ_get(resource->occ_get_priv));
+	if (!resource->occ_get || !resource->occ_set)
+		return devlink_resource_occ_size_put_legacy(resource, skb);
+
+	nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_SIZE_VALID, true);
+
+	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE,
+				  resource->occ_get(resource->occ_priv));
 }
 
 static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
@@ -173,23 +214,16 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	if (nla_put_string(skb, DEVLINK_ATTR_RESOURCE_NAME, resource->name) ||
-	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size) ||
 	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_ID, resource->id))
 		goto nla_put_failure;
-	if (resource->size != resource->size_new &&
-	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
-			       resource->size_new))
-		goto nla_put_failure;
-	if (devlink_resource_occ_put(resource, skb))
-		goto nla_put_failure;
 	if (devlink_resource_size_params_put(resource, skb))
 		goto nla_put_failure;
+	if (devlink_resource_occ_size_put(resource, skb))
+		goto nla_put_failure;
+
 	if (list_empty(&resource->resource_list))
 		goto out;
 
-	if (nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_SIZE_VALID,
-		       resource->size_valid))
-		goto nla_put_failure;
 
 	child_resource_attr = nla_nest_start_noflag(skb,
 						    DEVLINK_ATTR_RESOURCE_LIST);
@@ -476,7 +510,7 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 	WARN_ON(resource->occ_get);
 
 	resource->occ_get = occ_get;
-	resource->occ_get_priv = occ_get_priv;
+	resource->occ_priv = occ_get_priv;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
 
@@ -499,6 +533,26 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	WARN_ON(!resource->occ_get);
 
 	resource->occ_get = NULL;
-	resource->occ_get_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
+
+void devl_resource_occ_set_get_register(struct devlink *devlink,
+					u64 resource_id,
+					devlink_resource_occ_set_t *occ_set,
+					devlink_resource_occ_get_t *occ_get,
+					void *occ_priv)
+{
+	struct devlink_resource *resource;
+
+	lockdep_assert_held(&devlink->lock);
+
+	resource = devlink_resource_find(devlink, NULL, resource_id);
+	if (WARN_ON(!resource))
+		return;
+	WARN_ON(resource->occ_get || resource->occ_set);
+
+	resource->occ_set = occ_set;
+	resource->occ_get = occ_get;
+	resource->occ_priv = occ_priv;
+}
+EXPORT_SYMBOL_GPL(devl_resource_occ_set_get_register);
-- 
2.46.0


