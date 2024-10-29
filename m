Return-Path: <netdev+bounces-140103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 668419B5396
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0CE8B21FA0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645520F3C3;
	Tue, 29 Oct 2024 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAw57WfO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608220E323;
	Tue, 29 Oct 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233471; cv=none; b=kg2gyNwvmSmOaKZajUc77YQb2RdYXGM6sjtB6785ZX7BRWWF9JGKkOrHLreC2dLNNoG74Y+IBd7lCpfE8jt8wrRKocva7Cm+8v5gIwJQcdTRkDmbgTDG2H+K++M/+Y0j98YVrDtto+pIU/BfT5e69C/TIEBhUlHrUmDvgdZvae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233471; c=relaxed/simple;
	bh=cR2fgB78HNr71BXUwO5TRA7QH3VDNc3eMnJv2PQZD7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taLuE8Y5rZTmBwkmITdrHCqxGnaiBu2WuKFXvVOdE98PbV/kjPsD0Gt3QO6ruOp/3vqy0kaig+9hVcTh1PFw1YxriMdiNpd4om1h2L/ffoi1zAQ1y3IEnT29IMr8x9NPg90eNUjo4JFdrqdXX8gDznQuFBUcACa4gwCVmyRqezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAw57WfO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43160c5bad8so6248955e9.3;
        Tue, 29 Oct 2024 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233467; x=1730838267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzwRCpqtu/LaKB65Sh0DA5SNke+63PFskUW28xnczPk=;
        b=NAw57WfOqq5FfKONXy1JfRrw/H/gJl7iMrJSLfg9Nd3lkTfNMgRT6BN1fcjQPwyMfk
         1Lzqk+IJZG061lMVFXghpdpnUVcZbNzd6RCghuaLhWgAq5+IzffayREGsb+bLGjZaZtU
         J5DJ9kDkH0vQ+MiXIGw/MeCfisSdLh5HnbB4+zahAYvWcHJsXwHKaOC+rGoojLGOSp3L
         e1gdbNrgZMpP9hYZ05DHSBhsOA6yEPe7WGbLm8GjVkuCqq+uDa+Yic+A/BqnFfuxDjjA
         Mn17UIMEwATx/oqWHIK9Z7bziTG9LGD4h2RiRjcTYrP7oWZI4AzWiGKQndFdBZN0soOV
         2jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233467; x=1730838267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzwRCpqtu/LaKB65Sh0DA5SNke+63PFskUW28xnczPk=;
        b=bUBq8JkYA9jwzdcGe5EXPReKFy7nYgJBFGwJ9duBzA8XRf9ipz5Mv7wQZBM1By7zV2
         C3dtwNwKmUKLnFJDYXSTTMcUKpx7StZ0rBjVpxaIc6o3w6l9lkfhZcFCyA0SmN8Omscs
         IA86oDZ+ZOy8Iaxa7To6BpxjOCjCUzzxhK8f9dox3SgpqEutDjP7LF2kvsNryZ5e+4J2
         BXsGHGKrP4sRMd/ah9oUjkrMfUUQj4aC96yqBnv6twNkA26EZecu9x29wr9emQOY4scv
         UMyEjZ/8v8ZPNh0odH51SmNa1wMVVDK5KXymKtlYXNGYy+jKDhuPzZPPoo5faSqPdUnb
         CPYA==
X-Forwarded-Encrypted: i=1; AJvYcCV/fz5JV9xkEXGELTdTvcBvOSyncXvaSPvTnbCQ5TWC1TaUkstRUTHyNhiQAsFWxyH1cWZ39k2s/YDP@vger.kernel.org, AJvYcCVVwTg/pd6O1ngHuV3GroKXYcFg1V0d53cgnN0j0nurImRMLVRYTF5BzR7PgV1bwTbLs658RomHDmpDjjs+@vger.kernel.org, AJvYcCWbZ7zpA2nMMrsCOXocznT6lRtFOss+1Ur6stEbq4984nwHHZE3+7bVhuQoJ46QwfZkdsXTsWJZ@vger.kernel.org
X-Gm-Message-State: AOJu0YznAO4ynslKxwIEB+m4yMl47ITWZlmwJ7rLvHi1FdkGU+MA2X2a
	5L9EwME9JkJpS+QhK7iqhS0kkVo/GFCQJdiRDpYHjcy4BXuNvcZU
X-Google-Smtp-Source: AGHT+IGVkLSu4+PWoIJ+coYpkKXLhR5XEyzMIPK5W8wNP/CqB9C8YHK4RGWYMg6MZPBGM3IM9RzNog==
X-Received: by 2002:a05:600c:4f10:b0:42c:ba6c:d9b1 with SMTP id 5b1f17b1804b1-4319ad236dcmr49969575e9.4.1730233467355;
        Tue, 29 Oct 2024 13:24:27 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:27 -0700 (PDT)
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
Subject: [PATCH v4 20/23] dt-bindings: altera: add Mercury AA1 combinations
Date: Tue, 29 Oct 2024 20:23:46 +0000
Message-Id: <20241029202349.69442-21-l.rubusch@gmail.com>
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

Update binding with combined .dts for the Mercury+ PE1, PE3 and ST1
carrier boards with the Mercury+ AA1 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 31af6859d..51f10ff8e 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -32,6 +32,9 @@ properties:
         items:
           - enum:
               - enclustra,mercury-pe1
+              - enclustra,mercury-aa1-pe1
+              - enclustra,mercury-aa1-pe3
+              - enclustra,mercury-aa1-st1
               - google,chameleon-v3
           - const: enclustra,mercury-aa1
           - const: altr,socfpga-arria10
-- 
2.25.1


