Return-Path: <netdev+bounces-111712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A89322F8
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A391F22EB3
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438AC196D98;
	Tue, 16 Jul 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtRAo/Ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A626FB8;
	Tue, 16 Jul 2024 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122736; cv=none; b=WvO9Nv/tSed0yCa5eZAFv5lJFIsQJmSioWqexqf7C4gMajyI5b43K9rm16aI2VuUFaoxnfXOUBUPShSE77ktSmPRj/DZwne75tagcod9zBg0eHlBxhiyTz5zNL5PEOY8LGcAFLcqKrHEau6Zttx9yi6TzG0IP0A7PTxahkvM4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122736; c=relaxed/simple;
	bh=sZCgZ1mlf1W+93s1WpaccP/syCAclEKy79wKbpowxxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Gu/2P0tFki9XCyKv3tWmhq+zD1BneJvjWM+37/tler3+xyZM8GvB5TyeGW0k1XbgP4SKxFjnpOXclKD7IKgQxE013KxsHhRTdCHuiKnBkqMj2CSzEfqGYXZLxxrCZmytX3IjMpxE5hN4diEWpC3mUX5ckyvuKyppK9MXc925s30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtRAo/Ci; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-426526d30aaso37107665e9.0;
        Tue, 16 Jul 2024 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721122733; x=1721727533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gO65E7lX5KVX6534BJkCtsb8cdN0RzRb3ZFTu0VXeK4=;
        b=FtRAo/CiTrNcXlIJvft+5NkPabCYoVR72CQotMjl/c37NvGnOWg33kGkGh20TONumj
         NaBQhEQkuqNGUjBIvY3ItRDQjOmm6i1mYUiT4jz43iwXIqONiDM9rL5MrFC2k6w1H6ID
         sdLl0CqgtKGz2hhz4nYFWffxGXgN4WPCXvj96wBjCIWiGylU1Z/77WHzR6IV1GEAHNlL
         lgc2nIfL2JNSa5DTZ2wMubXmlwjNAWwS7Oza4y7OB6v1nFN83Xyu4/MZwr7+UEjXqW0H
         dB+P/TCLMwXav/WeKVuQ5Za1HYjsGvOZ1Lz+F0gYommI/vYw2O6qEWAHO5Na7KhasHCE
         oobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721122733; x=1721727533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO65E7lX5KVX6534BJkCtsb8cdN0RzRb3ZFTu0VXeK4=;
        b=DQzCUME7yIdap88w6MaY0Y5VV23mNEPeCyWUyrXRFbVLOEGrpxRzmlV5NCa32JLdaw
         YwSmF0JQkqG50GRSbq0vbNell/aYAnQQZwv0vAoOQ7/vRMRJQYWfUcetA1qfcSNaqdok
         2+xAPuvU7iSk14yWb40scDIsq7ZmXZU5To8avlofLRjDzpugJity0hZ6C4u2q0qQlCJR
         guObFqSoKV31yWO1VEJ8klg/D/igQ+LX+uw0opnP3jp2521znZUwrkNqi/BMRa/QXP++
         yayT1+xJofB27QwfCgu199SwQ3exTZVO0R5XeF+HzgWMP8Ldz04qBcvDDhEyeyf6ejXJ
         Ovbw==
X-Forwarded-Encrypted: i=1; AJvYcCVGcDfZhNcIQGDSVzBru2oViYea9YVwhLXm6hQVXA5Nt+bKUF0+FXUqYDhrl/oyoJbjTjhPmQl8SkBPSphk1mdcbMRw8Fm8DNmN+W5MxPF+7ky1DtDBBP2zwTaWzxJieGP/Rcm6
X-Gm-Message-State: AOJu0YzbUgcSePuAnDpDNtRWmulZ8gru4f8jP5UIB5cOEF+CAPH88B3c
	JVRsOSX1yN2ChlICiINsZ7tXHfhKsCTQ1VfEHhsQ9jWw6WB1GILC
X-Google-Smtp-Source: AGHT+IG0xGF3XqjukJKCYBK/iGBjGxYiTaFgDY3iB2v6fltmo5sNxhPWZZE/6hlUjouFOfVS9Wmm1w==
X-Received: by 2002:a5d:6d08:0:b0:360:7971:7e2c with SMTP id ffacd0b85a97d-3682631443bmr1137987f8f.54.1721122732710;
        Tue, 16 Jul 2024 02:38:52 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db04748sm8440028f8f.102.2024.07.16.02.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:38:52 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] eth: fbnic: Fix spelling mistake "tiggerring" -> "triggering"
Date: Tue, 16 Jul 2024 10:38:51 +0100
Message-Id: <20240716093851.1003131-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a netdev_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b1a471fac4fe..0ed4c9fff5d8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1499,7 +1499,7 @@ void fbnic_disable(struct fbnic_net *fbn)
 
 static void fbnic_tx_flush(struct fbnic_dev *fbd)
 {
-	netdev_warn(fbd->netdev, "tiggerring Tx flush\n");
+	netdev_warn(fbd->netdev, "triggering Tx flush\n");
 
 	fbnic_rmw32(fbd, FBNIC_TMI_DROP_CTRL, FBNIC_TMI_DROP_CTRL_EN,
 		    FBNIC_TMI_DROP_CTRL_EN);
-- 
2.39.2


