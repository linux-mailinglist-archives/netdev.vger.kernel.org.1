Return-Path: <netdev+bounces-21443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32647763A02
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6320E1C213B5
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F2CA75;
	Wed, 26 Jul 2023 15:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EEF1DA47
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:02:51 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A52688;
	Wed, 26 Jul 2023 08:02:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id AFCD01C0004;
	Wed, 26 Jul 2023 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1690383765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+d5s9323iF8ft7c8DhbJ/Jl0ODynHXS04sT7BffHRn4=;
	b=KlmSK+LVgexPCfc9c3JZfqCZC6QOt+I2+Zl6MZ3M4QVEQy4PxkuLxKuCQ/9t7uk27STRPz
	/0XLckGrkPlSad1c1BhRwQhGah8OKh8xqNvY1jSrNSw7emdWDOpK1g3CAL8QNyykPEaybb
	oEmxpAkenkLOUB8WC/Y8JvwuV1o67bL8QWbR1ohY9BaMmbKIE3XMWBKqbgnM1yzbgS5IOU
	gHPlvoNhM4SLSNPxtAganjBetxyVT463g6+3faZOg8XOK8YCWryKrX95Lkwe3dzIvne2Bm
	icXMELd4CRyRNut+3ii6nrMXFf92HBviuL8WEHP6MjzH8lNTnAhVi3x9M7NK+A==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 03/28] soc: fsl: cpm1: qmc: Fix rx channel reset
Date: Wed, 26 Jul 2023 17:01:59 +0200
Message-ID: <20230726150225.483464-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726150225.483464-1-herve.codina@bootlin.com>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The qmc_chan_reset_rx() set the is_rx_stopped flag. This leads to an
inconsistent state in the following sequence.
    qmc_chan_stop()
    qmc_chan_reset()
Indeed, after the qmc_chan_reset() call, the channel must still be
stopped. Only a qmc_chan_start() call can move the channel from stopped
state to started state.

Fix the issue removing the is_rx_stopped flag setting from
qmc_chan_reset()

Fixes: 3178d58e0b97 ("soc: fsl: cpm1: Add support for QMC")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 7ad0d77f1740..8dc73cc1a83b 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -685,7 +685,6 @@ static void qmc_chan_reset_rx(struct qmc_chan *chan)
 		    qmc_read16(chan->s_param + QMC_SPE_RBASE));
 
 	chan->rx_pending = 0;
-	chan->is_rx_stopped = false;
 
 	spin_unlock_irqrestore(&chan->rx_lock, flags);
 }
-- 
2.41.0


