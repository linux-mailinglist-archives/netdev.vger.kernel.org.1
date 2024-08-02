Return-Path: <netdev+bounces-115393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE629462A5
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 19:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBA11C237B3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC10175D47;
	Fri,  2 Aug 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B2M71UeZ"
X-Original-To: netdev@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642271AE027;
	Fri,  2 Aug 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620304; cv=none; b=qw9FUvpaKATNrqJEKEdhd9UyvSvSO8Z6+kYGLWN0XA+kWw51eQLzeZ7B0jKbDhYRrUb1NrnDTgIqtETYUDiM1Z74/0cJZTfEX7+rufYJScxRmdySaBdY1Z9gT78WJDslqCxhcckLAY0g3dAMuOU2x/VMD7fWg2hxBBARyX2hg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620304; c=relaxed/simple;
	bh=yAlTnGU4w8bJ9MfhSOqijWWEGEsFRjOGvMDeEAH/2lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRifR/k5a8APTVuVfsDMf3A76lIJIUKzQePvGC7AWEKVgdDDuHxcZcXhgpDyKtfOWjFGIWi4lri/xSyliVxVdUsT1bMGFRie+gneRvPajt/kCxdvfp2V8BBwyX2ZVncMYpBMJ0JxwXyVKAjEJDcP6YtaLDqc0dr/o7yCOQ4VS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B2M71UeZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722620301;
	bh=yAlTnGU4w8bJ9MfhSOqijWWEGEsFRjOGvMDeEAH/2lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2M71UeZS/1//8rW6T+vwT/iJ4wzxF3WXs00mOj/ck41ays+0tyBdWmetLcPcAten
	 8sT17r3likqY6OidqjZa6hRTa7s6xdFnlfj1KfpvXMssOQQjFMJwN2vgDjvq93s3qO
	 pMZ2LalbxvemDJZNicYObGNekIH82E76mxwi8GdcBD/+dwWgn7K9FlGqKUACHjPMw0
	 rxeMpifLYMtJ9Tz9eOgymQINNS3zj4AOHKtRHixFvs8TgTcsCogFReCQIQF7EMjQAo
	 iBxfo1PAZmifB2YmHCyQkxsuDau5J0L+EUsm0lvXRYZiCH87xFL6xAsM4O77jR5ay7
	 WYRudslX+Bswg==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 75617378221B;
	Fri,  2 Aug 2024 17:38:18 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	David Wu <david.wu@rock-chips.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	"David S . Miller" <davem@davemloft.net>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 2/2] dt-bindings: net: Add rk3576 dwmac bindings
Date: Fri,  2 Aug 2024 13:38:03 -0400
Message-ID: <20240802173918.301668-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802173918.301668-1-detlev.casanova@collabora.com>
References: <20240802173918.301668-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a rockchip,rk3576-gmac compatible for supporting the 2 gmac
devices on the rk3576.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 6bbe96e352509..f8a576611d6c1 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -25,6 +25,7 @@ select:
           - rockchip,rk3368-gmac
           - rockchip,rk3399-gmac
           - rockchip,rk3568-gmac
+          - rockchip,rk3576-gmac
           - rockchip,rk3588-gmac
           - rockchip,rv1108-gmac
           - rockchip,rv1126-gmac
@@ -52,6 +53,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3568-gmac
+              - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
               - rockchip,rv1126-gmac
           - const: snps,dwmac-4.20a
-- 
2.46.0


