Return-Path: <netdev+bounces-224803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F9B8AABB
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A7E7BFAE3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D470320A00;
	Fri, 19 Sep 2025 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOecxGJP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAAD320393
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301173; cv=none; b=RL6WxMctdrX8JO81oBUaBlfPpgmeTrHyVSQkqqfVwgXXoJAp6/sfulOjrWvViSbm6i8WY7uwwvrV2uu3Wtnfv9zzyLzxo0IQ1gHqBqdRIujP2CP+Ln/KDooZzTQGZ04pC3FwjTJ1R89MrGE+JFwipS/vcdvEJbOOFMtiG2FpGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301173; c=relaxed/simple;
	bh=KpJlYT1x4u5WWUj2aXT5S081UgMT4FN/iUfY8e/Zo5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvUjKQRMcXy/6A6imQddGceIKS94eiCA0XqGVIRTuKFcbKFtHr1Axr7mA5sT0Mgd8RHLs0olALrwSjcqMtX8Q3iPOcslNc937IFQEIB1W8gCocIyDTlGTWaQILsgTYdlMXGhKwqZGPxW6SNexDX89qPTEnrTZ+Q9YrePLlnjZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOecxGJP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758301172; x=1789837172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KpJlYT1x4u5WWUj2aXT5S081UgMT4FN/iUfY8e/Zo5Q=;
  b=UOecxGJP5zpgg810H/TMSotLcv7s3+rg2Z888ErG+obUI+s2/V5O2Uzh
   HTF18ZvnFjAETp/vFW28BAxExAVq2i2xgGU1ts59uo6E86rOTp6TpWQ3A
   nrymNjQO4+lXodN+FLICPia2Ily+79nyEt7Ae2wUSOu+sB/gIPtfJlcTH
   SkEUc7Lt5qzJgLYa8FAds+22RvEHQGVnRPNwFYnPmoSNljX1TQ3My3utq
   D7DIrWAX5UZ+3+9cxpazPB2XmixA/uxhgza0VgeWqJeeDyGYivq6R2Z5+
   Qv0NvLk7rFlFEtnCuXpiY2CWtGuHx0PfEaJqs2Hst8h50fhJAcpHn8ZpQ
   g==;
X-CSE-ConnectionGUID: me1CyLS/StqtYts78LXKnw==
X-CSE-MsgGUID: OWHbQUYoRbiwoY+La9NZBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60763406"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60763406"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 09:59:31 -0700
X-CSE-ConnectionGUID: sn7J7KYiScSQDzB2d8odAQ==
X-CSE-MsgGUID: V3jOfLIhS8WrV+LC9xJnRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="180119864"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by orviesa004.jf.intel.com with ESMTP; 19 Sep 2025 09:59:31 -0700
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH] idpf: remove duplicate defines in IDPF_CAP_RSS
Date: Fri, 19 Sep 2025 11:59:05 -0500
Message-Id: <20250919165905.1599964-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate defines from the OR operation when defining IDPF_CAP_RSS.

Duplicate definitions were introduced when IDPF_CAP_RSS was originally
defined and were left behind and went unnoticed during a previous commit
that renamed them. Review of the original out-of-tree code confirms these
duplicates were the result of a typing error.

Remove the duplicates to clean up the code and avoid potential confusion.
Also verify no other duplicate occurrences of these defines exist
elsewhere in the codebase.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 0f320a2b92d2..21c50695348c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -732,13 +732,11 @@ static inline bool idpf_is_rdma_cap_ena(struct idpf_adapter *adapter)
 }
 
 #define IDPF_CAP_RSS (\
-	VIRTCHNL2_FLOW_IPV4_TCP		|\
 	VIRTCHNL2_FLOW_IPV4_TCP		|\
 	VIRTCHNL2_FLOW_IPV4_UDP		|\
 	VIRTCHNL2_FLOW_IPV4_SCTP	|\
 	VIRTCHNL2_FLOW_IPV4_OTHER	|\
 	VIRTCHNL2_FLOW_IPV6_TCP		|\
-	VIRTCHNL2_FLOW_IPV6_TCP		|\
 	VIRTCHNL2_FLOW_IPV6_UDP		|\
 	VIRTCHNL2_FLOW_IPV6_SCTP	|\
 	VIRTCHNL2_FLOW_IPV6_OTHER)
-- 
2.25.1


