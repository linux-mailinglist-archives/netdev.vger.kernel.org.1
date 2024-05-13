Return-Path: <netdev+bounces-96056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664328C4216
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE9CB211BD
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC2B153574;
	Mon, 13 May 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDD9Wd50"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0C153515
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607537; cv=none; b=HPI2umqUqj2+oBhAzgslgkbHlUjD08wYjM8wLdwnmivuXqYOEtix763ATdM32MavJQYbN1eArec9qHbhs5vDJ4sjYrbhF1RaIbpyew6h5gb//VNN0jVsIqQTdl34tlYWpMUzkAUbWgwHZvp2I9CciTDRGKjHKNjuJsJBbMFyPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607537; c=relaxed/simple;
	bh=cmp18ZvxdKWGkb+gwWR/T8ZHlXVZdrrc3KH89R9VyXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8NnO3OYoUaYwe4XJoa59wzoMs1mMyFG10cGvsakpaCb8uVec2ec4OMamLg2w8UJAuuS2J6odvk1d0KIokHnZKFQ0HRAHhlr/0O7YDJDfwoAPHegliNX2Qjono5R28/g62BctcX852AsPWX40/pTDMgo7WlmK5VAIsUxpM2D/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uDD9Wd50; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f0602bc58so4854104e87.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715607534; x=1716212334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtLzkwQfQIttMYAXK7GWx6gN+UA6UwpKLoqnSdikuvQ=;
        b=uDD9Wd50bYvgOBOYSoAM22yFZkv6SqFwS6xLSdOuus5uU3he5YTvdKKUTQitET2dhF
         KLog3GU3kHc083vfHUcWfJmbxBPs4e8qhk+BTM7P8FC94ykBufnw1fWSs+THdIVJHttx
         Pg+7hxJYNaAIddsvRIIiW2Ev/l/kq5gbWfvO/3eE+f5YsiuIxDkcOpFS5WhXz763oyc9
         03aIhTKwmLDtsXtaOWzqWCx2pY3MZ4ZiPr/BlqLrlPImHFCwy8UNalCLi0TRNAncXEOi
         y63A+TbsLxNQD7NuT+U2sDCBYfJkGIUv/bq/2vpZvpmDLsEXlMOAqEVeH4L2iMNBe3gf
         jhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715607534; x=1716212334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtLzkwQfQIttMYAXK7GWx6gN+UA6UwpKLoqnSdikuvQ=;
        b=KlbRoB8Bx4knQ39wUViz/g82kl1BN30LGcBzI5BcNWB190y4njO/tIdtv5aN4pOpO8
         K0u/1caRzuL6yaHZywJjADyGs8Ao6QWUISCbWKC2d+C9wy9d1H59KSnaL/qjJR5PlMbW
         J/S5oRuwqdgKp62EGyMpIjj/2UMlgbfXLSZKK78OwykfSheUXGn+3dqCNcZnmsDOI6Wr
         CF8GmylJIFwjeL8XcZ19lWd8Wg2CjLcGszWz2TZbwz35Zt4O285yeSCzIcQqQ8SMuS67
         KZzWtXA4s0N+qPYTAIUJynncEnIATdFin2FWUF9MK0QcX7n1dXtV8AYzaHp1zhqL2bE5
         BD+A==
X-Gm-Message-State: AOJu0YzuKJHjQLYaah4nuobRIWpAUUGDAp2B0NWRR8/XNxPm+TolW4Ox
	h+pnL62csrnhGcudZtsSSCWTPvWvmHrHkVWWPcVsh+n6RXvdiX2yOB3n6uRyU+U=
X-Google-Smtp-Source: AGHT+IFsjYMOb7wLp1yXVSNau4KipnBA9TriKKowAmyxP6N4AmsWVsTkvSaFmfly5X5TpgNIyxUINg==
X-Received: by 2002:a05:6512:55b:b0:51b:a86:ab57 with SMTP id 2adb3069b0e04-521e126c26cmr4395651e87.22.1715607533854;
        Mon, 13 May 2024 06:38:53 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d899asm1757367e87.231.2024.05.13.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:38:53 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 15:38:50 +0200
Subject: [PATCH net-next v3 3/5] net: ethernet: cortina: Rename adjust link
 callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-gemini-ethernet-fix-tso-v3-3-b442540cc140@linaro.org>
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
In-Reply-To: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


