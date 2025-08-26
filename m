Return-Path: <netdev+bounces-216891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412F2B35C72
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EF2188181C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74C34165F;
	Tue, 26 Aug 2025 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaPlXh+R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F0321F5C;
	Tue, 26 Aug 2025 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207694; cv=none; b=ZNM8s769wp5th91Iewsjw4ly1/nHI4a7DAH887/Pmiit05UatdP0aqkMUZWABCj2bfs5UOa6NZq3Di3YOzQjSA1/6njOTrlLHzK5TNe4cRXPTlrWC26GWV9pVMCEVyv7sda2m2KChvofk3/IqnMUvaQDQNI/4uW9roKiY4HXkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207694; c=relaxed/simple;
	bh=eXfl58E1fRta3YHdqeADtIDJlpOXBQxOXSwkGGvk58M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ea1w7uNwvgLhvmpboKG3y5+6gEBQQpYSBQDv2NOuWCnlJ+F8wIHHz8ikdPBBswtk1rq0tVhgboZJvgyZ60cxeblWTPiVmP2SdmEaOYB8sstRsSKa1nMMCeP2taUgNtUSZ1eg18QXjZtsPQBzjGoMdRQY7PoJzr9GenprnQp7wFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaPlXh+R; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756207693; x=1787743693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eXfl58E1fRta3YHdqeADtIDJlpOXBQxOXSwkGGvk58M=;
  b=iaPlXh+RzqXvs0VEhwfcu7a4Nb+qjPvMm/r1hsC+nLdB9hT+a2/dRklS
   fbxoZo3gvsZwT/xde19pjSCQCy0J1CZ4xvOL5r43jdNVfOrPtvfr9cGVe
   /lQ6eQXPVJBt3Pltrsq3AIU9vTUVMQuDUZ9PDU1arfkuExxjRehmgczHW
   K95URHul8Knc4u02MwiekXlg+dG/Q8cPt3FJnHsDtvHnQuk+XLwUH1oaj
   zSsmarWubYixAFQE5S9wcneNYiYveellYUld9DMiXtbt3MqnMOzeDHLRd
   WZyMDMlU0t6Oi/GzomTlfWHDlDRRdwS4I1xpvqMh2nixe6OWdUeKHWB5g
   g==;
X-CSE-ConnectionGUID: bMBN01myRa+gLKiXTHnq+g==
X-CSE-MsgGUID: 5Zcbff3vQEOJoyGQP0wguA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62269259"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62269259"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:28:13 -0700
X-CSE-ConnectionGUID: ivV1y4e/RiSMoUFjfUHx9Q==
X-CSE-MsgGUID: um33PhChRrOAGcsIaiZ4oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173725764"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 04:28:10 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next 1/7] net: stmmac: replace memcpy with strscpy in ethtool
Date: Tue, 26 Aug 2025 13:32:41 +0200
Message-Id: <20250826113247.3481273-2-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel exception by replacing memcpy with strscpy when used with
safety feature strings in ethtool logic.

[  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
[  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571

[  +0.000005] Call Trace:
[  +0.000004]  <TASK>
[  +0.000003]  dump_stack_lvl+0x6c/0x90
[  +0.000016]  print_report+0xce/0x610
[  +0.000011]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
[  +0.000108]  ? kasan_addr_to_slab+0xd/0xa0
[  +0.000008]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
[  +0.000101]  kasan_report+0xd4/0x110
[  +0.000010]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
[  +0.000102]  kasan_check_range+0x3a/0x1c0
[  +0.000010]  __asan_memcpy+0x24/0x70
[  +0.000008]  stmmac_get_strings+0x17d/0x520 [stmmac]

Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index f702f7b7bf9f..219a2df578ae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -795,7 +795,7 @@ static void stmmac_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 				if (!stmmac_safety_feat_dump(priv,
 							&priv->sstats, i,
 							NULL, &desc)) {
-					memcpy(p, desc, ETH_GSTRING_LEN);
+					strscpy(p, desc, ETH_GSTRING_LEN);
 					p += ETH_GSTRING_LEN;
 				}
 			}
-- 
2.34.1


