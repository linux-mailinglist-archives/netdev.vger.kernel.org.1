Return-Path: <netdev+bounces-217503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A208B38EAA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16E87C25F2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A370F311954;
	Wed, 27 Aug 2025 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TG6XTEEz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF19310631
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334819; cv=none; b=mKuxxRGX8/E7PpAHQ6+Rm4gpCrLiLg3YrLvLyJRHm70v52zon2R8+c2weKcaFj1Rs9Uim24FLfMQDk8MeudvO3KRdKo9eTEqNPROQVVkCEnVw0yeeO2OrKBGu56TDRMY163dUszpLjp4GX1m1ehqDUJRC2AFwXK2zXNhFjBNKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334819; c=relaxed/simple;
	bh=n7mG46uF2K6//cTOXF9p9rBCE2/4OJ87mqjKXQ7R1gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sA4WubHKdwRzBQ1dOdOCitSf8/0UEpL2LxwryKbp3B/LiXprW49ypafdD+SCrYCNwSmMWgG6iUwgYCObD0IuWaSlcxJakIe2dpz8Rmpn/cNwcJTDweiEGlVVdwVJ3/xb3iuMP63e37VEv4oz/M2ByIuv7mJGDNyZBhTSTpgBy8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TG6XTEEz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756334818; x=1787870818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n7mG46uF2K6//cTOXF9p9rBCE2/4OJ87mqjKXQ7R1gg=;
  b=TG6XTEEzRHo6+aoUvOpb13avEMRCfwJuxeuX31VWRm9c4A478rTCidUW
   Xz+18NI5YNZHdYvUVvzH3KzC5TYCxh5nqxaHrOPDEvXOQAG34VUr7NCbz
   TMotj1JNuZMvqPqwOktyySbOAW6hMfjWXtEQeVzkKEsKob8AkyVQzGG8w
   oTCs18SYSxyXkBHfwiPdMCJ/eirCX3NgiGezJ1AvWMQ7dosXmtTWLkceN
   L3f11/TvhZgZlsBzBKj4HpuX/zwUz0co0jSCrKgSLZf8pv6Z/xR2/2ccj
   eVk12LKlFC0pLKjw7XljvALy55kpjroKuyi1P9ayHM1v0lTjaTXqfCzl9
   Q==;
X-CSE-ConnectionGUID: 88H2y7pCRFmMhnmQKUHp4Q==
X-CSE-MsgGUID: VI3R+jEeSz+V6CQ4d2OiEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70037266"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70037266"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:46:50 -0700
X-CSE-ConnectionGUID: 4k4cF+QgTNW2x7EXFqhlCQ==
X-CSE-MsgGUID: BG1Hx1H7Qt6fz/zUBgcQbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169555025"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 27 Aug 2025 15:46:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	kuniyu@google.com
Subject: [PATCH net-next 08/12] ice: split RSS stuff out of virtchnl.c - tmp rename
Date: Wed, 27 Aug 2025 15:46:23 -0700
Message-ID: <20250827224641.415806-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250827224641.415806-1-anthony.l.nguyen@intel.com>
References: <20250827224641.415806-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Temporary rename of virtchnl.c into rss.c

In order to split virtchnl.c in a way that makes it much easier
to still blame new file, we do it via multiple git steps.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                   | 2 +-
 drivers/net/ethernet/intel/ice/virt/{virtchnl.c => rss.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/net/ethernet/intel/ice/virt/{virtchnl.c => rss.c} (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 263b0cfcb30b..852f06064678 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -50,7 +50,7 @@ ice-$(CONFIG_PCI_IOV) +=	\
 	virt/allowlist.o	\
 	virt/fdir.o		\
 	virt/queues.o		\
-	virt/virtchnl.o		\
+	virt/rss.o		\
 	ice_vf_mbx.o		\
 	ice_vf_vsi_vlan_ops.o	\
 	ice_vf_lib.o
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/rss.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/virt/virtchnl.c
rename to drivers/net/ethernet/intel/ice/virt/rss.c
-- 
2.47.1


