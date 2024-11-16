Return-Path: <netdev+bounces-145594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1434B9D0055
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10E4B2545B
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B11B1B3938;
	Sat, 16 Nov 2024 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="asoGproX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD71917F1
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780199; cv=none; b=IK6XyhHyAwOkyM8F2OnVXkpWDZN0u7ebc5eJZhfN86kwAfBg46pUChT0xJk/NxoItfHL5ACRamW1qeYO1BWkQlvnhFdd4c2pdo2YIgjUEibAh3BPQ70oECXmDUnFADDRsp5idRKL6KOT87f7DWs2marec3/gPsasJPpOsDdqXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780199; c=relaxed/simple;
	bh=b+NraIsUClYsl+LKVbalvzNKBzSiT/wtutwKCT3G2ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJt5Yd0CEDyk1lsx0+KlGBI6Yst5zuTOkxGBx/YpUkr9LZ6RFihOKotWnHuG5AiT2r5uS1AWuNIjr5Qt4oUnukTo92Saosfar/IJYJi889rgf0/2Pvhn08ov4l/I96XCctPSutwsQgkb6jnE55NkmmlTgux8H+wWEIeLFWp6gas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=asoGproX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9acafdb745so558234066b.0
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 10:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780195; x=1732384995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPi0av2xe0jC0J5HdvNkCxIcsg4iO3imVdR2/hegefY=;
        b=asoGproXuz1ZNgmEjSgCPF6L9Vv8f07KkLdTa0sETtE3Xsy1+7ZCsAMGhxDV6/VdJj
         WZg/Vq6znz40fyTgL24alMigYmclmtdnurp9jvan3a3yxsO+B6GMGD9dpCF8kjqeLITW
         yR7Le4s+AX/pKt5G0XvK0X3VmmrXGCxP01pHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780195; x=1732384995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPi0av2xe0jC0J5HdvNkCxIcsg4iO3imVdR2/hegefY=;
        b=L394b6YKTLlGlxygnDQYWEVF1MsIB0qE+wwjhIWT2w334Ph+/oHWg52ysw3707x4eY
         VsmCDLm2FHsDcs+34q9eDzrmZNGEq1dBI1oHCDAaM37oGM0az8WkyFkhokZtRwyUfwF0
         IdvwsbmGItY39u/oYkVaoQiJwJoTSkZsvEaSWOtD2sVvTXdcAVxWH8N6DVDKAIEylBRB
         tFErXte1uNWVJ4u8bMshMHY6E97v72yxHiz/Loz84T2eBBdgmAi6jn97ke53RDOqkBhj
         ejYiDdWuFxOk91kshFmNjNhiVmDSl00Jiu46LTPHPhkWjthCZslFZV8VQ2hVJ6kE9NcR
         6lGw==
X-Forwarded-Encrypted: i=1; AJvYcCWg6UFRI5+JkiOSw9k8qIETh4BjfQDEemItm50/4v4PT74W5oTTEBmCPpMNJxFjcP3JnlAcIEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzRYX0Fo2l5Nc9v+l+6TiVLnXEMJwm84kOepR0RN5vp6BDXAU
	qDxEC8c6B7OFkjatokEKKn6LmCfgVOv46+nKwYJozcagah05q7LhLh/dtisYdkc=
X-Google-Smtp-Source: AGHT+IGiCGpsd+G1WFq5UxLc4I4k8txDJ+JeMk91+wJgoZFiUor+BpmbVpSQLk7uJcDP3qphPmkBiw==
X-Received: by 2002:a17:907:9813:b0:a9e:c266:4e82 with SMTP id a640c23a62f3a-aa48185c694mr772769266b.6.1731780195092;
        Sat, 16 Nov 2024 10:03:15 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:14 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 4/7] can: sja1000: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:33 +0100
Message-ID: <20241116180301.3935879-5-dario.binacchi@amarulasolutions.com>
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

The sja1000_err() function only incremented the receive error counter
and never the transmit error counter, even if the ECC_DIR flag reported
that an error had occurred during transmission. The patch increments the
receive/transmit error counter based on the value of the ECC_DIR flag.

Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/sja1000/sja1000.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ddb3247948ad..706ee8f6b7db 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -460,7 +460,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (isrc & IRQ_BEI) {
 		/* bus error interrupt */
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		ecc = priv->read_reg(priv, SJA1000_ECC);
 
@@ -485,8 +484,12 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		cf->data[3] = ecc & ECC_SEG;
 
 		/* Error occurred during transmission? */
-		if ((ecc & ECC_DIR) == 0)
+		if ((ecc & ECC_DIR) == 0) {
 			cf->data[2] |= CAN_ERR_PROT_TX;
+			stats->tx_errors++;
+		} else {
+			stats->rx_errors++;
+		}
 	}
 	if (isrc & IRQ_EPI) {
 		/* error passive interrupt */
-- 
2.43.0


