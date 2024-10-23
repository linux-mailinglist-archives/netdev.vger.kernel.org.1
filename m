Return-Path: <netdev+bounces-138160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C364A9AC719
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F358B25BA6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A00719E98D;
	Wed, 23 Oct 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFNhpwV9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15ED1586FE;
	Wed, 23 Oct 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677274; cv=none; b=CbmDFA5P9vyPPV08c7ynBf9cwO1aWLamRDbKXsLsnGzgrdUK6SEZSUJSBTR2vU7SoR9e4fofuTmBws8jw5i8jSEdhQEEltOk7ovl3NapKqaChDlEQH1g+J8WgNXkTt+b8wxlfydEEbgZMyRKMFoN6tuOrg/+tqIZsyPsa+Az2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677274; c=relaxed/simple;
	bh=Y5fuP3gzG9HVKuf3LvmENOmJFpaBGnVQOJHDRKFkUzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AiP/pf6gR9iipvYsXYOUZfz0AmYAYU2Kjn3UzSv6i0OAmhf5R0HfJ61cMwlSI3Hg4SIczsU8ee4KMReSimbPnR2AR8rs3dthtspxTczyAUS3A+9h8tcO5BSzJoMyv51e/2D8D4LKry+nDP4Ouaa1r/gHMmvRor4dAg8ZNFeN4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFNhpwV9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729677273; x=1761213273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y5fuP3gzG9HVKuf3LvmENOmJFpaBGnVQOJHDRKFkUzQ=;
  b=cFNhpwV93l8GjdLINivKml0bblq3FDzdDuIeN/0UgiufmojFklaxI9q1
   IC37G+VUnyKlPXgTjd67onZM8L0vQAX1FdJErBdsjjVkmQkL7POIV9+Rp
   Jb/CY3wBTSSPwptlDYHFFGSwn0BMJNn2HQFU92iqr7yG2+LQsaP2pcZrn
   kUlr6CZqV6wTQuUQxXRG9o3mqXKYK14xhejC3ILJtgVpPp+AV+fVO/rq0
   xvsX7iUeHtP8j1fwmtV17ZPIcosscnZbEIfdHG74hCTaf5NocuW3MLOlr
   3LyXHZ3/x9tqT67MWYpOO8gSIPAy1GrS1HWEx2k3P89vhh2i8mVmOdaH3
   g==;
X-CSE-ConnectionGUID: QlR7vwg9QSeI/0rgeuDlvQ==
X-CSE-MsgGUID: zliKbi7TQ7K/ae+wDzc1Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54658340"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="54658340"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 02:54:31 -0700
X-CSE-ConnectionGUID: EI7M5COJSQSXlWq5fUG4CA==
X-CSE-MsgGUID: 5MHYm0OTQq+4KntEPBKkvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84771106"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 02:54:28 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 08EE527BDE;
	Wed, 23 Oct 2024 10:54:26 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Konrad Knitter <konrad.knitter@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v1 1/3] pldmfw: selected component update
Date: Wed, 23 Oct 2024 12:07:01 +0200
Message-Id: <20241023100702.12606-2-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241023100702.12606-1-konrad.knitter@intel.com>
References: <20241023100702.12606-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable update of a selected component.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
---
 include/linux/pldmfw.h | 8 ++++++++
 lib/pldmfw/pldmfw.c    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/pldmfw.h b/include/linux/pldmfw.h
index 0fc831338226..f5047983004f 100644
--- a/include/linux/pldmfw.h
+++ b/include/linux/pldmfw.h
@@ -125,9 +125,17 @@ struct pldmfw_ops;
  * a pointer to their own data, used to implement the device specific
  * operations.
  */
+
+enum pldmfw_update_mode {
+	PLDMFW_UPDATE_MODE_FULL,
+	PLDMFW_UPDATE_MODE_SINGLE_COMPONENT,
+};
+
 struct pldmfw {
 	const struct pldmfw_ops *ops;
 	struct device *dev;
+	u16 component_identifier;
+	enum pldmfw_update_mode mode;
 };
 
 bool pldmfw_op_pci_match_record(struct pldmfw *context, struct pldmfw_record *record);
diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 6e1581b9a616..6264e2013f25 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -481,9 +481,17 @@ static int pldm_parse_components(struct pldmfw_priv *data)
 		component->component_data = data->fw->data + offset;
 		component->component_size = size;
 
+		if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
+		    data->context->component_identifier != component->identifier)
+			continue;
+
 		list_add_tail(&component->entry, &data->components);
 	}
 
+	if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
+	    list_empty(&data->components))
+		return -ENOENT;
+
 	header_crc_ptr = data->fw->data + data->offset;
 
 	err = pldm_move_fw_offset(data, sizeof(data->header_crc));
-- 
2.38.1


