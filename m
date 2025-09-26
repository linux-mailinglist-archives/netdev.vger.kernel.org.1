Return-Path: <netdev+bounces-226675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8650CBA3F59
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FAF1C01393
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8642F90CC;
	Fri, 26 Sep 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/QYugo7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9941A3A80
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894745; cv=none; b=ejG2RSEAAB3JZUhVHlI4OB3dm8uK8LRQkwj2U3jRjACWh9QyvsfCmDH1ZE0kGTMUgP2FtgeY2ZBUDmsq0DM+NXwgrDL+TUCnso06q3g+nZ4G+acE7oFZRwwD3omo/nq7cLX304WJltaZcP5fnJ+mYaZ5tW2Fgcm4THCV+VulO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894745; c=relaxed/simple;
	bh=29QXbFbslPmiTPuGlQ9L8/1DrSw32wFB7vLBuZhcYNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyNdNR3L7E4crsaXoXbjCi0ok4MPHbcVjokQRvTXUXOCPz4eWfyZp/TOdeUoOSnf8XLXVCuJL/hgQ0181gqRmXqj4YQOqI0o6YAXR4qIRxFQ3GCggNs4tXxh2Bj4CGhh+Qx8937ZOpYKquyuwRYeGp1ov1QKYxyqoy91V2mMRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/QYugo7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3352018dfbcso1479395a91.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758894743; x=1759499543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLKZ1PGtShbPQ7Db1+LnIKpZ5s1PqjR2pTFgHGOqcOI=;
        b=m/QYugo7vy7Ia7uJRasbz+ftf6NmLuBxc2IsBX+4NVJOk1+eUm1JYnHSo7yNwo++7K
         o17YKYN5MIF7weD4z8XxVDkXqm9EbVt2ONQtNDliZVfi9wRF/xpblUyX6VWbgVBZYSW7
         tCx8naFlv+ceJ/3bo96LhhPaFTQgfTHFvu2eX5Qxt46qJn4/kvySyVCQpXPAg5m3HGcc
         x2L+lThXR3Qv/DPG7Uu0iSBXq75r0dsdLuz7QltAE97m3BIrrnVoEOLkWp/SyOjXYfVD
         FQgewdOdHfEMcwbiTYKyf0Ti95P5VXEEmgxoeBVEvB96kydVXCFg99gD6+PE815vdYVR
         vCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894743; x=1759499543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLKZ1PGtShbPQ7Db1+LnIKpZ5s1PqjR2pTFgHGOqcOI=;
        b=QSf7e1FUZ7Xu2NK/M3REXJSW6ts7KxUFPj/8RnVsxQ7tF7oe0xVKqNDXaLlvuUElYx
         LH9muPytaSfSC60v0cx0qWE7MIR75LVmRLCCMd9xJt2lstQd0DHTpPAIxQabf0YmJ7NL
         XA9sQnKK+CCEZsWrNg7ynDLhbQQjeCfaxUZk/5Estb2C9VGXI0I+qqsEqLimi3uuWK3A
         XUEeiFCOwFAsARf1SLV9rwHhkmOo+vX6Ru2ZTYYYYIt7TlXayLkaGd0ik8FJhmkaCsuN
         RX+CUZoOzvur4uZmK7mbmm4wEQExnj07hSXU+cdPmLRmHLyvkuNBmKFoHxx5YTOiSZpo
         l4DA==
X-Gm-Message-State: AOJu0Yx/JJxJhC9WfpswCiu55JGeO9uBv5231XHQyBR6tlqHeNNh1Wp0
	f4OcjzmKK9qdFy+XkRZuqpHEFmM31pFjwo/N8Kh/WBNMdtSYZ+mUCavEzsYynUZKRDI=
X-Gm-Gg: ASbGncsviZysUMovi9Uh/+FV/3ubz6UX7dtKIy9IEelckiLI4GWR50sWM17JhDM/OQU
	gfAUN/wOqZWwZsIMUY9UeBVnXc6M2n+obM4WeSNDut3Lq2KNhHTrpt0dNZR+42DcTvM8SG7ExP1
	nPG1XLxhQfam7peizRbgSPqN19jlLvCy+l6BhcA2+1OuQ/pJxpQY3kEmR4dAfxW7iQ/mykihG9G
	y8EWLcVX3DzKZV8QRuvaJ6QBH9MOU+6OM0I6/i2cBRaijKUDlnO8qKcF+HrBlroQGPS14wSKM4F
	ffthT1rkaINY6nAxE3MA0B6W6tJwX76NC5jn9mxtqoHTSUlrGX8ABzFugjTCGnDVH9MwWVYrds0
	RehwY2donDgdBYgidGc+mvoxM7RoKZSq3i8M/ac6F9ox1VcMyBIy7yEG3yTs=
X-Google-Smtp-Source: AGHT+IESJmB1vCWK3wxFxNmHyAQofqcQGSOzEcCcasafXC4dETuw1ch/4qn4KS4mLk0uMo3QlKYA7A==
X-Received: by 2002:a17:90b:1c8f:b0:335:2b15:7f46 with SMTP id 98e67ed59e1d1-3352b15b573mr3443116a91.21.1758894743274;
        Fri, 26 Sep 2025 06:52:23 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2338csm8997217a91.22.2025.09.26.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:52:23 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v12 1/5] dt-bindings: ethernet-phy: add reverse SGMII phy interface type
Date: Fri, 26 Sep 2025 21:50:48 +0800
Message-ID: <20250926135057.2323738-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926135057.2323738-1-mmyangfl@gmail.com>
References: <20250926135057.2323738-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reverse SGMII" protocol name is an invention derived from
"reverse MII" and "reverse RMII", this means: "behave like an SGMII
PHY".

Signed-off-by: David Yang <mmyangfl@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 2c924d296a8f..8f190fe2208a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -42,6 +42,7 @@ properties:
       - mii-lite
       - gmii
       - sgmii
+      - rev-sgmii
       - psgmii
       - qsgmii
       - qusgmii
-- 
2.51.0


