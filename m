Return-Path: <netdev+bounces-173212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB011A57E9A
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 22:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A6A16E37E
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 21:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D34420C468;
	Sat,  8 Mar 2025 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ISGMtoKr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE8B1FC7D9
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741469863; cv=none; b=nqcP9bvVIOWW3Q/gj7KAB6nqjnOVbXbWxY3CKVEe8UP3f5SgXYYh9M+2CqoUV7HtmYMztm5+LKtNAvPUcKIrHiOvR9IuwH4oUklA4UnNBKKVdbrP91EQ0x6Kv1+F5yZxP8cwnJd+oaoEft8DCcMQQH8qvbtIOqtrvqnKAHY49Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741469863; c=relaxed/simple;
	bh=IPDNMr7X/K6yxoN9T0fftTf2PAkwAWDcRKsEdq7qczY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckPC3b2sLwdo8Wn+d7HWLZRc4lqpYqoLiC/E9wsJTx7KruoXq2xsloxcGUSbOapcXhR5dCvchPeNL1tROdwGK0/SiU8t+HNLTHa5OkwbYi0rm/48ysK4B6YqTLxSSV+BJN9qF64ukhZgoIIE4S2MjW0DNyb6c0lYCLcvOCbdr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ISGMtoKr; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741469861; bh=I/ujcC5nq+Y57EaiIBIvtCu4qYPsR76utxdU3XJmP/Y=;
 b=ISGMtoKrcwxwTBpiyLgkxscTmJ2pNDq31IhZD3YzYid6UOCovtW5J7tmk2/ERYuqg/cqRPiRI
 rsNsdQXdlEdih+v8NbauzBQSY0AKv/j63KCqDDRcqa7UnE53NdEpldOjqbfCrevIUjDVlpIZD3D
 VMqVmtOYkeSH1Rm5jKp4sf7u7T1vWZpJsXZK33x7rwfGdW2BH2Y0XSXD3nmzZVBteD6ojS6jdeS
 kEzm+aKkGChzVThf/4zhq8dMxOI7zUHizAmr6EtAsmU34/Q+EBeHgtoT2tSc7N5MwanZ2GqNcZP
 Mr5jS3ME6cGAFcNw+rrwZyFaF6MM/24B3mQUfhilgqWA==
X-Forward-Email-ID: 67ccb89cbfe70eb1bfc13b09
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/3] dt-bindings: net: rockchip-dwmac: Require rockchip,grf and rockchip,php-grf
Date: Sat,  8 Mar 2025 21:37:13 +0000
Message-ID: <20250308213720.2517944-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308213720.2517944-1-jonas@kwiboo.se>
References: <20250308213720.2517944-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Rockchip GMAC variants typically write to GRF regs to control e.g.
interface mode, speed and MAC rx/tx delay. Newer SoCs such as RK3562,
RK3576 and RK3588 use a mix of GRF and peripheral GRF regs.

Prior to the commit b331b8ef86f0 ("dt-bindings: net: convert
rockchip-dwmac to json-schema") the property rockchip,grf was listed
under "Required properties". During the conversion this was lost and
rockchip,grf has since then incorrectly been treated as optional and
not as required.

Similarly, when rockchip,php-grf was added to the schema in the
commit a2b77831427c ("dt-bindings: net: rockchip-dwmac: add rk3588 gmac
compatible") it also incorrectly has been treated as optional for all
GMAC variants, when it should have been required for RK3588, and later
also for RK3576.

Update this binding to require rockchip,grf and rockchip,php-grf to
properly reflect that GRF (and peripheral GRF for RK3576/RK3588) is
required to control part of GMAC.

This should not introduce any breakage as all Rockchip GMAC nodes have
been added together with a rockchip,grf phandle (and rockchip,php-grf
where required) in their initial commit.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Reword the commit message
- Disable rockchip,php-grf for other GMACs than RK3576 and RK3588

The pending rockchip,rk3562-gmac compatible [1] must also be added to
the list of compatible that require rockchip,php-grf.

[1] https://lore.kernel.org/r/20250227110652.2342729-1-kever.yang@rock-chips.com/
---
 .../bindings/net/rockchip-dwmac.yaml          | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index f8a576611d6c..8dd870f0214d 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -32,9 +32,6 @@ select:
   required:
     - compatible
 
-allOf:
-  - $ref: snps,dwmac.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -114,6 +111,24 @@ required:
   - compatible
   - clocks
   - clock-names
+  - rockchip,grf
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-gmac
+              - rockchip,rk3588-gmac
+    then:
+      required:
+        - rockchip,php-grf
+    else:
+      properties:
+        rockchip,php-grf: false
 
 unevaluatedProperties: false
 
-- 
2.48.1


