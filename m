Return-Path: <netdev+bounces-172635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43AA55973
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB193AC1FD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3B278102;
	Thu,  6 Mar 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="RL5ie8Vb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCFE25C708
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299260; cv=none; b=Gb04TJh0LorTV2xN9mG2WUrg2aG1sxpAg8YGjMKsAOXPTkQucPqrzObqdHikoKhLLuUKoxNrG49SCa+YE3Gtv1fO8CyAiiolKm5cuP/SFqEJChcQcNImsVadeYIO6NDLWEbrz8eyA/4jYot2y+4FtAT3KMvEYZH+iAwAWuVJY1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299260; c=relaxed/simple;
	bh=cCoP6aXG4yPoXwVcoUk7nKLL2NAgfPX8X1apZ4tN17A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0KZOpZIJo3LtkSWGY8dk2Vnz992frwjA9jVckCdb41b7iegw+3NT6OrtAxd4lIbxNotwCopQOANqRJNf9v4Lseyrgd6ltmA0pjYYL9w2x/SReITNNZTLtgnTH0o22C2Y7fcJiIgV7dqDv6Js5UHB1tzj7BwIcsRVSiE5mjhtns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=RL5ie8Vb; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1741299257;
 bh=ywH7Q8mbcPn4w2SCHmS2eCxM0WaPqI6rsN6MI+52pMk=;
 b=RL5ie8VbZAatOzmJn5x2+rIQkqCoAR3DZE10WHfC5HvAzeAmFRHXM73xugIDes+B7K0lkU3Bq
 wsd2ofBnjcr7tluzfoQI6I+C6PSw1N11WcAA5CBEOjacmHwVPI7c2eZqYaaCd60kzMhR0lY0Gx9
 Np11SOJEaDAkyT+PINunkF+QyNEt3Bs0lamCZ13QF28twSVXOqLqyUbpc5CnUpwVXf2K3JbNC6Q
 n/cKAz/XZPuk3WRhX+oammaROSXXa5W0Ayb9u1aNPwycsm3YsK0/aXcND+ohl5bhVc4ZjsMhfgh
 o3c09zpQqiz5UeeMmfcbMSDcwT7JXzPKbmYZ9ngCQKFQ==
X-Forward-Email-ID: 67ca1e30c1763851c065bfe9
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
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] rockchip: Enable Ethernet controller on Radxa E20C
Date: Thu,  6 Mar 2025 22:13:53 +0000
Message-ID: <20250306221402.1704196-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip RK3528 has two Ethernet controllers, one 100/10 MAC to be
used with the integrated PHY and a second 1000/100/10 MAC to be used
with an external Ethernet PHY.

This series add initial support for the Ethernet controllers found in
RK3528 and enable the LAN interface on Radxa E20C.

This only add a bare minimum gmac0 node for the 100/10 MAC and skip e.g.
parts to power on and off the integrated PHY in GMAC driver becayse I do
not have any RK3528 device that make use of gmac0.

This series depends on the "net: stmmac: dwmac-rk: Validate rockchip,grf
and php-grf during probe" cleanup series to ensure bsp_priv->grf can be
used. And possible also on the leds+buttons, sdio+sdmmc and sdhci series
for RK3528 for a clean apply.

David Wu (1):
  ethernet: stmmac: dwmac-rk: Add GMAC support for RK3528

Jonas Karlman (3):
  dt-bindings: net: rockchip-dwmac: Add compatible string for RK3528
  arm64: dts: rockchip: Add GMAC nodes for RK3528
  arm64: dts: rockchip: Enable Ethernet controller on Radxa E20C

 .../bindings/net/rockchip-dwmac.yaml          |   4 +-
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   |  30 ++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      |  92 ++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 132 ++++++++++++++++++
 4 files changed, 257 insertions(+), 1 deletion(-)

-- 
2.48.1


