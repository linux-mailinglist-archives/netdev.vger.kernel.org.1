Return-Path: <netdev+bounces-259626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O5PLEGul2nO5QIAu9opvQ
	(envelope-from <netdev+bounces-259626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:43:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB0163EEE
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08C253084BE9
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82D3205E02;
	Fri, 20 Feb 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAmmqTNu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B921C175
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548043; cv=none; b=LfCnZvwU0BAT522HZJCM0QgmM1qaIkjRq3LuhFp7xQZTU+Ts5n3FmoZajFqjcBdJswFM/ygJBXTAAEDvBy2qmdo0/TUOSqKgqgt/8bbhXIJc1r+gztI5TWYDFDdCXGh8+7p8JxxO30lZWjt3fYObBeuaM9J530fHYUw2XIqJHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548043; c=relaxed/simple;
	bh=8jMKm/Q5p7RGXO9Q9vPnyzkHwS8ajLrgvjEuNDAEvcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZX1npsQ8mklZ2ushagtlCDcTg/EsEQRCm2Y7BuVbPJOkL8UzI7tY8aew3IV3ijBBze8hjMFR4JT9PP4sXvxjLV4YLuc+Sgep0uV8Kt3iy7P/gBzWf9IpPT2YumcCxeA3NdPfnjEN3k1HrfJxnqR5dDPNGnXiw64yDx1UdCgMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAmmqTNu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548039; x=1803084039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8jMKm/Q5p7RGXO9Q9vPnyzkHwS8ajLrgvjEuNDAEvcg=;
  b=LAmmqTNuSWIq5ozaH6UXVw3EYEg8WlGVO4Lk+YxT+dZw1O7aiAie6nxr
   /o+ItRJrIA5jJ5+GW7TVqGIZY9KfmZ0ErWKAIpJrsvoHHrYNaE7qF4Efa
   NEVCXi+/NE9Z3nHFAtQuRImTF8CEHMmIrry4c0BZhkv8vE2R/Pkrh76tN
   yXqptT32sJJhZz7xy7UycXHRw6rPOzb7MDfe77hDkhQRJngJxvOwT6nGz
   l2gyGWRTu8zD8tAvdQ/ShRI8MryiXkDKKqWDthU3qByTAlrZogCV5chGh
   f4uVbkLoAsKvZny84tB8SLyEooWWORTaaYqCFsQeRufF6KjfWBK3cToHR
   A==;
X-CSE-ConnectionGUID: WreNyXvqSXeEYwhDB3Ww5w==
X-CSE-MsgGUID: PlkkwjRUR5alisetqGTqlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484217"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484217"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:34 -0800
X-CSE-ConnectionGUID: dgwx/V8wTM+WNLDI0v1mLg==
X-CSE-MsgGUID: +ZUqNCXrRk2ARl3kUbsAZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850486"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:33 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	michal.kubiak@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 08/13] ice: fix crash in ethtool offline loopback test
Date: Thu, 19 Feb 2026 16:40:20 -0800
Message-ID: <20260220004027.729384-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259626-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35DB0163EEE
X-Rspamd-Action: no action

From: Michal Schmidt <mschmidt@redhat.com>

Since the conversion of ice to page pool, the ethtool loopback test
crashes:

 BUG: kernel NULL pointer dereference, address: 000000000000000c
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 1100f1067 P4D 0
 Oops: Oops: 0002 [#1] SMP NOPTI
 CPU: 23 UID: 0 PID: 5904 Comm: ethtool Kdump: loaded Not tainted 6.19.0-0.rc7.260128g1f97d9dcf5364.49.eln154.x86_64 #1 PREEMPT(lazy)
 Hardware name: [...]
 RIP: 0010:ice_alloc_rx_bufs+0x1cd/0x310 [ice]
 Code: 83 6c 24 30 01 66 41 89 47 08 0f 84 c0 00 00 00 41 0f b7 dc 48 8b 44 24 18 48 c1 e3 04 41 bb 00 10 00 00 48 8d 2c 18 8b 04 24 <89> 45 0c 41 8b 4d 00 49 d3 e3 44 3b 5c 24 24 0f 83 ac fe ff ff 44
 RSP: 0018:ff7894738aa1f768 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000700 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ff16dcae79880200 R09: 0000000000000019
 R10: 0000000000000001 R11: 0000000000001000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ff16dcae6c670000
 FS:  00007fcf428850c0(0000) GS:ff16dcb149710000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000000c CR3: 0000000121227005 CR4: 0000000000773ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ice_vsi_cfg_rxq+0xca/0x460 [ice]
  ice_vsi_cfg_rxqs+0x54/0x70 [ice]
  ice_loopback_test+0xa9/0x520 [ice]
  ice_self_test+0x1b9/0x280 [ice]
  ethtool_self_test+0xe5/0x200
  __dev_ethtool+0x1106/0x1a90
  dev_ethtool+0xbe/0x1a0
  dev_ioctl+0x258/0x4c0
  sock_do_ioctl+0xe3/0x130
  __x64_sys_ioctl+0xb9/0x100
  do_syscall_64+0x7c/0x700
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [...]

It crashes because we have not initialized libeth for the rx ring.

Fix it by treating ICE_VSI_LB VSIs slightly more like normal PF VSIs and
letting them have a q_vector. It's just a dummy, because the loopback
test does not use interrupts, but it contains a napi struct that can be
passed to libeth_rx_fq_create() called from ice_vsi_cfg_rxq() ->
ice_rxq_pp_create().

Fixes: 93f53db9f9dc ("ice: switch to Page Pool")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c    |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++++
 drivers/net/ethernet/intel/ice/ice_lib.c     | 15 ++++++++++-----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index afbff8aa9ceb..49b4304c4975 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -124,6 +124,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	if (vsi->type == ICE_VSI_VF) {
 		ice_calc_vf_reg_idx(vsi->vf, q_vector);
 		goto out;
+	} else if (vsi->type == ICE_VSI_LB) {
+		goto skip_alloc;
 	} else if (vsi->type == ICE_VSI_CTRL && vsi->vf) {
 		struct ice_vsi *ctrl_vsi = ice_get_vf_ctrl_vsi(pf, vsi);
 
@@ -662,7 +664,8 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	u32 rx_buf_len;
 	int err;
 
-	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
+	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF ||
+	    ring->vsi->type == ICE_VSI_LB) {
 		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c6bc29cfb8e6..ff003529beba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1289,6 +1289,10 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	test_vsi->netdev = netdev;
 	tx_ring = test_vsi->tx_rings[0];
 	rx_ring = test_vsi->rx_rings[0];
+	/* Dummy q_vector and napi. Fill the minimum required for
+	 * ice_rxq_pp_create().
+	 */
+	rx_ring->q_vector->napi.dev = netdev;
 
 	if (ice_lbtest_prepare_rings(test_vsi)) {
 		ret = 2;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d921269e1fe7..3cd6296a1fbe 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -107,10 +107,6 @@ static int ice_vsi_alloc_arrays(struct ice_vsi *vsi)
 	if (!vsi->rxq_map)
 		goto err_rxq_map;
 
-	/* There is no need to allocate q_vectors for a loopback VSI. */
-	if (vsi->type == ICE_VSI_LB)
-		return 0;
-
 	/* allocate memory for q_vector pointers */
 	vsi->q_vectors = devm_kcalloc(dev, vsi->num_q_vectors,
 				      sizeof(*vsi->q_vectors), GFP_KERNEL);
@@ -241,6 +237,8 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 	case ICE_VSI_LB:
 		vsi->alloc_txq = 1;
 		vsi->alloc_rxq = 1;
+		/* A dummy q_vector, no actual IRQ. */
+		vsi->num_q_vectors = 1;
 		break;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "Unknown VSI type %d\n", vsi_type);
@@ -2428,14 +2426,21 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		}
 		break;
 	case ICE_VSI_LB:
-		ret = ice_vsi_alloc_rings(vsi);
+		ret = ice_vsi_alloc_q_vectors(vsi);
 		if (ret)
 			goto unroll_vsi_init;
 
+		ret = ice_vsi_alloc_rings(vsi);
+		if (ret)
+			goto unroll_alloc_q_vector;
+
 		ret = ice_vsi_alloc_ring_stats(vsi);
 		if (ret)
 			goto unroll_vector_base;
 
+		/* Simply map the dummy q_vector to the only rx_ring */
+		vsi->rx_rings[0]->q_vector = vsi->q_vectors[0];
+
 		break;
 	default:
 		/* clean up the resources and exit */
-- 
2.47.1


