Return-Path: <netdev+bounces-70455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDDE84F0FE
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 08:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C896228272F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 07:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12ED657A8;
	Fri,  9 Feb 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DR/XbAcX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7B65BA1
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464853; cv=none; b=ayWDI5yv52aQF8qtPn3M2ygR5blNZWtxxUHvs8LbfSfSPQcE5fW/kvLwnzczUo8SbMBlm81dJKrJCvpZKkmPQNgT1PEpKtXEBWmTfg7qBiIQjm/5SSyie3s+bXYmaZcppnEzXSIic3vMHRQmKiUBfiktU8HY4OToBImMT7yJA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464853; c=relaxed/simple;
	bh=JKonGBchDB52cFU7sO/a5uJ5RwO4H9+JGhdjfV6XQgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilO6p/ub7lV4lPohGgYN/hzAw93rI5PoFzZH6SgEghn82tv6mtPLxLpxyUEa/NxzaddWEKxKDMOzm++Qyel/N0xqPZLziEbC+c9j0rhGA59+YAiiRX7tbXryjDzwq9FRdQX+r/p8TJFXGPY6Tbgj4mVmFLw5ju3Xa+aQX4M7JAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DR/XbAcX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so772621e87.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 23:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707464850; x=1708069650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKonGBchDB52cFU7sO/a5uJ5RwO4H9+JGhdjfV6XQgc=;
        b=DR/XbAcXPAfxjmo0TG/RieeHFfIvoHcuPdGitKrKqkRJlbQ76/Ug6r2x2ZVy4SO5Zk
         VPtTQGRgcKv73KBpM/Dx+AMX79oU1PkYPSEpONqC/hJytDnJ25RGxXFHsYa+xGe/qTg7
         wHsJFx7U8EMl9ziIvbxPcKQgHNs34z7aQHv6li05sUKCFTnxkf1IdLbzFJCUPtRMS655
         hO3UJHU1ZFKcANZYOcDp7zLTsh2U8FtyMDNOES7A8B0d7DEXNdqGyDmCaf9khb10XJCR
         ia+0hEpLB+gXDKq6e127JxdBQTiYVKbYkXHyWiZrb4Vw5tsfjaU5SmJd9MBb8rM0a+YT
         jqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707464850; x=1708069650;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKonGBchDB52cFU7sO/a5uJ5RwO4H9+JGhdjfV6XQgc=;
        b=EoYWfGPeMtRbZJp6JgKiupnZfz/RFrJpZp/a8skA/6C4xrERaSKfBBre1bAEJsC7+V
         kHx77VgLMW5iGRXgZs9s5aAbYu+POhcZJ9clWCSdCO65Zhjt3HPy/rz3ngtDSpK4UjaY
         iK6E/c9z9fUdGGfQjdASYZgB/NdmIzYy3y1kg8fHg17GcCHSH3nP9tuYWRnoB/RSjf5Z
         R892klJwIE+WJxXP1UxLfoC0R84qujLYiXbRehgtvrC0pk5AY9KVu2JA0aQ85Tko7hOC
         ri5HK/ahBQ/5/r5tcroXD+X+Dw4tt/JBSRGTVUJful0zq73C46FFdcXL3PiB+CstXOt+
         5XLg==
X-Gm-Message-State: AOJu0Yw3pY+OAlVDkXyf0yfxvrHT1a3baYVa32XSNMLpZvoopuULbUYa
	SusD9z4vtfsHf6GED2cY799fGUWf0CIII6A04VFj9lGsFopjcraybCTCWUholbc=
X-Google-Smtp-Source: AGHT+IH0SXcnVXQX7ns8ygxbKDUiBT0JnW8MDznrEQp41tx2y/L0cU3ZZQMc1ZsSkqOT15UlSBoTgQ==
X-Received: by 2002:ac2:5397:0:b0:511:76ea:78f2 with SMTP id g23-20020ac25397000000b0051176ea78f2mr490051lfh.34.1707464850068;
        Thu, 08 Feb 2024 23:47:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHqqFb0eHtNkCMrHshqW9wPRnvz+cGZtmxHpQWfaZaNNS0+SBqzmxYbbervYA5Rimjh0njndZSbsYhZgXWBP7D+BN4oZReDuDh93YJL59bn/Z3dRn1rQP7ae/SZgGtjmgMPMZigpf8LJZsazACYgyJ4zReoIV7P3FgP9Wz5HXX15MsQGfm0kfdn1Y2gVGjHSMaIzWv4a4fDcmELNKEL3FKwWMYcfUxbZAJUv5Jspr9jehMjDxKgdVa2zo1ryoUCRaAJv9nVT0uNzct9QyFoOG+o+Ty59mniiVhbp9TqpzRjrtup8fyVuOf5/SPXRMIrENzUntkDxOgr9ZM6onLSGWr3chj7MSSCLX2LtMIVU5Y4w9OvCtDsK7wIcSdhIqKNmwJVG6zg5/pTOlgjSVkr4rVidSg
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b0040fdc7f4fcdsm1791764wmb.4.2024.02.08.23.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 23:47:29 -0800 (PST)
Message-ID: <0c47da33-3f50-4b31-87bb-3aefb01c0e47@linaro.org>
Date: Fri, 9 Feb 2024 08:47:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: realtek: Use proper node names
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240208-realtek-bindings-fixup-v1-1-b1cf7f7e9eed@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240208-realtek-bindings-fixup-v1-1-b1cf7f7e9eed@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 23:40, Linus Walleij wrote:
> Replace:
> - switch with ethernet-switch
> - ports with ethernet-ports
> - port with ethernet-port

Would be nice to see answer "why" (because it is preferred naming
style), because what is visible from the diff.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


