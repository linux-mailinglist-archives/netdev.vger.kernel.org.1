Return-Path: <netdev+bounces-175956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11DAA68102
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBE919C7B89
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79E214233;
	Tue, 18 Mar 2025 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9/ExYKN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9345212F98;
	Tue, 18 Mar 2025 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342376; cv=none; b=SI0ChMDBcuk29CokwSJoHgmNnkAksGgiN5PyYVtQbY6mR9xiWw8d+XvukE39DPREXXtZQey1rSoP+iy7yUeMpaUJOIbjP3wJVqkcMtVEQ7Wt3nYn2qi1c/j7uJdhCHveb19F7Ulb9PHlwc1LoA/t8N2R3y5wA7U7Qy1IMRnASjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342376; c=relaxed/simple;
	bh=JrUHA9FpyCx4DvvaC69xCjH0gw4/2gWMhta4nhQFkZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4QEHOygYq83hTNXi8iBIP75COJbisqJNRfDn8JZfgo9bVYF9hWNVvST/lp+gFNN3AFIrINAnfHc1QGPs5IchRnzKm9p914NLSlhiBPA7lK08WT6o+gPZ+ewe2Gpi5bo4HIeTSxDwwd96B191z/S8hlLsjt0xmtGc7FDoQM1nm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9/ExYKN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf257158fso26341405e9.2;
        Tue, 18 Mar 2025 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742342373; x=1742947173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/5iYgZbCUJsXiO7D38VJCrRh0YKXMu8sk/DBCkW7ic=;
        b=k9/ExYKN5QQpnlwA+Mll3lgCPssOArzK3g8Pf3kphz5XiExtuuPJ0Rx+d3U0w+07y+
         ZnO/0mLH+Y0QZ1NYMevilLj588fLe/eGTnoCQ8bJ+Kob/qW29NWGSeC+DD+r2sZgy4fZ
         p5IM9SlHMjhIbCBxaMmWZwMpJQXiaqWTRf9l6vcjE1GZE0yacyKWL/UOq9Bky/f0DE8I
         zU63+SPiK6ubOuUfvD4Nuvnkp7BrKe9p1Qp+tQy2sJnRhLzWTdYkDBKwd3DoBdhoSf5s
         OU2CTKIquGwKyeoowx6fKaOFKvEh6lmYFjGNdj1t1S/4WFOk092hJX9sM2zjaXbMv6Fe
         LSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342373; x=1742947173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/5iYgZbCUJsXiO7D38VJCrRh0YKXMu8sk/DBCkW7ic=;
        b=shsLjEKNlvQgSA1yi8VVOctslNavw4bsO0OLYo5s6cjR6quzozpgp4/3UjW5l/O1EF
         zXqFmnXoBVVFQjZSgEm7bGpPixhmA6VjJOK89zJ/9S3PvnVWPc0gqEWRTGkSRRZDQnJN
         cH79gbkQVG79NKoULN8ZVuFFFOakBJJYKIsmbYjuX9E97TZOCQ+c0IoW9LG5g1hZzR2I
         6M0aPc82eiTH9fXhqa/vSxkR2TS9fJjsNSZ/t9l1cKynN0vaD7zYSsXyVi9dHKQCHMhG
         V7STdbuzXHfamcMzETpUpmKnljJbVv2yMBs0gmzpOSyw3tlgS0E1H6zxR7EfvEc04Xwz
         kaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjVOYLyBHkRpQJ3EKivg1RdoryOs+uPec3WxhpmsgCHa4wWKBywY43rdJasYCrUV9OdAN57ask@vger.kernel.org, AJvYcCWJnZ3vmsNLu/CKBqhMHPOm2OR2RnjMUf3wQZwYPOHnJu6q3dgGyOAThFL5AVkM8cA4ZwsF6VN22um7@vger.kernel.org, AJvYcCWO0W3Uezi3tSK4WuDXJJ0sMoUhM6riu8SviwO9SUgV6X3DQwjOmPa9JR04CRwcJVPeSWnCBW4zRZ27hjRE@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4DNfi4aLp2KRA+MjkF0V3JQwUF4EQUVPG7+ZzQh0zSMt7g/b
	hBDqbbzbFA7j/JM/JlLl6jxqsK+/WdamNX81SGq949otKwE0kI9x
X-Gm-Gg: ASbGncuEAxyYhFHRHzaHb1EsFUtlMyZBAKUOhyA7Vad39jQNVRqd8Qa+s5dgYhJisdj
	CYTatI3RItw0Of77O2b5tjVEP6X5KLjYSOQcsxQ07BqEmOHguDI/V1VeQqqbAA/WB4qGQ1x2vWB
	aM7o2dsyAPJbxocAVX2MkIpCUkWMun+y/2gWBPtPOL17ewwpAY2YryMEheOcHTxc8ibf3XOCxG3
	s+DkPdIckL24bb9lyHtVa03rMpFveqKhB7ZaCdKnAeZ5d90AOQRhdREbblmo68DMkkAQ+Z43WZF
	jQm/3mLuZ29v7Z7ZN95ipKvgZrnZnluRcNxy5e1B+qEYXfPP/nBwqZN2wAkyc+RyljnZII4t0zp
	aKCzEUbGV5o0HoQ==
X-Google-Smtp-Source: AGHT+IHrUSW7kZea5qNUZamEroXL3N7I9riIWyNVShpuuVCd9aDBwNYHeRAO22OFdLWg0+M39Je/vA==
X-Received: by 2002:a05:600c:b9b:b0:43b:cd0d:9466 with SMTP id 5b1f17b1804b1-43d4378cf45mr3381605e9.9.1742342372613;
        Tue, 18 Mar 2025 16:59:32 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c83b748bsm19713268f8f.39.2025.03.18.16.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:59:32 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH 4/6] dt-bindings: net: ethernet-controller: permit to define multiple PCS
Date: Wed, 19 Mar 2025 00:58:40 +0100
Message-ID: <20250318235850.6411-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318235850.6411-1-ansuelsmth@gmail.com>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
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


