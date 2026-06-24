Return-Path: <netdev+bounces-301576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BrrOJKGZO2rMaAgAu9opvQ
	(envelope-from <netdev+bounces-301576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:47:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0146BCAA0
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:47:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PSzkpOcC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301576-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301576-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEDE63002908
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677FD391E7F;
	Wed, 24 Jun 2026 08:47:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6BE25B092
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:47:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290840; cv=none; b=c/YtmTVODqh4s6y+NAs1Apei1vmWvfcE9mECsYS0EV8PWSZRqWEt9dzLIC1F9MIUBzW91GzUVVQDDUXBRIOLVvipCSmd/2SrMXknaCpnaIunMXBac8qk/yEwYOhyMuoOos13FQccW0N8aJ3L6XOWUvAodxreehhQvE48oh7aEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290840; c=relaxed/simple;
	bh=8DnGaGhGF2q1/a03FB7kpaA8OczPo2IgyWm3JdknUfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ej7bYFP7TSiEcz2rZ2ONy72Swt6ik7bPjouwLuyj2hnve/+9RFT0xCBThutBGBSJy416Wy9pE/QVHpDhtE0x2HyfvYbLUTfurkNYXGOqZHFv3Dt/rs+Ewd3FJ/kD/ICbDGCYCiRQdWTRZxxXdi5ll+WqfqF2ac/Fd+GxRDa5LE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSzkpOcC; arc=none smtp.client-ip=209.85.216.66
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so333394a91.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290838; x=1782895638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4o4WYSufJQ01exYcxPhmyweb253Pa1dolXAna3IPCA=;
        b=PSzkpOcCMv5aZCD3GV+1pnLCPsGvfNYsYQKYDSB7eyvYWO2WH4yLlIH910aOQ8Yxzm
         LZjW9a4CpJs4afnrzZWUnLJDkVRCENGgRHj76bDYmgyUFjI9FCP1QB1Qe31XvL+UUiXk
         +GZousNPmQYHnfaVX9QbqQPeuyxMdj9qBXk8XnK4WMqmHfqZpNn/eLE89aJozEKcPgxQ
         17G6C91leGP8Db7wpnjFqlsCWHkihlzqRnbDStd5kISNaMuv1aLZSwLWdGz3J74f+cah
         4yfLd282TNmNDAnITjEKkGq5ZD+hBTkOVtukrvJtt/tfz3Mv1xl+6xG1HKq83tTmw3FM
         x+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290838; x=1782895638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/4o4WYSufJQ01exYcxPhmyweb253Pa1dolXAna3IPCA=;
        b=SPSZbgAwVQ5F6OOc19dUY2/hfSqE0Q+elf6ChRg5T/CzrmoE1DYx7cwJVUkevdgdNq
         C6EO/lUr/CtRad58ouC54A0WqDOE/eI9IYjdlMHjze1Vz92WngBdsiqEGIqX4Zk1O6YG
         4giHNCsiaHkDvioGBWGGHhE+4dNcAWIsD2f5j1oBuynhteQMGe3nG3NaFtsrKY8oLPAe
         Q0xLNw9rnh2qjQ0WUp6UpAN14zleTeMCfZwux8p4PFL/eWaOor9XFoi13MAf+3ghUHCd
         Zp7mDhJ2GT+l5o2jRW9erirNS/4uJrokFfvnPJCSUqozmtwJUqDwRd8jWn3iYRmaeUqi
         1E2g==
X-Forwarded-Encrypted: i=1; AHgh+Rrj5cnVSCIfmIP0SS5OQdyrxDCwY19q/7sMwNw9uyGFAMAfqbC3C5CH++kvQBSUJzX13GLEQc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylY/JASMTMXLI2NZAIxC7MWuoZ/9+USEK2UiemHCqbG5f0P3yN
	+21kdtuSG/G2OSBRXvfSy6Pi8XZncXTmF4EbgegVSR1imKKyc5aXybxy
X-Gm-Gg: AfdE7cmPIumrQ0Vm+WR/wvqFwYzB6YV3FKvSn+sX9zXyfA1Y0+ULPs4MukF8IaJojZe
	xIcUOBJr3pGubF1gZfoYw49fjRDgDc1od3AY15iSYvJKT8PVjWmWjfyxDhJHr7uP3xvIs1bZlHA
	vwi6qvmeP6wWAM1NTykl3Wl0SyxXyVWKkkqHigcLTP7BcCr7nNiudvD4Dsh72mzuG5t/AoIJ/jm
	UhHCLWH0RhKC0PJvjdCX8AyS3nVE7aG4KCkIbTicuxsvromPE/Q+nEt0G1ji1LOzn6uB5afP9Vr
	kOcqfsL6DRQsF0ygh7wyFGatbH8iJCORm8hveb8gU7DO1jCtA7WOPllSjb9dFsS5GspnbBLq+/H
	+n3OZ8WftKhq49Yo6oWvbO0XX+IjjKj9LDGlOwVyljCDRoGNc38k+6sse5sL45Ke07/HzfDqcPP
	PKtoksq0Dn8Nu6rYfOWLh3VD2m
X-Received: by 2002:a17:90b:3dc3:b0:36d:f28b:72e0 with SMTP id 98e67ed59e1d1-37de42395bamr2280839a91.12.1782290838541;
        Wed, 24 Jun 2026 01:47:18 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3d152f4sm2138146a91.14.2026.06.24.01.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:47:17 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Wed, 24 Jun 2026 16:44:43 +0800
Subject: [PATCH 6/7] ARM: dts: rockchip: Add RV1126 I2C5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-rv1126-alientek-dlrv1126-v1-6-5aef608a3f64@gmail.com>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290789; l=2080;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=8DnGaGhGF2q1/a03FB7kpaA8OczPo2IgyWm3JdknUfY=;
 b=YrCE91tKnr6J0OxbIju8J9llVy/eKVFyENAfkCGsxf50FuzCPU5lW0+qINNmUO0ziOrxg/4bN
 2UxDIGsPfkWB7A5GzEjXLLSyplZa5jrmv1yvPfGxXM2WoonVvpq4CIt
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:grumpycat921013@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A0146BCAA0

The controller is present in the SoC and can be used by boards for
external peripherals, such as an RTC on the Alientek DLRV1126 carrier
board.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi | 10 ++++++++++
 arch/arm/boot/dts/rockchip/rv1126.dtsi         | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi b/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
index 35ef6732281f..1d883b80aed4 100644
--- a/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126-pinctrl.dtsi
@@ -123,6 +123,16 @@ i2c3m2_xfer: i2c3m2-xfer {
 				<1 RK_PD7 3 &pcfg_pull_none>;
 		};
 	};
+	i2c5 {
+		/omit-if-no-ref/
+		i2c5m0_xfer: i2c5m0-xfer {
+			rockchip,pins =
+				/* i2c5_scl_m0 */
+				<2 RK_PA5 7 &pcfg_pull_none_drv_level_0_smt>,
+				/* i2c5_sda_m0 */
+				<2 RK_PB3 7 &pcfg_pull_none_drv_level_0_smt>;
+		};
+	};
 	i2s0 {
 		i2s0m0_lrck_tx: i2s0m0-lrck-tx {
 			rockchip,pins =
diff --git a/arch/arm/boot/dts/rockchip/rv1126.dtsi b/arch/arm/boot/dts/rockchip/rv1126.dtsi
index 5b1ee06dc035..483576de841e 100644
--- a/arch/arm/boot/dts/rockchip/rv1126.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126.dtsi
@@ -23,6 +23,7 @@ aliases {
 		i2c0 = &i2c0;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		i2c5 = &i2c5;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -400,6 +401,20 @@ i2c3: i2c@ff520000 {
 		status = "disabled";
 	};
 
+	i2c5: i2c@ff540000 {
+		compatible = "rockchip,rv1126-i2c", "rockchip,rk3399-i2c";
+		reg = <0xff540000 0x1000>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_I2C5>, <&cru PCLK_I2C5>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c5m0_xfer>;
+		rockchip,grf = <&pmugrf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	pwm8: pwm@ff550000 {
 		compatible = "rockchip,rv1126-pwm", "rockchip,rk3328-pwm";
 		reg = <0xff550000 0x10>;

-- 
2.54.0


