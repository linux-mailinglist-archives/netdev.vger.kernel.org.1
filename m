Return-Path: <netdev+bounces-114409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C811942717
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE299281D30
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8E171658;
	Wed, 31 Jul 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fe/GF8iL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A917085C
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408092; cv=none; b=Bw0lWX+5JD8+DrP/ur0Z7/P0j6C7s0m2um5p3OGMFpUqlXurIYAAyTAlkI8KS2mn08WXqH4SGs3H/cbB4Nn0jppXNylr4Yd9hsH90pbW62D7Lu8ExyVsdCMQTiK6dH3fRb1HH9tiUiLX2iyC2kKxRt9SvDoRurGv3AkyJfERHIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408092; c=relaxed/simple;
	bh=xAM5KuCUk7fhZ0Bjto448CcHX5hPz++gECDIEyxNyJ8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=M3LOaB+CNHOTE2cQp8ZAVM+CtuldSYx3qc6ZkUlJ9wLzTIPXwmqOpTELYC9qHk/on6r28xNUW98cyxv3uURx2jiRlO5OfCtT4ra89vlb18CvBGCwRqQVIgQFyHfUVvXDi1HmhRwCyVUXrMb7WKNmOOPHb41a5WlRe3d40rAmm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fe/GF8iL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d0dc869bso388822085a.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722408090; x=1723012890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzcsKxSamtz5qYylBq+mulofl7DNdl/8yBGrG+evBvI=;
        b=Fe/GF8iLsPMNu/gtWyxDLrOrBhgj8eKUJW+JtQ2NPfIsWqHNmcoScqOH36SAlZeZTO
         T8Ky4GrvXo3TJOjiNoCyPK9tXwzSFGBUGoJkcGailaK8afqea+y9dwJGWs/bE+mNtgIW
         AeJhYEG/UzZOWiFYsLXozy1chmtWWXOLEqOxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722408090; x=1723012890;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzcsKxSamtz5qYylBq+mulofl7DNdl/8yBGrG+evBvI=;
        b=azM3eU8+h5TopJn0x+p3pKWx6S2P5bA3VuPqPcciOTKKN/QfiA04Mt/SMOxez+5LkF
         Pmu4+bV9HZpMXWd+0xRIhjnY+mGlRhj/CqZdD7Frje6EHS16Xl4i5NxFSTii0jkjTLOT
         dDmC3eU0VLdBgnVkL5NIGV0JjSAXLrfONNoQDJGlryajsorZbNuRkQLx7K67LppwMv7C
         z7TVjbIgLGARTQRtNzFv3nfGgTYbExeiCP51gb83Q5EX7mVVxjpUIHSFgN6JNvYxZsIB
         /2d1tjoCXiz/4xgEUZdSwyWEnaTE/9WpZ7rwKQveQV/Syb3Q5ek4iwqqbrpyySVQF2Dc
         G+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5T1yhpEEKo30uJQEwjf13t78crCvMqT1RxJ0/nL/Gd3gpsKP5RC0b5LvxQW5UEybJlOKqSUQP/jvToMwjun+jkpI5DLWa
X-Gm-Message-State: AOJu0YyI4n+klQyPCLUXp21GHE554HSKmv0lCOR0Zw4EpYBYhXrQFwgb
	hzTSnmYAkZ4RsSOS0TGALoLTD3PldGn1gbTsvpQO0aCFzj4i7vC4OH/dj/7R1w==
X-Google-Smtp-Source: AGHT+IHVSnCSNUiDXZ50W1IsLXQBwnHUTc3D4diJbcUDSRlur70rvvyzQTE+g2F4ctDA9qBB1UnD+w==
X-Received: by 2002:a05:620a:4494:b0:7a2:e53:3f67 with SMTP id af79cd13be357-7a20e534344mr1952685a.19.1722408090009;
        Tue, 30 Jul 2024 23:41:30 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73ed33bsm710259685a.58.2024.07.30.23.41.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 23:41:29 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>
Date: Wed, 31 Jul 2024 08:41:24 +0200
Message-ID: <1910785a220.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240731061132.703368-4-jacobe.zang@wesion.com>
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
 <20240731061132.703368-4-jacobe.zang@wesion.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v6 3/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On July 31, 2024 8:11:58 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
> pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
> device under the Bridge1.
>
> Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
> Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts 
> b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> index dbddfc3bb4641..b80a552dad883 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> @@ -283,6 +283,22 @@ &pcie2x1l2 {
>  reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>  vpcie3v3-supply = <&vcc3v3_pcie_wl>;
>  status = "okay";
> +
> + pcie@0,0 {
> + reg = <0x400000 0 0 0 0>;
> + #address-cells = <3>;
> + #size-cells = <2>;
> + ranges;
> + device_type = "pci";
> + bus-range = <0x40 0x4f>;
> +
> + wifi: wifi@0,0 {
> + compatible = "pci14e4,449d";

Probably need to add "brcm,bcm4329-fmac" as well here.

Regards,
Arend



