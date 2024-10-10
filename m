Return-Path: <netdev+bounces-134355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACBC998EA3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0E5285E29
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD01F1CEAD1;
	Thu, 10 Oct 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXGClQcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F511CB309;
	Thu, 10 Oct 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582273; cv=none; b=X2IANYVCgWXXahBptnj9Je6vUt44l1NfIW7Abqpm73bUy7VtWDybFebUmY07Z7nsSJE7Wsi+jA0h2uQlSjHaoHjL0QwDFtk4Pq6TxAcM24UdWTgPM4jO8XceUPSMtGYDAaYo3zBvErrZnvrDVbo6LTI4abzqpk2GSuqt4DCB6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582273; c=relaxed/simple;
	bh=NisjLQ6AG+ayXJO1Uc/n/ydfucUugy/6A8GMWeGKP0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTmgRHeHIUWWJ1IMVoeq2h2DYUDUJEb1CyDZAJmBNFcCDFbWavL56qGr1wdjMDeoGdw7eszpUAcnTEE4kvBwgtYN7Tqd/uAwEyKIx6fIH7qUNJvFd4uqtoej1RUqDJxR4AWuuKqiXeG4OvMT2un826Zhx6zk1AvZewuslEmsq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXGClQcV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c71603217so10394175ad.3;
        Thu, 10 Oct 2024 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582271; x=1729187071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eKq5WBmYRanNBUMYgcDZuAxZpmoeLTNGUJJx7uGfFQ=;
        b=EXGClQcVugWQqCajUWG35P2K8sxu9QMuYSbouZ1dgp0MWc8gK4fbzNZYapCEWXPnST
         ivswZmpac0GDhyuPb4b7FA7g+l1c9MIOBSqQbw7/wBfDr1P3BezCtbXMFreslFDv0SxN
         FrUjxTzOtOwdE5thWzPJIGyjwQOOGYweVTygAuWNyp4jZRHpgb0wxXpnvbqkakMV0SC9
         WEOIh4RrkCw4qzkFlzBcNKO00044t6y2g6x76ReEYl43LldzWs8Du7qNLB47gKcULafm
         Ck+aFso8R++Qtor2uInmElwOPLXWUpusQRI/WNBRlPUH10atvvAbp0qjODMTLYdYydkY
         r6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582271; x=1729187071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eKq5WBmYRanNBUMYgcDZuAxZpmoeLTNGUJJx7uGfFQ=;
        b=rwBR2gaj6p24tZ4Kw46m228f7UsWdWS5yULYAGoZs9IMKU8BypQ+7ooil7yImu90OM
         5qcm26Wx80gQrPTZ11XcZab05aiqYmmnAqllAHxztFV4SoDkmwLrcOoutEioB0aTUgyb
         RsD1UMAib/d1FFR0653XWx5XKWBDuv5SQO7yJA6WBhVKfJWbuJVZ+lp6r//7gUBOuwvh
         uPWCXJ1NNrYUF+lH+2eHrKGE2qI5FxWILyfBxixoNF7gCoZupzTrXn0rdL2tztultPVC
         HCMp7lzq09r9yuMUa6ySqZlcQxMwRuXnevhWtMJ5YQgWvWt1lVoKF4Elqz6GX4fK9G6r
         WNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1iUN/pRZTfDbLu0u7KOPD5Y4q6Nxp/Blgke5X7uCu2J+EbTKedDcVySSxviY2dWiSSEfIauPrb6OR61Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tRbOfgU7q2AlCk5MJ/F8tieYrPQNUfuDPPEhNPIEIo0ps1Rr
	wQm7QBxF7ZwYjhlDmPA/cHuu5baGYQwjWHRQ3FB1ZltKAC45TAnKPwa+8gWT
X-Google-Smtp-Source: AGHT+IENUzlYT8m3mkT0ObIFRL2AdiWZqp0/Dg3jBFtDxQMmPCeRAwNTvkKl05W961ZIGUPx1uk2cQ==
X-Received: by 2002:a17:903:41cc:b0:20b:449c:8978 with SMTP id d9443c01a7336-20c9d8c8d00mr4829805ad.31.1728582271359;
        Thu, 10 Oct 2024 10:44:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm11826495ad.126.2024.10.10.10.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:44:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 net-next 3/7] net: ibm: emac: use devm_platform_ioremap_resource
Date: Thu, 10 Oct 2024 10:44:20 -0700
Message-ID: <20241010174424.7310-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010174424.7310-1-rosenp@gmail.com>
References: <20241010174424.7310-1-rosenp@gmail.com>
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
2.46.2


