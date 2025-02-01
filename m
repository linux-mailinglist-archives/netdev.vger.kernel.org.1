Return-Path: <netdev+bounces-161923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82993A24A39
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248323A7505
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C61C5D44;
	Sat,  1 Feb 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KirQZXW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3A1C3C12
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426681; cv=none; b=qoLhLCwzBtB4CudyKJQTkGMVFLbccwVblUYFdJ2EX+4+4Rj8tcY38T7hpuUiqqNm3XMl12OmC+jsVczzTWrBvtQ1155uljwC/w80BjsF5Bi40NBcj3E3mU3YFQDFfIdwy+0dMq0mdGnwzMIzVArgSa8oDuLnklCZ/ZgTHiub1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426681; c=relaxed/simple;
	bh=xvd2NFP5FB+CZsHk6V20vbHOvYWsNy5uLFVc9vcIMRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNCO3mrU8LYIKAMz2fpmW/Jq+8qCR3UCR8OXN+ZunExvh5mcBlH3PHe5IhIe1hWlq9ZUTdOadrPIRm/Oio93GzenNBNirDO5Cb64aaSBvNYYwaoeS2hAgvqRUhikNEpLD/AawvIJu2AdU7bf0fUzJrnTgXdgOY6GcXuqOm1OLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KirQZXW9; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-723442fd88aso826178a34.3
        for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 08:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738426679; x=1739031479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xa6g2oNfuacwFq4nVjdCRSL/cRrTFR4jPo2z/+uIvHw=;
        b=KirQZXW9fhrVxIBkbls4JrCj4qPKGc4b7sPnylfDShm6gQAjfdZm0ICV4RxNMOIFQX
         YI9k+wKeslFceFY2M3CpcV6DYrzg/UN/19czNbKbiBVWCdjl3MFKvuIi6SVs9c9PNtgm
         N3sCJxs6r7hc83TdC6K5GiBfEGOeYoGw4++nHh+fvCgiezRFuDF6G3WLMnFEPM0ix+1S
         BF4ZLGrRvM7vXcORDTWdhElEVIoi67I6+mIMFSdFFe6ZuTa0rD2xR8TjlzxnYeQNX0Vv
         KBZejBh12HHi91L6j5xvJhnkfXsp4owYc3rXS1CfOdFQmHw6s7mdmpF41xpEFLn9NbNl
         ttmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738426679; x=1739031479;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xa6g2oNfuacwFq4nVjdCRSL/cRrTFR4jPo2z/+uIvHw=;
        b=KSqKZX8WVcacGAN/FGQrVfSd6rtjGAEmx8vC0IdLGlLUeLc0GfBf3AgfF7chDjfSA3
         Z0s9lZ2dFpRPtogbUwDqkQI7WjMpHMLZ3lanig2jG0Gn9Kf4t6lV6mEDAgXvOv3Xg2Qa
         caPoCJxp4bSXXBadSyhAThT3c6clDJ3O8qtBA24zUMR/yt1UYyoUECbDmuCeqb0kzc7o
         yLfR/xNV2FTurXRb+mRHe9YWcdYVsOj+cRXd1luBgWxVA/jeYLyFxmeEFqQWesxcj8IU
         fOQwX8yVkdMgOxoyKgOlWpKINJKAv50Lhh6cWP6sLm9XpL6qkWit4QOfYLfEpMhN/9nc
         UzOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXtTxzO7K+VUj4K4OQfQFMi/61Y1cDWYT0buDgm+4MysJuXtxD1d3aeLAEjB57yGUiTrgWay8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjeYOPXhEu7cXM5HeNaTE3yXGZnPpGnkPLZtI+dJcCYmJxBCX
	UbQ34nSyA0UUvjPjC4f7xeoq0pgsM8Ri8EjgN6lJ0cMRBo/StTsk9Rgiylk+Uj8=
X-Gm-Gg: ASbGncspzLvupHnPiAsVZ2FTKQvUdomdkXciwDpgT+bbGya7U1GPnY91UaBwrbmQ6dj
	PP8cREqqaGz9DT4Rrgv/wRlxWkq6vlXr7/CXu9s+Hu1VXT6nVWmUgXtuQyLOvHg2trTebQVGJmQ
	5kA9CcXelkbxLJ9XwvjZQ1A4l/+l+vPPcYuot0ddwVskQQ1hmAsQFdgCpK9mWBtTDRevCQ1bOPe
	d6UbdsqBW2gCPwpjaSWc75+nVY5coEHGzDefMiIkfAKjsu2qB1gLHNzvnB1aUnoyCNxGj34o0iI
	L0KqnQ9H3GN6v6mR31Ua3HjZAylEEbUQhDs+/kkqvYUcneoJjl1s
X-Google-Smtp-Source: AGHT+IFzTntDqApDTAnL1g6GyTMtXHnjjv0+Ekcn43kwaqkrr7pFq/ZL82JAD9ToxQaZIxfyiLBkBw==
X-Received: by 2002:a05:6830:651b:b0:71d:f343:5f5b with SMTP id 46e09a7af769-7265676f070mr10847417a34.12.1738426679061;
        Sat, 01 Feb 2025 08:17:59 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc104e27cdsm1476222eaf.16.2025.02.01.08.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 08:17:57 -0800 (PST)
Message-ID: <072be5a9-e0fb-4073-85b3-4a8efcafae09@baylibre.com>
Date: Sat, 1 Feb 2025 10:17:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>,
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
 Takashi Iwai <tiwai@suse.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
 <9931433b-5cde-4819-ac96-eea4f1f0f1f2@baylibre.com>
 <CAMRc=McEdcDs01BAKN5vg9POg_xxJBY1k8bfgiDN60C1-e_jow@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAMRc=McEdcDs01BAKN5vg9POg_xxJBY1k8bfgiDN60C1-e_jow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/1/25 10:14 AM, Bartosz Golaszewski wrote:
> On Sat, Feb 1, 2025 at 5:09 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 2/1/25 4:36 AM, Bartosz Golaszewski wrote:
>>>
>>> This looks good to me except for one thing: the function prefix. I would
>>> really appreciate it if we could stay within the existing gpiod_ namespace and
>>> not add a new one in the form of gpiods_.
>>>
>>> Maybe: gpiod_multiple_set_ or gpiod_collected_set...?
>>>
>>> Bartosz
>>
>> I was waiting for someone to complain about the naming. ;-)
>>
>> I was going for as short as possible, but OK, the most obvious prefix to me
>> would be `gpio_descs_...` (to match the first parameter). Any objections to
>> that?
>>
> 
> Yes, objection! As far as any exported interfaces go: in my book
> "gpio_" is the prefix for legacy symbols we want to go away and
> "gpiod_" is the prefix for current, descriptor-based API. Anything
> else is a no-go. I prefer a longer name that starts with gpiod_ over
> anything that's shorter but doesn't.
> 
> Bartosz

Oops, that was a typo. I meant to write gpiod_descs_.

