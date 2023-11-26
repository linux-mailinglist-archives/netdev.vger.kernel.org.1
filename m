Return-Path: <netdev+bounces-51117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC77F92F1
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 15:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF9FB20E1F
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97333D313;
	Sun, 26 Nov 2023 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="R0MX3P5L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6B4F3
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 06:10:55 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00b056ca38so449858966b.2
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 06:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701007853; x=1701612653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G30K0Y0szZ7FUxHtENoJCMPPG9CnH+Xt3mCwLqz9nTs=;
        b=R0MX3P5LKjKuWKFRvvhT4ZhtCc0A76L6j7srJtLOFr4VpkDDxABcnOCbS3IMDtAjsU
         5lhC4La+Jnp26BQT/2WynYmzyHKY0+LVBATBCT8hWyXDpZDl4umD5LBJgF1zNxdn5z7T
         qQx2FMIu5Z3ySuqZj5TPTCBhe0OksBcfNJxm17K7VGYQ281TRLEVD5mCJJGvO+Dsdau8
         68Rs//BWrI6PDntJU1oUFdWfIHYBJbXhozuVBIaw2WJFwB2pipzPGceFTEIja9KUgCsK
         +fpPJgabDHuQauXLlIuuD3AoJW1Af3ngyZ0+eTgjk3q93y5vdkESaH7G8/n3WjENvTxr
         o5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701007853; x=1701612653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G30K0Y0szZ7FUxHtENoJCMPPG9CnH+Xt3mCwLqz9nTs=;
        b=Uhl1EZu3OD5thnC0W4va6TtmkhRQhnGFkUTfGaRvwckUdt6fSnOylQ4pPqFTLBZxwE
         aKeX+OiZH89TMl4RxRYiGNE7hHcWXphXLICGC0SIoIN9hSMi3odbjKkIA6+KOOmEqRiW
         dg20BW6+ugBpzVfgrb0D5x45P17BUL7GPYMlED13qae4H5zGjRuW/L1+zo7wQhx/Pi/t
         5bL6nDAjjwEWPpjqsdLgAhTqNo0a5D2dtakxNE4oog/11ywpWtNna3u7teO/XHE/fe/p
         hiVXcjpeaJD10gyVShHrxiNmO5W1pdKmkrka1xKaDu6IP6d+u+dIh/TwSvb65BI8iV6V
         TldA==
X-Gm-Message-State: AOJu0YzDoUKCFMEN0ApOVE0FFm9rL0zyErpCjoRha+WCGdH2OCVKjOK/
	F0ds31jSrX93Z2t3n56Gw+bbtA==
X-Google-Smtp-Source: AGHT+IHchuuV9GIsfhQWjw/7BZ/J4Ph2nLVq3ar7gUWKPuajHEh5h7gDvjAB7XKvfY1lncPbjEnouw==
X-Received: by 2002:a17:906:10d7:b0:a0c:87e4:8097 with SMTP id v23-20020a17090610d700b00a0c87e48097mr2048227ejv.66.1701007853102;
        Sun, 26 Nov 2023 06:10:53 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b009fc0c42098csm4603423ejb.173.2023.11.26.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 06:10:52 -0800 (PST)
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
Subject: [PATCH 2/2] net: macb: Unregister nedev before MDIO bus in remove
Date: Sun, 26 Nov 2023 16:10:46 +0200
Message-Id: <20231126141046.3505343-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unregister_netdev() calls the struct net_device_ops::ndo_stop function,
which in the case of the macb driver is macb_close(). macb_close() calls,
in turn, PHY-specific APIs (e.g., phy_detach()). The call trace is as
follows:

macb_close() ->
  phylink_disconnect_phy() ->
    phy_disconnect() ->
      phy_detach()

phy_detach() will remove associated sysfs files by calling
kernfs_remove_by_name_ns(), which will hit
"kernfs: cannot remove 'attached_dev', no directory" WARN(), which will
throw a stack trace too.

To avoid this, call unregiser_netdev() before mdiobus_unregister() and
mdiobus_free().

Fixes: 7897b071ac3b ("net: macb: convert to phylink")
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index cebae0f418f2..73d041af3de1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5165,11 +5165,11 @@ static void macb_remove(struct platform_device *pdev)
 
 	if (dev) {
 		bp = netdev_priv(dev);
+		unregister_netdev(dev);
 		phy_exit(bp->sgmii_phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
 
-		unregister_netdev(dev);
 		tasklet_kill(&bp->hresp_err_tasklet);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.39.2


