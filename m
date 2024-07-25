Return-Path: <netdev+bounces-113108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9716993CAAD
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87301C21445
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9876F143875;
	Thu, 25 Jul 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWdAfZkk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BB13D531
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721945343; cv=none; b=Mcp1KNxQ7Kruj9KhXerclRu5b+twuep5RBhjwyip4xvwrk1hze6AYH8QOgc4H681CCiT4HH0VyaO2LeYQqldrSHgW4B555Ng+2fkhcwVJ125edhZ0QLlqDoJ2MGvAgwM2Kt3/vN063eB6WbzJa4Ae/AGDUHm5UP4HnRSmHiIE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721945343; c=relaxed/simple;
	bh=yOMvGONTz6voeoYDVKKif51gxiH/fasIzag5jalvqfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uz/XMoXpRE1mnE6XOXCiulPVZ6bLlsXPk/7fx8k0gWIO+1gweYY+UjxREC7ivlL49Cg+DzZo+EIng4jjooFp59zXZluudqNcaudzU6jht8rjPOi1OS9UWEloUocM+NzsAh2pglwl1jpP2a4DBdtdSMZIz1jBRVWG8uoOfLLiH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWdAfZkk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721945342; x=1753481342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOMvGONTz6voeoYDVKKif51gxiH/fasIzag5jalvqfo=;
  b=nWdAfZkkNLvZXyoYcnMPCIK02kezkK+VgXM63zf87fjoxtFMeXYzZ0uG
   EY0Nb2nDwU7qIMR2QKl/clG5kWrl5qIbVxBB2EwFX5ILhFBGQzVm8Nj3o
   RMgs9xRBNji8oFyJv8nXCfSqWiXp+1hb/r8Z5ufSdjtK2QuTmZaRMNxVQ
   KqNSy6bSZsEViaKEG3CJR1b7za03b+ZEA6qoG/0v/8XZNIujJtPd5lWPS
   g3CDbTf2ZA96L9i9xXjCzCCC87bI4f6rcq/tzLgmEBFulm1hGmSNoVNyD
   vqupcG0Lql1Wyv8Ge6+cNCaT86sBcSHxH9KfaN/IQl40LOwa/ccj9ua/C
   A==;
X-CSE-ConnectionGUID: mYG7jPWdTNi6RaWr91TYEg==
X-CSE-MsgGUID: ltoCjtaAShuGf1WWO4jKGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19520543"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19520543"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:09:02 -0700
X-CSE-ConnectionGUID: 0tbE/hZDT/mZAn2mvBQ0qg==
X-CSE-MsgGUID: 6ypWcob/TCuuwCxrYN2RQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="52956224"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.246.33])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:08:58 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	hkelam@marvell.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH iwl-next v5 09/13] virtchnl: support raw packet in protocol header
Date: Thu, 25 Jul 2024 16:08:05 -0600
Message-ID: <20240725220810.12748-10-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725220810.12748-1-ahmed.zaki@intel.com>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junfeng Guo <junfeng.guo@intel.com>

The patch extends existing virtchnl_proto_hdrs structure to allow VF
to pass a pair of buffers as packet data and mask that describe
a match pattern of a filter rule. Then the kernel PF driver is requested
to parse the pair of buffer and figure out low level hardware metadata
(ptype, profile, field vector.. ) to program the expected FDIR or RSS
rules.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
---
 include/linux/avf/virtchnl.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 8e177b67e82f..4f78a65e33dc 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -1121,6 +1121,7 @@ enum virtchnl_vfr_states {
 };
 
 #define VIRTCHNL_MAX_NUM_PROTO_HDRS	32
+#define VIRTCHNL_MAX_SIZE_RAW_PACKET	1024
 #define PROTO_HDR_SHIFT			5
 #define PROTO_HDR_FIELD_START(proto_hdr_type) ((proto_hdr_type) << PROTO_HDR_SHIFT)
 #define PROTO_HDR_FIELD_MASK ((1UL << PROTO_HDR_SHIFT) - 1)
@@ -1266,13 +1267,22 @@ struct virtchnl_proto_hdrs {
 	u8 pad[3];
 	/**
 	 * specify where protocol header start from.
+	 * must be 0 when sending a raw packet request.
 	 * 0 - from the outer layer
 	 * 1 - from the first inner layer
 	 * 2 - from the second inner layer
 	 * ....
 	 **/
 	int count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
-	struct virtchnl_proto_hdr proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
+	union {
+		struct virtchnl_proto_hdr
+			proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
+		struct {
+			u16 pkt_len;
+			u8 spec[VIRTCHNL_MAX_SIZE_RAW_PACKET];
+			u8 mask[VIRTCHNL_MAX_SIZE_RAW_PACKET];
+		} raw;
+	};
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(2312, virtchnl_proto_hdrs);
-- 
2.43.0


