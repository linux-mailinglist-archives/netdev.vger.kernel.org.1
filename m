Return-Path: <netdev+bounces-167161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A327A39079
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E7518926D0
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D2A190068;
	Tue, 18 Feb 2025 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6zW4dXa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593418132A;
	Tue, 18 Feb 2025 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842639; cv=none; b=aIhEoC7n7n8jzEgZGIOohNvyRKeyNfO/RY6f9udBFNsFFwzTgSc6VZbrG1O4DwyJ+oU7ppxrdYS3HCJeSHkLHjo2n+gpW9rABfN5LY1iOW9Ygjdf9gXGSySpsDu9tWAck/ScpACA2GxfVu8Jojh04dKsOBYnmVJaf/7uUhsJgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842639; c=relaxed/simple;
	bh=Qi4otraQ/tzfmjMVkLSMqikA8FMNRlA3OcBbfwg+YYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb/r2hR44WSccsJReRVAue5noF29/p7xtG+wFruHLsiiz/uHn8ttv7upNGMkAD90ZnrALc8moQYp8KGtUgcTKivD3yhs6zin9LDxuASupkiGhE9S0lqk/+wQAHRuSA5K2/xpVqK3I/TimIN01kG0W9dF5svI08kIfJBiayZ/nMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6zW4dXa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220d132f16dso70245405ad.0;
        Mon, 17 Feb 2025 17:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739842638; x=1740447438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnT/e6F6Fi0LyXX+Ihgia8DQKf8/6Rddg8YXuUwcV6w=;
        b=f6zW4dXaaM+oOX+s0QmnjxnHnyRTKfTmyTrZOpSalV0u6Ar4XHaYcK8XKW3uZnEZx1
         29mR/NQECINqRyB6bdvAfvjg57/Xi49BaGikmun+MwXidDbuy0Rsx7zSw+l8s5vagOO7
         MAV1k07Vd5AgXjO+Pl8HKJRGl0M7hu8ek6sHlYOS5j4mOsrQFQ64YVbWgtH3iGV/pC1s
         i1+rTM2IUij6e3OUeYyXnTG5v+Q5ySQoBNUlDxsIdFi4wwWAq0xuCzsh6ww6QslPPxC+
         HsnuiH4H93l+rYT8LghmST+nNtGHmDqD/RXQO9CaXp3ylcTQaR0oLND7+ahppljksUz6
         Ksmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842638; x=1740447438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnT/e6F6Fi0LyXX+Ihgia8DQKf8/6Rddg8YXuUwcV6w=;
        b=qKwcl9JHfcluEB9J3plMmabUIsVZfuNogpgMz84lOiZbQvB5fdW7zB1/rwxY1+mnMV
         qyUYM5yPHtbqVaL5GUJ6zB28qwmRABmlfaAcue4qjPXC4FFdd3PiW+G2QZR+UiNL74lu
         Eyrart+pRGVuRLSUE2HV3XIdLxx6weTH786hVoNBlhqZ9okIP/6T0yT8Ua/BL/tAMjQ8
         HzwTYyopzJ/K7gAXOjpbpLLuhyW4LVUdXfFEGBw2C4FaunJ3q0ALhtEYBs2355yr9NGL
         JsQauSW5TGw8Z8aDf5az0Jj/XhT7QqvI7EK4dJn3eADFPlno7OZMTalwDUHnlwD9EBNw
         zh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsNnBcvHM6NH9uopIn8hvwELuXBgmnl6TGk6VQpq5iuh7+tNrrh5uUQXd0JJx6XPzmTzz5xCGjLuBE@vger.kernel.org, AJvYcCVp9WOeIqjAE3OLQe9RRHczEN7+sd4WSJieMDCDohJJk5uVbKcdlkfbO/YZo40suRlqyoFfnTuQ@vger.kernel.org, AJvYcCWBs1bHvY67iZQmJR3YkppnSqLYUhtGwQ7APZ2iyw/yP1J5p4ccHVn7Vr6jCpNTKRVyd5vSD4JtMTQ6wQUY@vger.kernel.org
X-Gm-Message-State: AOJu0YxJhhqZo9ANGVNAmMmJoglH/385lIn/MzeG0EoCEC5ETOBm/7Dc
	T3X4wAMK3qqg5k27jIvp4LAhOidlbZj9qMlyhqrM5C0fm1wWMjH/
X-Gm-Gg: ASbGncs4zGJv+GBQNsxvXe/eevD7gaaqy2g23454UPJu/UR4BtgRZlmQ1Ff66vaXGCU
	6VOgmzNTEgFT2R0zydXGARj+ckx39If8XtXqf21jXDZ7Spp9GyEXGTKakgcheT8XFWy+vNyxtxA
	JiyeAT9oINqSsGbmCM1TUnMsjthCnRyZ7IG1h5p21jRdPDCEnDiyRLm0SAOMHrPlDh31OqW+UfK
	7ospqhqBX6GDNDmt0yKsJuFTtCS26YO4FyC541ZlOY1NtMPA6HIf7mnKpY0205UL5m25wGzHw4c
	0E46U/nKUi2pFAUSerJitZyepB7pRmFcGw==
X-Google-Smtp-Source: AGHT+IFDu4hYdotyyziohrCdHf9suBIFyx+bvqhDmBKsMwrc2z6aM7HNvbrEUdFJLhy5MdcxD12ltA==
X-Received: by 2002:a17:902:e54a:b0:220:da88:2009 with SMTP id d9443c01a7336-221040c1b01mr176388335ad.45.1739842637719;
        Mon, 17 Feb 2025 17:37:17 -0800 (PST)
Received: from localhost.localdomain ([64.114.251.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d4d8sm76910165ad.170.2025.02.17.17.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:37:17 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 4/5] dt-bindings: mfd: brcm: add brcm,bcm63268-gphy-ctrl compatible
Date: Mon, 17 Feb 2025 17:36:43 -0800
Message-ID: <20250218013653.229234-5-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218013653.229234-1-kylehendrydev@gmail.com>
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BCM63268 GPHY control register compatible.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4d67ff26d445..1d4c66014340 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -54,6 +54,7 @@ select:
           - atmel,sama5d4-sfrbu
           - axis,artpec6-syscon
           - brcm,cru-clkset
+          - brcm,bcm63268-gphy-ctrl
           - brcm,sr-cdru
           - brcm,sr-mhb
           - cirrus,ep7209-syscon1
@@ -153,6 +154,7 @@ properties:
           - atmel,sama5d4-sfrbu
           - axis,artpec6-syscon
           - brcm,cru-clkset
+          - brcm,bcm63268-gphy-ctrl
           - brcm,sr-cdru
           - brcm,sr-mhb
           - cirrus,ep7209-syscon1
-- 
2.43.0


