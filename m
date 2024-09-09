Return-Path: <netdev+bounces-126611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F0F972063
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98AAB22915
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE917B401;
	Mon,  9 Sep 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2+G+/XH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5F173328;
	Mon,  9 Sep 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902650; cv=none; b=QVrs8L3WOWO5Msg6TsO3/h1JAiIFOzT14AhOy3q7/6CmhyQc5bsMJitK0ZMoNXq/zlklh/wTOs5xHAjUFsaUFyJFx5UTX0sTyVdvKzhazWCvnixP+uPu+Qs38ShuiO8UbpheRbf1T3Wg6XKIKF1vhDbYVPkc64jn9AuLQqruI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902650; c=relaxed/simple;
	bh=RA3HARXHwHsFdKkowqZX2MlM4vFFTmpEgk6U7rVwfvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNfhVZUi87JWG5CF27G43h5HzQKHmeotSSYhWLa01ETBgIXYBXOPjXPwUfXkkcRjDigiz89RcMN0cHoEgS4Tq6MJein5vmeSroMfuNDYt+vbMtXR7bbdiM1BStq7KBfKt4ecofFQMGlXXbgDOeRlOmz1tTHD18C6xUkhh81h0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2+G+/XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67EEC4CEC5;
	Mon,  9 Sep 2024 17:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725902649;
	bh=RA3HARXHwHsFdKkowqZX2MlM4vFFTmpEgk6U7rVwfvA=;
	h=From:To:Cc:Subject:Date:From;
	b=B2+G+/XHBZUQnA4GoEUqhzdJtSoIn9iFniWw6bSrO83ULbPR+6DGn13YuxJuiV26k
	 Xdz/85WtITZgwac+hBhrs23UBqrDkkUarfdaXFQhw6hDzIpmHYvr9934Lv2+YnWjWo
	 KzxRYd10k8JhZ9xSj5wc/rSLmUCfR8iO7KOc/lcWrm5cjBH7Qk2F021/9nv1iwP3zU
	 nSPC6ZwHElhYQMjeOcmyiklcMps7lz6hSA6vAgUReZbU2VdTviETXFeDs4s2Ar04Ns
	 aTRKHe2gYG1pB4G6jsyfh5tLHNHs0OxhyZnzHrVtCSD8tdnHzcF/5Q3F5U9jRk9ogq
	 9T2GVybY02J6g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: amlogic,meson-dwmac: Fix "amlogic,tx-delay-ns" schema
Date: Mon,  9 Sep 2024 12:23:42 -0500
Message-ID: <20240909172342.487675-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "amlogic,tx-delay-ns" property schema has unnecessary type reference
as it's a standard unit suffix, and the constraints are in freeform
text rather than schema.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index ee7a65b528cd..d1e2bca3c503 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -58,18 +58,18 @@ allOf:
             - const: timing-adjustment
 
         amlogic,tx-delay-ns:
-          $ref: /schemas/types.yaml#/definitions/uint32
+          enum: [0, 2, 4, 6]
+          default: 2
           description:
-            The internal RGMII TX clock delay (provided by this driver) in
-            nanoseconds. Allowed values are 0ns, 2ns, 4ns, 6ns.
-            When phy-mode is set to "rgmii" then the TX delay should be
-            explicitly configured. When not configured a fallback of 2ns is
-            used. When the phy-mode is set to either "rgmii-id" or "rgmii-txid"
-            the TX clock delay is already provided by the PHY. In that case
-            this property should be set to 0ns (which disables the TX clock
-            delay in the MAC to prevent the clock from going off because both
-            PHY and MAC are adding a delay).
-            Any configuration is ignored when the phy-mode is set to "rmii".
+            The internal RGMII TX clock delay (provided by this driver)
+            in nanoseconds. When phy-mode is set to "rgmii" then the TX
+            delay should be explicitly configured. When the phy-mode is
+            set to either "rgmii-id" or "rgmii-txid" the TX clock delay
+            is already provided by the PHY. In that case this property
+            should be set to 0ns (which disables the TX clock delay in
+            the MAC to prevent the clock from going off because both
+            PHY and MAC are adding a delay). Any configuration is
+            ignored when the phy-mode is set to "rmii".
 
         amlogic,rx-delay-ns:
           deprecated: true
-- 
2.45.2


