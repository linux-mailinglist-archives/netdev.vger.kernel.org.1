Return-Path: <netdev+bounces-148063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E99E0408
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EAC1675C0
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D0205AA5;
	Mon,  2 Dec 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="X5Cjly/K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B00204F71
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147377; cv=none; b=e09wKHXQcJfqP9ydzr84W/dbguCmntAh/CwVUGO07w2LXeyui4On8dQUftUakbIUbu7jd7AUW3fL1n9w1+WnBRCFyoZ6GhHluzNnOEk+ZfFIJY1uOsV4TP71nI1hbNSB5iqnOtZUH8xyVq2i/zk67BW3CJqaqHlisNN+sK0AgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147377; c=relaxed/simple;
	bh=gi4r/9fiAEQcJ1/VpsFKftfVoGeRUSEvG5SkeQqi7t8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjOqqrThX/7TGTZYhrvKTnlwiHHOaP32CPklTpetg3tDbhC4TKGxCrgEqAd0OdDzY8UGmfmTzYjF1Qe6BbohmVkXFtmxpaDGT479Q8tgajSxTgZ9K2IMholsES90Qu8XPWk7oR0eOwtuWKCQcrSlSU7IFxez41kXdo/LvCif82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=X5Cjly/K; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so62643781fa.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 05:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733147374; x=1733752174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwe209DAaje+GcWep9b6H0DEbfZW0MKQs07MfOwMWx4=;
        b=X5Cjly/KKUHZFYcDu1VQKm21CzLtryFHPMONpoaSCvLJL9wXEvLnlzYJV2IXy8qu5o
         LdBW5v6M5A+gFG9cXDnnN3BsYSA2gwMTB0slzdOhaEI6O1gp+EAut5bCKTspmQ9/uU2+
         X45mj0IDppXB+EHNj5sXaVTgiLHYaV+o2ol1lvp5Go+wllXUXJ/sGzlCpM/qLzuYDWO0
         +RY7gNcr2O2qv6t3UvqCjimuYBvPZU5fVwe3ucdgVnrTAhUNQubnOQkeo1Gk0T3/NOQc
         e9S9MUrba3uuwDUFPVPgqbQV7c1b58SDrupqXSk3uPoUWa7SJiDnEMuldd1KxqRf3WGt
         lyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147374; x=1733752174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwe209DAaje+GcWep9b6H0DEbfZW0MKQs07MfOwMWx4=;
        b=LwwTmnXAJ/KP8Y5Eunh0opfcSoL0274f039GqF2lGno5orxeTF4+pM2JpdD6YxnONr
         +a+jGaHACRB8zqeYfO7r46++ersuRezRZZBpafi32npxauyeqhdX4bMNqNzPiFQABVL5
         7bV5Rol56egWhenQIv+MepC5UDBDpjDcxDZ13QsY2QPCEizYmkxYTTJ2bmDayw1zQqh6
         WH766RQSo1ahSNvB3jddDSLRTkcVWHzpQc54JSft44/b42TlWgpwdkr63sFuUu2lXLmM
         mwSElnOvze/Q5EedqsctfSini6opa8nAhycEEY8byqalZqkCYEM8xGQoIW+XN+Ixesg8
         bZ6A==
X-Gm-Message-State: AOJu0YxTWQ2GSSckeWrICyfG9XG7GqiRgxr1N5M2qg47XXwTTEtEZEuo
	yyyVeFTji1jWBvtKT5z6mgEjfCgV6xWg/5Uh5QJq1UOpDMxbN9POGvIY/g5DRKI=
X-Gm-Gg: ASbGncuB0H4Xn4rKpTiVP/07tPgN5/sDdrgUhPhHvzei7D6/gQ1ieU+eRB6eSZvaVmi
	EA+UTXtSb8/d+Bb0wvPJndx72tl5NZzlRk0S7jaV4pvNWsQ+hMAlespq6EM5tKo0y29Xr8+hIiA
	lNxxoew09nNPsrivv2PGZ7ZXYq3IJ4dqWDDc+zWd9s8pp+7s0JAcXt5zi+fDpvlXQl+667Myqhd
	qprJO8IbsJnjwK45QwoCLb7nDVL9T4eNbAlvL14YIZxzh7+e/XyOjKoGq3zCE4u
X-Google-Smtp-Source: AGHT+IGPDUqvNQWOZK2p/wfCfolkShxEPG/W6xNxeCm8LRmsFRVGzSdVT9pHra7gpWP6h2+ulPowbQ==
X-Received: by 2002:a2e:a583:0:b0:2f7:5a41:b0b with SMTP id 38308e7fff4ca-2ffd60a96f8mr185401491fa.26.1733147373869;
        Mon, 02 Dec 2024 05:49:33 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f2csm12972661fa.15.2024.12.02.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:49:33 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 5/5] net: renesas: rswitch: remove speed from gwca structure
Date: Mon,  2 Dec 2024 18:49:04 +0500
Message-Id: <20241202134904.3882317-6-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field is set but never used.

GWCA is rswitch CPU interface module which connects rswitch to the
host over AXI bus. Speed of the switch ports is not anyhow related to
GWCA operation.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 3 ---
 drivers/net/ethernet/renesas/rswitch.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 5980084d9211..bef344e0b1fd 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1902,9 +1902,6 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 	if (err < 0)
 		goto out_get_params;
 
-	if (rdev->priv->gwca.speed < rdev->etha->speed)
-		rdev->priv->gwca.speed = rdev->etha->speed;
-
 	err = rswitch_rxdmac_alloc(ndev);
 	if (err < 0)
 		goto out_rxdmac;
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 72e3ff596d31..303883369b94 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -993,7 +993,6 @@ struct rswitch_gwca {
 	DECLARE_BITMAP(used, RSWITCH_MAX_NUM_QUEUES);
 	u32 tx_irq_bits[RSWITCH_NUM_IRQ_REGS];
 	u32 rx_irq_bits[RSWITCH_NUM_IRQ_REGS];
-	int speed;
 };
 
 #define NUM_QUEUES_PER_NDEV	2
-- 
2.39.5


