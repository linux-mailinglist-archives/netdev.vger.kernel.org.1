Return-Path: <netdev+bounces-49291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C47F181C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D0A1C21864
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2D1E502;
	Mon, 20 Nov 2023 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="vJXcUxqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA764AA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:03:35 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50970c2115eso6535325e87.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700496214; x=1701101014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qer5SIgtLUsRnvdV4wIK4MVmII4A/reZeCq78BgyVHs=;
        b=vJXcUxqzL69qzWIxz964/H4wl6qOFllrt407lDIkJPzcIC4M+xELDMYj1WHO1HWBiV
         7DeEyPqFMGJOtPoYdmZq6vIkQJGltTWM6tB32PEWSbd59z2DR4ZIQGcrYqcp5LJVDoY1
         7xuLkR7SUaKhCEhVNM29q85P6HXrzI/1FGwa/zWXdViKfIWc9rASAtg/ZBpaeQ4xp599
         uIgLZa9u2FYxCnrp65ZvmlQekknofj1urtiy7tVUMFk6ZwGCUVT0MqIPmFQ7o4KFXgel
         uSDmjElUWBLQCWbo8T0kD1sdGqM+wzGGkJUILDKF7N07wAQ2hN+cIPB0vSFhan20LDOa
         pLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700496214; x=1701101014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qer5SIgtLUsRnvdV4wIK4MVmII4A/reZeCq78BgyVHs=;
        b=jXg47pmC67dCBOuJFNd3rXMtO8WGkWJo7Uc2frTBkDJi/LDTldf59ANH84SkcX2l6o
         fr0+0DpLTdgqz8DCIG0xL0YdIsepBpPLbfddDH7Ak9DIEGWpk5MlSO0JRCOCSE17G+Cc
         QdZqs/aaMoGdadgOJG1Ae7Ed8fibWfymzoCeUd1P4ocF1m39Cwmthg3IZWb7KlAbFoeS
         7mpDUAl3sJzg5PpzmL0w+6en1P2z4lxbgOjVOJpqYQiJeFPorCaa182hLPJ+F25SsEPx
         YoHPRqPaQK2/nHeMaxQqQc0KS0HzO2CWng2LT7YoR0bKeF68Y5PP6OyEnpnIvTsdMn7V
         eZ1g==
X-Gm-Message-State: AOJu0Ywo1ooFzMryPsiVFG6Y5sEnex7698hvEOntI94VD+CzpM7PvrJL
	A65LL6j85w/iUcFtQkLDsEYDpQ==
X-Google-Smtp-Source: AGHT+IE/JH4O1AgW0MQmqNiPFcTJsQoZ04eHzRRpqqhKljW8mWvlGUoQAFLMlaGmIk9pUbyHaE5lpg==
X-Received: by 2002:ac2:44a9:0:b0:507:a9b7:f071 with SMTP id c9-20020ac244a9000000b00507a9b7f071mr5100756lfm.1.1700496213929;
        Mon, 20 Nov 2023 08:03:33 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id m21-20020a7bce15000000b004080f0376a0sm13564631wmc.42.2023.11.20.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:03:33 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next v2 5/5] net: ethernet: renesas: rcar_gen4_ptp: Break out to module
Date: Mon, 20 Nov 2023 17:01:18 +0100
Message-ID: <20231120160118.3524309-6-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120160118.3524309-1-niklas.soderlund+renesas@ragnatech.se>
References: <20231120160118.3524309-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Gen4 gPTP support will be shared between the existing Renesas
Ethernet Switch driver and the upcoming Renesas Ethernet-TSN driver. In
preparation for this break out the gPTP support to its own module.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- s/Gen3/Gen4/ in commit message.
- Add missing MODULE_AUTHOR() and MODULE_DESCRIPTION() definitions.
- Make Kconfig tristate depend on COMPILE_TEST. All drivers that make
  use of the shared code auto selects this anyhow.
---
 drivers/net/ethernet/renesas/Kconfig         | 10 ++++++++++
 drivers/net/ethernet/renesas/Makefile        |  5 +++--
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c |  7 +++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index 8ef5b0241e64..5a2e7da90e69 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -44,7 +44,17 @@ config RENESAS_ETHER_SWITCH
 	select CRC32
 	select MII
 	select PHYLINK
+	select RENESAS_GEN4_PTP
 	help
 	  Renesas Ethernet Switch device driver.
 
+config RENESAS_GEN4_PTP
+	tristate "Renesas R-Car Gen4 gPTP support" if COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select CRC32
+	select MII
+	select PHYLIB
+	help
+	  Renesas R-Car Gen4 gPTP device driver.
+
 endif # NET_VENDOR_RENESAS
diff --git a/drivers/net/ethernet/renesas/Makefile b/drivers/net/ethernet/renesas/Makefile
index e8fd85b5fe8f..9070acfd6aaf 100644
--- a/drivers/net/ethernet/renesas/Makefile
+++ b/drivers/net/ethernet/renesas/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_SH_ETH) += sh_eth.o
 ravb-objs := ravb_main.o ravb_ptp.o
 obj-$(CONFIG_RAVB) += ravb.o
 
-rswitch_drv-objs := rswitch.o rcar_gen4_ptp.o
-obj-$(CONFIG_RENESAS_ETHER_SWITCH) += rswitch_drv.o
+obj-$(CONFIG_RENESAS_ETHER_SWITCH) += rswitch.o
+
+obj-$(CONFIG_RENESAS_GEN4_PTP) += rcar_gen4_ptp.o
diff --git a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
index 9583894634ae..72e7fcc56693 100644
--- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
+++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
@@ -176,6 +176,7 @@ int rcar_gen4_ptp_register(struct rcar_gen4_ptp_private *ptp_priv,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rcar_gen4_ptp_register);
 
 int rcar_gen4_ptp_unregister(struct rcar_gen4_ptp_private *ptp_priv)
 {
@@ -183,6 +184,7 @@ int rcar_gen4_ptp_unregister(struct rcar_gen4_ptp_private *ptp_priv)
 
 	return ptp_clock_unregister(ptp_priv->clock);
 }
+EXPORT_SYMBOL_GPL(rcar_gen4_ptp_unregister);
 
 struct rcar_gen4_ptp_private *rcar_gen4_ptp_alloc(struct platform_device *pdev)
 {
@@ -196,3 +198,8 @@ struct rcar_gen4_ptp_private *rcar_gen4_ptp_alloc(struct platform_device *pdev)
 
 	return ptp;
 }
+EXPORT_SYMBOL_GPL(rcar_gen4_ptp_alloc);
+
+MODULE_AUTHOR("Yoshihiro Shimoda");
+MODULE_DESCRIPTION("Renesas R-Car Gen4 gPTP driver");
+MODULE_LICENSE("GPL");
-- 
2.42.1


