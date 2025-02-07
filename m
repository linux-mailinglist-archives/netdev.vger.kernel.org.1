Return-Path: <netdev+bounces-164043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D34A2C6EB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C46188C3E4
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4491EEA2A;
	Fri,  7 Feb 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dL5tXQN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C31EB1AD
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941797; cv=none; b=FfaOkMxCnKULzT0WjqdP+IRglH4pI7YGohoamlgxsDilj4MjM4iNsaB8mmfciYhGX2l5ifoyUQV+yZNHla4AJ1qDi+ME4h3z0Q/fA/Dybj4EQqN5/DkJG1LM7+vJEGokC5hzdXz9W+NtNnQFBqWy/Ja9XzH+QjS2C0BXkJTEMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941797; c=relaxed/simple;
	bh=JDDbmK++u5Zrrl9i4wETB+fZ6+WtylkQrpDbOxAMbWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/YXVOAJP9Fi3PuVpwcgsDCZ3Rk5hxGjUb9jkHAEKK8R09lBNmWvTEE+hzI1UFO4Aqgi35dr4DZ3191+M56OzkI74Ql2eh/yZmO7jiuRmVOcNxYGts+hSddIDJr9Tttu6x4aVrtSEmhzrKGq8L6fSvBO/zSng0SF59KX1BCocp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dL5tXQN9; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b832eabf39so791937fac.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738941795; x=1739546595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKN8sjRb3wgYxS8vD82nCdPhJYpZegmXytH3ZuvLDaU=;
        b=dL5tXQN99tpWF8iJr8PDD/x7JBvxCw1n0YxRCcqPSFnvPpC7pz3PL/hYn91vWQB0Lt
         PZ+YGjJPRvMOtCt8XuOsWuFMiBIr2RD5IvXR6mjqKscso6rFMGbhNJ1G5MGrXATFbpfa
         VRbiSVly/+dXXwGwD1F+9fcauRK/lcPtiyKuMiFGHGzuW5dhBj3e3WC6bCiqAoyuOliI
         TzBamMlWWZOQmTpDeCDQ2jegAqduAHVG1KqRiD/u6gqi6cFOo8bwhGGFnLZUJxCbVubd
         OMzJuQnB26STASsbn1P2y5yqqihWcI+LVXiQ57JzNDbcJB8FV+q3D1HXZajrsTQxKz0A
         d1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738941795; x=1739546595;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKN8sjRb3wgYxS8vD82nCdPhJYpZegmXytH3ZuvLDaU=;
        b=Th7/BtZi9EeR+hkaSdibU9WnbsWxlCQPTgLaUf5EEeYIeBVuh0TKnogvAB2ehPRVCY
         7VYo4Mo9wcjMZef7Xpmc2R37u8LcbYtUYLmVKBgmU2CzYfURCQ+lUvQhaiDrZNRBmSXX
         GieHVS3Svad1YHu6Obr0uJgEqpMPldohfvqLDjtvpg0/ivl0NLS7KiKYvGSJ57HCF+WF
         wbxCGMsKMlhtLamGFhtZvA3hMiFkogeXBPVkrOpOpbPEtWXmzfdXT4aLAJl+PfDZyMQk
         R5CpqT3rtV/CNfw+TSakl3eXetpzoMj65fTBC73G4apO2IPDbNBKgOp5sjza1rsOiAkC
         1UWg==
X-Forwarded-Encrypted: i=1; AJvYcCX3PafqYObR+Oy1Ngme0ihtnI0TI+Tw3F+oLdQJhCvr3z6WAsf8IVz7pH8N4qyw+5YLncVIx4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQssYvf/SaS/KFF/UifLiNXp94e0U5/VgEQD+OtqZNUAmm5N5
	tI9n5tOulYPp5i3qYaN6YOdXqmrVDntLpNRX3Ll+ws28v7sd9Cdvpca6HNS0b78=
X-Gm-Gg: ASbGncvSAoY3OPcTLQ0W93RFiEegcEkReMushq8GaTQc5knw+YaZSmjhfMrGbt2dYyj
	A6mLqDN/QBz5SQy26hNy8q1gmiFmowReCFaV/ENq6R8kcVJ5OtZsMdkuhMFn8duW/Zn+ru7EMog
	4+jBQEWjJZ48SUCdxvHLODqsXXWrB9YViniFaYXih7SqfYLTyfxkaRpnZtjohY9yt6FEBW3AoG1
	WBin7fh9KTXJ2z/+7X13P1Y98Pr3jUAkFb2j4g8TuXwY/zk6GQjMKh/uNV786CFsVVKMpNlXmMz
	x2LwRqEpcYLdDLYwtch2WxPiqwHUR3WsluMVmI2NkttxQVjjGAG8
X-Google-Smtp-Source: AGHT+IEEGiDMzanhY46VT0zPfUJ5PNu5OgiAyh3A5rsLRVIHkXKzWkfKjdhXcmoVPsTyGbzMvvecNA==
X-Received: by 2002:a05:6870:169d:b0:29e:4340:b1b with SMTP id 586e51a60fabf-2b83ed06682mr2385084fac.9.1738941794664;
        Fri, 07 Feb 2025 07:23:14 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b826261c16sm829675fac.40.2025.02.07.07.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 07:23:13 -0800 (PST)
Message-ID: <945b338c-8fe1-4082-a20f-57f8152e8f80@baylibre.com>
Date: Fri, 7 Feb 2025 09:23:11 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] gpio: max3191x: use
 gpiod_multi_set_value_cansleep
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
 <20250206-gpio-set-array-helper-v2-5-1c5f048f79c3@baylibre.com>
 <CAHp75VcNJzPH8to1Y6NzPMXnH48Ve4LJ7oid7_wEHtwhO82Fmw@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75VcNJzPH8to1Y6NzPMXnH48Ve4LJ7oid7_wEHtwhO82Fmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/25 4:34 AM, Andy Shevchenko wrote:
> On Fri, Feb 7, 2025 at 12:48 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
>> gpiod_set_array_value_cansleep().
> 
> It seems you missed my comment.

Yes, I must have been sleeping on the job. :-/

> 
>> +static void gpiod_set_array_single_value_cansleep(struct gpio_descs *descs,
>>                                                   int value)
> 
> This is not good namespacing. Can we change this while at it?

sure

> 
> max3191x_...
> 
> (I would go with max3191x_set_modesel_pins() to make it shorter. I
> have no clue why the function repeats so much from gpiod API naming.
> Is there anything else which is named in a similar way? Perhaps fix it
> by a separate patch?)
> 


