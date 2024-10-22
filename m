Return-Path: <netdev+bounces-137683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0781C9A94E7
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53125281ACD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101922010FA;
	Tue, 22 Oct 2024 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2JeGpSs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5113BAD5;
	Tue, 22 Oct 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556575; cv=none; b=f1MftT7Qt3EGsmGvH0nQw0VcGaMNb0e7LhEXijlwG18XjpVSPjLCVXAcwe5HAERaIP/oxcbFgYEQRhK1nsg+L4SlPhTVl6Nx6JpvPojNwO1pR1foXogf2VgPXJqN0HEqBV9YeE2IaPrGaEHExWcj+gdDIo/sJwR7eVkJcUWzluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556575; c=relaxed/simple;
	bh=bRJEmCY6y5URF2HzcYMggNfJbAYgHx9jPeoF9VvccGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOeGs5jKZBUJginrT1ZZc08n9aF25rYN+Tlz9v4YY8V7WtgpgDY+QqIeiI05OVOgQXTmoRJ+aEVnjAkl/TkxMQ67zyDb2ZS5ldtVGOM5oNga1LpJ+grx/dYjCcZSfAsjK3ne4y6WVdwWXbkioLejDEFMCGoS6Qd4eRLLxn8myQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2JeGpSs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e4fa3ea7cso3865143b3a.0;
        Mon, 21 Oct 2024 17:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729556574; x=1730161374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BljbYSB0xd4xASN/k+CEDImFtvVnFRPDAYQ2ETtbOU=;
        b=j2JeGpSssahC4qR94Cr1lI8UA0ne8c0DXnLldxQHn6oeeW0N3h8PrMVJvi6uPOAeex
         b61RmU/j5DuGyKuq6Ta0RF+xz0y+N0yobQkZNe1sMVhVcu9GS8Hdllz01YtIrzD0k6rA
         q6Nlt0VP+Dea8czT+0+2sr5nedVVC0xNof4vl6WCYEzC4MXXwq8YUWmokL7D0fvru60v
         P8m/P3qJfBcFRNWpajg1DfKofXtooreehhw6o9W7Nxv4gy7JXI7gSBBUasDLypTmPIK7
         wP+rRfYXhGVBcLQnynb38uJrKKf3gLD6UMCjJLto3p1SAkl358eQvgMwXwFWjMOwvfxc
         BbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729556574; x=1730161374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BljbYSB0xd4xASN/k+CEDImFtvVnFRPDAYQ2ETtbOU=;
        b=brNyWzLcV5msB4iRyaCBk0sjAr0LACqlkTqf5ZUohlh2jzw9vy4smI0Zl6IIFBVDEO
         KZEA6GCcbLw8X6mYFm+Ycpl3oIScZWVP6+bMsfRWsZEoSLhXZZ5l45bKSpwp3k/PxNtv
         KqpCCdAuZL6QHYubDu8H2o4eFeGAW5ofBvE48B2RitmKZ9lHhf2Ds1aLYkM9siApOE7L
         nsAteXg1Uli/2ww6GoD+CDBiNPfVnXXubSIAdW31xCfHX4r8xVFtHEsN+4PAtqPi7Pjn
         hju4Om+YxLfaZXqY61QTRIAzuDjzKRuND5HNOwOXSYGkdPlc/Z0VI6brG1tx47DmLjka
         8XPA==
X-Forwarded-Encrypted: i=1; AJvYcCXcvdJAD5uVj33uoQfXNg3cQgbwQE0h8jyomz0XdbOwKatPPZVfTfsxNlJykqSBbq/X0rTWvfS4r2N/SQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dnV+6dmENuT43PcyOXMi8Sgy97X29Kt28q62G8p0SeUCuluj
	barU2lxXdcUilY6TIQ2K9epqMdbyzDHV+gwzalFdv4fjaxmg1Ty8UPVf5hvz
X-Google-Smtp-Source: AGHT+IHs+DJm4ebsLhEHrCEq7VQ5+TOlGsc2hl0tpr6gA/ZvaRvoFE/AI543kSNY8CB2IulSOeiTyw==
X-Received: by 2002:a05:6a00:23d1:b0:710:9d5d:f532 with SMTP id d2e1a72fcca58-71ea32ea78bmr20615281b3a.19.1729556573504;
        Mon, 21 Oct 2024 17:22:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3515828b3a.46.2024.10.21.17.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:22:53 -0700 (PDT)
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
Subject: [PATCHv8 net-next 4/5] net: ibm: emac: use devm for mutex_init
Date: Mon, 21 Oct 2024 17:22:44 -0700
Message-ID: <20241022002245.843242-5-rosenp@gmail.com>
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

It seems since inception that mutex_destroy was never called for these
in _remove. Instead of handling this manually, just use devm for
simplicity.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 8c6f69f90af9..1f45f2a78829 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3021,8 +3021,14 @@ static int emac_probe(struct platform_device *ofdev)
 	SET_NETDEV_DEV(ndev, &ofdev->dev);
 
 	/* Initialize some embedded data structures */
-	mutex_init(&dev->mdio_lock);
-	mutex_init(&dev->link_lock);
+	err = devm_mutex_init(&ofdev->dev, &dev->mdio_lock);
+	if (err)
+		goto err_gone;
+
+	err = devm_mutex_init(&ofdev->dev, &dev->link_lock);
+	if (err)
+		goto err_gone;
+
 	spin_lock_init(&dev->lock);
 	INIT_WORK(&dev->reset_work, emac_reset_work);
 
-- 
2.47.0


