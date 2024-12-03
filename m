Return-Path: <netdev+bounces-148347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F6C9E13A0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372A42829C4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 06:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A791898EA;
	Tue,  3 Dec 2024 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIL3f0h7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309B189520
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733209107; cv=none; b=Gd50A/Y+DrYkVn864dfH460IYYyAXQTg1dnqHTtxtsK91869/rlL/OfH+AXG7Fhj+HCNm5mUfy1LWr2AaHtSloPjl/BYjbuvXB9nxEonSoCNSq3v9mgCz2SAVdwg63356cZdfRtud5MHa76SHf2i00tKRDV8pmwITGhY3BxcYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733209107; c=relaxed/simple;
	bh=kUYnqLnamd/0s815hFdGqpO272z6ZiKc/d0xfk27it4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhLJh1upNuCtCd5nT7ifUcyGtl39oRV/HCyMr3OMdEic6Auef+havO73xrdArBYGSJTKT/dBQ90BrasA9UGbk2UrRTeu8rTDOww0puA025ZWJfRxmXz656DsG7dEzOqOyFmdfQpgmVsoi6naq6Y0qkEKSIgTF9n6c/QugHn4tT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIL3f0h7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733209106; x=1764745106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kUYnqLnamd/0s815hFdGqpO272z6ZiKc/d0xfk27it4=;
  b=EIL3f0h7kliw+ESK3/hWKOYyLkJ4mz8l+2jFguCH+XFA04ymj5MORyjF
   iC59gjzQA0gVTlTZQVPQ/A5HGh45FCUdfyWA0t3nhMUoczR9ZhT5n1CvC
   fGxO35qr4ikvJMB3wJPyv2skwJUfj0W4gshqwrynXmGYDPfmD0PLKU5DP
   Sy5xxX6mzj3DzCAhLFLQ2GHGNbac/4dS/MjlkUgFTahV575zkblFCLq98
   lrrJBYYHh/O2vTizJp5/i2M4TT1DWJ/mwXd74kO2p/NS0jXjGWGukCAVU
   7YyBBik3iE+aDe9bt/7Aa01YoTa2c6p75HYnYy+2khXQzjOF1jjIPN+Dw
   w==;
X-CSE-ConnectionGUID: 61AIFRZhTP29veeBAjWcNQ==
X-CSE-MsgGUID: Eeh4bDCESzWjX7YoCNAldw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33330467"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33330467"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 22:58:26 -0800
X-CSE-ConnectionGUID: IztY6tBRTEGf5kFWe6+OMQ==
X-CSE-MsgGUID: 1xDIO8pCQ9u2o+Z3x3m9UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93673690"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa010.fm.intel.com with ESMTP; 02 Dec 2024 22:58:22 -0800
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
	David.Laight@ACULAB.COM,
	pmenzel@molgen.mpg.de,
	mschmidt@redhat.com,
	himasekharx.reddy.pucha@intel.com,
	rafal.romanowski@intel.com
Subject: [iwl-next v9 1/9] ice: count combined queues using Rx/Tx count
Date: Tue,  3 Dec 2024 07:58:09 +0100
Message-ID: <20241203065817.13475-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
References: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
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

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
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


