Return-Path: <netdev+bounces-113994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB7940876
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505A5B21ADD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66A718F2F5;
	Tue, 30 Jul 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UNxOmMl+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158A161914
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321437; cv=none; b=HR65rLAj/CnzJWDMYoaynjNZK+wvmFOQTVH3G2Fimg2cuCazxS+ic9ar7V82W2cV4WploR58XEGIpMKhlGVMexAycTNE1VulBbhglhsYiC7DBa6xTkz47dFHuU4Z2QeMa+eJZIr9NQemtn3FZ3LzvlPjeoTUy3seL+xcBppEweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321437; c=relaxed/simple;
	bh=N47Qs6ylcphzAUtYxaZMJgXp9Hzc7IfQwO9V19FO3ms=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DOJZ0PmtqOIpWWHJKqSW/aQVqzLS26SJtJrFHXMkhY3bdHgu/jn+C0RCrQTO2Dd6LhcPUpNS+MAn+PzPmSmpScFHCoiuPMfBqh0Pd1h7hVP612Fj1o6gbFgS3zTA3u185bWfu2nhh4K5Q9cS7VYyr82i/XSQPc390u5ZObv+8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UNxOmMl+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso3190248a91.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722321434; x=1722926234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8n8rYBKoxfcGnZbJLvEREPokWsFDiloFhCfdKHeZA0=;
        b=UNxOmMl+jxkf6YnKJctgui1i7rf8X2l5K0keWflVRIkS1DItWOrNWcPJrspO2gAkjI
         WBH/fXwA7G8oPkTTE4/ZVuy3j+/9tGyASds7ghFKPU2RNcjTZDAUvTvnFfb5ccK+cxHW
         0Ahfm7d5beHfMwrRS7PxuAw9NXYnhmcwF/O3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722321434; x=1722926234;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8n8rYBKoxfcGnZbJLvEREPokWsFDiloFhCfdKHeZA0=;
        b=nW1l1Mem9qwERrpC048eVjYYVfklaeZezmDecsTkFv8PeshRSPuz6oylTSACqU9q6h
         1xzZpKFRu71WqLBqftZpcENIpRrkIjRkZua+MG7C6N6UAcqFAKKT6+P4mksPQnA6HTi0
         W6IR55xgsC8m9HKUBjVH95vWo0FcbiKIRy2WS6aSinc1giOT+Q4xNtdrbtG8UEC8W++V
         IoB+fy+0cg7qbs/Ttje7vMPutfBm/1SBx+/tNUL+gB9o4gucHkU5e/bb9BeEXPggyMBi
         Kb8Ojgg75/rQeYMvjryFAEpU4YCWuvHmxK5Thbiuff7ouf3zRUqakCG3HADgJAitG/La
         UyMw==
X-Forwarded-Encrypted: i=1; AJvYcCX7a9R9oUHBFd2eVgIMckcunlvWI2s3D1iYzT9QfeBEVu66d5XlvCS3+IKeaU+TYB8ahpixwVycS0wBSv+ti5Kxtnzfybrs
X-Gm-Message-State: AOJu0YwMRU4MjZaq8xU55Ro+ye8eT2Ln8lrvGazlJ1Lvj+9MqXc83r3g
	nBJmlJ4crqTeeEgylnyARb2gMdZ/r3U7LhAd2iNY+WIv11N3Bv5dY21iOPE2Fw==
X-Google-Smtp-Source: AGHT+IEbAYsTcrcjdD3UrZN6PQy+Do67Ei8GuSEd9YQg6UqH56tJFOZ2LAJA39UhwaNb5oNVG9ACLg==
X-Received: by 2002:a17:90a:6b4c:b0:2c9:7ebd:b957 with SMTP id 98e67ed59e1d1-2cf7e1df0abmr10618508a91.11.1722321434495;
        Mon, 29 Jul 2024 23:37:14 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb7608b88sm11733257a91.56.2024.07.29.23.37.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2024 23:37:14 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>
Date: Tue, 30 Jul 2024 08:37:05 +0200
Message-ID: <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240730033053.4092132-3-jacobe.zang@wesion.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

+ Linus W

On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
> external low power clock input. In DTS the clock as an optional choice in
> the absence of an internal clock.
>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
> diff --git 
> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml 
> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> index 2c2093c77ec9a..a3607d55ef367 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -122,6 +122,14 @@ properties:
> NVRAM. This would normally be filled in by the bootloader from platform
> configuration data.
>
> +  clocks:
> +    items:
> +      - description: External Low Power Clock input (32.768KHz)
> +
> +  clock-names:
> +    items:
> +      - const: lpo
> +

We still have an issue that this clock input is also present in the 
bindings specification broadcom-bluetooth.yaml (not in bluetooth 
subfolder). This clock is actually a chip resource. What happens if both 
are defined and both wifi and bt drivers try to enable this clock? Can this 
be expressed in yaml or can we only put a textual warning in the property 
descriptions?

Regards,
Arend



