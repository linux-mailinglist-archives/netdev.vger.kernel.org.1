Return-Path: <netdev+bounces-222483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD73B546C2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FD5B60663
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778C82765EA;
	Fri, 12 Sep 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4CtvbSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038325A2C8
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668631; cv=none; b=l3W4HDLlfGwQrW93HhUC80NY2ABGjqHSSaY0S0GcqvUGP8eUeJlEAfSca3Z5QhXZHTukaWCPvmiV47/OxRh8IfJ11JUuyH4oOV+riiAEHBRxyqxMYSoPK6dYhoRLmblpqxEFId3LOVqTBhqUtwmX/jiBit314faSOfzMRDwTLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668631; c=relaxed/simple;
	bh=a5RCVLs88Ds9tMcha2Ryp9L18Wn0jZU/FrTcQ5n5tyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+2bs0gThgIv8TXqQ0gdoygCZq4sPqp8O3JSZsaCn+QH/axhhsE6oSVtGHyaLj8j4mTRR3M7u5G9B/JJuxp67FSdsGbPcugmg7Tbyzp60BhR6NLTnXz5Uw1pcTfPqoXDJuK0uG0Akno9CNG1jf1BjV3cshFe2jzOR+IGn1mSAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z4CtvbSQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45e05ff0c86so1863595e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757668628; x=1758273428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Na0sRM1JzNDX0cAD9RNRTd0BRFOVeZmTu9S+7uFIpUM=;
        b=Z4CtvbSQCYOKjzrrmJnQXwmEAbznId7qRcMsI5lfA+E3G3HhnjuiEd2xAp2PQZ/fIs
         fxU3SCm+XYIIkyQrGTAon6ZS0afSUpkWmIcGIhvskODmj9ZjhkNgndNJPouTXw3J5pAT
         rkYhI8tHhWFRGBD4t11BVV617BBDZ69YYCVNfH8xtkSn2jEvYzXt4Yu0aoK//Hj1YqzI
         7OOf5/tS6Ep0eiNoJGg+YvAqsMrpCXGkleAhcyvwkC2upBqzeGurLvp6uWDv/YevfrK+
         H7iAtHdQv76aCDVQ694jw2GEJ4Jlist7dVR6luK0yEPe30MVTpy82KTh7H+k7plYMzw5
         R7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668628; x=1758273428;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na0sRM1JzNDX0cAD9RNRTd0BRFOVeZmTu9S+7uFIpUM=;
        b=HsLhfAzapW8ENCMSxMHZPpnBUtm+GJihRM5DOHL69lZvDNqXkiccbpEKLDOSXZsw3+
         5ZkNgG4R0nrtoAmRwbc2MgBlzHsNB9P//zbTt5Hirf+aHL6AqpGoA/8igwjADQdkdIRs
         tM9KxWu8LFzWw7M2IISb8/DRFkTDC3m/ATxzhN0IKKpitxnXDY4SYRSfZVDcXR4lrOxu
         WDHIX+pH6xy186gEaD7PtVbLGN3HwG4o/efMlXw9L0ipODu9KdSTHwnco5dEeALvTofj
         STm/fuOSC1wovgnd0VjtpciKIc3DkvrGJR8NE8Fmuci0oApkjaJ7vs99lh8/fZmdN8ES
         iE+A==
X-Forwarded-Encrypted: i=1; AJvYcCUR7QnBbZ7fozWOvxGMK6Zy3wJJUmVeSupV0mO+KqfjAY7HjPdXNqFYOOFFyB1RI/Ox912CV1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1orx62MmvkIHjdumYjBbMsJTT9DtV4wtFFeevCXdDNSl912w
	EiTi3ZvQiTAvOvFCCS7xBnIbxqe3z5f9DJTG10wdw9xim3mtSeGGYF2tTPoL8PljoBo=
X-Gm-Gg: ASbGncuu14mSAI5k2s6Gp5bxBFuU0V9leEnK8HROCM8sXzGVRw3Ez+wER/RlnXPmzXb
	xiwEU27W8rIxzeHIDQ15pOnFVkC2sIxKUkFPwla9bI7++r1OZKaxDKA3L927rjxgWHZHfLOgv4e
	4zc3TkXZvGM0Xn0MBKbc1Q3os8qIK5hO63qbfqWVFcR9QRggtkNTi2LyDv3/NwzHMtYTZIs3Mht
	XLj32nhzczLWUv/SRtP8uvrrQOg56oBTqCo1aDBtyf/Gv9MIhAgFJz1JAX2y9NJargbC++JbfzM
	KoUMDbbKttYEyua2Le6nubSxUfbU8KZXJyXMgxTy+shqfae4hUnXmFsOYHkNS9c/mEVlKMOLC3S
	OXPHqHnGj/woaQ5w7FHnnb3Z5A3m15oZ/cecIkVGE/+0=
X-Google-Smtp-Source: AGHT+IHTCW9xZs8Bgrgtw3py8hA8Nlqz8Jk0NP4ZX+1dPY2l87YZ77GgC3GQhGAE7LZOnnpcJM3huA==
X-Received: by 2002:a05:600c:c165:b0:45d:f7df:26e8 with SMTP id 5b1f17b1804b1-45f212095e8mr13275895e9.7.1757668627916;
        Fri, 12 Sep 2025 02:17:07 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017c1dd3sm32051445e9.2.2025.09.12.02.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:17:06 -0700 (PDT)
Message-ID: <52714c33-5bd7-4ca5-bf1d-c89318c77746@linaro.org>
Date: Fri, 12 Sep 2025 11:17:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
 Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
 Devi Priya <quic_devipriy@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
 quic_linchen@quicinc.com, quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
 quic_suruchia@quicinc.com
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
 <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
 <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
 <2951b362-c3c1-4608-8534-4d25b089f927@oss.qualcomm.com>
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
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmgXUEoF
 CRaWdJoACgkQG5NDfTtBYpudig/+Inb3Kjx1B7w2IpPKmpCT20QQQstx14Wi+rh2FcnV6+/9
 tyHtYwdirraBGGerrNY1c14MX0Tsmzqu9NyZ43heQB2uJuQb35rmI4dn1G+ZH0BD7cwR+M9m
 lSV9YlF7z3Ycz2zHjxL1QXBVvwJRyE0sCIoe+0O9AW9Xj8L/dmvmRfDdtRhYVGyU7fze+lsH
 1pXaq9fdef8QsAETCg5q0zxD+VS+OoZFx4ZtFqvzmhCs0eFvM7gNqiyczeVGUciVlO3+1ZUn
 eqQnxTXnqfJHptZTtK05uXGBwxjTHJrlSKnDslhZNkzv4JfTQhmERyx8BPHDkzpuPjfZ5Jp3
 INcYsxgttyeDS4prv+XWlT7DUjIzcKih0tFDoW5/k6OZeFPba5PATHO78rcWFcduN8xB23B4
 WFQAt5jpsP7/ngKQR9drMXfQGcEmqBq+aoVHobwOfEJTErdku05zjFmm1VnD55CzFJvG7Ll9
 OsRfZD/1MKbl0k39NiRuf8IYFOxVCKrMSgnqED1eacLgj3AWnmfPlyB3Xka0FimVu5Q7r1H/
 9CCfHiOjjPsTAjE+Woh+/8Q0IyHzr+2sCe4g9w2tlsMQJhixykXC1KvzqMdUYKuE00CT+wdK
 nXj0hlNnThRfcA9VPYzKlx3W6GLlyB6umd6WBGGKyiOmOcPqUK3GIvnLzfTXR5DOwU0EVUNc
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
 DFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92Vcmzn/jaEBcq
 yT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbThLsSN1AuyP8wF
 KChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH5lSCjhP4VXiG
 q5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpFc1D/9NV/zIWB
 G1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzePt/SvC0RhQXNj
 XKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60RtThnhKc2kLI
 zd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7qVT41xdJ6KqQM
 NGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZv+PKIVf+zFKu
 h0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1qwom6QbU06ltb
 vJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHpcwzYbmi/Et7T
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <2951b362-c3c1-4608-8534-4d25b089f927@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2025 11:13, Konrad Dybcio wrote:
> On 9/12/25 11:13 AM, Konrad Dybcio wrote:
>> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>>> provider and an interconnect provider. The #interconnect-cells property
>>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>>> the NSS ICC provider.
>>>>
>>>> Although this property is already present in the NSS CC node of the DTS
>>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>>> omitted from the list of required properties in the bindings documentation.
>>>> Adding this as a required property is not expected to break the ABI for
>>>> currently supported SoC.
>>>>
>>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>>> binding requirements for interconnect providers.
>>>
>>> DT bindings do not require interconnect-cells, so that's not a correct
>>> reason. Drop them from required properties.
>>
>> "Mark #interconnect-cells as required to allow consuming the provided
>> interconnect endpoints"?
> 
> "which are in turn necessary for the SoC to function"

If this never worked and code was buggy, never booted, was sent
incomplete and in junk state, then sure. Say like that. :)

But I have a feeling code was working okayish...

Best regards,
Krzysztof

