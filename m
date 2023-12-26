Return-Path: <netdev+bounces-60315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944981E8C0
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B954B281E72
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 17:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4A50246;
	Tue, 26 Dec 2023 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7/B+XWG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598C4F8BB
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703612498; x=1735148498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cTAsOrdPIchENaXCkjQlpOgGurW6CJNSPdFBet5VU5c=;
  b=j7/B+XWGKCXNF7++ogchi6/oUwijUtele4EY1f6ON1eQSi4Jckk3NhFO
   4H4Ej5oBJOUNN3E626SPui0pJVF4Sxr7QcAUrlKd3rfFxdkMJuEIbqRua
   xvl6UmzQZqr3aTIyENZVpGGcFbhNJvMKGegL0YSIjToAjQKKWv/kf8yqw
   HhH/6xsIEROJceU8+jw1UM7xkQSxl1giXeCon0Ouh7j9t9/CaRsjxjRFf
   tWlM4rrA4IiuEMmUgNkyfIZwmDbktG4paFp5ha2S4ujhvd00nNDlmLvGg
   evPAD0mFltZL8UABbgC7qoOmldLDGG85rFVPs41aytWebL9J9AvVpuKSw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="396099072"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="396099072"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 09:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="868638796"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="868638796"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2023 09:41:35 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Simon Horman <horms@kernel.org>,
	Scott Register <scott.register@intel.com>
Subject: [PATCH net 2/2] idpf: avoid compiler introduced padding in virtchnl2_rss_key struct
Date: Tue, 26 Dec 2023 09:41:24 -0800
Message-ID: <20231226174125.2632875-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231226174125.2632875-1-anthony.l.nguyen@intel.com>
References: <20231226174125.2632875-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Scott Register <scott.register@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 07e72c72d156..8dc837889723 100644
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
2.41.0


