Return-Path: <netdev+bounces-77638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566C87271C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B465928B310
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FD5BAE6;
	Tue,  5 Mar 2024 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQZ+hJLi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A524215
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665069; cv=none; b=X8kn8EF9mC4ILhJvVPNSZ1UZzuOAwcGofIwKQHx38gLWG31dLLscuByw6ZSk7By9pf+IKWYCi4MpV7QusA6nfm1qKeYeP2jSxEfaNNxktpd3SHf8TT9m5MgUjkLaTf1IDtfH+Iu8N4RZGzrTpnwwpFg48vH087+gidjGVO4pyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665069; c=relaxed/simple;
	bh=0EYk/ZyMkRQrfNJJWurLHsPJD+czsbqO7H04q0T1trY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dp//YVt2RQISfY34YPKlYFdELNBr477UTE6auOq/P+SaiBFSRc/35A1tjNP3+TuaHqZWxW+nO2CTUk21wc/e7A6uF+wFyrrNtcs5ZXJOyVCozyCx3nJ8jpbcgEViuw+3oH3Fl3QulWsYXEktb3Uit4SupopXF+rLPDGcQQlUGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQZ+hJLi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709665068; x=1741201068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0EYk/ZyMkRQrfNJJWurLHsPJD+czsbqO7H04q0T1trY=;
  b=XQZ+hJLiM31jaqPGzb4A0o+tYGgW4Y4XCx+QVFJkUUtZyzHAVMo9XEAI
   JpD+vWTSicUhWsqt0UitaZ6EYkpaCAOBn1STnl4j42GD68RvD4n7ErpSi
   az/cXZVkaStNhIN5XICj7k0s5v0+NhTmDdtwCUZTDfhqj+OE3eVFQSzau
   Mgll3WOCrqUOG5ntHnyUbbFEGo+hd7ooTwy4wjPk8YK2bky35qa5BIt2J
   amPDg4Lltno9VL+y/5TYjFGctlPJhbWG+DJxAY+S7d++Y8lpDYXj5Weo4
   2CF7HXhbXAwYrkabcHMqspmjqI28UhDCs0jrU0vfg1HTuT4lIJHEtFQ+Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4822206"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4822206"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9337218"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 10:57:44 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net 5/8] ice: fix typo in assignment
Date: Tue,  5 Mar 2024 10:57:33 -0800
Message-ID: <20240305185737.3925349-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
References: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Fix an obviously incorrect assignment, created with a typo or cut-n-paste
error.

Fixes: 5995ef88e3a8 ("ice: realloc VSI stats arrays")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 097bf8fd6bf0..fc23dbe302b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3192,7 +3192,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		}
 	}
 
-	tx_ring_stats = vsi_stat->rx_ring_stats;
+	tx_ring_stats = vsi_stat->tx_ring_stats;
 	vsi_stat->tx_ring_stats =
 		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
 			       sizeof(*vsi_stat->tx_ring_stats),
-- 
2.41.0


