Return-Path: <netdev+bounces-185477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F421A9A986
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278293AB3E5
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBCE220680;
	Thu, 24 Apr 2025 10:09:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDF1F4617;
	Thu, 24 Apr 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489361; cv=none; b=iAWdpFafVqWxhHkuYzFCgcQ7XcoS0QwaG0xHf8lwTmxHoLRj7O5IMZ7y8O0gr6SCWdAto+0Mz5VBzLZf4zXJrfw4OR81R98vE3L55I/nk9YBhj4mS+Q9Nen2CrPlnBaPraqenUjjcc4rLnp2PTUkQf2aett9h4fQrGoicbIXfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489361; c=relaxed/simple;
	bh=aTRP5MOUdrYudfIXeH7X1qFPiPt5o8uB0GSNLVO1Y3Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fmd08Fx3kempR3mK1/aGpTF8JMqk1wTnM7SWoBg+wLokQj0vl1kahON7E1n0HcFCW4Rub4nDipd657CzXOur/y/6ARkb9Jcwqi1BiDNaXYrbSiZ1j4ohrgfyyWg0HBMe1I/KXJQtbLe/vesHsXI9gKzhrbLfwzluqG2pQ926o7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 144B9343016;
	Thu, 24 Apr 2025 10:09:13 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 0/5] allwinner: Add EMAC0 support to A523 variant SoC
Date: Thu, 24 Apr 2025 18:08:38 +0800
Message-Id: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKYNCmgC/3WNQQ6CMBBFr0Jm7ZihMARdeQ/DotYpzMLWtEg0h
 Ltb2bt8L/nvr5AlqWQ4VyskWTRrDAXMoQI32TAK6r0wGDJMrWmQasyvwKwoD+sIWZoT2558d/N
 QVs8kXt978ToUnjTPMX32g6X+2f+tpUbCthNpXc8sZC+jhDnGY0wjDNu2fQFSbWT/rwAAAA==
X-Change-ID: 20250423-01-sun55i-emac0-5e395a80f6bf
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Corentin Labbe <clabbe.montjoie@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=aTRP5MOUdrYudfIXeH7X1qFPiPt5o8uB0GSNLVO1Y3Y=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoCg21wuR03eG7PJ5BcbAbEvSBCD2s6I1UGgiC0
 4QRFOwWOemJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaAoNtV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277UcED/41P2u7nuUUGzH+Nl
 RH0IcFgw4kRxzmS64sXWYjeWMg3ZTJsmZdlrMePlTHFpT5dyt5lwILhAahFQxmswPOyiEJz5QDZ
 enEhZOQNb2wn316NeTE0oQzcsZzxYerhMMQcSsT8pO6zNCq0dEixRV/yik60P9ZCmUqdqUI51NN
 NlOegqa70BDG04ab2t1Q5FlNqDp+TfSFL6Dp5IF+VcKLzMcQgWoyOXSH8Y8yEyUdQkCHl6qrgyI
 cQaypj/GjCf1zrQOx27Hr4mdprc5fm/6nL7AuadhA4Qmy+Ln5K5Cj9A+ydj8+RSMMKEwQI+3r0v
 M73RO/nDJmKdNTG7e4Y/CGHo7+fsKYseFNB1C+39ruUa7rmudnAX+TzpRM2mp2kuepALq1nWtG8
 R3SyqHSM46UQNnt8ueMREiOmynLNvPujhGfE5cPA0RrfjTAffqx2tOIGtSRgLNl731NtW0R138O
 f+591g8Da+aSCnTDvaehhifgMbWiZ4DeAWsB0VB6DoqwHVfH/idMFbTcKZQ7gSPd0E8Ot+VIItr
 toWl+nYX/lr0XFfA7xxCpZASIotWVbXTsdqcxg3waYs5DasLWJX0OC0bNxoUOFapabMa/4XiJW+
 qMQGkDHKz1eJGgHSs0dvSOIE8Sy+MN8aI7bkETD8k7ZY1VJn9+qPX58+iwQpq8PPoZlA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

This patch series is trying to add EMAC0 ethernet MAC support
to the A523 variant SoCs, including A523, A527/T527 chips.

This MAC0 is compatible to previous A64 SoC, so introduce a new DT
compatible but make it as a fallback to A64's compatible.

In this version, the PHYRSTB pin which routed to external phy
has not been populated in DT. It's kind of optional for now,
but we probably should handle it well later.

I've tested only on Radxa A5E board.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Changes in v2:
- add ethernet alias node
- add phy-supply
- change to rgmii-id
- drop PH13, rename pin name
- drop bias-pull-up
- collect Review tags
- improve commit log
- Link to v1: https://lore.kernel.org/r/20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org

---
Yixun Lan (5):
      dt-bindings: sram: sunxi-sram: Add A523 compatible
      dt-bindings: arm: sunxi: Add A523 EMAC0 compatible
      arm64: dts: allwinner: a523: Add EMAC0 ethernet MAC
      arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board
      arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1 board

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |  1 +
 .../sram/allwinner,sun4i-a10-system-control.yaml   |  1 +
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi     | 40 ++++++++++++++++++++++
 .../boot/dts/allwinner/sun55i-a527-radxa-a5e.dts   | 19 ++++++++++
 .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts   | 19 ++++++++++
 5 files changed, 80 insertions(+)
---
base-commit: 69714722df19a7d9e81b7e8f208ca8f325af4502
change-id: 20250423-01-sun55i-emac0-5e395a80f6bf

Best regards,
-- 
Yixun Lan


