Return-Path: <netdev+bounces-126251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17D9703AF
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D201C20C50
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4946916C6AE;
	Sat,  7 Sep 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5EEl/td"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD716C42C;
	Sat,  7 Sep 2024 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734747; cv=none; b=LEAkk1b9v58ZunEz3tJ+m76q/OAJkeZwKLsuj7l+el+sDpedK9kvvQjX1VugCW7l5hFRNYqTtN3azzWoslRHfiBRah7nbzNmrMBQW7nzmJu3B/q22CftDsO5VzrF3YB3dasn4a4YEQv65EdQJrtNtJ6PItzlAMhZQfubCJeWFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734747; c=relaxed/simple;
	bh=seVo0Np6PR2inDQXcsvU1y5xTI/3EY+wHEJHZp2a9Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkTnKBWuDv4sF9HkttoZW+XVS7ObrKCJcZsahsShMkvkWB01EDuTgEihnLXITeQFV5oH7fzt8dpC7s03UuGgqckSDYWANcLdr7eZ7k7Sz8Sb8PP6zxK3VlmX0E/+WDNlPV/r1CuYjrOh7GL8Gn61GY5ayhNdPl30nZZnBDiso3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5EEl/td; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-277e6002b7dso1729459fac.1;
        Sat, 07 Sep 2024 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734744; x=1726339544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zDDUM5VV2uKFLT97hFDCWEzUxnP/qoxBNZ9RXNTYNU=;
        b=b5EEl/tdHbKbR+7nO+0t5iB89ocSZEqyYJMy4iaF8mFNYBNtEHUxWCr0flxmP0Z7qJ
         FfiYfl+gDrxytC0LgfCPbarqtYsY1GquWe/sHYQa2yDNT9uetCnM0E57ZwX73hAaZXB6
         REYz4OsmapGWoCmgc4mpnYbtuKVKv4XKR0hTjE/m3tc1r5VE4Dy2TXydcN4bFL57hl9Z
         SjxiYaG3u/QAuVYBNF50xXmpcTEcaKM+RUAac9rsXTqWlUAcK719aq702ijPZ15G7jmM
         3qxEWHgilWfdkAjwgPOaQ1lAuqP8LjuNqp0rJhlcqbOgeo7vcr4G1+/0PKfp6w6s5tIx
         fcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734744; x=1726339544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zDDUM5VV2uKFLT97hFDCWEzUxnP/qoxBNZ9RXNTYNU=;
        b=VLaIFbC7DHHJV6+fTnnofxJ2FqK/A/0LeQY/zvmELi58pi32cR33rSyzh5WqLhKO79
         GX2eQYQ9mA7g8DYaQJxImwR+rnNtQvrHPk2ky0XeZVhMbTb8A2mTdYd6/WpAvG4+Cs7B
         89r5B0dN7YP4Fs66KBmmYDY0EQXl4jOCppHFdT+ehaPqj7tkwHxHNposHvlIdU/dKruA
         hlkasEKOPAszAzLN14bJRCG3uFzv3R+XXqIHCZ2goet0H5LocmLtMTTjeG+RdT05fJLP
         YKJ9QDgueScZPDo9ufJdQnJTtpgWjBBhXEWq0LfhvHvMxAoLZAZDDqX+G00yJCylRhHJ
         ffrg==
X-Forwarded-Encrypted: i=1; AJvYcCXn49O8SLrIx87Gj7VfRGrcIsjaicPVUunwekHk2bkVwCymfv8+pN2HUPCVY3DVSLerBz2mbvprDAsqgi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Ftgn0ooyZJG6SjxtM5m2TuxvydFAZ3vTBHLC9EZneWvNdRKM
	jlM++7XBZxCglzvo6bh1XF5ZDISXqkmoiKDdnXcuN/3ho0s8whMAshdBbYmJ
X-Google-Smtp-Source: AGHT+IGPPDnc4uAZfONvRq4qAWlN7JqbQTOv39Xx0gKwja5dHtnTqK9lCq6yEYwDAfxKpoiozUZrXw==
X-Received: by 2002:a05:6870:a550:b0:261:20f:c297 with SMTP id 586e51a60fabf-27b82e07550mr7244260fac.11.1725734744439;
        Sat, 07 Sep 2024 11:45:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab18bfsm1111239a12.88.2024.09.07.11.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:45:44 -0700 (PDT)
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
Subject: [PATCHv4 net-next 8/8] net: ibm: emac: get rid of wol_irq
Date: Sat,  7 Sep 2024 11:45:28 -0700
Message-ID: <20240907184528.8399-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907184528.8399-1-rosenp@gmail.com>
References: <20240907184528.8399-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is completely unused.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 57831583ebde..a82abf263226 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3029,9 +3029,8 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
-	/* Get interrupts. EMAC irq is mandatory, WOL irq is optional */
+	/* Get interrupts. EMAC irq is mandatory */
 	dev->emac_irq = irq_of_parse_and_map(np, 0);
-	dev->wol_irq = irq_of_parse_and_map(np, 1);
 	if (!dev->emac_irq) {
 		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
 		err = -ENODEV;
@@ -3055,13 +3054,13 @@ static int emac_probe(struct platform_device *ofdev)
 	if (!dev->emacp) {
 		dev_err(&ofdev->dev, "can't map device registers");
 		err = -ENOMEM;
-		goto err_irq_unmap;
+		goto err_gone;
 	}
 
 	/* Wait for dependent devices */
 	err = emac_wait_deps(dev);
 	if (err)
-		goto err_irq_unmap;
+		goto err_gone;
 	dev->mal = platform_get_drvdata(dev->mal_dev);
 	if (dev->mdio_dev != NULL)
 		dev->mdio_instance = platform_get_drvdata(dev->mdio_dev);
@@ -3189,9 +3188,6 @@ static int emac_probe(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
  err_rel_deps:
 	emac_put_deps(dev);
- err_irq_unmap:
-	if (dev->wol_irq)
-		irq_dispose_mapping(dev->wol_irq);
  err_gone:
 	if (blist)
 		*blist = NULL;
@@ -3218,9 +3214,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	mal_unregister_commac(dev->mal, &dev->commac);
 	emac_put_deps(dev);
-
-	if (dev->wol_irq)
-		irq_dispose_mapping(dev->wol_irq);
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


