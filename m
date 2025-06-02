Return-Path: <netdev+bounces-194655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A2ACBBD8
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700B57AA2C9
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8822322A1D5;
	Mon,  2 Jun 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4tpRqSk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDD225A3E;
	Mon,  2 Jun 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893204; cv=none; b=LeN479q9OdjSbVV3uD7MUSbV1mTsk5ZdZiQvpuwENMUR5jyFR4l3vJcwx8tmacYAZFxkmBcjp2X9Wqnxc1/E5rBhE+5X4gZxJDWY3zEDrvSX3p94nt/eaBmsnQsgQL89/NFegHHf9n7PqKdf3Hyd4zR02Ee9HGwrXqfMHGJdRoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893204; c=relaxed/simple;
	bh=68r3wPwjDt0zL8t3mh+K0SjtOAmg8KmOb8Icr5kChOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQ7siKmEjxrhvel2B+FjG+aF49yDtYoL1VIxEsnVC5c13tguhxRrjFkrT0zU276ZeHQKL3/53DLRUa7cxBMuJCnmTcEuD6tn6MfsoSWs/lxXU6a4czsw2+uhZ9Z8UHk9NRVWcDdswNrgT8mH0Gx+0EW7qCmQrYv4nONpsDcmWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4tpRqSk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so725922566b.0;
        Mon, 02 Jun 2025 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748893201; x=1749498001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1kdwLfxxgBxhd368S9lStLqHiV5zPBZeoferEx4nTo=;
        b=I4tpRqSkqITWMIVizjlhYqBMmiH6tks/Zq8+rrQC8UgVzavNJB34NGu6s1yYApYI29
         q5l1xlGjHQ3svt1eRDUtYEnR9xCDCkSzrEEUBhyGE5AyWtepQbhfi5KQvU8wofFB3rWc
         HyPB2HgeGvxxFCmAICKF2vB+a/z2f+JtOUWuNwLnhY3jx5MFauZtfHRF66ginem5G/jH
         NiGIn8HYz7Nr/9kqe03op01RZPin/z7CJDqJz5AG50Qzq8mpUHm1933aqsiee9lsFVq6
         kLc1vWA9bXjp8ynRRAO/xUyrOyLh5j4dkVKZeznvjw3kgrdYFOvQ8A0nU0EetpXcQYZN
         19Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748893201; x=1749498001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1kdwLfxxgBxhd368S9lStLqHiV5zPBZeoferEx4nTo=;
        b=WUpgk4I7qJAgMyhvzMDgLlJb2iTZcCLgawCO4tDKlqu4GYN0F351dQpPzCKRDvMHJ9
         q8BgmS6JqizRpctlBha6e5kl4XqPictN+9M7bAKlZ+kjtK/h8jvyZhEmJ6V2vDE5GkjR
         l0tth0pXA6EoSn6a4w3PO3IKhRRbiCzX4yU516A7uzRaMSH5inq7SmcBoR0AwUVnld0t
         8XLu1HXf8buzJS1txooS0QDQc2ASjBh60tYN2OHiMLvq+51kvH6OB8JllpThF5DGBWir
         nhYKV2vASVvdTyvR1I/zDuQdtx1Ii2O4a55Vjyk45RwfLhEJW88kbTuKv6G2k3SqsXQQ
         ahNw==
X-Forwarded-Encrypted: i=1; AJvYcCVSmhm+ajjaWtADCJpmOYXid430qcTEce/b0qX9WURv3lZuL+kH3n7Uwa5JZboIG9aE9XtuzXp1DjgvXRs=@vger.kernel.org, AJvYcCWRll5d4xm59jbpZg9Pp8OfiEXlXNhvRIxliul62+X3yBcxcjBetpc9du6lzRrj4KtAvh+v/oYN@vger.kernel.org
X-Gm-Message-State: AOJu0YxUGktPgKHu6Sy8Z27Q3KQ/eDo3bu0b5VSW8Tw/lRevqIaM0b4S
	OEbcyIAIZJlNxMNVPIoYoeDfz/lXMYKrzDqeHEyE64eUT0t13cH5W7So
X-Gm-Gg: ASbGncv2pVDIlbk1gUcvNZtxIzOVlHzXq1o9Jc6Fgdobvw/NHVRbumXPTE+9pybeAC7
	sOzhZS0FdvO1RcQyt/+tupoFo8dsYluqidyOtJLUQkvRVOlgqHzH9AC+nRcHA8xmth8m/pVea11
	YkwZarr2u4J7RkcFUwRzLBzigGHq7ifP9j+6hEwWFlpFbxOnDRVenNqE60TUFC4ujvjwTzBNUvu
	gPDNoBV5onTcoX2JIa+xk/orvhcxHHX+16QxoQEsmQ6i55okyBBQ6qR8EvDD4zOLg/C90IASaka
	q3j4A8m7dVYNpHUPiY6KUp2sNvoeeqAeE8VIIn+C7TXoZmMbcATwC4YFrGzId5RQWq/4omy7++/
	Os/ScZPXwfg911Z0L8ysH5Mrrwm6ZSJg=
X-Google-Smtp-Source: AGHT+IGxPpwGJUoggNwpvH28ETsZWehMuBwg6JTvz0UkyKRTMkeeStmkImkTmsVVIjWD/XXBsnlFTw==
X-Received: by 2002:a17:907:944c:b0:ad8:9257:571b with SMTP id a640c23a62f3a-adb493ca4ccmr1027885866b.16.1748893200751;
        Mon, 02 Jun 2025 12:40:00 -0700 (PDT)
Received: from localhost (dslb-002-205-016-252.002.205.pools.vodafone-ip.de. [2.205.16.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad39df9sm839053966b.131.2025.06.02.12.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 12:40:00 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/5] net: dsa: b53: do not enable RGMII delay on bcm63xx
Date: Mon,  2 Jun 2025 21:39:50 +0200
Message-ID: <20250602193953.1010487-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602193953.1010487-1-jonas.gorski@gmail.com>
References: <20250602193953.1010487-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm63xx's RGMII ports are always in MAC mode, never in PHY mode, so we
shouldn't enable any delays and let the PHY handle any delays as
necessary.

This fixes using RGMII ports with normal PHYs like BCM54612E, which will
handle the delay in the PHY.

Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* do not enable delays at all

 drivers/net/dsa/b53/b53_common.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 8a6a370c8580..c186ee3fb28d 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1330,24 +1330,7 @@ static void b53_adjust_63xx_rgmii(struct dsa_switch *ds, int port,
 		off = B53_RGMII_CTRL_P(port);
 
 	b53_read8(dev, B53_CTRL_PAGE, off, &rgmii_ctrl);
-
-	switch (interface) {
-	case PHY_INTERFACE_MODE_RGMII_ID:
-		rgmii_ctrl |= (RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
-		break;
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_TXC);
-		rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
-		break;
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC);
-		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
-		break;
-	case PHY_INTERFACE_MODE_RGMII:
-	default:
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
-		break;
-	}
+	rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
 
 	if (port != dev->imp_port) {
 		if (is63268(dev))
-- 
2.43.0


