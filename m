Return-Path: <netdev+bounces-203049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E45AF0685
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC821C02060
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 22:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63CA30207C;
	Tue,  1 Jul 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+TuSIH2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D16302068
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408652; cv=none; b=rnk7x7zioM1RYHGsQ3mx/UvBvYTOTeEZw8xYAMk+thULiL7lQlLzqPk8xZt+DD4xu1FCraL+nRG/FTzuVxoRZYvU/yz4q+Sc9st/kG9MMNvK2TmM1ouAw4i2m4zofhyjQoi/TMIbcd0vQfA5Sk7SLUJNtuuKMFDs9OKTSg94E6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408652; c=relaxed/simple;
	bh=SDqem+yN+CppwyZoFjrEVI6UCF4zuRL953lIiDNtguU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfpfryRhR1EH6ZcfwyUTA3qY60zuPBnaWwvzYkDfqN5CTvaQkb+fYkaoYsrX2RTC1GsADbGV3RatLBPe/ctQNU9zqyheaZosCusz1jSoMTGIwWPPqN1jhrife3RhCLOTTamY3XBkca/ToDfG8pEaoymAJ46jsV3Vd9GiYYDrBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+TuSIH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8568C4CEEB;
	Tue,  1 Jul 2025 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408652;
	bh=SDqem+yN+CppwyZoFjrEVI6UCF4zuRL953lIiDNtguU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F+TuSIH26s6a47ZWYVLaAyIhAOnJonFbO8NEHvVPk2wgwTVURyjh5R8iZgpHK1qco
	 8gHwKzzKVdJ4fyIameH4heIU+mqHopxbzz5RQYlfxYERF6zF87FnxZunuU8JiQ/98M
	 QiidngTbdGfA7Kuig/f9KXMG35h5tQ7apnUlSZrBUAEr1fBkz2WUpI5KuL8zFGrFsp
	 5Xf0ipiW++uQGCqCB+fnCXgErpv0OIbrgc+0OXtTXuo5K0LgcRFhwoJQT9z2GSeZHG
	 EQvOma+9zyn1nSsjx/Y+v2e0RaiWfu9gpMI1cz98/CB7hjkT5GFGfSWzV5WYxryJZ3
	 OB7FqBj/2E4TA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 02 Jul 2025 00:23:34 +0200
Subject: [PATCH net-next 5/6] net: airoha: npu: Enable core 3 for WiFi
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-airoha-en7581-wlan-offlaod-v1-5-803009700b38@kernel.org>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
In-Reply-To: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

NPU core 3 is responsible for WiFi offloading so enable it during NPU
probe.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 1cf431469ca034bbaeb922fed3ebdab41aafef05..3e30cd424085d882aad98a0e751743de73f135fe 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -877,8 +877,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	usleep_range(1000, 2000);
 
 	/* enable NPU cores */
-	/* do not start core3 since it is used for WiFi offloading */
-	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xf7);
+	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xff);
 	regmap_write(npu->regmap, REG_CR_BOOT_TRIGGER, 0x1);
 	msleep(100);
 

-- 
2.50.0


