Return-Path: <netdev+bounces-124466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7E969925
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596902867C7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A7D1A4E97;
	Tue,  3 Sep 2024 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="ITpXzwsp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF91D0966
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355992; cv=none; b=T3po3lB+CFvP/qXBe8+c6pA+h2vybhodx57d3+dYE/0BgxMiQTV3UT+iaLxAPjmspyYDWiiPofJhNMr0ykq3mN4Y/u1Fowi5u8eyREyErXJ6wRruQkazm1R17E/kbKqN02ciIlzbQH1SgFdzJhz7raicEG0rHsnCSBF5y8l8skY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355992; c=relaxed/simple;
	bh=kQLyNykQqBQZJ3maZQVcRjGOkfhOeqGO9xiQOZ8mkaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vCnwitsUgYNeilxLwVNybdELZ+yyF6VPZrsWMB8KfzLJ2xxx26SNhhrQEPiurTYBmyvHlXeWoR1IwF1XNv5YjOTIVd8rWx2vxkQKyzCEu0pDSi7QQmMwP6GL8e4x+I8/3uq2+wOaDwr5bRjYH8uMbv7Iv4zQbpa4FNKklYLEem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=ITpXzwsp; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5df9dec9c0eso3362547eaf.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1725355989; x=1725960789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+RntZ4TKPgJ83xM8E1VHb1TVHAZ7oR+PPNqSgiu05M=;
        b=ITpXzwspuZcyxONsk85oowxhsSw36/xnY0vL+GYhpw3F8h1lchNrE4PiwEijxrHFsO
         9aMugate75wKr5AJ9NoP+OiPXCCAgx5euxpMVGYC9sDK8RIqvBbHbhlD+bqpWX63XZgB
         84YqvGWUHj7LYxTYKA4MLX4XMwluNVqDlEukAV6kvxRTep/hBBvEQLGOEyacSgR7AV0D
         GVpSHB5lsD350a3G2NfD/iP5pzF/rJck6caSdYllOGZ36jGCymnTlj1J6vPyL71bbQP/
         uch+FK+KZew4mNYkFxWyZExecoVi4dJt8MpZW/fh8OP7Q0wJVc6gkHljzmvVTFQekw4M
         lmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355989; x=1725960789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+RntZ4TKPgJ83xM8E1VHb1TVHAZ7oR+PPNqSgiu05M=;
        b=wN7+JmA5Yg62jIafhhLlL73tvksKHgqbpLdPglULJ0mVpZrYXSWkPgct90NhbaHIUX
         JXTb3VG1FkkmSHZExancnfaDsZV1QqVn7ZrsP9TdgbgfJsOobNyfV8WSQbArhRBZ6w9H
         Fh/y/Wei9HGQafzmhNV1pEEdFNpr5HvvmjanEJ43JzDZt4OVsueG3HM7+u6+KyGA1uqL
         yAsFVjvflNoRfJ6jgItfHcDyuR2Wczy9v69f8yG7wycxJkVdUdRjx+TltQJ89ppYKYYN
         S3kPPyWpzq46ibNl6Vl+4ChAJKqgqlqSuzV25J5Qg5CaGqruzU7Y48B59WKGOuOvA5Rp
         es0w==
X-Forwarded-Encrypted: i=1; AJvYcCXHVdFZatO5sDPwG+dADaBNhHespcHM0iQ5i1A0mHaXqdPOHEOu70OxX7dRxfLFpQMj7Qok+HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziTJMzeA4EGQWNpRy1HXveFJgz4RqUPT33nXXq8bBOI4j0cttk
	1WIHwmN7mpLzqw8+9TXS6Z18SJXCSwVumdzQa2Q4FMKm5jS2ETi5Yd0nUOYYXw==
X-Google-Smtp-Source: AGHT+IEg0lJl5/lZ5jrU6aG5mLySM/tKlGvW6bh/MFwKa8Sge7iFZlkRVLE1v4F4gvg//LFtRWlzSA==
X-Received: by 2002:a05:6358:9499:b0:1b5:fb38:5ed0 with SMTP id e5c5f4694b2df-1b7ef69be82mr1133321855d.2.1725355989509;
        Tue, 03 Sep 2024 02:33:09 -0700 (PDT)
Received: from [172.22.57.189] ([117.250.76.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d72d1sm8365868b3a.170.2024.09.03.02.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:33:09 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Tue, 03 Sep 2024 15:02:18 +0530
Subject: [PATCH v4 1/3] dt-bindings: net: ti,cc1352p7: Add
 bootloader-backdoor-gpios
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-beagleplay_fw_upgrade-v4-1-526fc62204a7@beagleboard.org>
References: <20240903-beagleplay_fw_upgrade-v4-0-526fc62204a7@beagleboard.org>
In-Reply-To: <20240903-beagleplay_fw_upgrade-v4-0-526fc62204a7@beagleboard.org>
To: d-gole@ti.com, lorforlinux@beagleboard.org, jkridner@beagleboard.org, 
 robertcnelson@beagleboard.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=kQLyNykQqBQZJ3maZQVcRjGOkfhOeqGO9xiQOZ8mkaQ=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBm1tfEROETaiK0xZE+/xP/CCiBas9g0tnCDrPh2
 6uOZ6ctZ4OJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZtbXxAAKCRAFzvXHieVa
 dCWREACeAyCLjk+BnzVkk4TyPyrAoCeqn7+bLAr5Pfi4umCwAiHUDDKMbbP/JsaWdv8atIunthE
 O0DLqohZeN+zbK1TgRyLgUfvzR9/daqgWXkffQIcr/OMR4Q/03InYm+gV8bcJzZOD9S5mjSJefd
 MYIyLQN34dCeF/ko4T7E/1fG/Z4X8X5/2CFmOTDVUteJGQ4Get1Se7OFeHZhqgB0qFMtYpexH++
 SAWKGiQtBh0pg7U24VUL94LqL3WSBdwq/RA32PG1mYh4NeUARmmb3EkM5ViNX3+d2y00vHVlcYp
 deTSPH2WntnTnrNhBFUFIke1e300B+ZiCAYXBoDdPVs2UypmmakrWbJn75opmwt+ntI62Mrnk8w
 RTT6X/qnCy7uEf3lz4Ks6LCrJTt3fpdHR64zQr36JxfQO8VgXa2uiISQwflERfwwJ8LDUe1SHEo
 mjpTOa5IsZSxo3icqCYvf//aPsRchfSRWOLVFHK3PZtGFWsmYnX49VWBd+g9GZMt7Qhagc86W8d
 XRjBgJsIJ7N7y2NHdFPs4TKwurGUNRm1ZkJvh9JFKQfndKBk/Of3/H5LLtmejwL6OpvfyYbUlkb
 boLkDdMuXJQJJplMCQdUAh8CVlzgdYXcTiSeQhw2DuswubEDEl3FKD9ebwSWjcZZeXV9xCfNHt6
 B+6IHlYenQdE1Gw==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

bootloader-backdoor-gpio (along with reset-gpio) is used to enable
bootloader backdoor for flashing new firmware.

The pin and pin level to enable bootloader backdoor is configured using
the following CCFG variables in cc1352p7:
- SET_CCFG_BL_CONFIG_BL_PIN_NO
- SET_CCFG_BL_CONFIG_BL_LEVEL

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
index 3dde10de4630..4f4253441547 100644
--- a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
+++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
@@ -29,6 +29,12 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  bootloader-backdoor-gpios:
+    maxItems: 1
+    description: |
+      gpios to enable bootloader backdoor in cc1352p7 bootloader to allow
+      flashing new firmware.
+
   vdds-supply: true
 
 required:
@@ -46,6 +52,7 @@ examples:
         clocks = <&sclk_hf 0>, <&sclk_lf 25>;
         clock-names = "sclk_hf", "sclk_lf";
         reset-gpios = <&pio 35 GPIO_ACTIVE_LOW>;
+        bootloader-backdoor-gpios = <&pio 36 GPIO_ACTIVE_LOW>;
         vdds-supply = <&vdds>;
       };
     };

-- 
2.46.0


