Return-Path: <netdev+bounces-45520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE927DDC8F
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 07:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB477280F7C
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 06:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7D84C8E;
	Wed,  1 Nov 2023 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7T8ht7s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5305667
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 06:22:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9A98;
	Tue, 31 Oct 2023 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698819766; x=1730355766;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9wz2LHUoWqpe98OcYQ2/Jx5c2J985NHQToFkCmXdymk=;
  b=g7T8ht7szX+KKcdvkx4bi2CPwGP4BPuxZDyNrPbwE9MR/1r9HehhaEOB
   qpLonj9rtYCBivIYLPcD4YwsNzVrVt0DfG4X2CxxsrWDGaDYyDlBoa8+T
   QpQ+GamJ2IwxNon3odGhtFnFEYV0Cth+k+UoWI/0iajb4/TULW4Fd/2n9
   zMvCaFNmk7yBEEjgOuRGo5y5Tvz2l9MxqLDf6WvrYhknM0RUL5bt7V67g
   APt25+35fzn3BCahNtLei4Bnp+ygN2V6WIJ41mpk1bGYTvyhjYptMJIz3
   F4XUw9TyacuPoTisDAUbanncVpyA7LuyuUmDEtFEvxys7VTc2/A61fVcz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="454914644"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="454914644"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 23:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1995351"
Received: from ssid-ilbpg3-teeminta.png.intel.com ([10.88.227.74])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2023 23:22:41 -0700
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
Subject: [PATCH net-next v2 1/1] net: stmmac: check CBS input values before configuration
Date: Wed,  1 Nov 2023 14:19:20 +0800
Message-Id: <20231101061920.401582-1-yi.fang.gan@intel.com>
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
Idleslope is always a positive value including zero.
Sendslope is always a negative value including zero.
Hicredit is always a positive value including zero.
Locredit is always a negative value including zero.

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


