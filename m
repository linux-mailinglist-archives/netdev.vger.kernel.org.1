Return-Path: <netdev+bounces-28818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A17780D0A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C882823F4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274118B18;
	Fri, 18 Aug 2023 13:54:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3F182A2
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:54:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF111FC;
	Fri, 18 Aug 2023 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692366846; x=1723902846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qPXTRHKErtcJGY5VhoyeJ8vFDNdIyRHpUI8T3Eq+zeQ=;
  b=gojtPGCxgoHQ9ISlsRjVRQU8LGGfte/uuzXXC2KX3vXuteiTalawiPql
   NAYhVCyIvEjTQUYkIgdBGndAuNl1fn8Kpqj+NJr30ws4joM1gpsKsEPSt
   zE8yI4OhExjUDcgt4SKDZDqPe+PU6LOZ/TpexToSXhy+VxUF+ea6vZ263
   4UF4V8KgWhH4jRCs6xdYwqMAP1kGSw5veL3YkyMWR9RVEtQrDqQcVXeJr
   efDo9Y9GfPrDx5pHZP6rPi4kZjD1dPORUfvgmiMQZzzmVrTdfpqVTYgmj
   joGNy9vCz+/lPl6Bu4hx7RALbyOQmwxEC40BInAK9do0DdgXRPlT+/F8I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="353407995"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="353407995"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="849307122"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="849307122"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 06:53:53 -0700
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
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v4 0/2] net: stmmac: Tx coe sw fallback
Date: Fri, 18 Aug 2023 21:53:48 +0800
Message-Id: <20230818135350.12474-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
Some DWMAC IPs support tx coe only for a few initial tx queues,
starting from tx queue 0. This patchset adds support for tx coe sw
fallback for those queues that don't support tx coe. Also, add binding
for snps,tx-queues-with-coe property.

changelog v4: 
* Replaced tx_q_coe_lmt with bit flag.

changelog v3: 
* Resend with complete email list.

changelog v2: 
* Reformed binding description.
* Minor grammatical corrections in comments and commit messages.

Rohan G Thomas (2):
  dt-bindings: net: snps,dwmac: Tx queues with coe
  net: stmmac: Tx coe sw fallback

 .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  5 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 ++++
 include/linux/stmmac.h                        |  1 +
 5 files changed, 32 insertions(+)

-- 
2.19.0


