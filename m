Return-Path: <netdev+bounces-222592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54918B54F2A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C012E7AE35D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600E30F534;
	Fri, 12 Sep 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jS1orTbg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5139E30E0D3
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683038; cv=none; b=js7bDsstEqMS0vxj3Ktce47r/yFuFrTCQ7zEUWtTMM8B6ue4usAY7xieLaEpeSbvIxH1yTJ+57kRwWYMauPOos0cp2Rtb1k5loQc/c+LK8NZSFeTpbA5KNcTp/RuyO8svksfTLlRF2doqhGUF6iESs/JIAmjCP6XvnZbVXtc9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683038; c=relaxed/simple;
	bh=Lr7XMlR0GP6CoJuj+0JC3gYElxLwUxJ1ZEl66nOapwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISdBqSkxSUwiGDbxvKeIv7yVUa2HcfNBY2a6yR12d6JfF7LJ1fNaQoUxzExiAjZxp1CuUAMd4NWPMfJHUd4UkWyGp7OJwAC6S4HXhjPp5DUdIdXOT9FBElIWKlyV/oYmHf5ySF0k7gg9LUQDs/7WM6jJqTB6nTYbBWwqSaMorXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jS1orTbg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683036; x=1789219036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lr7XMlR0GP6CoJuj+0JC3gYElxLwUxJ1ZEl66nOapwQ=;
  b=jS1orTbgYLG06kzJDuvkviEKWwNb+1WEEzPuyp2BvC8iuDUvJly2APE8
   DfTnmXexcR2ijjg4Ol9ptT74U8jQP5yhY/s88gJvizl65vIT0qPznNLbq
   ODhqvm9rMGox0FE+0d/+zENah3S71U3tKSP3ak3PyxNnUixAh9o6Sl+TB
   zGiHEj7vd+M7GTEU6ilveJ6vdXdIHvTXKFEpkAztteTWX06w0b6HMI7Q5
   XfuzeWkQR8oNjxwpajYy6hQdViGNTtNNEM3/QnKhmCEiL2+8q+uAtHAwW
   CEEqjnpZsa/LsyyJ9rmRRrQ9uRAN5TChZj9KQZy29LUybKPeL5D/4PPoG
   g==;
X-CSE-ConnectionGUID: uBiVNLfxT7OsE5noRa4ALw==
X-CSE-MsgGUID: ohpKn4/CTNWDzwJNJ0itlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461412"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461412"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:14 -0700
X-CSE-ConnectionGUID: HkeroFooSneFXg37GH6fcg==
X-CSE-MsgGUID: yc6VqzHJRYWqD0jbSxOKJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131218"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:12 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 912832FC71;
	Fri, 12 Sep 2025 14:17:10 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH iwl-next 3/9] ice: move ice_init_interrupt_scheme() prior ice_init_pf()
Date: Fri, 12 Sep 2025 15:06:21 +0200
Message-Id: <20250912130627.5015-4-przemyslaw.kitszel@intel.com>
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

Move ice_init_interrupt_scheme() prior ice_init_pf().
To enable the move ice_set_pf_caps() was moved out from ice_init_pf()
to the caller (ice_init_dev()), and placed prior to the irq scheme init.

The move makes deinit order of ice_deinit_dev() and failure-path of
ice_init_pf() match (at least in terms of not calling
ice_clear_interrupt_scheme() and ice_deinit_pf() in opposite ways).

The new order aligns with findings made by Jakub Buchocki in
the commit 24b454bc354a ("ice: Fix ice module unload").

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
CC: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 25 ++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 53a535c76bd3..3cf79afff1bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4062,8 +4062,6 @@ void ice_start_service_task(struct ice_pf *pf)
  */
 static int ice_init_pf(struct ice_pf *pf)
 {
-	ice_set_pf_caps(pf);
-
 	mutex_init(&pf->sw_mutex);
 	mutex_init(&pf->tc_mutex);
 	mutex_init(&pf->adev_mutex);
@@ -4769,11 +4767,18 @@ int ice_init_dev(struct ice_pf *pf)
 		ice_set_safe_mode_caps(hw);
 	}
 
+	ice_set_pf_caps(pf);
+	err = ice_init_interrupt_scheme(pf);
+	if (err) {
+		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
+		return -EIO;
+	}
+
 	ice_start_service_task(pf);
 	err = ice_init_pf(pf);
 	if (err) {
 		dev_err(dev, "ice_init_pf failed: %d\n", err);
-		return err;
+		goto unroll_irq_scheme_init;
 	}
 
 	pf->hw.udp_tunnel_nic.set_port = ice_udp_tunnel_set_port;
@@ -4791,32 +4796,24 @@ int ice_init_dev(struct ice_pf *pf)
 		pf->hw.udp_tunnel_nic.tables[1].tunnel_types =
 			UDP_TUNNEL_TYPE_GENEVE;
 	}
-
-	err = ice_init_interrupt_scheme(pf);
-	if (err) {
-		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
-		err = -EIO;
-		goto unroll_pf_init;
-	}
-
 	/* In case of MSIX we are going to setup the misc vector right here
 	 * to handle admin queue events etc. In case of legacy and MSI
 	 * the misc functionality and queue processing is combined in
 	 * the same vector and that gets setup at open.
 	 */
 	err = ice_req_irq_msix_misc(pf);
 	if (err) {
 		dev_err(dev, "setup of misc vector failed: %d\n", err);
-		goto unroll_irq_scheme_init;
+		goto unroll_pf_init;
 	}
 
 	return 0;
 
-unroll_irq_scheme_init:
-	ice_clear_interrupt_scheme(pf);
 unroll_pf_init:
 	ice_deinit_pf(pf);
+unroll_irq_scheme_init:
 	ice_service_task_stop(pf);
+	ice_clear_interrupt_scheme(pf);
 	return err;
 }
 
-- 
2.39.3


