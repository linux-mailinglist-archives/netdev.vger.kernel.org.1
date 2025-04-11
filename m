Return-Path: <netdev+bounces-181700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DEFA86338
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8995C1BA7026
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D15621E0BE;
	Fri, 11 Apr 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2KCUxFU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296421CC52
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388953; cv=none; b=NuDu8S6+LVqmQ4f/FjvNa60SpKqyZyQRUT9dq0iq1TF44aRxfU0v8IG9n5CfgFhmf2DWrseFFwx7KRLj5H+xjaSWZ762IvukWaSoXlZg1WGSCutZUY604p/SQqEeZAWpi+PZBWFBhdrxxpJ0TXomO/lYTBiYA1E6aLEI/ZQaMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388953; c=relaxed/simple;
	bh=b2qhkylz2UAnpUopbygdxStxWz8/lDYwmgSavBXREvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1wLGoCtfqa7/Sp4EXHcqfnto4twLrXZRJyUIt92xO2kNfTdCKzVmdE6ifRX8pEpsqOfvKvPLjDdOatvq4eg1lbxWRDchT7oJggCaUKqZ229TVR5v6hmfVGFI3cjWhXIBN30gkggLlKoJuEqS0i4vZXbg/qn1mGB007h4WCh254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2KCUxFU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744388952; x=1775924952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b2qhkylz2UAnpUopbygdxStxWz8/lDYwmgSavBXREvg=;
  b=S2KCUxFUPLytilUO8a4OlxgDvr5lKotbRLFJKOiVVa8AqQJR6aoZkKCO
   SeSr6Er9GP1MmZGWE6GUgLDvFdQF69urlsPY2qSrZi6el1yAkUDka947y
   MLp0ikpznE25E2NwCdp6rkF5+zJvlxVJwyebXRDk4BPcUY6DqXQOCSOVg
   jTgkOFVG14/Cp+SnR6/N9MKA5XfB+YzCbU9a1ITjHYqSOrS6qXIx4sh4d
   bC2KDTTPCMB7eaJTTmbHVwQZSTWfeGsTewY290kc814PXALgh6w0CTu82
   /tmBpw4KdGF8HiItErAM0MYckL6oiGm4720oi3/dBl/Wl0oHv1zNS41bH
   g==;
X-CSE-ConnectionGUID: JF13/lGwRvaIEMH78tUnVQ==
X-CSE-MsgGUID: R0P0vXxzSv+BxjEWqKKd4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56610973"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56610973"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 09:29:10 -0700
X-CSE-ConnectionGUID: le5ftMdkQWe2HFwOq6XBSw==
X-CSE-MsgGUID: 6aaOWtPuSDegQN924BqF+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="133343146"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 11 Apr 2025 09:29:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Christopher S M Hall <christopher.s.hall@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	michal.swiatkowski@linux.intel.com,
	richardcochran@gmail.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 5/6] igc: cleanup PTP module if probe fails
Date: Fri, 11 Apr 2025 09:28:54 -0700
Message-ID: <20250411162857.2754883-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
References: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

Make sure that the PTP module is cleaned up if the igc_probe() fails by
calling igc_ptp_stop() on exit.

Fixes: d89f88419f99 ("igc: Add skeletal frame for Intel(R) 2.5G Ethernet Controller support")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f1330379e6bb..b1669d7cf435 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7231,6 +7231,7 @@ static int igc_probe(struct pci_dev *pdev,
 
 err_register:
 	igc_release_hw_control(adapter);
+	igc_ptp_stop(adapter);
 err_eeprom:
 	if (!igc_check_reset_block(hw))
 		igc_reset_phy(hw);
-- 
2.47.1


