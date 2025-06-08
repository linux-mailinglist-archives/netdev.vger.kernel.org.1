Return-Path: <netdev+bounces-195593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47837AD15BC
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201803AA542
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27102676F3;
	Sun,  8 Jun 2025 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT0lWEuN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFB2676CE;
	Sun,  8 Jun 2025 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425388; cv=none; b=bjA4ODUrKZQnXJZRvterhE5hbNQauHS65nu9NXyK8ty83x7gh4c6mjZ6kZzUv/US0aXQj3REc9d17AjY8fT9yZbLtIK1oBt2K4iwhjXSnAizYfaqSezfGTskvhwlwG8HBwyZHqipdtJyzh88Tooyi75Wba5gvVDUDOF/xt0KxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425388; c=relaxed/simple;
	bh=4thjQyWKFqJ0Z4KGRxINiQcOw5O22+CVxgUdzvhpDFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpogxlvU8otSsdOFBYI56fwEW//9BKNyi2bM2JY1fVHzmtljYZQB8stJu4XoiwRsQRlmknhjbNC0e6Ha0XMU2nzxzMonLlgLkmPdBksW6nzPA70+P2gfgjT3pbumo1ezwyFW7coYX4KEuEr0+WMQISg1X/BfVt/pV319hXqf4qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT0lWEuN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d21cecc11fso645632685a.3;
        Sun, 08 Jun 2025 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425386; x=1750030186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCb6v/f0HspzS243Pz/dNvSdYY/W6vQ50DJnwXfCQFM=;
        b=mT0lWEuNJtp/D5qaCVYAIRzVnoXsCLN6Fywk2KSAsEKrbDUsuqu89n6JHWgFoQ6nLy
         6HUNxfxs9eejTj7scN97peicT5MeCuarY4NoiJyEOZfgUZSwxeVu0at2yGOB8T2MW9Bs
         PiIF8QdqHduMHspdAZcyjoDZXqkB5YEA7dyHPrZja5DNZMVsO3sY6Prj2rPtZubTg9dQ
         5kjrYrU8/W2WmFRQQkiqRaPZi2Cs7kSOtpGMNirxwmVCHGe4e0uX81zjWsK5AxQ2WEYs
         eSzdo0qOm2ih3JPpsCETHXeaBoAZnJyKzK8DcENVyGoWMvm0INRu5nRO8snm8K2KWC0x
         88aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425386; x=1750030186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCb6v/f0HspzS243Pz/dNvSdYY/W6vQ50DJnwXfCQFM=;
        b=bF1nsx7rmcOgEGwBXMRbSxrZ4hKWVaIwLCeJbYvi1V4HLcUTimcaYqZK8WTP/HQXo6
         FJgxZU9H82sSfTHmYjrVramuJE5eu6ZgqMk+/8YFbYRbscZ0yGmmbjtMjF3BPRCxDdU4
         dwlLLj1r7jleNBXBb+Ow+20a6wF2KIUzgGhotzmoPVdCor3k6TAJwjwOmnNmtNFBFBc7
         EuRsqkoM9xoaYSjWNwvOYp8uI6zLRHXF9kBhiL+uKJgRWsdszRxXw8kkm0zmIOQMT7lP
         8ifaNSgx+syudvjgTEp9e3JhzIlNEN7JOLgv9+ja32HBAXZHDrr5v6aYLCqMFmFOCru6
         ADdg==
X-Forwarded-Encrypted: i=1; AJvYcCU3m88DlMpBpyTItoh7b4sY8ait+grPPs+bOqYYhTuFDIfKXN9/aR1NRavgxCxDqnudV4vWbnXWLWqLsrCx@vger.kernel.org, AJvYcCUqeG1Obfu1IBDSExaOCM0il0AiYkrT6AHPOJZopeF5GhccbhWhKiq//8tTg3r5eqi7R35YeUoveYGF@vger.kernel.org, AJvYcCVIDiDpbOcyxslyzstovTmigsvARNviMTu70RDLCtdTrPmvnb/XjgcKzGdZ1Rluqv32u3Ju6/P/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8H2TqEYP8b7rp9GTW11tjYUZTaE4rPpaPM4kqtYx/fexWE0W
	BQU+stnu++2t1+y9W1uIXkN1Ia4XnwCmXYLTByNyefNcSKBrUeZSwV0kfRX11sTp
X-Gm-Gg: ASbGncvywpciq7aSzwlDucsVlyqVaxrDSi7acSJGosNCCRU89xEWcxAM2NIWe80W0Hm
	XxjpNsFRHHR7jSRyjrGnjAGFdldJNZzBJvVRh5x9JDiOc6Jkvz8YyRZdQqDuhwylGPnQEVasZ+L
	N1dWyIbYHlr9SgLHmkYXlZhh+6v22OuqjLsTGkPX1UP9xINcNWGiGvmAJ5VFQFu+cGAtlC04zw4
	oSU7u9DDr+dKcL5D7AZaavdH7LS+MddDWdNopLO9IEIAItAGC4bZF6bOqAu1QbAuwsNpxkpXDWC
	mnfEd3OAZp+qlOMX17IXyj0fwCrmy7fKqCqgQA==
X-Google-Smtp-Source: AGHT+IF1BKK0uFTInialGKijH/6k16MniaxLSvYp4PMRIjXYhZYA5hYo3Y7cvlg6UD8+EGsy2nqTeg==
X-Received: by 2002:a05:620a:1a8b:b0:7c9:1523:3f17 with SMTP id af79cd13be357-7d2298ed2edmr1567583185a.57.1749425386115;
        Sun, 08 Jun 2025 16:29:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d25a535794sm465946885a.26.2025.06.08.16.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:29:45 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Longbin Li <looong.bin@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 01/11] riscv: dts: sophgo: sg2044: Add system controller device
Date: Mon,  9 Jun 2025 07:28:25 +0800
Message-ID: <20250608232836.784737-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608232836.784737-1-inochiama@gmail.com>
References: <20250608232836.784737-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TOP system controller device is necessary for the SG2044 clock
controller. Add it to the SoC device tree.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index d67e45f77d6e..a0c13d8d26af 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -76,6 +76,13 @@ uart3: serial@7030003000 {
 			status = "disabled";
 		};
 
+		syscon: syscon@7050000000 {
+			compatible = "sophgo,sg2044-top-syscon", "syscon";
+			reg = <0x70 0x50000000 0x0 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&osc>;
+		};
+
 		rst: reset-controller@7050003000 {
 			compatible = "sophgo,sg2044-reset",
 				     "sophgo,sg2042-reset";
-- 
2.49.0


