Return-Path: <netdev+bounces-222590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D18B54F37
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFF81CC5C4E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DEE30E82A;
	Fri, 12 Sep 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nk8nB9eQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192730C602
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683036; cv=none; b=SJxB2Qxgnlbnt1HW/J4lSU+70muX1Z8SjRcCLrBmdLgMqESSRnKKixOz8s9qHNmBcM2uHXeOFmU7KuartM0209UwmjGTNStX3LeM+z7EAYZU/XmzvVQ6XTbeh/jHtTMR6ceRHgWiDFAqr9wpR2HCgNFiG9xQQ+e0Bxa35lm2SC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683036; c=relaxed/simple;
	bh=nYp2Je62JFvuEy0NyipjKgzopzn1TOBoUnG0MujtZSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XNomFGBH1ICvyeo0rQZyXeSWddIPN0zRWiPoI6peHevG06sycUBJNDPOcRN89t6nqLlKLotxwF1dE+OsrIiQjy8q1NwHcRiZFaufUstPAWS8JP5SjS6iHql14PQHBl8UX3X4wQTXmgWC3Bp+GNumVqLFMJvxHVCiHD9KqTWlqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nk8nB9eQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683034; x=1789219034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nYp2Je62JFvuEy0NyipjKgzopzn1TOBoUnG0MujtZSg=;
  b=Nk8nB9eQ0uDwndjlhiZyppSuadlb66TrzE2bjtJpRM3qiVkNarUE2Kn/
   mGMA56qIIJZWxL4Akknr+/W+C2gHLPSqJXrd2WcAxmJe1VHrZrFSEILtT
   wwlSiLX4ArZZkm3CGtDDEElOrzoU5NDu4AF6qoM86L6aKT9l2NVSnvf0z
   e99dnMe1ZolNC63JileO2PYrCRO3f2awU/BKpIVum8zxByqbIhAQfuLOc
   0kJM1PtNSl/cFEG6+mpvr/IWRlAr6FiOSYumbpcPX1pwXex06GjIm2tsR
   4lh7+g/Jz6Fu6Ya5dw5ZZlchkxcPIDFXhoYiqhGMc9FynTGVSIzQMSiBH
   A==;
X-CSE-ConnectionGUID: T3/Yu84uQzGQ/sk9iQkA6A==
X-CSE-MsgGUID: 0GOnbqfUTiOT/W3kj4JtcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461401"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461401"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:12 -0700
X-CSE-ConnectionGUID: 11Gjib9mRL6YF4hqKJkWSg==
X-CSE-MsgGUID: fTbjP3f9TcWMJpR1eD8piA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131207"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:10 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 43C092FC6F;
	Fri, 12 Sep 2025 14:17:09 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 1/9] ice: enforce RTNL assumption of queue NAPI manipulation
Date: Fri, 12 Sep 2025 15:06:19 +0200
Message-Id: <20250912130627.5015-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of making assumptions in comments move them into code.
Be also more precise, RTNL must be locked only when there is
NAPI, and we have VSIs w/o NAPI that call ice_vsi_clear_napi_queues()
during rmmod.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
CC:Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index a439b5a61a56..3f1b2158be59 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2769,16 +2769,16 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
  * @vsi: VSI pointer
  *
  * Associate queue[s] with napi for all vectors.
- * The caller must hold rtnl_lock.
  */
 void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 {
 	struct net_device *netdev = vsi->netdev;
 	int q_idx, v_idx;
 
 	if (!netdev)
 		return;
 
+	ASSERT_RTNL();
 	ice_for_each_rxq(vsi, q_idx)
 		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
 				     &vsi->rx_rings[q_idx]->q_vector->napi);
@@ -2799,16 +2799,16 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
  * @vsi: VSI pointer
  *
  * Clear the association between all VSI queues queue[s] and napi.
- * The caller must hold rtnl_lock.
  */
 void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
 {
 	struct net_device *netdev = vsi->netdev;
 	int q_idx, v_idx;
 
 	if (!netdev)
 		return;
 
+	ASSERT_RTNL();
 	/* Clear the NAPI's interrupt number */
 	ice_for_each_q_vector(vsi, v_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
-- 
2.39.3


