Return-Path: <netdev+bounces-160853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22262A1BDE1
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FACE188E66A
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A51E7C21;
	Fri, 24 Jan 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEg27CYf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D681DD520
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754342; cv=none; b=VRgayDWduy9mZJWMAFEMKmF9aM6mkgpA2tfC7V2mR5J1wgOkG6MB/Nx2G2RMVucQ8LXmR4qTGrRI76juSk6dz4g9pI9ik1U4Wxe1nwEeqTsbkqpa+DEPCYKOQzwv10RlU1e4QMUuuwMe2Z63JICDR8ghWuy5pwBkid//AxsFubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754342; c=relaxed/simple;
	bh=7u2607bVEyMZVmBYLyxGWvjBem+61Nd2tTBfIpsM5X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys+ugQ2KrH/ggWVO5xGXBMDcckl5by//008xxOrvJZcxVCmM7zVEMBLXzb3jgeo8OiHbLYRjSQjJZiptkPn4rOB2bwppGi1aVErtOawoqPSZB5CqSo7DSiGQCrWdzYV6OyWTbsvWEwid5aZu1GCWO5oun8uPtQrA4I7Ehmo5BNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEg27CYf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737754340; x=1769290340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7u2607bVEyMZVmBYLyxGWvjBem+61Nd2tTBfIpsM5X4=;
  b=MEg27CYfcL5Ud7B2NfXkCJ/LCqA57pHz4d325nlATaoDFTdp/nA//1Rz
   4LFJTvSMPx9AJklwpq73A95VgWsbIfkTtlGBYYpATdexdBly+lQQ4iXSr
   23UmPT3vh3EcvgRaY6uqAlwV0CKDMB7SLoo7c6XOh2gyppqnztv+EM4GD
   TBmHwRyCXFSF7VXKCDq68gK+rEWZ85Y/jgSngCDuKV/q44qrUgXiUtTmU
   LPWpG3NFheHyxRQ76RTwPHlEhbVRv+qDKLjJ5YFOhKAqFcKHPiYdj96Jt
   Ocm5Tz0uj1ru8RKaI0cSI1/wzWVOBfEJshSKKdcU5D1N610MJzKH3ltA/
   g==;
X-CSE-ConnectionGUID: hlzIxwFOS3K1zxFcLFCYMg==
X-CSE-MsgGUID: QcLTsp07Q66Dl5+nAizJfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41140390"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41140390"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:32:17 -0800
X-CSE-ConnectionGUID: I5uXn3ENRN2A1qSJ3BRZ+w==
X-CSE-MsgGUID: Vi/F3raoQOWEHusBJdYVaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107861079"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 24 Jan 2025 13:32:17 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	decot@google.com,
	willemb@google.com,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 2/8] idpf: fix transaction timeouts on reset
Date: Fri, 24 Jan 2025 13:32:04 -0800
Message-ID: <20250124213213.1328775-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
References: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Restore the call to idpf_vc_xn_shutdown() at the beginning of
idpf_vc_core_deinit() provided the function is not called on remove.
In the reset path the mailbox is destroyed, leading to all transactions
timing out.

Fixes: 09d0fb5cb30e ("idpf: deinit virtchnl transaction manager after vport and vectors")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d46c95f91b0d..7639d520b806 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3077,12 +3077,21 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
+	bool remove_in_prog;
+
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
 		return;
 
+	/* Avoid transaction timeouts when called during reset */
+	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
+	if (!remove_in_prog)
+		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+
 	idpf_deinit_task(adapter);
 	idpf_intr_rel(adapter);
-	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+
+	if (remove_in_prog)
+		idpf_vc_xn_shutdown(adapter->vcxn_mngr);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
-- 
2.47.1


