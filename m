Return-Path: <netdev+bounces-131443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E961B98E843
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F681C210C4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE547F69;
	Thu,  3 Oct 2024 02:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8G9k7jW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918DC3AC2B;
	Thu,  3 Oct 2024 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921506; cv=none; b=rZ9xf0ulS5qqHyVHMvkiNwYzUvpStQNU9h0ItcjARqIrAIyTcJ4DjSeJVxl0RXigCiONxVGg0xaiHCVY2iUmN/CGFYuLPM02b5+RXv45MeF/OSA3Tyo+oLfDh/OmNkfjS4PdJ41hnbsEsMFUfbuxNi8xgUNC+VMSlbIuOFs8uSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921506; c=relaxed/simple;
	bh=kk6BZgx6e1aK6qkYUJ4gDXK7X1PwsJgqDQzdqq529+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBVFp+Nl+kAoSkMn8CQ2aZuTU8Cunh87wVJaLCEj2KVuEnwl9sRluFWmDtf0rotHHswFuXAm6NKyItw7YxyRxC/GHDXjLRm0GzxvaQtLWXCEEPWHQbViRzK1ijszUWr3/8lSIW9miuNUvNVyKBXBObEOc6CyZYzNw8MG5/vwHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8G9k7jW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71afb729f24so368203b3a.0;
        Wed, 02 Oct 2024 19:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921504; x=1728526304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTdchS1usQhL1WtM0gjI76UYTIDbC6vW1SK3n+i286A=;
        b=W8G9k7jWOI3Lh3PeBz39au0pnqEfAeIhflFGtq0ZqSKBJlt3Xkbg56zbs/tX1hxi8h
         dzwllFDy9W7GV07Aj0edfIHXBkn2hPeh+3dfWa9eJMDAsMHsaKBF+yPI7d9F3CBl008d
         3Pbitz1Ico/H5PaiznBOVb/vCtY+rhSScWj2a3FPHtPigKjZAMn6QwNWvD7rZcAA2rPQ
         BTo2anKpDNQ7uEu6aQIm+YBlWeNNMNEebAr5z46jcGG0NXKciPoaAdffhprTc8DmB8/8
         p5idSiCBHM97hsps1doK+4LfGzv1BK5bo5ADL2WK1c7qHGxfyXbCgHbT67ECGKHwZAou
         V8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921504; x=1728526304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTdchS1usQhL1WtM0gjI76UYTIDbC6vW1SK3n+i286A=;
        b=uBj0s2q6hvEbYg6atXiu9hudg9SScdqbl8Cu4fWmt1vZ4JFG07smmv33ExAcOl7FD4
         E9PL4jeuBDSYAE5de/kUrxE6oZA39aZjN9hIZ7Q5UogiXWBv5guJDq1ClTmr2is09ZxU
         Jph2yAqTeQAadw5DgD4CgUjBV39LgBu8VHkYVlk1t3+1m1M/3TrNPGHNCQjFHMIXKc33
         jIDcJ7xPowHpYwzh/o+52JPnBjHZ0yD/pUn5K1SmhUO1A/wNLXUsVri7oN2OpPAM3yMp
         Rrsa5SR8ABZmk5JPed0Ye1vPnXoRd8sf4wrPMEoXHa1H7P8IetcsN3mX4IuCGsfNSvlZ
         YVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWnrqqoKqN6jrBbfQp6SouUn300zCrQD/7yS7jbC0aZoquDH3gylWptt9Wu5rurTca0IsDJrSNgx/Vozg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTnMMvaDEwtZga34svUhQDX3c4RvIYHZl+/xunq1M11Z4apnV
	XybggQjWtqaTFswL0bF9wQiN7EK21WknLpEGw0Chh3678w0iGsg0UY9Bpard
X-Google-Smtp-Source: AGHT+IHkc8P2japkEIzULnRrVy/ChAtOuhgjVE/ESfuxDMJOhPOceWA8y1QAVVhqLI3oq0l6sVzpAw==
X-Received: by 2002:aa7:9edb:0:b0:718:d516:a02a with SMTP id d2e1a72fcca58-71dc5d5436cmr6121362b3a.19.1727921503657;
        Wed, 02 Oct 2024 19:11:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next v3 04/17] net: ibm: emac: use devm_platform_ioremap_resource
Date: Wed,  2 Oct 2024 19:11:22 -0700
Message-ID: <20241003021135.1952928-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
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
index 97ae0b7ccb0d..205ba7aa02d4 100644
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


