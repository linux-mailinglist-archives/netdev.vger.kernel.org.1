Return-Path: <netdev+bounces-113601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A193F421
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9197CB22219
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55741146A9B;
	Mon, 29 Jul 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cKglSteq"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD281465AE;
	Mon, 29 Jul 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252780; cv=none; b=G5z2W/3g+uf40hdx4hlTGkpq+/EBDXEDgdSy9Z2AT5puSKtNsjuxTjB0rHDcz9NQwn6cPD24oR5OlK7J07oRyv7cWACHBDYlCHNXfNJ89TqumaMLKsdwSZ5eqgeWn9PQaiLqor5Xgin96UUgk5AnBAjB1x3qxV/vyg69V8ay7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252780; c=relaxed/simple;
	bh=IFoFnx/SWQWVZdY12avjnkkKDrGe0GyqdrEVzGKBUcE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MHHj8A2USTURZexPVjGCBPBb7u62MAvqhglnKIyJct8a6ykHTvp746dBN36rOqUAeKSXTz8qDm0ERk1G/howgtep5ySCr9pAlU/v0t6V1E05DYsadASwZ0D+nBA0OI9r/cAoX5Y+3D92GSE7QIIOvOI/ZgMTIFP2NnVz5jE10iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cKglSteq; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWUOv026409;
	Mon, 29 Jul 2024 06:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722252750;
	bh=c+fsl4q85i5wkbziWiZl87/UhWwCe46fpJs67kf6IeM=;
	h=From:To:CC:Subject:Date;
	b=cKglSteqDGG4aydowXPZcC/LD1SORv7Qx6k2im9292jSXZl6HnxzZQeWpVQ8usmPi
	 Sz+kFVNZvl7GxRo+WXbsQmC/Xwg/JN8xau/B/7PRbTUAbA89xXNsyolzy9rEvZz4Yj
	 /SO+ANAEQ/LisCnJmA2lCraNWvQyNvVuF1gj9Vts=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TBWUHB007455
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 06:32:30 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 06:32:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 06:32:29 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TBWTnD012817;
	Mon, 29 Jul 2024 06:32:29 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 46TBWSAU013146;
	Mon, 29 Jul 2024 06:32:29 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Tero
 Kristo <kristo@kernel.org>,
        <srk@ti.com>
Subject: [PATCH v4 0/6] Add support for ICSSG PA_STATS
Date: Mon, 29 Jul 2024 17:02:20 +0530
Message-ID: <20240729113226.2905928-1-danishanwar@ti.com>
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

This series adds support for PA_STATS. Previously this series was a standalone
patch adding documentation for PA_STATS in dt-bindings file ti,pruss.yaml.

Nishanth Menon <nm@ti.com> had asked in v3 to post entire series. So adding
patches needed for entire series in this revision.

Inter dependency between patches:
*) Patch 2 can be applied to net-next tree without any error / warning.
*) Patch 3,4,5 and 6 can not be applied to their tree as it will result in
   dt-bindings check error. For these patches to cleanly apply, patch 1 is
   needed in the tree.
*) To avoid any confusion I have marked patch 2 - 6 as [DO NOT MERGE]. Only
   Patch 1 needs to be merged now.

Changes since v3:
*) Added full series as asked by Nishanth Menon <nm@ti.com>

Changes from v2 to v3:
*) Added RB tag of Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> to
   patch 2/2
*) Added patch 1/2 to the series as the binding file is orphan.

Changes from v1 to v2:
*) Added ^ in pa-stats as suggested by Krzysztof Kozlowski
   <krzk@kernel.org>
*) Moved additionalProperties: false to right after after type:object as
   suggested by Krzysztof Kozlowski <krzk@kernel.org>
*) Updated description of pa-stats to explain the purpose of PA_STATS
   module in context of ICSSG.

v1 https://lore.kernel.org/all/20240430121915.1561359-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20240529115149.630273-1-danishanwar@ti.com/
v3 https://lore.kernel.org/all/20240625153319.795665-1-danishanwar@ti.com/

MD Danish Anwar (6):
  dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
  net: ti: icssg_prueth: Add support for PA Stats
  arm64: dts: ti: k3-am65-main: Add ti,pruss-pa-st node
  arm64: dts: ti: k3-am654-icssg2: Add ti,pa-stats property
  arm64: dts: ti: k3-am64-main: Add ti,pruss-pa-st node
  arm64: dts: ti: k3-am64: Add ti,pa-stats property

 .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 10 ++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 15 +++++++++
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso   |  1 +
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso      |  2 ++
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 11 ++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  5 ++-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   | 12 +++++--
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 32 +++++++++++++++++++
 11 files changed, 111 insertions(+), 4 deletions(-)

-- 
2.34.1


