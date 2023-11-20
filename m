Return-Path: <netdev+bounces-49119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA62D7F0E00
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758A2281E82
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4833FBE6;
	Mon, 20 Nov 2023 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kDjgvOws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A9510C3
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4084095722aso15794425e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469998; x=1701074798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnubXRxqwunb9d9wAijOwoMF4ml5sMiS99lc6deFk3g=;
        b=kDjgvOwsGrktkE6c+4SJ7VsHqDJ5DFCbTuJwiiMqs/PQWj6VgIf2NTgz1Ma+IsMVdo
         qkIqBM95A7M3eSW+/NB4dfMErnpCwuK5OU3/cEUIQQk4blNSArVLAFA/0fyu2ky1O5hh
         RTVgN+x0nthlUWB5nkH+eB5JDaGCVBeVgV5GebEH15NWuxywUfrTpkcplCf+X+mKWpvG
         s16cV5JgkUkrw3qO1nr5fMNRkg1ILPzRyPzxzLLnYUz5JgOwLCOpIZZKmhALcSUG2AmJ
         acJV7Y42jlCY8Om8VsxoTZmSr4zHkIduE9W/hqABNxUZOFU0sr3vHvv1n9gLx0tiYO04
         P8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469998; x=1701074798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnubXRxqwunb9d9wAijOwoMF4ml5sMiS99lc6deFk3g=;
        b=GLYM7+Zt99tXQyYz2cGopgtXNNhfNdFQqEAsHgns+Ha3ot85p1i8mHvKzwl5gz/1rL
         9rztn9S9Wjteb//PTaX2wZjcV8GWM/eAKRgQ1IkhzxuXCK8+qVWcTvbO38Fb0rYa21y5
         O36VDeuNMyCLza6bRhKJlgZS05a5B9PKu5/shYczZtdJZz2Mi6cewlbyDvYyod5GFvF7
         zM9i4Oc9dxQjkdrkmkFZi7H19hRsOO6yPfEeBqAzBwawDr/f+RitWDdDVpbSIEXeFHKD
         rytjFC2anjUrrAewisQnr5revQj6wriXBnKhRYA5JrLszd1D7DpP9c/XFCguXq1/vnP3
         tI+w==
X-Gm-Message-State: AOJu0YxbL2FmGXFNbFLvzMp5z28JU2ikACgBXBRN8MRKtCZuUBk64YXN
	9Rhu+you0tnpznYE8ZdZFKKEXA==
X-Google-Smtp-Source: AGHT+IEMct7WxOL7CEruxo5dhNLNWOxO//4tc7G+NL8rWLz5AtDQvNUkk8+27zWIFX2LTYBR/EnH+A==
X-Received: by 2002:a5d:64c6:0:b0:332:c527:66e8 with SMTP id f6-20020a5d64c6000000b00332c52766e8mr1784413wri.7.1700469998154;
        Mon, 20 Nov 2023 00:46:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	sergei.shtylyov@cogentembedded.com,
	mitsuhiro.kimura.kc@renesas.com,
	masaru.nagai.vx@renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 09/13] net: ravb: Make reset controller support mandatory
Date: Mon, 20 Nov 2023 10:46:02 +0200
Message-Id: <20231120084606.4083194-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On RZ/G3S SoC the reset controller is mandatory for the IP to work.
The device tree binding documentation for ravb driver specifies that the
resets are mandatory. Based on this make the resets mandatory also in
driver for all ravb devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ddd8cd2c0f89..8874c48604c0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2627,7 +2627,7 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
-- 
2.39.2


