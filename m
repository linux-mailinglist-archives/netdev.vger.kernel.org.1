Return-Path: <netdev+bounces-145593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284619D0050
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92F91F228C6
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C51ADFF5;
	Sat, 16 Nov 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KC447fUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024219CC2D
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780195; cv=none; b=Ai2KMmhs5yMxM46Uo6zf1p5yVcUAcJ9/AgXTa0Kwf8PWIUe51iKMmZmopijUTPjyVIQVCZXB+lmHQaDd2MlpxZljLoaiwc4SsowoT73/MRc35gnf+dVgG+9RKMwfg7EnBWxM826b2bclDKXTHxYAJwiGI7YXZLOX5m+EbYlDvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780195; c=relaxed/simple;
	bh=iVOkbe1eRnWeGsTAkh+kyxSnjEZFWE6KQVh2hr3CkMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCtU8RmJzQ8VxBmVDLciNIcKbsgJQd3GmE6Jnev+QY/OfpIjBQz+vwn0Q6tu3H439XPPAxzXgn6fsPkEfUfxW+60C1izKZkxrkyToyLXWnBSuoTCPwFb8ILsdo4XEdAD0IgshUtPNLlHEPI4lySjhQYXbISUgpI+vbL5KBE2mkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KC447fUs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa4833e9c44so242675166b.2
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 10:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780192; x=1732384992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1KN5qU2y25n0Oin8u2W01ajVRL3l5JZUYgBLtna1CA=;
        b=KC447fUsL8LwnpmfucdTwo0WlrEG83Da74tIB5BsC7E8xWn47ZcNLNSUbsGSztvXdU
         zsX07uTScA+wf3aZ7U2hOhW1k+StezN0wcUHaHR9JCpEIWtrHhTkrybJszUDRj9Qf8x+
         y2YULSNNzJphGose2I52z8dYmXnv6EHq5pUJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780192; x=1732384992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1KN5qU2y25n0Oin8u2W01ajVRL3l5JZUYgBLtna1CA=;
        b=i1ZxXixHELOKylc+UjfEznPn1ces5jGyK2JR1mZ5fIF+J9BgCCsQgA0nv9aZ0ZD80v
         fMfc+Bo9dK0RiQlukGST9/tzNPnwdaMfq0z+EbAsfmZIVR1OuTREH5SrdXOSfFa+EpRB
         QBG+S0RozCw23UAMdxEhe0iV1Ftg39OS7VhTEHUsE/nRaO+Tnt3uL0kxp9yaUzReRjCy
         /B1PFUVn1I9U0OPMFXXDAAzzIvCW85FYJ/b/07ReL7ugGaD11yfxyGVa8RFCz7lBi82i
         gwDJMCvVvXcTnV8ZVgJl/jv9qgpdkqz32arhdin4Vw+1J9RB9FhfGjrpljD1k0XZnSYt
         Zj4w==
X-Forwarded-Encrypted: i=1; AJvYcCXtAnntWCF0EJJcPaSqUVZqftg36nm28qiUC8ThulwlkBezVHzV9IvJbRwNOqqAgrhaPoZkcnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfKysXaRllJFkzHtIaTliEivFmDwx5cPPya1AOj/pOCyGKYnP
	Mw6XeorZ4G26O/F6f8hjN2PmHFSGxMh3D/imawQz4LxMoXgUdUIHENNoByLVDp4=
X-Google-Smtp-Source: AGHT+IES+ynBAJVqc7eTqNBNioplQ+TxFxR95t5P1e/kKOcra0XnT3EiiSNrB4CCUflAKPlc0RxwSg==
X-Received: by 2002:a17:907:3689:b0:a9e:8612:eeca with SMTP id a640c23a62f3a-aa48352b54bmr627153166b.48.1731780192655;
        Sat, 16 Nov 2024 10:03:12 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:11 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/7] can: hi311x: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:32 +0100
Message-ID: <20241116180301.3935879-4-dario.binacchi@amarulasolutions.com>
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

The hi3110_can_ist() function was incorrectly incrementing only the
receive error counter, even in cases of bit or acknowledgment errors that
occur during transmission. The patch fixes the issue by incrementing the
appropriate counter based on the type of error.

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/spi/hi311x.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 148d974ebb21..7a4d98037cd3 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -701,17 +701,22 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 
 				cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 				priv->can.can_stats.bus_error++;
-				priv->net->stats.rx_errors++;
-				if (eflag & HI3110_ERR_BITERR)
+				if (eflag & HI3110_ERR_BITERR) {
 					cf->data[2] |= CAN_ERR_PROT_BIT;
-				else if (eflag & HI3110_ERR_FRMERR)
+					priv->net->stats.tx_errors++;
+				} else if (eflag & HI3110_ERR_FRMERR) {
 					cf->data[2] |= CAN_ERR_PROT_FORM;
-				else if (eflag & HI3110_ERR_STUFERR)
+					priv->net->stats.rx_errors++;
+				} else if (eflag & HI3110_ERR_STUFERR) {
 					cf->data[2] |= CAN_ERR_PROT_STUFF;
-				else if (eflag & HI3110_ERR_CRCERR)
+					priv->net->stats.rx_errors++;
+				} else if (eflag & HI3110_ERR_CRCERR) {
 					cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
-				else if (eflag & HI3110_ERR_ACKERR)
+					priv->net->stats.rx_errors++;
+				} else if (eflag & HI3110_ERR_ACKERR) {
 					cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
+					priv->net->stats.tx_errors++;
+				}
 
 				cf->data[6] = hi3110_read(spi, HI3110_READ_TEC);
 				cf->data[7] = hi3110_read(spi, HI3110_READ_REC);
-- 
2.43.0


