Return-Path: <netdev+bounces-127634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF8975EBF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB571F23903
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81B24211;
	Thu, 12 Sep 2024 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgHSLAoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D070AD39;
	Thu, 12 Sep 2024 02:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726106868; cv=none; b=inbLPBxzeMPmrI00zjxTwyjzLz0OEWLD2RShZoyjGUrMwHOXK9KFGQOjdCc5jZwvepzucg5SYtciGqe78WxMGPO1Yt0sZDZHJou52jkd+jUms/18WSAJ0fDRtiSbTlBoxf0ltA20qnEKpTvH9txFFJdsjUHAUr8rpJF1VSsz3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726106868; c=relaxed/simple;
	bh=2pC7oUHqvWMtu/IF0XFSSJJ+/UjqjyzX7Lx26PSeFBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZLDJkSg0eMHXKYXbGZbnZ6T2m8fpoQyaFawhFOYAM3tQs1p4a+nUNyrGbKh9Wh4Yz05NQoYZj/NGY4FmFyxbWzKsWiGm+jAHQdywgSQcLpnJTOCbP+yLc4jXKy/Yqz+Kdlo6B7Of2VpVZX3It48vELWRJA1TInMjhhsMi5CmtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgHSLAoJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726106868; x=1757642868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2pC7oUHqvWMtu/IF0XFSSJJ+/UjqjyzX7Lx26PSeFBE=;
  b=YgHSLAoJ9pWWTJZdyOK6FsP+OPKhSvpDn7NgV7VzNWeORkKK+LLl9XVF
   kGQMdv4QPIZSsdugqLSZ0zO4BLp7qksEPOcR60z/LDbJ2RiVZUl2b+MrY
   ePwrGLqRVa/ZxtfFCtNzw4so03+vGRj0oO8IKlmXHluEVy8zYCutigZbi
   56h/EhxoMmNdKKH9+knbVefA2hcKiOfqXSud+qiBXv3VHkLWuSPjLxIE2
   VCtS3/OQFvENoC8/CDxdmLTRJTqwG5G+Eu3Nz7ZHzBJeJkkwVpJS050Zg
   EEyDF/bJWANMPOaXliv19pXrQCbYLk5mz+goAd5z6svZfAb0qnl49uBIt
   g==;
X-CSE-ConnectionGUID: tBE9vKr1SricmQfMsKkWCg==
X-CSE-MsgGUID: RE/kCSzxQpGQhVi5O4ymhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25070648"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="25070648"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 19:07:47 -0700
X-CSE-ConnectionGUID: omHwZdw+SlO9u0NbszeNcw==
X-CSE-MsgGUID: iSlPjsQBTnKTSinp9R5LKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67174707"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 19:07:46 -0700
Received: from P12HL2yongliang.png.intel.com (P12HL2yongliang.png.intel.com [10.158.65.196])
	by linux.intel.com (Postfix) with ESMTP id 91C5A20CFEDA;
	Wed, 11 Sep 2024 19:07:42 -0700 (PDT)
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Tan Khai Wen <khai.wen.tan@intel.com>
Subject: [PATCH net 1/1] net: stmmac: Fix zero-division error when disabling tc cbs
Date: Thu, 12 Sep 2024 09:55:41 +0800
Message-Id: <20240912015541.363600-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit b8c43360f6e4 ("net: stmmac: No need to calculate speed divider
when offload is disabled") allows the "port_transmit_rate_kbps" to be
set to a value of 0, which is then passed to the "div_s64" function when
tc-cbs is disabled. This leads to a zero-division error.

When tc-cbs is disabled, the idleslope, sendslope, and credit values the
credit values are not required to be configured. Therefore, adding a return
statement after setting the txQ mode to DCB when tc-cbs is disabled would
prevent a zero-division error.

Fixes: b8c43360f6e4 ("net: stmmac: No need to calculate speed divider when offload is disabled")
Cc: <stable@vger.kernel.org>
Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 996f2bcd07a2..2c3fd9c66d14 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -392,10 +392,10 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	} else if (!qopt->enable) {
 		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
 				       MTL_QUEUE_DCB);
-		if (ret)
-			return ret;
+		if (!ret)
+			priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
 
-		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
+		return ret;
 	}
 
 	/* Final adjustments for HW */
-- 
2.25.1


