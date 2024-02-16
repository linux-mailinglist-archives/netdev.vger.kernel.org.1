Return-Path: <netdev+bounces-72552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE73E858828
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0A61C22849
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA706146918;
	Fri, 16 Feb 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6UEhZev"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B7136678
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119789; cv=none; b=WRHpBtEQ+5lcmmXJ7pxnMzzsrhOd3mtojMw/ijGIExuoUmZEtSSQfugZSYzbKGWUjN+5xck9aXY2U4yhR+1FEPGHdUGwmeufMc8Nbq6QZ4k6Un+c0UEojfP3b4FGQtJFRkXxU7+xl8mfnrFjAg5P1Tbx8k1AyoPo6ae4npcmT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119789; c=relaxed/simple;
	bh=OFyK+F8Wp1iECPLPS32ZsmMxJA/uPlii7zrTFJr/RX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsVTY0HSGFVmiZbkBJdS9yv/cJ6qAsovLRg1AGhruivIZKDLllGtWvD9odAKLlLxeksfh26kzKpMQKYBvKcKg0fPJZ23rairJa9n6D3q9zc6vJKLKofOfAoxXajd3u8KnTuQS0b+s3ST92Qrn2kZxjpG4d/Io5EEMcXSv67Cu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6UEhZev; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119789; x=1739655789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OFyK+F8Wp1iECPLPS32ZsmMxJA/uPlii7zrTFJr/RX8=;
  b=d6UEhZevbFu9wdCdbQxANzUypNi3VRumJgQ83cwowP5GE2QM1zAxWlXO
   ZORFwstZ/Hvafv/NwdZWS0jrxv6qUYzsgJILUohzstkQFs9Ua+kUDJns3
   l7zoilaUe7HUrAEUCKexPkhXecNEKa0LxXALdr1U22to/uf5Xq3NfSlqg
   bHhvWlTT0Q2Em/WJ5M4QhPzIAcZE7CJKvJ5E1VcVz6eMFRuUhUlA0oCMN
   WWVn5tEIl2iPKQuoBwCCoXmtVe3MGKyYwN0lcU7DCWJkIa14wXQw4hDjf
   PonTTA1avx0QHfg+52b3C3E+ok+TpzySiYY0DlGRK0Rt8OgCU7wadt3yP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2122871"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2122871"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8618672"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 16 Feb 2024 13:42:51 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 1/5] i40e: Use existing helper to find flow director VSI
Date: Fri, 16 Feb 2024 13:42:38 -0800
Message-ID: <20240216214243.764561-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
References: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Use existing i40e_find_vsi_by_type() to find a VSI
associated with flow director.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 54eb55464e31..6e59a9509868 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15630,6 +15630,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #ifdef CONFIG_I40E_DCB
 	enum i40e_get_fw_lldp_status_resp lldp_status;
 #endif /* CONFIG_I40E_DCB */
+	struct i40e_vsi *vsi;
 	struct i40e_pf *pf;
 	struct i40e_hw *hw;
 	u16 wol_nvm_bits;
@@ -15640,7 +15641,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #endif /* CONFIG_I40E_DCB */
 	int err;
 	u32 val;
-	u32 i;
 
 	err = pci_enable_device_mem(pdev);
 	if (err)
@@ -15990,12 +15990,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_LIST_HEAD(&pf->vsi[pf->lan_vsi]->ch_list);
 
 	/* if FDIR VSI was set up, start it now */
-	for (i = 0; i < pf->num_alloc_vsi; i++) {
-		if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
-			i40e_vsi_open(pf->vsi[i]);
-			break;
-		}
-	}
+	vsi = i40e_find_vsi_by_type(pf, I40E_VSI_FDIR);
+	if (vsi)
+		i40e_vsi_open(vsi);
 
 	/* The driver only wants link up/down and module qualification
 	 * reports from firmware.  Note the negative logic.
-- 
2.41.0


