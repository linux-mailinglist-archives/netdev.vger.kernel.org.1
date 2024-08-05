Return-Path: <netdev+bounces-115918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1D94865B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 01:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34BA7B2164F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32BF16B386;
	Mon,  5 Aug 2024 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tDWbuVGc"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C914F9F1;
	Mon,  5 Aug 2024 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901951; cv=none; b=ckebVAnpQzH/myQMZok4puC7KcoQZt6vMrUDIcwNL8ZuEt+1jKf2XmTC64htLrnQhT4SxugGf8LlM1EpbW+mwvWdfu7DOBHHR3bdVI9zqvqqBZ0zU6M4eHrxymtPwpR0Du6PH2YHoCbVvrnEfnm8nbk88Vl7sAKMZpj7sXOVhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901951; c=relaxed/simple;
	bh=IiotENmGMhEqWE+2OSLc/NaCKxXivBFJS6vpsBuFquU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hDGOnGKyXLxd9152DBRBS7qQf+l0fuv9+UD5csajWzPVbIQ4/tS/EMSB9sFt9kbT/NBXCAL53SIk4pzVjAUfA2atdTNf1Y5yGfz3W65nJB3Jd28GfMK7368ONW45u/qNUvrGBJaNwh7CXqSoqhr5rXUFYVwjyt0n8wCNOjry5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tDWbuVGc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722901949; x=1754437949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IiotENmGMhEqWE+2OSLc/NaCKxXivBFJS6vpsBuFquU=;
  b=tDWbuVGcxE6u3xRR1T1o+NdnNOPaW4C/76Zp9FPe9ExT3F0RYxJcvIyQ
   hdSXmirFmWlgiXiXNfc7z2DERoEGriBJB883/VvREBzwkesKy9P7WSTUq
   BE0Lru6Qi/1o8MgfSqxJ7ufiz+LNO8JcQuyalrPeMarCmrJZ94F+5a2IB
   Rx6yASzZI9bP9BibPEwsvyp1SdGr9Kkb6jseCeytwMk75+i8zp22VkaXY
   6KiV1z6GCoAERoeW0+qGK2jpB/QAVhn8xP6JQBKIqviUwrJiTjjYlnbnk
   Peie1tOalojoCdD06iVkFIE7XcwKCs8qCiL562RrAsqUe6MOMvGXDsZKK
   Q==;
X-CSE-ConnectionGUID: 83RCjsVzTiGAx36Wh2MyMg==
X-CSE-MsgGUID: /7xA2csLQHWFaCDgfTIU6w==
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="197550953"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Aug 2024 16:52:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Aug 2024 16:51:55 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 5 Aug 2024 16:51:55 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net v2] net: dsa: microchip: Fix Wake-on-LAN check to not return an error
Date: Mon, 5 Aug 2024 16:52:00 -0700
Message-ID: <20240805235200.24982-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The wol variable in ksz_port_set_mac_address() is declared with random
data, but the code in ksz_get_wol call may not be executed so the
WAKE_MAGIC check may be invalid resulting in an error message when
setting a MAC address after starting the DSA driver.

Fixes: 3b454b6390c3 ("net: dsa: microchip: ksz9477: Add Wake on Magic Packet support")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
v2
- Update with Oleksij's suggestion

 drivers/net/dsa/microchip/ksz_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b074b4bb0629..b120e66d5669 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3764,6 +3764,11 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 		return -EBUSY;
 	}
 
+	/* Need to initialize variable as the code to fill in settings may
+	 * not be executed.
+	 */
+	wol.wolopts = 0;
+
 	ksz_get_wol(ds, dp->index, &wol);
 	if (wol.wolopts & WAKE_MAGIC) {
 		dev_err(ds->dev,
-- 
2.34.1


