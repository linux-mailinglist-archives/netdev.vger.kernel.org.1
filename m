Return-Path: <netdev+bounces-34225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BC87A2E3B
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1668281A02
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87962575;
	Sat, 16 Sep 2023 06:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE820F4;
	Sat, 16 Sep 2023 06:33:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD491985;
	Fri, 15 Sep 2023 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694846003; x=1726382003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XNwP6iy06WtQIeeb2YYjHa0FD0axMwuKvWJRYdYZ9sI=;
  b=Uk6Vs0faTpyCsVfuMniRj/6m+oC42jzUFLZXHzwg4dyh+IfNYT4pWouP
   nVSWlGEZIeCSY7FH16ZxDQAlSl3c9+PCITdobEWgRMwVycfAfNW4AUjeM
   ek2KehPBOh8Wv4F4BgBUR1GTePb9hJCgUsfhZZ5DuQTmNT4XRI68YxmeK
   Vtb8c3i/R6Yr//UwMcvdesoZWMukm6c16j4hSFq+gu+jbV41wEwzmG0+j
   D3z3UUrVm3yI5lLnPgNYRnigVlL/t8U3c2y9bYKvg6H6xXsJZqXs/xa2r
   c7c/e88zs/tL7WktYJ/DHd2fgkDV40d6S6Fk0b6EbAht9+BDxLwEb50hK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="359637784"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="359637784"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 23:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="780351376"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="780351376"
Received: from pglc00032.png.intel.com ([10.221.207.52])
  by orsmga001.jf.intel.com with ESMTP; 15 Sep 2023 23:33:14 -0700
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
Subject: [PATCH net-next v7 0/2] net: stmmac: Tx coe sw fallback
Date: Sat, 16 Sep 2023 14:33:10 +0800
Message-Id: <20230916063312.7011-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
DW xGMAC IP can be synthesized such that it can support tx checksum
offloading only for a few initial tx queues. Also as Serge pointed
out, for the DW QoS IP, tx coe can be individually configured for
each tx queue. This patchset adds support for tx coe sw fallback for
those queues that don't support tx coe. Also, add binding for
snps,coe-unsupported property.

changelog v7:
* Updated commit message.
* Add blank lines around newly added dt binding.

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

 Documentation/devicetree/bindings/net/snps,dwmac.yaml |  5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 10 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  3 +++
 include/linux/stmmac.h                                |  1 +
 4 files changed, 19 insertions(+)

-- 
2.25.1


