Return-Path: <netdev+bounces-118398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD1951791
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174721F23FA1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8AF149DFC;
	Wed, 14 Aug 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E4KNDbPi"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00713A418;
	Wed, 14 Aug 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627272; cv=none; b=TErOzJ20pQI+zG90CAcXhKFzblLNYpo8THV67TjXMePgHVbxJ+rUqobnm6ps+cKhlQAyIy0pVgZSLa2G/WryDAnenp0VItl1hnxDSN/lyKu/+noePWI4XAX1TnjF2jQMhDPZQmeL5Y3fIi1y5oOwSfmugmJCdjRcOvxYaSpypMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627272; c=relaxed/simple;
	bh=2VSt6rFZpRVGdXpxEt4x7cyzdDkDAlB+ZWy0dBEJM6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NoXtmJPBQ/vnb1kAztux3zNtAEngp+W4e/B5oiSdBiD+jP2Nh5T6xDufKEEMBblqBXHvatX7HH6pmI2qj9QqB71kqpjcbkUkZ2wLuwiyWqfFblzprZKfi8JWjaHFDCLWosZbLpHiE6/tGndhJgsAWHQyODsrrvm+V09XPAcxr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E4KNDbPi; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E9KaZp055844;
	Wed, 14 Aug 2024 04:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723627236;
	bh=RWHjtE9F+tImoiLagN6KLowN3n51lA+zm3+csE1nq8k=;
	h=From:To:CC:Subject:Date;
	b=E4KNDbPi9HYWo2Baul13nR+pXVHfp60sGWL7LoSFXM/QGPoFMU0KwAQ01EPAOgRHE
	 WTHZ0wWQykUKCy2GMFqdn6miugburUSuRCAH1sBoiFGHishqyZTnk9kmwpKuNIotCf
	 eNNf60ev0T2WxxcKJ2Rh6QW+W970YgIKvI0SviZM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E9KaSl005364
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 04:20:36 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 04:20:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 04:20:36 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E9KaYp050098;
	Wed, 14 Aug 2024 04:20:36 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47E9KZaP031781;
	Wed, 14 Aug 2024 04:20:35 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory
 Maincent <kory.maincent@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish
 Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v5 0/2] Add support for ICSSG PA_STATS
Date: Wed, 14 Aug 2024 14:50:31 +0530
Message-ID: <20240814092033.2984734-1-danishanwar@ti.com>
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

MD Danish Anwar (2):
  dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
  net: ti: icssg-prueth: Add support for PA Stats

 .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 ++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 17 +++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  5 ++-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   | 19 +++++++++--
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 32 +++++++++++++++++++
 6 files changed, 87 insertions(+), 12 deletions(-)


base-commit: 712f585ab8b2cc2ff4e441b14a4907f764d78f2b
-- 
2.34.1


