Return-Path: <netdev+bounces-107349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF1891A9F1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB731C21451
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA5A197A8A;
	Thu, 27 Jun 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpxKlDmx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98206197556
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500077; cv=none; b=HFT7DayDc5aQyw6Zc2ia1fMSOu1EWG10WjZC5HpgikA3NodSV5Z5/J3hnE+2gGZ2YGF4W7aIpdOJiCQzoKNRQbD9p4KK5/Rh+GR8H67uyqRnxtdA0EJ6TBlHusP6IaKcV2NhCvE/c3kVXxleZGGMba31heVZEPaZZEROxSKP01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500077; c=relaxed/simple;
	bh=00WpGcsEMIsU9URS7/+Rk5iXtCeARQolpArF+UPgl5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHEiqBtGsDVOtF5OuEFaqt6j750gYhANNzyfAN/VS8F9DLorl9Xpj+LDI0LTuTAM8LwDZhgFv53qzCG9IYzDF0pz+O5AsxM2TENDRR0PCiTy/R2QHme+vNFAxybOXGdDdku7qJXIqSvHKIydO9v4OTwY5CXjFJ0ZoVdSawdIJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpxKlDmx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719500075; x=1751036075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=00WpGcsEMIsU9URS7/+Rk5iXtCeARQolpArF+UPgl5w=;
  b=VpxKlDmxvZYidkf1xW2FtstieWGiIYFnoTyDYOBPNOTWu2GgTAA9oxSP
   x0sKa2V7ddThxRgnR+y1YzV94wGE5lZBuNlSgWJi0zesfvSMk1QkC9Agn
   FbgH/QJcvicPxqEMyz9RJdDTCJOTEONtgUWJxS/S7Zx7eIK9JtiArTXAI
   PagmEz/FtqZpOBoiPnJIUU6daq42qohp4XTMsOz4K4B43U0UdVgY/bx0a
   sWF/9AmRMq/ptLTCniGXkmZ+iuHB8GgfksYzSaGi5OixLNKdxLT6JOHDn
   bxyQ37tBrq7piq9TFqX2P1gZD+FJ2UcAtPdfzO31x1fbdLB6baRU44YaH
   g==;
X-CSE-ConnectionGUID: 74y7ISitQFW/S4cSZEukwg==
X-CSE-MsgGUID: bKBYBM8mRJWBnfEEjrZhVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20514964"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="20514964"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:54:27 -0700
X-CSE-ConnectionGUID: ooTJe8jxTAudB/vZ6Ue4mQ==
X-CSE-MsgGUID: aNqdOLZmTi6nQ5ICOw5I5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="67616389"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jun 2024 07:54:26 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4659D27BBC;
	Thu, 27 Jun 2024 15:54:11 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	pmenzel@molgen.mpg.de,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v3 1/7] ice: Remove unused struct ice_prot_lkup_ext members
Date: Thu, 27 Jun 2024 16:55:41 +0200
Message-ID: <20240627145547.32621-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
References: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove field_off as it's never used.

Remove done bitmap, as its value is only checked and never assigned.
Reusing sub-recipes while creating new root recipes is currently not
supported in the driver.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 .../ethernet/intel/ice/ice_protocol_type.h    |  4 --
 drivers/net/ethernet/intel/ice/ice_switch.c   | 44 ++++++++-----------
 2 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_protocol_type.h b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
index 755a9c55267c..c396dabacef4 100644
--- a/drivers/net/ethernet/intel/ice/ice_protocol_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
@@ -452,13 +452,9 @@ struct ice_prot_lkup_ext {
 	u16 prot_type;
 	u8 n_val_words;
 	/* create a buffer to hold max words per recipe */
-	u16 field_off[ICE_MAX_CHAIN_WORDS];
 	u16 field_mask[ICE_MAX_CHAIN_WORDS];
 
 	struct ice_fv_word fv_words[ICE_MAX_CHAIN_WORDS];
-
-	/* Indicate field offsets that have field vector indices assigned */
-	DECLARE_BITMAP(done, ICE_MAX_CHAIN_WORDS);
 };
 
 struct ice_pref_recipe_group {
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 1191031b2a43..0d58cf185698 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4918,33 +4918,27 @@ ice_create_first_fit_recp_def(struct ice_hw *hw,
 
 	*recp_cnt = 0;
 
-	/* Walk through every word in the rule to check if it is not done. If so
-	 * then this word needs to be part of a new recipe.
-	 */
-	for (j = 0; j < lkup_exts->n_val_words; j++)
-		if (!test_bit(j, lkup_exts->done)) {
-			if (!grp ||
-			    grp->n_val_pairs == ICE_NUM_WORDS_RECIPE) {
-				struct ice_recp_grp_entry *entry;
-
-				entry = devm_kzalloc(ice_hw_to_dev(hw),
-						     sizeof(*entry),
-						     GFP_KERNEL);
-				if (!entry)
-					return -ENOMEM;
-				list_add(&entry->l_entry, rg_list);
-				grp = &entry->r_group;
-				(*recp_cnt)++;
-			}
-
-			grp->pairs[grp->n_val_pairs].prot_id =
-				lkup_exts->fv_words[j].prot_id;
-			grp->pairs[grp->n_val_pairs].off =
-				lkup_exts->fv_words[j].off;
-			grp->mask[grp->n_val_pairs] = lkup_exts->field_mask[j];
-			grp->n_val_pairs++;
+	for (j = 0; j < lkup_exts->n_val_words; j++) {
+		if (!grp || grp->n_val_pairs == ICE_NUM_WORDS_RECIPE) {
+			struct ice_recp_grp_entry *entry;
+
+			entry = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*entry),
+					     GFP_KERNEL);
+			if (!entry)
+				return -ENOMEM;
+
+			list_add(&entry->l_entry, rg_list);
+			grp = &entry->r_group;
+			(*recp_cnt)++;
 		}
 
+		grp->pairs[grp->n_val_pairs].prot_id =
+			lkup_exts->fv_words[j].prot_id;
+		grp->pairs[grp->n_val_pairs].off = lkup_exts->fv_words[j].off;
+		grp->mask[grp->n_val_pairs] = lkup_exts->field_mask[j];
+		grp->n_val_pairs++;
+	}
+
 	return 0;
 }
 
-- 
2.45.0


