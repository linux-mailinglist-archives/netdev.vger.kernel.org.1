Return-Path: <netdev+bounces-66116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F183D4E1
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 09:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F29285320
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E9E1DFFF;
	Fri, 26 Jan 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKA/3TXG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F291DA3F
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250914; cv=none; b=jUZ1Vy2ymsFJ6AIGThxG+ZItrgDrpxRILMnJXtmW93LM6za/1xTyFGazf5tbrm5ontVXDhUZrPf8RCDfjoLv9dOzLONVVE1yzghKpF8VTkil8enGB6cd/p3Ca7BkRIGmJ65onJze0fTb3kANhUnMppAZDfWiRxQLzKvI0gNhPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250914; c=relaxed/simple;
	bh=crqtlQZPAGF9IP0JqUMkmEhjwAwKUs1v7HhOiB2r0og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvbOIZIPFUGqDisg2OQa04UzFx9nu5yJnRVFYKGVHeagHlHm9LC+EWVa97+fLRBCd8KGsOgblJr3U3QTQhmOb5pzwk6yd78NIlvL6bMsjrrX88i21qZhi5tA3rLgaSg706BJVC9oIsexkxkOj6R7uteJNhtDbkJTpNClUpdFrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DKA/3TXG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28e79182570so16724a91.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 22:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706250911; x=1706855711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuuqWS/zETzQP4dBpV3f94YH5YVYzrmMgulqqtiHf0Y=;
        b=DKA/3TXGuY8Hj0RMDyBWAdyDt2y2ICDLnEEtCFtYAH0fstLQLZt6FV4NpdtsFsgn7r
         zxK8PdHMdXBsXLtKSeIwfmahc6LL21GCRZlVyKlS4lwgGLRXB/8isLrGDjrBcY5DS0S8
         UT3LWtRQTNh1uWOP6q/e93j2rs0QeEcLjEdVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706250911; x=1706855711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuuqWS/zETzQP4dBpV3f94YH5YVYzrmMgulqqtiHf0Y=;
        b=iP5toCRUSL48a6bl9+TPQCv/lqa5WzQ3jo9GW/rdzO7Rs4T9L8EZoo4oZRo87Hy1im
         WNHmRlcsbIEaU4U8wXsBsjisg/6L5TlKS3/Eynnx8gTj3ofG+AyYIAEWeWd/0uJS4OoF
         iOkoFiBYLBPCJc6FYyIEJ3i9AL9NMQEect9iaxsX3ffwXn8F/Aka0xJEPK67Uw30GCuH
         oreac0RxnU1GL5WYnkz6UITotDP9E+KYxNwNXAwnEtA1Q8KYAR1jato1aoG/lcVOLkZH
         79LTcu55bI3SyFdhbgfWVnq9A7dNEQjzijz1nWEgFPsx+kPuPSyXh/bM11/q3RrweFXW
         t8uA==
X-Gm-Message-State: AOJu0Yz0GX1jAD2csvfrmKye/JbK/1+DWYqJLUBMkWhuTMUpEh1P5AO1
	K2qGqu4+0xf0GXKwJLnh13bPgmrLlSZKbn6qM/yRS18pvQzy9U9J8NgDwe4NNQ==
X-Google-Smtp-Source: AGHT+IFs+9WlKz8MghdgDvZcD36shY1/fh3wT7sOOIqi0oykByBuVo1+tb7sfuf0UIIKn6b50YL6fQ==
X-Received: by 2002:a05:6a20:d805:b0:19c:8eb9:5d51 with SMTP id iv5-20020a056a20d80500b0019c8eb95d51mr101790pzb.43.1706250911400;
        Thu, 25 Jan 2024 22:35:11 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id ka3-20020a056a00938300b006db13a02921sm488735pfb.183.2024.01.25.22.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 22:35:11 -0800 (PST)
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
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node
Date: Fri, 26 Jan 2024 14:34:58 +0800
Message-ID: <20240126063500.2684087-3-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126063500.2684087-1-wenst@chromium.org>
References: <20240126063500.2684087-1-wenst@chromium.org>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes since v1:
- Collected reviewed-by

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


