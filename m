Return-Path: <netdev+bounces-51582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5647FB395
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1F0282376
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DBA14F9A;
	Tue, 28 Nov 2023 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PrE3MAkP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E46D4C
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:04:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b4f6006d5so456655e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701158691; x=1701763491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llunhkM8sKXrafDQaQtl/MAyFYLs2dUG+zsrZHGyqOA=;
        b=PrE3MAkPkGQcth7uVaMUssbZEHhpQknLEbWRZVyPUW/LT+seWNHo8Ox1JohwEXY1qP
         R4EF+8QaGmNSOEzhfiP7ywLFi8++Mr/S1eL6p2Y4BinebiRPwRdvDKfUg5ABPUdrTJuf
         85ZVmWxqVQ4zRVwVPrFJw8wuQ/LJuGDVNsBkryLqb3PkOPgu7e6NjBXhIu0hi/c4ul4m
         APwfDK/yLoS0wElgR1SgQLjB/Jwct5XYTH5Gb//1nXeKYp3NZJR3ElYaBnQxbVvQY3Bl
         ABfJSq5FUTxP7SGiQYl58FAu3Y7Hyeyrmt7wgPIBLHwhUibLsXHmAKBABUZY8pn2r5/l
         5Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158691; x=1701763491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llunhkM8sKXrafDQaQtl/MAyFYLs2dUG+zsrZHGyqOA=;
        b=HZBJNgVY6uRmzAqFHYqlF6Yv0B3dGK9Qg+pKmfRlkSSwsZkwrKMnhPgiqRHypwTk/G
         kGya+soJTqGE7Ra6tLpqmWwJLWd+m02R912WCN5H7jYHUo9KWLkU14TqX+9O7+J6zf4R
         KkmAbNG43W2Rg0fWBe0U3i/y5HQxBEg9Ct9bbP2WZcEfFxb4vSYaSX82qvieXasV+KDU
         vmOxoksM6+N8NqId+NhyiKqMVRMHLlQvQ85O9Oo1UIe+S2Ph1q9QfBJBHQwzN9ERbu7Y
         EspsasYiHLcGBx6QNklfD7ZvUM1a/E6v2nCgdZYxsbjXBRe30zZDxjPHRyPq1GQ8gzHu
         +1Tw==
X-Gm-Message-State: AOJu0YxQ0komWvBR9JZVeRGlTfYySOucuGEo5a7+goAlVyZjS3Kf2A7v
	+Rs+xliGESNq+FCGamcuIHI1rw==
X-Google-Smtp-Source: AGHT+IGnCMgf0SdfdRgyacJnLuJ5KyPuGcHpPOquhV3N6OvasOIFBd4jOd1MCEmiwzmtXLhZkt/QWg==
X-Received: by 2002:a05:600c:1f82:b0:408:364e:34a2 with SMTP id je2-20020a05600c1f8200b00408364e34a2mr6194992wmb.10.1701158691121;
        Tue, 28 Nov 2023 00:04:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm1127534wmq.2.2023.11.28.00.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:04:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	renesas@sang-engineering.com,
	robh@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	mitsuhiro.kimura.kc@renesas.com,
	masaru.nagai.vx@renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] net: ravb: Keep reverse order of operations in ravb_remove()
Date: Tue, 28 Nov 2023 10:04:39 +0200
Message-Id: <20231128080439.852467-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On RZ/G3S SMARC Carrier II board having RGMII connections b/w Ethernet
MACs and PHYs it has been discovered that doing unbind/bind for ravb
driver in a loop leads to wrong speed and duplex for Ethernet links and
broken connectivity (the connectivity cannot be restored even with
bringing interface down/up). Before doing unbind/bind the Ethernet
interfaces were configured though systemd. The sh instructions used to
do unbind/bind were:

$ cd /sys/bus/platform/drivers/ravb/
$ while :; do echo 11c30000.ethernet > unbind ; \
  echo 11c30000.ethernet > bind; done

It has been discovered that there is a race b/w IOCTLs initialized by
systemd at the response of success binding and the
"ravb_write(ndev, CCC_OPC_RESET, CCC)" call in ravb_remove() as
follows:

1/ as a result of bind success the user space open/configures the
   interfaces tough an IOCTL; the following stack trace has been
   identified on RZ/G3S:

Call trace:
dump_backtrace+0x9c/0x100
show_stack+0x20/0x38
dump_stack_lvl+0x48/0x60
dump_stack+0x18/0x28
ravb_open+0x70/0xa58
__dev_open+0xf4/0x1e8
__dev_change_flags+0x198/0x218
dev_change_flags+0x2c/0x80
devinet_ioctl+0x640/0x708
inet_ioctl+0x1e4/0x200
sock_do_ioctl+0x50/0x108
sock_ioctl+0x240/0x358
__arm64_sys_ioctl+0xb0/0x100
invoke_syscall+0x50/0x128
el0_svc_common.constprop.0+0xc8/0xf0
do_el0_svc+0x24/0x38
el0_svc+0x34/0xb8
el0t_64_sync_handler+0xc0/0xc8
el0t_64_sync+0x190/0x198

2/ this call may execute concurrently with ravb_remove() as the
   unbind/bind operation was executed in a loop
3/ if the operation mode is changed to RESET (through
   ravb_write(ndev, CCC_OPC_RESET, CCC) call in ravb_remove())
   while the above ravb_open() is in progress it may lead to MAC
   (or PHY, or MAC-PHY connection, the right point hasn't been identified
   at the moment) to be broken, thus the Ethernet connectivity fails to
   restore.

The simple fix for this is to move ravb_write(ndev, CCC_OPC_RESET, CCC))
after unregister_netdev() to avoid resetting the controller while the
netdev interface is still registered.

To avoid future issues in ravb_remove(), the patch follows the proper order
of operations in ravb_remove(): reverse order compared with ravb_probe().
This avoids described races as the IOCTLs as well as unregister_netdev()
(called now at the beginning of ravb_remove()) calls rtnl_lock() before
continuing and IOCTLs check (though devinet_ioctl()) if device is still
registered just after taking the lock:

int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
{
	// ...

        rtnl_lock();

        ret = -ENODEV;
        dev = __dev_get_by_name(net, ifr->ifr_name);
        if (!dev)
                goto done;

	// ...
done:
        rtnl_unlock();
out:
        return ret;
}

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- fixed typos in commit description
- collected Rb tag

Changes since [1]:
- s/ravb_dma_init/ravb_dmac_init in commit description
- collected Rb tag

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2396fab3f608..9178f6d60e74 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2894,22 +2894,26 @@ static void ravb_remove(struct platform_device *pdev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 
-	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
-	clk_disable_unprepare(priv->gptp_clk);
-	clk_disable_unprepare(priv->refclk);
-
-	/* Set reset mode */
-	ravb_write(ndev, CCC_OPC_RESET, CCC);
 	unregister_netdev(ndev);
 	if (info->nc_queues)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
+
 	ravb_mdio_release(priv);
+
+	/* Stop PTP Clock driver */
+	if (info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
+
+	/* Set reset mode */
+	ravb_write(ndev, CCC_OPC_RESET, CCC);
+
+	clk_disable_unprepare(priv->gptp_clk);
+	clk_disable_unprepare(priv->refclk);
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(priv->rstc);
-- 
2.39.2


