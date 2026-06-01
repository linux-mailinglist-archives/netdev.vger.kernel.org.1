Return-Path: <netdev+bounces-293684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJq+NkpmHWrqaAkAu9opvQ
	(envelope-from <netdev+bounces-293684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:00:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42F61E073
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D7D3013484
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4325E39DBFF;
	Mon,  1 Jun 2026 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHhniPQ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9C39A4BA
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311236; cv=none; b=FHQIIK7ZQXjxeM/CHP0XZmkw18TPsZSHLWbl5Rtvkk/T1dVi+9qnbIogaVfRsk7hfCsINcdpNa593ylcZXov6G9xIdQ0VByQBTwRVN/llHdjnGUNgSh3xpRl80/tJ/NiZ2A0B/Mk/LkC392pttrryXTOX01B03gOEMFjplnqfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311236; c=relaxed/simple;
	bh=YamYR0gB5YpvzrPrfHuKhWssK/k1gQlhxfDHYVzOSrw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjfKeeG5gi1vFhnGqUQJ/YJ6K4+23BWc6rwUje9/RlNtPP/oS50/nhyWi2ZQjdzIIGyIlKJvS1xzTeIjG8JzSTLwHi1S16NqTlvh+xJVXLdPZxPSFLXu+8Y3Y3VhMeDJGG4Ccd0RNZx3alp33x+0fWwQ6/iD8ej8EAuE/OfPRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHhniPQ8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso10640645e9.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 03:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780311233; x=1780916033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/VphDQS+fwFrSctDzTxKBEr+9CTd6YQLukQQPgTJa4=;
        b=IHhniPQ8p98FjG4gozuDqUMzHlesNwlf8D3AskSPDhgXIKnnYFsrVAAdaxAmZ249F8
         q/ZG91DiTsyzr6aGYq4uwWm6vKWN+ZC6qb6m6HFPg9+ZRaXRsQfovr5uQytj4I60tJRX
         Ao2kfO7idTiRNjo07bJ8hez7/8TaUmvDoH1tvuZslsyLnlMm+URaHl4vFHEvemLxAjoK
         MIjf6qj+AWN94YydxgGthj4hS9pvR+81I4J1YDZX5b+SeDatNjdDu5yxb4Keh1c62dXy
         ClI5XgsNE0qgQavXh0TvX3DyNO/OdQAp8VXAmV2LoLDQ8YSPpbRt2COWvtmMnXrcnEoG
         PuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780311233; x=1780916033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/VphDQS+fwFrSctDzTxKBEr+9CTd6YQLukQQPgTJa4=;
        b=XJoDQ1UQm9Td8Vwnf+sjuS9vJ999TLoxw30GOJu1uvzZSjjIB1ebbA7vyQGOK0tbgI
         cwT02KkrpdYdVJA1dFmllU6KBEiezwh8toxQuDTWSOuRmvlVef3HWsMrxbUQ1QtqiT8w
         /hjFYfgd7NvMylHa3nTDHe2J4FuysugIINWN2+BSduTJEfCB2bDPgo6O0iWLoHTeWdcS
         1mdyKS6KSvvPOwKf87x3CAARsEHeVtae4iSPqfMv22oC+9C3lerAevfA4OUVF06n9APn
         rL89PPnA84s+czLlhl4RyVMVcHqjvYzk30kA61pC8sjKHPyEnuv/rFZ9P+rTR5HL8is2
         7d6g==
X-Forwarded-Encrypted: i=1; AFNElJ88X8p28KRx7xOpkdAo1G+Uan1Q6DWisxLSHcWdLo/4OfGS8PcuLy+be6hIeUuIXX05TeoHRwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSrHqTU1shvehTxPYXyjrxLvv7tIGbCFONUNWonWRwASEm8+3
	Cd3KS0axx0LAddTHSqsDCT4CbZ4dURXyhzx7KecD5HMote1A+DRtqpMY
X-Gm-Gg: Acq92OHaRiu78kmyMUS3C6PMMtFB0nDAKG2yNq98JxDDeLJA9kF79R3SSgiX/VpjdRx
	zGorVXIm1EJiahGn6vjbnA44GtQ/v9LyNvqZ2W7ubWIHVz9YDxcMDD6bPeMNRbNk9wKymyh5V5o
	si5osGugZFwURqxUTUik3kbK/iLPbo8lXndDhjo3WDpLxL15fy5fFTeWzrIz9K0EEmUVgNx7IRT
	17uL61jS3F/r/zZiQ15QsIU+l9x9fVLdnZ5osZbFyn1ODv/lx9IfegeoHp5FK8bho0SS+yeLmLj
	DF7copQLHAmnic0VYUQsLuuvfXTcv1ZS47B41eh5wn7KoDCP2Gvag2X7tSY5N03Rz/x4IbRkyxc
	r+Tei0DF0nIHgcthy9WBMbAMLxnlVwrx8XLeDumanTvG0T3jO4FWLULP1OuskpmQ9/fIdgAQvv4
	7XMs2Dexz+TieGQxr3A7iWgLej9NTtmJJnYQK1ATF/fm1srBZ2P4E8g0BWazYsPrZTXbJNvU1G+
	l/hLLQ=
X-Received: by 2002:a05:600c:2242:b0:490:5321:2466 with SMTP id 5b1f17b1804b1-490a2941ea3mr122733095e9.20.1780311233043;
        Mon, 01 Jun 2026 03:53:53 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-42-252-49.retail.telecomitalia.it. [79.42.252.49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c967c77sm257319895e9.1.2026.06.01.03.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:53:52 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: phy: as21xxx: fix read_status speed handling
Date: Mon,  1 Jun 2026 12:53:36 +0200
Message-ID: <20260601105342.28865-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601105342.28865-1-ansuelsmth@gmail.com>
References: <20260601105342.28865-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-293684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E42F61E073
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With further test with 2.5G NIC it was discovered that
phy_resolve_aneg_linkmode is not enough to detect speed higher that 1G
when autoneg is enabled.

Also in the switch case there is a typo where the speed mask is AND with
VEND1_SPEED_STATUS instead of the correct mask VEND1_SPEED_MASK.

Rework the read_status code to always read the speed from the vendor
register and parse the generic bit only for the pause frame.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 96 +++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 0db82da8dbdf..97ca37c6929f 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -671,7 +671,7 @@ static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
 
 static int as21xxx_read_c22_lpa(struct phy_device *phydev)
 {
-	int lpagb;
+	int lpagb, lpa;
 
 	/* MII_STAT1000 are only filled in the mapped C22
 	 * in C45, use that to fill lpagb values and check.
@@ -698,12 +698,20 @@ static int as21xxx_read_c22_lpa(struct phy_device *phydev)
 	mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
 					lpagb);
 
+	lpa = phy_read_mmd(phydev, MDIO_MMD_AN,
+			   AS21XXX_MDIO_AN_C22 + MII_LPA);
+	if (lpa < 0)
+		return lpa;
+
+	mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, lpa);
+
 	return 0;
 }
 
 static int as21xxx_read_status(struct phy_device *phydev)
 {
 	int bmcr, old_link = phydev->link;
+	int speed;
 	int ret;
 
 	ret = as21xxx_read_link(phydev, &bmcr);
@@ -720,58 +728,60 @@ static int as21xxx_read_status(struct phy_device *phydev)
 	phydev->asym_pause = 0;
 
 	if (phydev->autoneg == AUTONEG_ENABLE) {
-		ret = genphy_c45_read_lpa(phydev);
-		if (ret)
-			return ret;
+		if (!phydev->autoneg_complete) {
+			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising,
+							0);
+			mii_lpa_mod_linkmode_lpa_t(phydev->lp_advertising, 0);
+			return 0;
+		}
 
 		ret = as21xxx_read_c22_lpa(phydev);
 		if (ret)
 			return ret;
-
-		phy_resolve_aneg_linkmode(phydev);
 	} else {
-		int speed;
-
 		linkmode_zero(phydev->lp_advertising);
+	}
 
-		speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
-				     VEND1_SPEED_STATUS);
-		if (speed < 0)
-			return speed;
-
-		switch (speed & VEND1_SPEED_STATUS) {
-		case VEND1_SPEED_10000:
-			phydev->speed = SPEED_10000;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_5000:
-			phydev->speed = SPEED_5000;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_2500:
-			phydev->speed = SPEED_2500;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_1000:
-			phydev->speed = SPEED_1000;
-			if (bmcr & BMCR_FULLDPLX)
-				phydev->duplex = DUPLEX_FULL;
-			else
-				phydev->duplex = DUPLEX_HALF;
-			break;
-		case VEND1_SPEED_100:
-			phydev->speed = SPEED_100;
+	speed = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			     VEND1_SPEED_STATUS);
+	if (speed < 0)
+		return speed;
+
+	switch (speed & VEND1_SPEED_MASK) {
+	case VEND1_SPEED_10000:
+		phydev->speed = SPEED_10000;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_5000:
+		phydev->speed = SPEED_5000;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_2500:
+		phydev->speed = SPEED_2500;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_1000:
+		phydev->speed = SPEED_1000;
+		if (bmcr & BMCR_FULLDPLX)
 			phydev->duplex = DUPLEX_FULL;
-			break;
-		case VEND1_SPEED_10:
-			phydev->speed = SPEED_10;
-			phydev->duplex = DUPLEX_FULL;
-			break;
-		default:
-			return -EINVAL;
-		}
+		else
+			phydev->duplex = DUPLEX_HALF;
+		break;
+	case VEND1_SPEED_100:
+		phydev->speed = SPEED_100;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	case VEND1_SPEED_10:
+		phydev->speed = SPEED_10;
+		phydev->duplex = DUPLEX_FULL;
+		break;
+	default:
+		return -EINVAL;
 	}
 
+	if (phydev->autoneg == AUTONEG_ENABLE)
+		phy_resolve_aneg_pause(phydev);
+
 	return 0;
 }
 
-- 
2.53.0


