Return-Path: <netdev+bounces-135857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3799F70D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94D7B22144
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1F1FE0F0;
	Tue, 15 Oct 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xOVqTCen"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0A1F80C3
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019841; cv=none; b=GMJkjqg4n5symkGW+c6DI3gjOh0iVNTcWqO2eCz+sRQ9kbnNj+oqQAOBVDwdayYXs71DBANA7tMr9rWPF40ZP8uqfv0RoBtGr09Rtc7CBartcYEPmRYB2ePxwVAkmCPa307+tW79zXu+rFmPkBXDj6+B/3IXoQPJ20/Eg2hDAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019841; c=relaxed/simple;
	bh=aipUUq+7RrB1fQczjwGFQJsXFUnND3UwiWP5TZKO64w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzWPOn5ztKFjSXqCaRf0fYPglj/kwZ16Ny4yjM3O8VKmxvIVHNMm5X8L9gXtbehCjb3HQZcAU25HGPWnXaJtc7BxOL3Q4cRbzaZ0Y8OxEiFEXbRJFLqUDE7wZiPhObkMwFngnKIqSD5xLXJ1vkDL8ZMam1deVZukScd6uspU7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xOVqTCen; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so13788911fa.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019837; x=1729624637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjKPLiEdokQkg97Y4Rb67l893kRgrHE7+ULSYL6zJKs=;
        b=xOVqTCenmIJTaAmWEqUZFj30FSLRy9LU/fiU1SyDuIpBkv9vDstdB8qspfAjO7TncI
         /Lp4zd4Hgt6nIp+MuPptwGr54JSrrccKnjuI20BjkuTwMTblcmqHdfvTR+eziZKayFYs
         fzaK0Y/j/pPHbro4wZ48B+iRuQz8lSRtwLzkTtgnb5PAji+oqNsSJ6V/oE5thC5fKR7n
         ruo8vW3y0XGekPQsjKi9q8AmhNRISPamgt1eVlfcXAM/zGIglQhshmRo+vLYDkZQrdTv
         fdK0nYf108A5dYAup7tqiGv3qo6No5FWWidZjc03XrfUpnLh3TkFQb9pNbxMBr4/nNrI
         ipDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019837; x=1729624637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjKPLiEdokQkg97Y4Rb67l893kRgrHE7+ULSYL6zJKs=;
        b=RqauuSlgw3wtmFNWEsfCWynJRso42wIzu5CbnX6YQgflCuSdE/cHBidZ7jrtlJMlsA
         V6x4JUlHiEBrUeIXAbEsjME2GwnqtfT1bPcHCWDFshl1uV5RAb+7atyqpe2h9TrC+AL4
         cf9eTHS0X1E4FPUdTz8OfqhnEJe8hsAbbbWY+rdeS8Yi4S7SJU6GfQfGtP2GsNMDbjuv
         xE3EOUOlrUolMnRqpCosiritooHeyOcF0YNOZ+UcGMbyaWfhQh1Njyxy/rh3G/1ml+3v
         HSj9N+soG+cE25B3FOKFYTbYVSkoI0XmvEH8cSfhr6Y2+3wSFn/VIJBK8BxoIcBfgNNH
         RXIw==
X-Forwarded-Encrypted: i=1; AJvYcCWM8L+s10eGpbvO4kgmVqnCvllvX8hNW3VlCqVI1B6Px3M3p0xCskS8zzirEBsg9EW1dbNJYEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7KydSNxLmUDnhrnwwG9UG4g9gAsbceqZ3gw2Or47W8weiUZEi
	4G/aCc7HqZ9jiWqcJ/0tOeS974yFgTcNfVIXlg7Q32zWnu5KQzGFmYTIBML7ZMY=
X-Google-Smtp-Source: AGHT+IE4dzRsD/tCQ28U43nJXbo8BVQgpvc+e/8APYlr/mwBjZLsFjDakC3/JIU6v1rQg0lg4s5rnQ==
X-Received: by 2002:a2e:b8ce:0:b0:2fb:c20:dbc3 with SMTP id 38308e7fff4ca-2fb3f2edde8mr59233971fa.39.1729019836565;
        Tue, 15 Oct 2024 12:17:16 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d779975sm971515a12.67.2024.10.15.12.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:16 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:16:00 +0200
Subject: [PATCH v4 6/9] can: m_can: Add use of optional regulator
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-6-fdac1d1e7aa6@baylibre.com>
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
In-Reply-To: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=msp@baylibre.com;
 h=from:subject:message-id; bh=aipUUq+7RrB1fQczjwGFQJsXFUnND3UwiWP5TZKO64w=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59s/XqnFdKfDRbN+T+WsKHVybDbOyYt1kjex0p2ZPP
 8fbcdSko5SFQYyDQVZMkeXuh4Xv6uSuL4hY98gRZg4rE8gQBi5OAZiI3W1GhjWPb03bLCHc+rVj
 3ZH/zMcOcPNpBHzacP4tp8yJfSt1F2xnZHj2dff7aQv9JK24TzXfzy/8Wc/B2PdyzTW3nvPTvY3
 Cm7gA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add support to use a regulator for the core. This is optional and used
to register the dependency on the regulator.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c539375005f71c88fd1f7d1a885ce890ce0e9327..274fdcae49c31d4792b81cdc065821206d3cb206 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -23,6 +23,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 
 #include "m_can.h"
 
@@ -2421,6 +2422,11 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
 		device_set_wakeup_capable(dev, true);
 
+	ret = devm_regulator_get_enable_optional(dev, "vio");
+	if (ret)
+		return ERR_PTR(
+			dev_err_probe(dev, ret, "Failed to get or enable optional regulator\n"));
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */

-- 
2.45.2


