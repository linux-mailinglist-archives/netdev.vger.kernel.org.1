Return-Path: <netdev+bounces-121734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F40095E46F
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 18:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD952281A66
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 16:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829C16F827;
	Sun, 25 Aug 2024 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="fr3B5lw/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45C15538C
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724604453; cv=none; b=QHyXydeJ9Mhr+LYaViyRUsrlKD6mGuEw6mV3OpUzGlf1wsw8pq2RhiSH2zjQTzxEOxBBsCCYSpH/VRYF/VptvsWuw5XfLnVBAd91MEOSwXFVLjl3pq5tpOUoxEwKuvP/3OBK8ICvlPL6I+ICSV6DRG9Yd5OYV0FWM2kI9LoDdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724604453; c=relaxed/simple;
	bh=GMfOVBjnJuIyDUwmWasZ6B3xnGuCFW07MH/nRO0xhUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E03KHq3daNDyEBKE5dfsf5t4EA67Z4OV8nyv4i3YsHIwo1rc7tX+EzG1BGDHh0q9D6Ln3uxr4PvMpYK0OUYbAnkLhkV+Rm7OO+iMUiL/zeRJa6L86ce6rhxisTE8dsBJHd434XOhxo3wMIIhVSRDRqFXG7c5lArP2iaFiPx5mVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=fr3B5lw/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2023dd9b86aso25431765ad.1
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1724604450; x=1725209250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxz9W0rg7mMy2BV/5liqAlp9Grj+cfqvAy4EMVlcW0Q=;
        b=fr3B5lw/bVqgJiO7soC+T8JogG+9fFs4EWV42bJtHJ7whKmnYImso1ZEycDe776lNY
         4mSUAm3+bb4iUIpUVYsDvqe4Qf3O6ocJRXbUMBMPpH834QJP3lVqbTDF5PV0Yab9Cqc+
         zVx8DVVVcxoVv10fkR7e2N8WwaxJGCfc6vJ6MxoyhzZ8mbzSuE27dlmRmKd8q+2l+p4j
         HUo35OSrvyVnD+DT3lU8ZfK89dcRwnegMbUwZgz7NbYpWjnhGG9OvVb5Fpn2lKR9k+I8
         ViCLDHzVcXaqMhX6LRNUhRy5BX7Uel5ItlMOi3lbr1lp9+yJy9UY/0cwj/ToINcGxFnw
         yiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724604450; x=1725209250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxz9W0rg7mMy2BV/5liqAlp9Grj+cfqvAy4EMVlcW0Q=;
        b=ZF6Ud+G4TUZqpDwww9AQXdgvOuT6bISPyw67BpxoaqIgbcXoOialUEkTSfSdqAO7kt
         AU0Yf71nFTrZ/TEO1JSes+buQzI/ifSCk4/P9xv01n3EgRT5BwXMXtCGjWBPuHwEGlxV
         wz5o8wseQ9I/0VxgwVIBaJ5mSG9ReicW4ujSMtSZsUijciQUNAIsSqMza4NkeQ1mX4kz
         qHLaxq+9IJPK5NELxMHeX+oJWySSvRRASMrblXD2iErNCPb+gs4TsBBHa9+Ctx2zI/C+
         Wm1fuf4oJSdVDK2oB/7L3q8WdAqX+aoy2OciauhzzefTHQ1qxt4oX/102L7b41YAu4oJ
         pfcA==
X-Forwarded-Encrypted: i=1; AJvYcCWuGv4tayu02xmkO7S/wa2HQZRtLS7mBz2riw0VBNsYZhlHkDjMKjgZqHQwCvih8fKAtIHNNUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOI7vkbjreaL7+/okaWbiMcjPh9ym41imDOvV07R9xWdeMpZj
	eTAdSto0WeTfc/mKQV1eG7IGbeOXGWmXjB7kvT4NRXJMP8i1zesaEQ9V9SYzjg==
X-Google-Smtp-Source: AGHT+IGVR21d8zqzI/Keli5KOIFPrhh0cOLMEXTUS9i86vC9K91QywMMPIUWj0mRJltzwRZynXU06g==
X-Received: by 2002:a17:902:d4cd:b0:202:2f0:3bb2 with SMTP id d9443c01a7336-2039e555a4dmr75158555ad.60.1724604450596;
        Sun, 25 Aug 2024 09:47:30 -0700 (PDT)
Received: from [192.168.41.46] ([2401:4900:5ae1:9eb1:890a:6b80:a16d:5ab4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609dddsm55411465ad.196.2024.08.25.09.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 09:47:30 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Sun, 25 Aug 2024 22:17:05 +0530
Subject: [PATCH v3 1/3] dt-bindings: net: ti,cc1352p7: Add
 bootloader-backdoor-gpios
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-beagleplay_fw_upgrade-v3-1-8f424a9de9f6@beagleboard.org>
References: <20240825-beagleplay_fw_upgrade-v3-0-8f424a9de9f6@beagleboard.org>
In-Reply-To: <20240825-beagleplay_fw_upgrade-v3-0-8f424a9de9f6@beagleboard.org>
To: lorforlinux@beagleboard.org, jkridner@beagleboard.org, 
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
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=GMfOVBjnJuIyDUwmWasZ6B3xnGuCFW07MH/nRO0xhUA=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmy2AQ2QBtHN5N93ah4bgfx1vdyCdBtkCC+s3tb
 u9GqnkyqcmJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZstgEAAKCRAFzvXHieVa
 dHc8D/93PwsuFi6L+Z/37jsgx7MhUtmNxp+24Wzk9vMkyykd5HReCsim7ISof3Kg6TBA77Ytp8z
 WGifo40UZ7NZ2oMdYizXh/zeVfPUQ9aqXEOCD8uMhb/KsQBeaiF14zqE0Ef5CSwEmW9ed+2zjCF
 sYoPm67yXMV2B472oR2DDUlHAKZmF5C+PuwX1OHa8lVxzn01xci2IDxgrLNKk4TV/exJjCmNUsX
 zvDMugn0FYID0rV7sE+Pgdrf7WkblXNA624ZzL3SlIj2pwVV6h4hEHEBiT6vF04SbhXrpZqaMV6
 tEwIQ8QQT1XjvMEtkmJMn2AWC7Yv4V3HH9ZjXlcIv3nHI7JmGVu36EBT2wn4mkp9MOeVe253QPc
 G+8YRqqoYNR067PQD7LZ6xJ2xmNtbLI/dgJK90/uBXeYS6cnjkHQt7TXzxbTmZ2C1z6Riq6JJnF
 FM+BW8BwyQzXwKMD9ZVIko3kmRmGOYTn+nS/ghK1+uxGiqLNXOkkAXuHA9PZ24chCfMI1RH4xF7
 zO28q4vrvMX3y94l6BKLKPyALVcG8IKP8yya1m64kYpDeKWrvclvi9j70I0MCEbCp1f7SPjLdkj
 oaL5ayWcLNJmlLaOcqE03yvyDJoDElOxk9Oyo71qSowojg5iYbAYTrXghsFhETMzLJ8tJm5WSQU
 U7t6YLDAYwcQhEg==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

bootloader-backdoor-gpio (along with reset-gpio) is used to enable
bootloader backdoor for flashing new firmware.

The pin and pin level to enable bootloader backdoor is configured using
the following CCFG variables in cc1352p7:
- SET_CCFG_BL_CONFIG_BL_PIN_NO
- SET_CCFG_BL_CONFIG_BL_LEVEL

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


