Return-Path: <netdev+bounces-250133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E984D2446A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A71130C70E8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F0037E2EB;
	Thu, 15 Jan 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="bgojcElQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947D37BE67
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477296; cv=none; b=sa7UMPvlGecATmUHeZRL1SnBo28cihpb1WYDdUBqoHFieaSjU3V9bMqEa6dVXJyilbUK2kESr3Jy3yG8jGRgwqpvJTcvCGN3XpFrL3pdMzLDOd67ko50+jbDlmhPfW4siuSmMQX83uIxqhn+t9XWQvpE6yqdwgtWIv5orzTCm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477296; c=relaxed/simple;
	bh=kGLAInhaNaEk5rc2QTU8x+5FcCE5pgYroSfVZcUveHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4qsNE2kevDfjdQsFbcNCnHHi+BuvCqT/LzlecS9zeEOfQr5lI0f6bZzZHuHY9TPxRUGUWJCQ0mgEbn+eq2tkuM7jP2K4MCDpVsqtaTZm4wRmSz36NJO8BSK2yCY/embHS7stvFEeRfp3JWjQHl7fprxdXumTWlbAIex66qSMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=bgojcElQ; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233b172f02so964728c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477294; x=1769082094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6Hh4x4yU6+a4AjWH4xSBmP3UWp5wIhlMj96VEo5V8g=;
        b=bgojcElQFKHWk8J2QDM7bzI7VeTyPtMU5yByyGLHBGEn0Yzh6BeApsylOLgTpadW4C
         KTO1oV5OARVmQgoUL2M7aMX8JxJbTyaGXnuY1QlkT9ZTwtT4DFVNXsbB7oM/L3ESDuh+
         IVs1btTKYgCKpoOZMrBCkWDrae+Qk25O2wHtNBudsylq5Gdj9fYDS2GIRpqIIdBYA2jF
         hsfBZOtSrnv2D+T1AfKZxKG/klbK0DitTvy5qNG9gy1RmjLb/J+wl2WooBVlzq4LRMJP
         vwoW4R36Rj15ZIavj6NtwxzN41g92CfBvH2dEcieMaVZeOXyIIIJw137E7xK7o4Zmtrc
         sZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477294; x=1769082094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6Hh4x4yU6+a4AjWH4xSBmP3UWp5wIhlMj96VEo5V8g=;
        b=Uf9jy2Pi9a99eeoWIh4z3rkRO3yhR5/dDy/Qs7f/BPrMbP76YTcIWgYoqeQRb9rbfg
         1ZBBpJ0TXEhtOcIbefFuU1t6qR+mSTIxcnCfGhz+0NP08nvaoEJcDNWv9HyXhH7wLN0Y
         /tINtqOrjnKONnjvQZeyQKe9MAKLBcMG5aV+XYqpT0hVgi29U3iokvtA/gDOaW01djem
         xi6PSYNzZoa83+E8yU46g/ehz4Dui+5JPXKRezUtmf+50qGD9APE0+l7sSnnbq3UDllr
         nNJB4Xfq+FJm22MH/g6gCv4H2IsXxc6xa2jNp9l5IB9jJqN2aPi+Ic8pv5a/iYUsZk/5
         9Dgg==
X-Forwarded-Encrypted: i=1; AJvYcCWHSW6f3J05Atian5sM6gIlJc+oK4Sb4Q81iEV21NpgdHVvTADYHLdOWI8Ew71syCTD4qTNspo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcF7FMbcBHxLJvQi3HN2icI+cQGYSeI+XGuBZobTM8F58hNwFs
	eSCZhK744WcydjeUSI7J+mJo4O+F471Z7JshdGwAeOo2gsAz1+7oh4GIrOdR8mM5p8E=
X-Gm-Gg: AY/fxX63UgPtuDwAHcRUz72VuqsoFXkZqn6v+Pr+9M8zHHeP0X0S5Fjjjc0G0gbE9FA
	+9wPuaj+DnF9jSiKv4VQLzbR3DJqilB+36NqJ7sks7AWhKwrH6qrEcscfz5kQNrCO0T4lfMpCn0
	JZrwqEtagyBElKax1359k2e6sk37Ill++dFS02XVJfDCPLveVHpzwA0B57r0DSNvDd5NX0miT7H
	CuH97qU7BxydYD1j1e0CNDHr7dv3+6Mg+KIcy1CcOMOdGTrv8zr1zUgA/dZLr3xhfbKB/t2gnES
	JX+7jsHLHGuk1fUcV5Zb9Y3Re8VLTaRct0C3ZbGlGYV2wUNAfqwyOXNZ0K2kyPl3x3LuMHIxf+Y
	2YMxRK3TWWSBm4hYcfHAKgag4L68lnvUA2/WQxgzaUaVEl778HscLOgueVAqH5CqGpGs0wxdRz1
	8yNb7FBrE728qF6oIuDGx+FNI1AwkPly/RVIbXVNzjHyrxtdjvMypVh5Cg1LzH651Eia6Ou5we3
	0wBZn2t
X-Received: by 2002:a05:701b:220b:b0:119:e56b:98bf with SMTP id a92af1059eb24-12336a82526mr5837069c88.38.1768477294058;
        Thu, 15 Jan 2026 03:41:34 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:33 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v5 07/11] arm64: dts: microchip: add LAN969x clock header file
Date: Thu, 15 Jan 2026 12:37:32 +0100
Message-ID: <20260115114021.111324-8-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses hardware clock indexes, so document theses in a header to make
them humanly readable.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v5:
* Relicense to GPL-2.0-or-later OR MIT to match DTSI

 arch/arm64/boot/dts/microchip/clk-lan9691.h | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm64/boot/dts/microchip/clk-lan9691.h

diff --git a/arch/arm64/boot/dts/microchip/clk-lan9691.h b/arch/arm64/boot/dts/microchip/clk-lan9691.h
new file mode 100644
index 000000000000..0f2d7a0f881e
--- /dev/null
+++ b/arch/arm64/boot/dts/microchip/clk-lan9691.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
+
+#ifndef _DTS_CLK_LAN9691_H
+#define _DTS_CLK_LAN9691_H
+
+#define GCK_ID_QSPI0		0
+#define GCK_ID_QSPI2		1
+#define GCK_ID_SDMMC0		2
+#define GCK_ID_SDMMC1		3
+#define GCK_ID_MCAN0		4
+#define GCK_ID_MCAN1		5
+#define GCK_ID_FLEXCOM0		6
+#define GCK_ID_FLEXCOM1		7
+#define GCK_ID_FLEXCOM2		8
+#define GCK_ID_FLEXCOM3		9
+#define GCK_ID_TIMER		10
+#define GCK_ID_USB_REFCLK	11
+
+/* Gate clocks */
+#define GCK_GATE_USB_DRD	12
+#define GCK_GATE_MCRAMC		13
+#define GCK_GATE_HMATRIX	14
+
+#endif
-- 
2.52.0


