Return-Path: <netdev+bounces-58141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F3D8154A3
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 00:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812181C24051
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 23:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A6D1DDC5;
	Fri, 15 Dec 2023 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pk/1nUH4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87D118EDA
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702684226; x=1734220226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jeuw+gV3HerAJEKsYkEcIEaLL5vpGvorWy07Lc9qDCo=;
  b=Pk/1nUH4diQ4y+7smlGif8HUoNC4Nsk95+1Nh4U23g7LTUS0sGvVYrhZ
   PyKrrHnVsuAPckwRhoaOmtkecnULxtLRcm35sLHWgDHYGGv4tAL1gid1e
   IMnPUubslVgSEXL+7nOt2Ix2R1PZfETsEvwDLZdXWeyCeA7QoiamJq576
   gXmGWyFSLofD8gOkfh4RFIFBJEx4mZ2ZSQ4gcMpRg7ikefZaMSnR0Pg5C
   zKYjoS43vZWLp2IJgkPBET285reuJIPgYM8Ezngg+P/eSawArJYG/UP5Y
   Y38E+VI26cZreI12nEnytMvdEydYOVyCz07VB0urshe7CrU0wlm7dvQDw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="398128496"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="398128496"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:50:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="845280881"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="845280881"
Received: from unknown (HELO lo0-100.bstnma-vfttp-361.verizon-gni.com) ([10.166.80.24])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2023 15:50:25 -0800
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH iwl-net] idpf: avoid compiler introduced padding in virtchnl2_rss_key struct
Date: Fri, 15 Dec 2023 15:48:07 -0800
Message-Id: <20231215234807.1094344-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Size of the virtchnl2_rss_key struct should be 7 bytes but the
compiler introduces a padding byte for the structure alignment.
This results in idpf sending an additional byte of memory to the device
control plane than the expected buffer size. As the control plane
enforces virtchnl message size checks to validate the message,
set RSS key message fails resulting in the driver load failure.

Remove implicit compiler padding by using "__packed" structure
attribute for the virtchnl2_rss_key struct.

Also there is no need to use __DECLARE_FLEX_ARRAY macro for the
'key_flex' struct field. So drop it.

Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 07e72c72d15..8dc83788972 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -1104,9 +1104,9 @@ struct virtchnl2_rss_key {
 	__le32 vport_id;
 	__le16 key_len;
 	u8 pad;
-	__DECLARE_FLEX_ARRAY(u8, key_flex);
-};
-VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_rss_key);
+	u8 key_flex[];
+} __packed;
+VIRTCHNL2_CHECK_STRUCT_LEN(7, virtchnl2_rss_key);
 
 /**
  * struct virtchnl2_queue_chunk - chunk of contiguous queues
-- 
2.38.1


