Return-Path: <netdev+bounces-79639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8FA87A54D
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBC61C20A23
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D9381D5;
	Wed, 13 Mar 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWKpzBLc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87843B290
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323629; cv=none; b=awvHWwoYPfwb+A+furpl/nZlU2ZuTHE9Ymqb1KdrO+sguiu9cyPDEbEWynqE18iCTXDCs0SemcUReKj66FZRM5hg+hUrdY6APEaVoH0Kymx5F8ur2StaFZmtRWS0lvdkzc9lLnhsX4ozxHfZ4Vn4UVI5UMuhymRXGWUV08U/D7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323629; c=relaxed/simple;
	bh=D41juIXOltkpONDHTD2P7Kls/c+v9rfD6GhwLQ8TCqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfgDgybtq2huEw4CF8yyC489YcJGR4xO3OOrcSHvwhVsMuq8evZ6xPdSkGWOHYiwXBSul3pP44dpQH3imrLOyeBaZIOibvQBTBiT/71aJQFkuoHpO0JwhusGOcxgS1mb0LpHReez4tqnoD8j43xH6MFQVi/Ygmllpgo88SLolGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWKpzBLc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710323628; x=1741859628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D41juIXOltkpONDHTD2P7Kls/c+v9rfD6GhwLQ8TCqo=;
  b=ZWKpzBLcPgG23VlWzNfjkOx0q9P81kk+v9+PmtwEMUkjfC9NzBa0zMtB
   B3zMrIAXifo/8y03JoTyFA6oNLX4jVustxM3D8HmrSfq1rATIeYVC1770
   MDUWo6qPN7gbCIOp8X1Kpc0OUGX+IL/BsHV7V1W1/hQhRc1/ovcX0DaM6
   /mm1zE40lwRZVFMoQ+0o2i4a/2HACsGFevSdUck4MsCzDW7hp57syF49D
   Q/NWV/qXrzInWPuYZ3cGL8IAiGHaKLyXSqReVnxcJlaZElttnS0GhNU0n
   SX79BxYm0SsdA0ASJ+LIZbls2nJBlk9gBbMAkuTbERZmGZFG4odqyiHyK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5201295"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5201295"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16436978"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa003.fm.intel.com with ESMTP; 13 Mar 2024 02:53:46 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net v2] i40e: fix i40e_count_filters() to count only active/new filters
Date: Wed, 13 Mar 2024 10:44:00 +0100
Message-Id: <20240313094400.6485-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug usually affects untrusted VFs, because they are limited to 18MACs,
it affects them badly, not letting to create MAC all filters.
Not stable to reproduce, it happens when VF user creates MAC filters
when other MACVLAN operations are happened in parallel.
But consequence is that VF can't receive desired traffic.

Fix counter to be bumped only for new or active filters.

Fixes: 621650cabee5 ("i40e: Refactoring VF MAC filters counting to make more reliable")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v1 -> v2: add explanation about the bug
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 89a3401..6010a49 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1257,8 +1257,11 @@ int i40e_count_filters(struct i40e_vsi *vsi)
 	int bkt;
 	int cnt = 0;
 
-	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
-		++cnt;
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
+		if (f->state == I40E_FILTER_NEW ||
+		    f->state == I40E_FILTER_ACTIVE)
+			++cnt;
+	}
 
 	return cnt;
 }
-- 
2.25.1


