Return-Path: <netdev+bounces-240472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74591C75582
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0C7582A06F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1F536A03E;
	Thu, 20 Nov 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wis8FnzW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E732366573;
	Thu, 20 Nov 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656007; cv=none; b=CQPMNhd+ow5sC6XKm31PZ+0Gjw2lhEZS0krgPnunDGfRGakilzZiVB9CE5hI2yMd0W9tV+aSDS1Hn+Sq8IUIJ1y7u8iKtkvhnfMmP+U4gJ4aKMOYMrwCEQkDbYG6FDhoFp3SDgxvlf/TTY5571HNH5iCIcD6+sAD5SJecTsxDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656007; c=relaxed/simple;
	bh=0AGNlvqqr0qu4bwYr8AQBoa4jNlfvu8ZN5pTq4ez5ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CncLPEFHT11877HiXv0mowLE9GgQLu9m1yVuLaf/CR7P1sT57dZ4Zp1h7fIAS6ndJHKAMVAwld8cKKbkucDHDK1UxeB7heeQm/4cptYB11h6M6EsovxvBE2iowTmmK+8p687jtbHnr8INHI/eyZWzxAvU0asf+LDwrwz9GPHeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wis8FnzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B897AC116C6;
	Thu, 20 Nov 2025 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656007;
	bh=0AGNlvqqr0qu4bwYr8AQBoa4jNlfvu8ZN5pTq4ez5ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wis8FnzWPhKLKU+uK1W0nWROE0rAfq+mPjJk2YhoLyjqhObcBYjrDRf33s6Bq7Fnx
	 Sy1KyRr3Q93U59KEH4r9K2fpnCh4EpuhDgBGJhtXmw67UciyXZa3aM9zpZJCE37L4k
	 +BMQTePTqHmRqdy92goxx5+Hh4BmmR2FG/zB/ixK9vL0yYf2Vy8vexwYbI8DMhrAzF
	 tDhEHIuS19Y57Z1j6HEmllx9zoK2QSfgSXv4IjAbkUWMI4m8U7DMUcjHaO3TS0Agsk
	 xgfD2Bel5PM6UCXlTRl3kdn+ZwcxWsbnE3DC9vGCfdn2mhZ+3FTs8rwcBda7tv2wWb
	 Iexs3zgkdcTJg==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>
Subject: [RFC net-next v1 4/7] net: macb: np4 doesn't need a usrio pointer
Date: Thu, 20 Nov 2025 16:26:06 +0000
Message-ID: <20251120-native-steadier-481bc9453d04@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
References: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=tC+n+f2MenYJnWXWr5SyA85ikQiWhM9zmnDvVhPzymI=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnyjlIXF6/531VxvHi70bQzkc9PevhM38O2ZXMzK0voS pb0yjWvO0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARiZeMDKdUWNfKiSdvijvi +jVo7kReqbBelX1rH/0X/yA2v/WMOwfDX/HTjBxqL+Z3i2qY3Dl/beKV3TrP2W15fr+65/AqdsG DM0wA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

USRIO is disabled on this platform, having a pointer to a usrio config
structure doesn't actually do anything other than look weird.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 888a72c40f26..21045575f19c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5314,7 +5314,7 @@ static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &at91_default_usrio,
+	.usrio = NULL,
 };
 
 static const struct macb_config zynqmp_config = {
-- 
2.51.0


