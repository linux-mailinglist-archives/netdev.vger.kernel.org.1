Return-Path: <netdev+bounces-209425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD664B0F8E4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEB61CC04CD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681EA21A457;
	Wed, 23 Jul 2025 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adh1z0Ja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F11FE46D;
	Wed, 23 Jul 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291221; cv=none; b=fAfHTMKgjXpyXzqYFTLP19hSVZ+EhPJZtcbX+0CI7R6NBR4MkQ+QK5Xy3uT8wRfuzAnOlCS3P/jwfnokkrNSA8nWLL9ozIaBqbW4TZ79N42ncVv2rmleb39g07aHu73uLxE7Vfhcx2yIEONIUEgrkdvJRtnMzcmFaOXAFsNjQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291221; c=relaxed/simple;
	bh=C6h07MIeYF/IWpw/c9BwXgLL1ekelXtBh8YVwLIY2ZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOpn41LgfVLZeQWlcr/4xY7VgV3o91vRYiy+oqIq7XfiPljzL1MHiNr6g5GRM01mHUXbftOyPCFq/0kZXmg7GSB0IE1GQM/v9nrsZVcihhHSYM1HWucfaKMa2jg5dgZGSO+ww8Rol+ZkClC1rsfJ4zxVc0oQF4NVt85a3prv3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Adh1z0Ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EA7C4CEE7;
	Wed, 23 Jul 2025 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753291220;
	bh=C6h07MIeYF/IWpw/c9BwXgLL1ekelXtBh8YVwLIY2ZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Adh1z0JadfgTJARCg/R/TaC81TOHC8PPpXrGxo8ttftcO8Bwpsh0sB67jier4fWNS
	 7yc83VQMslsCVCkvsT1JSbBHlHaWIQJf3i0HQNtkxoLtfJCTAbCyVwkicNO6393swL
	 FdcQlM0jgO+pbJCkNq/wnX+ABkyoSB9wtWXucke1jb+T0ufoHkX+tWQ/WajfkgjFKJ
	 RAaAjSUpqCYvg3Qai7poei1dzofXBnhyFiBsAc9Y1Hf0BM4OM5MvefSvOQRG52+o3Y
	 gRxSxKu9OWW9J0q0vnsG/zE/hWOsgF0qy3/TJJhGqirDx4/PaJW/Wbh+EzMpsd2teG
	 wEnDVCXvIadAg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 23 Jul 2025 19:19:55 +0200
Subject: [PATCH net-next v5 6/7] net: airoha: npu: Enable core 3 for WiFi
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-airoha-en7581-wlan-offlaod-v5-6-da92e0f8c497@kernel.org>
References: <20250723-airoha-en7581-wlan-offlaod-v5-0-da92e0f8c497@kernel.org>
In-Reply-To: <20250723-airoha-en7581-wlan-offlaod-v5-0-da92e0f8c497@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

NPU core 3 is responsible for WiFi offloading so enable it during NPU
probe.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 90bb61d6c09d0dc874b7f5b874606d34a812aa87..af3604daf87e68e50a3b8c6e8b8fa2ffac64be80 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -725,8 +725,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	usleep_range(1000, 2000);
 
 	/* enable NPU cores */
-	/* do not start core3 since it is used for WiFi offloading */
-	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xf7);
+	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xff);
 	regmap_write(npu->regmap, REG_CR_BOOT_TRIGGER, 0x1);
 	msleep(100);
 

-- 
2.50.1


