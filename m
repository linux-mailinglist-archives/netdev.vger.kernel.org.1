Return-Path: <netdev+bounces-222598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C535B54F33
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B4E5A29E0
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD83115A0;
	Fri, 12 Sep 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYYju7tZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34D30FC08
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683041; cv=none; b=qK92eYA7wV0CFrlQQlWfNaJgqiLvUlNaK/zjZQ/6xwVQDrVn+4U3vvc4VDr1jjk7l5SCKnKDG2Ei7aE8Bjwz09mhb+vZu+Q4/2SxSIUaVYXDOw+CyTxbP1JlBH47U+LfG5rLyS3cll2miIqDh/Zxszs2s6g0EAa5cxp3OrCl2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683041; c=relaxed/simple;
	bh=0lubkKvXUTXLnSw8A50MURKszPTJ4IuA01qIWQQ67bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SqcQAN9T0bxcZKpouXrw+XcwBQbRtzUfbFyAPtnwNKr87QFAwlaetzcTw1dlAo7kXA5ZX8MgqwMy0+ghq3mAEkvlR2MGh+q9bBqG7R3de/+OakCKz3taqEzj4O1ljvgCzKYBVUn9Geiz9LeVk9KGn0zI5cBtDXyMtg1R3iWzmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYYju7tZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757683040; x=1789219040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0lubkKvXUTXLnSw8A50MURKszPTJ4IuA01qIWQQ67bw=;
  b=WYYju7tZdWC0bBgVhpkb8vS5Htl6xfNCpaizJWIxIT9XF7Ce2ZgRZxBy
   DBLTAeW2cow3Ib7owtefvmm7w6DxdZkiF6da9rN3SlNm1fjSWN+53fcDF
   VU9qrP8UqbWc7nE34VdppdZTGmOL8/5K5ltuCRMoKhDnc3spBCsRqi5U6
   KgRAgcRpn0Y2YjFz9AshJWhBDlZDel8uYPibd+r/W8yMrU89395a509lt
   jPdS8AfZ/ZvDZCaMljbCMxQQFKoZeDgNTe1HabOJwqRhhpOQfu/ukR4yi
   3YCwAASpUr96FSDtprEl3XkWYryL+cuPHfYBzWPq6CKrVuSzURNQ7ZQF9
   g==;
X-CSE-ConnectionGUID: OUGsfynaR4WLZImtsbHpWA==
X-CSE-MsgGUID: I0MUj9c/TIapbcBD0ZAymA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="85461445"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="85461445"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 06:17:18 -0700
X-CSE-ConnectionGUID: ZI6MQcVeSVq/gzDwBhapww==
X-CSE-MsgGUID: AZYbj3sgQE+bbxvvwjG7rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173131240"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 06:17:16 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A08EE2FC71;
	Fri, 12 Sep 2025 14:17:14 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 9/9] ice: remove duplicate call to ice_deinit_hw() on error paths
Date: Fri, 12 Sep 2025 15:06:27 +0200
Message-Id: <20250912130627.5015-10-przemyslaw.kitszel@intel.com>
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

Current unwinding code on error paths of ice_devlink_reinit_up() and
ice_probe() have manual call to ice_deinit_hw() (which is good, as there
is also manual call to ice_hw_init() there), which is then duplicated
(and was prior current series) in ice_deinit_dev().

Fix the above by removing ice_deinit_hw() from ice_deinit_dev().
Add a (now missing) call in ice_remove().

Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20250717-jk-ddp-safe-mode-issue-v1-1-e113b2baed79@intel.com
Fixes: 4d3f59bfa2cd ("ice: split ice_init_hw() out from ice_init_dev()")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
This series obsoletes patch by Jake Link:ed above; already removed from our
dev-queue
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c169134beb04..6b197d44f56d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4815,7 +4815,6 @@ int ice_init_dev(struct ice_pf *pf)
 
 void ice_deinit_dev(struct ice_pf *pf)
 {
-	ice_deinit_hw(&pf->hw);
 	ice_service_task_stop(pf);
 
 	/* Service task is already stopped, so call reset directly. */
@@ -5497,6 +5496,7 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_set_wake(pf);
 
 	ice_adapter_put(pdev);
+	ice_deinit_hw(&pf->hw);
 
 	ice_deinit_dev(pf);
 	ice_aq_cancel_waiting_tasks(pf);
-- 
2.39.3


