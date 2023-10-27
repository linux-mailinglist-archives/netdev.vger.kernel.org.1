Return-Path: <netdev+bounces-44650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909F87D8E8D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1674AB20ECF
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899B58C0C;
	Fri, 27 Oct 2023 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWfSHQFj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7C5245
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:15:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4E1B1;
	Thu, 26 Oct 2023 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698387356; x=1729923356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RzxknOAHxhYQy517vTA+5JreFWE2tbMpxk8ZOQ6gyW0=;
  b=cWfSHQFj1f9YPlsrzzwgMWStoey8sg1NqQzcnoN6M4jUjdo6VZLStxZR
   BS51Z2zFqpWxs9FeOZd1Iwa5XuJt4V+txZM34UqjMwY9Xf+7DxC1gTmAU
   1epKuWlkvZ96yGsNNVvzSQ7YCTQgQ9BKUc37PekkNeXXia1WRN74guJM2
   m9XYNM5frPDRlbOazvm5WjRU/fxcHcbij3ZNdWLkb6ZXIWe8mMPPAafA3
   wXmmP3AzFFyncRzAWAfmU50fsZapN/BVj7BkZk/yOaeeTNClv5i/NftBx
   /MH4V7klG9JYbajAj9qb3XbmU1GvbU00W3FYSk901TkJA3m1qcovhcbNe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="473958859"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="473958859"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="735995360"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="735995360"
Received: from ssid-ilbpg3-teeminta.png.intel.com ([10.88.227.74])
  by orsmga006.jf.intel.com with ESMTP; 26 Oct 2023 23:14:21 -0700
From: Gan Yi Fang <yi.fang.gan@intel.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Gan Yi Fang <yi.fang.gan@intel.com>
Subject: [PATCH net-next 1/1] net: stmmac: check CBS input values before configuration
Date: Fri, 27 Oct 2023 14:11:14 +0800
Message-Id: <20231027061114.3792619-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>

Add check for below conditions before proceeding to configuration.
A message will be prompted if the input value is invalid.

Idleslope minus sendslope should equal speed_div.
Idleslope is always a positive value.
Sendslope is always a negative value.
Hicredit is always a positive value.
Locredit is always a negative value.

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index ac41ef4cbd2f..e8a079946f84 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -381,6 +381,11 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
+	if ((qopt->idleslope - qopt->sendslope != speed_div) ||
+	    qopt->idleslope < 0 || qopt->sendslope > 0 ||
+	    qopt->hicredit < 0 || qopt->locredit > 0)
+		return -EINVAL;
+
 	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
 	if (mode_to_use == MTL_QUEUE_DCB && qopt->enable) {
 		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue, MTL_QUEUE_AVB);
-- 
2.34.1


