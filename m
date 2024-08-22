Return-Path: <netdev+bounces-120971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D395B4F8
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41071288CBE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1559D1C9DE5;
	Thu, 22 Aug 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tMBUL2pj"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639471C9DC3;
	Thu, 22 Aug 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329641; cv=none; b=smFCoSpJlP1Ka6B0qGI+SUE+Du1pZLaib99oGcF3NTPKyFYrJxR+8pvWl72Ta3scOpau4YYuq6NaRohTwCzttBYpQMYQy88aJ8b8tSIzB9nGWHniQ22ltiUhVWT1OuBZokDCn6oUQzYcZ7RkriYfEa54WOGQ6PMg7q80d2AWODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329641; c=relaxed/simple;
	bh=pEvcrxr4une554HicftcYGaTBsQfuFT04uonE+qQdrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YcaKwTSbfL0suJ+f5xqQdkaGlug+HZp53KspTQLEYG4x2/BFqvzLrhNTAOHfNzfHq51uB/51FxICg9/HihLLB47nKvwlZyRKBPn0hSBhWjAbApGCvQgR5ooxAh+hiHJF/HHWWphNhljLONzaCs/gfnYQoIv5wrCb+sFB87NqH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tMBUL2pj; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47MCQubM123904;
	Thu, 22 Aug 2024 07:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724329616;
	bh=gIekhkefUB+8majHOiNvNR7rn9Yl7464DUsDGsBTk68=;
	h=From:To:CC:Subject:Date;
	b=tMBUL2pjxv2/YqOB5p3DedQruxUCgsZyatVLmeqA/ICOVoyvaugugVPdbVu9UsvTm
	 VOWGlPM+WsSo9WKopzMd4rsWSqZ9Q5KQM3O/Kcl3OUSMagjbye99E8TlaSseupIskV
	 vDJ22HQhO+mQIL7cgEQ9Vwimy6j0QTIP3BJNb4vg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47MCQuPt037058
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 07:26:56 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 07:26:56 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 07:26:55 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47MCQtAF014889;
	Thu, 22 Aug 2024 07:26:55 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47MCQt59015169;
	Thu, 22 Aug 2024 07:26:55 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth
 Menon <nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v7 0/2] Add support for ICSSG PA_STATS
Date: Thu, 22 Aug 2024 17:56:50 +0530
Message-ID: <20240822122652.1071801-1-danishanwar@ti.com>
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

Changes isnce v6:
*) Addressed Roger's comments and renamed stats related data strcutures
and array so that they remain consitent.
*) Re-ordered data structures and arrays related to stats type as asked
by Roger.
*) Modified commit message to state these additional changes

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
v6 https://lore.kernel.org/all/20240820091657.4068304-1-danishanwar@ti.com/

MD Danish Anwar (2):
  dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
  net: ti: icssg-prueth: Add support for PA Stats

 .../devicetree/bindings/soc/ti/ti,pruss.yaml  |  20 +++
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  19 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   6 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   9 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |  31 +++-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 158 +++++++++++-------
 6 files changed, 160 insertions(+), 83 deletions(-)


base-commit: 812a2751e827fa1eb01f3bd268b4d74c23f4226a
-- 
2.34.1


