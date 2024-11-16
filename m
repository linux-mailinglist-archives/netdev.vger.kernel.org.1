Return-Path: <netdev+bounces-145597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEA09D005D
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB62EB269A5
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F088A1BDAA2;
	Sat, 16 Nov 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="N+rTDxhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4EB1917FD
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780203; cv=none; b=N3SneKnyq5J70jnx698bOLrq8Wo6qXsEkER7LOC1TJhPICthqDckQdiA31TvfkCs2j/SI6sX5l13UR5EyV9c/+boLnyvmg1UcchMNG/wIdDalqpAwDeMFnT1cm/iEZwG77Ur5GrQ27SDNRX4eoAwhufPvsEUVZPiOCLuU4VyZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780203; c=relaxed/simple;
	bh=x191pU5csUjNf+5eLZ0Nmib7//JKYxHIAn9GWqpsWYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWTS+w71itOD/bGXKX41SaiqECgQRPxKzCUiK6oKnQmxUQXbmINRmsLUb5inM2DiwU5+OUgN/+4uWxdgrrDXz0H4tqyfKKTV5r119SrjRf4unFnJvkS8+XKJ8azk+3HqaAz3TH8M1+A9Xst+Z0ltJU8K8Bidiwhy+Etn8W1LfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=N+rTDxhl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso313811966b.1
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 10:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780201; x=1732385001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C7d9rxCEuHbUF9PXUs12JGZsS1zAdEa4j4i3gKpHM4=;
        b=N+rTDxhlx1q4v15tAgZKM0KDGpBxYrwrgaFir8eweP96Afo3FpVUhddFdnqylXfM1w
         OLg7xk4w911T5x3IBX/9uUxizVUmvpjS7z9+0BjaIapAYh8EDgQ8ni2Fv8evL+qn6C61
         SFvoCbarlWTAvvqzw1lgHmhnNgLWn2TY7jakQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780201; x=1732385001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C7d9rxCEuHbUF9PXUs12JGZsS1zAdEa4j4i3gKpHM4=;
        b=mi+WwUIIePkAINDwF85fX5ZS2tbfre1G57yV9CQtmCR3yJSV91ELp8hiuOyKOesFgL
         YK48dRxVIEyCfuL+UVC6EOCzjsSBXLfQItD9Va7sh9r6pUQAzN5unqyP2CIeH0yeYwwC
         A+CT7aSaWKXFQmFMe6OvXhHWSZuqcpwCRZT7ZwqZBUDXVhOicEUZGgOjXV6xaLl7ie0Z
         pWcyCcCbW9r2iwnPNlj61bLpD44LccYKbnSKIFpmcY6iS0C3NSRtkGht2BgrWZP3vEVo
         QA3BN1WHMNMvzQOyrR++aOfNwRibVU9HpRpoYFmzRfVxzVk1J2bMzzICeu22wUN9ewjC
         trzg==
X-Forwarded-Encrypted: i=1; AJvYcCUmGFJkFTSILmyrsyt2X1pJNhxIk+GZOyJx9c41IB6dg4o1Dk1q7vFlwDvWoDCpSecroy2qmOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDs/KS3sHT9i4moAv5qUUwYWpU2j48aLEj1jZAHsEMRZtDyjnL
	edyqDRkEUfbjBctBSp6rUHSO/u88dQrFfm84GxdDcqGftjUgp3saNi4MJ+9eNKg=
X-Google-Smtp-Source: AGHT+IHL/EwOUuvDKou6kklzDzL1Ir/aKMiYpZiijN1w+hmbgwaSQwKLBVtSh5AFMY3NeE8czlFetQ==
X-Received: by 2002:a17:906:5ad2:b0:a9f:508:592a with SMTP id a640c23a62f3a-aa4a28a3bd6mr104955266b.46.1731780200732;
        Sat, 16 Nov 2024 10:03:20 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:20 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 7/7] can: f81604: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:36 +0100
Message-ID: <20241116180301.3935879-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
References: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The f81604_handle_can_bus_errors() function only incremented the receive
error counter and never the transmit error counter, even if the ECC_DIR
flag reported that an error had occurred during transmission. The patch
increments the receive/transmit error counter based on the value of the
ECC_DIR flag.

Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/net/can/usb/f81604.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index bc0c8903fe77..8463e00517c9 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -526,7 +526,6 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 		netdev_dbg(netdev, "bus error interrupt\n");
 
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		if (skb) {
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
@@ -550,8 +549,12 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 			cf->data[3] = data->ecc & F81604_SJA1000_ECC_SEG;
 
 			/* Error occurred during transmission? */
-			if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0)
+			if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0) {
 				cf->data[2] |= CAN_ERR_PROT_TX;
+				stats->tx_errors++;
+			} else {
+				stats->rx_errors++;
+			}
 		}
 
 		set_bit(F81604_CLEAR_ECC, &priv->clear_flags);
-- 
2.43.0


