Return-Path: <netdev+bounces-201438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F8AE9764
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A6617D302
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2525260574;
	Thu, 26 Jun 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6/PNaPf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B625BEEC;
	Thu, 26 Jun 2025 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924884; cv=none; b=jed877sv74iGniGQWn95vQyQjTtfmIscxwRTjQbfOhNrwBU03qU2H61whGFQNSTlwPKa+cDOtsjAT1PwWhwP3DklfZ220z3dcC6wp/hZeOrluyQMx98fSvpgdZibTOZsK2rzP0VXiwOtRQdNKssvwaHwSReOZYh3jMx0uvztmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924884; c=relaxed/simple;
	bh=Hq80mkzOm4sDH1lo61LQlZ+WhvZpGs/2+0D69YVEncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro3R6v39sIF+IX5QCwlStOc/SfkzJ/DeLdl9IxAbA3KttzWraa9OQFWqM1nbRcbt/pB1tlPKnM3tsUoJPekvdKUoiI5nA+ZnRAmUhLgxYJyZrGWOprYEUZqAHiKqXvZMRBVikABfsh4v/T7ix6iYcmBENXapL5P1K09srLJog4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6/PNaPf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b9dfb842so7216105ad.1;
        Thu, 26 Jun 2025 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750924883; x=1751529683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnJ5HyRFTLzSb90lPZ0kytxtuJ4Ps5kIpRokWvdn6qw=;
        b=c6/PNaPfKI/QcO223m05Msok8wJhB7/39HoDUczqjtJ+ZkeYLrMuxZKEByRx/GJ4S7
         uDo+1hvoCbRYJOoyZ+9iI9p9/EK67vf4gLgfZUXaJSoeaNWgr4VH/3Hcr/DVlxq8sxDQ
         pIT7MBfCK40w28Z5WRosWi7Kvwc+L2cIiAmF02iZ+tSvP7w7jjx3JgE49DBeA4P5qD2F
         xg+0KYDhLhv3Jzf7QYJxB6BUMMBDfn9cBrdp6zkv3hQTmq8puGRFpmuq/tNBRRAJPfVk
         2AbM6m6UbuboQy6u/AT/UYULJqC/WJX6chfMixSxa/Mhag90iRZ7HFug97l5DKqhFbdk
         YKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750924883; x=1751529683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnJ5HyRFTLzSb90lPZ0kytxtuJ4Ps5kIpRokWvdn6qw=;
        b=ocyIPwrriOWGMfQ8bL9MSRTaIyW7VWS9K82NkFhtYjbsmvske/YqtvTdastsAFHlx4
         v9Nu9kqRk6JWxleK0gjuXGSeR5Xv/PsXS4BXf/EChOuYd27kGFWrSSq2KA7YXOx8+eBd
         P4YnglUebbKy6NaGn+vraAIL5o49BAefeDs/eVbH1ZUF6T05CKWY7+vMCBLZrOKbUEWc
         4cHj8TRd1xx5IO9MoM+nOsKkxJi8+ma+IgYfXmDJNdfWEH9YxgHfsI+m2S0O7W/x4aft
         FA5dBoVb1PeBGsHM/DUvUC1pxmgj81feWZlcxkRfqfAF71EPsh69W9HmKLPwGjy55FbK
         C+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUSzVbE/h95LdZd0NRaNJzQTfqmr9XvCINGZxnIAqiI7yqQRLLf7KeOZ/S8qSHlxdkpHfRn0Ke5X3T@vger.kernel.org, AJvYcCXFLAeyBp9kl6yjmslg6IUsEjOBR7i2dj7epqgy3c2W4nOT5aoZWDJ0jbCvYarEjHRopHHHT1U4YxGyfU7q@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjzW4dZJnh71evbJNmrMyKgBNjIyHZ6B/V6yAfZ0Iil9zdykt
	nuDsCl6wRPaih2MZKjUuDxoIf6Gn6X5Y5bDtg0efxTLfBHUfTlrsQaPh
X-Gm-Gg: ASbGncuiqb7i1VgCm1o3EsgMtG2g+rGCg9LLy8YL35qFNsQ2P5TPqmpFnJlNPn12u7R
	1Ls8+G0ZvmdXRGDy0lgJlzHDUzf+udXDuZOEd2CNalaukMLFwr3Bsck5UNlGFTfP9xMC0f732Ff
	pxro7D0fy+HaD3S+se2TRIhVfaEaGK8c0wTJAPt9qvb3n3bzlYOSY3YpKJ+g6po0AhfvjJtWBjj
	B0+2YRB2aOkR/CgFV9yt/z8j2Zww6XFoMaiFhidy1CTCQQnMVvJXM1ctlxVuez1nsnKi+Odn3ja
	OotOCWhsTLM6lTK3oxvEKUGaKV69FTh3GVpA8x61QLv6X0KxEj/Wub37OeIOJA==
X-Google-Smtp-Source: AGHT+IHEcN9TqXpZqCIhiJkeXd5Rd4ZpIJF9ZCmoYkubJ2AJSnfavgHhpNIHpdPsx+RjCvP+UqGFrw==
X-Received: by 2002:a17:902:e947:b0:235:7c6:ebdb with SMTP id d9443c01a7336-23823f88824mr119070055ad.10.1750924882766;
        Thu, 26 Jun 2025 01:01:22 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d8695195sm156236865ad.187.2025.06.26.01.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:01:22 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v3 4/4] riscv: dts: sophgo: Enable ethernet device for Huashan Pi
Date: Thu, 26 Jun 2025 16:00:54 +0800
Message-ID: <20250626080056.325496-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626080056.325496-1-inochiama@gmail.com>
References: <20250626080056.325496-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable ethernet controller and mdio multiplexer device on Huashan Pi.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
index 26b57e15adc1..4a5835fa9e96 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -55,6 +55,14 @@ &emmc {
 	non-removable;
 };
 
+&gmac0 {
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+};
+
 &sdhci0 {
 	status = "okay";
 	bus-width = <4>;
-- 
2.50.0


