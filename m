Return-Path: <netdev+bounces-106548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FCD916CC0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B626B1C2332D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3A17F50F;
	Tue, 25 Jun 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QMDOTApc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB417C7A3
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328487; cv=none; b=UIYRjnSaD2n3eQN6jljYygsOz7gGc98UaFpDPw+RFPErfnMldqbG2dVyfiFafxSlJKLsZjrSYH101mf0PlU+CCDHp5s8TV5kVNKJht2uiqgUOMhy9DJKOhPMmYShfLzM3N0d03KkMXsIYqzojr+sOSNxXyFPQPIJyLZuohvmNZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328487; c=relaxed/simple;
	bh=6oEPaSCChudDdQl5CoJDofrXFQKG94CulRBD/mPvurQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyMGW36Wg6kudsyMi6vcq+xpt2uruUOJiHFFcAdWYeKhheZYb4GxTuPkMI6AVcIsPXwjEAFMaqIILI+y0NCtMm05VsHUiMX9auvn2XI72LqKlkv7WT0ddYVd0ygoUUW1T78omjJuytWz6AF21gRtc6woeaD3HNi50oLbyWyHbx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QMDOTApc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424720e73e0so49272185e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719328484; x=1719933284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW5TgJTLJvnOUoVv5AkY93z+u1qC4NhO9SwlIzEGESI=;
        b=QMDOTApcSe3CkyGTodls3R2JPecXuNX0kzIPubLu07J1AxeiQ3KKFwc5HfOLQLKO4T
         AbrFQh1pUyVzlcUQL4z9VB1QcK3F5cVj9QAUb0ku1E6sNbXx18toRcyJYtW82QNtTJcm
         p+n6yqHt7iUYEaBs4d79NhjhEXHUEdVaOZFYA0n/xnm2Hk8afmmCZVyy8D0YUKOfsrKR
         XiaH1MHHmG3IEPzUONmqF4QPwpiYppH0Nfn6HFAG9xqqWd7iZVYXI/LRCBmzsiKza7tn
         9uLs9qoO6Fs+cz68SxED2m390gvFIWBx+UViJTVaXQhtXwyy0GqcUyobyiL1hoZvoRbw
         +hQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328484; x=1719933284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW5TgJTLJvnOUoVv5AkY93z+u1qC4NhO9SwlIzEGESI=;
        b=N0ijl+t3091Zagx4s50orKr59lsMRVgVKGE55FHtIliP26h7DseHGA6WeV6QDvvcGY
         9l+waxKSx2bvEMKm5ixbvZfgVp76GrTzwPVFRXxdHkk9bQaiyIPPZtqxy+74Dh0YZS9m
         1bz+3B8uRLa8DYpCYf2hXxaE8ciXAZYGB0S70LQEt+qVb0OolZluxtG30tz9R+ei9+gx
         3i/bO0ZyQ8kN9yAN5AJhX5lJa9aoK6FrgIMNsx34udOQ3tOG1LA6aRYDVjobVUliQM4a
         0s2IQXrgyYqQcEXvN9mnU9Y6gkI6bQUAnX4A6XGTY9FRQa+cMsjK7mtvoIBISWCA/zCg
         TpuA==
X-Forwarded-Encrypted: i=1; AJvYcCXDyKan8MLB8A1vT2a98wGH7dvegwp6eadCe+V8RLLZu0GOyaaTfXFP4DrKvSfJ80u2v0V2S2lHz9kHoYmEnFfJGKAtZMv3
X-Gm-Message-State: AOJu0Yxr/xxL7pjV5SVVHrCxRtHhjdjGkfBKZK6Ug7Lp5f/ZhDQ3eGCB
	kHswgKJ/GffB050qacG/Bqvam6uKCc5yLObc4RD3aimCnUkTLZaR3hXGxqR8o4w=
X-Google-Smtp-Source: AGHT+IHPUHzaJ4AixLf5gkUx9yjJMzFDeNciwKVnr+uETnNcIHDTB+b+nTXnzdoAxq+gSkf7gsMEig==
X-Received: by 2002:a05:600c:a29f:b0:422:35:d19d with SMTP id 5b1f17b1804b1-4248b9ebc59mr57452935e9.36.1719328484086;
        Tue, 25 Jun 2024 08:14:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2b2c:4971:1887:588b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f694asm13215884f8f.77.2024.06.25.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:14:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom: add sa8775p-ride Rev 3
Date: Tue, 25 Jun 2024 17:14:28 +0200
Message-ID: <20240625151430.34024-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625151430.34024-1-brgl@bgdev.pl>
References: <20240625151430.34024-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Document the compatible for revision 3 of the sa8775p-ride board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ec1c10a12470..000037f4a712 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -895,6 +895,7 @@ properties:
       - items:
           - enum:
               - qcom,sa8775p-ride
+              - qcom,sa8775p-ride-r3
           - const: qcom,sa8775p
 
       - items:
-- 
2.43.0


