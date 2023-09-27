Return-Path: <netdev+bounces-36524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B63F7B0429
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B7166282E51
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707F28DD6;
	Wed, 27 Sep 2023 12:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652A28DBA;
	Wed, 27 Sep 2023 12:29:39 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E3192;
	Wed, 27 Sep 2023 05:29:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40566f8a093so78685595e9.3;
        Wed, 27 Sep 2023 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695817775; x=1696422575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djhGgzEttuBwypRoTD2e7qd8nkSbwt4HcuoP4naClbc=;
        b=T1vxRkgobVuEmy6Gz7IHeQuRs49WWLYWxWBFjZ7+8feXTId1NtFjvEJjUltQdfwpGk
         dHcmsIyG1aGPmIEOk+QbmX++XFLXitPspNtBjTqC/l/PfoPqB7vMv+2Etn8XU6JoC9qN
         Uv/cFARJHXGIGF+288ja9sZuisnEeeWtOAX1ZXj9Li/USj9QiBtkMzVVwgDWgu5dUqAs
         NMQlxRR+p29pVCCFdpzCFF3eBuhWzE05XdFgZyyR/ki7h8Q0ct8qTj5ehCVTXRt3N1dZ
         SAIOQ3mB+HoWNRt+hs1eydJ7FaxD11dQzm+nScHqSMs50LKgBpioVmJ3P97Pp516kf8S
         rQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695817775; x=1696422575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djhGgzEttuBwypRoTD2e7qd8nkSbwt4HcuoP4naClbc=;
        b=BlkW/8/leXqul+xuyC2TwclDDvr8RWUjudEWSKqyn74ewP/Ajld6rtxu9WSpO6NTiH
         QOyk9qjtFjddSmo8AkqGidqEqcmrYt7clVc/7Dgy+6odVvlrIc9+KNWLkvs+ycvg7zOo
         yjXWLpNH8ozm93D9gxE+SV53glYXoFY29EI/wN0GZ8OreZCnPmVR40b+J7dnz2dojy7m
         cBrxgK7QtfJjpdpZX7YYXMA+j93e4fqm/O1DwI1VYdHj1oAQ89zfWe3//mRJLbieo2K5
         JEhH69sazCAN8UMcOF7ctbIK2/cxxKoFoVyz/UPip9PzFXcgwjHr3XK9L7ocY6IPa6so
         n/xw==
X-Gm-Message-State: AOJu0Yx3i09AehFZCvDRAPH2GKXZjKvuvgj7GKQS/ERAnB1zLRFza9df
	XelXHfkDxxnO484qq6dTXHk=
X-Google-Smtp-Source: AGHT+IHcQL3pFBI02XxvUXVb6GR+GG2cph2JWQp8B1W1KKSu38pGMBYcBmAR8ek1iOZ6aemezFAIAA==
X-Received: by 2002:a05:6000:1188:b0:31a:d4e4:4f63 with SMTP id g8-20020a056000118800b0031ad4e44f63mr1488621wrx.18.1695817775087;
        Wed, 27 Sep 2023 05:29:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id 8-20020a05600c230800b004042dbb8925sm4521218wmo.38.2023.09.27.05.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:29:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 2/2] net: stmmac: add support for DMA Arbitration Scheme
Date: Wed, 27 Sep 2023 14:29:28 +0200
Message-Id: <20230927122928.22033-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927122928.22033-1-ansuelsmth@gmail.com>
References: <20230927122928.22033-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for DMA Arbitration Scheme tune up to program the DMA to put
priority on Rx instead of applying Round-Robin logic.

This special DMA bus mode was defined in the header from a long time but
was never actually implemented. This option is used on the original
setup on the ipq806x-gmac driver based on DWMAC1000.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c   | 3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 include/linux/stmmac.h                                | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index daf79cdbd3ec..14eb7e8d61ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -104,6 +104,9 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
 	if (dma_cfg->aal)
 		value |= DMA_BUS_MODE_AAL;
 
+	if (dma_cfg->arbit)
+		value |= DMA_BUS_MODE_DA;
+
 	writel(value, ioaddr + DMA_BUS_MODE);
 
 	/* Mask interrupts by writing to CSR7 */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 843bd8804bfa..f5791b03b320 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -576,6 +576,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	dma_cfg->pblx8 = !of_property_read_bool(np, "snps,no-pbl-x8");
 
 	dma_cfg->aal = of_property_read_bool(np, "snps,aal");
+	dma_cfg->arbit = of_property_read_bool(np, "snps,arbit");
 	dma_cfg->fixed_burst = of_property_read_bool(np, "snps,fixed-burst");
 	dma_cfg->mixed_burst = of_property_read_bool(np, "snps,mixed-burst");
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c0079a7574ae..04a61f1eba90 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -97,6 +97,7 @@ struct stmmac_dma_cfg {
 	int fixed_burst;
 	int mixed_burst;
 	bool aal;
+	bool arbit;
 	bool eame;
 	bool multi_msi_en;
 	bool dche;
-- 
2.40.1


