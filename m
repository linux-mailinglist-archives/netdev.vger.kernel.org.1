Return-Path: <netdev+bounces-60400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2F81F0FC
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A671D2818DD
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468346521;
	Wed, 27 Dec 2023 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtC625hS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55985482FE
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703698709; x=1735234709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cRmJW9tNyoDafmN+5jZx2+c5vjjg3wdbbiSEthAjQS8=;
  b=EtC625hSqGXopdDAFFBZueV26YXQ4jjYX7M1tLK12VQS5iwErMBis5YW
   R+58vXtiKAlMVZrcAJIuZAPamkGXSfhv5I9omI/HScqc6B6j02Z7oPB+2
   aLqunygqtDwQVyGzPY3dCwli5BRTn0nVGbBk7Izcm8b2zYOAMpkOEfSTe
   O3AT7kEZrIdUpfWmn91HKi/mruhQCQ3iC8Oz2l0y6dnTlDG5fmR1eoP1v
   1S4x0CpqQjvb/gu6ugoZTnfYJSGsrYeEZ/6Zn0dv3zAgMGqEEBLV4tYQq
   Dyf22vQsW3VJM3RVAtkGDUVtF2NW5n/klRb/zJLn/TtNKEpDunGErjN32
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="460796848"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="460796848"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:38:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="1025436969"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="1025436969"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.24])
  by fmsmga006.fm.intel.com with ESMTP; 27 Dec 2023 09:38:28 -0800
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH iwl-net] idpf: avoid compiler padding in virtchnl2_ptype struct
Date: Wed, 27 Dec 2023 09:37:57 -0800
Message-ID: <20231227173757.1743001-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Config option in arm random config file is causing the compiler
to add padding. Avoid it by using "__packed" structure attribute
for virtchnl2_ptype struct.

Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312220250.ufEm8doQ-lkp@intel.com
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 8dc83788972..dd750e6dcd0 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -978,7 +978,7 @@ struct virtchnl2_ptype {
 	u8 proto_id_count;
 	__le16 pad;
 	__le16 proto_id[];
-};
+} __packed;
 VIRTCHNL2_CHECK_STRUCT_LEN(6, virtchnl2_ptype);
 
 /**
-- 
2.43.0


