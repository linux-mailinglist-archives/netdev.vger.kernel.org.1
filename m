Return-Path: <netdev+bounces-258239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDDZD/ROjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:42:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A99122D59
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFBFE3003608
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39E357715;
	Wed, 11 Feb 2026 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUqQm8tu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB263557EE
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802929; cv=none; b=D5Qpn8jJwc25OCOuAJRVH118tkbfoHJigUoxDxxbg0nAubgSHaQYin0mrAxkQQbnLlMr1aQXAFXusl+31IqGcrLJ61wWJ5fdreIYOQYJ3PAuxj/5FLwzqX0sZWXKEhycmqXfeRvdnayk822CHt2PWOeluG7/X1ttBVa2iLZRVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802929; c=relaxed/simple;
	bh=APntsk4MTWEO9YuK7mDQRF5/+R2iKfmtOW+Sf2X1qt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSqpXo/RqD55JhJhRgRicmD4kspLuM/yXOPTI1oBGDG9zbXyb3+OerA6+ojqOxtJpMwStcfWhWjsK+JH4gT1Oxbci/E4PEZejaEAYRyvwF9PrRmtbKR9oSYn0vbx/zN3sZJiRsVh12VfXLjm5uGDfj6hnzEw0+0RUAszdpxew+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUqQm8tu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770802928; x=1802338928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=APntsk4MTWEO9YuK7mDQRF5/+R2iKfmtOW+Sf2X1qt4=;
  b=DUqQm8tu8QWZWjWjtjEZn4EqVA0IhhUNmZqu5SJPeQWm72pr2h1N/Jva
   9dX+km2LLM5QTx9yZMqVyBlROU73mJIYbk9BINHL9SziFObL3gnJ4099z
   pZFUATZoPF8nj1bPVXgnSlYtKh2Bj3bLFXylv9od645k/lmE5to3c6QN4
   +iw8ze8PeDqt1mAU9cwIlj2SaZqdwqA9slIgdMgWv+Eis7fEpWaHsoCCF
   Venp2DNdoWxTQGDWo+kOP1k4g6Cp7RGcci7mYzxetAEOrMkCC3SdIsRzY
   S9OinJFJwEimvfT4jNOFG7TyIPPY2iiAQaNSDtxNVb/S1KfAbhDateCOA
   w==;
X-CSE-ConnectionGUID: h/F88wbbQMW++PBOvbKmsA==
X-CSE-MsgGUID: GYOxbUeSTFOI7E2qAuZCJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71988514"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71988514"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 01:42:08 -0800
X-CSE-ConnectionGUID: uKKN/ziCREmnXY7XgyPUWA==
X-CSE-MsgGUID: 2YM07DmfTvmIWwAzO3RPxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216361856"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa003.jf.intel.com with ESMTP; 11 Feb 2026 01:42:06 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v1] libie: prevent memleak in fwlog code
Date: Wed, 11 Feb 2026 10:10:08 +0100
Message-ID: <20260211091008.236185-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258239-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1A99122D59
X-Rspamd-Action: no action

All cmd_buf buffers are allocated and need to be freed after usage.
Add an error unwinding path that properly frees these buffers.

The memory leak  happens whenever fwlog configuration is changed. For
example:

$echo 256K > /sys/kernel/debug/ixgbe/0000\:32\:00.0/fwlog/log_size

Fixes: 96a9a9341cda ("ice: configure FW logging")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/libie/fwlog.c | 49 +++++++++++++++++-------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/libie/fwlog.c b/drivers/net/ethernet/intel/libie/fwlog.c
index f39cc11cb7c5..30a6bd095f18 100644
--- a/drivers/net/ethernet/intel/libie/fwlog.c
+++ b/drivers/net/ethernet/intel/libie/fwlog.c
@@ -433,17 +433,21 @@ libie_debugfs_module_write(struct file *filp, const char __user *buf,
 	module = libie_find_module_by_dentry(fwlog->debugfs_modules, dentry);
 	if (module < 0) {
 		dev_info(dev, "unknown module\n");
-		return -EINVAL;
+		count = -EINVAL;
+		goto free_cmd_buf;
 	}
 
 	cnt = sscanf(cmd_buf, "%s", user_val);
-	if (cnt != 1)
-		return -EINVAL;
+	if (cnt != 1) {
+		count = -EINVAL;
+		goto free_cmd_buf;
+	}
 
 	log_level = sysfs_match_string(libie_fwlog_level_string, user_val);
 	if (log_level < 0) {
 		dev_info(dev, "unknown log level '%s'\n", user_val);
-		return -EINVAL;
+		count = -EINVAL;
+		goto free_cmd_buf;
 	}
 
 	if (module != LIBIE_AQC_FW_LOG_ID_MAX) {
@@ -458,6 +462,9 @@ libie_debugfs_module_write(struct file *filp, const char __user *buf,
 			fwlog->cfg.module_entries[i].log_level = log_level;
 	}
 
+free_cmd_buf:
+	kfree(cmd_buf);
+
 	return count;
 }
 
@@ -515,23 +522,31 @@ libie_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
 		return PTR_ERR(cmd_buf);
 
 	ret = sscanf(cmd_buf, "%s", user_val);
-	if (ret != 1)
-		return -EINVAL;
+	if (ret != 1) {
+		count = -EINVAL;
+		goto free_cmd_buf;
+	}
 
 	ret = kstrtos16(user_val, 0, &nr_messages);
-	if (ret)
-		return ret;
+	if (ret) {
+		count = ret;
+		goto free_cmd_buf;
+	}
 
 	if (nr_messages < LIBIE_AQC_FW_LOG_MIN_RESOLUTION ||
 	    nr_messages > LIBIE_AQC_FW_LOG_MAX_RESOLUTION) {
 		dev_err(dev, "Invalid FW log number of messages %d, value must be between %d - %d\n",
 			nr_messages, LIBIE_AQC_FW_LOG_MIN_RESOLUTION,
 			LIBIE_AQC_FW_LOG_MAX_RESOLUTION);
-		return -EINVAL;
+		count = -EINVAL;
+		goto free_cmd_buf;
 	}
 
 	fwlog->cfg.log_resolution = nr_messages;
 
+free_cmd_buf:
+	kfree(cmd_buf);
+
 	return count;
 }
 
@@ -588,8 +603,10 @@ libie_debugfs_enable_write(struct file *filp, const char __user *buf,
 		return PTR_ERR(cmd_buf);
 
 	ret = sscanf(cmd_buf, "%s", user_val);
-	if (ret != 1)
-		return -EINVAL;
+	if (ret != 1) {
+		ret = -EINVAL;
+		goto free_cmd_buf;
+	}
 
 	ret = kstrtobool(user_val, &enable);
 	if (ret)
@@ -624,6 +641,8 @@ libie_debugfs_enable_write(struct file *filp, const char __user *buf,
 	 */
 	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
 		ret = -EIO;
+free_cmd_buf:
+	kfree(cmd_buf);
 
 	return ret;
 }
@@ -682,8 +701,10 @@ libie_debugfs_log_size_write(struct file *filp, const char __user *buf,
 		return PTR_ERR(cmd_buf);
 
 	ret = sscanf(cmd_buf, "%s", user_val);
-	if (ret != 1)
-		return -EINVAL;
+	if (ret != 1) {
+		ret = -EINVAL;
+		goto free_cmd_buf;
+	}
 
 	index = sysfs_match_string(libie_fwlog_log_size, user_val);
 	if (index < 0) {
@@ -712,6 +733,8 @@ libie_debugfs_log_size_write(struct file *filp, const char __user *buf,
 	 */
 	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
 		ret = -EIO;
+free_cmd_buf:
+	kfree(cmd_buf);
 
 	return ret;
 }
-- 
2.49.0


