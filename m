Return-Path: <netdev+bounces-132439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F923991BF7
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1284AB21C19
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567BB16FF4E;
	Sun,  6 Oct 2024 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeMSWoKA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEED16EB55;
	Sun,  6 Oct 2024 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180387; cv=none; b=mV3r9aPnOj/gLFctHbUZGoiSH7x84y1lrdRs55vqYqDjjffmyRYBZ47T2tnFWqH7cVW95nTP775eL0Ihd6w5nlKIX/aOBSqYMkAQ5Gd2DqBiFJAk+rfsGvMPIkbvLcPiVYP0VLa3bW3toz3bsgInJVr5+DkqRF6VcAyB2oDD5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180387; c=relaxed/simple;
	bh=kk6BZgx6e1aK6qkYUJ4gDXK7X1PwsJgqDQzdqq529+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y504p7fXHkX39ypTZozoejBnYucA3AlBg2NO1vv+CKcfrTpfQr2rOKf1FsVCLmgQmIIvvkUlugYXI54OI/6yh5KwHx6s3e62zQ3k/sPX0YPJIwt7DcYNsaBxiM5iqQt9AN3zTvwYqHYjGL+Eo12LgdegI7q8Vj5bwork2dQ9/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeMSWoKA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71dae4fc4c9so2786756b3a.0;
        Sat, 05 Oct 2024 19:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180385; x=1728785185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTdchS1usQhL1WtM0gjI76UYTIDbC6vW1SK3n+i286A=;
        b=eeMSWoKAGOoBC3jQRaYumgz7A3vrpLnhNEZBK0fyps02iiLdZX/d7TEVTxPJkR2sTy
         ZUxhEeDn7tZRmJUibM11EcrlvBXdionSaggIHt94Yw4YgY6Yp2IgFXeTWgsAQU3WBYWC
         zLBgjS2sIWL9a0MiEP3y5WgLvUSoYDVdnSB7uzbTwu/ZRpJlpijlLr7h4GMgTQLICDOv
         QWSVu+CPqdPxMWQWp6dPngBAj4ffb9fOfhJ/jEyOc8tuNbS0oT83GIVfrC97tfckttgY
         kIy/dGty8690KSe6g+WUezpK98SEPCkvWNlTunrEFAZ2JCu7IfpBeaCylvvfxqoMinF+
         L6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180385; x=1728785185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTdchS1usQhL1WtM0gjI76UYTIDbC6vW1SK3n+i286A=;
        b=Exyr9mYOsbyVA5TgIQMQzxwVSPJ1g6tyJY235tnT98/G5fGhGa8VHk2/Sj5TCBdmvN
         boKVp57ZAifgCTaGsIT72LF4hH4MwzaQ3cqZAYpjR+z7XILRo88gf83bl2ZwYXUc7xpY
         k6RkLE1K1JcH3QOo9BkT9XDGzYU7I5on3Bd5nAJ045b7Rtb7T6wYk8cIpKb++Fl4rvue
         OGbiizGIRcVToclsi7h3HICdwHRfJQZa3JR1zhWUy6nLqXqF9NkaU9p9e8edNhF9Remu
         eheqt4xMMCjjrTU9plRBnwG8NaZv4mcC71Ily0pC4gbBw0jb+pW9BOkq7OdfFaaUZP9A
         3zQA==
X-Forwarded-Encrypted: i=1; AJvYcCWg8FdBlQ3PxzMWJblj9/0znRWIFlcD3J8CprxXgcSaEyElyEJIKutWIGDUtX83IRaMopBz66VEpjOYAeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz01ZEBngCZB4ZBWIiuCbo+ZJB33jPz8ex7d7xuG9ZrdxoFyLZ
	iTSgFbGlzMVequaLy3lEPJFTnmmP6Cpxxbt2dPu2JnEZ+lADiml/LcFeVg==
X-Google-Smtp-Source: AGHT+IFRSmQuNLULqemyX/VjdJxRBlrXBvNhk6NrJRfE9EtZblC3F8zawLFXDaHGcoqX+7Oy189esg==
X-Received: by 2002:a05:6a20:438c:b0:1d2:e78a:36a2 with SMTP id adf61e73a8af0-1d6dfa24b28mr10615218637.8.1728180385121;
        Sat, 05 Oct 2024 19:06:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683153asm2034212a12.50.2024.10.05.19.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:06:24 -0700 (PDT)
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
Subject: [PATCHv4 net-next 4/8] net: ibm: emac: use devm_platform_ioremap_resource
Date: Sat,  5 Oct 2024 19:06:12 -0700
Message-ID: <20241006020616.951543-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006020616.951543-1-rosenp@gmail.com>
References: <20241006020616.951543-1-rosenp@gmail.com>
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


