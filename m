Return-Path: <netdev+bounces-28405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4CF77F584
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B7C281ECA
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0BA13ACC;
	Thu, 17 Aug 2023 11:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27F13ACA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:45:59 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646A4198C;
	Thu, 17 Aug 2023 04:45:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HBjYSc074780;
	Thu, 17 Aug 2023 06:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692272734;
	bh=/YvZHFijQAOOUb/hxHeFZFqv3Q7xfF5U1eY9Z9/kDVo=;
	h=From:To:CC:Subject:Date;
	b=nl+T11tMHNmxoIeWHsT87cUrNB3Y7tO2rvfwXMnxkVhcRsMGsGAHp4+rmasXmmQmC
	 H5xYqDNDdTLTklEIMv+Ag80TLRuouVRKzWgSH98all5mzf03H0blqf1OIuB3SBlb/b
	 jiA0X6lvtTwSd9jj82gx1jXWnfl+hbEQcYQJaRoY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HBjYHU003072
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Aug 2023 06:45:34 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 06:45:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 06:45:34 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HBjYIp097174;
	Thu, 17 Aug 2023 06:45:34 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37HBjXuQ002765;
	Thu, 17 Aug 2023 06:45:33 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        MD Danish Anwar <danishanwar@ti.com>
CC: <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/5] Introduce IEP driver and packet timestamping support 
Date: Thu, 17 Aug 2023 17:15:22 +0530
Message-ID: <20230817114527.1585631-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series introduces Industrial Ethernet Peripheral (IEP) driver to
support timestamping of ethernet packets and thus support PTP and PPS
for PRU ICSSG ethernet ports.

This series also adds 10M full duplex support for ICSSG ethernet driver.

There are two IEP instances. IEP0 is used for packet timestamping while IEP1
is used for 10M full duplex support.

This is v5 of the series [v1]. It addresses comments made on [v4].
This series is based on linux-next(#next-20230817).

Changes from v4 to v5:
*) Added comments on why we are using readl / writel instead of regmap_read()
   / write() in icss_iep_gettime() / settime() APIs as asked by Roger.

Change from v3 to v4:
*) Changed compatible in iep dt bindings. Now each SoC has their own compatible
   in the binding with "ti,am654-icss-iep" as a fallback as asked by Conor.
*) Addressed Andew's comments and removed helper APIs icss_iep_readl() / 
   writel(). Now the settime/gettime APIs directly use readl() / writel().
*) Moved selecting TI_ICSS_IEP in Kconfig from patch 3 to patch 4.
*) Removed forward declaration of icss_iep_of_match in patch 3.
*) Replaced use of of_device_get_match_data() to device_get_match_data() in
   patch 3.
*) Removed of_match_ptr() from patch 3 as it is not needed.

Changes from v2 to v3:
*) Addressed Roger's comment and moved IEP1 related changes in patch 5.
*) Addressed Roger's comment and moved icss_iep.c / .h changes from patch 4
   to patch 3.
*) Added support for multiple timestamping in patch 4 as asked by Roger.
*) Addressed Andrew's comment and added comment in case SPEED_10 in
   icssg_config_ipg() API.
*) Kept compatible as "ti,am654-icss-iep" for all TI K3 SoCs

Changes from v1 to v2:
*) Addressed Simon's comment to fix reverse xmas tree declaration. Some APIs
   in patch 3 and 4 were not following reverse xmas tree variable declaration.
   Fixed it in this version.
*) Addressed Conor's comments and removed unsupported SoCs from compatible
   comment in patch 1. 
*) Addded patch 2 which was not part of v1. Patch 2, adds IEP node to dt
   bindings for ICSSG.

[v1] https://lore.kernel.org/all/20230803110153.3309577-1-danishanwar@ti.com/
[v2] https://lore.kernel.org/all/20230807110048.2611456-1-danishanwar@ti.com/
[v3] https://lore.kernel.org/all/20230809114906.21866-1-danishanwar@ti.com/
[v4] https://lore.kernel.org/all/20230814100847.3531480-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar

Grygorii Strashko (1):
  net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support

MD Danish Anwar (2):
  dt-bindings: net: Add ICSS IEP
  dt-bindings: net: Add IEP property in ICSSG DT binding

Roger Quadros (2):
  net: ti: icss-iep: Add IEP driver
  net: ti: icssg-prueth: add packet timestamping and ptp support

 .../devicetree/bindings/net/ti,icss-iep.yaml  |  61 ++
 .../bindings/net/ti,icssg-prueth.yaml         |   7 +
 drivers/net/ethernet/ti/Kconfig               |  12 +
 drivers/net/ethernet/ti/Makefile              |   1 +
 drivers/net/ethernet/ti/icssg/icss_iep.c      | 965 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icss_iep.h      |  41 +
 drivers/net/ethernet/ti/icssg/icssg_config.c  |   7 +
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  21 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 451 +++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  28 +-
 10 files changed, 1586 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
 create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h

-- 
2.34.1


