Return-Path: <netdev+bounces-112086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B50934E25
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8711C21A55
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1F1420DD;
	Thu, 18 Jul 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XxcaQVty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6399140E30
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309147; cv=none; b=ZdCBIpVOuxaIw2dsCCIve3eU27xn5vrKkYsTS5q+SiXXR1Czffbkdy9+QaXIcYlD7GGyoZnAJlglWTIqxjO0ISSp8VFm/3sjU+6TKHxl5dKU3Isu5N2qbcccr2xdekXzDFtDTxgknati5e0Xyr5g9SiviE+N6I8zT9KdrEo79Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309147; c=relaxed/simple;
	bh=PjNivT268L5G0Z+kXWR7bt4UcXdGtUEgJR3SsnpuaVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXNQPKPIgzCeWgbdbjB/cUk6Cj1GHTw74sJU8amYuEEjBR+Sws0dTn/gQjVkj9WjA2KV2UzbJdHwJP98ZC78SFO9jH0Dc99Q2KZhKzKT0kOwigJrbquy1tAhU1ph3JZiTte91q+ayDFuH/PyZ438oihlIxMRgP5menHpJAb3FiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XxcaQVty; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so3276385e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721309143; x=1721913943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eEhgve0oh3LYHZapYyjqaD+66ebK/fUpWywW/X7xHxE=;
        b=XxcaQVty5KKdkz3lZ4U+vM7+IdNhdS24WcHL+2/DmMe4qomem7zi5+gP8dIC1LKw75
         kw9s1r8CJXpsYkU5CRyshLoP7BPxvuwcrrD3glLvgxLY26k9SM80t6/bkqO/wI7TIijt
         NfQ6kwVGmi1gPRa9af3q8xoP9P4oPjaJTR6MXYcp35LyQeig8KGy7+FZBHmd3ubQ7jz+
         WIYP6GZJElMZ4MSXFqqUPti0BkyN01YUFau0AblCqgmeRJO7ofdSUJlMrHZFcgMVhgEL
         ebxSRxbJ3z9HHYU5VwR7+/2+HimLpIwPDJ1tyubxpJPanO+JzgcMEGL+mmufr7WDw6CB
         rhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309143; x=1721913943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEhgve0oh3LYHZapYyjqaD+66ebK/fUpWywW/X7xHxE=;
        b=ONcRZP/8LuRqekGkrianyzKfknnw7oRY5ZNIJwt8Dy4755WvSC34L/65rZYhy8Z4jv
         4FXmBHrZ6PTHAHxqKOiAdp8jButvKTDtYUBysyvKkTt+mzMudEEBwZxQQuOmLRc1478q
         +XCI6ZDtNuUEjhoO8U4xD8v/LR+qJ/zrxZQDZbENEDAkydD3QR8e4c685bMnLPndCj2T
         nZKrzOr1haG4jjIxtlYmwCLtbhxwdxfjGoYfRN6PS0o7204bFdCkq5NnE+woaGvsJf3m
         3rCwB7i+g923BL9JR8TLW7ZxmfAGQEUapj15OHwuuhF2oCYdA/ZQH6+8/LGv87ReN8RU
         rzyQ==
X-Gm-Message-State: AOJu0YzHXgx4s0beWO2WlEYSf2dX2fMU6Jtv/xK/VqdZLY+BFoBtJDyb
	z9d/IaTr6SWaFhvgV70buUxkYyok0FRb3FbuhxUCCgnF/AAiTZM4WIZ9m2a/qtk=
X-Google-Smtp-Source: AGHT+IG0NuzcLCQ8uEI1sTqJyliNIffZxlgIwO4TbYgVbeAj5TBLTTJcCZ7dJzuADxfQvhCHGsIgBw==
X-Received: by 2002:a05:600c:3144:b0:426:6857:3156 with SMTP id 5b1f17b1804b1-427c2d01f41mr34643565e9.27.1721309143025;
        Thu, 18 Jul 2024 06:25:43 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a6efc5sm15163155e9.21.2024.07.18.06.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 06:25:42 -0700 (PDT)
Message-ID: <80351026-0d15-460a-8002-4b24b893fefa@openvpn.net>
Date: Thu, 18 Jul 2024 15:27:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 10/24] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-11-antonio@openvpn.net> <Zj4k9g1hV1eHQ4Ox@hog>
 <eb9558b3-cd7e-4da6-a496-adca6132a601@openvpn.net> <Zpjyg-nO42rA3W_0@hog>
 <10c01ca1-c79a-41ab-b99b-deab81adb552@openvpn.net> <ZpkUfMtdrsXc-p6k@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZpkUfMtdrsXc-p6k@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2024 15:11, Sabrina Dubroca wrote:
>> basically the idea is: with our encapsulation we can guarantee that what
>> entered the tunnel is also exiting the tunnel, without corruption.
>> Therefore we claim that checksums are all correct.
> 
> Can you be sure that they were correct when they went into the tunnel?
> If not, I think you have to set CHECKSUM_NONE.

I can't be sure, because on the sender side we don't validate checksums 
before encapsulation.

If we assume that outgoing packets are always well formed and they can 
only be damaged while traveling on the link, then the current code 
should be ok.

If we cannot make this assumption, then we need the receiver to verify 
all checksums before moving forward (which is what you are suggesting).

Is it truly possible for the kernel to hand ovpn a packet with invalid 
checksums on the TX path?


Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.

