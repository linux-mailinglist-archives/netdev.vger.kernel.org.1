Return-Path: <netdev+bounces-36547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D77B0581
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D7024282F4D
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E785134191;
	Wed, 27 Sep 2023 13:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C6A8C04;
	Wed, 27 Sep 2023 13:33:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9217510A;
	Wed, 27 Sep 2023 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695821611; x=1727357611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NUigNMShWhyuKldPxid5E/o6rZg3Y7HZGIR7UdP0JxM=;
  b=mP8bELOdjKk1+x4dO7Fr8P6UIvvjlEGScngpvxJ7NkmzUtSiTyP33rHK
   t6/2cX2XzkZzDwAXFJs5tODx++BLklg/6DVJlhY9ROuM+5CMPeLqiG/7Q
   fyyl7cvQURcP7R9enJU24D9yMvYKuYYuaQQBUKJQVdbaGUofN5Ug4/qsm
   rbfaGqaZXejKeMXNoKbaIb3idEQO7tQeiuQ1F2twigQ4+PHbSOjAy0R1b
   h97/of3N2jtxieS9zjO52nE08+iUWbxe//cQjRdmU1uw9iO0xcDS7Bk48
   3gWmYpDXyoIOeBeDJO8VXdOr+lHRHdqv4eV3z6pNRQL6ozzkRWCYfwZxg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="380700667"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="380700667"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="698866879"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="698866879"
Received: from pglc00352.png.intel.com ([10.221.235.155])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2023 06:09:24 -0700
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next 0/2] net: stmmac: TBS support for platform driver
Date: Wed, 27 Sep 2023 21:09:17 +0800
Message-Id: <20230927130919.25683-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
This patchset enable Time Based Scheduling(TBS) support for Tx queues
through the stmmac platform driver. For this a new per-queue
tx-config property, tbs-enabled is added to the devicetree.

Commit 7eadf57290ec ("net: stmmac: pci: Enable TBS on GMAC5 IPK PCI
entry") enables similar support for the stmmac pci driver.

Rohan G Thomas (2):
  dt-bindings: net: snps,dwmac: Time Based Scheduling
  net: stmmac: TBS support for platform driver

 .../devicetree/bindings/net/snps,dwmac.yaml   |  8 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++++++++++----
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 +++
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.26.2


