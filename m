Return-Path: <netdev+bounces-207262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A85BB067BB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB456564A62
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0311917BA1;
	Tue, 15 Jul 2025 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGNdkHHW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134F2BE641
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752611410; cv=none; b=gq1P2vMs0eusX4H18rlin3lmbgaFBpGTQGvH8yfwHqk76OC3rb4cjVXC9hM4gGUuVQMuGFGgi3MTAfiSAc7mO94NqSsnxog+76dAIZbsgHol5p191MIv2YO1pArop3HVgYRy+i5yUgcU3kDsFj66Bpre4J0WZhUzGA40UF771TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752611410; c=relaxed/simple;
	bh=/oUdp1eUjc8e9Lgd7+wGCZ0B94uY7ood0jBLhM2gczY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg52gqcPHiy85vm1t46DIcDmEQaQlb/O6stCdzPjAIeXjCyeD/SGrENzJNsa/atChvyKIHArMO1BZ6f3zihyBfW8aHuqiNW427T453BzrURIjW62XznlFDQBLaoM7xC7XoNt4nXTmPzaXz/xkvQXliAz6RE0fO8lHzuTYArxUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGNdkHHW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752611409; x=1784147409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/oUdp1eUjc8e9Lgd7+wGCZ0B94uY7ood0jBLhM2gczY=;
  b=BGNdkHHWhVhsK8HbYlvdiPce8ZMf/76nycvVo2pTXbM5vaOo6VNVnvzb
   yPlNm9ds1eLG4VME0vHC4iXXDUHshkZA9QmI9FvDfIaVP4VIoDgkUEuCK
   XUvax5tdruA0zdtj+8/cvPb1Y6Lmz1q0TLWFj+s7Ha4Bn6kT5Fy2H026+
   qwOL+pGBOiFT7H67YVEzu0vOr/tqE8NlqQq+QYYG12JLx1GhPDk08HAQz
   Ns7hL8/q2eiDMSRqbcbbA3f4aa6J/WG4HTmCRAk36B/Cuzbxf4FVBuJca
   0itzpHmGWC+O3H7EDBIraC7bjcdP3V1ilzlO70NpNxpN1P3k5k46fR7c9
   Q==;
X-CSE-ConnectionGUID: SyCYL58FR6GSrzeZz3iv+Q==
X-CSE-MsgGUID: peRx+I3ESka9Juyajliq2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54699826"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="54699826"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 13:29:58 -0700
X-CSE-ConnectionGUID: XQwbfGLMQP+25/KDxH03Wg==
X-CSE-MsgGUID: ZnBOBT3rQRy+vYMkIyebow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="194449525"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 15 Jul 2025 13:29:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/3] ice: check correct pointer in fwlog debugfs
Date: Tue, 15 Jul 2025 13:29:46 -0700
Message-ID: <20250715202948.3841437-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250715202948.3841437-1-anthony.l.nguyen@intel.com>
References: <20250715202948.3841437-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

pf->ice_debugfs_pf_fwlog should be checked for an error here.

Fixes: 96a9a9341cda ("ice: configure FW logging")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 9fc0fd95a13d..cb71eca6a85b 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -606,7 +606,7 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 
 	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
 						      pf->ice_debugfs_pf);
-	if (IS_ERR(pf->ice_debugfs_pf))
+	if (IS_ERR(pf->ice_debugfs_pf_fwlog))
 		goto err_create_module_files;
 
 	fw_modules_dir = debugfs_create_dir("modules",
-- 
2.47.1


