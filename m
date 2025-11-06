Return-Path: <netdev+bounces-236533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFFBC3DB19
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCAEA4E665C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607E234CFBD;
	Thu,  6 Nov 2025 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNaOtlKA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFECC2E0934;
	Thu,  6 Nov 2025 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469611; cv=none; b=X4Rlmr/k+4q3zsltFdIfphdrhbSvFDydsmCmF9FZQmtsv7XBbLNaSBUKbK0a15nhSeRtKbsbw7y1h5VRRzEayng21XT0UlnILat5JfsxDBVFLJ6jDg5H89S1+6Bmc52jIn/ZnP6IXLFDckLtGJFIkGOBJ1y+ugz2gAe8akPgeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469611; c=relaxed/simple;
	bh=PDtYsetj4ullHYxxDE7k74iGTbEI52Po1HqLVzRId8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4AlOTLynS+JbMCRYQD2MwzEygJ+6hPtwasidSzxubsHg8hHi0bXrL5uE7k+Ia1kfD996kbl8KYnQdQCpwDEZIHA1MlPcsJqSIvMt5j87aMy8k4ccfSGvxIjXGanPTn5Jn2wZmqBDoafzFNDumtOY+/MwpBDPn9XHQqU/k3GMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNaOtlKA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762469610; x=1794005610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDtYsetj4ullHYxxDE7k74iGTbEI52Po1HqLVzRId8E=;
  b=aNaOtlKAB8EDUYLsxX01mz2HdEgsi1WFjwWh25KqsiqvlweaKOV4OfPY
   E2weu63aUT8CrqdZnItOlk6wAruUGHDQQ6LnBT1RIm4IRtHI6r+/gfvg5
   H3No7nOhT/8ayNeTAEpsh84MObQ0SWPVUbijfh3WVQfYPm/QT25kSna9R
   QBu/jK/gEP2rwnLhJ7kxLwcdmCwlU1sBZ7sRCpxrzRFvHaJfXlup2R1C1
   TpiCD+Aw3ZeTGXWp+x13rfrzBRkKuwheQ2PKHVH3d5L5ETEzf39fS6CF4
   +6uFbQXLCRtaQas18pYosKT8KZvnKHVnP/gxlaHdWSMZiEGJFaHpWLQYK
   g==;
X-CSE-ConnectionGUID: kjSME+6rSoy8DPVNiCTCrg==
X-CSE-MsgGUID: Bgs8gowTSwCCEQyYeEyxwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64715895"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="64715895"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 14:53:28 -0800
X-CSE-ConnectionGUID: oW+5Qi1gSLGoZA1mXjSkYQ==
X-CSE-MsgGUID: Uxtd7IHjQeq4WkMI3l2xkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="188602814"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2025 14:53:27 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mohammad Heib <mheib@redhat.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 1/8] devlink: Add new "max_mac_per_vf" generic device param
Date: Thu,  6 Nov 2025 14:53:10 -0800
Message-ID: <20251106225321.1609605-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106225321.1609605-1-anthony.l.nguyen@intel.com>
References: <20251106225321.1609605-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

Add a new device generic parameter to controls the maximum
number of MAC filters allowed per VF.

For example, to limit a VF to 3 MAC addresses:
 $ devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
        value 3 \
        cmode runtime

Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 Documentation/networking/devlink/devlink-params.rst | 4 ++++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 0a9c20d70122..c0597d456641 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -151,3 +151,7 @@ own name.
    * - ``num_doorbells``
      - u32
      - Controls the number of doorbells used by the device.
+   * - ``max_mac_per_vf``
+     - u32
+     - Controls the maximum number of MAC address filters that can be assigned
+       to a Virtual Function (VF).
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9e824f61e40f..d01046ef0577 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -532,6 +532,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
 	DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
+	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -602,6 +603,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME "num_doorbells"
 #define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 70e69523412c..6b233b13b69a 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -112,6 +112,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME,
 		.type = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
+		.name = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME,
+		.type = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.47.1


