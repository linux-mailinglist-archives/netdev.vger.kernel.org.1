Return-Path: <netdev+bounces-140099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC999B5385
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64FA2835D3
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396F20CCF6;
	Tue, 29 Oct 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnclQjeg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F0120C49E;
	Tue, 29 Oct 2024 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233464; cv=none; b=js0pZSLEitBbdM9EIDY6XV75nMKHIWeyVebMLruqSEsUMcMARhIGUJkA09L14k+WVsljcrSIJqrb33i+R7oZXinR6QkURo3dNlg5AsX7uEk5e7fYdMXBBwgNEh4vZ3Aj4BmhfGZLNMBES3r0vN7rERcZQGYco8sgsAO/YfsxMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233464; c=relaxed/simple;
	bh=6r3OTMCkg8JSnNJPL45Buou4ldCUlppeLIpHydg8N0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mn4dXFwaPpJqNjCQBq8iwDtFbSBcwhPuMuR5xt1OY6OeRq5kKfdzWAiKyq3EMWTRA8XHQFp0K0XaPrHIWqKvpozNZ8iiJN3z4w47mbrzT4QhHa1mxbWNU26mRf1vouvhhCBsT6D7Y12uxG5Quyd6qr/NKcmhF3xht6M3JqElfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnclQjeg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43158124a54so7106175e9.3;
        Tue, 29 Oct 2024 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233460; x=1730838260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcSzd2hHGzMI1nKPL5Zq2z/Pr8ApxfIMOQ8qhhepbX8=;
        b=ZnclQjegmZmwixtnErm4L0TZVNaC5MKflxoi16CMA6hUYEzlt3wh+17F2h1iARc92+
         K1CpB9mr7Khu5oLny7LfoBEAbbgynBJHIp8aTS1SsdaTFTFxlDh2FNLWXG8rYf/LJg0u
         2tp+ZLwYlHS1nfM4ZCOoa+dd1zaM/PY6b++qMAnKSCTYZUQbFmTLDTNej7WKxjabNO//
         YVOysGD9ARfpbaod8G1WD9oHmSyKuj557iMQMUYVwVyRplbbU+Gthzk6cB93npQqRe4p
         vTvKhq7WlblxxIUjwJkBPLWYtDWhKEPteeNmcOCV/Bl4vLi82P9hFdT28G0C7T4DMS6P
         v7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233460; x=1730838260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcSzd2hHGzMI1nKPL5Zq2z/Pr8ApxfIMOQ8qhhepbX8=;
        b=NfIYuL4ZSFT6hwL+S9hQfSytWWzuPpILJkLtV5MBqbM0dxMbIPsjU5nYIEsRU55h77
         Sl13tf4/CwoMEo9OMgbOw08qQ36jymdWgsDXCxMi5e8ndu0t5/KxKEKk23tuwrSgUzZl
         fcYLp7Duwfqs+ABmAKu+o8dIRmC6zfv1+CRi9Lp/LZWBQKff0hSq4QVVzTp78q2fFXCH
         F9E2zY2EFNGvw4xbFU7MK5tE3pmp/dPW9JMvRZIHnyHdtXMnWB5H1p4RWvjr3cMRQgpH
         gEMCUDfODiOYuRTlBMwHOrYic977wAXIR+tMgLFbsCSitjyAzEIGPEqG7E4hsEfDJcVs
         F5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuUAsqRc4/2L52XMMofV4GK37FiG3sJCFtn3eGjRC53I01RSui9s/vrlDHjt3IRDkPClcJJxgSRs7ChbAK@vger.kernel.org, AJvYcCVpfr/ZExqySXXFLtb/5oS5SWE/OhDTgILWoWD4PxcAFa5k8qB7k8KVLrvcDkwWkdox4xTZ8su6Jf5d@vger.kernel.org, AJvYcCX8yaWtJGY+kJ1Ca96gZLBIwnPzILZSbL7knmXKdBom3dx+Xk78hciMQFMWGc2rrPjQJy51Ij16@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13kvAe3Kloi1W/xv50JeUL90Uq4XAGLpRGXCHtiAcd6shfgs+
	LSAiu7wE9N4bELcwpp5fRUgxzogeBn+75IC/P6TV44l6ifMBQ+w3
X-Google-Smtp-Source: AGHT+IFthbx5sF59M7JPXFTbmXBHaYzdi4tE1rj9Q7V6VVETB6DSTEN3Pzofg+o0yDuJbijtUURebA==
X-Received: by 2002:a05:600c:4fd4:b0:42c:aeee:e604 with SMTP id 5b1f17b1804b1-4319ad41ba8mr47526965e9.8.1730233460330;
        Tue, 29 Oct 2024 13:24:20 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:19 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 16/23] dt-bindings: altera: add Enclustra Mercury SA1
Date: Tue, 29 Oct 2024 20:23:42 +0000
Message-Id: <20241029202349.69442-17-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029202349.69442-1-l.rubusch@gmail.com>
References: <20241029202349.69442-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DT binding for the Enclustra Mercury+ SA1 SoM

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 8c7575455..87a22d2a4 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -51,6 +51,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury SA1 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa1-pe1
+              - enclustra,mercury-sa1-pe3
+              - enclustra,mercury-sa1-st1
+          - const: enclustra,mercury-sa1
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.25.1


