Return-Path: <netdev+bounces-135853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D0B99F6FC
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7326E1C2310B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1E81F818D;
	Tue, 15 Oct 2024 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o02LR9nx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E8189B8A
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019836; cv=none; b=HUwZ8kyy0K97EpHZ9ocbgyDBY0wAaz/dRJ5ZgffuD+Rr4nl2bgN1gMg1kVs8QixVO6uRYc7NMeKE8tmcc7PWxb28TE3w2K7JAxtmHv7PDAHZWX7hmCYzisAJ+/FeX8+j9a7b7GzokaPxpSMhEpyvrbBtVViTs8n+NazVmkMh9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019836; c=relaxed/simple;
	bh=UPDN5Sq6sr7oOOH4G9BvBLb/9GgPBe4IrDFtGwTay8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBLTb+BF6CIS0uG+u9TYUczTNjgnZaXdVMbK9adrM1YoG24zlvDfhm/R/5lrKvRzuKseR+MKYlr+BwNMlwMasyzbsYnVa61j8Gir9X0ny6weoT8biTWu59xJhziSin2Pdmf7zvlp3vPrNBa/hCO+sRGjK15JREXtBNIaFSZS17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o02LR9nx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e8607c2aso3791615e87.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019832; x=1729624632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saDUfDEJR0b1bnX4tkk4rHbVAroR4qkyv+y1+fjCTpM=;
        b=o02LR9nx3ANPw+3/leRzpqYGzyC7gIV/cbstbu0ddqnNo6ftVgmTrVAPBD4mKpcPJP
         ieXHNPoTvV2ceO/qbeRoCOBrEm+QjLLkOeoDdP2sJn8wh2xmiORFc/LOgA9bOzRUzJQG
         JxCuM/hf6aGQAPaKk66zDMsISwGz4ixcdD6hXXCLThl/p/y+SVliTca8QTe/hGHMHVFg
         mgu9U2N5Ua2LvE0ld243P6W1g3SzS2RL9h+qXPavAlHnWxEe9x+j+BYOWnRT/1fklhNz
         35cms12r2VqKPo5Kus08wWFwiycdp0HO4xaD4f7S83CTMEqBWV8dDj/xwLuemZcC4Hhp
         x5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019832; x=1729624632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saDUfDEJR0b1bnX4tkk4rHbVAroR4qkyv+y1+fjCTpM=;
        b=F6sU/j36+xneaMFYvHrihRDal5MowkK634vXxvt+7+qGr3RXNgBztaUj0QCvzIJnQy
         qPpG1uVTFLckuRrOWzCCjyrQUjXy9yS/htM7JlrptidFJpQKAYH0T2eLT9/IWowDQNVi
         PXk6DS5ALtnweaebIkZt31QMH65B/amRvTo6yg5cG7br+RFoI4+qaZ9UoPa+Jpj2TGys
         ZZ+HEkP4ZJ+6RpKh096QanXsQy4YaVvolQiR/VF04rGbZXHcGxXKaz6wsPuFXfoKhJyR
         iZ0GgG24Oj3sLN0GyAkNnAzS5Q9V2XFcyw56uOoBXcfYYhHHc3vDhgZZTYdCZr+2qmKZ
         c/RA==
X-Forwarded-Encrypted: i=1; AJvYcCXni4XtgN/W7ANaJzGiU0IMRTIEpDO4F7EmUSgiidHSuh0mtt/W+xha6+lIQXvkanySfEnaqSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXdAVZmyDDe2zFe7HP+FjmEiOYqU2ZrpF1s/CkErQEim8KBSF
	Ln3Xaz/ri5R7Z80sGPPBzFC020mjC1M8eeDdRG+wdlc9gyE8GDJIKeDsmIzna1s=
X-Google-Smtp-Source: AGHT+IFxGivhAN/nSNOoLheyHq+ARNplWEmPyvbotn4tEsxOfN/CTNRV/WQq00xw7zNxKmVZkX8xEw==
X-Received: by 2002:a05:6512:1599:b0:539:fd1b:baf5 with SMTP id 2adb3069b0e04-53a03f18d61mr957911e87.16.1729019831697;
        Tue, 15 Oct 2024 12:17:11 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29844cc9sm100891566b.182.2024.10.15.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:11 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:15:56 +0200
Subject: [PATCH v4 2/9] dt-bindings: can: m_can: Add vio-supply
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-2-fdac1d1e7aa6@baylibre.com>
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
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=msp@baylibre.com;
 h=from:subject:message-id; bh=UPDN5Sq6sr7oOOH4G9BvBLb/9GgPBe4IrDFtGwTay8A=;
 b=kA0DAAgWJIy04tQVrj8ByyZiAGcOv4yj3tsKAl5GXHqokb05W6ep2N/lbn0I+W8qCDj1wuDdj
 Yh1BAAWCAAdFiEE3fCh7n4e16BYruJBJIy04tQVrj8FAmcOv4wACgkQJIy04tQVrj8loAEAg7v/
 fmMlmA9duPbbiOawXOqpUc9t+28UBJWyEe/V8oUA/2oR68+3s4nCZte+s7g225dGBOOf9wokyJe
 BCw4WQjoO
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The m_can unit can be integrated in different ways. For AM62 the unit is
integrated in different parts of the system (MCU or Main domain) and can
be powered by different external power sources. For example on am62-lp-sk
mcu_mcan0 and mcu_mcan1 are powered through VDDSHV_CANUART by an
external regulator. To be able to describe these relationships, add a
vio-supply property to this binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 0c1f9fa7371897d45539ead49c9d290fb4966f30..aac2add319e240f4f561b755f41bf267b807ebcd 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -140,6 +140,10 @@ properties:
 
   wakeup-source: true
 
+  vio-supply:
+    description:
+      Reference to the main power supply of the unit.
+
 required:
   - compatible
   - reg

-- 
2.45.2


