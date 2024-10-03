Return-Path: <netdev+bounces-131444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97798E845
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152712882E7
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A26F066;
	Thu,  3 Oct 2024 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPbafzKB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05784642D;
	Thu,  3 Oct 2024 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921507; cv=none; b=ANAhThUYqw4hV389IHn7e6BpFm1rEYy4Ld+tnQp2Ap4iezsCMkZHcKUSNg0/eIxDvLSUKXFtreUCFYnjOV+tv7HrBQDTnT21NYeZNP1cq3LkpcZaD2f047mm0AU314TCm/UPjWvXPW11LvFQ6uEZyGscZDkn0uqixnPgRasL7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921507; c=relaxed/simple;
	bh=k+hWWt4RJCuaq34feyjRdwmdzmEmgz88H7zHH0eqdeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rjw8EsFxeWBJceJP1FH3VinUVIrPXqXbY6hP71yG/tGTsuoPbxvay+iOENPfA3C+dcaAA29++kw74RZ4tAKSPIbERZ2gX/nb4ojHeZ0DT2bskTRnCcZMLc/fVSTeaNDqpzDNf3rVusF1wsTPxqz0pqLwoRXe4FaZC314DsTXrjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPbafzKB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7198de684a7so359591b3a.2;
        Wed, 02 Oct 2024 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921505; x=1728526305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFaFgc9POesph+LsrZhmZjoY7P5q5F3QfbVs+MT0fXs=;
        b=lPbafzKBde7Regcec+ImiHWqOmxNWDT+ouXlSUVAXZNiE0EhsOhwLHJyzvxkulEoAV
         VZ5T3x7+ABgNBP++h37MPG2g7gAy+anyqJ42ArXHPnZIVU7tPqQdmK+/550EeEn1KaqL
         Lqv9PJB9MrbxWmraa5OKdXTN+pNjkxw8m4b6M3+J7Pb5YW1Jwf5C0+wYSp9NJYYYqkZU
         8R6adiBlj4BCIHDAzmSlYyZ9R0i5TfEeQfVJf0GTksd6Rf1c2LsC+jEqkcWGe8q4Vloz
         7v/ZyMiZ2euyZYJrhCFzmZLJbjBVuO/m8aR2bJvI1ripuvJ5Q4a9raZ3hIW7Ybmg09Xs
         pQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921505; x=1728526305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFaFgc9POesph+LsrZhmZjoY7P5q5F3QfbVs+MT0fXs=;
        b=YBEOJO3tuGR8Gj7F9NMiaEMLTnBg8gSHQyuYdQ3xDm1y6szV/evQ2kUC/2xZ88aask
         jYImexCytvWFy4qz3u4ekl0MZNYVzXQO3jpjxKVifyAl0a3kcdSVNujUqoIQ54AlotPL
         v7DrCUnSg2rnWYRY4/O6GRE4wyvCiIKIq+z9xain/yEYP992YvLr0uu9lH+W+DhvjqEQ
         cXb1H2IKhZ8af4f1ah/Py+BZks3H81QKrGyUvgcvX1I97t5Je70ZyDVX6EQWqyiyxZ4S
         WK+XTIWBC+saO2/MVmrn8/svdpfcPKWW2tSbykP2ngurEGbZ6Q96Lu7meNUAOvm1kZCr
         0YMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKykzwIGF6rOWhitToAGp+HVIX7YjU60YozqBjyrzm2IO3cSgXFO9RyUM4vz3YYJiJEwlt1qE3+OH2INo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8SunHIpixJeGXpKdfNr4fzQzqhSMEeZIk76c9A5Fc68pHqkb
	VkxJlMnFPdu4chU7WaQxAGj8Hh4SgSHIzyjUhwPSxUl7g4Zu4INU9nn2q0Go
X-Google-Smtp-Source: AGHT+IEi9Y7oofKSN2Re6/SrOzCBFD+VdwLrNlj8NfxwpTyjT7dEYjEjSRUtHV59chclIR40oAnVhQ==
X-Received: by 2002:a05:6a00:2ea2:b0:717:87a1:786 with SMTP id d2e1a72fcca58-71dc5c64385mr7151009b3a.9.1727921505171;
        Wed, 02 Oct 2024 19:11:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:44 -0700 (PDT)
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
Subject: [PATCH net-next v3 05/17] net: ibm: emac: use platform_get_irq
Date: Wed,  2 Oct 2024 19:11:23 -0700
Message-ID: <20241003021135.1952928-6-rosenp@gmail.com>
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

No need for irq_of_parse_and_map since we have platform_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 205ba7aa02d4..a55e84eb1d4d 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3031,15 +3031,8 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
-	/* Get interrupts. EMAC irq is mandatory */
-	dev->emac_irq = irq_of_parse_and_map(np, 0);
-	if (!dev->emac_irq) {
-		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
-		err = -ENODEV;
-		goto err_gone;
-	}
-
 	/* Setup error IRQ handler */
+	dev->emac_irq = platform_get_irq(ofdev, 0);
 	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
 			       dev);
 	if (err) {
-- 
2.46.2


