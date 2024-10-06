Return-Path: <netdev+bounces-132453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5EE991C16
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E941F20EF1
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA9176259;
	Sun,  6 Oct 2024 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RriHha+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D8175D54;
	Sun,  6 Oct 2024 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181740; cv=none; b=CEC4mYnbSvft7YtDBb3TEXQAsNRl3MWimVOqtEBzkJanzBWsbtKhBG8mGva9Mqcw7p2W6cx6DNVXr6oMVC9byyRe8atX+6NSnAeTqZohx7YProMyR9GCQUklbavv6tfLiUlAooKjrxaCaB3eTym/7Gw6sSWTCrxq4FTkpkTu6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181740; c=relaxed/simple;
	bh=ygxRrGdJ9KUgzvWWQQm+pKJqPtp9dK2gVLxXFBftRo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDcsNZjZCcecSbWg+pQjTaMsc4dzqYXzLvCinqGDaUiwWqkEIbMF2Ddmcna343NGUNz5YLYLADrPiW+DCq7qEO3tjeKG8USGvGK/65P9N9NTVbo8+BVblaPLOXFB8qRM4Tm7omOJRYFux7KnzWND/3MDSvjZrc0NjElvBE/w0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RriHha+2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so508044b3a.0;
        Sat, 05 Oct 2024 19:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181738; x=1728786538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0ntunKKFgauuU5ev2XToJi6VDmF8czZ8ZBzTnd02HI=;
        b=RriHha+2tGHow+cx00n+XzaU5lSXtKlD1MKkkaI3WqGo+1nFLgzfGh80C0Li0ii4PI
         tqdlaP7oO0tgAoLCN/4xY0JmhB+Bg5i2toG573HE6oR0qgfcg9PfHorb53QV+wT2f4U6
         jGxHmN6iAjoqkFKieYp87SixhBy09Qmv2b84EybrHS0qUL624808nfG3cL9QahDwslQ1
         tVhVI5QVoU6S6d8qP978vo0u2/YSLqHlxfpFnUoFWe9iOjs7iWJu9SVEjfgbynNWbvuQ
         Q1uW1/06OgC83pQwabMhdpzPbkMisJT/SIn5dLwO8LtXJ80bB+a1dUDxZRm7L1XFpKKS
         V0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181738; x=1728786538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0ntunKKFgauuU5ev2XToJi6VDmF8czZ8ZBzTnd02HI=;
        b=ctEqKmZGKneGlpdvK9bUfVnJG8hAcuVVEeiKZFWqiXYRNpEv7UFHy2qakKihfLQB2c
         5dMYBqCyfQgWII4xKohSckCJOqZhN8+NeP3R0yrp6gFP0SBOx6tszQKrB83y3jcwVtAi
         SAGUjnSK5abagrC90DH5uGJaza+D2RKCrtHNzLLL5uhPgRZ/Uyy2bZx9L5dH1zKqllwt
         k/LFo8hA/9EWF8MMRStyEezt6ArsEnnqAQLv+PTHe73nI5GJoKDNpXNJqbBL7vaBbJRS
         hUwa4BR5ICbVQfMcK2uYIUcQMTawUinz9ypNFXF9XtWlHcOCPbhhFAWgFszte64I/SNP
         lPPw==
X-Forwarded-Encrypted: i=1; AJvYcCU5z57Z64uz5qkXKpOm6XZTL4qxGI6YOhZtP14Bap4A9CnjWNtQNMHPrIfOjH7UZnycfYsVpe0My1MeeDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwtKIzZ+DTAHv9iRrHapRPQFrCZxH7IYhUl2VpWOh4Q5npqul
	7JupfGz3E3GYL2xhsRyB9EJm4TEtiHFHtWp18ds8puWPMWUov7sYTI0Rkw==
X-Google-Smtp-Source: AGHT+IE9cwf2izfUgWzpobqYIEp0MwTn3Yu77dl+wNb7QtWMaA3RJ1v4L4kxsywsND6QuOdPADOCdA==
X-Received: by 2002:aa7:8892:0:b0:717:8a98:8169 with SMTP id d2e1a72fcca58-71de22978d7mr9733070b3a.1.1728181738311;
        Sat, 05 Oct 2024 19:28:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:57 -0700 (PDT)
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
Subject: [PATCH net-next 08/14] net: ibm: emac: zmii: use devm for mutex_init
Date: Sat,  5 Oct 2024 19:28:38 -0700
Message-ID: <20241006022844.1041039-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that since inception, this driver never called mutex_destroy in
_remove. Use devm to handle this automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/zmii.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index c38eb6b3173e..b0c46dfe95b5 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -235,13 +235,17 @@ static int zmii_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
 	struct resource regs;
+	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
 			   GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-	mutex_init(&dev->lock);
+	err = devm_mutex_init(&ofdev->dev, &dev->lock);
+	if (err)
+		return err;
+
 	dev->ofdev = ofdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
-- 
2.46.2


