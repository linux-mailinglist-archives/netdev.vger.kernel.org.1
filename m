Return-Path: <netdev+bounces-131816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F16D98FA4A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FC928121F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68A1CEAC5;
	Thu,  3 Oct 2024 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHy9xAgO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2411CCED6
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997120; cv=none; b=alU00VBdyI9Rbk6yT+YCyPDeQfJTGXapF4RASoSOTy8ZWoQWWDp0VDbKJ1/5iD7boFfXyaKIS8IisY0HOZ2czOuYf6flWHtfcvomxo5UXnW9Uri5sq3sygqrcr+4M+muqQS9+79e5IoPYgZjxz7bPBNwo9mMR3LWD71E+VfTA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997120; c=relaxed/simple;
	bh=m88Cdp6p7Qz6PoSEEZB1Jgs6OsvgUG5+3xq/bLrX3k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMBHCSnud0bJFp9rkXI4O1Fux/VuSHgoTUzXeyuKdA64eFJ9VlBWLA8GRecAvng/40AGoqBOmfLCgnWkpS8qXAoRgcKmzF0w2Sb/OyNoGn5nd03jBl/svodo6M0eEcfBQH1ZOXAoizPFyQMQIAijVZ92G5P+jjsbamAYAUh/qNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHy9xAgO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cc60c9838so897673f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727997117; x=1728601917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKM75zxanfWhhKQK8t/Qt3lK7p7bZTGbhBxzm++dSNY=;
        b=XHy9xAgOnr/n1RY5lulK18XggfketedOb8AnyH/ATL3yizC2B9xTxXxK9XxA3BfCUD
         a9dj32fwqHRWTAkSY+FoC809T2AygXpVgdV8NlPScZf+sD98WtseQfBlFVdXrNR4wrvP
         fIDGqCOcc6JbwzSl6sS23NGqiLGCszBRZz5uI7kGnuRrOTIZ8Xlw92Vh6XTsl0HqqKXw
         nysWHBeLVaz9AcchL6cQfP6WZi9bCRd+28eiosfFnt7qDDBF7zGiOWEVIGpyi+5Egcj1
         8w6UJJqtjxhgCf0n0VlPVOCUC6oU7KAjDtyH+9D60PexznUm0n8vi9B8p43LPLFMluWm
         IKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727997117; x=1728601917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKM75zxanfWhhKQK8t/Qt3lK7p7bZTGbhBxzm++dSNY=;
        b=H84scHII39YnPwDu295Z96z0DydaZecwq+gNS+tdvH0gODhMOgZWkCOq1o4SBrU9ca
         o4qGiL80n002+WfIosIw2g0hgMpk55EO2AwWT0SjsL2GxwkdxgyEdNJh9KqOHrfEebjJ
         ueDZiSpINkVYJtNpajsJiZRMb3USGoxGpeJhUZnWf52UsdXuWtjSXswoXw6h22YVybgs
         h53VK3K0MKnrYVEJbQqVOoDwBTGvis8FYUm1NDz1v0kFt/91zRyvglGmVduOPJ/p5cuA
         EQj5wv1yzGFia3yyWAnAfgYwXQ8ZMHXaZSWefH2qYaA8NtxPh5CMqnGAAihdP03O4RM2
         7qGA==
X-Forwarded-Encrypted: i=1; AJvYcCUryXobuXheqNZoSD9Ko1S8H+UV1B3vS0CzIplOhEo6l+nSYz8DBhd8LCAXuq/rygpzb6cLmj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/7/XmuzDQBU/npV1147FCaS3yWPZC+CVVyaOCIxJ1dWuZaEtd
	rdEsSst0nbbu/JYMh1+xJvJE+hO9wfVuy+dEiqgdqJN92dJC/UUb
X-Google-Smtp-Source: AGHT+IHmkGTj5zUIlPoFXT6YzynZweabfR/Kot8hSJzvjQkbA/FVNRrEh0A0aeDPHyrdfPAHQ7Hgnw==
X-Received: by 2002:a05:6000:c86:b0:37c:ca20:52a with SMTP id ffacd0b85a97d-37d0f6a15cemr451881f8f.8.1727997116569;
        Thu, 03 Oct 2024 16:11:56 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6c3asm2136082f8f.69.2024.10.03.16.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 16:11:55 -0700 (PDT)
Message-ID: <0d6070ef-d830-45e7-9162-edc025e459a1@gmail.com>
Date: Fri, 4 Oct 2024 02:12:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] net: Switch back to struct
 platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Loic Poulain <loic.poulain@linaro.org>, Simon Horman <horms@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
References: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
 <3f7c05c8b7673c0bda3530c34bda5feee4843816.1727949050.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <3f7c05c8b7673c0bda3530c34bda5feee4843816.1727949050.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.10.2024 13:01, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/net after the previous
> conversion commits apart from the wireless drivers to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>   drivers/net/fjes/fjes_main.c             | 2 +-
>   drivers/net/ieee802154/fakelb.c          | 2 +-
>   drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
>   drivers/net/ipa/ipa_main.c               | 2 +-
>   drivers/net/pcs/pcs-rzn1-miic.c          | 2 +-
>   drivers/net/phy/sfp.c                    | 2 +-
>   drivers/net/wan/framer/pef2256/pef2256.c | 2 +-
>   drivers/net/wan/fsl_qmc_hdlc.c           | 2 +-
>   drivers/net/wan/fsl_ucc_hdlc.c           | 2 +-
>   drivers/net/wan/ixp4xx_hss.c             | 2 +-
>   drivers/net/wwan/qcom_bam_dmux.c         | 2 +-
>   11 files changed, 11 insertions(+), 11 deletions(-)

For the WWAN patch,

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

