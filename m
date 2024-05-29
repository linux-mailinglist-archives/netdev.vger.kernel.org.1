Return-Path: <netdev+bounces-99049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A78D389E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C021F22B7D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7B1E890;
	Wed, 29 May 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qlvmv05x"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C91BF3B;
	Wed, 29 May 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991485; cv=none; b=kXDG/e4cO8u+ajEuYwhlVHL7B07wtjibeuBCe5vwzSHLrPe0Qby77TAYM87LLkyyDta9Y6fdK3aRdAY+86WyoLJCsNnKK72AElvsuBU1eEdI8PLjFLM5dlt8KTsI5b4ZrGktOl1aiN+j/NO5FWxZmMopQanZVSk+PgvI1dbkHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991485; c=relaxed/simple;
	bh=hywXqe1+thnJEGFL233Btn9YUfw8uz+KCB0n0otHubo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtYJlQt9WBAjIBPHuWrj4YPYy/UtZE9gxbj8q+6qORjMtxe5exJjTk6ZPyQi2LbcjWbYkQ847fRuhvbmWMON3fVn56cMx7yd/7WPr0kpNtaq7VSrV8V7ua9sh3ywxikAkIvlgUcpsPANWMrH/NdHVcFlJPCXRvYGeFr/Lvhf/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qlvmv05x; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716991483; x=1748527483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hywXqe1+thnJEGFL233Btn9YUfw8uz+KCB0n0otHubo=;
  b=qlvmv05xQ/dpQzcxOjbfVzhXAK6+77NfA1Z5NKiCvt1tcWYNHBqGWvIw
   EFnjKtXqakIEIBn2f8SLC8nJ0cUu5oYBvDGdkyIap5UZBl+TWzK5VM8Lh
   LTquAG47xMznl43mrWwM7hkI5Vis84Wm/UiuQ0i3QMmqSYHDUWI0u1Osy
   1H2Guot8AwoqKEsNKYaNVVI2Le0fPvN/Lrf33ZIgmwVqtIBedVwBk+6uE
   VV4bI/4g1dt14eXdHazj3Egmmy/msii3Zj3IyDd//WJp2BuDA9XiNEcfs
   Ly4qbplawXB0kxijLrJ/ioUI7J5gMGHbx0eNalPNlqm/MitYMoiyOUdgB
   w==;
X-CSE-ConnectionGUID: UHRX1dMPQmiDDA0urO7xTA==
X-CSE-MsgGUID: KGOuusQJRMmotEnz21LpEw==
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="29036711"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2024 07:04:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 May 2024 07:04:35 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 29 May 2024 07:04:32 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net-next v3 1/2] lan78xx: Enable 125 MHz CLK configuration for LAN7801 if NO EEPROM is detected
Date: Wed, 29 May 2024 19:32:55 +0530
Message-ID: <20240529140256.1849764-2-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529140256.1849764-1-rengarajan.s@microchip.com>
References: <20240529140256.1849764-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The 125MHz and 25MHz clock configurations are enabled in the initialization
regardless of EEPROM (125MHz is needed for RGMII 1000Mbps operation). After
a lite reset (lan78xx_reset), these contents go back to defaults(all 0, so
no 125MHz or 25MHz clock).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/net/usb/lan78xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index ba6c8ac2a736..7ac540cc3686 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2944,6 +2944,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		return ret;
 
 	buf |= HW_CFG_MEF_;
+	buf |= HW_CFG_CLK125_EN_;
+	buf |= HW_CFG_REFCLK25_EN_;
 
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
 	if (ret < 0)
-- 
2.25.1


