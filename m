Return-Path: <netdev+bounces-51578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD9B7FB389
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39084B20FEF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596EF168BA;
	Tue, 28 Nov 2023 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NSH+yIqa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE0ACB
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:04:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4079ed65582so36352775e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701158683; x=1701763483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TER/zjgFsQ4zH/M/nBtL41p2wpZGtg22rimu0p57AMs=;
        b=NSH+yIqa5s/ZejJN07Qauf8d3WJ0IEOgE4+CpI5Ssa7gTjJgaJ8SKPO995OfuT9yiT
         ayBU6HqLc35b+YC1Pe9OicLyCOXwsySYl+EVIcsaYZ6H8AHJROjjcYxgh3eIBuAxQR5i
         WI+9CDTAi8vOPIX9u3K5rbkKyovh0twyjTiQdGLGRyP+trLsVOMDekoT7VazH0cra6Nk
         UgFzWAdzI7bN9m7wUyFNUQSbKFLze6KCd8/jzdTqd21+1eAzztQYyWaIQ0q+qqYKgLI6
         UtjVproy8mrqO703i2QqpZmnOhBCmXFbFgMdf06JTPZSmO7asZqVGnAiunDC3+D7OvQD
         KHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158683; x=1701763483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TER/zjgFsQ4zH/M/nBtL41p2wpZGtg22rimu0p57AMs=;
        b=kHD8Ugdc+ReLRuye17e8gzUF4l0u/zIoG8+mLRNN+wHhbuQI8BwfeiuFPqM7l3AGA9
         ptDHRL3BN/ytTh4sYDhJNMl3ggbkjmsSGyUBP0BgfJr39OR4dtih7q3+Pr2iSCCWRMFl
         ndWkMrIbx5v9xkEGP1Kfm5BcS6Po2eIUy5hgUktNB8vO3nStJuYrHmYPDhIvm5NkfnaJ
         SWcrbnRA4/tVG85iTtympZx/f8IlkDIvQeC8ZzzpIRVuVA8Bb+xRCYrG1Xn2x1sMX7Wv
         CA/FNJVau+hFTkexvx+lfPpTJrRoaLTXrlatrN8oOF/ZmitFb2lMTrsjCNKtiN2P4VD3
         FkdQ==
X-Gm-Message-State: AOJu0YyTEZtie9jucCbEfSxYeKCTiDWiihpOMb737Qi3ftl8E7lJGfcA
	QjC6rtK9sCUfTkPu7WCLHoqiNg==
X-Google-Smtp-Source: AGHT+IF9kC7vFv0UFd4k0YZm4RaGwXdesZdpw8BOTVxF/2FVztXa95IPMgGc0hCY8Loptjy7Z4wZhQ==
X-Received: by 2002:a05:600c:4f8a:b0:40b:4520:45a6 with SMTP id n10-20020a05600c4f8a00b0040b452045a6mr4460089wmq.8.1701158683147;
        Tue, 28 Nov 2023 00:04:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm1127534wmq.2.2023.11.28.00.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:04:42 -0800 (PST)
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
Subject: [PATCH v2 1/6] net: ravb: Check return value of reset_control_deassert()
Date: Tue, 28 Nov 2023 10:04:34 +0200
Message-Id: <20231128080439.852467-2-claudiu.beznea.uj@bp.renesas.com>
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

reset_control_deassert() could return an error. Some devices cannot work
if reset signal de-assert operation fails. To avoid this check the return
code of reset_control_deassert() in ravb_probe() and take proper action.

Along with it, the free_netdev() call from the error path was moved after
reset_control_assert() on its own label (out_free_netdev) to free
netdev in case reset_control_deassert() fails.

Fixes: 0d13a1a464a0 ("ravb: Add reset support")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- documented the addition of out_free_netdev goto label
- collected Rb tags

Changes since [1]:
- added goto label for free_netdev()

[1] https://lore.kernel.org/all/20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c70cff80cc99..50c4c79be035 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2645,7 +2645,10 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 
-	reset_control_deassert(rstc);
+	error = reset_control_deassert(rstc);
+	if (error)
+		goto out_free_netdev;
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -2872,11 +2875,11 @@ static int ravb_probe(struct platform_device *pdev)
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
-	free_netdev(ndev);
-
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(rstc);
+out_free_netdev:
+	free_netdev(ndev);
 	return error;
 }
 
-- 
2.39.2


