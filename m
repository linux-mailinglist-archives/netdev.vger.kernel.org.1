Return-Path: <netdev+bounces-124265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB29E968BFF
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B464B20D36
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B51A263D;
	Mon,  2 Sep 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvsrikEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85413BB50
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294276; cv=none; b=M2JLfWDZS2RvWRKivtYL8URcWyJLqEQ+44pVLZlGZVS9XR8iMDet2KbFKjwDspwBEB9z+nuNAUZ/YkdjpYaIMDUmbYN8iFW/5iX2CZ/e/vjd790jBzdZ/tfGjbTc0sc4jrKWPrVbCf6DrHxrr6CJsp4TuesHzf+NKTpzlC2uHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294276; c=relaxed/simple;
	bh=Oi1xtxZESkLjsTPIXDBvHSah6LjCNmGdq4rLBIHR8JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuMLJwOY3HEiqYccC3aJJPRBc6Ncb7S+DEATWCG55q+P4rXf4+DfDkdb/YMQ6dDpYfxn+7hUtLDLDDU1wMeRaF/c5kYRNLTf4aH+rqxhVkA6pAQfCxhwriUavWGi3GBt3z8o+5A7sQXGWKlawaO3oFLScUBmu6U6O1wtqrA/tW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RvsrikEB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c255eab93dso212676a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725294273; x=1725899073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j/nLDhNicjCjfXVFv1I2whlaDgogWUtwTeLwCbZKBe4=;
        b=RvsrikEBr8icyMcIcPsAbie4YFas+oJEmv7XsB15EhXkpcWYicupsrdfIjkXtAQRDa
         L5lkQFmmVCjjCHMyZbTa+MDC5RSoyGHboXTHwNSSwWhVTHfkWvjTx/5yYlK+s3fR8WVm
         gBYpGtI2DADXjAD0YIj3UFdVzDNgdvS88MPwn2JnMPh0Qa8bhC5UyA8yBrEf9lLtgJFN
         npsCHvXx9ksXmHj69eolEJ6ahR7vcNs1zrsEAfCXnN+16WEVi37yeGBNiqzJmzLNOZGO
         6qoq6S8FddL8ieFgHUzPkVDKrMk5U1yfQYY+X2BDFnM1bci2yTLvh9/sz32tBlUoJsBO
         /OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725294273; x=1725899073;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/nLDhNicjCjfXVFv1I2whlaDgogWUtwTeLwCbZKBe4=;
        b=vFTvV/D8nL3nSyWCRKjO/Jkn8Zu3rM42gSoSEpl0yxad7ajxbzIuWLxeFX10/e+aTh
         HYmvX5iMk4DMeNOxf4taKADQVWcFEuAUcHoBC2qfWwBMMQiKwE01Likd2H94zSlTScxg
         zLr6l9HUDFoQrDspClPb1YkK0faBDQRTTtIwdFbCYk/EwPwQgz9VmmVTvVjEjGxBw+rA
         9Gc8WFpSnLpqoZPoqMC8qiOUvC4FAdzemnr28cyURppyjfiwc9w36SClcxLLUVpye6NN
         jDK6MuEs70zBBnGoTSWpL3ku3xfz5DawczgW1l0pE+Q5egb3q3ue5p9hmd9v3D5JnvmB
         TukQ==
X-Forwarded-Encrypted: i=1; AJvYcCVza9Qlh0NWNdsNaEXZNThz79yuYB+Qcze5sRky1l48A65wbUtyQqUIv8AhTeEotxm/CkrRqdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVor03ipt57V743FLrZ2eE0FBbcQQXOKqymQzoS8ufkEyKhcV/
	EqROnOcHSwnNjv/TyXmTUNOvyFkKGsxekjOGsQUW1reeqOdhaR/WhkEmOh/hXx8=
X-Google-Smtp-Source: AGHT+IEZxX1ltVEvf9fEZeEUPOXHcL4+Ovmywc5a318DgvURQnABzhb0d+8QEx5+AuFm/q5LsqIq+Q==
X-Received: by 2002:a05:6402:5254:b0:5c0:9fce:8fc4 with SMTP id 4fb4d7f45d1cf-5c22f9495a2mr4141700a12.5.1725294273102;
        Mon, 02 Sep 2024 09:24:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c7358dsm5733985a12.38.2024.09.02.09.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:24:32 -0700 (PDT)
Message-ID: <17dcf3ed-a686-4991-895e-5d684a011d62@linaro.org>
Date: Mon, 2 Sep 2024 18:24:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: alacritech: Partially revert "net: alacritech:
 Switch to use dev_err_probe()"
To: Simon Horman <horms@kernel.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Yang Ruibin <11162571@vivo.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830170014.15389-1-krzysztof.kozlowski@linaro.org>
 <20240830182844.GE1368797@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
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
In-Reply-To: <20240830182844.GE1368797@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2024 20:28, Simon Horman wrote:
> On Fri, Aug 30, 2024 at 07:00:14PM +0200, Krzysztof Kozlowski wrote:
>> This reverts commit bf4d87f884fe8a4b6b61fe4d0e05f293d08df61c because it
>> introduced dev_err_probe() in non-probe path, which is not desired.
>> Calling it after successful probe, dev_err_probe() will set deferred
>> status on the device already probed. See also documentation of
>> dev_err_probe().
> 
> I agree that using dev_err_probe() outside of a probe path is
> inappropriate. And I agree that your patch addresses that problem
> in the context of changes made by the cited commit.
> 
> But, based on my reading of dev_err_probe(), I think the text above is
> slightly misleading. This is because deferred status is only set in the
> case where the err passed to dev_err_probe() is -EPROBE_DEFER. And I do

That's true and indeed request_firmware() will not return EPROBE_DEFER.
I'll update commit msg.

Best regards,
Krzysztof


