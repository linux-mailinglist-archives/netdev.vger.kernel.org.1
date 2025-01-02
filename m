Return-Path: <netdev+bounces-154794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7799FFCE1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B546E1881415
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7D1B4F23;
	Thu,  2 Jan 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="FhJT2JN/"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AFE1B4121;
	Thu,  2 Jan 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839466; cv=none; b=mJ5uT0T0s8qvAW6qEoCRgGXIOBAEU1qnNHCnDzj4NJSk3MU8pHN7ha+31l8VvC/+sFH3CX6KdsO6WIu1Vpzmeu+p54RBypYtchKuHn59qMY0zmbiZc8yY6n0Hueg1Ubb79USWtmtdGttel7muGXW3w7knAIXGt/s/+MeX35dnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839466; c=relaxed/simple;
	bh=ZpLbs8G4b/CfoPAXsSFSWGB6YncnYJDKCOKcfpnpyfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/g+DjPaUEzn/6gx5YnGpgbiJwmLFUl4YZCp6DSJbsc3ce5lqimFcYfYQtE6nqScBX+UObQNDpgE6gs0PlgR+x4mNTUT6soYSMK4BKNV1+58ziayp/nZTHXajW2MfHQxLRN9RUip1dYiedvs22RgNzFK1sh7g/hUw1X3IGkpK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=FhJT2JN/; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=AHVpFzSjHV15hL40UVEK2lfc9SE8GqU1vNkl27mvewE=; b=FhJT2JN/FtzReiV6
	cBJEkAuerFCXxuN0L/SpkbPn+AMeTKlaZbawGVPtDPqPb/18SkogYgoSSKwu6zUh1t7RwYDsiNuGx
	981kp/Zyts96MQ+FzWDDCvPbYwzRDSuoRan/qrilyXMG0+1HFDUzHVqIx1HmwLBBbu1Oc6gfWJx7Y
	Sk6CLk3dmzl5XchbOzVEkgTkvw8e2eL95G63SPItqMaX5yqSU6id/Bxm2QLnOe1FCwLTQ4uTIOx/D
	CqnCORodMcLalYMqAn08JjGqtTnALVo44OIq8sRc+ilEwb6revwCvMl6A0wKpQjogGiVtM3dyU42X
	5SGb/9lfyn6Co1XKGg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tTP8M-007tod-2I;
	Thu, 02 Jan 2025 17:37:22 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 4/9] i40e: Deadcode profile code
Date: Thu,  2 Jan 2025 17:37:12 +0000
Message-ID: <20250102173717.200359-5-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
References: <20250102173717.200359-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

i40e_add_pinfo_to_list() was added in 2017 by
commit 1d5c960c5ef5 ("i40e: new AQ commands")

i40e_find_section_in_profile() was added in 2019 by
commit cdc594e00370 ("i40e: Implement DDP support in i40e driver")

Neither have been used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 72 -------------------
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  8 ---
 2 files changed, 80 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 6779e281a648..370b4bddee44 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4882,39 +4882,6 @@ i40e_find_segment_in_package(u32 segment_type,
 #define I40E_SECTION_HEADER(profile, offset)				\
 	(struct i40e_profile_section_header *)((u8 *)(profile) + (offset))
 
-/**
- * i40e_find_section_in_profile
- * @section_type: the section type to search for (i.e., SECTION_TYPE_NOTE)
- * @profile: pointer to the i40e segment header to be searched
- *
- * This function searches i40e segment for a particular section type. On
- * success it returns a pointer to the section header, otherwise it will
- * return NULL.
- **/
-struct i40e_profile_section_header *
-i40e_find_section_in_profile(u32 section_type,
-			     struct i40e_profile_segment *profile)
-{
-	struct i40e_profile_section_header *sec;
-	struct i40e_section_table *sec_tbl;
-	u32 sec_off;
-	u32 i;
-
-	if (profile->header.type != SEGMENT_TYPE_I40E)
-		return NULL;
-
-	I40E_SECTION_TABLE(profile, sec_tbl);
-
-	for (i = 0; i < sec_tbl->section_count; i++) {
-		sec_off = sec_tbl->section_offset[i];
-		sec = I40E_SECTION_HEADER(profile, sec_off);
-		if (sec->section.type == section_type)
-			return sec;
-	}
-
-	return NULL;
-}
-
 /**
  * i40e_ddp_exec_aq_section - Execute generic AQ for DDP
  * @hw: pointer to the hw struct
@@ -5137,45 +5104,6 @@ i40e_rollback_profile(struct i40e_hw *hw, struct i40e_profile_segment *profile,
 	return status;
 }
 
-/**
- * i40e_add_pinfo_to_list
- * @hw: pointer to the hardware structure
- * @profile: pointer to the profile segment of the package
- * @profile_info_sec: buffer for information section
- * @track_id: package tracking id
- *
- * Register a profile to the list of loaded profiles.
- */
-int
-i40e_add_pinfo_to_list(struct i40e_hw *hw,
-		       struct i40e_profile_segment *profile,
-		       u8 *profile_info_sec, u32 track_id)
-{
-	struct i40e_profile_section_header *sec = NULL;
-	struct i40e_profile_info *pinfo;
-	u32 offset = 0, info = 0;
-	int status = 0;
-
-	sec = (struct i40e_profile_section_header *)profile_info_sec;
-	sec->tbl_size = 1;
-	sec->data_end = sizeof(struct i40e_profile_section_header) +
-			sizeof(struct i40e_profile_info);
-	sec->section.type = SECTION_TYPE_INFO;
-	sec->section.offset = sizeof(struct i40e_profile_section_header);
-	sec->section.size = sizeof(struct i40e_profile_info);
-	pinfo = (struct i40e_profile_info *)(profile_info_sec +
-					     sec->section.offset);
-	pinfo->track_id = track_id;
-	pinfo->version = profile->version;
-	pinfo->op = I40E_DDP_ADD_TRACKID;
-	memcpy(pinfo->name, profile->name, I40E_DDP_NAME_SIZE);
-
-	status = i40e_aq_write_ddp(hw, (void *)sec, sec->data_end,
-				   track_id, &offset, &info, NULL);
-
-	return status;
-}
-
 /**
  * i40e_aq_add_cloud_filters
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index bfebe18c0041..ccb8af472cd7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -452,20 +452,12 @@ int i40e_aq_get_ddp_list(struct i40e_hw *hw, void *buff,
 struct i40e_generic_seg_header *
 i40e_find_segment_in_package(u32 segment_type,
 			     struct i40e_package_header *pkg_header);
-struct i40e_profile_section_header *
-i40e_find_section_in_profile(u32 section_type,
-			     struct i40e_profile_segment *profile);
 int
 i40e_write_profile(struct i40e_hw *hw, struct i40e_profile_segment *i40e_seg,
 		   u32 track_id);
 int
 i40e_rollback_profile(struct i40e_hw *hw, struct i40e_profile_segment *i40e_seg,
 		      u32 track_id);
-int
-i40e_add_pinfo_to_list(struct i40e_hw *hw,
-		       struct i40e_profile_segment *profile,
-		       u8 *profile_info_sec, u32 track_id);
-
 /* i40e_ddp */
 int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
 
-- 
2.47.1


