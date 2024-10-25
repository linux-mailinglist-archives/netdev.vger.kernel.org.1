Return-Path: <netdev+bounces-139132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D79B05A3
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9221C2384A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C0F1FB8AD;
	Fri, 25 Oct 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvpyJaVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803F31FB8B9;
	Fri, 25 Oct 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866134; cv=none; b=Gfy9//U9B+cePzBVRUFCEtQYjgUy/NglIIZKNJCgWsINKGqj/hNH6chec6IApz8N2C8ChWAoGtuCHOy9IPJwMr1FJfoip6Jy1Y/2F5ruTEPxzAJxQS7iL8oyw+Af4dOKztZqkNTGK6GcSaBAyLDeg9th2+xIGgeXJeFUT7KfuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866134; c=relaxed/simple;
	bh=G4atOyxM9jgJYS0gyVFPokvnqnRIuTR8/gUzRdXWmR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=THOZaCs8H2krfnCGJFfU5CpAh6jM1CvejsBLXXKBi2m6T91zd8Bp28QgJi0npA5kZhUofXHQxE8uwDQ3bejyh6n0ZTSVSBIX3wwW2CqCa1gNL5aJUEOvwlia0mjKLgghRzzKq9PBVYyVu5hP/AnTQ1k0cAeVef38FSgKmIUQV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvpyJaVJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cdb889222so19014305ad.3;
        Fri, 25 Oct 2024 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729866132; x=1730470932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=J+SkgqVJgNuicstP3JsGRFLErFj8SbUewOJTdMcB2kY=;
        b=VvpyJaVJ1jFuifwPcA8rMEGM9rbL2Qu6+Gt8QqLiNsd3Yqv4OgjYe1AmuvZdRr//q+
         Vv4axi23PDH1vHCIwkMm8cHslq4mCuPy+z4+HnGsreajbnrNxysXVwHoZP2sD9QKrIkH
         MI+h/rxR+ITtetAMLTp36CNw2/RG180kTB4v6+8MVX2O71fJRBR28reoqkE9P00WfEBN
         YuTBqru2I5AXB69+4bJqFCC4+wLwDrmVRt7Z/Aip26XZAsjl4ArDRT9EaUH7hPAHKnZW
         sUjxxBTy6EdMGzendLn1bPlD5mKy/HY1/5ecApnb3nHN0LtLR81UrP2+e5ndFIQKpxiU
         iyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866132; x=1730470932;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+SkgqVJgNuicstP3JsGRFLErFj8SbUewOJTdMcB2kY=;
        b=Ex8CpNJWqlgRVBdAj/qRjL5f7jzK/wt2evs1fXpfmT36Vjl++56hlWXkClC4P0BYdX
         feuWZ0hQA5vpjdeK420irKu1mbP5MEyO8Hymo7E4Q0HMVkfE/ztUhDtpVTQV+WaTeJgn
         iLjEby5bzrlnH1rPtmAM/qNIDLKSOAQh4w72APtYq99iRkWLI6UFDufM9mibApzKEk6l
         APFZXGKzyCFqbuunCJfIyrxpPQCX54FKz2LvjTQ+UxDRU+kdKbJUUP1+s8yrFG8aqn+k
         ynW9V4eBmcVdEs1Z+ar25BxnzlCxCWRwlxMT/gH4uH+AMa7JyZGLqh0iGJdbT3ir+XYM
         gNeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+mTDUdiXoKMfOkv7UD7xsHuBetQUQM1FIpgEaZaYHDyAdlWUYWd67wFyzFwXHJzp42WDV467y@vger.kernel.org, AJvYcCUl4kJaPs5Jf0xYQsIyKfsZ2dDCXIrUaVwCpLtd3OBSdy8tetn53fGakF4a7r25PTyLHIA/U35gxQJF@vger.kernel.org, AJvYcCVYDoTzX3H+VFwKJOWu9G20buASZ0FQ7ulZDHMptgYSNgoB/Ta7++PZ4QsEeKl9SlLHZDTLhV+OcP+x6Z+F@vger.kernel.org, AJvYcCW/Q23dfmuiippNcN8xuwPAA5aK7x4FAliae5sh/it2amk+GlUovh8IOq4tAXhHcpzhrmPr8FdKlinTClc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyotf6DZaqY8JGVJ4wr7Le8EG65KvHKJvpYU8cJvcdeQ9jkYwGC
	8MZob9+XoOHgGRY9LLzsl84/+CGMaAuc4oUxoMUOW30RCU/wtcB3
X-Google-Smtp-Source: AGHT+IE0HJgh3tgcsL6OQ6cerJSSzvl2kzimxZhUmfqvyOZzTwOE9jF1+jxbo9KS4avg/g5ONz8VRg==
X-Received: by 2002:a17:903:2a8e:b0:20c:d428:adf4 with SMTP id d9443c01a7336-20fa9eb92b9mr144717375ad.38.1729866131679;
        Fri, 25 Oct 2024 07:22:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf44743sm9914485ad.21.2024.10.25.07.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 07:22:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6955c8b6-58df-4b1a-bdd6-759de3d3c46b@roeck-us.net>
Date: Fri, 25 Oct 2024 07:22:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: ltc4296-1: add driver support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025115624.21835-1-antoniu.miclaus@analog.com>
 <20241025115624.21835-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Network Development <netdev@vger.kernel.org>
In-Reply-To: <20241025115624.21835-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/25/24 04:56, Antoniu Miclaus wrote:
> Add support for LTC4296-1 is an IEEE 802.3cg-compliant,
> five port, single-pair power over Ethernet (SPoE), power
> sourcing equipment (PSE) controller.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +	hwmon_dev = devm_hwmon_device_register_with_groups(&spi->dev,
> +							   spi->modalias,
> +							   st, ltc4296_1_groups);

New drivers must use the the with_info() hardware monitoring API.

The API use is inappropriate: _enable attributes are supposed to enable
monitoring, not a power source. The hardware monitoring subsystem is
responsible for hardware _monitoring_, not control. It can be tied to
the regulator subsystem, but even that seems to be be inappropriate here.
I think the driver should probably reside in drivers/net/pse-pd/.
That doesn't mean it can not support hardware monitoring, but that
isn't really the chip's primary functionality.

Yes, I see that we already have ti,tps23861 in the hardware monitoring
subsystem, but that may be just as wrong.

I am copying the PSE subsystem maintainers and mailing list for advice.

Thanks,
Guenter


