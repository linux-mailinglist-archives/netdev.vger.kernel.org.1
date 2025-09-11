Return-Path: <netdev+bounces-222314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B33B53D74
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71835A2BAF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B402DE6EF;
	Thu, 11 Sep 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQob0UaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE61DA55
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624742; cv=none; b=M4QFojH0IczinT61r2zCxlYy8pEmxqEYyLFq3r0swsATB6uptjHF9PeN7jshO65iaUrP9lGy4s++tCznWG0ctFoucRA9BIse4Ok1rLOvtA3S3w+ixPPXC7bPWj5yJ1u1yaOJTw2lN9k6IlsA312MTLyuVD73zIPmd3h24z9i068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624742; c=relaxed/simple;
	bh=U+2v1LOM67kWJz3YEtUUrZ2c5DZomC6gyAm0DuzETRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N88xJZdAgpdQO7ufY82x1L4eW8XDDFdjcxiYAYnYBdt9uvHw5hkjpGI2reqkC6wpPJVVwQEG8mLBe1AUfC5yIu5iLyl44AQN7eVVun5ArZnUCvLeQwPDjgcVQVXL5Pedp5uxTleKf925eR/vz0/qSjhUXHtocIpKvCLMqh7ftJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQob0UaJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624741; x=1789160741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+2v1LOM67kWJz3YEtUUrZ2c5DZomC6gyAm0DuzETRk=;
  b=OQob0UaJ2DGGc6VlOc6T4+uzDrZxfWz5luct2veLlFHVO6wc5xATpw7H
   NscFlPASSxewSxmWJ3HNquU7JpOeWagDOh14P6QOeQmYJ05kblb+qk/Yo
   Fwpsuy9HBF25fi78P1klqGGrN+yrxr0Sr+J+P/WokaAj/4HrYqbv+L4Ok
   NLb4Kojcj8ymOkOeRo865RYZM+M/qvXxbBa12+xiLbg6pfnEYg9+71iCV
   odSxrdigjLicYdub2l4+PdcjC4/3bWKW9BONx0MKw58L3r/SQpKOXYFwB
   jidMZM/t9byeN8QdC5x2EPUaczwO6kHCP7/uOhrUafqfX83ajNAIB64Sp
   w==;
X-CSE-ConnectionGUID: BPazLUmTRM6cusgAJM9ZfQ==
X-CSE-MsgGUID: 4w6PtyEaSR6xc0/09O8Xaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558860"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558860"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:38 -0700
X-CSE-ConnectionGUID: sbz77mIgTs2QE/Euf+hrtA==
X-CSE-MsgGUID: EdXUgHb0SQuRaUDnLih7oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583340"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 03/15] ice: drop ice_pf_fwlog_update_module()
Date: Thu, 11 Sep 2025 14:05:02 -0700
Message-ID: <20250911210525.345110-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Any other access to fwlog_cfg isn't done through a function. Follow
scheme that is used to access other fwlog_cfg elements from debugfs and
write to the log_level directly.

ice_pf_fwlog_update_module() is called only twice (from one function).
Remove it.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 -
 drivers/net/ethernet/intel/ice/ice_debugfs.c |  5 +++--
 drivers/net/ethernet/intel/ice/ice_main.c    | 13 -------------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index e952d67388bf..a6803b344540 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -912,7 +912,6 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf);
 void ice_debugfs_pf_deinit(struct ice_pf *pf);
 void ice_debugfs_init(void);
 void ice_debugfs_exit(void);
-void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
 
 bool netif_is_ice(const struct net_device *dev);
 int ice_vsi_setup_tx_rings(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index cb71eca6a85b..170050548e74 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -164,6 +164,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	struct ice_pf *pf = file_inode(filp)->i_private;
 	struct dentry *dentry = file_dentry(filp);
 	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
 	char user_val[16], *cmd_buf;
 	int module, log_level, cnt;
 
@@ -192,7 +193,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	}
 
 	if (module != ICE_AQC_FW_LOG_ID_MAX) {
-		ice_pf_fwlog_update_module(pf, log_level, module);
+		hw->fwlog_cfg.module_entries[module].log_level = log_level;
 	} else {
 		/* the module 'all' is a shortcut so that we can set
 		 * all of the modules to the same level quickly
@@ -200,7 +201,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 		int i;
 
 		for (i = 0; i < ICE_AQC_FW_LOG_ID_MAX; i++)
-			ice_pf_fwlog_update_module(pf, log_level, i);
+			hw->fwlog_cfg.module_entries[i].log_level = log_level;
 	}
 
 	return count;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dcb8e7520471..47e2fab3432e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4628,19 +4628,6 @@ static void ice_print_wake_reason(struct ice_pf *pf)
 	dev_info(ice_pf_to_dev(pf), "Wake reason: %s", wake_str);
 }
 
-/**
- * ice_pf_fwlog_update_module - update 1 module
- * @pf: pointer to the PF struct
- * @log_level: log_level to use for the @module
- * @module: module to update
- */
-void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
-{
-	struct ice_hw *hw = &pf->hw;
-
-	hw->fwlog_cfg.module_entries[module].log_level = log_level;
-}
-
 /**
  * ice_register_netdev - register netdev
  * @vsi: pointer to the VSI struct
-- 
2.47.1


