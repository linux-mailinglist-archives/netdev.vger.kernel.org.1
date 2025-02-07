Return-Path: <netdev+bounces-164044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A74A2C6F1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BFE188F976
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD61F4183;
	Fri,  7 Feb 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XYaujCYb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E401EB195
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941842; cv=none; b=HXZzqKrOPkthSY1wATiMMOQLUXhj+6do8b8yg1hlzI0P1X7TjcViRn+AI4k7xL2CW4WVw4v+efp3NXbSPS8MOOCxJrpz3vMA+GF/k+KUswWs01wgu3+dpWeosutJr5g0gTVdYdLrGCaBXB0cgD2+fKIn3akc78ovLQV3s+fpK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941842; c=relaxed/simple;
	bh=0QDQqHrgVLXCxx+qW9kTksbcFhM3nUPG5B9br80WLWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCt1qAB1mDQeaNIh/OPp4/i52qttRQswn2oeOOKaXrOvLbN6r3CKR/k15VLVFmbo54NaCuPdg1WsqREMQKtVWrLeGILyMcpJnBNtNTFeWDMbWAgILIlNVfn/hX8vTAcEANvg+sSo5FXSXoRprP2sK7HFUG+oZy8wS2oDD9Q8lco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XYaujCYb; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f2b21a0784so642188eaf.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738941840; x=1739546640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uxr/gLgLMBNgytGiMYTlRHUYI9qRODMAWATD12wZy7U=;
        b=XYaujCYbI88MZnV/G1lJee/MJ+aCiASTiFsxGFr9js3x7vf8JGH98j/GA1jebLnB7k
         AYCBzmQ5J04Kkmnx8bwh5xQuGwHIGssb+JITSRCnTiScbPdDSJ7oTTtxMQ7jMCfICJ5h
         AGIvkX9jOQ7Ulj255s8i/mBds32LVSMexP+G7G1coNQJqWieGncNv0zDB+nUuoaNWx9a
         Ym8HUmf231hNfPIToW0B/21hQn3CJeW/8kLwDhLnMXi09ErzQN86A4DcQz7yYQFh6IXm
         blS/OJmd0k2WGFyABzHbqHbdlIg+4QZ2NTvP0JqoZ0aSyZuIgki6GSgiClYuTufvcFAs
         xTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738941840; x=1739546640;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxr/gLgLMBNgytGiMYTlRHUYI9qRODMAWATD12wZy7U=;
        b=PyCDAxASHTAxSW8VXWwHLkFneiMzihiwMRsJ8ZnQzrKdTw5tjfEx+7UAupxYqewnQC
         XEEsNxtEP/cd4qXXkjt8fPFv5cFRt8Itna0g0ofeaIrkf5A7vMHOg/4AVSpxbTQR6fe5
         X9Xj77FZhoqEIdIyShzAgJ337pQuKFHeH8qhi2OUARRT8pLECBkDIO2cGdv22Zck0KlD
         wiPKJyj4YS6ww/TTP2B0YdpMda2J5ahVecdW0w+UQKQhfJk7fU0SQTFGG90Ph4BJtiQ2
         nyxz2dLKaiyZN+TMS7S9YZSxk474QJxBHncXPMZ+Dn3JHIK01MWLmk7uxOJ7nmSr0I6Y
         4jkw==
X-Forwarded-Encrypted: i=1; AJvYcCWFGicaCBe7ExQNfhd+m0sbHQmpj0AbTk3YAkEY6mFVOdLQN0mw1iyp5aLftt0Q2aKDrYddLJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxci4Wbe/1NrzZVK1mAFi0eDhQ55aEwtN5RlMJG7zNcRDm4kAZG
	lARoeuf74zb5h991Jf5PKvzHNxPCeX4bUDD2VqbMNMMZTaGM19mWEyLbH3L8sAo=
X-Gm-Gg: ASbGncvVgakDarGWVYUCQojpvZTCLDuNqQFXaxCGxOOHo9o5kLlvOlbiTvAn6OlpRzf
	I+y0zcxoRBfo5GrqskWITVCvx6SCCVdioZkIk4wEVAKdia2+iR/1/2GSNAxDy+0AQQc5vsshmxg
	SB5WG/nl7BENT1ZmieHlAbD9CjiBHlB4cf4IZXFoe8+3bwpVFEpfjMm/6u6sxzOgo0GJrnRFnsm
	u92LgGZnAQh3NhZu7Ubct75p01dbEnqWq7dti+Pd1bRuJ9LTxu+MPfP9QQrQ6BIPriu2mbON2gy
	LTmGp7HpUfusgDMxG872aVy2rsVTvx8pr60NhsoqpPf6K8wE7XRt
X-Google-Smtp-Source: AGHT+IF71KkvJXcsCE6zlhD6P6zBCyc3Fr6QETt2X0hURimYWWudXZ1vnECtKv4gtVKmBwfLEwmh0Q==
X-Received: by 2002:a05:6820:162a:b0:5f6:765c:d260 with SMTP id 006d021491bc7-5fc5e707990mr2247407eaf.7.1738941839640;
        Fri, 07 Feb 2025 07:23:59 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b03b4sm781542eaf.3.2025.02.07.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 07:23:58 -0800 (PST)
Message-ID: <b1459947-18ec-4835-8891-5251d8f8c95e@baylibre.com>
Date: Fri, 7 Feb 2025 09:23:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] bus: ts-nbus: use gpiod_multi_set_value_cansleep
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Yury Norov <yury.norov@gmail.com>
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
 <20250206-gpio-set-array-helper-v2-4-1c5f048f79c3@baylibre.com>
 <CAHp75Vf+3pc84vV-900Ls64hM1M7Ji6Dmy8FPwL=n0=sJFSuVA@mail.gmail.com>
 <CAHp75Vdt5EU83mJrB7Sb_pgRNbhvCQ=F2Lyq7mQLAvV-w6cqEA@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75Vdt5EU83mJrB7Sb_pgRNbhvCQ=F2Lyq7mQLAvV-w6cqEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/25 6:17 AM, Andy Shevchenko wrote:
> +Yury.
> 
> On Fri, Feb 7, 2025 at 2:15 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, Feb 7, 2025 at 12:48 AM David Lechner <dlechner@baylibre.com> wrote:
> 
> ...
> 
>>>  static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
>>>  {
>>> -       struct gpio_descs *gpios = ts_nbus->data;
>>>         DECLARE_BITMAP(values, 8);
>>>
>>>         values[0] = byte;
>>>
>>> -       gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, values);
>>> +       gpiod_multi_set_value_cansleep(ts_nbus->data, values);
>>
>> As I said before, this is buggy code on BE64. Needs to be fixed.
> 
> Or isn't? Do we have a test case in bitmap for such a case?
> 
>>>  }
> 
> 

Maybe not the best style, but I don't think it is buggy. Bitmaps are always
handled in long-sized chunks and not cast to bytes so endianness doesn't affect
it. I didn't see an explicit test, but bitmap_read() and bitmap_write() use
array access like this so indirectly it is being tested.

