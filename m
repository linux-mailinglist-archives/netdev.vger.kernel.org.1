Return-Path: <netdev+bounces-114662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C519435E6
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A555228573E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E901607B6;
	Wed, 31 Jul 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="jbm2ct1l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E904879B
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451998; cv=none; b=Xow+LlJduK6R4sGFgtjlTwYN1rNML9LbC3FyUytG7nbbhLLMHgS4tp7CJVrMB9AOmdfb52LO1Y/Jj5ABSvyaarOxhTQ9BS9jO/n0uweajpsoiYa/R+r2lYbegM0koDiRZXHzpj2bz34rkkbAD7zhm2RwcDw8TLbvmSESzRhm68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451998; c=relaxed/simple;
	bh=XHqJU4/T7F12L5POtvVe0Q4zmll9qWWprpMTXEoqi+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EtOGlvoATaYFQBm6nmUSqj9zIc7wBktL8M3B1uBU5tuhN80Z+PN2x8BuBQ3XqqdC7B+jhYTAQBMmVJE7uc7r3obSz54+6H4iw04wp7va2aOyWk6jNRRYnAthR+2bLmq4+Vo/9ORSRgQkLYr3NKTXEgThfh1dhCo9/Ts5vZ83QAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=jbm2ct1l; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc71a8a340so2632395ad.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1722451995; x=1723056795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojT/JLCa93OROa435ly8/9yf/IKMKJjKV66nK3VNbzc=;
        b=jbm2ct1leVBm73w9vSB26SEqkhYTQsB1RWGQrXDRj2QOHrFR3FaLURr0GM54AbBtog
         dzCOjJY/Q7z5y/880/1sLxFooVSJQISt5DAGTRdId3CYd8FhLXK/M6sW70Kdp5j8w226
         q312KZfS45Me+eU5L5CNBS7wnXoJ6XXKWFyUgY4RtEjYnjDJvN66GvXHILct7NjVWp50
         xaJCie59ppmqcjB87uIQ2N5M1V4nQCyh7ToZYLsU1ad5zmuk8bovRxJnVndeEymVwc2L
         K2cr0K4ruFkcDxNbxKc88DvkkxzIQcrtyS8BtV4JGLYQ8xBUn/kDvcQetunJ4WY264El
         8jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722451995; x=1723056795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojT/JLCa93OROa435ly8/9yf/IKMKJjKV66nK3VNbzc=;
        b=g1T7g/UQoj8NV/pXHFQfiZqIRqQ1DIWo4cL484+xpsznhxtjHhGvlKkwZ+Ya2A0H8b
         2wqy52p99DUExAfAbm55ykxU79WyopgxOeY34pP9mg8f55rs3Pjgmci83OgggK05ap7t
         Zo9NXBd5m+l3rocFIBJ/8z//Z+iRR8rwk2/1goiv4YqhAQcVzf+bZXHmLFaVHIBcbyFt
         LTGp7BTZe4Pa1wgK2CYd7pYaU3avlAqcG0ft86hgSdJaD1pgT8C+5iQasse6qhWJ6oca
         oYqtUV1ZamvsDXETeh6diR4UmZQS21gNvTCdePbQttcoYv4tG8BR5kgjfbO15VaE8eN9
         j/lA==
X-Forwarded-Encrypted: i=1; AJvYcCW777v6VC1kP5ymmor1vruqpY5LgGD7w6K7uPNpZ+UVgr+MPCiQMgn9o4SSiIBBU0el2DrYrliNPcxcXQpPpmwmlr6HQu2t
X-Gm-Message-State: AOJu0Yzkuyicfpdd9TI7ob5suBXACnokLvgqxp2zHym828bHyAyuj1Fn
	YQdym4+LIwMaTQpP89lXtyufDZvKWWZOJ04uXnYrgZ1EbxVjrwli6iM+OhEZMzGxKqQ39IseO2I
	=
X-Google-Smtp-Source: AGHT+IHdD6Lu2yTxVi0/pR+KxWdAvB7471oytstPn7Ep06dyWyYC7FdxtYjBH0hrSEJ/lCHbOD3o+g==
X-Received: by 2002:a17:902:d507:b0:1fc:5377:35ac with SMTP id d9443c01a7336-1ff4d27c1ccmr1480985ad.10.1722451995611;
        Wed, 31 Jul 2024 11:53:15 -0700 (PDT)
Received: from [172.16.118.4] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff3d64sm123182825ad.299.2024.07.31.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:53:15 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Thu, 01 Aug 2024 00:21:05 +0530
Subject: [PATCH v2 1/3] dt-bindings: net: ti,cc1352p7: Add
 bootloader-backdoor-gpios
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-beagleplay_fw_upgrade-v2-1-e36928b792db@beagleboard.org>
References: <20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org>
In-Reply-To: <20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org>
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
 h=from:subject:message-id; bh=XHqJU4/T7F12L5POtvVe0Q4zmll9qWWprpMTXEoqi+k=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmqogPQ0J/TODCghlK+Gt4hhKjYxhh2Cr6l7ces
 FW/VbMBS8mJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZqqIDwAKCRAFzvXHieVa
 dDgoD/wLkKv4S7Es1rK82+/4QnDQYJc7qcpNhWECyHjCljbCMyaa4WnDa3OakUCJShWbwwy+Ael
 yC5w9+vVDuyWoYRBF7Q2t6Zk5wW5admxnuvGr+5iwrrmtewNxscAyiSdk+3z86dJ7ZT9ykh3jdX
 ubTwC5yWlPPB6sE8skPc8hx3h52CbTH/dyyqSmw5TQ8k1CcyA3zCFtm2BKcrqGfLgORI5iB/N2g
 wUYkccWg4APMnzXYFIbTwGSD+sTTo7QKTJ+PUf3kAgGfcKKcmDUY82p+MU+cnefFKLRXFocANtW
 uXrOeH+zufLwS84w8qtx7M+vw76ZQzA/uSUoLgdxcxXGkJln+6KnSc/WbST9hbX6/te5+KLnLeN
 zKJjmcbNjXY8UYeSGdmO4BeduMefXidaz4NTILD9YrY545m9incW7OgzOATss3A7GmXSGp6z6+0
 yHxsC3a4HZQy6v+FHJtTf1asuWeTefsQibTluZSS+FbNNzW0wvLpHXF63glW43LZ5cfXS8mf8OD
 hNf0i981p7jXn8VgXW3616o8r1Uw2q0MIqNRNcZ8p8kIJuApNxK3oHnmz5Tu7oXr8LcMmXnNZOX
 nthCn7gtjNrGjV8plupFsvE4+VCVK7TjPvDlYb0O+jcv4ccVuqKRp4Hbhq0SZwIrfJZTwm8pFuy
 MupaODO95S+NofQ==
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
2.45.2


