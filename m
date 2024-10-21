Return-Path: <netdev+bounces-137507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5569A6B6D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2292818E2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D11FDFB6;
	Mon, 21 Oct 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ywo6JlTR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17E1FCF6D;
	Mon, 21 Oct 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519223; cv=none; b=ciMNwVPtcDZewXc5qy85axSP1JvdA1PWsjUH9PplXnu2Iin+OAoi14XvB3Rqf2I+62VD7425tEeARrYmiurbj/uDTjU4tYV6O5uenaT4qV0w5ZLDGjZM4tME3DNQ/0fsItqHujnCuR7iFXEwKEwLnFpybjbbN72iCOARS/LKwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519223; c=relaxed/simple;
	bh=D+pngnpKeWqkazA+ixceYniwTUm1eq9HUVMG96pBj/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WqJmeYUgN0V2xdZGvUFpBrXoQ99brBcyPKi8PAOAtzjRZ+ZvShBvG0Qq9Gwg0ZCKiVKa6dRFV9t+zESZHo0uEHpDPfWOMsYyaDP8hVZ7bgXagBfMfSbppEJ4O9BLdgg8HciOe3BDHsXvnjKkxCwsvx8iqPOfF8G1BYK4qXXZ1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ywo6JlTR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519221; x=1761055221;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D+pngnpKeWqkazA+ixceYniwTUm1eq9HUVMG96pBj/o=;
  b=Ywo6JlTRPk/dJyPZZcKSIQveX2i0WRMYNutUaGDVR+cpNygH7sI9VU3O
   1Hfq3Dl/pxk52TxPtt1oNTfYtaSrlvDvaSsuIN33P+NGIBopj3PNhRC5L
   /Cjy3YvYIZ/BlOj3f4Ld7bV8IGE+djv8A1vcUwsmby+Eyo9HCTOe1QXqF
   1Dy+E5IC4ZTerBXjkPbogkpRnqeF7H4X86saFXezumoktfFkRs9bYhkxs
   DnKNw6ztZQ+FTqfYAcmthHrUP0aX+b9C9/W3hC5eaESUjqpPrcM8sAzXQ
   EE/iGfhDDSEkDj8L5w9yf5Au5zEwtJ2s46vhMvU027RjhxbsX21K4rYfG
   A==;
X-CSE-ConnectionGUID: Ky42XnPuQxK/Okp36Nw4mA==
X-CSE-MsgGUID: 3XY9PXaeTjiED3TNdN7jcA==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="200707748"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 06:59:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:02 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:58:58 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:39 +0200
Subject: [PATCH net-next 02/15] net: sparx5: change spx5_wr to spx5_rmw in
 cal update()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-2-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
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


