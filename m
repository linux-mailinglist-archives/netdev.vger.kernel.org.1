Return-Path: <netdev+bounces-141052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA579B9440
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57713B214CD
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC91C3F32;
	Fri,  1 Nov 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xb8gJSgb"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E741C2DB2;
	Fri,  1 Nov 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474454; cv=none; b=mW/NsQ4VJQB447XendzOrjGIfvmZkCD8ofU9XgO6JIAo1SzDRf4Z2qDMD5XpS2yKTVQhM7mtcBGcxVKATfeHFcn/CdRNg3pl9Ed3i1mCaWfqNcAZTM/9GkG10SMFxX9czxX19gu50R5Xuk+uIqeli0sKvVevW18FIN6pkMNi/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474454; c=relaxed/simple;
	bh=YB8pbQNj6sLlzicHNtt6ickDj4H2tEh5oQmtt87rcZk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eiHrzbzZlVhKBNS1Bhnt9dmZvZ4cGK1rdCRNieCTELT//fKh1ZInR6Y/loOgzDg/xFhwNkZr6UE+gvQASRqss3ZwgwE7gly3TlFcZbK4TrYdCzM86Y+aT90ex3CmHPqCzbqw1e6I7DoEy2DbRngz4Yla+aVSbHBQFJjMEtAPl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xb8gJSgb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730474445;
	bh=YB8pbQNj6sLlzicHNtt6ickDj4H2tEh5oQmtt87rcZk=;
	h=From:Subject:Date:To:Cc:From;
	b=Xb8gJSgbstBOSK/9BQ/qNdVRJAMkO+jB+8cY8xGLDCs/iWp4/0Sn7UETxT3IgWsXJ
	 IrwntJ4vr08+VH0IObdSPJVQeF9YX/UkJxVQCPCCtOXGxR1M2iFjXOuIA7bhEuHe4J
	 NzIyKzDpnZF39yCfg2dJA4xuXz00sIuRFuYhzLuGz16wQHEReMGImHkKgdDsKUvZoL
	 Q9tjLb/TvlECyDQAYZAp8cPICOow74R8tuWWYleSy54+unnKIYnPJh8elBdPamYs4Q
	 DRP9GhImM/TkPVAWEdVWKn+jqVIZhNQBT5eNhAnuDxPvtjChw3r2BHNK6fBYr0kr1Y
	 f48CNAojyQSCQ==
Received: from [192.168.1.214] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8410717E0F77;
	Fri,  1 Nov 2024 16:20:42 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/4] net: stmmac: dwmac-mediatek: Fix inverted logic for
 mediatek,mac-wol
Date: Fri, 01 Nov 2024 11:20:22 -0400
Message-Id: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALbxJGcC/x3MQQrCMBAF0KuUWTuQaWNRryIuQvLVQTuRpNRC6
 d0NLt/mbVRRFJUu3UYFi1bN1iCHjuIz2AOsqZl613sRJzwhaZjx4ilE/uY3Wza1BWVGYjmf4hi
 988dhpFZ8Cu66/vvrbd9/VYDmdG4AAAA=
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
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

This series fixes the inverted handling of the mediatek,mac-wol DT
property while keeping backward compatibility. It does so by introducing
a new property on patch 1 and updating the driver to handle it on patch
2. Patch 3 adds this property on the Genio 700 EVK DT, where this issue
was noticed, to get WOL working on that platform. Patch 4 adds the new
property on all DTs with the MediaTek DWMAC ethernet node enabled
and inverts the presence of mediatek,mac-wol to maintain the
current behavior and have it match the description in the binding.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (4):
      net: dt-bindings: dwmac: Introduce mediatek,mac-wol-noninverted
      net: stmmac: dwmac-mediatek: Handle non-inverted mediatek,mac-wol
      arm64: dts: mediatek: mt8390-genio-700-evk: Enable ethernet MAC WOL
      arm64: dts: mediatek: Add mediatek,mac-wol-noninverted to ethernet nodes

 Documentation/devicetree/bindings/net/mediatek-dwmac.yaml     | 11 +++++++++++
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts                   |  2 ++
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts                  |  2 ++
 arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts         |  1 +
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts        |  2 +-
 arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts |  2 ++
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts         |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c          |  9 ++++++---
 8 files changed, 26 insertions(+), 5 deletions(-)
---
base-commit: c88416ba074a8913cf6d61b789dd834bbca6681c
change-id: 20241101-mediatek-mac-wol-noninverted-198c6c404536

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


