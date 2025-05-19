Return-Path: <netdev+bounces-191395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E2ABB618
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8228A188F52B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551062690FA;
	Mon, 19 May 2025 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge61jM1L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852312676D5;
	Mon, 19 May 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639267; cv=none; b=R1AyGSgkvziuLBkFig1EQHcBg97AcAouKbH6jqZj7Dl7568/xAI43eUbKDvkiCw2sB/wC2wzdz8Ded35ZlRpVpC41qN3eJnzb70UzjLfTAk0vpr2MsaLdtxtLu69aau43PdshZoLZAbayOn97GSF6wKLKlTXUWDiwmt6av696Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639267; c=relaxed/simple;
	bh=PXzwswM7zeCQGH43r5Hb+tLm48f6r20TC+9wRh21xZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nv2Dhjpq8q+WwQCATklKKLnPbleGHwion6OO4hVmIR0ZQqxnECjpzdwWIcAisqtA1L1uEF335D9wTykUjpySiH872iAVFBkiypConaZwr+uZLU85Fc3oiRROBbw6TTATE/yeLlpgUM+MGF/VpZ/NEHZN13pPGyvdZVeKRVtEpLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge61jM1L; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747639265; x=1779175265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PXzwswM7zeCQGH43r5Hb+tLm48f6r20TC+9wRh21xZc=;
  b=ge61jM1LyRskNvvBIRJtdmsZbeZ71kusX+e9au89w2CNgek2jrys2sDG
   6ESpN+rx1dMnBhjLPKGXSnsZQITB14q5crn7bD26fAMkG8sh5F3Ajmc1G
   kzuu8X5JuFIfkO6SPi+GejDqIwTNyhQwEXp69r1JZDlPneIQUK/kUPIKo
   E0BchKyhHs5XK3M20PJYNq7icgE7IItrRtcG3jngIZzazT003dX5+3xco
   RJa3sGJgrobMjdkXNfTaRxPudH77RtPhHodrDpau9Wj1Sii/oGdXyFpIu
   7uXEkFZYQ2GQ2E6sWz6ydji8ihUfwGo0sW07leUWaKXfMiYkzbUkQoo9i
   A==;
X-CSE-ConnectionGUID: Iyy1sRelSRCGz3P8SMWpvg==
X-CSE-MsgGUID: 75lPGIUmSNOfkyJqo9lToQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="72030778"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="72030778"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:21:05 -0700
X-CSE-ConnectionGUID: mmpoC57BR9uND73U9O8tew==
X-CSE-MsgGUID: 2EcW9jtTSHC2bVPaerrckw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139798887"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa007.jf.intel.com with ESMTP; 19 May 2025 00:21:02 -0700
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v3 7/7] igc: add preemptible queue support in mqprio
Date: Mon, 19 May 2025 03:19:11 -0400
Message-Id: <20250519071911.2748406-8-faizal.abdul.rahim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
References: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

igc already supports enabling MAC Merge for FPE. This patch adds
support for preemptible queues in mqprio.

Tested preemption with mqprio by:
1. Enable FPE:
   ethtool --set-mm enp1s0 pmac-enabled on tx-enabled on verify-enabled on
2. Enable preemptible queue in mqprio:
   mqprio num_tc 4 map 0 1 2 3 0 0 0 0 0 0 0 0 0 0 0 0 \
   queues 1@0 1@1 1@2 1@3 \
   fp P P P E

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 ++-------
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 9 +++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.h  | 1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index eb68a352840a..509f95651f25 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6764,6 +6764,7 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 
 	if (!mqprio->qopt.num_tc) {
 		adapter->strict_priority_enable = false;
+		igc_fpe_clear_preempt_queue(adapter);
 		netdev_reset_tc(adapter->netdev);
 		goto apply;
 	}
@@ -6791,13 +6792,6 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 		return -EOPNOTSUPP;
 	}
 
-	/* Preemption is not supported yet. */
-	if (mqprio->preemptible_tcs) {
-		NL_SET_ERR_MSG_MOD(mqprio->extack,
-				   "Preemption is not supported yet");
-		return -EOPNOTSUPP;
-	}
-
 	igc_save_mqprio_params(adapter, mqprio->qopt.num_tc,
 			       mqprio->qopt.offset);
 
@@ -6817,6 +6811,7 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 		adapter->queue_per_tc[i] = i;
 
 	mqprio->qopt.hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+	igc_fpe_save_preempt_queue(adapter, mqprio);
 
 apply:
 	return igc_tsn_offload_apply(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 811856d66571..b23b9ca451a7 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -160,6 +160,15 @@ void igc_fpe_init(struct igc_adapter *adapter)
 	ethtool_mmsv_init(&adapter->fpe.mmsv, adapter->netdev, &igc_mmsv_ops);
 }
 
+void igc_fpe_clear_preempt_queue(struct igc_adapter *adapter)
+{
+	for (int i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		tx_ring->preemptible = false;
+	}
+}
+
 static u32 igc_fpe_map_preempt_tc_to_queue(const struct igc_adapter *adapter,
 					   unsigned long preemptible_tcs)
 {
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index f2e8bfef4871..a95b893459d7 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -17,6 +17,7 @@ enum igc_txd_popts_type {
 DECLARE_STATIC_KEY_FALSE(igc_fpe_enabled);
 
 void igc_fpe_init(struct igc_adapter *adapter);
+void igc_fpe_clear_preempt_queue(struct igc_adapter *adapter);
 void igc_fpe_save_preempt_queue(struct igc_adapter *adapter,
 				const struct tc_mqprio_qopt_offload *mqprio);
 u32 igc_fpe_get_supported_frag_size(u32 frag_size);
-- 
2.34.1


