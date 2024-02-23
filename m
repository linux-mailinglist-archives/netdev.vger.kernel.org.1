Return-Path: <netdev+bounces-74547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449DC861D0E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7344A1C24C21
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F175C14535D;
	Fri, 23 Feb 2024 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="P/5a1fmc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CE1448DD
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718217; cv=none; b=Ds9RtkBv4c/LQ0BY+yBvpiqp/ethY8FKbsgghaLCxYTgyQCfFBvHSLtgLnz8Cf6Jbf0HV/FcIFldYSICF9xPHbe14QOP9yuXzF6vZRmCNqC1U7eZVx/5fJnu0jjPLPsX0r6gV7X2DektVSFaxcX+04e0o0dKcI7zEFdK+kHsAvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718217; c=relaxed/simple;
	bh=2Er/E/YWR4ziMDKsjtcUbOnth7XzrgxHccJF7NTGcdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LBiwUYmpbQdehfBI/JA1YQVsQug4RTJR7A6HSvX/C1G/Ooh7oTmUkC8B+MK/+9GgWGprpqgzbJv5MKMTQXz3kIEeCi3+IkmcoG9GuTeCfzXHnLTjoME+yTvqX5c2Rfjnd1PsrcjoF3Ouwj2vLQDHo1bYBgOb8zZWpr3aG69F2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=P/5a1fmc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d26227d508so9016721fa.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 11:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1708718213; x=1709323013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnKaa7U6yo34FD6yjr/0ko1wRd4z14aSOMgBBceVmWE=;
        b=P/5a1fmcCxe5wyHwutsdiUG9UZcP/ZwRjF2b9ewOuy/awYBjVn1gRNaiA6gZNaHtqJ
         Xg+fQcNPwx2rzs8xtcSHFOFjuSRnWRdzZwKSZ/MZL21h3wl+br2crCXZ++5TsvvZ3i7H
         olu4yLHYL6/qkyS36Xps5T7aHVVMWXmGP0pEbAt1EjlpOwebF0ts2Mk4sIp1RfiqW7En
         7i7E+6VqpSJnHVoaQ3yGzpSU8Mpuueu1oIo6pl52BCpW6sq29C9vJQXbbVuKqx8QW07w
         o+FcD+JaA2z+6QPeOky88C/P6pYNqR7uHhPY5VsEsk+tHFh4c9E4hEFn9fbgnDco/yyE
         kzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708718213; x=1709323013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnKaa7U6yo34FD6yjr/0ko1wRd4z14aSOMgBBceVmWE=;
        b=xOCUhGXweqFsCbcMMVcJwLn+VApLMpIzIa2ZK3Gr/188Ty/PPaz8f8NC1zSqP/OIsU
         d2GB5mVUJBiEhZHiFn9Ob3M8cuKEyNgtqbMFqpr5C4tULlh3ovIcyzeZDW8omO5jihV6
         4V0whIx3SLvyxdq+G3kMvOS1nOhLCRNdoaPHL9v1pxl5Dv93FUMGzf5ctVXsKh8diGwm
         QYL449eqpvtaXMdilZdEtSj/WGgPlZMqOY+KvZmvHHl7tTFvIHxgZe+E2zdV9rCargqQ
         XC49ngVZsO69RNHyThzQybEOwqVVTGWNDNI92drwck5PWjeV4qhQwN14fmxZiwA4zk9X
         ankA==
X-Forwarded-Encrypted: i=1; AJvYcCUje49wBtaICHMNrWNFM9jGnz8aP+JCn8ZbL0qpOdbraXgMeGlbG73dp9VCTs2O9OqNVYfto8vp11v4ziKUIMa3lBsqQ2Qw
X-Gm-Message-State: AOJu0YwbXjgq1CboJo3i1M92uqCauJFOOq7sMnIJXtEXl26kfcjFzmve
	2TSQMsaapA3mhO6Huwp9zjK6I9D2Lpq/4WTe64tB+ZqFfprpwO/NBnvl7VKQwl4=
X-Google-Smtp-Source: AGHT+IEszpjkvVii9Ofn9U98ZBWGg1toQDRx9xo+HuBlNaQdnBY246B7GBYO8EHTSbTKFXUCPiDO8w==
X-Received: by 2002:a2e:9c8a:0:b0:2d2:31e2:ec00 with SMTP id x10-20020a2e9c8a000000b002d231e2ec00mr82847lji.30.1708718212975;
        Fri, 23 Feb 2024 11:56:52 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id bf2-20020a0564021a4200b00562149c7bf4sm6658334edb.48.2024.02.23.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 11:56:52 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] dt-bindings: net: renesas,ethertsn: Document default for delays
Date: Fri, 23 Feb 2024 20:55:26 +0100
Message-ID: <20240223195526.1161232-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The internal delay properties are not mandatory and should have a
documented default value. The device only supports either no delay or a
fixed delay and the device reset default is no delay, document the
default as no delay.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 Documentation/devicetree/bindings/net/renesas,ethertsn.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ethertsn.yaml b/Documentation/devicetree/bindings/net/renesas,ethertsn.yaml
index 475aff7714d6..ea35d19be829 100644
--- a/Documentation/devicetree/bindings/net/renesas,ethertsn.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,ethertsn.yaml
@@ -65,9 +65,11 @@ properties:
 
   rx-internal-delay-ps:
     enum: [0, 1800]
+    default: 0
 
   tx-internal-delay-ps:
     enum: [0, 2000]
+    default: 0
 
   '#address-cells':
     const: 1
-- 
2.43.2


