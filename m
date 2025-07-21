Return-Path: <netdev+bounces-208619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D7B0C5D9
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F5D16F266
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1EF2DA77F;
	Mon, 21 Jul 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z5K6lEMl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A616E2DAFA1
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106967; cv=none; b=QR7uSiKGzXsuM/m1Qk7Cl3zPE1L1rUa1raaMRtenHd8isI06hW9Uv1STWTTW67rkkCsGKJtQMRwmhNknU3Pr3MJ32EloZvvYC6UFRTYWwiaZ/DCItcdKdAFyVhasknftQE5Lzy8iYbvJfLrQGMHyJdfhuzxvhWjcgO/+1CW42u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106967; c=relaxed/simple;
	bh=++Ox7gKvHdwky39WdQJFmk0HB160GJNorAa3/n8tZP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHuEKip5q7gwpVJ73Cw/o8NfGU/4dG83NvGi8wWkPhvlKOtQpw0a4cD4DpF7yAkl3U+lGqQ1xliS3c3M8UAUk9XwFQXg4QPReoyyL7mlcaydw4LqJq/M8Fr1BJnJWlpgL3igLzydrPCBe754BRwhuPr8fF0B1J2NUg8LAxIhjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z5K6lEMl; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73e82d2ec52so429585a34.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753106964; x=1753711764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LnLWJUsAr+JAkpxUkcXadAzf96B3tnYqEVcIVAbTvg=;
        b=z5K6lEMl8JmkEUT/7Ok1G0iQxZb6TAGi9hc3Gt48hT/ZgTT3YKcTBUai8YkopcbpvF
         mxwi6k1EJkqez7O7uD4BgGZ7bNeUo3YQOtlDZryCx1vrQgytASP0vndrc4qV+EzSgYVa
         q85iw736SXmkEWipZjlY8XWTfXrmuGuCOpxPP+WXzKV/gm2Z1ebR6O8cr4VwacvuBUHR
         HozkpzdGWoDNtbon+i2/X23UkBHg4DyGoWViVKDFhDjmsK82gsrHWVa+WCK9xAG7J+my
         xwz+Kn1/h20pFzhx08zQ77QjYGLqFopn4maqP15AGb+y+zHxZmskqM/RbJdyWSlx9YZv
         51TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106964; x=1753711764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LnLWJUsAr+JAkpxUkcXadAzf96B3tnYqEVcIVAbTvg=;
        b=InfksNzzMYwiWUr6LQc8WLFBC1Q3Ws0ENEJEIcHIaCUHg3pvvd6TJ30zm2K/pYcosd
         LjUALvylbCjk3OLJkApFyzVhsc2PTQaUCeL5a6CcX0K/OnyCY+H7agHgZem5IACm/FPe
         TR8vEvroZqLa7Z7OrhnngeVnzWrHWMRGAR+/Obu5d6MMpqqnZtF6hc2kh693bz8tFHBw
         3/FRAoX9kjgSOa0oYo3jlbRxglZA6jcBhXQNK3m4/gllACSojgIpZ/i5lqDrwh2CfWpk
         +9UGxaxqITzhdlFgh0FIFZEm0FETIf8nosJc5eBJmsKeTKkBIvRubhc1khEqaGOFlU+Y
         xAqA==
X-Forwarded-Encrypted: i=1; AJvYcCWW0pmDPNLOa89fzkzFyVVBzbimVY+V8UW8NfcUsGeBc6eIbI+FvSoCefcovF6J9gIz22JOCXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsNs4OyYYDyqmByiTJ9Kvb5fduRmsJ23xyCivNZ+j8Xnbgkd/
	MOq3DPl4MFaoFyrOGVzEKYEbyqfkLfUQDMfPYAqfM9cNrmKcj043dRZDL2o7vHlPfTA=
X-Gm-Gg: ASbGncvgHE/QAX8BKyYvkG7EmDI4adNPshCfL5dIf92mkV+obnTT/86cifjOTLKgFrZ
	EQi4EGvYLDc14GzGELrBxR9hl4vtVtyH8P7VasEeEkRRdGRQkfafoeo8oEkZ4cAxYvWQbwhyG4w
	v7Ad6obPonkdsinv4tQW966KgyN0ty1WVCB21noedVyTc6SrI/13UUjW3oCcFzSmPCSLzhpAh+x
	NBauC1Hq1ZWgWEC4lC/36MhYe+hK6GFXNbF7wBMmvx3YR7Y68zaQwkZjog+jLp8O8F8TyoQV8/n
	b2A4JDJ1E8rokmH1LyN2L0MU8oBDQ+lY4Yv0kWC8jZ+oaRe/S5tAcSkEe/F/FmPqaF1f53TAHCI
	2xEo9h4QnpE/2A7iwGzBZQhoGVZzEs7dAyuxUTPdSTXRClnBG092WMRenPqbpsPaQDGP764OESI
	A=
X-Google-Smtp-Source: AGHT+IEYJ69qw8hWrbyhfCDdoYCGwahdtxo+pfFxwMph5mSmiJShT9DMVnokAtIY6hWFVoiT1iMVrw==
X-Received: by 2002:a05:6830:3e8b:b0:735:af51:5ea5 with SMTP id 46e09a7af769-73e665b9181mr11113510a34.22.1753106963677;
        Mon, 21 Jul 2025 07:09:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb? ([2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83bf667fsm2820418a34.65.2025.07.21.07.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:09:23 -0700 (PDT)
Message-ID: <35eba285-2c49-49ac-9da2-29636e257196@baylibre.com>
Date: Mon, 21 Jul 2025 09:09:22 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Sanjay Suthar <sanjaysuthar661996@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 ribalda@kernel.org, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
References: <CADU64hCr7mshqfBRE2Wp8zf4BHBdJoLLH=VJt2MrHeR+zHOV4w@mail.gmail.com>
 <20250720182627.39384-1-sanjaysuthar661996@gmail.com>
 <84ad0f66-311e-4560-870d-851852c6f902@baylibre.com>
 <9574826f-3023-4fe1-9346-eacd70990d73@kernel.org>
 <CADU64hDZeyaCpHXBmSG1rtHjpxmjejT7asK9oGBUMF55eYeh4w@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CADU64hDZeyaCpHXBmSG1rtHjpxmjejT7asK9oGBUMF55eYeh4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 5:15 AM, Sanjay Suthar wrote:
> On Mon, Jul 21, 2025 at 12:22 PM Krzysztof Kozlowski <krzk@kernel.org <mailto:krzk@kernel.org>> wrote:
>>
>> On 20/07/2025 21:30, David Lechner wrote:
>> >>    - Ricardo Ribalda Delgado <ricardo@ribalda.com <mailto:ricardo@ribalda.com>>
>> >> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> >> index 0cd78d71768c..5c91716d1f21 100644
>> >> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> >> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> >> @@ -149,7 +149,7 @@ properties:
>> >>        - description:
>> >>            The first register range should be the one of the DWMAC controller
>> >>        - description:
>> >> -          The second range is is for the Amlogic specific configuration
>> >> +          The second range is for the Amlogic specific configuration
>> >>            (for example the PRG_ETHERNET register range on Meson8b and newer)
>> >>
>> >>    interrupts:
>> >
>> > I would be tempted to split this into two patches. It's a bit odd to have
>>
>>
>> No, it's a churn to split this into more than one patch.
>>
> 
> Thanks for the reply. Since there are suggestions on patch split as it is touching different subsystems, still not clear if I should split the patch or single patch is fine. I would appreciate if you can guide on the next steps to be taken
> 
> Best Regards,
> Sanjay Suthar

Krzysztof is one of the devicetree maintainers and I am not, so you
should do what Krzysztof says - leave it as one patch. :-)

