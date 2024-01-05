Return-Path: <netdev+bounces-61791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8BC824FBC
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 09:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CECA1F239DC
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F8220DD0;
	Fri,  5 Jan 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OEBXK9LX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF522EFF
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso1619584a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 00:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704443055; x=1705047855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5wciRojDeq9cu3DUNng1ZDH9KltXB/o+T6WijHm3tQ=;
        b=OEBXK9LXXPkMC8AeSYQ/SnnEHJSJEBC4Rh6xZeoYIOf781rBppmx2Zlw/SVBSZiK/P
         BpfDutEz2tvJU+LaiOqOCb0ffw7BTfNiVgs6xpsWtdTgJS9FezBBxuQjXnGh96Q1SCeb
         yxCdOEtZq8rXT3TplgBPb2NN9pYt3dZL/VtHdgGk8wy75yF6IQy+BtyXAgiuMwEGflC7
         BH2kUABzKEhMkegREn6TroPc5G3TCFJ0G2IAOFyBWNhgqTMX0ckoB63yKIqyD1qEPCSB
         Ju6SWLzzXXbKeKvaCwmQbJn/sEEIinDHClM0k603+rO9DpWx2ssI/bVBcVXX01nBLQOJ
         emWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704443055; x=1705047855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5wciRojDeq9cu3DUNng1ZDH9KltXB/o+T6WijHm3tQ=;
        b=MTCcMMXBZG172C3qhg5dUj4SoEMo8KsbV9nL3DdLm4P3u82kfnY2dll6xOZjN3b6Ok
         LXXOhCVqjLjTkzifo72AD/lz6TMqxHDXtrnUIgm/NjiYagumGBBkmk3Bwgn+525OlC8F
         tx9fhJTE7H++rlMEi3AjING0EV6vuhvNqhkl3RjCIbwdgfIFKnJHi6eJg8xx7UzHih6O
         3vFWgoCQAkgMrVCaHpTCf/2KQZ9io1QXZ5yuSW3luRGQujZc4eNrTa6eWV1A/APFGrV/
         6Do26ehaOeEbU3QewF9XOJmpGR3bBsxJbx0uztL6pzmWtqzAXys9dIBzO8L2MzmcQayL
         8kCA==
X-Gm-Message-State: AOJu0YwfvlTMBqq+Qe37BggV4bL10DHs+Qa+zI/KLshLleXRyBLsZu41
	8Rc0EjYAijvAJdbOt6LG7R7278XXxQYgJA==
X-Google-Smtp-Source: AGHT+IEGbKvYxvuorV/dKUofp9/a9JDbVVxhxZyFu4N4OaE9q2nfPceDdwAMwNk7KsqDlI4AujoDVQ==
X-Received: by 2002:a17:907:76ac:b0:a28:b9b8:2f8c with SMTP id jw12-20020a17090776ac00b00a28b9b82f8cmr792621ejc.152.1704443055187;
        Fri, 05 Jan 2024 00:24:15 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709064b4f00b00a28e759a447sm596198ejv.213.2024.01.05.00.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:24:14 -0800 (PST)
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
	wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	geert+renesas@glider.be,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v3 03/19] net: ravb: Make reset controller support mandatory
Date: Fri,  5 Jan 2024 10:23:23 +0200
Message-Id: <20240105082339.1468817-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On the RZ/G3S SoC the reset controller is mandatory for the IP to work.
The device tree binding documentation for the ravb driver specifies that
the resets are mandatory. Based on this, make the resets mandatory also in
driver for all ravb devices.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1374dc11a7d1..ce053047a9f2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2645,7 +2645,7 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
-- 
2.39.2


