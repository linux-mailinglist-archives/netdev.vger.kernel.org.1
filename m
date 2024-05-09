Return-Path: <netdev+bounces-94953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3858C115F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40115B21CB0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5854EB37;
	Thu,  9 May 2024 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvs4oONd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35512E1F1
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265570; cv=none; b=oO/gi6ybYJSwdKSBcReOMXEtAFnyvl3YzjoerPImBHPNEditdVUReg6wzZBDsZ6nRishkmEHnLHZo7gNeL4BDUKcAnc8aZz6J9UcnE5DVjrUl0D1UQW9uqzyOL5QsctDeUAS0+6r7FOMyYzbKBHkufHzqZo3F+BRlH6EMHHMeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265570; c=relaxed/simple;
	bh=Oqw9hCVQzSIH3enl+rGm71JD1XIoGust4N0femSQBcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xep/io61WyTsIy6byvcVpQMoWBis4Yd/cc79EBmAJvfI5JNlomcXcMxEj3h9PRarhNNOFSIOlFxG6fLx08QSs/MPRQWrUxwnTUl8rYd1OTnI2DBSCb/Bdg3RwnGbu3DNXVF+eH9x6OSL0C8XCjqccr9YpyP2GBq6zhhpruJPVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvs4oONd; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so250147366b.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715265567; x=1715870367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0fgJc8E2KgKNGLKRWDqADYaZW8wGqtQXaUAbdG1wpeQ=;
        b=dvs4oONdcrFA38TKdRlkc+gKW9q+qHwNjN8U5UXJhDCaTl7p/eD6Sh/Tjafm73bNua
         KRSQsCPeBqnbPfb7k37vlt82xm2cRvd8lcxcr1fxDlvfZcUIF0mNFTI62Wx5DvLhFal4
         MOCN1kg8/wZ/eRPcGQIIRCzDxFST8+zr09Z4Mq0/djqaexe7DuZwnp/tRGZ/iVFOs2NL
         xVIdfTWoDKZdeiaAU16uu68wZMIvqUpssuIuJSzWOxRnNUdmvzYqHSNVioG+yW70jmv2
         0uYfnIQAIvx4J0B51AOfe6w+70C9C1J4GQ9K83u0yqIUA2OmWMZ1GRPum8QkhbTHiCNQ
         LHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265567; x=1715870367;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fgJc8E2KgKNGLKRWDqADYaZW8wGqtQXaUAbdG1wpeQ=;
        b=p1ZjNXOO1uZhk25/wdNSZyghryh25e+HUgDgXX3AE2ihUi+XrnHlurNa89XD3B1cTJ
         Nn4vdnc5gGcVnJrhLjxsgn9xUBPGylISLfMT3itLmyadbK1g2T18PMS9KFdMVACnNYIQ
         Hx/Zh+CPAUp0khPlpT4rniKqfUBB5KqUSR15aYXo0B6A+uqX4B0bhYSuRjqf9I8872+j
         vOwVquOWTd+JAZzEMG1ZIHWdjCgn1LJX8U2DfIo9xtXcfaEskn0Q95bvM5AnllHBUNdO
         5aoC+OUnC4I6nHB1kkKF+RUfZjsA5KTS7ei1+W0bMwcVFXBNLwnAfeVjCbfpiukApBp9
         kuag==
X-Gm-Message-State: AOJu0YzwR3HdEigk7EWOOJR/MR4K2UPx0EH8Ic3cpxHxep1LUCrEiva0
	6VHp5/czgz13lzLpWmkjFs2FRVz6BCFBbQP2NmtOdOggnddFTQvsl8qTBvGIs/0=
X-Google-Smtp-Source: AGHT+IHAOUtraPit3LFUN1WYaxGf8dh4ewy5TUHSh7A4MPnn8ZSogz3m1n8IOCsvqL/uzks3qqb6eQ==
X-Received: by 2002:a17:906:fac3:b0:a59:beb2:62cc with SMTP id a640c23a62f3a-a59fb9dbd48mr357841866b.61.1715265567328;
        Thu, 09 May 2024 07:39:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178a9d68sm80346866b.80.2024.05.09.07.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 07:39:26 -0700 (PDT)
Message-ID: <a6958ed8-05dd-4ee6-bae2-a35293958271@linaro.org>
Date: Thu, 9 May 2024 16:39:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syoshida@redhat.com, syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
References: <20240509113036.362290-1-ryasuoka@redhat.com>
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
In-Reply-To: <20240509113036.362290-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2024 13:30, Ryosuke Yasuoka wrote:
> syzbot reported the following uninit-value access issue [1]
> 
> nci_rx_work() parses received packet from ndev->rx_q. It should be
> validated header size, payload size and total packet size before
> processing the packet. If an invalid packet is detected, it should be
> silently discarded.
> 
> Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> v4
> - v3 patch uses goto statement and it makes codes complicated. So this
>   patch simply calls kfree_skb inside loop and remove goto statement.
> - [2] inserted kcov_remote_stop() to fix kcov check. However, as we
>   discuss about my v3 patch [3], it should not exit the for statement
>   and should continue processing subsequent packets. This patch removes


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


