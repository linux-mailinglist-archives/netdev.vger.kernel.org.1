Return-Path: <netdev+bounces-129068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41097D4F6
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAA91C21A75
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AE0149DFD;
	Fri, 20 Sep 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTXz/KO0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF8144D15
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833144; cv=none; b=f11ILmpSzAxaLOqr2WSX43K9TtWWZ+QffDIHe/2gcQ1/j1i//AqutZcoKA1ozPSTqw2yKglnlZZm1Y7LE3kQ58Bwd1Ng4ZddUUh/XNnTV1aQ7ACskOmAs9Cb94mOkVJ3TBj6ekvRtoJmIdSVtZx4Ea8QjKM/iSW+QR45jlb3Tmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833144; c=relaxed/simple;
	bh=hhBq2op7M4PcDdmTGfhYbmO8pVY6PQOWvLVVBKnWkcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VflNkngI6sp5tglm5h3rDoMfGO0kPW88z6hCZtTfzowdENtrVC8iNZuaYtkzhMS38cU1O0sC9/Yl1TyEx8SXdU8im1CLSnfiYMPbbXUSpSYDCGxLmi8/qO6YFnX6/40ncu2Rxq8w0TbJ3FOFQTfir0mLlYtXXCCpuqo6PZksnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTXz/KO0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726833143; x=1758369143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hhBq2op7M4PcDdmTGfhYbmO8pVY6PQOWvLVVBKnWkcg=;
  b=UTXz/KO0sW6yAgOi+zbf3LHwn9WORsxW5OhBuo3hZNDH8TggnpaHAsSl
   245NlKuR6cFSuXtvMqjQQrL630RUoaEP/ggtpMk/NtIOrQWS1KlpnzX/W
   5H39HRWul6WACbMctIda6tuh6Dn8yoMDWSsz7vFWyQTpjsfOxPavbNRAY
   PvDUlqZZY1ReBhqPVbwXPbYxMcGwjzCkJuUS0/IHZSdJGp+XRH2PL4ovr
   IW6uYkQsque3Gi7nf5lT6qa9benjIx4jJN7/4ZS0pGLpbmnWtHbwy5jkD
   9zgzPEc+43en3CHJka50Qp5ZFOYe83YcNP3wSkKLBW5T+in+1YdvW4c4H
   w==;
X-CSE-ConnectionGUID: JNKOxgHESkW4bBMDjhEQ7Q==
X-CSE-MsgGUID: gzWPixQBQ3Sfyqk4J2a5Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25708349"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25708349"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 04:52:22 -0700
X-CSE-ConnectionGUID: I2l/uRqHRgOfH/SRtb7aIA==
X-CSE-MsgGUID: wXAL8tOCTTewEBUKnv5AaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75046034"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 20 Sep 2024 04:52:19 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 90F1A27BC1;
	Fri, 20 Sep 2024 12:52:18 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	mateusz.polchlopek@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 2/2] ice: Fix netif_is_ice() in Safe Mode
Date: Fri, 20 Sep 2024 13:55:10 +0200
Message-ID: <20240920115508.3168-4-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240920115508.3168-3-marcin.szycik@linux.intel.com>
References: <20240920115508.3168-3-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netif_is_ice() works by checking the pointer to netdev ops. However, it
only checks for the default ice_netdev_ops, not ice_netdev_safe_mode_ops,
so in Safe Mode it always returns false, which is unintuitive. While it
doesn't look like netif_is_ice() is currently being called anywhere in Safe
Mode, this could change and potentially lead to unexpected behaviour.

Fixes: df006dd4b1dc ("ice: Add initial support framework for LAG")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7b6725d652e1..b58ef3e69f9c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -87,7 +87,8 @@ ice_indr_setup_tc_cb(struct net_device *netdev, struct Qdisc *sch,
 
 bool netif_is_ice(const struct net_device *dev)
 {
-	return dev && (dev->netdev_ops == &ice_netdev_ops);
+	return dev && (dev->netdev_ops == &ice_netdev_ops ||
+		       dev->netdev_ops == &ice_netdev_safe_mode_ops);
 }
 
 /**
-- 
2.45.0


