Return-Path: <netdev+bounces-112770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B593B1C8
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D7B282446
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC628158DD0;
	Wed, 24 Jul 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="km1Wb3Ri"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36816158D94;
	Wed, 24 Jul 2024 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828447; cv=none; b=JqEhvID+WAtHPEhE/QowS32v6geh5XRxnKpSJAMuda5K9xqobox8ZfP2kC6iMlvn9K8lRDhjG9cpPMpM/sE5ALiqzsd6/CYZ6z/Yw1yr3s/hbgX1T7/QmTyjPc6NERhpXzcX2ks5r7NcV/cBKcj1o65DC4Hp9rN48iu56kggiXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828447; c=relaxed/simple;
	bh=QqPw9lZkqki/+Jsew9g6qEdJrYcGgAYT2cbcz7OrDZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krNy9xTv8uPhZ+sKmDum3iKbOl78v7noR9mld0RBJYhk1VV3YvoXpgmfmIyAdU66deiIdbVQc9U/NAC/jGH8+yQCXCfwQCoH9/+JA65xkhSACJtIydZ9SxLj9qagoGZ8D1Kx797AdMAPYi94OQyAQyu2n2SsrQHaR7TxBANxQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=km1Wb3Ri; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721828446; x=1753364446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QqPw9lZkqki/+Jsew9g6qEdJrYcGgAYT2cbcz7OrDZs=;
  b=km1Wb3RisRtp7VHyExPFnAURTQc6KAvirsJsNRv+MS2HJv80bYQg5gQF
   QtyJaP7J/kix+XcdolfjD3ZsDcurexnb3+EQzF6ZGtcyRnLhfti/0gapk
   VtunGP1rXnC1TYY9iDWlqo+faV1BkDgjJ8ohJwm2LCxshxyJ4FTvjfIr1
   cmMHzbGUsZL8IQwiqt65d44tqLE1YBK//yQimA4F3gOVt0kQKM26YqAjW
   x8WTZzVXPq1N3uBxzy161Y9mTuPjHD5DuseixqB1l23DrJESfdl+eWQSs
   kpjEaphTTmU2TPobY5npBCUHwQEsu0kvsPPXOkreU5Th2JtSKj7iEG29m
   Q==;
X-CSE-ConnectionGUID: dgqGhlbiQE+FjdophyIBUg==
X-CSE-MsgGUID: TVXLhAlXQzyZd5SpstN1yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19469372"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19469372"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 06:40:46 -0700
X-CSE-ConnectionGUID: E8S61nS+R7+WgnY26O6sDA==
X-CSE-MsgGUID: KILUOf/wQ6yWlDbiWCS/iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52615648"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 24 Jul 2024 06:40:43 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 1/3] idpf: fix memory leaks and crashes while performing a soft reset
Date: Wed, 24 Jul 2024 15:40:22 +0200
Message-ID: <20240724134024.2182959-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
References: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second tagged commit introduced a UAF, as it removed restoring
q_vector->vport pointers after reinitializating the structures.
This is due to that all queue allocation functions are performed here
with the new temporary vport structure and those functions rewrite
the backpointers to the vport. Then, this new struct is freed and
the pointers start leading to nowhere.

But generally speaking, the current logic is very fragile. It claims
to be more reliable when the system is low on memory, but in fact, it
consumes two times more memory as at the moment of running this
function, there are two vports allocated with their queues and vectors.
Moreover, it claims to prevent the driver from running into "bad state",
but in fact, any error during the rebuild leaves the old vport in the
partially allocated state.
Finally, if the interface is down when the function is called, it always
allocates a new queue set, but when the user decides to enable the
interface later on, vport_open() allocates them once again, IOW there's
a clear memory leak here.

Just don't allocate a new queue set when performing a reset, that solves
crashes and memory leaks. Readd the old queue number and reopen the
interface on rollback - that solves limbo states when the device is left
disabled and/or without HW queues enabled.

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Fixes: e4891e4687c8 ("idpf: split &idpf_queue into 4 strictly-typed queue structures")
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5dbf2b4ba1b0..10b884dd3475 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1335,9 +1335,8 @@ static void idpf_rx_init_buf_tail(struct idpf_vport *vport)
 /**
  * idpf_vport_open - Bring up a vport
  * @vport: vport to bring up
- * @alloc_res: allocate queue resources
  */
-static int idpf_vport_open(struct idpf_vport *vport, bool alloc_res)
+static int idpf_vport_open(struct idpf_vport *vport)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct idpf_adapter *adapter = vport->adapter;
@@ -1350,11 +1349,9 @@ static int idpf_vport_open(struct idpf_vport *vport, bool alloc_res)
 	/* we do not allow interface up just yet */
 	netif_carrier_off(vport->netdev);
 
-	if (alloc_res) {
-		err = idpf_vport_queues_alloc(vport);
-		if (err)
-			return err;
-	}
+	err = idpf_vport_queues_alloc(vport);
+	if (err)
+		return err;
 
 	err = idpf_vport_intr_alloc(vport);
 	if (err) {
@@ -1539,7 +1536,7 @@ void idpf_init_task(struct work_struct *work)
 	np = netdev_priv(vport->netdev);
 	np->state = __IDPF_VPORT_DOWN;
 	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags))
-		idpf_vport_open(vport, true);
+		idpf_vport_open(vport);
 
 	/* Spawn and return 'idpf_init_task' work queue until all the
 	 * default vports are created
@@ -1898,9 +1895,6 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		goto free_vport;
 	}
 
-	err = idpf_vport_queues_alloc(new_vport);
-	if (err)
-		goto free_vport;
 	if (current_state <= __IDPF_VPORT_DOWN) {
 		idpf_send_delete_queues_msg(vport);
 	} else {
@@ -1932,17 +1926,23 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 
 	err = idpf_set_real_num_queues(vport);
 	if (err)
-		goto err_reset;
+		goto err_open;
 
 	if (current_state == __IDPF_VPORT_UP)
-		err = idpf_vport_open(vport, false);
+		err = idpf_vport_open(vport);
 
 	kfree(new_vport);
 
 	return err;
 
 err_reset:
-	idpf_vport_queues_rel(new_vport);
+	idpf_send_add_queues_msg(vport, vport->num_txq, vport->num_complq,
+				 vport->num_rxq, vport->num_bufq);
+
+err_open:
+	if (current_state == __IDPF_VPORT_UP)
+		idpf_vport_open(vport);
+
 free_vport:
 	kfree(new_vport);
 
@@ -2171,7 +2171,7 @@ static int idpf_open(struct net_device *netdev)
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	err = idpf_vport_open(vport, true);
+	err = idpf_vport_open(vport);
 
 	idpf_vport_ctrl_unlock(netdev);
 
-- 
2.45.2


