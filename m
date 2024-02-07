Return-Path: <netdev+bounces-69898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE35484CF1C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F1B28D828
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD00811F2;
	Wed,  7 Feb 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeyCnUhv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6F81AC6;
	Wed,  7 Feb 2024 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323984; cv=none; b=r7AyMRSB2f334HCN19Wkl0w/vnYmQm7c189ppCrt2PXe9EQ+MNVvvQeAn7XoWt09GrM2esTxA8Z6GFH/oFHbfBKjNYCtyAct9JVuNmAHXz2P+QMFp/ZUayFzTtGwXk3QQ31MYpm/r1I9sXiiuur0DbSvm/fcX+Hl6iUGjlxP16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323984; c=relaxed/simple;
	bh=6VeUkduw5EfcGspExXyND+9I4cH5EtGKaVU95A84+Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkWQOiFItp2xbroP+p8mwFDDihNr+4LHVpQZpxl5b/ZOrDuaSxHs9O5BTkClijzyWWIjpdqEuziY11PbYsd/Sx7kZDfFF6fTdPJAZs0yHbH5m0gEEYoiMxTRLmOrn59+Wgj26QiHZiDou8XCvyXaw3x5ImfRxezyCHGsrZ8bIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeyCnUhv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51167496943so1307994e87.2;
        Wed, 07 Feb 2024 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707323981; x=1707928781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SB6CElYBmH4Ozh9j3qgetp3odjgGs78Z185/4AJzzjc=;
        b=VeyCnUhvUKX/n5T72vufkUQn4wRvfflyjvBHZ+MzRSfWmH4rN5D0kc62xnb+U83Fmp
         Gw65F+yyu+CcPgmoQOGTnvhmEdhj4hBALBf3TwhK34OKU9X7MWI3lPYmGwOCFAHUZvkZ
         a8ZBJCPi8HcucnYU0rFtWqVj2ZmUJBecsonB2TFFE8RzK8Q9qobi5ezmMMLoh4FyDMFX
         DbIH11Eq8AWBUf/PysIwueZHH272EX8bOZdOtjmWZdgolH8zBntXpqpLVTd7tuTh/00Q
         adKx3364bxbdGkzJQWQb8oRLnJQLdsuzs7WAxO/aFoFBlNSrdxnuLe006fPBta+MApYa
         i+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323981; x=1707928781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SB6CElYBmH4Ozh9j3qgetp3odjgGs78Z185/4AJzzjc=;
        b=mXMl/AcXyrmtoP7I28AoEmV3vea52wCxPKL55OKhxSVnpz61hxbHinDuDvqeQPCovk
         XByYK+1f4EeMYwO8dIlkdM3iyiPCeckwywOPCto1kfEX/0CnNgJqWTT3A7+evTz7x8Zu
         6SDFnGoZ+kFNrnqfYalJ0ytbPP5YQ+D0ddE0hD1IIxRXLpF7ZFj+CT+7BfPfT1DDmu2g
         wY+x6DInjLU8iGcv/ZvANRvaiMaDQGpp78c88ezi2WpN9IDday1wVYJvE7rd324NrWvM
         kSufsd20JieZb1V76GmY+51qqf46LV/OBMUp7uqqGcFwX7/Um0ZFMKLtvojtRwE3RpS/
         S9Pg==
X-Gm-Message-State: AOJu0Yy8F/eJZPjLDm4wirhRXhZh3KOjYQ+HPvqRZb9vnQdMNa1zxYoE
	ZAnYvFXLaOhvki76rCFCZMAihEk/NcBGD39QTH4OqCD4lvR785ez
X-Google-Smtp-Source: AGHT+IEnogADwUjK5uNEdSvnGNhIDJaSNuBXzHhZhNeIsBgG5+yZgWSU6VWYiTjlgnBSk3KMEGLgGg==
X-Received: by 2002:a19:7006:0:b0:511:4ee3:dc1c with SMTP id h6-20020a197006000000b005114ee3dc1cmr4380035lfc.33.1707323980416;
        Wed, 07 Feb 2024 08:39:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXF0HYAQTAdmVOfM8FfW9yagq93xaf13BYldFD03MDRvpI/Eg3wUkKqVFMVrXBrnQVDFf5WNtDEEOcAWkcnl29KoL58nA1hOOgjfKbHEu8NGId83Lc14PAw1yyQMV2v8XnGrv5v2E7jr9o8Ap/XizE+fH8+orVf9gqyAg1TP0syOv6oGmjX9aDSX/iEH0TkgBfYCUDnZyTlFa81+NRNWX+68+vAmJaLH8cl3ILk/q5eWDX5ADS02rclRcIsBB7BcjVxCG5Uj7xkC1LeA8Oz0MZata2/GVdKOXgpCXhOiY9cv33UfE0BvM1IcDir7d1vE3dvoZpnqsnqP2FjQqunwzN8C3WylxQ4YZMLx/fbz37K0377NauoSELPPwm6ie5mO1k8MxSikrRPnQrzifd2Mk32cfpmuJoruzcWIwujA3nw4uxN1gGfCXozqvA2B9H2DfRRNNzc5UREdZibp9epOXE9eATmrQKvVcXXC3UB9/pK6XA+reojbsaly93/r3YZ9YRplLRMSFMgn04mEq6we52BKfj1gYUU5RGNe2kreOoagIg/hmieQDaa/ed8hq2PPg==
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id ho12-20020a1709070e8c00b00a372330e834sm922630ejc.102.2024.02.07.08.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:39:39 -0800 (PST)
Message-ID: <32897bd5-4b53-4280-a5c0-5765cfe5b7d6@gmail.com>
Date: Wed, 7 Feb 2024 17:39:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240206194751.1901802-1-ericwouds@gmail.com>
 <20240206194751.1901802-3-ericwouds@gmail.com>
 <ZcLGkmavpBAN02xq@shell.armlinux.org.uk>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <ZcLGkmavpBAN02xq@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Russell,

Thanks for your suggestions, I will change it accordingly.

> Searching the driver for "air_buckpbus_reg_read", there are four
> instances where you read-modify-write, and only one instance which is
> just a read.
> 
> I wonder whether it would make more sense to structure the accessors as
> 
> 	__air_buckpbus_set_address(phydev, addr)
> 	__air_buckpbus_read(phydev, *data)
> 	__air_buckpbus_write(phydev, data)
> 
> which would make implementing reg_read, reg_write and reg_modify()
> easier, and the addition of reg_modify() means that (a) there are less
> bus cycles (through having to set the address twice) and (b) ensures
> that the read-modify-write can be done atomically on the bus. This
> assumes that reading data doesn't auto-increment the address (which
> you would need to check.)

I will see if I can change the code to:

        __air_buckpbus_set_address(phydev, addr)
        __air_buckpbus_read(phydev, *data)
        __air_buckpbus_write(phydev, data)
        air_buckpbus_reg_read()
        air_buckpbus_reg_write()
        air_buckpbus_reg_modify()

While not changing (except if (saved_page >= 0)):

        __air_write_buf()
        air_write_buf()

> While you only support 2500base-T, is there any reason not to use
> linkmode_adv_to_mii_10gbt_adv_t() ?

I will change it to use linkmode_adv_to_mii_10gbt_adv_t().

Best Regards,

Eric Woudstra

