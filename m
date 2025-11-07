Return-Path: <netdev+bounces-236759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C5C3FB23
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E194B4F0E58
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA36324B10;
	Fri,  7 Nov 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezilsY/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B880322C81
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514262; cv=none; b=nm4vWtpa7JWNtYtL8O4FgyX8qBvgiMX4QoRPMTXxE5QPBKEwrQfqGiD6Ns9xCMQHqQlApJrlhHjLRK4VkQbdw5YJTa2pN+sxMjKo8GGEKlJll2uUPAzaIjen+WY3j9w61JazB8Xu8kD4Sa1GalxPy6dvIRX4OZJN8I9jPHZx2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514262; c=relaxed/simple;
	bh=/s3k3gaQa5vELRzkRL0kZbmW5//OLC8cCCrARdlhhI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSmV5oDNbUGO7dzmWkAXpByKOGiazFeNWlLWJVRb/cqxcN2Zj9stYzNaAHoaHYz1MUZ0BSJetXjST/OQLX62M9xULEAHD+M+9mfQURFjzZCRoYdtwSoGtLlqv7aAoy69jrwrU5rVgAkaoz+uFdUHHIxnU6YlrR159mTvGQ76Y0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezilsY/Q; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b553412a19bso361040a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762514260; x=1763119060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DZ/Hzt/Z4dyeSpA3JZAv4iA86Nxbb9HIqSS2XvFzQ8=;
        b=ezilsY/Qa3PiFl6X9LeVDH2A0a7gKBHbBqWs2cwo/aJ+cgr7wRiPQepenViWVBUEtk
         vjkmftqgYAgCuaY+EkhaBZ5ecBkbcrcQwq7hkCk7xkn+z2drBCXw5GQHEjCD6pmxxrvV
         zTdjM2Ybf6m2LxwalUHXdcvg0TPxSzlg8bi7LKDqxWqGpI4DvHHqWGcceRHwGzBIdcJo
         IMxwfFfhHQOJUnL8iVy3WLCsFafVTECyXxjUCrP2q0YXWP/kPd0HAB84lX9erwsXXj1U
         RJaUyDpl0E38VlrbWuhhlFzJxOBjoU+AzrN16J/AVf12tLi5Gr0BhH6QYRIbdtK/OXPx
         D7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514260; x=1763119060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DZ/Hzt/Z4dyeSpA3JZAv4iA86Nxbb9HIqSS2XvFzQ8=;
        b=YRCEkx6gR0cI0MKoxDkY96nOFcVsd9MyxKIcQg8upQ5RbDOE2dKzYG5nvP1KzUHhJd
         gnU+PcqJacQiZdVIX3kY6Rtct/t467j7NHlxUkiH2jMDdFZWyiCLA0/EEf2zPlb8XRCQ
         93ybzrR+1JyzIEdqJdFxk/9ecCeANquNePDWzAqLy7KHOjCLFBfafF2F+KGmC2EXM9nF
         YbdJjrhSGqMPG1GRpUJkQGPfL2dgrGrsf5OU3ocu/kuec7Af+BFRVkz1FFOwl6dpvY2e
         0HZxOZzPSStCaF34qH+it4qu44BpqYaTP0Q3srrDsSwi8p9nV8olKgavsqRnUcMC/wNh
         ZYpw==
X-Gm-Message-State: AOJu0YzJQGwg8KPbk3/wMaDgdrH6L4npOrEqXFfdW2CtRq9TqICPnDzm
	OZeXytaUamuc/89FqEU1+eW22r6Q5BJ3/Xzbcdw/BtG8WJsYswQsymgn
X-Gm-Gg: ASbGnct9mjGcwEXMyb6QMcMDFf3VEo51EMRWvGXFi1WC8pxDsIqmHcC/tSUoXDU6FVx
	s5MzCeK88lPwgpcTSGItXIGSaJ3NrwEGABJMfPpAMkiPwOnxwrRsANkWge+ZU/yeq8lbfAt/ROD
	HdCFCEsVhKFzd1UxcfffXrhsKdE2+MPWQcYNWvfkxGZfO1Kj1/eG2EfbGEp/d5RAqZGshntU5O8
	RxuLUMqUH/LzDdOGWaA30mYxxswB4fsydrEOKnQkkaC92JFBtUnIV/fXVgoOSUi0L+xRtFCRMah
	IFkgst7qyZgUGBg85K7ZfmmPnS6hDBDxWX/2ZAB/BtTCvsrssf4wxpzcrHsc8WUF1BXln1H39X8
	AJfgtP/itGTFxjrTbZh4qdiXlZ0RUr9NDnXY4hYRd7R5PCe93bR0b1p0l9nniDcsNQXE/6rqdAi
	c=
X-Google-Smtp-Source: AGHT+IHjf5f+YuLvxkmcrd3cJvkmjsyY1yheeW5iHSKdbzLJ/p2M1xTgPY5ean6VA+ewJk0yolgl8w==
X-Received: by 2002:a17:902:ec90:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-297c03b66b9mr44655785ad.11.1762514260220;
        Fri, 07 Nov 2025 03:17:40 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe3616fsm5131381a12.19.2025.11.07.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:17:39 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
Date: Fri,  7 Nov 2025 19:17:13 +0800
Message-ID: <20251107111715.3196746-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107111715.3196746-1-inochiama@gmail.com>
References: <20251107111715.3196746-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the ethernet controller of SG2044 and SG2042 only supports
RGMII phy. Add phy-mode property to restrict the value.

Also, since SG2042 has internal rx delay in its mac, make
only "rgmii-txid" and "rgmii-id" valid for phy-mode.

Fixes: e281c48a7336 ("dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042 dwmac")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
index ce21979a2d9a..ce6fc458be61 100644
--- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -70,6 +70,25 @@ required:
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sophgo,sg2042-dwmac
+    then:
+      properties:
+        phy-mode:
+          enum:
+            - rgmii-txid
+            - rgmii-id
+    else:
+      properties:
+        phy-mode:
+          enum:
+            - rgmii
+            - rgmii-rxid
+            - rgmii-txid
+            - rgmii-id
 
 unevaluatedProperties: false
 
-- 
2.51.2


