Return-Path: <netdev+bounces-106162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56133915061
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D338228496A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30619B58D;
	Mon, 24 Jun 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eb1tKI2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02219B583
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240241; cv=none; b=N6UR2jhD26+CmkpLsACk9pqowJgBOyNve0zu8P9VAtgxCo8hi2/0muZDWvHX3UFpOssdKtLmQLlxMvXjoKKL1wDNw02o6nY45rT2HHZ1+g9+HueuJGkmMyaTdPrMaW+EyVGrctfG8K2ip6w0kvHoJWUH6O8sQAZvBd8KOqcrekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240241; c=relaxed/simple;
	bh=00WpGcsEMIsU9URS7/+Rk5iXtCeARQolpArF+UPgl5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUXYKKKHpfNk/irQopjzYttNIPgYVTiYduK3VEN+J9DlcyVHC5mNraNjOKv7rnptLcidzUmA6CWtyfu15/PcY4jse0rmMROH0/xYF0TIyEg65HOBFL9Z0wwonTK3hYEMJbHmMVhXpilKSTKrgLP4OTcNaMBlYXxMHEMhBv222fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eb1tKI2Y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719240240; x=1750776240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=00WpGcsEMIsU9URS7/+Rk5iXtCeARQolpArF+UPgl5w=;
  b=Eb1tKI2YVy5jNXNvcBP2IdHpIZ2c/wv1B5Xj1TUuLImIxLFA9c1BXVZ/
   VpqvyxMd8FZVtHLirJasFVnmef3dGWBSWZQP/Y5klj3wNOK0wyKugCdff
   jMbAAu+MZLV5jbxk0PXT1jrKMCRHWvQLnwq9nsXkvggFVYYvS+sUaNgVz
   y63drMtHreVk3vrSf8YebHsORKSMq2sF0r3HuLbCqUCpjLVukiNx2eR7l
   m3plILzgp0GJcOzDNKCAcZDO4iKJ00VRDPMks8tEktRIvSxxhE4+dEf4t
   hWL9hfQV1IPU70a8kjXaD9SEa8DHNxHCYVooBDfLlKhMmsdOhYyb7bdeB
   Q==;
X-CSE-ConnectionGUID: SSEoB1bkRta2cSd03LkOaQ==
X-CSE-MsgGUID: 9RPzLzZ0Tk+iYeBOwj447w==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16040474"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16040474"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 07:43:59 -0700
X-CSE-ConnectionGUID: yDN1Jn7hQdeODJFio3M3hQ==
X-CSE-MsgGUID: X8LlvTlUR/GY9+C0mYoLjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="44022049"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 24 Jun 2024 07:43:58 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2F7F927BB1;
	Mon, 24 Jun 2024 15:43:46 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v2 1/7] ice: Remove unused struct ice_prot_lkup_ext members
Date: Mon, 24 Jun 2024 16:45:24 +0200
Message-ID: <20240624144530.690545-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624144530.690545-1-marcin.szycik@linux.intel.com>
References: <20240624144530.690545-1-marcin.szycik@linux.intel.com>
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


