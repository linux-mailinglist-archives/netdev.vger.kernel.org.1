Return-Path: <netdev+bounces-104606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A590D8DF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5393F1F26834
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7B8061D;
	Tue, 18 Jun 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx5MAdQL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFF77101;
	Tue, 18 Jun 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727241; cv=none; b=u5CqycKbxqmqp6eUts/E4cD0sM1BtqgV6RTVdhxfmtR8DdW0fV67/WNCgYNvJU6lGnsTcy9XT+dST0zgfNNgbV03E5McSuhwN43/Kzj25oq2eKG99gOliKyNdTBBPJ+dki6La8jMt5RN4p+gm9KFl0kKH7o2yzYs1DyPRrOjtAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727241; c=relaxed/simple;
	bh=eXst0iPbk4Bb/LthjJ/eB/W1T9uteyF/EYvmEJ3Pnto=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c/YrAU8TmsToY6T7CLISslUZFCfo5eKQTV+tc87B1srVBk8PFne35RxkWN7fMv9Gl0gQAdNgf832Bpq3ryOtIWxnJyWyhNXbqkwV1+Dhlhp2jJ2GOEQqhZNL23QZd+iK2mBFxSaNKuVtmK2lmttx0Wzoiajs0fKFNy7718LpYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx5MAdQL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so684079666b.2;
        Tue, 18 Jun 2024 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718727238; x=1719332038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WWTx77d5eJnGnctm36s2wsX3pxrVWFjQDRGqkPWp/lw=;
        b=gx5MAdQLeeCmHvUj5R5LdL+pkt22WNMZVMP+Zr+HhlwnvYCkfL7hRfRkPEfKqHEmk9
         mDEmbbGC8f2iT7s7KyATQmQWtN+hrMiKra8GaOYAqLMm7XRy28p8QzmsYnXuuLDW6j9E
         OmeftvxjzMgPyfl1vaKLtJC07u9p9EFS+GguO+Fng1AvrHHmllbGJRHYuffu13A8fgkp
         GmQ8zpumNEG8Y91D66I90KfLwAeUjghYS2to7q+re3RYvTRsIKabnCLItMTgTpqkbNUh
         sp26K9FFc81wfarIXjYyMH7Vs507LXz+mpXLLZ5vxOMnw6n1cJthU3t3nfOHggfjTxF3
         8gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718727238; x=1719332038;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWTx77d5eJnGnctm36s2wsX3pxrVWFjQDRGqkPWp/lw=;
        b=jmah7AsIJ3uPg5IW7SZiaucYa55MQGMXCqaJkXTaWI9SGMejbgOp7BXvylWfSlpdsy
         Pm4pwVMpTDheJKEays4tX2ZOOpoAZ0tAzEo3Jrd0uFEXRlW5ZDwpBMSlmVNX+w/zym5s
         L33bRYsQ4tcCanRFpRj8YJD5sRpZsBOPUzIBjgx8083b2lGC5/5IBQmYKODPOEDxY5Un
         cFksAiXqTR5ZDpdY668xDMoALUnUqHoqjoxLshiULpcf8Rqms7w5OTUW7a53FBKa2D6d
         EbKyLkPw3dvwkMxyVHP+WvilapNJh4TsCGNfBPb8NfaDWFTPn1MrGYMC2/7x79ETWSaS
         yMJw==
X-Forwarded-Encrypted: i=1; AJvYcCUenZTo0EeeTJamzGohlM0Tjrz/qOqt3WD1kUDy2NAVw2LjyWYevFgoaOOALN1/b64K0LCOpX+u7xzPEWDmnKGlpRIPn6nP2xfO5txARYkH5vns6y1EaewNCkXPhVZMYa2CLRHvxqzV/RH2gevRvkB6XKu+VqM4CgcPG3QfIeNX3w==
X-Gm-Message-State: AOJu0YxMLTOhiUd+RJzc7nn/peCEz/VGuRB57uHl2QuyENEizEdc8doA
	m2AnHS75/fD9mRXXFSSMCUwzAaUWm9j7J8ZVJ/VLttR/9Nq0DlHF
X-Google-Smtp-Source: AGHT+IFrJd2P1zNowiuFxfXKuLeFkY8i8OFcYY9grJ9wDu0sz0akTQp39THa3fEyzQyVz6uSY4TVxw==
X-Received: by 2002:a17:907:a645:b0:a6f:8f20:a0b with SMTP id a640c23a62f3a-a6f8f200abcmr324363766b.30.1718727238121;
        Tue, 18 Jun 2024 09:13:58 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56dd3109sm633560966b.95.2024.06.18.09.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 09:13:57 -0700 (PDT)
Message-ID: <12f50bef-ba6e-4d96-8ced-08682c931da9@gmail.com>
Date: Tue, 18 Jun 2024 18:13:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/3] ARM: dts: rockchip: rk3xxx: fix emac node
To: heiko@sntech.de
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
Content-Language: en-US
In-Reply-To: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In the combined DT of rk3066a/rk3188 the emac node uses as place holder
the compatible string "snps,arc-emac". The last real user nSIM_700
of the "snps,arc-emac" compatible string in a driver was removed in 2019.
Rockchip emac nodes don't make use of this common fall back string.
In order to removed unused driver code replace this string with
"rockchip,rk3066-emac".
As we are there remove the blank lines and sort.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

[PATCH 8/8] ARC: nSIM_700: remove unused network options
https://lore.kernel.org/all/20191023124417.5770-9-Eugeniy.Paltsev@synopsys.com/
---
 arch/arm/boot/dts/rockchip/rk3066a.dtsi | 4 ----
 arch/arm/boot/dts/rockchip/rk3xxx.dtsi  | 7 ++-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3066a.dtsi b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
index 5e0750547ab5..3f6d49459734 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
@@ -896,7 +896,3 @@ &vpu {
 &wdt {
 	compatible = "rockchip,rk3066-wdt", "snps,dw-wdt";
 };
-
-&emac {
-	compatible = "rockchip,rk3066-emac";
-};
diff --git a/arch/arm/boot/dts/rockchip/rk3xxx.dtsi b/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
index f37137f298d5..e6a78bcf9163 100644
--- a/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
@@ -194,17 +194,14 @@ usb_host: usb@101c0000 {
 	};

 	emac: ethernet@10204000 {
-		compatible = "snps,arc-emac";
+		compatible = "rockchip,rk3066-emac";
 		reg = <0x10204000 0x3c>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-
-		rockchip,grf = <&grf>;
-
 		clocks = <&cru HCLK_EMAC>, <&cru SCLK_MAC>;
 		clock-names = "hclk", "macref";
 		max-speed = <100>;
 		phy-mode = "rmii";
-
+		rockchip,grf = <&grf>;
 		status = "disabled";
 	};

--
2.39.2


