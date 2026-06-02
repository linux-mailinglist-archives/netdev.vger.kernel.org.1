Return-Path: <netdev+bounces-294451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XdEkMXFfH2pYlQAAu9opvQ
	(envelope-from <netdev+bounces-294451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:55:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C387F632B0D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 00:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YZNB5QZG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294451-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294451-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9ADDF3016688
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 22:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781BD3CAE93;
	Tue,  2 Jun 2026 22:55:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899B33A5E65
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:55:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440923; cv=none; b=vCV0HnCqVhbWwJNCXTUyahlZ1tCM/KU3aGsp1yTDyiWVJpHClmNi4gwdEA7WI7I+bqfUKNj46e9Vx1pMgUiQUcvOf+vvbX5IFywYexWeajYuNiwWYNtcPnyqVNFfp6TkFzRxXvng0jy2kTRm73/bKcP8OhntPJgyom5+nruUy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440923; c=relaxed/simple;
	bh=bkEE+VGZ6LqII4GpH0PFdNwWjVUXS08t9T65j4x+JVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhSlZaiMHQp1YHoXk9w5IVBagGSV1UO+7kO0Dewa4P9sPABCPos5ExiLQse+hGOHAEYIjvXXd1vtO2kQswB9+3Zcg4b+FuDTjtBi8rkW5S0rH2u27RjEhAZGQ0xHqPdQ9LzfYB7ocKRiB0Ak1LNgWlv/gu+Ut2nkd8w41UoEuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZNB5QZG; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780440922; x=1811976922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkEE+VGZ6LqII4GpH0PFdNwWjVUXS08t9T65j4x+JVk=;
  b=YZNB5QZGi8hCXwEMUfL4i6VpC+BVNuEXK7fhg3N3att+nZEJcBmhnN2u
   ivsSr4Sd/uNyKPQ9bJKXVIXKG9zbCf/RadtSEcBW2MYGsImcQ8HcgNEjo
   3WdcKz4pIDvQuoXjJvSUgw0jNVYPHyiZoJDm1kRIMD2QWTT1G5Oz0FvYS
   qZfC6kOb9mX4R2OUXSJl/FGHM0G6BS0t4xRUUXcJtNXy6DOydyt7iWSJw
   oVmthyufO964IEqVBYkq7/SdfsSiBweAku+ooCNF2+XkGYRWLC/EQuD++
   Ok7Z3B1iwMJ3s9YGCY4T0Avsnhf2JWx2bdZoYi7EJAmIMrw0D56Qu9M8U
   g==;
X-CSE-ConnectionGUID: MqNMqd3ZSJqe0vqN0NEdyg==
X-CSE-MsgGUID: KlStMk6wSdWYBMTv8NYObA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81421401"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81421401"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:55:21 -0700
X-CSE-ConnectionGUID: kOy5ogwPR92foPtpJ8vzog==
X-CSE-MsgGUID: LFJzcDtORAyqBl/tF/FloQ==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jun 2026 15:55:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	magnus.karlsson@intel.com,
	horms@kernel.org,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 1/3] i40e: keep q_vectors array in sync with channel count changes
Date: Tue,  2 Jun 2026 15:55:09 -0700
Message-ID: <20260602225513.393338-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260602225513.393338-1-anthony.l.nguyen@intel.com>
References: <20260602225513.393338-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294451-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:maciej.fijalkowski@intel.com,m:anthony.l.nguyen@intel.com,m:jacob.e.keller@intel.com,m:przemyslaw.kitszel@intel.com,m:magnus.karlsson@intel.com,m:horms@kernel.org,m:sunithax.d.mekala@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp,napi_threaded.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C387F632B0D

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 73 +++++++++++++--------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6d4f9218dc68..c3fbe14ff2d3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11403,10 +11403,14 @@ static void i40e_service_timer(struct timer_list *t)
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
@@ -11414,7 +11418,7 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
 		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
-			vsi->num_q_vectors = pf->num_lan_msix;
+			vsi->num_q_vectors = clamp(qps, 1, pf->num_lan_msix);
 		else
 			vsi->num_q_vectors = 1;
 
@@ -11466,12 +11470,11 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
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
@@ -11490,19 +11493,18 @@ static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
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
 
@@ -11575,7 +11577,7 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 	if (ret)
 		goto err_rings;
 
-	ret = i40e_vsi_alloc_arrays(vsi, true);
+	ret = i40e_vsi_alloc_arrays(vsi);
 	if (ret)
 		goto err_rings;
 
@@ -11600,18 +11602,15 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
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
@@ -11671,7 +11670,7 @@ static int i40e_vsi_clear(struct i40e_vsi *vsi)
 	i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
 
 	bitmap_free(vsi->af_xdp_zc_qps);
-	i40e_vsi_free_arrays(vsi, true);
+	i40e_vsi_free_arrays(vsi);
 	i40e_clear_rss_config_user(vsi);
 
 	pf->vsi[vsi->idx] = NULL;
@@ -12043,7 +12042,8 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
 	cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
 
 	if (vsi->netdev)
-		netif_napi_add(vsi->netdev, &q_vector->napi, i40e_napi_poll);
+		netif_napi_add_config(vsi->netdev, &q_vector->napi,
+				      i40e_napi_poll, v_idx);
 
 	/* tie q_vector and vsi together */
 	vsi->q_vectors[v_idx] = q_vector;
@@ -14264,12 +14264,26 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
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
 
@@ -14281,7 +14295,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "failed to get tracking for %d queues for VSI %d err %d\n",
 			 alloc_queue_pairs, vsi->seid, ret);
-		goto err_vsi;
+		goto err_lump;
 	}
 	vsi->base_queue = ret;
 
@@ -14305,7 +14319,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	return vsi;
 
 err_rings:
-	i40e_vsi_free_q_vectors(vsi);
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
@@ -14315,6 +14328,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
+err_lump:
+	i40e_vsi_free_q_vectors(vsi);
 err_vsi:
 	i40e_vsi_clear(vsi);
 	return NULL;
@@ -14456,12 +14471,12 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
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
 
@@ -14484,9 +14499,9 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
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
2.47.1


