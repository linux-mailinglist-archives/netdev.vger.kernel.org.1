Return-Path: <netdev+bounces-120054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE299581EE
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E199B1C22A53
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1C18C35B;
	Tue, 20 Aug 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KqaHAff8"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3318C356;
	Tue, 20 Aug 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145450; cv=none; b=qICqX2OqX12hxo/1F7SxDC3m7mFoEN2BrQnqc6OKsnokRGtVcFtF1Rj09KgD7IFi/JRr37sumsaN9BfSCwtbOVHy+BDjuV+coHGNGhUNpmTRmganSXWGR23z4+pWTBIkH7sQ2L2V995D6OtkYhqUd5ZT8QXz013Q0aE7b/pbx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145450; c=relaxed/simple;
	bh=6WqQ9bZ1jNERH1OVyT+68qPMJh4OGz7I3i6jzAqYrsY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cm3pKVAW10i3PHOxM7smzKifbvCh6/yl+1pNKfjW6AxzRUDBH6NTvlzfYgzdPKV8+a8co4vMMkbIvfXqV3Afw2ainFhIn8RzXxklzdUVXr4yVOVigvZi7BEdYSJCFpmSrAY7ceTK29RRt6LhOH5IrdwNqGAhtCAzZB/mlSM9zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KqaHAff8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47K9H0Zb007330;
	Tue, 20 Aug 2024 04:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724145420;
	bh=I7ZRMszLONWGT9rU/+fUWOeX9vZN1R9Vo1ubOC9KAFo=;
	h=From:To:CC:Subject:Date;
	b=KqaHAff8YVoPGjm4cMn4GZHAjC1AhAV9Q1nr23+ro9ulk4FAG8WIRuVZ2v+kSljCs
	 l8lJsh3s/21E3hHzfBnrp5TFq19PzcsJT0I/PyNbN28kpLPSaaO0rKhOw5LIGKeIkc
	 iqgxbz53za6VvgcGCYokjRpC5yaw7p6stQYy81VA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47K9H0nn028025
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 04:17:00 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 04:17:00 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 04:16:59 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47K9H0WB084730;
	Tue, 20 Aug 2024 04:17:00 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47K9Gxn2016984;
	Tue, 20 Aug 2024 04:16:59 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Simon
 Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh Shilimkar
	<ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v6 0/2] Add support for ICSSG PA_STATS
Date: Tue, 20 Aug 2024 14:46:55 +0530
Message-ID: <20240820091657.4068304-1-danishanwar@ti.com>
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

Hi,

This series adds support for PA_STATS. Previously this series was a
standalone patch adding documentation for PA_STATS in dt-bindings file
ti,pruss.yaml.

As discussed in v4, posting driver and binding patch together.

Changes since v5:
*) Used ARRAY_SIZE(icssg_all_pa_stats) instead of ICSSG_NUM_PA_STATS so
   that it's consistent with the loop as suggested by Dan Carpenter
   <dan.carpenter@linaro.org>
*) Created emac->pa_stats array for storing pa_stats as suggested by
   Dan Carpenter <dan.carpenter@linaro.org>
*) Renamed `icssg_all_stats` to `icssg_mii_g_rt_stats`.
*) Added entry for pa_stats in kernel doc for structure prueth as asked by
   Simon Horman <horms@kernel.org>.
*) Improved syntax for kernel doc of pa_stats_regs register by dropping
   u32 from kernel doc.

Changes since v4:
*) Added net-next to both driver and binding patch as they are both now
   meant to be merged via net-next.
*) Added Acked by tag of Nishanth Menon <nm@ti.com>
*) Dropped device tree patches as they don't need merge now.
*) Modified patch 2 to use ethtool_puts() as suggested by Jakub Kicinski
   <kuba@kernel.org>

Changes since v3:
*) Added full series as asked by Nishanth Menon <nm@ti.com>

Changes from v2 to v3:
*) Added RB tag of Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> to
   patch 2/2
*) Added patch 1/2 to the series as the binding file is orphan.

Changes from v1 to v2:
*) Added ^ in pa-stats as suggested by Krzysztof Kozlowski
   <krzk@kernel.org>
*) Moved additionalProperties: false to right after type:object as
   suggested by Krzysztof Kozlowski <krzk@kernel.org>
*) Updated description of pa-stats to explain the purpose of PA_STATS
   module in context of ICSSG.

v1 https://lore.kernel.org/all/20240430121915.1561359-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20240529115149.630273-1-danishanwar@ti.com/
v3 https://lore.kernel.org/all/20240625153319.795665-1-danishanwar@ti.com/
v4 https://lore.kernel.org/all/20240729113226.2905928-1-danishanwar@ti.com/
v5 https://lore.kernel.org/all/20240814092033.2984734-1-danishanwar@ti.com/

MD Danish Anwar (2):
  dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
  net: ti: icssg-prueth: Add support for PA Stats

 .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 +++++++++++
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 19 ++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  9 +++--
 drivers/net/ethernet/ti/icssg/icssg_stats.c   | 31 ++++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 34 ++++++++++++++++++-
 6 files changed, 98 insertions(+), 21 deletions(-)


base-commit: dca9d62a0d7684a5510645ba05960529c5066457
-- 
2.34.1


