Return-Path: <netdev+bounces-217851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BECB3A291
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC4817F524
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094EC3148DB;
	Thu, 28 Aug 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9+xIHUh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EA312814;
	Thu, 28 Aug 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392077; cv=none; b=qkHsCtHBGqQOUhb418F+iEI/BQjVvj9saBvtxfUBCa+zaP8hs6gUn09B+R+8+ZS5Z94hX/O4YTf4sIcRNQdmmXr0raGfUOoNwyaXM9wzJzkuBvg9fXfxyl+W62WRh7JWRcwBEkpFk/qakqkzU8SylMzeF0XyUkTpoPrvfjgilG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392077; c=relaxed/simple;
	bh=Xtf+Ux4m23iglcsKMxPsLhSHhwNaUtEG5Rt95hfHkio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cyfgSRgGLliWCiCTi+UQ8CmBWpgKF3qGYrvTSNdHNc9vM7GhFDaCzF2hWYY0e3ojohUCwWc02qPZbxscFDCLJI4d2gMTMnebQEsGNZ/WvywGH8mVviIaM9r0q72uZkt+HUr13hl+4ArVdIHpBqgQPfgH4kYNqQMPTL4tvMgIpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9+xIHUh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756392076; x=1787928076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xtf+Ux4m23iglcsKMxPsLhSHhwNaUtEG5Rt95hfHkio=;
  b=P9+xIHUhBOLhR0k+BW0CnuNenlYJtVVinIb7843mYnlUltHuoQtbC00B
   wyDiKB90kZm9bPhMyfyHIZMnrDZAfo5ZplXcAPy802z1Yc6Ib4BvlUJzv
   dz1PPpTtwiG0WPdIdt4HcyZu8CdWX0fGIRTc3xaMj+/ROtut/JkObApE2
   CLNm+mERVRnZG3mNd8X0JQ1605nWWKJZL2rF7HiCMylRY5g2aywZe6hc3
   cudrIhiHvH245Ps80wTUkY0B557IOIkGIhwkPsVD99fOmKb5CnF3+9jHx
   XRUyFXMEU5hZmgzctUfysQrQanx3r9u4XoS4ukBkhb72VrwIoXkODNEmG
   w==;
X-CSE-ConnectionGUID: aumcC8xpTnuAhlMMzDPoow==
X-CSE-MsgGUID: SiAd+VZFTMCWG//N4jkJaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58515375"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58515375"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 07:41:15 -0700
X-CSE-ConnectionGUID: 9csiW3iHQtmbONFVMSuY+g==
X-CSE-MsgGUID: 2JDCaMjYR2yWgtFF7+g0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207276069"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2025 07:41:12 -0700
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
Subject: [PATCH net-next 0/4] net: stmmac: new features
Date: Thu, 28 Aug 2025 16:45:54 +0200
Message-Id: <20250828144558.304304-1-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds four new patches which introduce features such as ARP
Offload support, VLAN protocol detection and TC flower filter support.

Patchset has been created as a result of discussion at [1].

[1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/

v1 -> v2:
- add missing SoB lines
- place ifa_list under RCU protection

Karol Jurczenia (3):
  net: stmmac: enable ARP Offload on mac_link_up()
  net: stmmac: set TE/RE bits for ARP Offload when interface down
  net: stmmac: add TC flower filter support for IP EtherType

Piotr Warpechowski (1):
  net: stmmac: enhance VLAN protocol detection for GRO

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 +++++++++-
 include/linux/stmmac.h                        |  1 +
 4 files changed, 50 insertions(+), 6 deletions(-)

-- 
2.34.1


