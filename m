Return-Path: <netdev+bounces-76691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7DC86E863
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD9F1C21137
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893FD20DC5;
	Fri,  1 Mar 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7sN3gOA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F451CA98
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317701; cv=none; b=o7psZjKHx+Q2miHmplN8NJw7/UidhWTL4McPwzenEQeJOo5LPQqPebbv9W/8dfWrE0uqspsS98WQYdh4etJyInRZNiC8dDsZ9BQnAEG2S/ztFY2e544glhyUGXD9AhsZFZuRVht8xMZlHcNDis8VstVnjKEes58++G6oyOUaDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317701; c=relaxed/simple;
	bh=gKnBsvJL+Rlqj45zIhXN0kOtWX68tNTT+TRkUrzgaTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+eY7NEdsK1ydfxiZbTfjs7hQJMgQ0UDd3RArQgyd34c66kVF2TfXdsbXcJWNQDfUrcZFsF9V0uDoBQ8h5diaut77W3ahaFTLwfO3wDlz2HfPghWIXPMNIZY2Lc2gcHjo81RrRmB2wGucZeMSs7j0gBmslRR74Bat+cvyyzIs0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7sN3gOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57720C433C7;
	Fri,  1 Mar 2024 18:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317701;
	bh=gKnBsvJL+Rlqj45zIhXN0kOtWX68tNTT+TRkUrzgaTo=;
	h=From:To:Cc:Subject:Date:From;
	b=V7sN3gOA29+iTau9CUWlthkny4oJdspBiBCA4kDTyxOcxz2QXmpQWUr+/mXNS3jlY
	 G9clYV0Wc7nul4wdzy1schx3yADsVdNQW5iZoFvQxD4e7WRz73iYz2DZ9dUeh72Hpt
	 EO4XF9Zl8C5TIFa5/O78D8tyIvCL6j/2TKj5CmUe6ic4ttbDswbP8CxA/9OhaFsx2U
	 7J0gPY6WZhi9aCqO3M6ywH2PcA62AuCrMMQ1Rd3caiXRNOuJCLMoA3aRsRj0leyzRZ
	 rqxjNn73aWTvBDeHoBXH1tAno2EMFKVMP6tn1XfxlUOYDlj+ZpwxggyJ8wRIP2aP+p
	 M+1ePvETqT7hA==
From: javi.merino@kernel.org
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	Ross Lagerwall <ross.lagerwall@citrix.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Javi Merino <javi.merino@kernel.org>
Subject: [PATCH] ice: Fix enabling SR-IOV with Xen
Date: Fri,  1 Mar 2024 18:28:10 +0000
Message-ID: <20240301182810.9808-1-javi.merino@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ross Lagerwall <ross.lagerwall@citrix.com>

When the PCI functions are created, Xen is informed about them and
caches the number of MSI-X entries each function has.  However, the
number of MSI-X entries is not set until after the hardware has been
configured and the VFs have been started. This prevents
PCI-passthrough from working because Xen rejects mapping MSI-X
interrupts to domains because it thinks the MSI-X interrupts don't
exist.

Fix this by moving the call to pci_enable_sriov() later so that the
number of MSI-X entries is set correctly in hardware by the time Xen
reads it.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Javi Merino <javi.merino@kernel.org>
---

I'm unsure about the error path if `pci_enable_sriov()` fails.  Do we
have to undo what `ice_start_vfs()` has started?  I can see that
`ice_start_vfs()` has a teardown at the end, so maybe we need the same
code if `pci_enable_sriov()` fails?

 drivers/net/ethernet/intel/ice/ice_sriov.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index a94a1c48c3de..8a9c8a2fe834 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -878,24 +878,20 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 	set_bit(ICE_OICR_INTR_DIS, pf->state);
 	ice_flush(hw);
 
-	ret = pci_enable_sriov(pf->pdev, num_vfs);
-	if (ret)
-		goto err_unroll_intr;
-
 	mutex_lock(&pf->vfs.table_lock);
 
 	ret = ice_set_per_vf_res(pf, num_vfs);
 	if (ret) {
 		dev_err(dev, "Not enough resources for %d VFs, err %d. Try with fewer number of VFs\n",
 			num_vfs, ret);
-		goto err_unroll_sriov;
+		goto err_unroll_intr;
 	}
 
 	ret = ice_create_vf_entries(pf, num_vfs);
 	if (ret) {
 		dev_err(dev, "Failed to allocate VF entries for %d VFs\n",
 			num_vfs);
-		goto err_unroll_sriov;
+		goto err_unroll_intr;
 	}
 
 	ice_eswitch_reserve_cp_queues(pf, num_vfs);
@@ -906,6 +902,10 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 		goto err_unroll_vf_entries;
 	}
 
+	ret = pci_enable_sriov(pf->pdev, num_vfs);
+	if (ret)
+		goto err_unroll_vf_entries;
+
 	clear_bit(ICE_VF_DIS, pf->state);
 
 	/* rearm global interrupts */
@@ -918,10 +918,8 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 
 err_unroll_vf_entries:
 	ice_free_vf_entries(pf);
-err_unroll_sriov:
-	mutex_unlock(&pf->vfs.table_lock);
-	pci_disable_sriov(pf->pdev);
 err_unroll_intr:
+	mutex_unlock(&pf->vfs.table_lock);
 	/* rearm interrupts here */
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 	clear_bit(ICE_OICR_INTR_DIS, pf->state);
-- 
2.43.1


