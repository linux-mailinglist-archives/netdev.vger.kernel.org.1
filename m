Return-Path: <netdev+bounces-165284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29738A3173A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4EE3A2AC2
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5F0264F91;
	Tue, 11 Feb 2025 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NlTA5AHN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC26264FA8
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308047; cv=none; b=ePp4ilRpu5rRgV8IfAFrwJjLaZh3WurKwxL8gCD+Ws3FWW/O+FlqC6+9INymJL3EgoXnyYv98XPkWc/1NUzHk3uxdlZAAHEDJFlRVLkRvh5K7PoFaV7DcCwF0Nbevo7gdYQQgNAEb2TBYVLHBkzbeS096GL7u/kluSc0avSHkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308047; c=relaxed/simple;
	bh=u7ZXvh3AZnI7NZucsGOvY2jvV+xhRphXyYjNuxXfBrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIjqSNNxH/hWp6vdRUxe+MOWBv8wC88pD6g/V++9xoDmXdBQxwU+vgCMwekBl0Wl1Tr/VFPBhlMqrtJDXsCCoA5R2A9TIe22315h/0f+2cZ6uNcZbNzaJSMBauK6XZWz2PZmiCuqgJVbGYFqzL5uZ6IA4EHREY1RA9vW06jDTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NlTA5AHN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739308045; x=1770844045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u7ZXvh3AZnI7NZucsGOvY2jvV+xhRphXyYjNuxXfBrw=;
  b=NlTA5AHNRFXG3j3zTVH4sIYZsteA28xDvO0QcWRH0x1QesWkNwLnhRt2
   vIcMcpaN08R4+6MKC/vH8QfX1Qc4JZrcCFpvt7WGhFKnA7Jyq1kMTbJtS
   9kKRBSzTrE3nq9+5alXvg9sWixkijwd7crAin1F5GZ49iSNbPnwhWFrJv
   SZ7m0pP2GRQRFLR10AaE1OaV1KmFgkLEm2DHeDlbLC0hK7GXZKo2Wf9Je
   LMsP2L9LpFzddRO2V7B969CQNWa7Pwo1PYhB5+vULOafm/oK/UuXh4Yxa
   3r59E0hGyU8APigsU7sBNtnEg7ZSUWgt1lEN4x+rkBUyO2ib8tw30e0gX
   w==;
X-CSE-ConnectionGUID: VNwHB1hLRkSpv/yVLofh8g==
X-CSE-MsgGUID: XqfLlN2VQGuFI53llsLRZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51339601"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="51339601"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:07:25 -0800
X-CSE-ConnectionGUID: dywcXyhHS92M+IZjIoEe3w==
X-CSE-MsgGUID: /mWha7aXSiCz6ZUr9kBFLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116713235"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.7])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:07:18 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	pavan.chebbi@broadcom.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v8 1/6] ice: clear NAPI's IRQ numbers in ice_vsi_clear_napi_queues()
Date: Tue, 11 Feb 2025 14:06:52 -0700
Message-ID: <20250211210657.428439-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211210657.428439-1-ahmed.zaki@intel.com>
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We set the NAPI's IRQ number in ice_vsi_set_napi_queues(). Clear the
NAPI's IRQ in ice_vsi_clear_napi_queues().

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 16c419809849..b2467dc17681 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2766,11 +2766,18 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
 {
 	struct net_device *netdev = vsi->netdev;
-	int q_idx;
+	int q_idx, v_idx;
 
 	if (!netdev)
 		return;
 
+	/* Clear the NAPI's interrupt number */
+	ice_for_each_q_vector(vsi, v_idx) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
+
+		netif_napi_set_irq(&q_vector->napi, -1);
+	}
+
 	ice_for_each_txq(vsi, q_idx)
 		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX, NULL);
 
-- 
2.43.0


