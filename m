Return-Path: <netdev+bounces-250504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60360D303C5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCEC0300957E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377D736D510;
	Fri, 16 Jan 2026 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e78OplHw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9736D504
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562177; cv=none; b=EoszUPfcmNctlbCMbXCXQJs8h0cVXiSOxxLp7xZVXvlAEAlyZnyn4CihVXZOyW/l4LuEdOQ9d4BoJfuITT7th5llcyYPjjYaF+MIOEvIOQVQcNlIVVYQvm79fR1HJxIWk8INz9+NcgtwIDiDn/Gthr8w0QnINWkzRTlPfwC3QM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562177; c=relaxed/simple;
	bh=awtSa70YIOy7DkgI9qgxThmsXuEXN5au1KlV2Qk/F1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQuokie+63Mv8UbPicI1CYFokwGwQgVmfuL48ZymrbbqehiqtGvNkr8q4yMslsnCsdRkXl7v4rdbruf6k7VLUmVj16bJMFW9S6iOvJVfPupqQphJPs1SwjJv8aqJLiYjg+3CA0pnQCPtzMUGwQdPyZxzL837L9ZuVYSadkX+s+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e78OplHw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b872de50c91so296871766b.2
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 03:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768562173; x=1769166973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awtSa70YIOy7DkgI9qgxThmsXuEXN5au1KlV2Qk/F1o=;
        b=e78OplHwLXu9HeNdVKiYx0yH3vQBuffMeGVmE+m8UwDjBKpdH0qW4aLAPiope6xnsV
         U/7RfS9STu2XvafO6cXnrUvlPwCRuy2rZrFxwDV1kjeUQNVRF+zW85z9NLtWvsMWSA4e
         9qwx341UmraBqyZzJWOgEuqrxqCYgQeSxPCsadK/ai2cPEtCz7xiWOdaQT98GN2ABhB8
         yGnuORKD4dQNXmNyTSNwt8wS948kAfs13gtsNi+0VgdqmOZcoI9f5eKUr5KSOOO1jQvZ
         v7DnZFpN7jFXQmL3uJWA/mjaFo9jcTIP8A6jJez/AXEtJwxV3NUszJTrRzFHIkVfuVEq
         XAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768562173; x=1769166973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awtSa70YIOy7DkgI9qgxThmsXuEXN5au1KlV2Qk/F1o=;
        b=tNxTflVo39NqCu/w7FBLohZHCgYIHos9hZ0t4t0YdZaQ+kWLOE9uCNE0OKn7C8z4TL
         otDqX4wdTLXYFPWksudKtPRQk3UabzB9Tv6F31IO3isTLGAiaJ1qGAYlL8LMIxrOoZ3s
         DDiHhCHGtvcB5XiWCO8f1NBOmv+/dvZHlSdje2yz9XOBW4URfgreirSeV0dnqnArWElG
         DyjBp+Ubyt2XRUyiwW5T8t5TJy6oAYVoFWU98Ec6oMfxdqrMPiXAO51A3Dsu1/62H+TK
         IK/gBdUqPCCwMSybl4kRFOZIfs5egQIZS++WaXND/F72XgmiIpgYN/gSliCrsxxdpMbp
         bT+Q==
X-Gm-Message-State: AOJu0Yzm/uY1jm5gWTz0QT+LOylVoB2R/u8pm0L5dCS4R079pnjkWJFT
	x1CPsryv5G/qUyINtog//oGW+rUl0xgWGt1WFrgtp1PsrWZ38PvwuK9J
X-Gm-Gg: AY/fxX5t2i8tpwV+IfVb5/I9JT/pm9xDb+xIujySilxlw9LoK1CLNJJbyWdbu3DX28s
	B7JIUPUBhUjlIvtqM0GHe5iXHLPhBdwM5ilDg21zAqdGeux1q8Gc5XJUbK1avDBwwSBJ2X5FgW8
	II2S3lkujRE2qthh9+/gRC1l+Ga79h3/rQhgPa/XxRKY7+EvkqipTeRGV4rZDnQC5lSKfujgH7K
	TCWF187aiFm6Ne9n8DLKfMxEFdSm1ZzSb8geNiYgPTAaJPXOdDz32IuZPku8tusZwkVi+Rglrkf
	EM94QG0+yN3fqiIHn9VdVaIUMKlUll88vJYa/xpJKVxxfza+Vx0cWj8kh8bh5RkH98LhrMgQBE9
	HTLeZNWM/fgEgap1Xsh4tWrbxWaR4yIpxtUTekKHdca2OHDSRR8jthqOy8p7f0/Xo7Q7rfAAxYT
	K2m2noa1zENil+4k6ykU8lzIQsaZSDNPUNGeaoxofIQkHOp9xt8LHUNL20GE+3h8mvJEQU3sJHu
	cK8rMzbA3bAGw==
X-Received: by 2002:a17:906:fe0b:b0:b87:2e8a:e270 with SMTP id a640c23a62f3a-b879324c893mr242314466b.57.1768562172556;
        Fri, 16 Jan 2026 03:16:12 -0800 (PST)
Received: from ?IPV6:2001:9e8:f13f:1001:fd79:63dc:69b7:40d3? ([2001:9e8:f13f:1001:fd79:63dc:69b7:40d3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452bce433sm2156997a12.3.2026.01.16.03.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 03:16:12 -0800 (PST)
Message-ID: <d5c11fec-1e75-46cf-aeae-593fb6a4af09@gmail.com>
Date: Fri, 16 Jan 2026 12:16:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: sfp: add SMBus I2C block support
Content-Language: en-US
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Paolo Abeni
 <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
References: <20260109101321.2804-1-jelonek.jonas@gmail.com>
 <466efdd2-ffe2-4d2e-b964-decde3d6369b@bootlin.com>
 <397e0cdd-86de-4978-a068-da8237b6e247@gmail.com>
 <0c181c3d-cb68-4ce4-b505-6fc9d10495cd@bootlin.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <0c181c3d-cb68-4ce4-b505-6fc9d10495cd@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maxime,

On 09.01.26 18:03, Maxime Chevallier wrote:
> ACK, I'll gladly help with testing. This should actually be easily
> achievable with a board that has a real i2c interface connected to the
> SFP cage, as there's a i2c smbus emulation layer. The SMBus helpers will
> work with a true I2C adapter, you may have to tweak the code though.
>
> This is relevant for modules that have a built-in PHY that you can
> access, if you don't have any I can run some tests here, I have more
> than enough modules...
>
> If you don't have time at all for that, I may give this a shot at some
> point, but my time is a bit scarce right now :'(
>

I'd postpone this part if that's ok. Quite busy at the moment :(

When I come to trying to work on that, should that all be kept in
mdio-i2c.c? I'm asking because we have a downstream implementation
moving that SMbus stuff to mdio-smbus.c. This covers quite a lot right
now, C22/C45 and Rollball, but just with byte access [1]. Because that
isn't my work, I'll need to check with the original authors and adapt this
for an upstream patch, trying to add word + block access.

Kind regards,
Jonas

[1] https://github.com/openwrt/openwrt/blob/66b6791abe6f08dec2924b5d9e9e7dac93f37bc4/target/linux/realtek/patches-6.12/712-net-phy-add-an-MDIO-SMBus-library.patch

