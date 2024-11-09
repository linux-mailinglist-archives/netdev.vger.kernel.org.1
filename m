Return-Path: <netdev+bounces-143530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E92B9C2E1F
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 16:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4381C20D95
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDD61991A1;
	Sat,  9 Nov 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WjGXSk+p"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB2233D6B;
	Sat,  9 Nov 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165485; cv=none; b=eEnwz7MP/RSc1Z4kXJLSGgn+IDeTjbOzY98N2Bbjo3Sy9yX6AeweOdgbrVycpOI/mH7A7/Zq02v3qjflKx5PbJC8XM6JMxqrFJ26IZfkf1tYhWkLtFd0uaIiaG0hzCVjwhLZZxHkdKVHOOMGhcT/SEl1zbNfuZcakwzhOeRQpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165485; c=relaxed/simple;
	bh=r8pOJtwP+l+aThisZLQEzXRJelwC83jKXvQDLp3YZ0Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gvfNsLXeEQAXyxooxOBdWe/cbQJoXZMc+vJnduh+leP1b8/4lhvO46/eLRRa8MVAL/2IwyvC0oQ9DyJ+UsYxka3OkQHULHqi4Hkk1AqXWYOmrCh+U2zrdmiKB0WHuyh1F0tvzFLX9B2h8o71snPJgbAlDwvddfceCkzLRQhL80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WjGXSk+p; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731165476;
	bh=r8pOJtwP+l+aThisZLQEzXRJelwC83jKXvQDLp3YZ0Q=;
	h=From:Subject:Date:To:Cc:From;
	b=WjGXSk+p0nwTI4xqakbd1duOtiGya37aCquPOiYed+6/OSQ8BqGEZAH8o6aD7iBl+
	 Xdz1/YI9ZTLbGCJnocIykUcRbE7i2z6aKWIWv4PHML6J9c8oN1gxKuZHmfYNFAoDeP
	 8d4rDYV9LbmkrrkiQ7LERwE1LZ85bZQFcg389FNZCTsGEZm5EpGAOomwISwgyydUpo
	 Xhv4Wi1fHYa4Ww2fJRQw//ifCBcvVxnkIKDbirPmRM+9rrgVgYN34/AJb1aasZPFE4
	 4NN2h6lSbfIYud9pWlxwvbYtWhB7mTsMjT1HauXx7fLk/Ws/05i6XiO6IXkvfjibkP
	 6B2Vp7/vyZXzg==
Received: from [192.168.1.63] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4806517E35FA;
	Sat,  9 Nov 2024 16:17:53 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/2] net: stmmac: dwmac-mediatek: Fix inverted logic for
 mediatek,mac-wol
Date: Sat, 09 Nov 2024 10:16:31 -0500
Message-Id: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM98L2cC/43NTQ6CMBCG4auYrh3TQX6qK+9hWJQyykTomJZUD
 eHuVk7g8vkW77eoSIEpqvNuUYESRxafUex3yg3W3wm4z1aFLkpEjTBRz3amB0zWwUtG8OLZJwo
 z9YAn42pX6rI61ionnoFu/N7y1zZ74DhL+GxvCX/rn+GEoKGpOoNGmwYbe3EyjraTYA9OJtWu6
 /oF5fARncwAAAA=
X-Change-ID: 20241101-mediatek-mac-wol-noninverted-198c6c404536
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Andrew Halaney <ahalaney@redhat.com>, Simon Horman <horms@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

This series fixes the inverted handling of the mediatek,mac-wol DT
property. This was done with backwards compatibility in v1, but based on
the feedback received, all boards should be using MAC WOL, so many of
them were incorrectly described and didn't have working WOL tested
anyway. So for v2, the approach is simpler: just fix the driver handling
and update the DTs to enable MAC WOL everywhere.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Dropped introduction of new property mediatek,mac-wol-noninverted for
  backwards compatibility
- Set MAC WOL for every DT
- Link to v1: https://lore.kernel.org/r/20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com

---
Nícolas F. R. A. Prado (2):
      net: stmmac: dwmac-mediatek: Fix inverted handling of mediatek,mac-wol
      arm64: dts: mediatek: Set mediatek,mac-wol on DWMAC node for all boards

 arch/arm64/boot/dts/mediatek/mt2712-evb.dts                   | 1 +
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts                  | 1 +
 arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c          | 4 ++--
 4 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: c88416ba074a8913cf6d61b789dd834bbca6681c
change-id: 20241101-mediatek-mac-wol-noninverted-198c6c404536

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


