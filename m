Return-Path: <netdev+bounces-116620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44A94B336
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 00:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BF11F22405
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A73155A57;
	Wed,  7 Aug 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd/WW+eJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20526D1B4
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070730; cv=none; b=oMhPGR8OrR5P4xb6xi/Rzb7XCx0yj1pK3E6HlIGhiAbLmkKF7yxmcA+K/U9fGYh5Ui+W+wPL2ntJli1xT/RWQHGXcYJgXnbyivA4AszvTUCbkezFqkntFVP5kCVFszU0US6hyRNo28fk0R1K1i37S30TERbdfNwoDekQNrblIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070730; c=relaxed/simple;
	bh=6ZK86bRiFrZmTFnriLaSueGHXM2tQ42j3OAX4JBwcQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDqSSR2OTxaCz/N6OzhYNDWeJsyHxLaFOTz2N5751eWxDB/6n1J9KS8uatbnfUOSHzmlknyeiaoyLFZmJWk2XklK/Eq2SeiD3Tl2tX5vaV46PVw9j6KTxX/0VCZMieQdSfmXfbG2eSOk7BHKT8owVenkwn2sbAf2cJYiggO9zdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd/WW+eJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723070729; x=1754606729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ZK86bRiFrZmTFnriLaSueGHXM2tQ42j3OAX4JBwcQY=;
  b=Cd/WW+eJALzU2i/vxfNWpeUta5gOuU+RAZWCjmjoJS6RfuIM6/Ka4YQA
   eKsRpdsbLVAfP9sQJkyYYfqTyd3amBmiBPqbvCs7roG3pQOTQM2UIzY40
   N4gFhZuT1MR3JkvANQQ0W0y9dDYJxUw5iXpSVWNFVkbYn8pu8OcSNu4nB
   2THhz3LiK001IgoxMNTU3zYrTodKuGEJ2OkAoDU5dW1d8LrMvEh11x9Iu
   mJbWcxgkSE8IuVx8BHaFySbY0MPaQT3ncSvq5tWU7yUYoWsXiaHZgtZAf
   78LNVLOghuyqYHSM6062M3/7wRnKc1Oa0GhCrLHn1C35MMoL/An7QeZzq
   w==;
X-CSE-ConnectionGUID: RLWtpDpzRdqNsvd6JkKpPA==
X-CSE-MsgGUID: FGI0AjP0Q5KgPhZkx226yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32573961"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32573961"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 15:45:28 -0700
X-CSE-ConnectionGUID: JRG9iN8OQTeDM4Y6fWfVZw==
X-CSE-MsgGUID: OenSlLI+TYWzFZYxoo53XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57088289"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 07 Aug 2024 15:45:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/3] ice: Fix reset handler
Date: Wed,  7 Aug 2024 15:45:18 -0700
Message-ID: <20240807224521.3819189-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807224521.3819189-1-anthony.l.nguyen@intel.com>
References: <20240807224521.3819189-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Synchronize OICR IRQ when preparing for reset to avoid potential
race conditions between the reset procedure and OICR

Fixes: 4aad5335969f ("ice: add individual interrupt allocation")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3de020020bc4..6f97ed471fe9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -559,6 +559,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (test_bit(ICE_PREPARED_FOR_RESET, pf->state))
 		return;
 
+	synchronize_irq(pf->oicr_irq.virq);
+
 	ice_unplug_aux_dev(pf);
 
 	/* Notify VFs of impending reset */
-- 
2.42.0


