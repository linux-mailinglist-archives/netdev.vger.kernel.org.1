Return-Path: <netdev+bounces-229288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2C7BDA216
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D81942406A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FEC2D7385;
	Tue, 14 Oct 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2xgHOri"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAE2701C4
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452954; cv=none; b=Pu8h6kq7v4oz7Tw0fRvymTnzH14++1YQWZbY8FsqYg8DpexXTeA6/mQSvF24nYe7OKwWWpdRcy2XI23Z9gBJTpjlI2BCZ9vXb0untDJzs3cyR7l3M2Un8/cydwDvjCSvstn22WtF4PaMBSpnC+mLZIv80HQG4PtrmzZtuX1evM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452954; c=relaxed/simple;
	bh=c6+EocnD4w4+0yuKJRBmHOTb815TgNmuf/l/5ZifKkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvAmsfMU7C51L+Sia59FPKbb+Bu51jIuh6bd55AoNWIAiQMvEXTAHbCr6Za+k/hEf5c+ye2m3xBAPjnmQkoDtO9lHnTrACuo7m18Etv6ZlnlbQQjHFNQOL8c0XacOyMw/Pzq1cRzbed7Eb+A+TgTpXZGdscuDHW2Yn6erE35ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2xgHOri; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760452952; x=1791988952;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c6+EocnD4w4+0yuKJRBmHOTb815TgNmuf/l/5ZifKkU=;
  b=I2xgHOriVu+nrFh8B2qj0k2aEIZ9HLbjluZmw40URZwy337TEI9/27Da
   VGL8ZIXtGnOj7i2P96qfnqNENsfg+Ml1cCAoiB0Zo3u7RaFPg1IInI48w
   u/croCkLHpHyNdUWoZuMih7IsAsbvEXRBkX6dXMaos43GiHK4ctLpBh9A
   JaQB7dRE8kaSuD+PBDp1eKaOkH1yaASXdnSV6glmbkv6Jpjv58Hvt4eeo
   CGJ9nJHZ9iXWBV8Zo8QogYhJl4DVB1SusxvLWefT4RDEEm4vM00zGxyIV
   quddAmWK1jj2coLtQRK160vyEskbe2xzrzh4Gg7vOWaJQY0cAcNs7Eon8
   g==;
X-CSE-ConnectionGUID: rXEgIXVCS4i4SI48TmD+bA==
X-CSE-MsgGUID: 241hUCmqRPe4BOHelfS1Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73955277"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="73955277"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:42:31 -0700
X-CSE-ConnectionGUID: wWn2mO3GSOijVT8WbioiBg==
X-CSE-MsgGUID: cOXsQb0VQJG4x/V+mZo4TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="212519417"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa002.jf.intel.com with ESMTP; 14 Oct 2025 07:42:30 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH iwl-net v1] ixgbe: guard fwlog code by CONFIG_DEBUG_FS
Date: Tue, 14 Oct 2025 16:11:10 +0200
Message-ID: <20251014141110.751104-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the ixgbe without CONFIG_DEBUG_FS leads to a build error. Fix
that by guarding fwlog code.

Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net/
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index c2f8189a0738..c5d76222df18 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3921,6 +3921,7 @@ static int ixgbe_read_pba_string_e610(struct ixgbe_hw *hw, u8 *pba_num,
 	return err;
 }
 
+#ifdef CONFIG_DEBUG_FS
 static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
 			    u16 size)
 {
@@ -3952,6 +3953,7 @@ void ixgbe_fwlog_deinit(struct ixgbe_hw *hw)
 
 	libie_fwlog_deinit(&hw->fwlog);
 }
+#endif /* CONFIG_DEBUG_FS */
 
 static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.init_hw			= ixgbe_init_hw_generic,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 11916b979d28..5317798b3263 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -96,7 +96,15 @@ int ixgbe_aci_update_nvm(struct ixgbe_hw *hw, u16 module_typeid,
 			 bool last_command, u8 command_flags);
 int ixgbe_nvm_write_activate(struct ixgbe_hw *hw, u16 cmd_flags,
 			     u8 *response_flags);
+#ifdef CONFIG_DEBUG_FS
 int ixgbe_fwlog_init(struct ixgbe_hw *hw);
 void ixgbe_fwlog_deinit(struct ixgbe_hw *hw);
+#else
+static inline int ixgbe_fwlog_init(struct ixgbe_hw *hw)
+{
+	return -EOPNOTSUPP;
+}
+static inline void ixgbe_fwlog_deinit(struct ixgbe_hw *hw) {}
+#endif /* CONFIG_DEBUG_FS */
 
 #endif /* _IXGBE_E610_H_ */
-- 
2.49.0


