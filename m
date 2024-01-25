Return-Path: <netdev+bounces-65826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A090683BDFF
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307AC1F307EC
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890071CD13;
	Thu, 25 Jan 2024 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UozhGrAK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F51CD09
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176381; cv=none; b=eUo2/VrVjtT2aMYZ2OBByH4RcP7AlOWLaWVuU/ulaf8rNVMaDa+rEPrkaZp1s7CENb1MYJm5HWNO6HRldbYJbDQnJalTNoGiqh2POwTOhZYA3WE1qPpF8myA7EX/yMBPE0sHxw0B7cu9/0WHKM+PlEUZroBMuNeAHzV7+Amfb3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176381; c=relaxed/simple;
	bh=u25TQi/eCQzC6TkwHDavOWDYLYRf4oNMi+35yG2C16I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHolOIESl6QeGWTuIGZyNm6NOUi4TczqzGZ2sAo2AZbvy6xOkzKfx6kqIEmRiCbOn1jfUyBWvoh/OQ5tPeGMXgbueXzi2H/UklDmgygM7zLhLQVEZdpWPLN50q7dIy+Or6iTVUvPW/OytBzmU3dPTUVIYNSr1cVLDHGD1XNYcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UozhGrAK; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd6581bc62so4442191b6e.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706176379; x=1706781179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwHQQ3y8mRIC5l7GJR/3O2cr3VUs7tVDE1ZJ0OPgKKc=;
        b=UozhGrAK9gJVtTbSEPb//zh8wAFymQqVEBy7InQ12SzZc5ARf5Eb7M93dmLIhki/EA
         JhDC5fXgqPlWipQJ9aUvmj2pKBSj1Hidi9NzJtMbgPsJkciPTrf6s8Jh3alfhr2NDq3D
         T4tu3plSujc4TxrUEVIqpZsbk81cQGX65wQVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176379; x=1706781179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwHQQ3y8mRIC5l7GJR/3O2cr3VUs7tVDE1ZJ0OPgKKc=;
        b=aBuCnirK/rv6xMhClc8NPOzpoZGqqkNrJCXDjAXO0wWsDTCZ1HZnWwWyfHM6JY3rHT
         1lemzGKiaZjJ2U7ujhn7itVsvImO23VmdqE2yhdjmMHXdjXRslzgaPXGckmfxAj4+980
         emPdmIbwPxwU0Og5LSWPvDqETHd0zXXux9xAnxkBB2z3CcFmnrlAdxb3mtU9uYS/QIeK
         FIcikt3RSw7D/sEW8FOIV7TH6Vq755Bw1U+2Pxc6zkNhUpTvJ5J4DUpQULZ2AI6QE3jP
         pU4xFQRAMNd5kegBIStQkJTd3+MauxTlGDraDtZqJ248nd3+5HPaVBs+wdsxeOm2lm25
         1b9A==
X-Gm-Message-State: AOJu0YzpqiiK1mHE33VI3L4KpWYcMT+3GBQr4DoIu3vjgM0KFEEisd30
	kuRAEpzA1wz4xolgY4P2cM753aVKHKcaLzwdU6aGAJKyvYkTwKX9byg+rYy3sg==
X-Google-Smtp-Source: AGHT+IF9ouqrxuN/kDRByMxn/PlL63gtfiQf6zEmcMi2K5+Vu4orKTJyiaEsZI9CeowBst0wk6XIzQ==
X-Received: by 2002:a05:6808:1911:b0:3bd:c038:b71a with SMTP id bf17-20020a056808191100b003bdc038b71amr770409oib.25.1706176379179;
        Thu, 25 Jan 2024 01:52:59 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7fb6:ed02:1c59:9f9c])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b006dd8a4bbbc7sm3228275pfb.101.2024.01.25.01.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:52:58 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node
Date: Thu, 25 Jan 2024 17:52:38 +0800
Message-ID: <20240125095240.2308340-3-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125095240.2308340-1-wenst@chromium.org>
References: <20240125095240.2308340-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bluetooth is not a random device connected to the MMC/SD controller. It
is function 2 of the SDIO device.

Fix the address of the bluetooth node. Also fix the node name and drop
the label.

Fixes: 055ef10ccdd4 ("arm64: dts: mt8183: Add jacuzzi pico/pico6 board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
index a2e74b829320..6a7ae616512d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
@@ -82,7 +82,8 @@ pins-clk {
 };
 
 &mmc1 {
-	bt_reset: bt-reset {
+	bluetooth@2 {
+		reg = <2>;
 		compatible = "mediatek,mt7921s-bluetooth";
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_pins_reset>;
-- 
2.43.0.429.g432eaa2c6b-goog


