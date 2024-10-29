Return-Path: <netdev+bounces-140095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B19B5375
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF931F237A8
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1720C031;
	Tue, 29 Oct 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnfDhkIh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A6E20A5FF;
	Tue, 29 Oct 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233457; cv=none; b=TBoXsD9InWLbfzVSfi68mBSTDPka0mn+b0M/dT7VOOZVp8sV6yC+PH0/gzXLTXUJN+8q5uOVnJKHP1FkvB3j3FaOCKrLJ/m0mmGENmStOtrzmnQoJ5oQhDop0YOgXGzb4Z1ilZhi+3Uy5i0M2OUAM4eD6zt3+NHrDN/NKgEJh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233457; c=relaxed/simple;
	bh=PYawdMcP2GouJZJBJhzUjoIk0OafdBZQzp+rXwkagL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIktUfmjmbFznLDpSnj3BoTe9IobsjoAGwUFoJ4iHVYlXSSBAutF9Bw0V155LNyiTBcLR7BbRHMeav2XTh7cvttotdUCdyPgC4mHUjzFCoCKXNs6xEIKewrFMbNbuoBnExuR4CcgmHYA8izbEAeCHtJx0MW7siOOIDoubtrcbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnfDhkIh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314c006fa4so4898535e9.0;
        Tue, 29 Oct 2024 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233453; x=1730838253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozG3F0d45Tc8g66cKQj6Gpf5cSc5WnMCj2YvzIalGjA=;
        b=LnfDhkIhFRAMGEnnKpwXltUFr2KLQ0F9Knf0K8yI0VYsOQ2sI+cMt3+icWtLgCoBZs
         iAPUm+88XmvgwuolHe8owWgoVzuu2osLVrD8EwKe5n1hn3lvoG6WgPVZ8dfPLY67m40M
         0V0iq9dOE+v185x0LcShLbQJn70pRdip8JGHNslHP/ysfayuncrrY14gAkmKQ+mPc8+l
         QDzAlI9eDpNw8l1tWxb23VyeNiMfyL7pzXciQMbEzJr+iZP6aQ+ZYK7x6lZs5Vy9Qb3a
         IDd6s8VvaQ+Oup04Ixvu7KS9L/zLPPso/GULt+v4xngJ/Vx8VNTU0tKbWq0dx3Iavzas
         /GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233453; x=1730838253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozG3F0d45Tc8g66cKQj6Gpf5cSc5WnMCj2YvzIalGjA=;
        b=hd0KJ2jA/XcWm9v/vLdNAUFbh2i5DakKM9k+PWTmQ/j8uV5V9RkCj+LDoWJ87rYcLk
         qKTBAmVawOUN/DuKTbi7DAbZ7DfMGF00fYYxAom//3TCCoss7tX7JLfyZnPOwLuACN/M
         9+YWN9TfPNbL8pbHZRF73b+XSj0DKZyCNHqlvOHKmwXUtXsPHYjdXZ9QRfp6vCuPZBNR
         PKciCz0TQBucCM1oGBQBmYaVBndsrWzcJBlxQNbfgsTvA47fHIOMJKSY7AM+GCA4JOjT
         HWMpg/3xlFawUOLKROGPB1Wvk0/syTjvlEyXDydwvkmtPEFUOOShgUHeUf7oTXvf+xLl
         ILwA==
X-Forwarded-Encrypted: i=1; AJvYcCW45K+aEjeN5UUbNI0I/B77+vof3glQUtiHlwj9WVged4AoUTqGR6xfW47LRn2/d4oV/uPjvc/255rT7Weu@vger.kernel.org, AJvYcCXB6GKwEVHoccK5EaSmMth1b5affw0lbINstjead5+HMlo0A01XNZz5FkWGK5HPpZLz9niaWLw0/aZe@vger.kernel.org, AJvYcCXXXXbWfPcjBglFXYqJOhcTIiwpkxr9h+Inb9puqzkVSKQsnMAaLIJbxaP1/JfdB8SeQDEwueEc@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6UYiRMNLuuSnK8+iE8l/BREfcjHkIRDsepRpmb/N1JrVb5r4
	aJIp40QXgiqh3zYoG0RfMC8CIifr4pFiVeotfd4HvpipOqmoQNXz
X-Google-Smtp-Source: AGHT+IGHbXNtpVeRkay6QoXYzvaEQf3MjkyLQHiS5jkm/oeLQ1Uj4ljCcnFMbwCNEC3ab9YAHsxiog==
X-Received: by 2002:a05:600c:468d:b0:42c:aeee:80c with SMTP id 5b1f17b1804b1-4319ad74341mr49011315e9.9.1730233453136;
        Tue, 29 Oct 2024 13:24:13 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:12 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/23] dt-bindings: net: snps,dwmac: add support for Arria10
Date: Tue, 29 Oct 2024 20:23:38 +0000
Message-Id: <20241029202349.69442-13-l.rubusch@gmail.com>
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

The hard processor system (HPS) on the Intel/Altera Arria10 provides
three Ethernet Media Access Controller (EMAC) peripherals. Each EMAC
can be used to transmit and receive data at 10/100/1000 Mbps over
ethernet connections in compliance with the IEEE 802.3 specification.
The EMACs on the Arria10 are instances of the Synopsis DesignWare
Universal 10/100/1000 Ethernet MAC, version 3.72a.

Support the Synopsis DesignWare version 3.72a, which is used in Intel's
Arria10 SoC, since it was missing.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
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
2.25.1


