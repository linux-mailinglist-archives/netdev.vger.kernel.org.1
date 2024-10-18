Return-Path: <netdev+bounces-136943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DEF9A3B59
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BD11C23D65
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5FB202F71;
	Fri, 18 Oct 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYmdeY7P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4020125C
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246837; cv=none; b=qfZdiz2wQZo/upKEyb9l3npNd8VgNnF8qo+hzGHS693EqO8OUSrQ1ilz+uo3Ub7oFe26DlGIyi0/RQla5wgeBhdXGJdNnYBhQQxrh1V/RBHKBxo0rIfFgAguMCQuDuhYxVb7EnJB1uo+27uniLCfRX9wWXDNESIsydXiXDN5+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246837; c=relaxed/simple;
	bh=YwYgQITKimu8KB1x/DmCeal71HAcIrT4nSe8L03JW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJP243VqWpffLTw+Dbqvp0lgwnTUDwou70PRGBRXPZD6dA7SsQ/Ri1ijnBFdYTp+xQnnBEYAwBbp9M6QbI1e2V4khh1rWpyE90ny0xYVn7Zn5TYPcZh4QyhM5tDBl6bwhd87ocAGeZVMgYg6PsjbElLVuEmdfNXI7x3e4fNK+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYmdeY7P; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246836; x=1760782836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YwYgQITKimu8KB1x/DmCeal71HAcIrT4nSe8L03JW/E=;
  b=FYmdeY7Ps+509RI+eK5Nl8Lja0z0qYBoq9zO9bCHWtE2F7EQ1sO2UL5d
   0oPjEj1GPqv2zvvZzNO9CTDRqCJG+pwSbFewHQRgC5n0/RqssaYEgJ/yx
   A9TyZfmpm6BOIxxdclqmkkNJXgB4AN+6suqMSg/CPGCqjRgmxWxiew2hQ
   fInMOdWQA49pAyU24eBxCWe1Gevo0g7o5YYHkAvTcEgyaAsQY1Bwg7SGn
   RfzHsBjq7SkB7WtbYUHMSt5dXiVLA5cwrPJNu/XVZy+urDe2znOTWDvM2
   Ig/4CLHNHMU1YA5eix9JW+rxCPp7cQH5w0iQnzaEzUQI6NfoaxKbKsJdg
   A==;
X-CSE-ConnectionGUID: kV7v14M0SjCIAG4Q7bX+Lw==
X-CSE-MsgGUID: LYI7WQSxTg6sH+qClFCLKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39401221"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39401221"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:20:36 -0700
X-CSE-ConnectionGUID: Kh5e6qPYSU62rZ0EXFOaRQ==
X-CSE-MsgGUID: ATNiBYvXSGquMoyHMBBJKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78789312"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 03:20:33 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EE24D27BD2;
	Fri, 18 Oct 2024 11:20:31 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH v1 2/7] devlink: use devlink_nl_put_u64() helper
Date: Fri, 18 Oct 2024 12:18:31 +0200
Message-ID: <20241018102009.10124-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
References: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devlink_nl_put_u64() shortcut added by prev commit on all devlink/.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/devlink/dev.c      | 12 ++++++------
 net/devlink/dpipe.c    | 18 ++++++++----------
 net/devlink/health.c   | 25 +++++++++++--------------
 net/devlink/rate.c     |  8 ++++----
 net/devlink/region.c   | 11 ++++-------
 net/devlink/resource.c | 27 ++++++++++++---------------
 net/devlink/trap.c     | 34 ++++++++++++++--------------------
 7 files changed, 59 insertions(+), 76 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 13c73f50da3d..9264bbc90d0c 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -971,14 +971,14 @@ static int devlink_nl_flash_update_fill(struct sk_buff *msg,
 	    nla_put_string(msg, DEVLINK_ATTR_FLASH_UPDATE_COMPONENT,
 			   params->component))
 		goto nla_put_failure;
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_FLASH_UPDATE_STATUS_DONE,
-			      params->done, DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_FLASH_UPDATE_STATUS_DONE,
+			       params->done))
 		goto nla_put_failure;
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_FLASH_UPDATE_STATUS_TOTAL,
-			      params->total, DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_FLASH_UPDATE_STATUS_TOTAL,
+			       params->total))
 		goto nla_put_failure;
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_FLASH_UPDATE_STATUS_TIMEOUT,
-			      params->timeout, DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_FLASH_UPDATE_STATUS_TIMEOUT,
+			       params->timeout))
 		goto nla_put_failure;
 
 out:
diff --git a/net/devlink/dpipe.c b/net/devlink/dpipe.c
index 55009b377447..e55701b007f0 100644
--- a/net/devlink/dpipe.c
+++ b/net/devlink/dpipe.c
@@ -165,18 +165,17 @@ static int devlink_dpipe_table_put(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	if (nla_put_string(skb, DEVLINK_ATTR_DPIPE_TABLE_NAME, table->name) ||
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_DPIPE_TABLE_SIZE, table_size,
-			      DEVLINK_ATTR_PAD))
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_DPIPE_TABLE_SIZE, table_size))
 		goto nla_put_failure;
 	if (nla_put_u8(skb, DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED,
 		       table->counters_enabled))
 		goto nla_put_failure;
 
 	if (table->resource_valid) {
-		if (nla_put_u64_64bit(skb, DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID,
-				      table->resource_id, DEVLINK_ATTR_PAD) ||
-		    nla_put_u64_64bit(skb, DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_UNITS,
-				      table->resource_units, DEVLINK_ATTR_PAD))
+		if (devlink_nl_put_u64(skb, DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_ID,
+				       table->resource_id) ||
+		    devlink_nl_put_u64(skb, DEVLINK_ATTR_DPIPE_TABLE_RESOURCE_UNITS,
+				       table->resource_units))
 			goto nla_put_failure;
 	}
 	if (devlink_dpipe_matches_put(table, skb))
@@ -403,12 +402,11 @@ static int devlink_dpipe_entry_put(struct sk_buff *skb,
 	if (!entry_attr)
 		return  -EMSGSIZE;
 
-	if (nla_put_u64_64bit(skb, DEVLINK_ATTR_DPIPE_ENTRY_INDEX, entry->index,
-			      DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(skb, DEVLINK_ATTR_DPIPE_ENTRY_INDEX, entry->index))
 		goto nla_put_failure;
 	if (entry->counter_valid)
-		if (nla_put_u64_64bit(skb, DEVLINK_ATTR_DPIPE_ENTRY_COUNTER,
-				      entry->counter, DEVLINK_ATTR_PAD))
+		if (devlink_nl_put_u64(skb, DEVLINK_ATTR_DPIPE_ENTRY_COUNTER,
+				       entry->counter))
 			goto nla_put_failure;
 
 	matches_attr = nla_nest_start_noflag(skb,
diff --git a/net/devlink/health.c b/net/devlink/health.c
index acb8c0e174bb..b8d3084e6fe0 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -287,29 +287,27 @@ devlink_nl_health_reporter_fill(struct sk_buff *msg,
 	if (nla_put_u8(msg, DEVLINK_ATTR_HEALTH_REPORTER_STATE,
 		       reporter->health_state))
 		goto reporter_nest_cancel;
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_HEALTH_REPORTER_ERR_COUNT,
-			      reporter->error_count, DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_ERR_COUNT,
+			       reporter->error_count))
 		goto reporter_nest_cancel;
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_HEALTH_REPORTER_RECOVER_COUNT,
-			      reporter->recovery_count, DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_RECOVER_COUNT,
+			       reporter->recovery_count))
 		goto reporter_nest_cancel;
 	if (reporter->ops->recover &&
-	    nla_put_u64_64bit(msg, DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD,
-			      reporter->graceful_period,
-			      DEVLINK_ATTR_PAD))
+	    devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD,
+			       reporter->graceful_period))
 		goto reporter_nest_cancel;
 	if (reporter->ops->recover &&
 	    nla_put_u8(msg, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER,
 		       reporter->auto_recover))
 		goto reporter_nest_cancel;
 	if (reporter->dump_fmsg &&
-	    nla_put_u64_64bit(msg, DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS,
-			      jiffies_to_msecs(reporter->dump_ts),
-			      DEVLINK_ATTR_PAD))
+	    devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS,
+			       jiffies_to_msecs(reporter->dump_ts)))
 		goto reporter_nest_cancel;
 	if (reporter->dump_fmsg &&
-	    nla_put_u64_64bit(msg, DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS_NS,
-			      reporter->dump_real_ts, DEVLINK_ATTR_PAD))
+	    devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS_NS,
+			       reporter->dump_real_ts))
 		goto reporter_nest_cancel;
 	if (reporter->ops->dump &&
 	    nla_put_u8(msg, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP,
@@ -963,8 +961,7 @@ devlink_fmsg_item_fill_data(struct devlink_fmsg_item *msg, struct sk_buff *skb)
 	case NLA_U32:
 		return nla_put_u32(skb, attrtype, *(u32 *)msg->value);
 	case NLA_U64:
-		return nla_put_u64_64bit(skb, attrtype, *(u64 *)msg->value,
-					 DEVLINK_ATTR_PAD);
+		return devlink_nl_put_u64(skb, attrtype, *(u64 *)msg->value);
 	case NLA_NUL_STRING:
 		return nla_put_string(skb, attrtype, (char *)&msg->value);
 	case NLA_BINARY:
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 7139e67e93ae..8828ffaf6cbc 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -108,12 +108,12 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 			goto nla_put_failure;
 	}
 
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_RATE_TX_SHARE,
-			      devlink_rate->tx_share, DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_RATE_TX_SHARE,
+			       devlink_rate->tx_share))
 		goto nla_put_failure;
 
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_RATE_TX_MAX,
-			      devlink_rate->tx_max, DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_RATE_TX_MAX,
+			       devlink_rate->tx_max))
 		goto nla_put_failure;
 
 	if (nla_put_u32(msg, DEVLINK_ATTR_RATE_TX_PRIORITY,
diff --git a/net/devlink/region.c b/net/devlink/region.c
index 7319127c5913..0a75a2fbd4d7 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -145,9 +145,7 @@ static int devlink_nl_region_fill(struct sk_buff *msg, struct devlink *devlink,
 	if (err)
 		goto nla_put_failure;
 
-	err = nla_put_u64_64bit(msg, DEVLINK_ATTR_REGION_SIZE,
-				region->size,
-				DEVLINK_ATTR_PAD);
+	err = devlink_nl_put_u64(msg, DEVLINK_ATTR_REGION_SIZE, region->size);
 	if (err)
 		goto nla_put_failure;
 
@@ -210,8 +208,8 @@ devlink_nl_region_notify_build(struct devlink_region *region,
 		if (err)
 			goto out_cancel_msg;
 	} else {
-		err = nla_put_u64_64bit(msg, DEVLINK_ATTR_REGION_SIZE,
-					region->size, DEVLINK_ATTR_PAD);
+		err = devlink_nl_put_u64(msg, DEVLINK_ATTR_REGION_SIZE,
+					 region->size);
 		if (err)
 			goto out_cancel_msg;
 	}
@@ -773,8 +771,7 @@ static int devlink_nl_cmd_region_read_chunk_fill(struct sk_buff *msg,
 	if (err)
 		goto nla_put_failure;
 
-	err = nla_put_u64_64bit(msg, DEVLINK_ATTR_REGION_CHUNK_ADDR, addr,
-				DEVLINK_ATTR_PAD);
+	err = devlink_nl_put_u64(msg, DEVLINK_ATTR_REGION_CHUNK_ADDR, addr);
 	if (err)
 		goto nla_put_failure;
 
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 594c8aeb3bfa..5ce05e94f484 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -141,12 +141,12 @@ devlink_resource_size_params_put(struct devlink_resource *resource,
 	struct devlink_resource_size_params *size_params;
 
 	size_params = &resource->size_params;
-	if (nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_GRAN,
-			      size_params->size_granularity, DEVLINK_ATTR_PAD) ||
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_MAX,
-			      size_params->size_max, DEVLINK_ATTR_PAD) ||
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_MIN,
-			      size_params->size_min, DEVLINK_ATTR_PAD) ||
+	if (devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_GRAN,
+			       size_params->size_granularity) ||
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_MAX,
+			       size_params->size_max) ||
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_MIN,
+			       size_params->size_min) ||
 	    nla_put_u8(skb, DEVLINK_ATTR_RESOURCE_UNIT, size_params->unit))
 		return -EMSGSIZE;
 	return 0;
@@ -157,9 +157,8 @@ static int devlink_resource_occ_put(struct devlink_resource *resource,
 {
 	if (!resource->occ_get)
 		return 0;
-	return nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_OCC,
-				 resource->occ_get(resource->occ_get_priv),
-				 DEVLINK_ATTR_PAD);
+	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
+				  resource->occ_get(resource->occ_get_priv));
 }
 
 static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
@@ -174,14 +173,12 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	if (nla_put_string(skb, DEVLINK_ATTR_RESOURCE_NAME, resource->name) ||
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size,
-			      DEVLINK_ATTR_PAD) ||
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_ID, resource->id,
-			      DEVLINK_ATTR_PAD))
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource->size) ||
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_ID, resource->id))
 		goto nla_put_failure;
 	if (resource->size != resource->size_new &&
-	    nla_put_u64_64bit(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
-			      resource->size_new, DEVLINK_ATTR_PAD))
+	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
+			       resource->size_new))
 		goto nla_put_failure;
 	if (devlink_resource_occ_put(resource, skb))
 		goto nla_put_failure;
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 5d18c7424df1..f36087f90db5 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -189,14 +189,12 @@ devlink_trap_group_stats_put(struct sk_buff *msg,
 	if (!attr)
 		return -EMSGSIZE;
 
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_PACKETS,
-			      u64_stats_read(&stats.rx_packets),
-			      DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_STATS_RX_PACKETS,
+			       u64_stats_read(&stats.rx_packets)))
 		goto nla_put_failure;
 
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_BYTES,
-			      u64_stats_read(&stats.rx_bytes),
-			      DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_STATS_RX_BYTES,
+			       u64_stats_read(&stats.rx_bytes)))
 		goto nla_put_failure;
 
 	nla_nest_end(msg, attr);
@@ -231,18 +229,15 @@ static int devlink_trap_stats_put(struct sk_buff *msg, struct devlink *devlink,
 		return -EMSGSIZE;
 
 	if (devlink->ops->trap_drop_counter_get &&
-	    nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_DROPPED, drops,
-			      DEVLINK_ATTR_PAD))
+	    devlink_nl_put_u64(msg, DEVLINK_ATTR_STATS_RX_DROPPED, drops))
 		goto nla_put_failure;
 
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_PACKETS,
-			      u64_stats_read(&stats.rx_packets),
-			      DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_STATS_RX_PACKETS,
+			       u64_stats_read(&stats.rx_packets)))
 		goto nla_put_failure;
 
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_BYTES,
-			      u64_stats_read(&stats.rx_bytes),
-			      DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_STATS_RX_BYTES,
+			       u64_stats_read(&stats.rx_bytes)))
 		goto nla_put_failure;
 
 	nla_nest_end(msg, attr);
@@ -750,8 +745,7 @@ devlink_trap_policer_stats_put(struct sk_buff *msg, struct devlink *devlink,
 	if (!attr)
 		return -EMSGSIZE;
 
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_DROPPED, drops,
-			      DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_STATS_RX_DROPPED, drops))
 		goto nla_put_failure;
 
 	nla_nest_end(msg, attr);
@@ -783,12 +777,12 @@ devlink_nl_trap_policer_fill(struct sk_buff *msg, struct devlink *devlink,
 			policer_item->policer->id))
 		goto nla_put_failure;
 
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_TRAP_POLICER_RATE,
-			      policer_item->rate, DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_TRAP_POLICER_RATE,
+			       policer_item->rate))
 		goto nla_put_failure;
 
-	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_TRAP_POLICER_BURST,
-			      policer_item->burst, DEVLINK_ATTR_PAD))
+	if (devlink_nl_put_u64(msg, DEVLINK_ATTR_TRAP_POLICER_BURST,
+			       policer_item->burst))
 		goto nla_put_failure;
 
 	err = devlink_trap_policer_stats_put(msg, devlink,
-- 
2.46.0


