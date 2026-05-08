Return-Path: <netdev+bounces-285821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP5NEe7e/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:02:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28254F6BB1
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2564307B85C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF943E277B;
	Fri,  8 May 2026 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfGaRppH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0FB3E121D
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245205; cv=none; b=bmg5Eum3r3gnDn858BvQ68DcK0Ez2/Ye/z9NzJho2vuhU9mSDFopifdEMxGGx7VKnEFqD2cHh+ThJOwnkxxb6Dj4eafOkOYJNTAnN4AopWh+d9Q/1uDvJfunavffy6ooNrRJbuGEuAYUivk0Y0bNYZG669whVIG+Fho/7NePNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245205; c=relaxed/simple;
	bh=NlcT9xFh6hWCogshEOFokLhWIlFsDsMi1nuEY7HZ7iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyqNOLPXFfRiiwo6f0am+jYV4Ba882x/mt2gGKTyrIVqNppvKElq/EBSszCcYgLCN9ohsMq2lRuc77mSzp4dkWI0ZffDyLzckKyJCETwR1Q9glIGRNyFVAcow7bG7FvOyY4hhbKF+/6cy0tzexCJ/imAg2CYBs2LBoPvW4K7228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfGaRppH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778245204; x=1809781204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NlcT9xFh6hWCogshEOFokLhWIlFsDsMi1nuEY7HZ7iw=;
  b=MfGaRppHZBar2XzMbhm9wqvgZFXdXMk3Nyz6koRJ02tp0nWuuCOlG9T/
   TMwLqyTI45zoblc7jCzWRTvpOtkADlhQSZ80d7TgpsWuq7tZWYuHEY3uh
   MxQXDbm/0B0RKfGlxX1xjb+ZTrMvZKsI0OiLGB+YFgcaES4C9udQ8mUXf
   xJ1TZES5a764TAMDyKIWhZ2Tjk9fot8hgIWLg7C2I4uMDJi7P4F/hFlrp
   PXLcVDUv8XPHC99+Ylegju1uw3nuE5UG/lD+CDsTGpvgEYb+NtCUmuove
   xaEYwhCY0SATTzzKJyTtZqYYV3KRx9ca9N7ZeSF9aqjx4CG7hrymnm5uE
   g==;
X-CSE-ConnectionGUID: pxnJOro4Q9KSmYAqbzdyrg==
X-CSE-MsgGUID: pK1YLNiVQmC2CAVFSerIZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79199984"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79199984"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 06:00:03 -0700
X-CSE-ConnectionGUID: K6FcwD4nRSKd5a8e+aoWBw==
X-CSE-MsgGUID: mFhI437QSkmor8bFyqD6Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241730183"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 05:59:57 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 904462FC44;
	Fri,  8 May 2026 13:59:55 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	bruce.richardson@intel.com,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	padraig.j.connolly@intel.com,
	ananth.s@intel.com,
	timothy.miskell@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1 13/15] devlink: give user option to allocate resources
Date: Fri,  8 May 2026 14:42:06 +0200
Message-Id: <20260508124208.11622-14-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F28254F6BB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285821-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
RFC, Feb '25
https://lore.kernel.org/intel-wired-lan/20250219164410.35665-3-przemyslaw.kitszel@intel.com

I have structured code to just choose "the mode" of operation based on
the presence of .occ_set callback, instead of naming the mode, what,
even if not the most clear code, avoids the need of naming the modes.
---
 include/net/devlink.h  |  7 +++
 net/devlink/resource.c | 98 +++++++++++++++++++++++++++++++++---------
 2 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 5d3a1337bfa1..9b777f02beca 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -420,6 +420,8 @@ devlink_resource_size_params_init(struct devlink_resource_size_params *size_para
 }
 
 typedef u64 devlink_resource_occ_get_t(void *priv);
+typedef int devlink_resource_occ_set_t(u64 size, struct netlink_ext_ack *extack,
+				       void *priv);
 
 #define DEVLINK_RESOURCE_ID_PARENT_TOP 0
 
@@ -1934,6 +1936,11 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 				    void *occ_get_priv);
 void devl_resource_occ_get_unregister(struct devlink *devlink,
 				      u64 resource_id);
+void devl_resource_occ_set_get_register(struct devlink *devlink,
+					u64 resource_id,
+					devlink_resource_occ_set_t *occ_set,
+					devlink_resource_occ_get_t *occ_get,
+					void *occ_priv);
 int devl_params_register(struct devlink *devlink,
 			 const struct devlink_param *params,
 			 size_t params_count);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 3d2f42bc2fb5..2212eff5230d 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -19,7 +19,8 @@
  * @list: parent list
  * @resource_list: list of child resources
  * @occ_get: occupancy getter callback
- * @occ_get_priv: occupancy getter callback priv
+ * @occ_set: occupancy setter callback
+ * @occ_priv: occupancy callbacks priv
  */
 struct devlink_resource {
 	const char *name;
@@ -32,7 +33,8 @@ struct devlink_resource {
 	struct list_head list;
 	struct list_head resource_list;
 	devlink_resource_occ_get_t *occ_get;
-	void *occ_get_priv;
+	devlink_resource_occ_set_t *occ_set;
+	void *occ_priv;
 };
 
 static struct devlink_resource *
@@ -137,6 +139,9 @@ int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	if (resource->occ_set)
+		return resource->occ_set(size, info->extack, resource->occ_priv);
+
 	resource->size_new = size;
 	devlink_resource_validate_children(resource);
 	if (resource->parent)
@@ -162,13 +167,40 @@ devlink_resource_size_params_put(struct devlink_resource *resource,
 	return 0;
 }
 
-static int devlink_resource_occ_put(struct devlink_resource *resource,
-				    struct sk_buff *skb)
+static int
+devlink_resource_occ_size_put_legacy(struct devlink_resource *resource,
+				     struct sk_buff *skb)
 {
-	if (!resource->occ_get)
-		return 0;
-	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
-				  resource->occ_get(resource->occ_get_priv));
+	if (devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size))
+		goto err;
+	if (resource->size != resource->size_new &&
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
+			       resource->size_new))
+		goto err;
+	if (resource->occ_get &&
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
+			       resource->occ_get(resource->occ_priv)))
+		goto err;
+	if (nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_SIZE_VALID,
+		       resource->size_valid))
+		goto err;
+
+	return 0;
+err:
+	return -EMSGSIZE;
+}
+
+static int devlink_resource_occ_size_put(struct devlink_resource *resource,
+					 struct sk_buff *skb)
+{
+	if (!resource->occ_get || !resource->occ_set)
+		return devlink_resource_occ_size_put_legacy(resource, skb);
+
+	if (nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_SIZE_VALID, true))
+		return -EMSGSIZE;
+
+	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE,
+				  resource->occ_get(resource->occ_priv));
 }
 
 static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
@@ -183,24 +215,16 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
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
+	if (devlink_resource_occ_size_put(resource, skb))
 		goto nla_put_failure;
 	if (devlink_resource_size_params_put(resource, skb))
 		goto nla_put_failure;
+
 	if (list_empty(&resource->resource_list))
 		goto out;
 
-	if (nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_SIZE_VALID,
-		       resource->size_valid))
-		goto nla_put_failure;
-
 	child_resource_attr = nla_nest_start_noflag(skb,
 						    DEVLINK_ATTR_RESOURCE_LIST);
 	if (!child_resource_attr)
@@ -634,6 +658,39 @@ int devl_resource_size_get(struct devlink *devlink,
 }
 EXPORT_SYMBOL_GPL(devl_resource_size_get);
 
+/**
+ * devl_resource_occ_set_get_register - register occupancy getter and setter
+ *
+ * @devlink: devlink
+ * @resource_id: resource id
+ * @occ_set: occupancy setter callback
+ * @occ_get: occupancy getter callback
+ * @occ_priv: occupancy getter callback priv
+ *
+ * Setter will be called when the user wants to change the resource size,
+ * getter is called to show the user what is current size of the resource.
+ */
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
+
 /**
  * devl_resource_occ_get_register - register occupancy getter
  *
@@ -657,7 +714,7 @@ void devl_resource_occ_get_register(struct devlink *devlink,
 	WARN_ON(resource->occ_get);
 
 	resource->occ_get = occ_get;
-	resource->occ_get_priv = occ_get_priv;
+	resource->occ_priv = occ_get_priv;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
 
@@ -678,9 +735,10 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	if (WARN_ON(!resource))
 		return;
 	WARN_ON(!resource->occ_get);
+	WARN_ON(resource->occ_set);
 
 	resource->occ_get = NULL;
-	resource->occ_get_priv = NULL;
+	resource->occ_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
 
-- 
2.39.3


