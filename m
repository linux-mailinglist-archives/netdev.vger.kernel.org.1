Return-Path: <netdev+bounces-34041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DEC7A1BA8
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF32282614
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00DDF55;
	Fri, 15 Sep 2023 10:03:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F1D29B;
	Fri, 15 Sep 2023 10:03:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7294493;
	Fri, 15 Sep 2023 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694772165; x=1726308165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ed4YUZv03FL/7pT0GTcscmk26C9Wo3TferDm4a8fs+I=;
  b=PkhI5gk4YPFyjciC6siFEA9LbLJPsFAkfaJZeJqFi/dGhwtSdkvD6s00
   8LSX8vP8+8cMerKWtRuo3bOlS0v4DPzmcG9Fbl8mmE8Q/fIIdPFz6QqC5
   M2FP9OTDAl2kJ7PB9QI4UoULUS1tVLaw18meFDnstRXYJPktECcz8nZP/
   /mjxNpupZf5ijWN2BBHU/+UBciaCiRjHHAyMzfUO9AMxdrPizOMOa67R/
   k7dr1fx2CCPpHlbr8AQMd2VaUKayTg18iQm54DD/jUKS2wjF8w6xank7c
   ZtnJjkAmrXnYBusn4WvcYCbywdoTx+SQCa6qfKjQqpjuOX1DuqXOj8pEu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381938667"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="381938667"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744916284"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="744916284"
Received: from pglc00032.png.intel.com ([10.221.207.52])
  by orsmga002.jf.intel.com with ESMTP; 15 Sep 2023 02:54:20 -0700
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
	fancer.lancer@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v6 0/2] net: stmmac: Tx coe sw fallback
Date: Fri, 15 Sep 2023 17:54:15 +0800
Message-Id: <20230915095417.1949-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
DW xGMAC IP can be synthesized such that it can support tx checksum
offloading only for a few initial tx queues. Also as Serge pointed
out, for the DW QoS IP, tx coe can be individually configured for
each tx queue. This patchset adds support for tx coe sw fallback for
those queues that don't support tx coe. Also, add binding for
snps,coe-unsupported property.

changelog v6:
* Reworked patchset to cover DW QoS Ethernet IP also.

changelog v5:
* As rightly suggested by Serge, reworked redundant code.

changelog v4: 
* Replaced tx_q_coe_lmt with bit flag.

changelog v3: 
* Resend with complete email list.

changelog v2: 
* Reformed binding description.
* Minor grammatical corrections in comments and commit messages.

Rohan G Thomas (2):
  dt-bindings: net: snps,dwmac: Tx coe unsupported
  net: stmmac: Tx coe sw fallback

 Documentation/devicetree/bindings/net/snps,dwmac.yaml |  3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 10 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  3 +++
 include/linux/stmmac.h                                |  1 +
 4 files changed, 17 insertions(+)

-- 
2.25.1


