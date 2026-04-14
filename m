Return-Path: <netdev+bounces-278435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL/7B00w3mnxogkAu9opvQ
	(envelope-from <netdev+bounces-278435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:17:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C7D3F9E92
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A70D330021F9
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBE8302756;
	Tue, 14 Apr 2026 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyKvlcM7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1123E5EE5
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168863; cv=none; b=SC1KRwrHl1gVLXGZNOIOEewByVlzDRRa9w0b/E3Z+S0ufqJdpGcAK7vd2j8Z/t4MVBSXplhqhY1It2Lhce79kEpSPmZ5ei/NLDtCBf4EwGFjOPfO9fH364Eu8xftq3qLQHZLAibgeOSO2IlE82oP6FUE+lblQ+kkgCftK1zp4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168863; c=relaxed/simple;
	bh=aoQqQPGJhc03KFS3wOJRIWobNOhGmxoRm0pwr6KLZKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnevDjuxu0gJjMyWog9GExjGJHkFFkKI/Dk6zqXGgssMBxi0MAafpscETCFYnm1hTubrVK6RDWhHL2veylD4YJfrwv/gTULelsAM6IBdTBuEyrITx/f+DXnM2jDedm+ZyNUCDqG6JKD8AtOWcahYSEu9nYfaJQZQ9wEUUA40Bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyKvlcM7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776168861; x=1807704861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aoQqQPGJhc03KFS3wOJRIWobNOhGmxoRm0pwr6KLZKU=;
  b=lyKvlcM7Pkkrghc3S9Xai25MRE8Okjjq2nahUfzHi9ZyWTWBRwN8fxYM
   NVBxxnj9R+MC8F4sIe2JpnKUxtMT3RwpnQd1JLocSBu0qq9+JvWZva2Lm
   q+N9kZ9sYBHkrr51GIqIaidrXWN+VMZW5ElZU0yjK5/erSG9Xj50RsvzK
   BOBwSwsW7mcgO+hWv7sCAmomd12Nu1Asllla6U52agyrCGuPSGdkx4B5/
   FTyYc6Zt/w/zcJ5idKFQZqUQ9p2JJrIMRX1MEc5G/sqlaaYvaB4WI8NEI
   mSW//o5/LyfTsgPIIfgJrJTVGo3GGZhmG0mAwY4XBgJ/Ylb6VoZBMYiSk
   A==;
X-CSE-ConnectionGUID: C1rsLnj3TOWu2paCfSnYdA==
X-CSE-MsgGUID: A2UMQsRtSA+ojPZGZohnUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="79707432"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="79707432"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:14:21 -0700
X-CSE-ConnectionGUID: XWSIhP6NQ06y/MK2T9SRjQ==
X-CSE-MsgGUID: GNf6lb5bS/mOHE3aWRvTvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223580738"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 14 Apr 2026 05:14:18 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net] i40e: keep q_vectors array in sync with channel count changes
Date: Tue, 14 Apr 2026 14:14:05 +0200
Message-Id: <20260414121405.631092-1-maciej.fijalkowski@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278435-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87C7D3F9E92
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
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 34 +++++++++++++++++----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 926d001b2150..5636ad71f940 100644
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
+		      min_t(u16, vsi->req_queue_pairs, pf->num_lan_qps) :
+		      pf->num_lan_qps;
 		if (!vsi->num_tx_desc)
 			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
@@ -11414,7 +11418,8 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
 		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
-			vsi->num_q_vectors = pf->num_lan_msix;
+			vsi->num_q_vectors = max_t(int, 1,
+						   min_t(int, qps, pf->num_lan_msix));
 		else
 			vsi->num_q_vectors = 1;
 
@@ -12043,7 +12048,8 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
 	cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
 
 	if (vsi->netdev)
-		netif_napi_add(vsi->netdev, &q_vector->napi, i40e_napi_poll);
+		netif_napi_add_config(vsi->netdev, &q_vector->napi,
+				      i40e_napi_poll, v_idx);
 
 	/* tie q_vector and vsi together */
 	vsi->q_vectors[v_idx] = q_vector;
@@ -14265,12 +14271,27 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 	pf = vsi->back;
 
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
+		i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
+		vsi->base_vector = 0;
+	}
+
 	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
 	i40e_vsi_clear_rings(vsi);
 
-	i40e_vsi_free_arrays(vsi, false);
+	i40e_vsi_free_q_vectors(vsi);
+	i40e_vsi_free_arrays(vsi, true);
 	i40e_set_num_rings_in_vsi(vsi);
-	ret = i40e_vsi_alloc_arrays(vsi, false);
+
+	ret = i40e_vsi_alloc_arrays(vsi, true);
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
 
@@ -14282,7 +14303,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "failed to get tracking for %d queues for VSI %d err %d\n",
 			 alloc_queue_pairs, vsi->seid, ret);
-		goto err_vsi;
+		goto err_lump;
 	}
 	vsi->base_queue = ret;
 
@@ -14306,7 +14327,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	return vsi;
 
 err_rings:
-	i40e_vsi_free_q_vectors(vsi);
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
@@ -14316,6 +14336,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
+err_lump:
+	i40e_vsi_free_q_vectors(vsi);
 err_vsi:
 	i40e_vsi_clear(vsi);
 	return NULL;
-- 
2.43.0


