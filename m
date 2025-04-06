Return-Path: <netdev+bounces-179490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3FAA7D108
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15E5188E20A
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764FC2236FA;
	Sun,  6 Apr 2025 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnRi0EyL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97157223308;
	Sun,  6 Apr 2025 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977714; cv=none; b=VBXCtMRFpKQE6mPd3Uqgq0yDfer7If0rPwH/VquwRGOScQtVaqQjr85QkfNkAO7ZQeO7RlU61HX+UtTZas+i88/rccxF87ZndwCzQrnujTgLFEYW/RsgVeL3Gbo8plsM0bSkKmR4LW0/NYoTaBu3BFXyUDVcT6UNX5g+8ScDrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977714; c=relaxed/simple;
	bh=9mR4C4XWDUIFEuiuVNK+8HBz2gGD4Ctdk8J+leH+h9s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXnut7bPWQce0N9pESxpPXplph5urj7IylH3NcSjHxcJ10qY1CXMqNEUtn4LnTsM0ZHcTIXHRTsvZ4l52ifuZ+lQ36x8yBhtfWfd3u+OEox5SrMuWva0BaoWdUwqLMaa+QHAElCtWbdMDN613ArTAHt/XQ2vM/yrksedpcKpFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnRi0EyL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso25945415e9.2;
        Sun, 06 Apr 2025 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977711; x=1744582511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm/ZIdkSaGh1P4y2c0zDVUpHmGlbMlKT0SYr00OWyVM=;
        b=fnRi0EyLOBp/Iw6mnbIYDBBJyhy9WarpfFJk2w1jV+QZ0LtW6lnfITtHIfrRYdvuFa
         Lyso0CR53rzU0nIhHKYd1aig/7va4rzY8jWjpd2ntxtqQtUSM4DZNvpkP5UcNLhBgC2C
         HGeAoHH5XfXobYb40J5CuhY8P1nOGnIROncRvxOsljgQof65kP1uR2W/B1NwDy5BdLdt
         6uxfiOppY2A7dxfGjit8+ECWCJuKM+aTOZ8JtwLWx1hta8TwA+FJ19posfOZLLxuIs6T
         Huz+KtO1qtmpKUNpmQrmLhZO6m1d9dJEAtVhswsX5/x9m7Cz8dkWrINAtQWrbdX3oI4D
         F01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977711; x=1744582511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm/ZIdkSaGh1P4y2c0zDVUpHmGlbMlKT0SYr00OWyVM=;
        b=jjxAjJhlbkkRQUKSBA41c6j6/VbDvqL/iHLZ/OIabEDJwTX2hw3aajDvLa+W33rLCv
         z5NL+yd60X4Kd/stQBvDbcv198iaJLF9cWSillMJTx03F3E3KB4NLwanr3jmT6t/UwQc
         O1MWVMcyDEXFyLZ9VhVFetuCZQwFqB8VP3HfCRfJJ163BLx/fo5UTm4X/l3irLGGlnVk
         SNJo3XgX7+NU1ykPBn8ZrTFvkcLIwHkdwV6gcNt8WJz8QTkuPcvnjAMv04pvSAdnYxT7
         JJdm7bXP2rKId6i/sQu4CAv1bnTHeO1QQUOP4YF0X/3vsvOYuCnZcP13QP/KyYZntDLY
         nTEA==
X-Forwarded-Encrypted: i=1; AJvYcCUmql67k263Hb7/z4pDadp8kthwGp8v1yC2EVfEwifKNUPQ+bFW8CstQNDb2iQJ3IWOlEgEemCn@vger.kernel.org, AJvYcCVy4VoVCluicN2S5S+VvCOBeW7GGmvtjvEtaL6MOT/9iDG+eQNF2kMOdhe2c78dm7wYUfUw3YzLuyBucMn7@vger.kernel.org, AJvYcCXblS1KSxhiXBuSZ9EpeqOeYXmGT63C/lZE2Iw4RpJnxBntYjE2TLTENCSrcaq6BJN1gOszbuiD+Jtl@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZDBFM1dkrmE5xA1YUdMxNtxASbSnhClh+HuuGLTYSr62SB4Z
	L/hd55PdZcL0QdRdwxVUy6R2c8ZWswIB5+zqNFQWu0JY9yB1dXKRKXSc6A==
X-Gm-Gg: ASbGncvhEFTT8oFNPov5ysSUQ4fHMZX/IC6Xry/+iyA3PzaCs55oI3R1Apxb6AVK3t1
	aj6XSAPBkFHbrjIu8UgxrhhdoHZ0G8TmnS1fM9LvxdXXnMskUVUBtT0tQcQ67dETZ6InBFALaF4
	BdUiIFvtAwRmwAlmhWANxWVX++wUiT5lf9pITw3tR3NA/IwEepjTIOjc4lc+zmdFcyglfXsO1N0
	AsCm8LrrZISmckLwVm6Iiy58zAJt7Vz2yLgk+cLslWiElbfZiRwibh+pj38FmMmXxdm+UHjQMgd
	2h+3vEfEXYTGAoPreb89L18hIBVWtbaIiAHSy2OpWe617FcHIEzuH8mhgOeUi0w1SSgcapfmZHQ
	ove51HVKBoNtKgg==
X-Google-Smtp-Source: AGHT+IHxaGvWEB3NGSJbMPNiv9bPepD1ALCIv/tPzMQD98V+RZ+Iyvgwi83L4i5nUBXgE8BY0b3p2A==
X-Received: by 2002:a05:600c:500c:b0:43d:bb9:ad00 with SMTP id 5b1f17b1804b1-43ecf8cf6b2mr116582275e9.15.1743977710829;
        Sun, 06 Apr 2025 15:15:10 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:09 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 08/11] dt-bindings: net: ethernet-controller: permit to define multiple PCS
Date: Mon,  7 Apr 2025 00:14:01 +0200
Message-ID: <20250406221423.9723-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the limitation of a single PCS in pcs-handle property. Multiple PCS
can be defined for an ethrnet-controller node to support various PHY
interface mode type.

It's very common for SoCs to have a dedicated PCS for SGMII mode and one
for USXGMII mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
(for Rob, I didn't ignore the comments, just want to
 make sure the driver side is done, please ignore)

 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 45819b235800..a260ab8e056e 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -110,8 +110,6 @@ properties:
 
   pcs-handle:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      maxItems: 1
     description:
       Specifies a reference to a node representing a PCS PHY device on a MDIO
       bus to link with an external PHY (phy-handle) if exists.
-- 
2.48.1


