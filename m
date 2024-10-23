Return-Path: <netdev+bounces-138069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FD9ABBAC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2571F21FAC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9A678C90;
	Wed, 23 Oct 2024 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDLOkCZe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A852F88
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651197; cv=none; b=DiujUE9Z+uVwJOabfv/UYoFPd1FgCHzsq8T7xCs+PLfvvY03jlnMul3TjEIDqoMeVMNvZ5UCiD4ywECLPvLIl2n1w3iY3WXF39Cz+akB281iU6MSlNaj9hlG8GOsQcWndHYGmYisIZhmuHg8wx/hyLHZsOvz9lN0X8ydozl/WPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651197; c=relaxed/simple;
	bh=YW8OJ6ncs4oJPqe5fuxKSZeeTTvjkAOWYEUbEfU4uus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agiSyRmsmrC51be458Ok1xeUll/AV2Ct6+sV4dAIBPTUdbsnD7ylh1QPzyrkMYr3hH09xCvf0hW2N51D7WBaeL2rCx7YujR2bLumGKWYwSVy/ac/GyjtFnqup/zCvoSOCFi4fkHP58SemKiNYs24G3ZB97wvPqu9rjJH306Bers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDLOkCZe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729651196; x=1761187196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YW8OJ6ncs4oJPqe5fuxKSZeeTTvjkAOWYEUbEfU4uus=;
  b=IDLOkCZeQOnnamarD/njjFLv9CJ3NYjYiFBTildGRJtrn30L1Xe4ivgt
   NXHFjiNrzc3N3bKAU8OkzTrRWVA/Fl1RCHdc5CFHSc6N5Or7dhgBnA8bk
   BS29p27SvsoD/Dtg6mUkiUipZ4P4eSajUhVfywjn9ea2mh43akwa1sdLJ
   c53+ldRcTClUYFzqCRIwjcgk8PDGZyK9dNTmitL4/++8SB8FED7eGlBTa
   8aFB2wP5vGVV1LHsVNNFl76R2tQhJEBh2imKZoZK80qavoxXX/jODwOA0
   uzcNiK3Ov4o4X2PJFzN98ZSRX4tf/G/jF6ZloMtburRLZ+16v6zy8ZFQZ
   A==;
X-CSE-ConnectionGUID: 7VQQ/jGNT/uvNjlZetCIgQ==
X-CSE-MsgGUID: hQBm3KJmRGOsTRQKtNGLDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32918042"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32918042"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:39:54 -0700
X-CSE-ConnectionGUID: iPrtyChSRcmLX7EU6P0mZA==
X-CSE-MsgGUID: UaHbyb1PSDeyGn7gyWiWww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80396828"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by fmviesa010.fm.intel.com with ESMTP; 22 Oct 2024 19:39:53 -0700
From: Chris H <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com,
	Christopher S M Hall <christopher.s.hall@intel.com>
Subject: [PATCH iwl-net v2 3/4] igc: Move ktime snapshot into PTM retry loop
Date: Wed, 23 Oct 2024 02:30:39 +0000
Message-Id: <20241023023040.111429-4-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023023040.111429-1-christopher.s.hall@intel.com>
References: <20241023023040.111429-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

Move ktime_get_snapshot() into the loop. If a retry does occur, a more
recent snapshot will result in a more accurate cross-timestamp.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 00cc80d8d164..fb885fcaa97c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1011,16 +1011,16 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 	int err, count = 100;
 	ktime_t t1, t2_curr;
 
-	/* Get a snapshot of system clocks to use as historic value. */
-	ktime_get_snapshot(&adapter->snapshot);
-
+	/* Doing this in a loop because in the event of a
+	 * badly timed (ha!) system clock adjustment, we may
+	 * get PTM errors from the PCI root, but these errors
+	 * are transitory. Repeating the process returns valid
+	 * data eventually.
+	 */
 	do {
-		/* Doing this in a loop because in the event of a
-		 * badly timed (ha!) system clock adjustment, we may
-		 * get PTM errors from the PCI root, but these errors
-		 * are transitory. Repeating the process returns valid
-		 * data eventually.
-		 */
+		/* Get a snapshot of system clocks to use as historic value. */
+		ktime_get_snapshot(&adapter->snapshot);
+
 		igc_ptm_trigger(hw);
 
 		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
-- 
2.34.1


