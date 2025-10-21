Return-Path: <netdev+bounces-231418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1538BF9223
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7D3A60DA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDCF30147F;
	Tue, 21 Oct 2025 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Vftz7HtP"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE02E8E09;
	Tue, 21 Oct 2025 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086678; cv=none; b=p/udh1M+RKO0rQxb6vnuRY9+NtCj3Lpz4yQap+TvpQ4fG9OMYnVOwegW04dh5jZ8ODUYzwzUFlE2St9ME6Sbw162IuHSzCGJZU4JyZ/X9971/uA1F06JGxro/OOKG+QR6mwmln60oDcVArdFyw36tCwR/yoTBAJVZYH7mBBlG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086678; c=relaxed/simple;
	bh=WeJfmHyei00p447QjgsE9IiL48Ztq9qheHraxlDpeQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/VF/6dPosNBmO8ZWIJ7uVUSkfUdzpJuPDSiqk+7sURDnwxKDHQjAeAWnmRZevR8svqmIxvn5QCiZg3A+JXKOZ7XVb44X9c/GE7ewNTp58hmLGkmJx/mOA/6D7/j9N7gshWx14tZWB0sjRwA2UJPDRzow3t22zLLboIBIW6gU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Vftz7HtP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=6FoTuurwhJCTzhxL1K844VeX/g2bvcWy2Z6GNdQEJ48=; b=Vftz7HtPLbA1u3G6kUjaIj5GyO
	iT5a7S8KYNwVz/N2s6wHcRVL3g5SOzyaP1nm0At4lqwRIOp0eVo5wp69yNZPweF1i7KfCeH/Yk7GD
	vdmTkDWPWZGwdoFqkut6NK5uGyO3iOPxzJ/RDyNUs3q1afzWxv9AWi58oI0jNigPkkuy+suE/NlMK
	x6JLNG0Ynt8tcf28Oxc+MccN5TXzjEvt52NHI1yGLKYNQh/Acp3p07acFdKccpDs5ZQ0Tg48FFWRs
	cGz2arFS9JeQ6AUJsz4X0wicf7lb4hyG4EeJv30kUxAO5U7KRxCY1qPfuQivbQ5UjkY6LlIwDXH5b
	Sx8pEvBQ==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBL5d-0006q7-8A; Wed, 22 Oct 2025 00:44:25 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: net: rockchip-dwmac: Add compatible string for RK3506
Date: Wed, 22 Oct 2025 00:43:56 +0200
Message-ID: <20251021224357.195015-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021224357.195015-1-heiko@sntech.de>
References: <20251021224357.195015-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3506 has two Ethernet controllers based on Synopsys DWC
Ethernet QoS IP.

Add compatible string for the RK3506 variant.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 3 +++
 Documentation/devicetree/bindings/net/snps,dwmac.yaml     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 0ac7c4b47d6b..d17112527dab 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -24,6 +24,7 @@ select:
           - rockchip,rk3366-gmac
           - rockchip,rk3368-gmac
           - rockchip,rk3399-gmac
+          - rockchip,rk3506-gmac
           - rockchip,rk3528-gmac
           - rockchip,rk3568-gmac
           - rockchip,rk3576-gmac
@@ -50,6 +51,7 @@ properties:
               - rockchip,rv1108-gmac
       - items:
           - enum:
+              - rockchip,rk3506-gmac
               - rockchip,rk3528-gmac
               - rockchip,rk3568-gmac
               - rockchip,rk3576-gmac
@@ -148,6 +150,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - rockchip,rk3506-gmac
                 - rockchip,rk3528-gmac
     then:
       properties:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 1a0d6789a59b..dd3c72e8363e 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -87,6 +87,7 @@ properties:
         - rockchip,rk3366-gmac
         - rockchip,rk3368-gmac
         - rockchip,rk3399-gmac
+        - rockchip,rk3506-gmac
         - rockchip,rk3528-gmac
         - rockchip,rk3568-gmac
         - rockchip,rk3576-gmac
-- 
2.47.2


