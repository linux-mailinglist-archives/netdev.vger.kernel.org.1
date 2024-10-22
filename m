Return-Path: <netdev+bounces-137682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B7D9A94E5
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B6A1C22017
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88313C661;
	Tue, 22 Oct 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baGWC8ef"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575413957B;
	Tue, 22 Oct 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556574; cv=none; b=lU5ZwaUR6a4/LshmThCGnKuNNJJ4E6Fj36+SaWTAr/dnU2WbUESzsIar1syJyt04sfOC5+QEa9IVvrTS46vjkj8QtDFGrJlWaGTa1qs0gLdIQk3jodCNOI+9XjfFa6b1/W6mOLaU13pAsn7XEd8HNOoGYHxtEA4i681hh5Zd6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556574; c=relaxed/simple;
	bh=QPD+w9WV8cDvz3ihvrGAzBAHZlCrhDAeouYa3KaoNWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERgB8aLkkRVM069gsxLehaGumm19q2UrfHVqv5DwOb4OdmXm3kZUaXSsBn0/H8AAK9YbbfVcHjG29pxNvqrwWDdDVVQevOhZ+FzBKCE9fE1ehBcvlAh6V+PJbQjzX5WKPvkLUAptxhLcg379+uQfC/jsO1Pk8+WT6gD93+272kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baGWC8ef; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so4155071b3a.1;
        Mon, 21 Oct 2024 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729556572; x=1730161372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4BxEn7ENonrVt9RzcXJADLmBbb8Hf8lMTRGUW7oIGA=;
        b=baGWC8ef06j99GXBEYP8Z3a9FaiuJwUHDRK3TBoa0onIr/6b7KdCSdxDOuwdeaJ3K2
         9vIwKboa09eonoLbjhL9KE+RhtKtduPKRhqbuyHEfQpvvJhj9Ck+g3AMrwfqQ+df/2lv
         6CvlYPxO7R4gzLLOoJ6Axf7SyxBg4nm6u4zL26iCKKv6wpnNZdveBgjdH6szjxli9hfl
         RjYRvgmCb5qJzeH1uel/vq2PdBU5qjGB1EO+5K1solYAnI71d2XmNqdhqMNZmTtGr4U5
         s+3JtsWrJdHYTkai3Wx4razgaJw7BVQfmYIrwGFtKT9NgCh6fX3k8nTnA4yEXiVfJnXN
         HW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729556572; x=1730161372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4BxEn7ENonrVt9RzcXJADLmBbb8Hf8lMTRGUW7oIGA=;
        b=KWiN6g2rOroNBnUNUK54HjGd6ePFJokoJxdc5F1cLWXsIakhExhCpNULvIc8jQgyEA
         BH5fbTDJ4CwWgznmluc9iRzADcLKwtGKTTiUUmt5PRVaBKfsGkUhljzyn34383N2bp0n
         xSWqzrjiNNszA0/G6L0q7BFTB1CoUYnct2osaPbW1i1Wvr/gdsbItU7cINEnT75BPqlU
         lLkRtn8WJyDRtkoRjLKVGDbz7fwNIqsnlA/xNtVXQ59/M8uBW50Nz3SBsZd/JVGPAtF1
         SGK3tRNZfhzwkxNrhH4qgrIlfyqq42+ZwEi58EgD41pFQi2XlQRFpfH41+MLMFiWK8eI
         fZsA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+PjGU0mBgz8jynKxML/hMfH2lZdOpDuuEn8px+oF7Cgdy60HR2FOISZh2w1NTKzZR1IlEL4mQkCcV6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMB4ny2c8I98fRO6wQlCec+eAiwPKstLRHZcWV8QLZ5oZ7N3n
	W2/u89fL67VUIbWqwjHFC/eZLJp7JPxKQoCpxozcwzQnLyCXNXvYLn1jQFNf
X-Google-Smtp-Source: AGHT+IEEq6VHhuFOOj+3kOkYnzChSHGo6QHHpoH1KdksXKoPcvgbjcNyI2KLaah20PW00dbEGPmGPw==
X-Received: by 2002:a05:6a00:270f:b0:71e:591d:cb4c with SMTP id d2e1a72fcca58-71edc132de9mr1966789b3a.1.1729556572232;
        Mon, 21 Oct 2024 17:22:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3515828b3a.46.2024.10.21.17.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:22:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv8 net-next 3/5] net: ibm: emac: use platform_get_irq
Date: Mon, 21 Oct 2024 17:22:43 -0700
Message-ID: <20241022002245.843242-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022002245.843242-1-rosenp@gmail.com>
References: <20241022002245.843242-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need for irq_of_parse_and_map since we have platform_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index f387c4635cc6..8c6f69f90af9 100644
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
2.47.0


