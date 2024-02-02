Return-Path: <netdev+bounces-68350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E479846AFA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6AB293E7D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476F612D2;
	Fri,  2 Feb 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LDAwv0yP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4805FDB9
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863322; cv=none; b=qXyS/YTmBSR1b4c8wO0Wh+Y2Qwmopt+Rabwc5iirHiRC4iWMuC4hvbuEcy1/NRVbvGFrd9lPXiWx6Na0f1LEjwmWED+MgRlJ3/CC0SqM9tMg75p4m6Fqf0pTfWdYEulo2Q8/Akws5ddaTdomK7Mv1iBPJOcxtnNzJMCrB2TKFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863322; c=relaxed/simple;
	bh=ONbLpDUQ0pxclPSJgUwLbET51iczHAS/yqhLYj7/j1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CYXQyxEByKQHzGV1YPdh6WNPFVjDYpv7fTOEHGxcO+FaJSWbvK81jzYRlwhVSbx4JYrsWGwibm5/FsFFP1eAYl7Dv66/uML4OiNRBkmxSIZ0+jaeZT2eDVt84S5m+kduTQUKw6aedc7LhSVUZQbhC1CmmQvg/KPYBqM6qwEF/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LDAwv0yP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a370e7e1e02so32289666b.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706863319; x=1707468119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI71IkOMT1SgNH06umqK9lD2YJ8x0EnJE4QH08tMLVg=;
        b=LDAwv0yPllK8bov9hAZ+TFwuH9APeDr0TnYLkT1pgRhcPQEilHS4KD3SgoVGNFQIsQ
         DkOmEe9ow8vi2+DH2v962Xock94UfXSypbDrM+QFdFUVC4QoIvr3dac698/wFmHifW10
         jFK6SkUw15NCDGkJ5c1pF9Cb/CAMadkMNajel5PP4lAKVUb+saMZZm/WDyZYnczJAXFG
         Q00vO2qbDWFsDby9A0TG5m+Xn4c3gER/1mGkIjJjpRFU/bZ54nzcfaZQoz+JAMP+RgN9
         kJCoVYh/qYcpDT9snQm0cDGFlDLvhFEUMOrYwBFdEuApTflz+bSUaUfiUzCC0EMfKP8z
         A6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863319; x=1707468119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YI71IkOMT1SgNH06umqK9lD2YJ8x0EnJE4QH08tMLVg=;
        b=wuarIDSH5yiMvq2gJCm753pfPchTgmbw9kDEvFh3PPlHcBYS0g1muHsnb6hEoJD4ir
         Ke6dKUIp7lTV7tALNAPHidJjePEEvofpZmI28uayIaelehXRkh4dGFZacVBnFg8FgcGZ
         m71Do4K22qkDVzSAYvpjCpj8udGV8SOhL/Rx2/sy6wZxqVb8S0HHMx+igpp4JjP2P1aM
         YSmM7II7+qnuUYn9WYXRPyKoiqRptR8NK3EoUJytvgcSvrhswNDl81bP1L85hnQfQWY9
         3Px1K9l3LVZXCwr+P3MCWdm8kclbV1mIKO+UhCOcsS6WRCFexHz9jC8SpcknZoXLQJ9t
         +Acg==
X-Gm-Message-State: AOJu0YyO1Pkd/YXnBxADXggTNqJ2dkXgg0i6/HrkEwrJKhpgLTeLGBlR
	KwL4uJtqVGMurCHOs2hg7vW3rGsjx/+ZVN9786z3S25DCNd76UuV6jmNqjxEu8c=
X-Google-Smtp-Source: AGHT+IGwAEtd98gv9Uj3CwlkaCRSQFY2aondW9bQppJ81yZfClAIps1aFV/4117XUjsxgw6V+YnbgQ==
X-Received: by 2002:a17:906:b803:b0:a31:8e54:14db with SMTP id dv3-20020a170906b80300b00a318e5414dbmr5796744ejb.55.1706863319184;
        Fri, 02 Feb 2024 00:41:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVycCJlmHxnoNErdRh/32hZodjiOrpxpOduG/5PQsHgwIF3io97/09VHxS0p38RtyN9ytVaKVPKLKhYWtB+BPmng5GPQoPG5I6GQcfbx1Y+rzz3MK1GqSN+LhmIjWmu4UbH1hjk5D5gjR/KlXHYcevuFzle8pgiTOaQMw0h5v6ICLIdZmRJl2HdQ7YGXMnGVWPWaPU3odIV4HY5t2GFJT5ezhCnpkw4STnO7C30QJOGz6EiJESR1e436seEfaOxe89+XI8CuJ+HErvhuZbg8R1qsa4Yzndc4PoW/243f3mcDCx8pCjkC3T6P8GarwvM75KzSEbvdgd4/64MtXfjmtZr3bSNDGw5IznO/q/YBm76LpTg8z3ddmwJtQEVKTtlRqzJt05EM/ASz0ZSvw==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id oz35-20020a1709077da300b00a361c1375absm631642ejc.133.2024.02.02.00.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:41:57 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v6 05/15] net: ravb: Use tabs instead of spaces
Date: Fri,  2 Feb 2024 10:41:26 +0200
Message-Id: <20240202084136.3426492-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use tabs instead of spaces in the ravb_set_rate_gbeth() function.
This aligns with the coding style requirements.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v6:
- re-arranged the tags as my b4 am/shazam placed the Rb tags
  before author's Sob tag

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7ced5db04f75..c05d4a2664eb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -96,13 +96,13 @@ static void ravb_set_rate_gbeth(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 
 	switch (priv->speed) {
-	case 10:                /* 10BASE */
+	case 10:		/* 10BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_10, GECMR);
 		break;
-	case 100:               /* 100BASE */
+	case 100:		/* 100BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_100, GECMR);
 		break;
-	case 1000:              /* 1000BASE */
+	case 1000:		/* 1000BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_1000, GECMR);
 		break;
 	}
-- 
2.39.2


