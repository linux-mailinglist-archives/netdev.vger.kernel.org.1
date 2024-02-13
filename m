Return-Path: <netdev+bounces-71127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA538526D5
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D5B1F25937
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804AF79DD3;
	Tue, 13 Feb 2024 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/sduY49"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CC26AD4
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786366; cv=none; b=ImXnqCaHiQ9kh/xkZ4r7SEFg0OCVNGaIQwYfzCDNQGBFvDDc+g/a2tas996jmy1O7KAJYXcsNRWLQUBPxcTZMH/jp5Bp+Y7UcSjH+Lj9njeFUNt0gh0w5VWu96zxLCKrFxRdrXrvuSfPBRVQYXHt+QiaeL2huEWXzEtaL/1DypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786366; c=relaxed/simple;
	bh=3RP0i3T+5ujjx2GFwHJ6H/Rz9raFZzUxhOvBuEe1SfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VthNC5gIPK6yntgmtk8bCN88/YzGjQ2FxGc4XW/+0IHpIE3xomGIoa8FkLcMDKook+3U0eeYZ7o8VgJon2WO9f8UccI/cRs0pkHMe3DwpSN9wuz5K37bem4MhFTG7EAvRjiWokviuLEO7c/OQJLe1xkJepZpzJW+VBHOLTrptE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/sduY49; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707786363; x=1739322363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3RP0i3T+5ujjx2GFwHJ6H/Rz9raFZzUxhOvBuEe1SfQ=;
  b=W/sduY49omf3AuvC2DIdjohletVGnH4eUX9/Eil9rJ4ODyK/1716VirF
   NbeC8w+oNKzfzEDg0lnIcjeVz03NJPkBa+G4szXScoC0vJXJ4XslcyeYx
   PRPEj+3LVcg8vUMyLmUhEQbkyFFsdY4TRsKRayHYcmsnurZaJwBIvE+H3
   V5xLEKhT5gOcLQS0dhCLuRogrSZK7d6xMSKBi2Wso74kfV+Wg6nzkkmGS
   Vd9otHqJ3OlyTGASRtudqNo4I4aJ6DxqcSgwnk/GJ/tDo7GlQ13RMNBP6
   y60fin5ZFv0vTDWsbWqIRyiWYTRlX5CQFW7uWr6BMHRouMTnpIP1lD10U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436927653"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436927653"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:05:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911651332"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="911651332"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 12 Feb 2024 17:05:42 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/4] i40e: Fix waiting for queues of all VSIs to be disabled
Date: Mon, 12 Feb 2024 17:05:36 -0800
Message-ID: <20240213010540.1085039-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
References: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

The function i40e_pf_wait_queues_disabled() iterates all PF's VSIs
up to 'pf->hw.func_caps.num_vsis' but this is incorrect because
the real number of VSIs can be up to 'pf->num_alloc_vsi' that
can be higher. Fix this loop.

Fixes: 69129dc39fac ("i40e: Modify Tx disable wait flow in case of DCB reconfiguration")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6e7fd473abfd..7a416e923b36 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5360,7 +5360,7 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
 {
 	int v, ret = 0;
 
-	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
+	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v]) {
 			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
 			if (ret)
-- 
2.41.0


