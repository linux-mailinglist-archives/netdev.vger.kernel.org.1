Return-Path: <netdev+bounces-116262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EC4949AF7
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F5C1C21D8F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538216F8FD;
	Tue,  6 Aug 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fT4ocHuK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A99159571
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982179; cv=none; b=WlmDGyURADhIcMXvSayDNXRMyAgGPeYZanPdfBqBQK4zNXCIVJ2QPZ0qYOVFfWT+sphGiAnA8Ysg6Oki89Fq3SnuFTdy86A+it2thIMIXs2OtdSQmph5DUZa4t3IfZI0B/kQN1guyxQwozF1DA81+t1NnCGPTE5A47Wvu+9uGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982179; c=relaxed/simple;
	bh=OmLSRVe6aq5J6ZQgkRNEgUYOX0q+oqc/0aCHnTZ9Xys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKHPJExst/DNP3QAP8aMOTLhNOliqf7nI+srAEHzixryPi9G9eUP0Nzv0/28iCpOLq4GTiL9LCDWJUUWhyqIslH1B5h2Hoo7fmPXzPRfoO+VG4kz3YtZ72Z52riY6VCnVuFxtQYOjVPfgiNo3sCZzGrGdpgHW6n4IfgR/iFZRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fT4ocHuK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982179; x=1754518179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmLSRVe6aq5J6ZQgkRNEgUYOX0q+oqc/0aCHnTZ9Xys=;
  b=fT4ocHuK5WcEJybXCdIm8SR8jxu8yTKWmNAr9qhvJSdvyYx3uKTpB2fL
   wrnbkIbhGeZqNBAxVbsD8EGpax/3r7KEE7NA5RVNJTVyXm5JzGaZ5y/dz
   7CD1US8ReMzz4fMGHw8fX066nSxQpfCzbBqRgY/3c+A85o/geKACmkBH7
   UlaFXilu8C7nb9a6cbTyK5KMyw12ffvFaqog1IvCw3uymLY6wBIoQ85gS
   YinndGR8bzRu1Gk3gOIOA2R9pmShR4CkMxT6hwIvsEi1UmlU+vb5TWnVC
   E4x61u8orBDxfDG9CVg3kbbi1/3gU8NYxf/rpI3x188T5QcbXmJeDWJ/w
   A==;
X-CSE-ConnectionGUID: SVPzo7wJRYmalNCj/dU5pg==
X-CSE-MsgGUID: QTTxHy7tQaqrXhmUcPQ69A==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21172193"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21172193"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:09:37 -0700
X-CSE-ConnectionGUID: WbcRhqdJR86bBblbMv0jXg==
X-CSE-MsgGUID: 2c/eklsnRAaiCj/6iewqAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56297911"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Aug 2024 15:09:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 1/3] idpf: fix memory leaks and crashes while performing a soft reset
Date: Tue,  6 Aug 2024 15:09:20 -0700
Message-ID: <20240806220923.3359860-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
References: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.42.0


