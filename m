Return-Path: <netdev+bounces-99045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4CE8D3888
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902D41C2204F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060C51CAAD;
	Wed, 29 May 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBOCD3Q3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFD12B95
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991206; cv=none; b=RK1mq3+J6F7AvheBmjtwYgjhOlwXlbMKvDTNHUJIyt42KVgGBbpAhtsDI6VRpQGYzKzMYg2kYbmfi8ZLqHyrPHnizEwmoCagcx5/2R8T9XfhG/bAeOREuZ3Eed2MMDizbnbmIlAp/gzlLhL4yiCp8G9SdLNMe6N1cpu9cSkRhpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991206; c=relaxed/simple;
	bh=CoBusJQazCOIEoGV+WMRvkw97W0ipsCQHXYjmrSMWjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEggf/JZDN8EnBmhYXCVFTISLCulgO5WhqqHO8LL0v7qAOMBIgU2uGueC4lmIb3e2yOKdPnTPXoFOgqD9ggtVvLwOvY4Fw/Uqyfqs2RGd9m/C1Ls6SMNSmJ1itqy6LO8ixYouvzJcJAG/gHx/cZK1CQNHjAd5ndd3qNEarUby8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OBOCD3Q3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso9718621fa.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716991203; x=1717596003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN7/h6kTo2XnMU/9NM8PFU9mkK1bfHP+69ug5lQnxeo=;
        b=OBOCD3Q3Ge1juDNfoSFmGK4xNdmj/+LUkYnTf57cPfFHqtSpG9YYobBhyKARDgMoER
         U7f1JRn3DSEpRekudcVcFfDuoDWi2hulR2zKEKHU20iqKnWK/ouamUv/a+0gXOjxB+N/
         IhMJsvVgwJYauR0ul6D2MK1/GeOAGkglH4oaYNg9IdI/ehamXvZUJIzsUFAukyP95Wnm
         eWcj2T6R0ssXQ9M7QXlQhZyQBnFBMbMgG04/shJKlYftOfGtuxf02Z6oQlNqpVT6LczG
         pszt86MELsQpmN5rij/ydIrlUnZnhcOrFhB/6bEocEm5C3vxWyGGgejPcC71MfNo45sA
         OWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991203; x=1717596003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN7/h6kTo2XnMU/9NM8PFU9mkK1bfHP+69ug5lQnxeo=;
        b=i++GbHHa2Vuttaw76hqbBeqTy2WZ2q46OduMCE4pj0Nh/AZdYOTqQkuJKHhM3EMQ7s
         ituzGFa+106C/+9UJhffInLklFiMnm0lu6blHTAXApmlyynaP7ZMlFmw83md7MfHzCq1
         eg9j1F0okCG87IWYHkGx8IueNKMz09Co1PKfoub36TKuauT/Xsfjg2euUhs1CDE5o55U
         HI6PbXI4hjdrHEpDJbYZAmjqu+vRVPn8T2hwLTP8n7Q0/PES2AyMqyXZ5xcRQZ1+/qT6
         L79OezF+FbtD2jfgzZoourLoszUnn16iYgnl6eZySYmimceVTZeyd6cm2KqQZJF1yy0O
         EIPA==
X-Gm-Message-State: AOJu0YybXfbSWZ7eBAEzpDzeXOArJhgM3vZJe8T+SnraAWjFZk5cFkth
	pxuhTk9Pha3tNwWB2q0TDHFn0ltSOPrlUFE2vGmaZcLQF36EMko2oTrshB19y5Y=
X-Google-Smtp-Source: AGHT+IF5B2aYwHaoUG9A7wqPZZKFdHmfsG1ZG1/BGCj+rBRr8xBmSrqM2GBUlrQd1YIWaS9f+jQFEw==
X-Received: by 2002:a05:651c:3c3:b0:2dc:f188:9945 with SMTP id 38308e7fff4ca-2ea4c8fdba5mr5386311fa.25.1716991203408;
        Wed, 29 May 2024 07:00:03 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc47bfsm25472551fa.20.2024.05.29.07.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:00:02 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 16:00:01 +0200
Subject: [PATCH net-next v4 2/3] net: ethernet: cortina: Use negotiated
 TX/RX pause
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-gemini-phylib-fixes-v4-2-16487ca4c2fe@linaro.org>
References: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
In-Reply-To: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

Instead of directly poking into registers of the PHY, use
the existing function to query phylib about this directly.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index ff3aeee15e5b..b33f9798471e 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -292,8 +292,8 @@ static void gmac_adjust_link(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
 	union gmac_status status, old_status;
-	int pause_tx = 0;
-	int pause_rx = 0;
+	bool pause_tx = false;
+	bool pause_rx = false;
 
 	status.bits32 = readl(port->gmac_base + GMAC_STATUS);
 	old_status.bits32 = status.bits32;
@@ -328,14 +328,9 @@ static void gmac_adjust_link(struct net_device *netdev)
 	}
 
 	if (phydev->duplex == DUPLEX_FULL) {
-		u16 lcladv = phy_read(phydev, MII_ADVERTISE);
-		u16 rmtadv = phy_read(phydev, MII_LPA);
-		u8 cap = mii_resolve_flowctrl_fdx(lcladv, rmtadv);
-
-		if (cap & FLOW_CTRL_RX)
-			pause_rx = 1;
-		if (cap & FLOW_CTRL_TX)
-			pause_tx = 1;
+		phy_get_pause(phydev, &pause_tx, &pause_rx);
+		netdev_dbg(netdev, "set negotiated pause params pause TX = %s, pause RX = %s\n",
+			   pause_tx ? "ON" : "OFF", pause_rx ? "ON" : "OFF");
 	}
 
 	gmac_set_flow_control(netdev, pause_tx, pause_rx);

-- 
2.45.1


