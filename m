Return-Path: <netdev+bounces-213845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E2B270C3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D79E3B90AD
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 21:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F3272E5E;
	Thu, 14 Aug 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFSVQMH3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755C26E6E5
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206554; cv=none; b=sXrpbOVYXtxqo9CHmSjHuEKeu1zzhxtwjnf5tLVaZUXShGG80v4F8NQIxdCpQ8FrfNi2yRkT2x5VvyMlEfzzpNfYyFshig/j3UTcC36Gb+BNEvZN6C9od7anDPG0T2MRtzBxuXCcn9ih4o/nYr7Bx+f9qg7UL0A31MTzcRqdxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206554; c=relaxed/simple;
	bh=vXruK7HKIOthCODtNS8T6dWYd2gveLJLkZ6UxrswHPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=crxDA/qFhpYO6l9T2MIPyA6+gvvgp0nAQLBKr/iMbtQITAOcaaDoVPdrn+L2bWqgncJo/3BaWDHXM8dVyv/6l2inSK7R4e7YvRg8dc5o+OIjMAre0agNAFIvo9WfPYY3U1NmWzIKMRCZKXfoErDEHzY/gbTC9htVYOaO7pyfvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFSVQMH3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755206552; x=1786742552;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=vXruK7HKIOthCODtNS8T6dWYd2gveLJLkZ6UxrswHPo=;
  b=OFSVQMH3mJJKlWzgDyVU0Qdr/I0yL4xL078HAgKh3N2f+hdFc/74Gpv8
   X2fLWWIwpyXEJFZSpDYpyEUb8DVnu/TrHNLuT/nMpNr40sQJEGpGFhb0t
   NSK9EzKQ2VplOuoF4rXKKnwFqRv/u5HIY4v0tzRtO925/D36ALQynlixh
   1hP3wxJbIKiiBiO8g27ZYjmSEWgYv3gsx9/oZFVekxlVWrYifgxvsx4N4
   5LwIZV0Y8qwppqHaO2oUlmwcymwTrIcoYojeomTUifOTqt3JvxYAA2ARR
   YfTV9wnYfqndI0Br+fnsx4gcP0PTF9cQSHu57hjuNmZGiwk0jMcHxZbQ4
   Q==;
X-CSE-ConnectionGUID: Uo8r8VtMSwe3yXzQowH9vw==
X-CSE-MsgGUID: ZJOdvDK6RvaCFpJU1WZwEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61344225"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61344225"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 14:22:31 -0700
X-CSE-ConnectionGUID: xJam2HqEQ9ifUAc8XqSL4Q==
X-CSE-MsgGUID: BhX1XrUqQEKzu6+HMWmO2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166077480"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 14:22:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 14 Aug 2025 14:21:54 -0700
Subject: [PATCH iwl-net] i40e: fix Jumbo Frame support after iPXE boot
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-jk-fix-i40e-ice-pxe-9k-mtu-v1-1-c3926287fb78@intel.com>
X-B4-Tracking: v=1; b=H4sIAHJTnmgC/42OzQ6CMBCEX4X07JpuQVBPvofhAGUrK79pK2II7
 27l5JHj5Jt8M4twZJmcuEaLsDSx46EPAQ+R0HXRPwi4ClkoqU7yjDE8GzA8AycyIE0wzgSXBjr
 /AlWmlYxThbq6iCAYLYXqJr8LfrfQkxd5ADU7P9jPNjrhhvf4JwSELM4STAujNeob957aox663
 9xuhTHhoSlNUmb/inxd1y89HRHxEAEAAA==
X-Change-ID: 20250813-jk-fix-i40e-ice-pxe-9k-mtu-2b6d03621cd9
To: kheib@redhat.com, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-c61db
X-Developer-Signature: v=1; a=openpgp-sha256; l=6293;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=vXruK7HKIOthCODtNS8T6dWYd2gveLJLkZ6UxrswHPo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhox5wT3Jkil9t02eyt4tPWp+cuvTJ3G+p6+LiVg/XnzM+
 rRoh5ZbRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABM5v4Hhf+QVCy+f9g0bujdd
 8L3zsrDJuzEz8aHy3bzTFXPlV0V/42D4zf7o6/Xi/gD5jxcjCxdLza+eL5357Ln8vqu97UkLl0d
 t5gcA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The i40e hardware has multiple hardware settings which define the maximum
frame size of the physical port. The firmware has an AdminQ command
(0x0603) to configure all of these settings, but the i40e Linux driver
never issues this command.

In most cases this is no problem, as the NVM default value is to set it to
its maximum value of 9728. Unfortunately, since recent versions the intelxl
driver maintained within the iPXE network boot stack now issues the 0x0603
command to set the maximum frame size to a low value. This appears to have
occurred because the same intelxl driver is used for both the E700 and E800
series hardware, and both devices support the same 0x0603 AdminQ command.
The ice Linux PF driver already issues this command during probe.

Since commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set"), the
driver does check the I40E_PRTGL_SAH register, but it only logs a warning.
This register also only covers received packets and not transmitted
packets. Additionally, a warning does not help users, as the larger MTU is
still not supported.

Instead, have the i40e driver issue the Set MAC Config AdminQ command
during boot in a similar fashion to the ice driver. Additionally, instead
of just checking I40E_PRTGL_SAH, read and update its Max Frame Size field
to the expected 9K value as well.

This ensures the driver restores the maximum frame size to its expected
value at probe, rather than assuming that no other driver has adjusted the
MAC config.

This is a better user experience, as we now fix the issues with larger MTU
instead of merely warning. It also aligns with the way the ice E800 series
driver works.

Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Strictly speaking, the "Fixes" tag isn't entirely accurate. The failure is
really the result of changes in the iPXE driver to support both E700 and E800
within the same intelxl driver. However, I think the warning added by that
commit was an insufficient solution and we should be restoring the value to
its expected default rather than merely issuing a warning to the kernel
log. Thus, this "fixes" the driver to better handle this case.
---
 drivers/net/ethernet/intel/i40e/i40e_prototype.h |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_common.c    | 30 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c      | 17 +++++++++-----
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index aef5de53ce3b..26bb7bffe361 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -98,6 +98,8 @@ int i40e_aq_set_mac_loopback(struct i40e_hw *hw,
 			     struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_set_phy_int_mask(struct i40e_hw *hw, u16 mask,
 			     struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
+			   struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
 			   struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_set_link_restart_an(struct i40e_hw *hw,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 270e7e8cf9cf..f6b6a4925b27 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1189,6 +1189,36 @@ int i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures,
 	return status;
 }
 
+/**
+ * i40e_aq_set_mac_config
+ * @hw: pointer to the hw struct
+ * @max_frame_size: Maximum Frame Size to be supported by the port
+ * @cmd_details: pointer to command details structure or NULL
+ *
+ * Configure MAC settings for frame size (0x0603).
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ **/
+int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
+			   struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_set_mac_config *cmd;
+	struct libie_aq_desc desc;
+
+	if (max_frame_size == 0)
+		return -EINVAL;
+
+	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_set_mac_config);
+
+	cmd->max_frame_size = cpu_to_le16(max_frame_size);
+
+#define I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD	0x7FFF
+	cmd->fc_refresh_threshold =
+		cpu_to_le16(I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD);
+
+	return i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+}
+
 /**
  * i40e_aq_clear_pxe_mode
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b83f823e4917..4796fdd0b966 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16045,13 +16045,18 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %pe last_status =  %s\n",
 			ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 
-	/* make sure the MFS hasn't been set lower than the default */
 #define MAX_FRAME_SIZE_DEFAULT 0x2600
-	val = FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
-			rd32(&pf->hw, I40E_PRTGL_SAH));
-	if (val < MAX_FRAME_SIZE_DEFAULT)
-		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set below the default (%d)\n",
-			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
+
+	err = i40e_aq_set_mac_config(hw, MAX_FRAME_SIZE_DEFAULT, NULL);
+	if (err) {
+		dev_warn(&pdev->dev, "set mac config ret =  %pe last_status =  %s\n",
+			 ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
+	}
+
+	/* Make sure the MFS is set to the expected value */
+	val = rd32(hw, I40E_PRTGL_SAH);
+	FIELD_MODIFY(I40E_PRTGL_SAH_MFS_MASK, &val, MAX_FRAME_SIZE_DEFAULT);
+	wr32(hw, I40E_PRTGL_SAH, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out

---
base-commit: d7e82594a45c5cb270940ac469846e8026c7db0f
change-id: 20250813-jk-fix-i40e-ice-pxe-9k-mtu-2b6d03621cd9

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


