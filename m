Return-Path: <netdev+bounces-116974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C0394C3C4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B731F228A6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077F1917EE;
	Thu,  8 Aug 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMirMUkM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812B191F9B
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138277; cv=none; b=nGk9CTdi8jJFo80msCYsUQS5gPWdnYAA6yyNhlff/NwdK8sZsRsApkfd1ENKFkOA+mi3RT2k5+6GJvid/dW8p30YtCxgRakAm7nSwtDxYNMqJv9Q9Wi2cq14o/FJJsESfNgOnk+FswKdIxgFbzAqRSor9DpgxNEO+PG23yKqoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138277; c=relaxed/simple;
	bh=WfNtwD6keXKCRe4ITugs3W/573UVYZ5rks1aEYnG6hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaz0TGuuhSJw5DovaMbdWjWhaMgEtfJmZ+kFHkUlHK5APJDJ00AaQ5cqOjkz4rHcsr+I9Sl06zgQAXSJPx7E+x0uH7Tr6gt2ojZC3Fpvi2gmNmiNYzh4eYgUnL1fQm5bP9oZpfj6gtdAcTmWnedMFpc3HkmlAyXMHju9COAyaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMirMUkM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723138277; x=1754674277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WfNtwD6keXKCRe4ITugs3W/573UVYZ5rks1aEYnG6hA=;
  b=YMirMUkMRwn4TG3LoBBdQiE7LAs2c3BbFMavAAg+M+q+KJympERqhjz2
   ktTiQA2RK3VK7it5fnnNn6uGvXJ318hqZ7n2u++avxo6JAQsCRvS6q9Rl
   mnNCf5Vtt1N0kEgDsM7tfe+sS2RJfsGGuUbOCo5PI3fFeopUkA0QRwgrn
   VHLc7l+RbEal2rWCOsf9ARUkXJ2YpPw1eZ3W6GOejheN87Sn3dOefO5Yd
   aiwlUNvPmh9ut+I2QDBmeQ6Z7JZR5xtyXmte9StFf/DZj82+jrQbB6q6F
   TuqczJ44PMHnLdiiOQdIJGQa/AiAc49D7Nh7qOYtTtVAudU9RQyftviVl
   A==;
X-CSE-ConnectionGUID: OUY8a8zgQeaHlz19ZzhOhw==
X-CSE-MsgGUID: u4CmOuK+TAuacvP/POFSmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32675449"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="32675449"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 10:31:14 -0700
X-CSE-ConnectionGUID: xyE77jFZR1KXvCwUOLewPA==
X-CSE-MsgGUID: 8yBC5FH6SfaVvPAT/AP14w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="61682467"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 10:31:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v3 10/15] ice: don't set target VSI for subfunction
Date: Thu,  8 Aug 2024 10:30:56 -0700
Message-ID: <20240808173104.385094-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Add check for subfunction before setting target VSI. It is needed for PF
in switchdev mode but not for subfunction (even in switchdev mode).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8d25b6981269..d327a397f670 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2407,7 +2407,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 					ICE_TXD_CTX_QW1_CMD_S);
 
 	ice_tstamp(tx_ring, skb, first, &offload);
-	if (ice_is_switchdev_running(vsi->back))
+	if (ice_is_switchdev_running(vsi->back) && vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
-- 
2.42.0


