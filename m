Return-Path: <netdev+bounces-141192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D219B9F74
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 12:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338E12826C2
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C218593A;
	Sat,  2 Nov 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdMzktAU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A424184545;
	Sat,  2 Nov 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547699; cv=none; b=g0q0i93l74RMVxIVqaDa+bAhcvSUN2rFQPXpLLNQsA7OJAq29IvabyQUe0ADPaf+/K6onc1LPR0h1rLs8kCeciPSWLn9zgBouZR6hx8NwW/eAqqMPmGbrbyEr17qXOHV+pgv+1461KI42mV9kTjUgWu+M9SrVYj3YH2dm23iOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547699; c=relaxed/simple;
	bh=MJdAzs40GCnOJP6xS0AQ9YL3mtYF4FBP7S3m2PxPXfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmYR6r31kJRuQeIFYhEj/qbekHRV4P13jwsim0+AYlsHIYibO20VmhNUJ2I1aWyRPmwE3loT67+IuVlUZnmgFzq5fnierItvOngVunlkJEjHcgCjQr1TpeziMzTCrCh/YxKJA+oqho/fgU6tSsDbF1mWpNEeQRAxBScOaoi7SW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdMzktAU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a1e429b89so49877166b.1;
        Sat, 02 Nov 2024 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730547696; x=1731152496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOkHw4o/DpBBAteKKHGiek6FnJvHtdDfQKLJ8jI641Y=;
        b=AdMzktAUUJCDntd5soMtFPY4mN5GfZAHSh8pTeK2MyXCFpW7TAAXYEbiIvXSB26PNR
         CXfJCuh6h+t2/ZtXi6wLG8dG1kWLrI+HOLYuE8sTvEE5cQTDaRV8qRDPWulOWrqItb4f
         6JVB9u9l8DuNV4UwMFu1aaalIurVjQMDKSBMABt0/HrAex4V6mwEPq0sU31Zo6sZf6Tl
         5rnvNBAa5+LcD0MVqKuML1lqyBaUFdwW19bXKUr/erB9ChoaW2IHGIi1OHXfuWi756Yk
         yWzT43Fc4MHxC2/PhHpVAjnAbsXk+kYxKkafNzBey8xOHeBCywy/KZgH7UoppxJwtCWS
         ZESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547696; x=1731152496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOkHw4o/DpBBAteKKHGiek6FnJvHtdDfQKLJ8jI641Y=;
        b=X6iRhrGd2kktYVLULch7Y39aRux2JDZP8GvVJVOE6gNNitf+aJTs/Lc8Qs3EE7lXNt
         /7E6dyG4uCwrGWsmZV07x/fZI8HKVY27nEyPzIOBLuyQRBgZjmTsbH2lQ/RunC8KvLgU
         nLSqxGK4mKFEqgvh8VEvqQc+ycFAy8OXSFMMFgQNqP324VzQZlO4ZmdpbANtwH08rH1B
         wGqOB058xu+WL+LQkD95ltCdCgtygOzAM8o1Fz62iNaAdecYlmdgUTrZ9yArzDv+LzwY
         CxJEyuRf64I0w4u3fq092lKiDlUy524bHLIIgq7DxdsCkUwn9mggCETdhzG0S2hgjM4B
         EGsw==
X-Forwarded-Encrypted: i=1; AJvYcCVXNN4HDLrSplQERj8+JTsfxbai4fG3yvMDfvBOKYYx/8tfAbEHzqhRwxJF9dDX7g47ObpR19cLpani@vger.kernel.org, AJvYcCXLheyooQZhwkNCA6KcquRLjudSDfoF3KeKybmOWkJUb4Ckig6KuqL6Jmf5p5GLNC0NqMevWCa8@vger.kernel.org, AJvYcCXiJXDkyq1djD3qkjZGCaucIjhQYBOK8857AfzPYGI5ixEFkW9KN8XwRrsP7pHpFpklI1NxUhI2IjixfKPG@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJPCrZUwvo3i531+VoQMyS1re6TwlOwqrzV+4qdtIjIpl7GpO
	7x0UbqwDIJXk7mNuf2fJrfIUL4lT1gMhEmldZbJomIOUOKrbrZcW
X-Google-Smtp-Source: AGHT+IHjlFEbf282MF76qwHad6BykjaTigqFREVRHfAAOyoo0BQ9DtSIfDsLbquzvjN8C3vTjqzNpw==
X-Received: by 2002:a50:fb8b:0:b0:5ce:ccff:ac34 with SMTP id 4fb4d7f45d1cf-5ceccffaf12mr288807a12.6.1730547693808;
        Sat, 02 Nov 2024 04:41:33 -0700 (PDT)
Received: from 1bb4c87f881f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceb11a7aaasm2224918a12.83.2024.11.02.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:41:32 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	kuba@kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peppe.cavallaro@st.com,
	devicetree@vger.kernel.org,
	l.rubusch@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: net: snps,dwmac: add support for Arria10
Date: Sat,  2 Nov 2024 11:41:22 +0000
Message-Id: <20241102114122.4631-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241102114122.4631-1-l.rubusch@gmail.com>
References: <20241102114122.4631-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hard processor system (HPS) on the Intel/Altera Arria10 provides
three Ethernet Media Access Controller (EMAC) peripherals. Each EMAC
can be used to transmit and receive data at 10/100/1000 Mbps over
ethernet connections in compliance with the IEEE 802.3 specification.
The EMACs on the Arria10 are instances of the Synopsis DesignWare
Universal 10/100/1000 Ethernet MAC, version 3.72a.

Support the Synopsis DesignWare version 3.72a, which is used in Intel's
Arria10 SoC, since it was missing.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 15073627c..d26bb77eb 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -26,6 +26,7 @@ select:
           - snps,dwmac-3.610
           - snps,dwmac-3.70a
           - snps,dwmac-3.710
+          - snps,dwmac-3.72a
           - snps,dwmac-4.00
           - snps,dwmac-4.10a
           - snps,dwmac-4.20a
@@ -88,6 +89,7 @@ properties:
         - snps,dwmac-3.610
         - snps,dwmac-3.70a
         - snps,dwmac-3.710
+        - snps,dwmac-3.72a
         - snps,dwmac-4.00
         - snps,dwmac-4.10a
         - snps,dwmac-4.20a
-- 
2.39.2


