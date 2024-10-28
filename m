Return-Path: <netdev+bounces-139474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C387B9B2C3A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09B81C2188F
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60DF1CCEE6;
	Mon, 28 Oct 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCuaTHsU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F921922F2
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109831; cv=none; b=iBwr8I2ZPpbc7ABQsmsFIpUeQAWeWT/sYwfwVka4R2azZIy/Mu9BIliXbNAR1rbNz7iqh11RQ8iDNzdSumJ2WOlokEU7sOFP2jfTiyxHfohbBGbSN8jnvAYXVgqvGke1Aa2/HrmC9xf6zuQATH++2Qep9Oe6pGB+PQoSH1agj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109831; c=relaxed/simple;
	bh=fBo/M28zaE+Gi6IeMuAGUsuNyb5P4s2Gmpx5MaRTckQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsV5ril/j6VSEZhf/POm/pZUw0awv9YdQFC73PLq4K513x8s2TAmgcS4eo4fIuFTgjEyvk6KLJvaVdpLPKWo3bFgQLBufIrojUXCwb44VoXLXM543oI8Z+O7YGyufM7NFgdzDYpo+jtFkrQ+TcK5aAkVHkyG/8dbw5rgKWH9mrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCuaTHsU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730109830; x=1761645830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fBo/M28zaE+Gi6IeMuAGUsuNyb5P4s2Gmpx5MaRTckQ=;
  b=GCuaTHsUYd3tpDZ1krZLrE+0VLKrc+23RdaVZ+qCWF+lj5gMy7fIUs77
   O9UPfiHEkrhSplMkp4CBBVvN7uexQF4xu8Zark+DnCiPJEmWm0u/t/npz
   rPcx43o84boVBfz3L9lTAOMFflQyHWkXa8896iAcwYe04yU4JN1c0AiDW
   Rs+lA/YdebadYgRy5LVD2LudxbBU4Ryo0SFS3+igfnG5oA3hyTdi20Lsu
   Em8FiePbgo2zbP1PDWK3i8ObBFaf5s8Ve3+xzG4PwJ7B2R26HnzJeaPNX
   RhM3y1WA+n8ChzuamiossZiue383j8KazOaTWarWcHd/2htc5wWS97g6m
   Q==;
X-CSE-ConnectionGUID: H49UK0sAR4aJa/iI2N8PrQ==
X-CSE-MsgGUID: aVguWJK1Ruy6YzAQfLtyig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29560716"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29560716"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 03:03:50 -0700
X-CSE-ConnectionGUID: EAYMqFncSUe/4av+nKzC/w==
X-CSE-MsgGUID: DckBn3HhTfy0zkauWCMpCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86182279"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa004.fm.intel.com with ESMTP; 28 Oct 2024 03:03:45 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM
Subject: [iwl-next v6 1/9] ice: count combined queues using Rx/Tx count
Date: Mon, 28 Oct 2024 11:03:33 +0100
Message-ID: <20241028100341.16631-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous implementation assumes that there is 1:1 matching between
vectors and queues. It isn't always true.

Get minimum value from Rx/Tx queues to determine combined queues number.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b552439fc1f9..c2f53946f1c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3818,8 +3818,7 @@ static u32 ice_get_combined_cnt(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, q_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
 
-		if (q_vector->rx.rx_ring && q_vector->tx.tx_ring)
-			combined++;
+		combined += min(q_vector->num_ring_tx, q_vector->num_ring_rx);
 	}
 
 	return combined;
-- 
2.42.0


