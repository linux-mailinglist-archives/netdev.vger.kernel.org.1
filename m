Return-Path: <netdev+bounces-140101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549399B538F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA3D1C20E21
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8220E03B;
	Tue, 29 Oct 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbJmEWZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB520E006;
	Tue, 29 Oct 2024 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233467; cv=none; b=qFIvH7tEEOd/eb0nbEyUv1A+M+++jinWu7cWfW5EgVCb5To0HZU5BnBAZ56EQggbpOmxtDlaC7pB7U5+GnoFvZBywE2U9uxNhWkD2YWF2TzjJ7UmpKJfzvHsfSvaqf6pcbsxV71dYNvoknTSuUahxOQqIpIPgV5XkT6qLPrlRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233467; c=relaxed/simple;
	bh=+WI7z4cCdgzRCz2IC29X1z8kx4r4PyB+TcV+EvRg5uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgAxVdAo/exfrBMVl5LMXYtUr3kwMoRfwAlK01lEkmTv0ot6yMWnGpTeK91Wu8deqOKSwuVPhCMQR/P5NVh9Y6tj5fEPTNzCpw5OqZcp2otDHga5LXBtMMx5bM0GvUy1dgxfhWXu83tZO3ELo6qZwgud34ckKPbcwk0UCMdRW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbJmEWZ5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4eac48d8so533961f8f.0;
        Tue, 29 Oct 2024 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233464; x=1730838264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiZ7/G9UNkzspOjV6MuvUoqfRxBzDKu6uAviqklHEbU=;
        b=PbJmEWZ5X/dO8hb+/v5q/Y/VIZNrJ5JqThrhkiO/LdCoxLvvSFFauhH6NEAWMnZF8y
         sp29QZlV4YmsxQNFqAWuBI0bTi77zb+bPjaoG85YedKE1hhUUmmwbOfGzT0a4s8zwMLy
         xYJ5qvjU26glilzhwbmbESMDgrV86+Cibl7YSCEQD5tx9HE4mjlRK8KxFfprvQpvZc+4
         nngvXUQWmNBSjJFDiFetnQ9LNDdU213F0yedfv24T3zFo5wdfQ1wNBDNDVmAhlD4UiDv
         PhFSTQsM6GbC7CZZ0HHQ1y39UAEZUZ42uBAeb7AUByxLrSgK/+eVYTl5dnhRbjU6/FjR
         qEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233464; x=1730838264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiZ7/G9UNkzspOjV6MuvUoqfRxBzDKu6uAviqklHEbU=;
        b=R3DWGQ3Fmi1RWpAgAoJ/CRL4O1oD7kegcKXENBy5pbIie1ypm7+4IuVRywCV1Q0HCs
         WYAMYi4bNp2x+4DmFDfFvxG6psfgwmpL9sIbewmTQqz9dFBMRWc4BCQQBFJ/VielUkne
         t2aC6nFev2r7eY/saK5d06xIE3LYO7b2HMOht3jelYaPeKyHIUc5VSz3trlNAAXMsoeB
         dkXCBPgvQSeYYkcVR5o046gLkC5Xb8++tRhx/wIzIeqtgyNaBWBB8XjVnoU0iE/3DQDT
         YaSyMqxZBdM8tdDbO0yxfnkYhWtzEz2UsD0qsSHysW9qduYR9gkscLtdye/vCRNcNgBY
         JoUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9moPr+P1GKXnT3RWJsp7DQot5sI7lw1n1M8oRQXmA6vu/eYHYmfYyME3KloXuQb1fc7dvRJibvaq/@vger.kernel.org, AJvYcCX/JqQItRjQkdm8IXTPCLmFMWGsH9plNS32GMgBTzVLhLPOpyD8uz5E1mqr4rYRMu1leZy5tgLs@vger.kernel.org, AJvYcCXPpudnvOquzkckXRs9QNCwzeurqj0Nwki4M4bjBVD6JICJM0ItuESTxn8npNBX8fJq248nXPovwsrubKjE@vger.kernel.org
X-Gm-Message-State: AOJu0YywSNzD98FF5GwqXMKGI/D1Bhw5j+0CaGPoZHo+QgIi/x0AnefS
	qEJzTQOqnWsdsJ/v5BM1jSSwi1qr1H14HNCEqfnoOewGIYMO7QiQ
X-Google-Smtp-Source: AGHT+IHyg5QfVoIB0g8cY8WdGJ+yLFIaLjBBCklyUO2y4aO27Z1LJKejcrpTkw72xrOIrnw0gtfwbg==
X-Received: by 2002:a05:6000:184e:b0:37c:d0d6:ab1a with SMTP id ffacd0b85a97d-3806121f5ebmr4369116f8f.12.1730233463587;
        Tue, 29 Oct 2024 13:24:23 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:23 -0700 (PDT)
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
Subject: [PATCH v4 18/23] dt-bindings: altera: add binding for Mercury+ SA2
Date: Tue, 29 Oct 2024 20:23:44 +0000
Message-Id: <20241029202349.69442-19-l.rubusch@gmail.com>
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

Update the device-tree binding for the Enclustra Mercury+ SA2 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 87a22d2a4..31af6859d 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -61,6 +61,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury+ SA2 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa2-pe1
+              - enclustra,mercury-sa2-pe3
+              - enclustra,mercury-sa2-st1
+          - const: enclustra,mercury-sa2
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.25.1


