Return-Path: <netdev+bounces-289406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPFCFvtJDGrjdQUAu9opvQ
	(envelope-from <netdev+bounces-289406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:31:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DAE57DA51
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43A7C308396C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE8B3F4DD1;
	Tue, 19 May 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eybWjlsl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E33D88FC
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188230; cv=none; b=nfOcdu7XKlme5IjVBVI8mQnc9JC0LGXIZwmfMcqnLap/x7srgSVS1aYTwnfaTkpFa3gW6o7oiDNrjqRTWhCFgsFp4XHPP13INkaD6ngdcGZ336hH1051bdk8vY2zyv85+2KWAnv+8YdqmI+EJEbymsyoXF8i73EuszLQ6z2FMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188230; c=relaxed/simple;
	bh=lsBVMREThc1wx/FRt7E+QCeVCwR4ZbEJEAKra/cO96g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pgz+IqpMFpZYfySmNmPVEDacCA9qhxkpdqjHTRyo6OqFk6rMfW8BQpVsh4SKVmtrV6pzj7FY72PHSasjbhV+HqZz9zeFSSygWb0MjnW/aOm5gZIPZq+LIR0RQu8+FQEOapgZX22IrKkEtf3hP8gt14uSN/FzMNOuF4LMEkMbcPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eybWjlsl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779188228; x=1810724228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lsBVMREThc1wx/FRt7E+QCeVCwR4ZbEJEAKra/cO96g=;
  b=eybWjlsl6/aLww82hQ2pcmzxzWwWX2mf7N9NGabIcEg7eSYY12cmni07
   5AHY1N7NJZoIPIsljNgXMRxCivuwENQo4yGMDSIngsV2S1Jey8jU0/abb
   AVh+LLi50bxF+5R9F8FFAmD0bFQVmIyTvvlfEvrhTrhVxU56JI5GSMLG8
   8FREXHg1aut/9mW9+FUaM6migD987ZOuNE3HUAk0nYcFtkJk/2Utzu0VG
   KDC4FPkLdaLtAoqojGwB0Hixy/XUSWINPJGtrr8O+uiWMadWcrT7nnbJZ
   zRVwBARDExj7+mRwV/SjicY7USNWG/xniHFLVMnCkN9T3Fi/r+hRzIXtE
   w==;
X-CSE-ConnectionGUID: rhBShf0aT4GSdpPWDNBp+w==
X-CSE-MsgGUID: MLvqugEFQfKIgRKtier7Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82626789"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82626789"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:57:00 -0700
X-CSE-ConnectionGUID: BaVOWXebSbS9DesvgV6Uyg==
X-CSE-MsgGUID: KrVgaAA7SkmaoJajXSmd1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241568910"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa004.fm.intel.com with ESMTP; 19 May 2026 03:56:58 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH v3 iwl-net] i40e: keep q_vectors array in sync with channel count changes
Date: Tue, 19 May 2026 12:56:38 +0200
Message-Id: <20260519105637.839438-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289406-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C5DAE57DA51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For the main VSI, i40e_set_num_rings_in_vsi() always derives
num_q_vectors from pf->num_lan_msix. At the same time, ethtool -L stores
the user requested channel count in vsi->req_queue_pairs and the queue
setup path uses that value for the effective number of queue pairs.

This leaves queue and vector counts out of sync after shrinking channel
count via ethtool -L. The active queue configuration is reduced, but the
VSI still keeps the full PF-sized q_vector topology.

That mismatch breaks reconfiguration flows which rely on vector/NAPI
state matching the effective channel configuration. In particular,
toggling /sys/class/net/<dev>/threaded after reducing the channel count
can hang, and later channel-count changes can fail because VSI reinit
does not rebuild q_vectors to match the new vector count.

Fix this by making the main VSI num_q_vectors follow the effective
requested channel count, capped by the available MSI-X vectors. Update
i40e_vsi_reinit_setup() to rebuild q_vectors during VSI reinit so the
vector topology is refreshed together with the ring arrays when channel
count changes.

Keep alloc_queue_pairs unchanged and based on pf->num_lan_qps so the VSI
retains its full queue capacity.

Selftest napi_threaded.py was originally used when Jakub reported hang
on /sys/class/net/<dev>/threaded toggle. In order to make it pass on
i40e, use persistent NAPI configuration for q_vector NAPIs so NAPI
identity and threaded settings survive q_vector reallocation across
channel-count changes. This is achieved by using netif_napi_add_config()
when configuring q_vectors.

$ export NETIF=ens259f1np1
$ sudo -E env PATH="$PATH" ./tools/testing/selftests/drivers/net/napi_threaded.py
TAP version 13
1..3
ok 1 napi_threaded.napi_init
ok 2 napi_threaded.change_num_queues
ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v3:
- address UAF when ring arrays where freed before q_vector's ring
  containers (Sashiko, Jacob)
- remove bool params from alloc/free array routines (Simon)
v2:
- NULL vsi->tx_rings in i40e_vsi_alloc_arrays() (Sashiko)
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 73 +++++++++++++--------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..4e7cffb23d03 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11406,10 +11406,14 @@ static void i40e_service_timer(struct timer_list *t)
 static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
+	u16 qps;
 
 	switch (vsi->type) {
 	case I40E_VSI_MAIN:
 		vsi->alloc_queue_pairs = pf->num_lan_qps;
+		qps = vsi->req_queue_pairs ?
+		      min(vsi->req_queue_pairs, pf->num_lan_qps) :
+		      pf->num_lan_qps;
 		if (!vsi->num_tx_desc)
 			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
@@ -11417,7 +11421,7 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
 		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
-			vsi->num_q_vectors = pf->num_lan_msix;
+			vsi->num_q_vectors = clamp(qps, 1, pf->num_lan_msix);
 		else
 			vsi->num_q_vectors = 1;
 
@@ -11469,12 +11473,11 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 /**
  * i40e_vsi_alloc_arrays - Allocate queue and vector pointer arrays for the vsi
  * @vsi: VSI pointer
- * @alloc_qvectors: a bool to specify if q_vectors need to be allocated.
  *
  * On error: returns error code (negative)
  * On success: returns 0
  **/
-static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
+static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi)
 {
 	struct i40e_ring **next_rings;
 	int size;
@@ -11493,19 +11496,18 @@ static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
 	}
 	vsi->rx_rings = next_rings;
 
-	if (alloc_qvectors) {
-		/* allocate memory for q_vector pointers */
-		size = sizeof(struct i40e_q_vector *) * vsi->num_q_vectors;
-		vsi->q_vectors = kzalloc(size, GFP_KERNEL);
-		if (!vsi->q_vectors) {
-			ret = -ENOMEM;
-			goto err_vectors;
-		}
+	/* allocate memory for q_vector pointers */
+	size = sizeof(struct i40e_q_vector *) * vsi->num_q_vectors;
+	vsi->q_vectors = kzalloc(size, GFP_KERNEL);
+	if (!vsi->q_vectors) {
+		ret = -ENOMEM;
+		goto err_vectors;
 	}
 	return ret;
 
 err_vectors:
 	kfree(vsi->tx_rings);
+	vsi->tx_rings = NULL;
 	return ret;
 }
 
@@ -11578,7 +11580,7 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 	if (ret)
 		goto err_rings;
 
-	ret = i40e_vsi_alloc_arrays(vsi, true);
+	ret = i40e_vsi_alloc_arrays(vsi);
 	if (ret)
 		goto err_rings;
 
@@ -11603,18 +11605,15 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 /**
  * i40e_vsi_free_arrays - Free queue and vector pointer arrays for the VSI
  * @vsi: VSI pointer
- * @free_qvectors: a bool to specify if q_vectors need to be freed.
  *
  * On error: returns error code (negative)
  * On success: returns 0
  **/
-static void i40e_vsi_free_arrays(struct i40e_vsi *vsi, bool free_qvectors)
+static void i40e_vsi_free_arrays(struct i40e_vsi *vsi)
 {
 	/* free the ring and vector containers */
-	if (free_qvectors) {
-		kfree(vsi->q_vectors);
-		vsi->q_vectors = NULL;
-	}
+	kfree(vsi->q_vectors);
+	vsi->q_vectors = NULL;
 	kfree(vsi->tx_rings);
 	vsi->tx_rings = NULL;
 	vsi->rx_rings = NULL;
@@ -11674,7 +11673,7 @@ static int i40e_vsi_clear(struct i40e_vsi *vsi)
 	i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
 
 	bitmap_free(vsi->af_xdp_zc_qps);
-	i40e_vsi_free_arrays(vsi, true);
+	i40e_vsi_free_arrays(vsi);
 	i40e_clear_rss_config_user(vsi);
 
 	pf->vsi[vsi->idx] = NULL;
@@ -12046,7 +12045,8 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
 	cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
 
 	if (vsi->netdev)
-		netif_napi_add(vsi->netdev, &q_vector->napi, i40e_napi_poll);
+		netif_napi_add_config(vsi->netdev, &q_vector->napi,
+				      i40e_napi_poll, v_idx);
 
 	/* tie q_vector and vsi together */
 	vsi->q_vectors[v_idx] = q_vector;
@@ -14267,12 +14267,26 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 	pf = vsi->back;
 
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
+		i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
+		vsi->base_vector = 0;
+	}
+
 	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
+	i40e_vsi_free_q_vectors(vsi);
 	i40e_vsi_clear_rings(vsi);
+	i40e_vsi_free_arrays(vsi);
 
-	i40e_vsi_free_arrays(vsi, false);
 	i40e_set_num_rings_in_vsi(vsi);
-	ret = i40e_vsi_alloc_arrays(vsi, false);
+	ret = i40e_vsi_alloc_arrays(vsi);
+	if (ret)
+		goto err_vsi;
+
+	/* Rebuild q_vectors during VSI reinit because the effective channel
+	 * count may change num_q_vectors. Keep vector topology aligned with the
+	 * queue configuration after ethtool's .set_channels() callback.
+	 */
+	ret = i40e_vsi_setup_vectors(vsi);
 	if (ret)
 		goto err_vsi;
 
@@ -14284,7 +14298,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "failed to get tracking for %d queues for VSI %d err %d\n",
 			 alloc_queue_pairs, vsi->seid, ret);
-		goto err_vsi;
+		goto err_lump;
 	}
 	vsi->base_queue = ret;
 
@@ -14308,7 +14322,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	return vsi;
 
 err_rings:
-	i40e_vsi_free_q_vectors(vsi);
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
@@ -14318,6 +14331,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
+err_lump:
+	i40e_vsi_free_q_vectors(vsi);
 err_vsi:
 	i40e_vsi_clear(vsi);
 	return NULL;
@@ -14459,12 +14474,12 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 #endif /* CONFIG_I40E_DCB */
 		fallthrough;
 	case I40E_VSI_FDIR:
-		/* set up vectors and rings if needed */
-		ret = i40e_vsi_setup_vectors(vsi);
+		ret = i40e_alloc_rings(vsi);
 		if (ret)
 			goto err_msix;
 
-		ret = i40e_alloc_rings(vsi);
+		/* set up vectors and rings if needed */
+		ret = i40e_vsi_setup_vectors(vsi);
 		if (ret)
 			goto err_rings;
 
@@ -14487,9 +14502,9 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	return vsi;
 
 err_config:
-	i40e_vsi_clear_rings(vsi);
-err_rings:
 	i40e_vsi_free_q_vectors(vsi);
+err_rings:
+	i40e_vsi_clear_rings(vsi);
 err_msix:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
-- 
2.43.0


