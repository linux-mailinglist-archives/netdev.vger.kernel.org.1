Return-Path: <netdev+bounces-110657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47B92DA49
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1A9282728
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B631198A05;
	Wed, 10 Jul 2024 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuTZdqAc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CF197A99
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644070; cv=none; b=NlXP+Ml/0uE03b4bPnFI1BrwBM/Ulw75YbfJ6qJhwn20tC658ijsAWdeD69pB+LDSvc4ypw/BcZEKTNHrfeNZJo4ulpX5FQ27QH68mREyCNlPbp+nx85WLoengypo4PTFQh2gyJ+TCb7T0iH+Xb3eqMYLBOdmX4DB1niw6I3d+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644070; c=relaxed/simple;
	bh=2yFiu1Og9cxMJXWXQ+vO2j1w/wU3jvz/fw4Fj8ypKf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuB3u2x4YMcH/4x4QPV8I7Q9n4qqnOo7xe+ObDXGOHqgrfWr9QoRIVzpRXdt4SIakP1IEbBNTYljWYM2O3xdwxBbz9a8pE1DPooTY4S8Zss2Ig2Qyuuf2h3VE/wQsIVW4KjF5d5Lf4e2n0iaoFbFNrjcluSZZQm5UPA3wtjJtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuTZdqAc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720644069; x=1752180069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2yFiu1Og9cxMJXWXQ+vO2j1w/wU3jvz/fw4Fj8ypKf0=;
  b=TuTZdqAc+UmP2S3Fo5UQ3pPjaQRl97Z9WnTvpiIdEZNDtg2uoVVolGMm
   PkgMleehhC03U+0miNbUFdBHb+LKxKKKnm4Rf6nlY1am2JCU9Lx2ty5gw
   +cXPpb9h0I2dnFRr/BZiD3xrwOElm15TkLgB1NX4hO52wBNU5Hbds26L3
   XZ0Pdmtc+A/T1Vm6z/CcanYjKrWFFeXODYJhMa6vywocHJDbN9U9W+dor
   WAprrb6fdkaB+5SRNVgkbTZo/QK/VxOwHaTY2PI8uq4p0rX5zQzBgfvpk
   S9G1U9WOuaaGFEfGzFsclUE39bsLnOgwmsjBphZB4LCOsosmPBCJPf/B3
   w==;
X-CSE-ConnectionGUID: LnWa+yq9TOuMXR4nkMEVkg==
X-CSE-MsgGUID: Hyue9Rn1TCS/vl88EHpGDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29153349"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29153349"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:41:09 -0700
X-CSE-ConnectionGUID: MTzFsQsqSKWh4NaOpAAJ8g==
X-CSE-MsgGUID: qxj66jW4TTmCarFGFJQPcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48301232"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.246.184])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:41:04 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next v3 09/13] virtchnl: support raw packet in protocol header
Date: Wed, 10 Jul 2024 14:40:11 -0600
Message-ID: <20240710204015.124233-10-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710204015.124233-1-ahmed.zaki@intel.com>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
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

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
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


