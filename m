Return-Path: <netdev+bounces-138413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591A9AD726
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B0F28339F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B561FDF83;
	Wed, 23 Oct 2024 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Sf77NbXK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C441E2604;
	Wed, 23 Oct 2024 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720927; cv=none; b=NP+KlglwgGuEizNKuayCLLxdWlY756AdteLf6Agca/FqWxhbgiFNQMavjLH6bkKZ9dbP1Ekn+qiCfoRDmFu94UNc8HFanvrjLFQd7HTd+/U1H0p/zOMrE9MOrJyQonw+DK2AGXVzmmVHfAaZQ6xAw8OBfq5y7bkL4SmGgSMBEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720927; c=relaxed/simple;
	bh=D+pngnpKeWqkazA+ixceYniwTUm1eq9HUVMG96pBj/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nkr8Him7OnB0IptY0ysSJwv//HmDyjAITgryccpTTsOwiNR73H68ey/2wJPEF/d6yABdtUkEYffXJwwYjgaLNhVH0uVaLYfRrqKiuuEj9p/KMz/vHD2cG+a8AeVTsbDrKKa19AKVbEaNBtKeCGzoEA6V0aRFu1EvxRFnOMuxIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Sf77NbXK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729720925; x=1761256925;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D+pngnpKeWqkazA+ixceYniwTUm1eq9HUVMG96pBj/o=;
  b=Sf77NbXKKBQMCWbgcEO7Wjw9ln+jmJRY5igvDLU9tNPKKZj71+2gmEoN
   NUutp7kAmTip07N1Ei0i8JL97ma6S0GfbzNhXCAyvWroaajf+N9MI3LfE
   OOc1JkPQD9guvDjCfuaXucuO96PcpznN1eUfN0rCODrR0++E/8AxXGeVy
   5mkEqzowi1P5VSeQnwN1VlujYHl4xAEVbfLByclF9BCEhtwvHZV/cInuC
   0L8ck7DZadsV7UOEflHsT3KrPIiEp61d8B2JtpYueA1DFsvlgqR5x8KvA
   fE4LmhSLKU9SBKwwVcsD3dxUwH7SuOTf4XPgb/v4IcTuSCBk/Z2tuleP9
   A==;
X-CSE-ConnectionGUID: 1Xapdzk8QAqz3uJYdYtrIg==
X-CSE-MsgGUID: XHMw/OD/RVyqCjWt6K85VA==
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="33409629"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 15:02:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 23 Oct 2024 15:01:47 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 23 Oct 2024 15:01:43 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Oct 2024 00:01:21 +0200
Subject: [PATCH net-next v2 02/15] net: sparx5: change spx5_wr to spx5_rmw
 in cal update()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-sparx5-lan969x-switch-driver-2-v2-2-a0b5fae88a0f@microchip.com>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x, use spx5_rmw() for enabling the update of
the calendar. This is required to not overwrite the DSM_TAXI_CAL_CFG
register, as an additional write will be added before this one, in a
subsequent patch.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index 1ae56194637f..edc03b6ebf34 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -546,9 +546,10 @@ static int sparx5_dsm_calendar_update(struct sparx5 *sparx5, u32 taxi,
 	u32 idx;
 	u32 cal_len = sparx5_dsm_cal_len(data->schedule), len;
 
-	spx5_wr(DSM_TAXI_CAL_CFG_CAL_PGM_ENA_SET(1),
-		sparx5,
-		DSM_TAXI_CAL_CFG(taxi));
+	spx5_rmw(DSM_TAXI_CAL_CFG_CAL_PGM_ENA_SET(1),
+		 DSM_TAXI_CAL_CFG_CAL_PGM_ENA,
+		 sparx5,
+		 DSM_TAXI_CAL_CFG(taxi));
 	for (idx = 0; idx < cal_len; idx++) {
 		spx5_rmw(DSM_TAXI_CAL_CFG_CAL_IDX_SET(idx),
 			 DSM_TAXI_CAL_CFG_CAL_IDX,
@@ -559,9 +560,10 @@ static int sparx5_dsm_calendar_update(struct sparx5 *sparx5, u32 taxi,
 			 sparx5,
 			 DSM_TAXI_CAL_CFG(taxi));
 	}
-	spx5_wr(DSM_TAXI_CAL_CFG_CAL_PGM_ENA_SET(0),
-		sparx5,
-		DSM_TAXI_CAL_CFG(taxi));
+	spx5_rmw(DSM_TAXI_CAL_CFG_CAL_PGM_ENA_SET(0),
+		 DSM_TAXI_CAL_CFG_CAL_PGM_ENA,
+		 sparx5,
+		 DSM_TAXI_CAL_CFG(taxi));
 	len = DSM_TAXI_CAL_CFG_CAL_CUR_LEN_GET(spx5_rd(sparx5,
 						       DSM_TAXI_CAL_CFG(taxi)));
 	if (len != cal_len - 1)

-- 
2.34.1


