Return-Path: <netdev+bounces-132441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCCB991BFB
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFE81F220C9
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031891714D9;
	Sun,  6 Oct 2024 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9lf8mV8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C817084F;
	Sun,  6 Oct 2024 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180388; cv=none; b=GF39HaShOreIKHoddx390GPTLMG2F5vMwM0zz46wsmDZmJFjemOoShlQmstko0w+naEnZnvB3ql69Gn0JqM3xbV6JlyYoO/P4JaM1KenVio3vP3GT2+kfFPduIMe0VQUlxioW9PTpiALuZNxyyaDp5371Zea05GiH4L77zOQuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180388; c=relaxed/simple;
	bh=k+hWWt4RJCuaq34feyjRdwmdzmEmgz88H7zHH0eqdeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXHTHmqaC8MBLu0B7ZBg5OnOpykUWy4UOk4Pas8URZCBHQvK47OP1R8DFEnwxnlGKNVHNtL6QGbt7GRr5wgZJQq2Cch7Ix/Dk9TTRBeUAcaviN1N1rOkz67eprd2YkjmEDUzQxm7MdEDqaZ8T7maV3tCdrPVoEu4TUrI9QKeniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9lf8mV8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e9ff6fb4c6so801445a12.3;
        Sat, 05 Oct 2024 19:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180387; x=1728785187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFaFgc9POesph+LsrZhmZjoY7P5q5F3QfbVs+MT0fXs=;
        b=k9lf8mV8IhKcVNWjNSddVQcVN2k4HBaQMvddtNxVDomKrljmyHgNr5E/Mx1O0sszMw
         Gjn2h7xLaAujURzUtJfi4SVidSRQzBQUm4nEugD/fiqJISOr4qtBHGqPKS1xgVpxqZef
         d/NwDJZpA2+1Vr7KafvFdSZtDrlJeSOHkSOUAHI1Xv4QwiqQ3xIlK4QJlgN/P/gsO8r0
         CP0MQQviq82wFj9oL1ANKWc3eXyqm+xG46bVqH1Y7961kOU3sUttpA4jDXVptyjfX5Mg
         NhR5OSLe2gGr5pTxMhl/soBmjebinkP5DprVdZeRi7qL7P+f6mtOunFNEX/jVyJQxe/k
         qf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180387; x=1728785187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFaFgc9POesph+LsrZhmZjoY7P5q5F3QfbVs+MT0fXs=;
        b=sNwVKMAx0omyBms7L5InbtziF1uZjZCwBD3+CJ4evni0m7EvMYRJsIP5v+1k5psfPv
         8gNxpfP4EOPJqgB3Ne+/JMiPLBdbwRjTWrVXa4UPjEjRYsNJwjSd7J/C7FtjHd2dx8gU
         2d/mzFwCciRd3nP25ng5D/yybg4oGRu8gRWnpDAh/rHkTBxOHZU6QMtxQCXU2xX7eYR2
         d6qvMB+fLWHBmnuyF3/rrOTubnYnVmsIvWjRD1nlzJahQOVA29O0mMIXt4u1JVVRq1Wu
         lPr5tyc6jtTRS5GLFhf1cbChQGzMfhzxL3OzSebGG86vGjtqPEjrwzzBex0kwUS/qUar
         LrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeZhtp8UhBGJ06CaF+q3CZiOqDWzXVI/s/plX0zZCWBa1X3VTh3LivO5RlZ5l5zB2UGEUHun6rrzirq/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGjzhv3cEqimne06WlL2k20vqXLVuehy4gjjYb4JXReuDBG8s
	1wT3iAd8DL9YR9N0AGiKs5lonlbNvfCU5D7FdEHNZVfhhbWrdCkvheWuBQ==
X-Google-Smtp-Source: AGHT+IGOoEIT3gp2HtncwWltZZZjI/OM2B8JpQhGwlSSc9+H351UPiooEk+zNDoRiYwzYgsV3wOdkA==
X-Received: by 2002:a05:6a20:c916:b0:1d2:ea38:39bc with SMTP id adf61e73a8af0-1d6dfa33d08mr12888642637.11.1728180386711;
        Sat, 05 Oct 2024 19:06:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683153asm2034212a12.50.2024.10.05.19.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:06:26 -0700 (PDT)
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
Subject: [PATCHv4 net-next 5/8] net: ibm: emac: use platform_get_irq
Date: Sat,  5 Oct 2024 19:06:13 -0700
Message-ID: <20241006020616.951543-6-rosenp@gmail.com>
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


