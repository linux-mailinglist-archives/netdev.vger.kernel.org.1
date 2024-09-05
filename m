Return-Path: <netdev+bounces-125679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E033296E3C7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5BE287A45
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E911A08A3;
	Thu,  5 Sep 2024 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaGY+s7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FECB19EEA0;
	Thu,  5 Sep 2024 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567313; cv=none; b=T2Igsuquj5dDlaBlBbKC/4ljhsrrZkSokWAiL8Wb36U9q7eVjIznJ0uAbz/eJT+Y3HIKpYjNl6NqB34Zwrsmod1T2YBVrdW0c0RjRGU2xo2NVMcrlHXBpbclfhrz5euVAuEDEC0Yq5uUvR3h1CRPceILVSQasceXc6KJrHUpKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567313; c=relaxed/simple;
	bh=aZNu7iiv/TYq0BlMH229d2ccbsF2mWev0TPm5aNKaTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdY5oc72sSq8FasQLArhkSjFormrus4qYF6nhcsQzrBid8n4eTieeSVM3IWi8V6IduOxYBcbTpe1kt4UVt13hH9hJwcBzuvqLpddInZFUbcyPOqC7ungmAf/GQGX95ll8QsNNXNkN8Wxfq5lUBhPagz9Y6Vg3aL5tqkZK7oHcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaGY+s7r; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7184a7c8a45so332468b3a.0;
        Thu, 05 Sep 2024 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567311; x=1726172111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltddfl1/seB86FuPt28B0OUAnAVJMcJpdwKzmOTOXTQ=;
        b=kaGY+s7rG/O/TXHV8m2TJcUhnyWAY0spaiS8bfQHM6IwjruWAi/uIt42tTqhopB5tz
         i/CJsvSKuTmrrctnpVGwcCYc3eU882vTkP5FH9HqK6Vm+nHubyPxKHgG8d/UqkyFRJra
         p1HYJmSmUvKjMnp3+A2E5FxqSJDuPFSs+/ZPPjPCZt1eu1ALHV0aFdT25b1dTZGKDpie
         q6CIgX2CAVXNnEDn5rN4iRLqbkKA1Y1UXRno165dT+XXMumX4yz9zELEnGiA5bop/77F
         LZDL9URogoO2JDXGtMz5D3RpBf+hBaRyln/Esw55jMMkeUUz4fgG7zo0zB6+QD4jpU/P
         H33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567311; x=1726172111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltddfl1/seB86FuPt28B0OUAnAVJMcJpdwKzmOTOXTQ=;
        b=MZ0md2lbjrcUk4a42PufnFkJ9VzKIj0Qg2svZhfqW+EDzpfNgZXGu7LfMdt48vhOmQ
         VlPaif7G0ONO/JRIZ/Vfy9Ebhs6TU7r+QFlZUjSuGXAeZjVGlAnxaLjXj4erc8WrS3OI
         WMgSJpIuG+ggN5pJWmej5AotF4ZXSAI9LwySb70qvZf2JK2yX4nTS6f+LSpxR0qk8hkw
         f1d0TEeN5fUTjLgsVQ/oHbv28YV286wAG/+kdlNoRlP3eBj0DCNH9e53wOAj1R235GIa
         Xqcgk51tPuczCnHfZibdJR2WzFshCcyiR19Jtx9mAj9KighsLG4lTtEaHmp9AIN9UXlT
         az2A==
X-Forwarded-Encrypted: i=1; AJvYcCWwHI85gg84Sz1V9r/6jUbRB9gfH+bi8a6gIXHfJ1RKy2qVEk63iDJtrWca215MkSlUsZUMkLMOZ/PG2Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqT5Nk0xyRWAsvJj7ipr9Hhpd7ovbHckNYIT1mrrorb9/SL7CO
	F+UWH/tiFzjPetLrHFVXYw7Cr7ifMgyZNb/H1IdlmzB2gLFMpFeoijgGy8WB
X-Google-Smtp-Source: AGHT+IH0C4sli2G1PL868GMVrz77JpWGqk/BE8epqMhKDlbcJ0taLYECCqwVUJl1Pc1pbbclILvxnQ==
X-Received: by 2002:a05:6300:41:b0:1c6:ed3e:3e24 with SMTP id adf61e73a8af0-1cf1d0ee292mr137715637.19.1725567311464;
        Thu, 05 Sep 2024 13:15:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv3 net-next 1/9] net: ibm: emac: use devm for alloc_etherdev
Date: Thu,  5 Sep 2024 13:14:58 -0700
Message-ID: <20240905201506.12679-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905201506.12679-1-rosenp@gmail.com>
References: <20240905201506.12679-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows to simplify the code slightly. This is safe to do as free_netdev
gets called last.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index a19d098f2e2b..348702f462bd 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3053,7 +3053,7 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Allocate our net_device structure */
 	err = -ENOMEM;
-	ndev = alloc_etherdev(sizeof(struct emac_instance));
+	ndev = devm_alloc_etherdev(&ofdev->dev, sizeof(struct emac_instance));
 	if (!ndev)
 		goto err_gone;
 
@@ -3072,7 +3072,7 @@ static int emac_probe(struct platform_device *ofdev)
 	/* Init various config data based on device-tree */
 	err = emac_init_config(dev);
 	if (err)
-		goto err_free;
+		goto err_gone;
 
 	/* Get interrupts. EMAC irq is mandatory, WOL irq is optional */
 	dev->emac_irq = irq_of_parse_and_map(np, 0);
@@ -3080,7 +3080,7 @@ static int emac_probe(struct platform_device *ofdev)
 	if (!dev->emac_irq) {
 		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
 		err = -ENODEV;
-		goto err_free;
+		goto err_gone;
 	}
 	ndev->irq = dev->emac_irq;
 
@@ -3239,8 +3239,6 @@ static int emac_probe(struct platform_device *ofdev)
 		irq_dispose_mapping(dev->wol_irq);
 	if (dev->emac_irq)
 		irq_dispose_mapping(dev->emac_irq);
- err_free:
-	free_netdev(ndev);
  err_gone:
 	/* if we were on the bootlist, remove us as we won't show up and
 	 * wake up all waiters to notify them in case they were waiting
@@ -3289,7 +3287,6 @@ static void emac_remove(struct platform_device *ofdev)
 	if (dev->emac_irq)
 		irq_dispose_mapping(dev->emac_irq);
 
-	free_netdev(dev->ndev);
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


