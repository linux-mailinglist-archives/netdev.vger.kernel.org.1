Return-Path: <netdev+bounces-141534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB559BB454
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DC51C21C10
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF831B6CF9;
	Mon,  4 Nov 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K57CU/8X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69F1B6CE8
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722427; cv=none; b=mF1IYcrvvbipebUd8+84WwmeFpdKDgsvRhReHaoUViLAYMkwO39YaRY4n/1nsC693nKsZFZauH8kstWP36PZXyfv3l2MXVSjbjQvZU33NYPoIRZ8fLTOVyffuzhIWFGn9UZNTTn+ZeUr5YrSuUjCGr1fOiZdFq80iNV9cYlBsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722427; c=relaxed/simple;
	bh=zlw6JJTyL7eFVV8Q68C41gOu/Qvl3bUUkm8lnRit7aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKgQUUnxVkf/+AgUVckIACT1GxDvoY+wFnPmGO7AlYOhmuxBHZ1JPxq7WaL+AQMz06L0wdaNUoy8PDAYd3pu9OHhJrVHhNuxB5T4aIRUAUIxMy7+AlzlHvuyuodBaAKRF4bU2nmLa4mlWJiJnqeifYBjFIsowJTDbe2BWNYGgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K57CU/8X; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730722426; x=1762258426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zlw6JJTyL7eFVV8Q68C41gOu/Qvl3bUUkm8lnRit7aA=;
  b=K57CU/8XExzXKSZIzUadnc6tN34D2g7khdbJeBpXNwTBC/0YBKBGM3oN
   uXP7H2Bx0unnXsou4GgOBJxlb8Z5hBRxS1M0Jbbqc2lZkNY2NFjWeG+Tx
   96xq4xTxJlh//VEInh4kzgFDiU90+cK16CKNWdequn1rryYa63i5kVU4B
   3pOwsGMfZbijuSWBHDQHd/E351r3FhVMwTBSlMv3FGRdWWOZOkAwmkgW9
   v9GXoybqB5WxwV6UiKKH4QcDq+f3gvrvtbH+A8EpLS9IgsshkGpGziPDp
   kVJSENgLzTi0+Q277j1g6B5nO+52ZuYpPZwo2b4TQazppkL5m2PAF2tpp
   Q==;
X-CSE-ConnectionGUID: x2zDcG5HRsSilwsqARknvQ==
X-CSE-MsgGUID: yyFSMr0rR6GIuZLWYgdziw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29843664"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="29843664"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 04:13:45 -0800
X-CSE-ConnectionGUID: 6C5qUKgqQlinVQe0RSieDA==
X-CSE-MsgGUID: NaBPZE3wSaCE6Ans75k+PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83525756"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2024 04:13:42 -0800
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
	mschmidt@redhat.com
Subject: [iwl-next v7 1/9] ice: count combined queues using Rx/Tx count
Date: Mon,  4 Nov 2024 13:13:29 +0100
Message-ID: <20241104121337.129287-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
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


