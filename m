Return-Path: <netdev+bounces-217497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A6B38EA3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4987ACEB0
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30A30F94B;
	Wed, 27 Aug 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDxm5KZH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC61DFF0
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334813; cv=none; b=mSda3BVZ6aBS/Z4iJ0rp9vkQaUu7oFthXqOncS+eE4+p2jSL+ftNjTBI3T9U4WiUN+8Y0+ZF92hMJJIbA+GK73bR35YYWCgbm2uowiJh2ncXsEWbV00uGkSTZa5USliLH1aOHuj7g9G1zhdvNmeTmel51XA0SfHEpGXUy2SfkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334813; c=relaxed/simple;
	bh=2w6EEO4x2ZR7WwD05Vpm0bH57JiCy7kbw73t7x2IdLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoHSvdM7Zw/MsHoX10c5LLcOF3i4s5qrc1PKLk0ZSTA8GTbuTBq1G0Ixj2Q/QgMXXIv02+X1ck3s5j2WCZaDK9ZnvbdnDAXI9OPSuknZdsvhB/3d0Xk63B6vLUOjojuaYs1M8uLa8aHZNnfAi5WcOe00jKelGmpzzQTQtHgaMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDxm5KZH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756334811; x=1787870811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2w6EEO4x2ZR7WwD05Vpm0bH57JiCy7kbw73t7x2IdLs=;
  b=hDxm5KZH1W5QthajuXvslFr4lFKmGIoYhEknA73zRh51bfvxM+IwEuap
   jJMaD32ZMKxV/sf0nFJgdlLInV02JBWE9Xwi3UV9MX48Xl/tQOVtnDk2r
   vLgZUJmfwHGb0qINkDiKxPeeXMCGn7Jo+bOu6e8+g/+QVi3GbS8omm/4q
   jhGRuQjqbQYdMgQDA4lLz8vLHFpQ64BNfg6ucZ/HGXzr01Epdu1OprQ8c
   WG+AHnlKaJkUGs6orNQ7HLslTjnM48Sr1cmYMuiGpUnmaV9Y4abepwTS8
   J1dbHMXpjAV0dKN9hh061fWW18Al1Sw4MJEnYnKhdGSk3/pqzbI/1oMyz
   g==;
X-CSE-ConnectionGUID: NherzpgRRHCyx4YBqnNj1w==
X-CSE-MsgGUID: XXMI+j3TSye46+zj18gQKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70037222"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70037222"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:46:49 -0700
X-CSE-ConnectionGUID: jV3GUCICTR6CO8g4bLKy+Q==
X-CSE-MsgGUID: 5LNwQSTNQ+CKXay8kB3O4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169555004"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 27 Aug 2025 15:46:49 -0700
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
Subject: [PATCH net-next 02/12] ice: split queue stuff out of virtchnl.c - tmp rename
Date: Wed, 27 Aug 2025 15:46:17 -0700
Message-ID: <20250827224641.415806-3-anthony.l.nguyen@intel.com>
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

Temporary rename of virtchnl.c into queues.c

In order to split virtchnl.c in a way that makes it much easier
to still blame new file, we do it via multiple git steps.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                      | 2 +-
 drivers/net/ethernet/intel/ice/virt/{virtchnl.c => queues.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/net/ethernet/intel/ice/virt/{virtchnl.c => queues.c} (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index f1395282a893..31904b684517 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -47,9 +47,9 @@ ice-y := ice_main.o	\
 	 ice_adapter.o
 ice-$(CONFIG_PCI_IOV) +=	\
 	ice_sriov.o		\
-	virt/virtchnl.o		\
 	virt/allowlist.o	\
 	virt/fdir.o		\
+	virt/queues.o		\
 	ice_vf_mbx.o		\
 	ice_vf_vsi_vlan_ops.o	\
 	ice_vf_lib.o
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/queues.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/virt/virtchnl.c
rename to drivers/net/ethernet/intel/ice/virt/queues.c
-- 
2.47.1


