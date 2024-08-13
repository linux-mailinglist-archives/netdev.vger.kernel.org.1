Return-Path: <netdev+bounces-118230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABF1950FB0
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510BEB24D0A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A131AC43B;
	Tue, 13 Aug 2024 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFmjpJGs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4581ABECF
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587783; cv=none; b=X9yDDTfhX+7Z690JDMSAYN7Heue90pojCwWfcacyKXl/2IkGbwwhxc0ft9EzIjHpqAdCh6xjIZu1CHx1cX1sIdEQkBd2z4P6Mu3In9WouvBZ6tNh8iqgMRs+iaRSg67pXeFjuhkXpFpT2idX2Jgvo+Rcqvo5O2CLzMii7puREk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587783; c=relaxed/simple;
	bh=CcQgzfTQFOOFWMKkzuwilAdxpY11f/Y1xW1+W48wJd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDipYZ3lYU4Cc360RPiXgI3m6JfND+tJsncbg56A7/GSQDdsbCU4sOVqdX20QgKO4QoAYsL2JHuxuv7GBHW8dE8ejFs3RbEnqr9nox4KWTNfjk8HUvUIK7rbh89Cf7RbbzCrUZ5+w4qE7iNFcH3vceVGoqNYv6yjZc9j7b2aUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFmjpJGs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723587782; x=1755123782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CcQgzfTQFOOFWMKkzuwilAdxpY11f/Y1xW1+W48wJd8=;
  b=hFmjpJGs0Ez8cSF4ViN8Q+X22nwFRMfF4qVWhUHUPMlKLdL/vQijcBg2
   FD6qpAlkwUJbVZA7Lh64F9hvVWsPBkCCwlkbZ61hLwTEIkprN+2zBY1Pm
   jppr4L+lutIHDADwBG59uY2fUxeJ7GXg1t2qWTJheGShcL26CvWN0CfdO
   MZ2+VWODU6By2kQPWsb3QdyItqYMx3NE/Qf7ZxMIyJYfraGyDX9eY1O1q
   08Pf20FuVdVXf6NSkyfFxa5yd8ELoOtcfdSmR89A9Bew0CU2vGn2o2c8b
   tFCbbtb6jFaIrRmln3i07FPHZ5yDxzJif7i2YA3uDs9xMG47UC4ASvv6k
   A==;
X-CSE-ConnectionGUID: zJ12VPp7T0SnvxYZXPc0QA==
X-CSE-MsgGUID: w8GQBEetRPeL4AO64I2k9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39287122"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="39287122"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 15:22:56 -0700
X-CSE-ConnectionGUID: 7tJgwjDkTW2ggQ2hXmFpaw==
X-CSE-MsgGUID: T+K0+24PTwaNLkfDZk+aGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="59381082"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 13 Aug 2024 15:22:55 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Junfeng Guo <junfeng.guo@intel.com>,
	anthony.l.nguyen@intel.com,
	ahmed.zaki@intel.com,
	madhu.chittim@intel.com,
	horms@kernel.org,
	hkelam@marvell.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v2 09/13] virtchnl: support raw packet in protocol header
Date: Tue, 13 Aug 2024 15:22:44 -0700
Message-ID: <20240813222249.3708070-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
References: <20240813222249.3708070-1-anthony.l.nguyen@intel.com>
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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.42.0


