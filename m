Return-Path: <netdev+bounces-49288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90357F1819
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44A61C2185F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E7E1DFD0;
	Mon, 20 Nov 2023 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="fl30HzBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F556B4
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:03:30 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c876e44157so24017791fa.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700496209; x=1701101009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAl6nd1nCzN04zqiBnYIqrG9SwaJGuvdGPy3QreQOpU=;
        b=fl30HzBajmU6iBX/sNZgfLeGSGBViaEUu7KUbSEmOLODZoM292E8eatYCZL4Ub09f0
         +Rbtw3vzg09boNsmENP2mkMdjli6fBFsbu/z11YFdCmX4IhKH8gQ22RC7bYk4RHDXdil
         iMWLjKZAkbnkPcB6fkg+VJycPPckYppNLUCegngV/e4oU0BW/xGV2h3HFhsXpsOvb4I1
         wJZ1/h90NdpWp0f3jYMJkYOXEfkP53WOd/DWzRNlC/L9naLcz1WB8VeU30TE16XH8mQm
         grjbM+IQTTI++AB8WvazShgNYHFnF2KXihqA6COnzIF3LWgtUvkFU/R563TyfWMVJS2Z
         q/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700496209; x=1701101009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAl6nd1nCzN04zqiBnYIqrG9SwaJGuvdGPy3QreQOpU=;
        b=IM/9ekOdBky1+gXEyhFqSXkYHG+6YMFuy0t5jOU24WHHtyyg/vJ04bv9p7e++yLawj
         K2TncU83+LK2B6l8DbpezndpgIbSfydcHtp4+GJz1Z4gdnvI98qCZpii9dlVs69JYPEJ
         OD81laZ2eNbQR3LyPsLddGphKZp2kouTsxzX/khjJjYCvikxssggBCejMFKYRvwQEfp+
         VYNBNOV39zRBtzBX5w1bhnHdJC+vz8JPvGGfthEVpu4ECyWElxcZj8eJ4o9adqpOEGwJ
         Yf+pMj5im/Q/eUE826UpTXqYCzHUWw6mNaBzChfC+lBfAbzsjOqtzPETpaBaziEsHqtH
         o6Ww==
X-Gm-Message-State: AOJu0YxcOpLQVzrm+4lH5JP6IQZfVg8zT7sJVP4sYb73e/cBVMBBxJr1
	dADNvqjKzYtWdCklihllFWcvgg==
X-Google-Smtp-Source: AGHT+IH9y3TjxSbJc9gvoYuUHR2atdzxyQzCyOsaNpkl35ZWJdmfWceSEAGzPZVSde7QgIkoFiUFzg==
X-Received: by 2002:a2e:709:0:b0:2c5:6c7:9e73 with SMTP id 9-20020a2e0709000000b002c506c79e73mr5317559ljh.48.1700496208747;
        Mon, 20 Nov 2023 08:03:28 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id m21-20020a7bce15000000b004080f0376a0sm13564631wmc.42.2023.11.20.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:03:27 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [net-next v2 2/5] net: ethernet: renesas: rcar_gen4_ptp: Fail on unknown register layout
Date: Mon, 20 Nov 2023 17:01:15 +0100
Message-ID: <20231120160118.3524309-3-niklas.soderlund+renesas@ragnatech.se>
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

Instead of printing a warning and proceeding with an unknown register
layout return an error. The only call site is already prepared to
propagate the error.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
* Changes since v1
- Added review tag from Wolfram.
---
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
index c007e33c47e1..443ca5a18703 100644
--- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
+++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
@@ -130,23 +130,30 @@ static struct ptp_clock_info rcar_gen4_ptp_info = {
 	.enable = rcar_gen4_ptp_enable,
 };
 
-static void rcar_gen4_ptp_set_offs(struct rcar_gen4_ptp_private *ptp_priv,
-				   enum rcar_gen4_ptp_reg_layout layout)
+static int rcar_gen4_ptp_set_offs(struct rcar_gen4_ptp_private *ptp_priv,
+				  enum rcar_gen4_ptp_reg_layout layout)
 {
-	WARN_ON(layout != RCAR_GEN4_PTP_REG_LAYOUT_S4);
+	if (layout != RCAR_GEN4_PTP_REG_LAYOUT_S4)
+		return -EINVAL;
 
 	ptp_priv->offs = &s4_offs;
+
+	return 0;
 }
 
 int rcar_gen4_ptp_register(struct rcar_gen4_ptp_private *ptp_priv,
 			   enum rcar_gen4_ptp_reg_layout layout, u32 clock)
 {
+	int ret;
+
 	if (ptp_priv->initialized)
 		return 0;
 
 	spin_lock_init(&ptp_priv->lock);
 
-	rcar_gen4_ptp_set_offs(ptp_priv, layout);
+	ret = rcar_gen4_ptp_set_offs(ptp_priv, layout);
+	if (ret)
+		return ret;
 
 	ptp_priv->default_addend = clock;
 	iowrite32(ptp_priv->default_addend, ptp_priv->addr + ptp_priv->offs->increment);
-- 
2.42.1


