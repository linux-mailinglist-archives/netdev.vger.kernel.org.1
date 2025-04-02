Return-Path: <netdev+bounces-178874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814FA793EA
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0861894F47
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3081DDC28;
	Wed,  2 Apr 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0nXMTC7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658381C8604
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615555; cv=none; b=l27vqEsRIUnumNfUvSE1jV/oYg1ybx23eRWPxMp1pJA+QUauyIai9aRS0aCut7dIKDOvppJITTjpxouyPPvFH6IMdGH8pJy3qfWnZTtdssS4E/+J9eoyrxD/5bfBG+LwpY+FH2zahKwE1TT5DfgPkvNH/1RBLh2DIZeWGWPOK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615555; c=relaxed/simple;
	bh=QfgFqbVAQEpRBjtw5mPjVjuszZjEVNbqgmw276wdWG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5CB4JLE8ZJL93wdJkFLmEP/rAps3jydHBYiV9205EvUeMk1imnIKW1kAZtYWofYCZXoJr6T2LzlHg8Cw9Ty84F46jK4GlogP0BnOZIb7GpQnnvQdE1wpTySFqLBLo7QM2aCt+zPJhOR/uK1n/blvsD4rrmmIBzpYtGR88zOlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0nXMTC7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743615553; x=1775151553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QfgFqbVAQEpRBjtw5mPjVjuszZjEVNbqgmw276wdWG8=;
  b=g0nXMTC727zpHyxEbPKtP4QMiWqDxKJnJuo404AF8MTG9dxkMtNnUE8u
   tgvaisay9C9EF4dsJau742vy59Kj90hLeJyhcDuQ9vTOExAME6rSdw22T
   XR3S64vX2h9PMwVjoVEOhevniPgcNnew3qI/SHu+UAOXQhgZso7tNfc2Q
   cmu8k0AM3CcjcjP2jCpBfqUgPNddBOm7ImLJEI9fc2Ex8HmCcgJQaY12t
   SR2Gd7bZh7P+Ue3Q3Sj8X+Or7MG9sRqKvPsGiizQ7/kT4F2ZA7m4a5irR
   SzoHCLQ8R/cKRb5+TTp3++AD418F9KzV+gRkLGGmBkO6Jq03gmtAgpGEt
   Q==;
X-CSE-ConnectionGUID: fPlxHISwQAu44C+biazZCg==
X-CSE-MsgGUID: 6F3qyKnLQkeqTMOPteCv5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44257299"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44257299"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:39:13 -0700
X-CSE-ConnectionGUID: PEX1tSzaS5eAvHH8UHYf4g==
X-CSE-MsgGUID: SOnt5ROQSUKdjE+j2pjBvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="149968809"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 02 Apr 2025 10:39:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	decot@google.com,
	willemb@google.com,
	horms@kernel.org,
	yuma@redhat.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 5/5] idpf: fix adapter NULL pointer dereference on reboot
Date: Wed,  2 Apr 2025 10:38:57 -0700
Message-ID: <20250402173900.1957261-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
References: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

With SRIOV enabled, idpf ends up calling into idpf_remove() twice.
First via idpf_shutdown() and then again when idpf_remove() calls into
sriov_disable(), because the VF devices use the idpf driver, hence the
same remove routine. When that happens, it is possible for the adapter
to be NULL from the first call to idpf_remove(), leading to a NULL
pointer dereference.

echo 1 > /sys/class/net/<netif>/device/sriov_numvfs
reboot

BUG: kernel NULL pointer dereference, address: 0000000000000020
...
RIP: 0010:idpf_remove+0x22/0x1f0 [idpf]
...
? idpf_remove+0x22/0x1f0 [idpf]
? idpf_remove+0x1e4/0x1f0 [idpf]
pci_device_remove+0x3f/0xb0
device_release_driver_internal+0x19f/0x200
pci_stop_bus_device+0x6d/0x90
pci_stop_and_remove_bus_device+0x12/0x20
pci_iov_remove_virtfn+0xbe/0x120
sriov_disable+0x34/0xe0
idpf_sriov_configure+0x58/0x140 [idpf]
idpf_remove+0x1b9/0x1f0 [idpf]
idpf_shutdown+0x12/0x30 [idpf]
pci_device_shutdown+0x35/0x60
device_shutdown+0x156/0x200
...

Replace the direct idpf_remove() call in idpf_shutdown() with
idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(), which perform
the bulk of the cleanup, such as stopping the init task, freeing IRQs,
destroying the vports and freeing the mailbox. This avoids the calls to
sriov_disable() in addition to a small netdev cleanup, and destroying
workqueues, which don't seem to be required on shutdown.

Reported-by: Yuying Ma <yuma@redhat.com>
Fixes: e850efed5e15 ("idpf: add module register and probe functionality")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index b6c515d14cbf..bec4a02c5373 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -87,7 +87,11 @@ static void idpf_remove(struct pci_dev *pdev)
  */
 static void idpf_shutdown(struct pci_dev *pdev)
 {
-	idpf_remove(pdev);
+	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&adapter->vc_event_task);
+	idpf_vc_core_deinit(adapter);
+	idpf_deinit_dflt_mbx(adapter);
 
 	if (system_state == SYSTEM_POWER_OFF)
 		pci_set_power_state(pdev, PCI_D3hot);
-- 
2.47.1


