Return-Path: <netdev+bounces-48909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12977EFFC7
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 14:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C84628106F
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383613AC2;
	Sat, 18 Nov 2023 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="huj0uA40"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2258127;
	Sat, 18 Nov 2023 05:14:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 308CF20002;
	Sat, 18 Nov 2023 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1700313293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1wtPYbuvCrxzK3zVYcy+dqMNAt++iVN9XJT5RdrMlU=;
	b=huj0uA40EXpEj+N00n8DwlkjzblQ5eqh2gaex0fcBiOFYukZHxlO0s1TA72cAdJUn0vwQS
	LA22YLgypbPSsoJvecdpGX99+sYre9Bvs71sT2F6U0qO/qjE2fu3mSj5ryE6DzAjpasRrT
	1DdzjOLP0qnbbiYjgMgDgbgI2eMHmglslDiD0la2xmw9+6Ci5+SO4C8bfTc1bAZgWhDnN0
	pnMNuNgKJutl30lPWa/QyCTSCDv0jUH+XMvxFK0G7cTkq3O2qe7h73rzy7FV0BU62wWORW
	uCvYETEfp9Oj4l/B1ZdJa5PXuJdxzVm74M8X5cXVWnizKYxwcf6gmzBwiWx6jw==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com
Subject: [PATCH net-next 14/15] net: dsa: mt7530: correct port capabilities of MT7988
Date: Sat, 18 Nov 2023 16:13:16 +0300
Message-Id: <20231118131317.295591-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118123205.266819-1-arinc.unal@arinc9.com>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On the switch on the MT7988 SoC, there are only 4 PHYs. That's port 0 to 3.
Set the internal phy cases to '0 ... 3'.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f36f240231b5..ca42005ff3a9 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2562,7 +2562,7 @@ static void mt7988_mac_port_get_caps(struct dsa_switch *ds, int port,
 
 	switch (port) {
 	/* Internal PHY */
-	case 0 ... 4:
+	case 0 ... 3:
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
 		break;
-- 
2.40.1


