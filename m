Return-Path: <netdev+bounces-27372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449FF77BAEF
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF642810CA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA470C136;
	Mon, 14 Aug 2023 14:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EDC120
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 14:06:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94973E3;
	Mon, 14 Aug 2023 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692022008; x=1723558008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CDzK91hrFBu3C3eQWjdbTzk2hWA6gCmI/7dZQVWE7PE=;
  b=UcJjx8AtR45so9ZsThfLdvKBwf74uOvLNfgpULEhLBYiILmfFsj3oToe
   pzdHHUtVUnOkcy7GhPnO/qCLNiFstnwZDdGw3jjA4mQ8llSjXHLaRnxs7
   YEGUA7tL5bJG1HphRZTsXVA96E6elzZerhioxgPNbiN8c5DqXKRBtiGFP
   tMELsXzI0ASRH66Fa9H1pNu3JylxZtXO+/T4PYlEXgDA+rDwmSLQRQUT2
   a80GNUqn5HI0M7fwjsDjHl7AFxkI2SCjiY2EfTGZi9D/7yOFNuj0WZTJL
   k7snkFSk/RFq6kaVUQA09WFIxdysoQ1440Ce+ok/zo1yGVZjSMeazoAwd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438377168"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="438377168"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683317889"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="683317889"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2023 07:06:43 -0700
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
Subject: [PATCH net-next v3 0/2] net: stmmac: Tx coe sw fallback
Date: Mon, 14 Aug 2023 22:06:35 +0800
Message-Id: <20230814140637.27629-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.19.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
Some DWMAC IPs support tx coe only for a few initial tx queues,
starting from tx queue 0. This patchset adds support for tx coe sw
fallback for those queues that don't support tx coe. Also, add binding
for snps,tx-queues-with-coe property.

changelog v3:
* Resend with complete email list

changelog v2: 
* Reformed binding description.
* Minor grammatical corrections in comments and commit messages.

Rohan G Thomas (2):
  dt-bindings: net: snps,dwmac: Tx queues with coe
  net: stmmac: Tx coe sw fallback

 .../devicetree/bindings/net/snps,dwmac.yaml   |  3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 ++++
 include/linux/stmmac.h                        |  1 +
 5 files changed, 29 insertions(+)

-- 
2.19.0


