Return-Path: <netdev+bounces-254019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECJnKqU8eWlSwAEAu9opvQ
	(envelope-from <netdev+bounces-254019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:31:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7DD9B11E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DEAD3015863
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EBE2D879F;
	Tue, 27 Jan 2026 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1cSGBaA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340425EF9C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553056; cv=none; b=URr/9dbQnUzN94wFiQlgjhNdieV4GayKC/LQ7uhhA/ZbGrRLOR5FUPor9tkTkixv3Kwm7Dxp5g8ANV6xZX/R6rw7XYv/3Anf6O/PVbd93fx+PZ3akkL9L6XipzyxV5YNVeFrtq6Xm2HXf4oSAEtfEU4/eZiESE8ltf0xoTewS2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553056; c=relaxed/simple;
	bh=pIaiYVtMxB3Adkzpqen5IKIHH83OJOeVyW++IQGLumo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6ycTpy+v1ZUMNh/E0s+I7DOeurIQ2i7WOYmKocWVATfvZSzmaTX3VvILtjZRodkvwjMTnZRk3dyjstUk/1rs7xNZVxcuMj8Wxn8Q10K/F7LsqbApoSMZ+WbER7aRt0I9YVdSiDYNELj1nc9gyjzuaHrHgstkPJ71qT9b57mTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1cSGBaA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769553056; x=1801089056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pIaiYVtMxB3Adkzpqen5IKIHH83OJOeVyW++IQGLumo=;
  b=l1cSGBaAO/CNj643T1Ik0gMryZt7wsbri260VFk7PW+i65doH92ME5pE
   y0oNYPQGdFl8nzsgZLZ30NdFIs6f1x7SIVzqR/JElP8wqM0yHhvHAagT5
   JssaT9aDaI/n8fCgme83PbZFNkolc7IaLI0CDUWkMkqIZpL/zGJY2A28w
   MebR4nJ7jmIgjyLcgEWk4JNM1kT7Bf8J/r8hPjZKntNnRb5vFQfxvnpkX
   mE87dvIaWDrdlmQse8lWOYjVBHSuFmvmZARsDp9Dp86z7tQVabZh1CLBD
   EBtF/TlXvs/EoZyroKUtCr29lZiQff/2R0hQbsZkqb4dQsftmDnCtkk0x
   w==;
X-CSE-ConnectionGUID: BYzCV4FuScCkAYT73eWAhw==
X-CSE-MsgGUID: pa2k/2AZTMuUBiiLK/gMbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93418597"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="93418597"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:30:54 -0800
X-CSE-ConnectionGUID: IXqiJTDNSca1wY603nK2QA==
X-CSE-MsgGUID: gF5AivCxTb+Sk1GDCaJT4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="245714641"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2026 14:30:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <enjuk@amazon.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	jedrzej.jagielski@intel.com,
	horms@kernel.org,
	kohei@enjuk.org
Subject: [PATCH net 2/4] ixgbe: don't initialize aci lock in ixgbe_recovery_probe()
Date: Tue, 27 Jan 2026 14:30:43 -0800
Message-ID: <20260127223047.3979404-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
References: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254019-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D7DD9B11E
X-Rspamd-Action: no action

From: Kohei Enju <enjuk@amazon.com>

hw->aci.lock is already initialized in ixgbe_sw_init(), so
ixgbe_recovery_probe() doesn't need to initialize the lock. This
function is also not responsible for destroying the lock on failures.

Additionally, change the name of label in accordance with this change.

Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode")
Reported-by: Simon Horman <horms@kernel.org>
Closes: https://lore.kernel.org/intel-wired-lan/aTcFhoH-z2btEKT-@horms.kernel.org/
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a69b5a8a91cb..c58051e4350b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11476,10 +11476,9 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 		return err;
 
 	ixgbe_get_hw_control(adapter);
-	mutex_init(&hw->aci.lock);
 	err = ixgbe_get_flash_data(&adapter->hw);
 	if (err)
-		goto shutdown_aci;
+		goto err_release_hw_control;
 
 	timer_setup(&adapter->service_timer, ixgbe_service_timer, 0);
 	INIT_WORK(&adapter->service_task, ixgbe_recovery_service_task);
@@ -11502,8 +11501,7 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 	devl_unlock(adapter->devlink);
 
 	return 0;
-shutdown_aci:
-	mutex_destroy(&adapter->hw.aci.lock);
+err_release_hw_control:
 	ixgbe_release_hw_control(adapter);
 	return err;
 }
-- 
2.47.1


