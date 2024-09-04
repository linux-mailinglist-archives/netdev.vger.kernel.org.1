Return-Path: <netdev+bounces-125160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB07996C1D2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C1C1C2211E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE241DEFEC;
	Wed,  4 Sep 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS4BBT9L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A11DEFC2;
	Wed,  4 Sep 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462638; cv=none; b=Drq0L2cnAKgYUX0L1vFDmiuaacAY+66vtMP2uNWOBGh+UePyUqFuXLKfPgbZR7Riheks1Wq/JOUtOOxtpin8/TkuM4BKb/joL3sGE/lcihjCC5enQpf5jSAVqtFlWnTEkgQdn5mOgg/kugH2t3mmkB3yFNf5+hDZkkBbqgHnRyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462638; c=relaxed/simple;
	bh=77DPBtPsKIUYtgU4WKxUAPrI/k0SzeyXIUXrWlHugoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Geh9BdJNFKqaTH0pZtkcBdCHaFm3eddv1f/fhy3e2wpnS05gfCCYmiNaRYPpYBnObL2RvKAjO1nwxE4c+gE8B9UNsNRqIUapNFyr6S3WUeakpvDipBIkBCdYrY77lcWYi6IFzGsxHkeLQLkL0Q40TYrHNfW9BgqrKlGAPnJ4nmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS4BBT9L; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86b46c4831so788248266b.1;
        Wed, 04 Sep 2024 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462635; x=1726067435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRqHGX1dkwlnA7Nv98xmqW1O3WTx8p18LGH7Q6/PB5c=;
        b=JS4BBT9LgYBl0ThXpQyh7D+zSjYSCFBpv5ZEengh57cXpcj5riWmUbrEOrR7ox+tBY
         RN6Ccd26CfBgNMLz6xAmB0wwSeDAd3zYFIjjjZrc3NCJhIJBxmxyX4JvgnWvAMH5lAgI
         pz+boT9znV0oRAEPxeStGwYdJPhhDrVOaYGngNOnkLr8uJLhtkmGoRB+E0D4fCcQHRJ7
         a34g94XpTCOg5gQ4CrdX6X7YTriSDRqkYiPawNUpy/R3mOFgmJj1kgxOiAcAN8XucoPD
         aVkFLxT/f0pMxO5862/f5ALHpDJFWKzhfxBPKk7ugDf+6rmpaWbX7GwZ7urEnyBAkP/8
         wrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462635; x=1726067435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRqHGX1dkwlnA7Nv98xmqW1O3WTx8p18LGH7Q6/PB5c=;
        b=BifhVcZajMypzVvbu7Ozk8ZCqb+viuKNlPEOFBtgf1p7CKWufQPXd2H+OY1t8ROVCE
         a/kaGru7h7JLT08lyRFul7M5NfwFqGO1YO/IJTgbNICKtq/pxxS01SVGrzEwCjUQa9Uw
         mrSRdzux8ZHwB1gzilGD1SqP7JGJowGxBbahHGGKrlMP8zhFcDDRJMHbSh4OpID/goYJ
         oGp+0wJJzOzHe1dqUyJF1Ic2Mj0kMM7LZzzKnbhn14Gr+oF5fvYBPLPhe99rOkKvr8Kx
         QQbc0FE6H30ey4v3mmK1TuLgvqIBeeP67RN0whE+LQzfMjeq8BV2L8ORYcBkCQ+YkIfq
         y8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCULWJLdV0pVKxwb+yj9JcoDbiCxfQX2Fg704XmFGbK2YHlkkGN0KoblSC6HUTM79eOuARXtiRa/2wDsZUk=@vger.kernel.org, AJvYcCXlhnMlem8aN3LgDNFIiZXRaPSDJL2MaytMH1Jt+T+ZURcQyMWBqahMj2jWft/rCB40wqiXEom1@vger.kernel.org
X-Gm-Message-State: AOJu0YxiIJfEA8sjLcZRy6dgjhFvGGpeyLyGYCl+ILy6pN686FlrSQiV
	YFBBzYVGEMc0W3QCT5E2lUilvPC8BqBqSN4aoEjWFdUm+MYx7jGX/DY9nY3N
X-Google-Smtp-Source: AGHT+IH/VUNWzyEYZerWoaOK0fCLQrXeHAqtMooLVFTWel9m5k9dwQNHLs+uGcacYuJW4YqS9vuJ0Q==
X-Received: by 2002:a17:907:7253:b0:a86:7b71:7b77 with SMTP id a640c23a62f3a-a89d8848dfemr946739066b.44.1725462635076;
        Wed, 04 Sep 2024 08:10:35 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c8bsm2956666b.146.2024.09.04.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:10:33 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nico@fluxnic.net
Cc: leitao@debian.org,
	u.kleine-koenig@pengutronix.de,
	thorsten.blum@toblux.com,
	vassilisamir@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
Date: Wed,  4 Sep 2024 17:10:17 +0200
Message-Id: <20240904151018.71967-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904151018.71967-1-vassilisamir@gmail.com>
References: <20240904151018.71967-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 11243f89c98a..c7a8cd060587 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -599,7 +599,7 @@ static int rtl8366rb_setup_cascaded_irq(struct realtek_priv *priv)
 	}
 
 	/* Fetch IRQ edge information from the descriptor */
-	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irq_trig = irq_get_trigger_type(irq);
 	switch (irq_trig) {
 	case IRQF_TRIGGER_RISING:
 	case IRQF_TRIGGER_HIGH:
-- 
2.25.1


