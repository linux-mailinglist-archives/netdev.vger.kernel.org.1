Return-Path: <netdev+bounces-134687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F5399AD2F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF818B2272B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8F1E1310;
	Fri, 11 Oct 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZQXroWg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D821D173F;
	Fri, 11 Oct 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676593; cv=none; b=C8CBKqVmylaoEMeLz7Ho1uKbHu5ITEC5E8ZyBYqMiYLlnBcJCH2A7eGqS3yJWmmpFwve2dpcc6cflh4abSUaCln3t88cfOXmVLiXvh3gQPqI/wYPfNf5otxRurOY+2YwflcL094AgBDt/lonei4gKtyp4pSjgPmGm3fHmMC4ZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676593; c=relaxed/simple;
	bh=tniUXV6qEoLdBOPzJKqDpO8qKcTzjxc7U/9coruMqC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViVOgD8yRYqujZxzdTdGufB36bdFwD5BXmlpsekHAEA78ly92xt2rzP7uKJ6bJ88a9UxD37dzYPd657Qm5DHjhQeUf0/44KwF1bk03O2j3dGwlPGkVs0t91vk2NKSb1zRcneZbqKvUrsvZg/vYa4Qf/vpKg5e59fm2KKuYpsucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZQXroWg; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b98d8a7eso2612345ab.3;
        Fri, 11 Oct 2024 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676589; x=1729281389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6ITQx9ZkcEUR17rYZmaK0CYrDABtxSCN0Y/5i0Ckw4=;
        b=lZQXroWgH+a3dGfXjwlmT2FQDPFuax7o7canxb/R+m6/zXo7ufR+0mlltJtNmiGTZq
         oNeSwRxDchOD8CbcYDWxaU7CCtcQwaFaL1cBy3qBNe1MY+uiZh4qBrub09JgdxthxYWB
         gZrKmusPmA7+bjU9XRaQinhXetNa+l38Ocp1wj19hqKJNRNzpraiHQ48PNwrSwVPuFyZ
         twOiRaTZoITebZsmxJtMwzK6d/O1MUbTqvooRarXLtgA8o52LenPpr6F+tj8pIF4N5Qf
         rKkBH3a1XxN1DpK+aiy6r2bk8iNutY06sZYamzhREDGaFUWY/xhcBXxus2Vu4jUmyQsd
         A6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676589; x=1729281389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6ITQx9ZkcEUR17rYZmaK0CYrDABtxSCN0Y/5i0Ckw4=;
        b=YVKq+WO+/zNfXVFNAtp0nXoO4eD2PD82Ghj2+rAyBQ46da1jReY5Z7IprMAHdSQP81
         QzTQq81J+O6i8vWWMxfXOxi+uPpsPWMvLXipV929xwLH86Zax2rI9JNyU55A7UdisoGC
         Q/sI9LpUe7dnVvqni/KjFv3zmfalOe2zmmr6xI/6Nlp/WZ0/PDO6dWefVEW9W6HrDt2N
         soZFoPf11BRmDp2iHAtDs+bHOCavlUeeQxKJkcRkVKNT0+db86/wccXg+QUMHwXV5Hi4
         tijzqzb2/QZwVoZTYu0ePHBEvZ5w6NlwqgB2NLVMufTWBTVCjZP366UTtnqKU45KDq7G
         +M8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZx63tnqmtJoFfF4VGdZt92fyJ07tDQFPmxE2EplyIwVMx2wOwRSu2xLqfFWNQMCjV/fO/94RGWKn4+Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWaFuTXItsj+M1xiXkjovt7VDdqqurv3WuIiPVzTDiKWrwpHjH
	9IrONZLkYri+82uZoHSrIOhe3eOEojSkk7tDmfNx/wr18ukrrHLZ8OlW+2As
X-Google-Smtp-Source: AGHT+IGl1pZNNeKiwLw346Fxdrc4k+rkfoaNFBOUuY8one0D3Kdj1x9y8bj92ky2QyaC71I2ueDlqw==
X-Received: by 2002:a92:c544:0:b0:3a3:6b20:5e33 with SMTP id e9e14a558f8ab-3a3b5f70cd7mr45678225ab.12.1728676589466;
        Fri, 11 Oct 2024 12:56:29 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44907ea9sm2846025a12.40.2024.10.11.12.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:56:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv6 net-next 3/7] net: ibm: emac: use devm_platform_ioremap_resource
Date: Fri, 11 Oct 2024 12:56:18 -0700
Message-ID: <20241011195622.6349-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011195622.6349-1-rosenp@gmail.com>
References: <20241011195622.6349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to have a struct resource. Gets rid of the TODO.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 644abd37cfb4..438b08e8e956 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3050,12 +3050,10 @@ static int emac_probe(struct platform_device *ofdev)
 
 	ndev->irq = dev->emac_irq;
 
-	/* Map EMAC regs */
-	// TODO : platform_get_resource() and devm_ioremap_resource()
-	dev->emacp = devm_of_iomap(&ofdev->dev, np, 0, NULL);
-	if (!dev->emacp) {
+	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->emacp)) {
 		dev_err(&ofdev->dev, "can't map device registers");
-		err = -ENOMEM;
+		err = PTR_ERR(dev->emacp);
 		goto err_gone;
 	}
 
-- 
2.47.0


