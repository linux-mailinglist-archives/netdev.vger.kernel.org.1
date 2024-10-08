Return-Path: <netdev+bounces-133364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4475F995BBF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0989D28700A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F832219488;
	Tue,  8 Oct 2024 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkoceXOM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5088218D7F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430495; cv=none; b=Ie2M9/7EnvNbhXFqzKQU0DWXUTF7xqBHKIfFRIt7dvUyieMl6t/rYcuI85p0R3DBEctVpV2N/0tMSbOUC9pneXbm2vfpWbEQJ4OTJHkbH/yX2Q2wokTUiJB2HDFirAcsjK41vHHLw9xyY94zd/jo0/v721nTt7UFyO/Wbj6kz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430495; c=relaxed/simple;
	bh=CrMi/DF58SKgUmwVAdiiPsSpTmCLpg9eWJNb6CY8EhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxAM20xI5HSr4L6GFhNj88U8dSzTfOjmYG77qRm4kP2cYjLpmcxPDtNmBdv6o/e1+PNCMFOU+AeUeZ7HNZRJalLeBZOlf5fYSpImoNNzQfXUbpzg2zv3QGJcphSGlmtY1ymdZjBg/5oX3WihAxh1SHX0DDPC58rPWs34BneiQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkoceXOM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430494; x=1759966494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CrMi/DF58SKgUmwVAdiiPsSpTmCLpg9eWJNb6CY8EhU=;
  b=KkoceXOM3FsDaRjl0TCYe8tL75IFN+HuHVwcwvEguOq1tHKvQ347hH2X
   wTfMLKwBk5ovBZlc6V1Xs7KOibM4O8f05KRpgWCUY0Ket42B0NOnaQg21
   pYMOoSifjKiUZ/2PL7gRg7ubZegYCMAlVBPQeuqeI3rUNigjyISJI74EP
   zZM/mbWltzOpqca31WnAw8llY9LCd4y0vFxrVFxORVIE1H1VcRMplTy0N
   CVAZl9TpUGFATGrvGtcIQHaWGbajEF/Lba6wk7XG84VZAK5RYOFzt1AYe
   +1JIC7r1JiRtWyxIrd2fb16uvI9HMXOwZdFs0/KnS0YIdxNz4sdl6my2w
   A==;
X-CSE-ConnectionGUID: P8TAQ0uZQROrod1lKTwxYg==
X-CSE-MsgGUID: ZBv+MV88TtaTliuf/4LwPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779906"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779906"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:50 -0700
X-CSE-ConnectionGUID: CQ+Lvv7SSKeLAz65OW+Zjw==
X-CSE-MsgGUID: PuQFaYQfRhiDne5LkDTFlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794200"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	anthony.l.nguyen@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next 08/12] iavf: Remove unused declarations
Date: Tue,  8 Oct 2024 16:34:34 -0700
Message-ID: <20241008233441.928802-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

There is no caller and implementation in tree.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h           | 10 ----------
 drivers/net/ethernet/intel/iavf/iavf_prototype.h |  3 ---
 2 files changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 48cd1d06761c..95b1d8f62304 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -529,22 +529,16 @@ static inline void iavf_change_state(struct iavf_adapter *adapter,
 		iavf_state_str(adapter->state));
 }
 
-int iavf_up(struct iavf_adapter *adapter);
 void iavf_down(struct iavf_adapter *adapter);
 int iavf_process_config(struct iavf_adapter *adapter);
 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
 void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags);
 void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64 flags);
 void iavf_schedule_finish_config(struct iavf_adapter *adapter);
-void iavf_reset(struct iavf_adapter *adapter);
 void iavf_set_ethtool_ops(struct net_device *netdev);
-void iavf_update_stats(struct iavf_adapter *adapter);
 void iavf_free_all_tx_resources(struct iavf_adapter *adapter);
 void iavf_free_all_rx_resources(struct iavf_adapter *adapter);
 
-void iavf_napi_add_all(struct iavf_adapter *adapter);
-void iavf_napi_del_all(struct iavf_adapter *adapter);
-
 int iavf_send_api_ver(struct iavf_adapter *adapter);
 int iavf_verify_api_ver(struct iavf_adapter *adapter);
 int iavf_send_vf_config_msg(struct iavf_adapter *adapter);
@@ -555,11 +549,9 @@ void iavf_set_queue_vlan_tag_loc(struct iavf_adapter *adapter);
 u16 iavf_get_num_vlans_added(struct iavf_adapter *adapter);
 void iavf_irq_enable(struct iavf_adapter *adapter, bool flush);
 void iavf_configure_queues(struct iavf_adapter *adapter);
-void iavf_deconfigure_queues(struct iavf_adapter *adapter);
 void iavf_enable_queues(struct iavf_adapter *adapter);
 void iavf_disable_queues(struct iavf_adapter *adapter);
 void iavf_map_queues(struct iavf_adapter *adapter);
-int iavf_request_queues(struct iavf_adapter *adapter, int num);
 void iavf_add_ether_addrs(struct iavf_adapter *adapter);
 void iavf_del_ether_addrs(struct iavf_adapter *adapter);
 void iavf_add_vlans(struct iavf_adapter *adapter);
@@ -579,8 +571,6 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			      enum virtchnl_ops v_opcode,
 			      enum iavf_status v_retval, u8 *msg, u16 msglen);
 int iavf_config_rss(struct iavf_adapter *adapter);
-int iavf_lan_add_device(struct iavf_adapter *adapter);
-int iavf_lan_del_device(struct iavf_adapter *adapter);
 void iavf_enable_channels(struct iavf_adapter *adapter);
 void iavf_disable_channels(struct iavf_adapter *adapter);
 void iavf_add_cloud_filter(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index 48c3901381b4..cac9d1a35a52 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -18,7 +18,6 @@
 /* adminq functions */
 enum iavf_status iavf_init_adminq(struct iavf_hw *hw);
 enum iavf_status iavf_shutdown_adminq(struct iavf_hw *hw);
-void iavf_adminq_init_ring_data(struct iavf_hw *hw);
 enum iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
 					struct iavf_arq_event_info *e,
 					u16 *events_pending);
@@ -33,8 +32,6 @@ bool iavf_asq_done(struct iavf_hw *hw);
 void iavf_debug_aq(struct iavf_hw *hw, enum iavf_debug_mask mask,
 		   void *desc, void *buffer, u16 buf_len);
 
-void iavf_idle_aq(struct iavf_hw *hw);
-void iavf_resume_aq(struct iavf_hw *hw);
 bool iavf_check_asq_alive(struct iavf_hw *hw);
 enum iavf_status iavf_aq_queue_shutdown(struct iavf_hw *hw, bool unloading);
 const char *iavf_aq_str(struct iavf_hw *hw, enum iavf_admin_queue_err aq_err);
-- 
2.42.0


