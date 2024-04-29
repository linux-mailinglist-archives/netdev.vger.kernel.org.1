Return-Path: <netdev+bounces-92140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CCB8B58F9
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DE71F2617D
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE796FE14;
	Mon, 29 Apr 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="TMCtLWEG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3FC2C6
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394721; cv=none; b=XWspXeuqxA6Epsq0zoUTUaXSy67BGPKOvyRQrE885KXfPnjZf/GP0OjGySGbn55P2mqSSXrwawgizeMoL5XuH7YnLAU/mpRDgAycdy5zsQPrnM914WlP0zigMftsVhr3uon1ueYYrXR0Lw1xNflv4eSWJvf/59ryYeBPbG6f7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394721; c=relaxed/simple;
	bh=kYwBjIRWT+X3mxLz+DC79azJb3xxACkWB24/jo8nNRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fomszKMXoIGg0PPxy7/xPc0YjH5u4BvgbygMklHj0zA7Im1T60bBCYSkelnsDH9YecOP2Dl+tUI6xeq8IsCnEcVBEVm2JuY3h77gxMkBcCkHEU6MbF3c6fovhBrN2/RgWiOQRyXoCPbPqBxVurq92UR10j31K79C2k2gMatt5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=TMCtLWEG; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78ecd752a7cso321516285a.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1714394718; x=1714999518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSdIjzzdjAUqRZWXlYR6ZEgeQhNVj7rUEbwWPASOCLc=;
        b=TMCtLWEGNbcLMrPuAfsHvetl6pirtqHZ0la4rHqOXv3mTQDFEYpkjRslpK09EwGu1g
         l5fZOxoOcnGoPzZcUbxsNKoan+Oddso9EC+SdQcae4fB1DHTyjLOEs0/gqU6TXWnh48b
         lTS2ZhM3vKf4nfC4vVMPr7Sjk5xRb8FlXyOA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394718; x=1714999518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSdIjzzdjAUqRZWXlYR6ZEgeQhNVj7rUEbwWPASOCLc=;
        b=b9tq9X9cqcLtLjrVfggMsxo+hDsAlkFJ/lk4y5/KTsbTPSDMGca6GRCtZ1KcuFSANY
         8o9YT7wDyzUpYceh4Rx7GjxSuwHYDzRXWYJtbD3JVHvdeXojzKmInf9m2W+oCGkwjMW5
         nj94XfBDPXNoN8bryJPSdLGJtrer38sYN66DK8MatrRTR9gYVWaHdv/mqkl2b9s+qBfy
         Jn/pkkzz7fLuplemTCedilyStVNy37do7KDNQNDoXNYkLrc7I5wawuVXt362toS2t9Xl
         0lSrBudc0B2JqW7NlNYlBS+xHXKe3DicBsjah+DsHveg3U2ennit89Y43ra13UMy3oJe
         nQ6A==
X-Gm-Message-State: AOJu0Yx4zLOuN3wOMe1QA/kmF+BlbjBbGUwK3DOXeExvGDsDKj9cJtxW
	W1ozT5Z77YHDB1ezydqFv5I27uRdwP/EqmQtbU0mvEMFHVJWYvXsdUSAgA9EZfy5zBYINDwaTPA
	=
X-Google-Smtp-Source: AGHT+IElZd42ZGwJ8z9A8xEz9Hiqk8qh71/z3AW+tX8Ig39dBjGxB6sSSxZRSmrirxxlgFCqcIpC4g==
X-Received: by 2002:a05:620a:2415:b0:790:f40f:e24e with SMTP id d21-20020a05620a241500b00790f40fe24emr4630529qkn.22.1714394718621;
        Mon, 29 Apr 2024 05:45:18 -0700 (PDT)
Received: from rossla-lxenia.eng.citrite.net ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id k9-20020ae9f109000000b0078ede0c25b5sm10412073qkg.23.2024.04.29.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 05:45:18 -0700 (PDT)
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Javi Merino <javi.merino@kernel.org>,
	Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH v2] ice: Fix enabling SR-IOV with Xen
Date: Mon, 29 Apr 2024 13:49:22 +0100
Message-ID: <20240429124922.2872002-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Javi Merino <javi.merino@kernel.org>
---

In v2:
* Fix cleanup on if pci_enable_sriov() fails.

 drivers/net/ethernet/intel/ice/ice_sriov.c | 23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index a958fcf3e6be..bc97493046a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -864,6 +864,8 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
+	struct ice_vf *vf;
+	unsigned int bkt;
 	int ret;
 
 	pf->sriov_irq_bm = bitmap_zalloc(total_vectors, GFP_KERNEL);
@@ -877,24 +879,20 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
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
@@ -905,6 +903,10 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 		goto err_unroll_vf_entries;
 	}
 
+	ret = pci_enable_sriov(pf->pdev, num_vfs);
+	if (ret)
+		goto err_unroll_start_vfs;
+
 	clear_bit(ICE_VF_DIS, pf->state);
 
 	/* rearm global interrupts */
@@ -915,12 +917,15 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 
 	return 0;
 
+err_unroll_start_vfs:
+	ice_for_each_vf(pf, bkt, vf) {
+		ice_dis_vf_mappings(vf);
+		ice_vf_vsi_release(vf);
+	}
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
2.43.0


