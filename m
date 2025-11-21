Return-Path: <netdev+bounces-240593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B728C76BCC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C41B4E6A5E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6052236E8;
	Fri, 21 Nov 2025 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFeNfKBz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED521579F
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684360; cv=none; b=oYeUPiaJJrpnHgROcDRDYGC1DFBHdoltr6tcntekC/H2WSMJKqN9Isiat2+Y5UsQUy3I05IKpOGbxjCVLUUJXkwtfZVUvvfVtW4FEv8rDqr0eN+aPJgOYYH1+CKLhvfkzDy3Y67BcbTGgaT+ioh5z24qaWeKWL4Y4E6sALd6yGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684360; c=relaxed/simple;
	bh=Sh6c7b6Hi90RoX/bOeWbivnnXi5ySOfBIpzuddrreJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VucTiwXP4ieUFFMtSSUyXzfqawz6yoCfahyxRMxXX00mvRI6mNSNCGwzBiHpx7pW5LfBo3w2hggt7IpsukBdNJv+2j/yf504Ex3K8vLwipvF2JkDL92AAXZrC74pPzaRPsBO+U3rN4hqDyvt1I8i/pW5Zhu3em40EaYJcDwJgec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFeNfKBz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763684359; x=1795220359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Sh6c7b6Hi90RoX/bOeWbivnnXi5ySOfBIpzuddrreJs=;
  b=bFeNfKBzJmiMR1Cqd3VHvyTEuU8J1DoItrjo227nCFT6c4T4Jeo3p2tI
   I0Q4t7eIpkZH8Zj9rPzTxvvtmCXAkG+L3AjVN7oJ2hZd0T0lhdp1lfsHX
   jrJ91CVeDy2F2zpt7Rnd1tmQCxSgiB/yXhXbTg+n60IJW/yxeR7CUImxQ
   qvyWzneIo+XTzytul9DqYa/gwPQxPHT473UqXpPNh/wppoPEKJF5Oj7eh
   Wn9qxE0/FPmVoGwmtwN9aQpsNW7KmmfjlZ3igFV2791CD4r39taKC4ljI
   jNyddFk8k6ExHyL2d7Yp41CG+/7T1wvg9UE4DCuLu1z1eIgETZg4FUI50
   Q==;
X-CSE-ConnectionGUID: qgQ1/pKeT7GjDuPJm9vyFg==
X-CSE-MsgGUID: 3y53edCASSmFh1GFYs2YXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65704075"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="65704075"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 16:19:15 -0800
X-CSE-ConnectionGUID: /CmWmNz9QuCSvdbjCtO1qA==
X-CSE-MsgGUID: sSB9nbthTMSxOdfdOtvxiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="190815182"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 20 Nov 2025 16:19:15 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: [PATCH iwl-net v2 4/5] idpf: fix memory leak in idpf_vc_core_deinit()
Date: Thu, 20 Nov 2025 16:12:17 -0800
Message-Id: <20251121001218.4565-5-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20251121001218.4565-1-emil.s.tantilov@intel.com>
References: <20251121001218.4565-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Make sure to free hw->lan_regs. Reported by kmemleak during reset:

unreferenced object 0xff1b913d02a936c0 (size 96):
  comm "kworker/u258:14", pid 2174, jiffies 4294958305
  hex dump (first 32 bytes):
    00 00 00 c0 a8 ba 2d ff 00 00 00 00 00 00 00 00  ......-.........
    00 00 40 08 00 00 00 00 00 00 25 b3 a8 ba 2d ff  ..@.......%...-.
  backtrace (crc 36063c4f):
    __kmalloc_noprof+0x48f/0x890
    idpf_vc_core_init+0x6ce/0x9b0 [idpf]
    idpf_vc_event_task+0x1fb/0x350 [idpf]
    process_one_work+0x226/0x6d0
    worker_thread+0x19e/0x340
    kthread+0x10f/0x250
    ret_from_fork+0x251/0x2b0
    ret_from_fork_asm+0x1a/0x30

Fixes: 6aa53e861c1a ("idpf: implement get LAN MMIO memory regions")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index fc03d55bc9b9..ca302df9ff40 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3570,6 +3570,7 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
+	struct idpf_hw *hw = &adapter->hw;
 	bool remove_in_prog;
 
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
@@ -3593,6 +3594,9 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	idpf_vport_params_buf_rel(adapter);
 
+	kfree(hw->lan_regs);
+	hw->lan_regs = NULL;
+
 	kfree(adapter->vports);
 	adapter->vports = NULL;
 
-- 
2.37.3


