Return-Path: <netdev+bounces-51116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A834E7F92F0
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 15:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE536281126
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F771D2F6;
	Sun, 26 Nov 2023 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CFYFTrSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B5EB
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 06:10:53 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00a9c6f283so453252566b.0
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701007851; x=1701612651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf3BBbGgK38KEJry5f+skZG4ReehlnPep5PbY6SoWGQ=;
        b=CFYFTrSxcrA8TfeWR3G1Y5sOoDm20rR8R3NFf7ESSCc1n4ILNyrT7g0Y6sTs38NX3S
         jUW8ttrPG+5UZ4PbQKYpoESwyo5BSFnVjZSMrCiS3iD6nd/Ys41qcLD2deUV0fVNz/9X
         wGjcLv2FrQiB9qz7albIHwfi51Rr/dBofveH27wAjBhFmi4iCzkuTSjgBDl+zc4FTJT3
         9f/PiDwuLdQxMKvLL9r2djR9lY5Ad8cucSlmk8SZwQSSKSfiUvHc56mnOKp/LbRsLWqJ
         1nDqoLj1CNesd3K+MAl3vzxIoVh53/xip0H+gwRNY4x+0v8esbFbCKYBPM5aa9O/0TnP
         w2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701007851; x=1701612651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf3BBbGgK38KEJry5f+skZG4ReehlnPep5PbY6SoWGQ=;
        b=a8f0LgNpEwjKST8VACxAn/jxPpdmPjGT90eQMXpqeEXyNdwFBwmCL+4uT1tcy6tvCo
         pAVQKcURFQQHMkzigJ15T+eugHq+usrecDIJEY9s8Nq5pOHJgXeHbDdJ2ABsHkg3+DiI
         TjZ15CfZ6AV/rzE1kLc2VmNxkNjDj5OQM/6tHxsupSTxa89J5f6fhu+4QCJPhZKM7nLD
         4v0HX8xXrCVV+0zmKN+K1QBvvc/1kFLekOndWqWGfGyutFg5KmQqvLt8Sn5lXmx+TpUK
         eFNsPcLWHFFsKc3DEaIHcr2mbi+bfD8QmoZCMmQy1zxNXL0ne2Z6+E1MTCjEjvaixUMJ
         AGaw==
X-Gm-Message-State: AOJu0YxTokOuFjWsL2ubiwh8h5Np5v426KQzXB975eN+Aqjo28iQMhHb
	J6NLLm0Verz7t6rzgs0oYdJvdg==
X-Google-Smtp-Source: AGHT+IFQxU7KH05yMJU+q5DjIE3FNct1n5ReGHCv7CyKkjdrnTGipQuhi7GpiH5b23rMBzVDJj8YEQ==
X-Received: by 2002:a17:906:4e:b0:a0d:a567:b92a with SMTP id 14-20020a170906004e00b00a0da567b92amr1525873ejg.39.1701007851676;
        Sun, 26 Nov 2023 06:10:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b009fc0c42098csm4603423ejb.173.2023.11.26.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 06:10:51 -0800 (PST)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nicolas.ferre@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	jgarzik@pobox.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 1/2] net: phy: Check phydev->drv before dereferencing it
Date: Sun, 26 Nov 2023 16:10:45 +0200
Message-Id: <20231126141046.3505343-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The macb driver calls mdiobus_unregister() and mdiobus_free() in its remove
function before calling unregister_netdev(). unregister_netdev() calls the
driver-specific struct net_device_ops::ndo_stop function (macb_close()),
and macb_close() calls phylink_disconnect_phy(). This, in turn, will call:

phy_disconnect() ->
  phy_free_interrupt() ->
    phy_disable_interrupts() ->
      phy_config_interrupt()

which dereference phydev->drv, which was already freed by:
mdiobus_unregister() ->
  phy_mdio_device_remove() ->
    device_del() ->
      bus_remove_device() ->
        device_release_driver_internal() ->
          phy_remove()

from macb_close().

Although the sequence in the macb driver is not correct, check phydev->drv      
before dereferencing it in phy_config_interrupt() to avoid scenarios
like the one described.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel")
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/net/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index a5fa077650e8..dd98a4b3ef81 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -165,7 +165,7 @@ EXPORT_SYMBOL_GPL(phy_get_rate_matching);
 static int phy_config_interrupt(struct phy_device *phydev, bool interrupts)
 {
 	phydev->interrupts = interrupts ? 1 : 0;
-	if (phydev->drv->config_intr)
+	if (phydev->drv && phydev->drv->config_intr)
 		return phydev->drv->config_intr(phydev);
 
 	return 0;
-- 
2.39.2


