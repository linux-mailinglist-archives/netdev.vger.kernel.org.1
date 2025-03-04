Return-Path: <netdev+bounces-171592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 212B8A4DBF4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4829E3A9DFD
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE320012C;
	Tue,  4 Mar 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXpFyFJ5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AC1FE471
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086552; cv=none; b=padHIFGzvQepHaDaYZDuA8A77HTn7D7m1XWiaFf2QrnS3gSKy/qUMc2Y3R2xC/MosJau1yvT0uUgvXvQGnMGQDY5RjrjU9gmwTw/1dIX6dBh02gtoIZzxpPDgy8HXToFLnLiuaWlRG5ppcE/HjmCpyC+vb9BPFenLTd3PBfAnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086552; c=relaxed/simple;
	bh=xEO0/4wAT4eG6eNQ1IpmyEI3RGwFP/EaUa7el7XClz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQ+Hd+HwX1gWfBy2VfYM1uEAeMtZkCl8K8mqYe1KuLDRdlKa/Xto7cL/Gmh7oiaswCIB8orKFCLg23w5rOSOBcNW+MBzf0aEKdBjs5yph9m7kLemmf0y4Dnj/5b+TzViVmbHEH3hRajyTFHlER3/EoC8CtFp65uv0Nm8UhoC2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXpFyFJ5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741086550; x=1772622550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xEO0/4wAT4eG6eNQ1IpmyEI3RGwFP/EaUa7el7XClz0=;
  b=BXpFyFJ5xKw9PPbRhZpu4APEBtn+9HRXgWLDCoXsb0Hk7OadHke/y5Ix
   62remuc6L08F13t0ZaHN5POqlEdOn0ukvX49LOKW8wmwHgx5QEV7vRxTV
   1nWZqt1QRJs2BPP3hyC7aZRGcmVevSyOBdsb1gnExFUl+tFGVmt/FofxA
   wvLiM9Z1PgDf7mJ53rOADY4xeMNjaIQbYw2xbCl7fsOlVpnP0PuBwR6bM
   +XX2I/LTgo/6jVLqxMbOiJ8kBMehuITs6EXkhQZ9V4nwGklVdlTVJCZ/k
   2mm4NPM0py4VcbORXeXq5/cS17v0vPXWToMeWnlnkhsWXzb+Ec/SWG6xV
   Q==;
X-CSE-ConnectionGUID: +K4Nf8VNTUmCSVHtBti/3A==
X-CSE-MsgGUID: cKCwSeztQ9OfuctOvUJYEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41247013"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41247013"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:09:09 -0800
X-CSE-ConnectionGUID: eQVm/oVDTtigz5pNMmuHYQ==
X-CSE-MsgGUID: joD21DVDTq2Fr+2GAoOagQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118341327"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa007.fm.intel.com with ESMTP; 04 Mar 2025 03:09:07 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net v3 1/5] virtchnl: make proto and filter action count unsigned
Date: Tue,  4 Mar 2025 12:08:31 +0100
Message-ID: <20250304110833.95997-4-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250304110833.95997-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

The count field in virtchnl_proto_hdrs and virtchnl_filter_action_set
should never be negative while still being valid. Changing it from
int to u32 ensures proper handling of values in virtchnl messages in
driverrs and prevents unintended behavior.
In its current signed form, a negative count does not trigger
an error in ice driver but instead results in it being treated as 0.
This can lead to unexpected outcomes when processing messages.
By using u32, any invalid values will correctly trigger -EINVAL,
making error detection more robust.

Fixes: 1f7ea1cd6a374 ("ice: Enable FDIR Configure for AVF")
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 include/linux/avf/virtchnl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 4811b9a14604..cf0afa60e4a7 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -1343,7 +1343,7 @@ struct virtchnl_proto_hdrs {
 	 * 2 - from the second inner layer
 	 * ....
 	 **/
-	int count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
+	u32 count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
 	union {
 		struct virtchnl_proto_hdr
 			proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
@@ -1395,7 +1395,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(36, virtchnl_filter_action);
 
 struct virtchnl_filter_action_set {
 	/* action number must be less then VIRTCHNL_MAX_NUM_ACTIONS */
-	int count;
+	u32 count;
 	struct virtchnl_filter_action actions[VIRTCHNL_MAX_NUM_ACTIONS];
 };
 
-- 
2.47.0


