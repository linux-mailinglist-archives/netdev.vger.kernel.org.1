Return-Path: <netdev+bounces-95600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6E8C2C74
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705111C212F2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8084813D263;
	Fri, 10 May 2024 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPhihtCb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0E13D243
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378940; cv=none; b=GwrTxo5BnAPkahNe1T6SSRgdH4SQTgoHN6dtHTIOF6HsRGs2NqBnfhwWAa+bg9hhsjPuHxvQhj/7b9fCkEbkfSIHrViwiRUbAShUNVPpKfaHNjApvjvjjB+OyOlR3DxOnz3KKw3A0y72M3D/0sCGR9s9+PH3zb0+RKGVP4HTHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378940; c=relaxed/simple;
	bh=xQIYBxkBv0T2jXpUE0izOur858+mVuU9VH6jubzoR5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHx0K7d4J/vWgbIgXEN8mXkoY1DuDrRy8eRKMchVYVhFAEUX7kdN6ASqkO3MKiFKDnVTpbyyva4H55CAgjU3QUDgF6GCLaBt5yFj/wnYRV2USe62mPJZ5g9fp+cuvMidoHfChKW/V8ReDu9zH15Uie4rNnGifY+vvBJYCNrWG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hPhihtCb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a157a1cd1so622329266b.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715378937; x=1715983737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JY2M0W5sJkBljmZwX5JiVcqYzpxebL05MDZ/Dt9N2Bo=;
        b=hPhihtCbMNXAyI9KJCdVQF4vrXfi4BOU/AvH4bgPcVpcUYqvuSvRhMdFOtgkGbGCon
         7Qgfu0BlClNbtAiiaxhHbYvwNSnxo6fWp0bRSnpTQLM3d/lLtR5oGYwMRhzbPa6i1It3
         zg7ox4gi+g2wnY99Zgrj7OsLfXJyl1g5ioFNs4vm3pMs+FBd3xP9kA4gXXLi4ye0MoKQ
         sQXj24sw2wl7OIiTD/xGR8iNRuE+JhXdcprm1Fr05OsfaBIGNYQxAy3bsRyG2KpayGOd
         PVgWOEDuUNOllWzOA8fp2d2WlBhee1gnMYNfHm90l0NQiZ4HIaFq7syH6fdd77JdA1Pt
         Nf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378937; x=1715983737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY2M0W5sJkBljmZwX5JiVcqYzpxebL05MDZ/Dt9N2Bo=;
        b=kqB+lsExYcVyXKwJsbKariHCzBfuDoyV+v/GDN6Bldp5OYCvR7cuGSD/pEPTh5uOr3
         UuknySJtlakiVW6jllJAK2chnkzkKq6jGHSDC1Tmn8J7SkGkYFXw0sOEW8KUqWVKmSLh
         OhIgrYyyoof/sZcDDWdg11cuOdfSzsgA416uwOctyhDbQ2jERj38dV1bV1WGkr4iZbaE
         TwMuzcI4PIwyWBlbb1pNMihY25FaENH+op8Q0MQyHO3beTAJUU2D1Qk0Wie1MXwJQVxx
         JCeqTajzZGxfLcfYJjcizbqi6v6U08R7wlWCcOFpKVmzE6yMHNmLHhk5hu7WxKHrr4kx
         SxpQ==
X-Gm-Message-State: AOJu0YxUdJ4AXQV5ggWYa/W0BSk3HfVZShswLD31tRsWz6XLnNgxUkpd
	5j6RAGCgSji3JXXNLRs3AZOhTjz0ocn6/ezbV+Xl+8mXGLxgJ4sHyp9T/JFmltY=
X-Google-Smtp-Source: AGHT+IHwKWKKEsG7kwRGgj+0NRYPmkZB3ozttc89r2itP9s1NVipFrp/9nBlJv0Vcn31ba6KEtSvpA==
X-Received: by 2002:a17:906:c452:b0:a59:ee81:fd68 with SMTP id a640c23a62f3a-a5a2d68089bmr259803066b.71.1715378937287;
        Fri, 10 May 2024 15:08:57 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce3fsm228219866b.4.2024.05.10.15.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:08:56 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 11 May 2024 00:08:41 +0200
Subject: [PATCH net-next v2 3/5] net: ethernet: cortina: Rename adjust link
 callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240511-gemini-ethernet-fix-tso-v2-3-2ed841574624@linaro.org>
References: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
In-Reply-To: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

The callback passed to of_phy_get_and_connect() in the
Cortina Gemini driver is called "gmac_speed_set" which is
archaic, rename it to "gmac_adjust_link" following the
pattern of most other drivers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 3ba579550cdd..e9b4946ec45f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -288,7 +288,7 @@ static void gmac_set_flow_control(struct net_device *netdev, bool tx, bool rx)
 	spin_unlock_irqrestore(&port->config_lock, flags);
 }
 
-static void gmac_speed_set(struct net_device *netdev)
+static void gmac_adjust_link(struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
@@ -367,7 +367,7 @@ static int gmac_setup_phy(struct net_device *netdev)
 
 	phy = of_phy_get_and_connect(netdev,
 				     dev->of_node,
-				     gmac_speed_set);
+				     gmac_adjust_link);
 	if (!phy)
 		return -ENODEV;
 	netdev->phydev = phy;

-- 
2.45.0


