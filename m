Return-Path: <netdev+bounces-117520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB9F94E292
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 20:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793941F216CC
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBB516132B;
	Sun, 11 Aug 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1LRwyq3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4115C129
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723400247; cv=none; b=a8IORMa6KBSMEHvBPBSgIfTR5ck3RkaHhAbTPV9QO52hWKn7X7DM6IayYyoywxWtQFuiEgZx8ulhVInALC1KztfO/0sNVQ4EOEc0hJS4x6JGdJVAnUSCyJBLAujb0UUmgxOC83l3BSpz8s27B9fDpjpD600nZ4IzBf5j7T5sbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723400247; c=relaxed/simple;
	bh=Shykp2EypMXZ/QCtrfeiM+kDiKjZCEK90ANRVRIkFao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTmCYNr36mJ8FRHVJgRqXr8kKrlErxlB2SswwmbjA7W+RKV/JVnvODfYq3nH4Rjf+sWcaZTHDNPBUT3SHOvCclD/WDs3q/BJTta7CNfWN8aLU894mX42RPAbb/uJnXX5cHKeN+NTA2nmYMVjq0SHaSbP2ukw4zCHKG7dVeSMvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e1LRwyq3; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52fc4388a64so5055769e87.1
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723400244; x=1724005044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGFhjis3vEwUW+zmFS0SHZDoiWLXNXD1jilEiEFaOug=;
        b=e1LRwyq3DdFgc5rpz9eUvjayBSr85gM/ffkyrlPgYDyYB1iaknuUUx/rke3JKqFb0l
         /qv1J/QEHBiJeaLteE4vCX7mbKspenYCZGr0h+UwmEnlPM5e86O/b+kJtkII+mXJM1Vd
         xROHhfYUQs+NncGGWwutO46KPUXR/kZtTH2od+gOC0oCzDNhRed7agoW/kKeRjJ6Bt87
         DF+swzLQ7M9JxMgc0f2h07IPVrm1GBbtUU39L9aNUGqvn4va7d1aiMxd7XK7QJ/hBvQ5
         mvY2U15IPHEEzrNI8vMTblw41i8AaiIUYsW7KV1YNE7WZDe1g9tCGV18VnJ4Rl+BjuZU
         AAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723400244; x=1724005044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGFhjis3vEwUW+zmFS0SHZDoiWLXNXD1jilEiEFaOug=;
        b=ArcWDxw9CWMCqw98oWTQ/8Xn3VlmWx8fk2jxcxC7ylZHFd977zbHBl208lzcq1T+GD
         j4ZnPP4nD16V632gET7UthErlLAQb9wXPwV8HPx+ULfBzaDBIX12zRr+SCJmWzsh5nwi
         gyRoSFW1WY6X/PHKrgZ2927/FtGxNl1qM3/RPZBDNLeSP3tukp1VEpTCYlmnXoMJY80F
         ZTrbHMopr+w+gX54JseE3uiFDxGXtq5BhlIYeEzzlt7HGavpW2xhDEnX9vIV926KiOl9
         meCIbIoTjThc/94YurBOYs85XiOSJ7auFVB2FnjyMCGlnQahTvSgJ/vP+1z/O+UcLQr9
         aYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvOmd9mDBNuHYcgFYdF/Q4fOQVaF/yCXHfufMuJSDYhp2haPOZ+s5L6OH1xB/etrzekmT88HQaPZXUGT0rMp/N32+h5cy/
X-Gm-Message-State: AOJu0YzkQPCoXG5eRkNiljtccd1vmtzvsr2dTpqBt4BkYqJ9WXrDDJPA
	p6G6KUyv27DKdTCR78Hsah7IAohmEj6LDjMu2QVMK7UfPA56oX8X1z1NqYMz/BI=
X-Google-Smtp-Source: AGHT+IF1UTHAP/uCXS+U0LCWoWj6La4p0Jxj1fGCJBYGFjAqz1RV8j1pRFl9F80FQYyJE89hUneeuw==
X-Received: by 2002:a05:6512:3ca4:b0:52c:d905:9645 with SMTP id 2adb3069b0e04-530ee998c1fmr5849572e87.13.1723400243767;
        Sun, 11 Aug 2024 11:17:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a6032c1sm1610593a12.92.2024.08.11.11.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 11:17:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 11 Aug 2024 20:17:06 +0200
Subject: [PATCH 3/6] dt-bindings: bluetooth: move Bluetooth bindings to
 dedicated directory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-dt-bindings-serial-peripheral-props-v1-3-1dba258b7492@linaro.org>
References: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
In-Reply-To: <20240811-dt-bindings-serial-peripheral-props-v1-0-1dba258b7492@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Daniel Kaehn <kaehndan@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5616;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Shykp2EypMXZ/QCtrfeiM+kDiKjZCEK90ANRVRIkFao=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmuQAogwO47g5/difzXmXbrkByuY1vS2kO0De2e
 ZKPfbrsPguJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZrkAKAAKCRDBN2bmhouD
 147TD/474Iq37wLRBRyecqclhH0wNzPuifYqBgjZqQHezZmQbpXVDVK1vf0+LCfc/ZtyCR/Sv4m
 jltJ2V8uBF3IPaQHcicV8n9tMtUWybfMJjDr6tnbBhpNS+X2Aa87SO75vBBtCnrSVTfkXK0o8YX
 RSKBy6GOo67UIzbasCmS+HYdpr9ERwy7K+3TNHSmhLRCLRBfVrDMG2w9u4Y7LvIxIgCAiaNOpFP
 o1in1Juq7JrW3qkKdH3xV+H+b72v5vAb6nWM1uVVeSrA2nWNeVrAvV2ckQa6FtHqozXL3RiTV5k
 aKMfLyL0DOT23SbOPUVV7GLTy/B1lKShYkUl4EdD1n49w1IWbKVaCXtDj173oDwdXe+LxVplYGf
 kDZ7F3DsQeriuNXM3nndbXGinKgjOnJWZnp3mQtog++T8upjSSWQP7I0PRhbV1SXYqN1THYDy3G
 vTspwv7Ox5oIvZ9wQiNf1+7xnB9PlIIo4JbdIo7qSyS8XnTcMrS8KmdB0YZGhR7rHeUrx7S4q9f
 8uVqhBw7RiLUJKjSESXgCS2KLsoQ6KkMHJF0zxjO7oq0N4WyW/awYsXliZazsBLE+ofM2uoB3tq
 G9hVXGUpr8+1AFc4Hzv7DzCM93Dbm7GEJ7FxjCjUF480EyBRObg3LOB12RcecvO90dzdJeG0OhG
 kbLDwaE43Filc8w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Some Bluetooth devices bindings are in net/ and some are in
net/bluetooth/, so bring some consistency by putting everything in
net/bluetooth.  Rename few bindings to match preferred naming
style: "vendor,device".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This patch should probably go via Rob's Devicetree tree.
This is the dependency for another Bluetooth patch.
---
 .../net/{broadcom-bluetooth.yaml => bluetooth/brcm,bluetooth.yaml}      | 2 +-
 .../net/{marvell-bluetooth.yaml => bluetooth/marvell,88w8897.yaml}      | 2 +-
 .../net/{mediatek-bluetooth.txt => bluetooth/mediatek,bluetooth.txt}    | 0
 .../net/{nokia-bluetooth.txt => bluetooth/nokia,h4p-bluetooth.txt}      | 0
 .../net/{realtek-bluetooth.yaml => bluetooth/realtek,bluetooth.yaml}    | 2 +-
 Documentation/devicetree/bindings/net/{ => bluetooth}/ti,bluetooth.yaml | 2 +-
 MAINTAINERS                                                             | 2 +-
 7 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
rename to Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
index 4a1bfc2b3584..e49e4146736f 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/net/broadcom-bluetooth.yaml#
+$id: http://devicetree.org/schemas/net/bluetooth/brcm,bluetooth.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Broadcom Bluetooth Chips
diff --git a/Documentation/devicetree/bindings/net/marvell-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/marvell,88w8897.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/net/marvell-bluetooth.yaml
rename to Documentation/devicetree/bindings/net/bluetooth/marvell,88w8897.yaml
index 188a42ca6ceb..60b90cd62013 100644
--- a/Documentation/devicetree/bindings/net/marvell-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/marvell,88w8897.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/net/marvell-bluetooth.yaml#
+$id: http://devicetree.org/schemas/net/bluetooth/marvell,88w8897.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Marvell Bluetooth chips
diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/bluetooth/mediatek,bluetooth.txt
similarity index 100%
rename from Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
rename to Documentation/devicetree/bindings/net/bluetooth/mediatek,bluetooth.txt
diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt b/Documentation/devicetree/bindings/net/bluetooth/nokia,h4p-bluetooth.txt
similarity index 100%
rename from Documentation/devicetree/bindings/net/nokia-bluetooth.txt
rename to Documentation/devicetree/bindings/net/bluetooth/nokia,h4p-bluetooth.txt
diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/realtek,bluetooth.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
rename to Documentation/devicetree/bindings/net/bluetooth/realtek,bluetooth.yaml
index 043e118c605c..993c607eaa49 100644
--- a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/realtek,bluetooth.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#
+$id: http://devicetree.org/schemas/net/bluetooth/realtek,bluetooth.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS Bluetooth
diff --git a/Documentation/devicetree/bindings/net/ti,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/ti,bluetooth.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/net/ti,bluetooth.yaml
rename to Documentation/devicetree/bindings/net/bluetooth/ti,bluetooth.yaml
index 81616f9fb493..1f507ddccc3c 100644
--- a/Documentation/devicetree/bindings/net/ti,bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/ti,bluetooth.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/net/ti,bluetooth.yaml#
+$id: http://devicetree.org/schemas/net/bluetooth/ti,bluetooth.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments Bluetooth Chips
diff --git a/MAINTAINERS b/MAINTAINERS
index 494bcb5e6f35..ae9a81df25ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14269,8 +14269,8 @@ M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-bluetooth@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/mediatek,bluetooth.txt
 F:	Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
-F:	Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 F:	drivers/bluetooth/btmtkuart.c
 
 MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS

-- 
2.43.0


