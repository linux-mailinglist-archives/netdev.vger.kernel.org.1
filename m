Return-Path: <netdev+bounces-135860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E115B99F717
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 21:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6209281B68
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BA41FE11D;
	Tue, 15 Oct 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a5qzwe3f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65411FE10F
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019843; cv=none; b=KQQ30VwX9MhN/7qKEEswDfW8qVoe6+DwNFpSOshUa+nUSAVbk0HcmdpLzhbWKSiT9xT3Mj83tS657/xARNfcx51vndfJYOBBY2mIjHWoUZfCBsNtyJXDuTCOBRa1OZ97VG4a4IVxF4MvRO9nYccS5edGOe1D7n1WaQjw7Zp7X/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019843; c=relaxed/simple;
	bh=Mzxbq0cogQNrwowj1zfIE0DVBGY5w4Uyxw7H3xobrQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMRutDslwQEC/+B36x55yTDtN1cUAV6Dz8viUAbuabKcg7XXeeJ7wKkNOYeWoDuHZV7CiiEMPU1Zy88qgtflwhMxiv50b4GIGXEsxnzqGA9Bat0HmC89ZME62/93/9cAJ4xFQi5JXbznimPnDgO4lDiLN+U1Q47NPwIFW4/pkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a5qzwe3f; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c973697b52so3745350a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019840; x=1729624640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0ITVZ/ruKG/TLGpfGAwzLMygWSysjucbld18q4vTYY=;
        b=a5qzwe3f6tK9/R7s61yQfB1pNI6YhyoXKhIc/YSpkQeZs9KouGICNxmGqn+eknUaRd
         65qGejTZgYBSRFdFs1E2DDR+oHUEx09A7PZpqJ+nBLefFXK0PVIFByHE3NJdzPigvaO9
         HS/A5clVzA5uMtMe+SJp5Er/M97RG6nQOKD86SQJJ50aT8jCtKp/OJnBy94rFu4EdUL3
         X0mrbdsvAJHR+k4JuElxUq2zb71qfNS2CY2c0H1aKBkgIGykg2ER51r5FGkyjQk4T2k7
         ypQObybFBwVyJ39VSyw3xwjxP6/h4ESEbRsc03AdnEUHKKFJEKjHKcYKdOp6AJ3jYZ1C
         5qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019840; x=1729624640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0ITVZ/ruKG/TLGpfGAwzLMygWSysjucbld18q4vTYY=;
        b=nKxxps2frbT1GV9MfVkK9T/x0aXnHkNxYuPsiA6HKOTXXK0PDiysNKr9QCZYk6sPwn
         Ug0naGqfh0dEgbgCVLvgMDJ3fVa3vr7ZC2WvJO3FENeotYUYbsn8QQvZ2OG2QxskkAXy
         NnFsnTi4v10xErC8bvWzdIKRjfT6Vlwf8kdtL8wYyv+IfjwZgq4FerYeVch4fhyul/6O
         LpyNjfyejnuCBctwyHwYxz3L7FF4XImKBe6Vm8FzCF7CzNlhhjzynDA2pso+S+LaDT7O
         eXlQ2Ljbu/tz8GpE8h5JWm7DtVo1XUIhQpTQrBDpIRWDfPqFggBM3na8dvCTedTF3CP6
         wJhg==
X-Forwarded-Encrypted: i=1; AJvYcCX5e8wigPlhMaiR+y2gQJso4wl3xfxsQWf/VTce8fFnP+Gr163eGRGTXGl9wu3gh39QauPmKo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH02cPR2Jw+AMZBcCyKENZXbcC/fwwQ5QtT9AzHfbm99QbpaaE
	oielAL58dDADm9/SuxyzVYiwgXdyxUYjHxXZDwiMuvKonaszlVmJCmzv0zPNqBk=
X-Google-Smtp-Source: AGHT+IFE3zU2wsWTaMuFRX4RT0/Jxds4c9H2MyVuhIDmZBUP8boAZj8D2JLinmI6aBazvsto4DV1Nw==
X-Received: by 2002:a17:907:3f8f:b0:a99:f746:385 with SMTP id a640c23a62f3a-a99f746105fmr1163295466b.1.1729019840193;
        Tue, 15 Oct 2024 12:17:20 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29749540sm101289166b.76.2024.10.15.12.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:19 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:16:03 +0200
Subject: [PATCH v4 9/9] arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-9-fdac1d1e7aa6@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Tq/fbr0WhZHR5UVyg7x0DcqyPJVYjETLUN6TQAqpB5E=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59q9r6nha9Hh5SuMeznWH2r4sOONbuO/kHN3Ls+fGu
 Syurd9/vqOUhUGMg0FWTJHl7oeF7+rkri+IWPfIEWYOKxPIEAYuTgGYyPpqhn92rt2Nr1as3zBp
 iqqu7MKwdG2e72VxM0NEmzz/ay+Y8v4dw/+0xo+R89ulZlmvn9J26sPnrSva7yu+i1wZ38bg8n+
 i8noOAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

From: Vibhore Vardhan <vibhore@ti.com>

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree. Based on the patch for AM62a.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index b33aff0d65c9def755f8dda9eb9feda7bc74e5c8..3afa17e6592f39387a667547835c90f95a9af351 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -173,6 +173,7 @@ mcu_mcan0: can@4e08000 {
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -188,6 +189,7 @@ mcu_mcan1: can@4e18000 {
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source;
 		status = "disabled";
 	};
 

-- 
2.45.2


