Return-Path: <netdev+bounces-107823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39D491C731
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4931F26765
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547B13D2A2;
	Fri, 28 Jun 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlg/3FPq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE813A24B
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605627; cv=none; b=WOzPcPOi+x/LdTrUoo1qwTmmnnsfmpbnahrdpWcfupIMz1GtwLkU42PK45/7wjIbjfdxRViFojnhgnGV2KZpIQIo7kFbMUuqrgfVKwWukBrR4byI4K1oEJlf2alTTBREv+qbZz5F5tqbdNGmENhtVY0oI+kNnZ7WlqBY+gcYOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605627; c=relaxed/simple;
	bh=jeU274rfYGSdJfTv19ueZQSsyitwBisqpRyfnwB1Jkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvzs8XOVKyTxtzKCLGsZnEDmbORWKuXDCy2MhRkIVWmilmqEq6xLC2Ls73IFhgy0TSXl72cgwnZ53jc76Qb5bNEJcoWtjgtfssCuo7pddeYt1WBVXfnsBInYMWxRwKGKULmN3nCoLzFLgMFsT56TKOvu+FDEKdezKf4e0ZIx+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlg/3FPq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605626; x=1751141626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jeU274rfYGSdJfTv19ueZQSsyitwBisqpRyfnwB1Jkg=;
  b=hlg/3FPquVxNAtCLWHmUgimTQ/tSqmpEH6a8q3tEc7/5bed5TnjNbOXA
   iJSSB7Rc+7gF0W4HyUdaox3RF8Kurcau1mW2kCI7ZRNYnFOD2VzqK/S4d
   qzCJikoZZYL4O4K0p6UnlMjUgCVBO8CLORM/2qkhh9spBpvpEfclFr3rB
   OR7eZWnHTVdys3GvyLrv1BmSf8wzyMK4CLOXgBEA5aeNp0JsEYpzw3aWQ
   1t91YYQbyJu4YZ8dzIhcJl4CGRpYUKpG3veNqX1uGIwXqBtWOdsyuHyqN
   qumN0HRsj1poWTDmcENYe5ZsciQn+K5vj2iN0dJ+UizhLC69g3eX2I7pI
   A==;
X-CSE-ConnectionGUID: PpjuoOK3TDGQMsKsu4Tgew==
X-CSE-MsgGUID: qyVrCu9kTm6jZ9RmzycjRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20674926"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="20674926"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:42 -0700
X-CSE-ConnectionGUID: w8YhLI1TSH63tuv7qFPi2g==
X-CSE-MsgGUID: 2Etu5c99Sj2zDwzEdlCcxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49735535"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Jun 2024 13:13:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Piotr Gardocki <piotrx.gardocki@intel.com>,
	anthony.l.nguyen@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 5/6] ice: Distinguish driver reset and removal for AQ shutdown
Date: Fri, 28 Jun 2024 13:13:23 -0700
Message-ID: <20240628201328.2738672-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
References: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Gardocki <piotrx.gardocki@intel.com>

Admin queue command for shutdown AQ contains a flag to indicate driver
unload. However, the flag is always set in the driver, even for resets. It
can cause the firmware to consider driver as unloaded once the PF reset is
triggered on all ports of device, which could lead to unexpected results.

Add an additional function parameter to functions that shutdown AQ,
indicating whether the driver is actually unloading.

Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.h   |  2 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c | 19 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 +++---
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 86cc1df469dd..40dc735dc25c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -23,7 +23,7 @@ int ice_check_reset(struct ice_hw *hw);
 int ice_reset(struct ice_hw *hw, enum ice_reset_req req);
 int ice_create_all_ctrlq(struct ice_hw *hw);
 int ice_init_all_ctrlq(struct ice_hw *hw);
-void ice_shutdown_all_ctrlq(struct ice_hw *hw);
+void ice_shutdown_all_ctrlq(struct ice_hw *hw, bool unloading);
 void ice_destroy_all_ctrlq(struct ice_hw *hw);
 int
 ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index ca80b34f2f8a..ffaa6511c455 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -687,10 +687,12 @@ struct ice_ctl_q_info *ice_get_sbq(struct ice_hw *hw)
  * ice_shutdown_ctrlq - shutdown routine for any control queue
  * @hw: pointer to the hardware structure
  * @q_type: specific Control queue type
+ * @unloading: is the driver unloading itself
  *
  * NOTE: this function does not destroy the control queue locks.
  */
-static void ice_shutdown_ctrlq(struct ice_hw *hw, enum ice_ctl_q q_type)
+static void ice_shutdown_ctrlq(struct ice_hw *hw, enum ice_ctl_q q_type,
+			       bool unloading)
 {
 	struct ice_ctl_q_info *cq;
 
@@ -698,7 +700,7 @@ static void ice_shutdown_ctrlq(struct ice_hw *hw, enum ice_ctl_q q_type)
 	case ICE_CTL_Q_ADMIN:
 		cq = &hw->adminq;
 		if (ice_check_sq_alive(hw, cq))
-			ice_aq_q_shutdown(hw, true);
+			ice_aq_q_shutdown(hw, unloading);
 		break;
 	case ICE_CTL_Q_SB:
 		cq = &hw->sbq;
@@ -717,20 +719,21 @@ static void ice_shutdown_ctrlq(struct ice_hw *hw, enum ice_ctl_q q_type)
 /**
  * ice_shutdown_all_ctrlq - shutdown routine for all control queues
  * @hw: pointer to the hardware structure
+ * @unloading: is the driver unloading itself
  *
  * NOTE: this function does not destroy the control queue locks. The driver
  * may call this at runtime to shutdown and later restart control queues, such
  * as in response to a reset event.
  */
-void ice_shutdown_all_ctrlq(struct ice_hw *hw)
+void ice_shutdown_all_ctrlq(struct ice_hw *hw, bool unloading)
 {
 	/* Shutdown FW admin queue */
-	ice_shutdown_ctrlq(hw, ICE_CTL_Q_ADMIN);
+	ice_shutdown_ctrlq(hw, ICE_CTL_Q_ADMIN, unloading);
 	/* Shutdown PHY Sideband */
 	if (ice_is_sbq_supported(hw))
-		ice_shutdown_ctrlq(hw, ICE_CTL_Q_SB);
+		ice_shutdown_ctrlq(hw, ICE_CTL_Q_SB, unloading);
 	/* Shutdown PF-VF Mailbox */
-	ice_shutdown_ctrlq(hw, ICE_CTL_Q_MAILBOX);
+	ice_shutdown_ctrlq(hw, ICE_CTL_Q_MAILBOX, unloading);
 }
 
 /**
@@ -762,7 +765,7 @@ int ice_init_all_ctrlq(struct ice_hw *hw)
 			break;
 
 		ice_debug(hw, ICE_DBG_AQ_MSG, "Retry Admin Queue init due to FW critical error\n");
-		ice_shutdown_ctrlq(hw, ICE_CTL_Q_ADMIN);
+		ice_shutdown_ctrlq(hw, ICE_CTL_Q_ADMIN, true);
 		msleep(ICE_CTL_Q_ADMIN_INIT_MSEC);
 	} while (retry++ < ICE_CTL_Q_ADMIN_INIT_TIMEOUT);
 
@@ -843,7 +846,7 @@ static void ice_destroy_ctrlq_locks(struct ice_ctl_q_info *cq)
 void ice_destroy_all_ctrlq(struct ice_hw *hw)
 {
 	/* shut down all the control queues first */
-	ice_shutdown_all_ctrlq(hw);
+	ice_shutdown_all_ctrlq(hw, true);
 
 	ice_destroy_ctrlq_locks(&hw->adminq);
 	if (ice_is_sbq_supported(hw))
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f4a39016a675..14ec4ebcd9af 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -623,7 +623,7 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (hw->port_info)
 		ice_sched_clear_port(hw->port_info);
 
-	ice_shutdown_all_ctrlq(hw);
+	ice_shutdown_all_ctrlq(hw, false);
 
 	set_bit(ICE_PREPARED_FOR_RESET, pf->state);
 }
@@ -5499,7 +5499,7 @@ static void ice_prepare_for_shutdown(struct ice_pf *pf)
 		if (pf->vsi[v])
 			pf->vsi[v]->vsi_num = 0;
 
-	ice_shutdown_all_ctrlq(hw);
+	ice_shutdown_all_ctrlq(hw, true);
 }
 
 /**
@@ -7759,7 +7759,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 err_sched_init_port:
 	ice_sched_cleanup_all(hw);
 err_init_ctrlq:
-	ice_shutdown_all_ctrlq(hw);
+	ice_shutdown_all_ctrlq(hw, false);
 	set_bit(ICE_RESET_FAILED, pf->state);
 clear_recovery:
 	/* set this bit in PF state to control service task scheduling */
-- 
2.41.0


