Return-Path: <netdev+bounces-196689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F1AD5EDE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77613A9DA3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2911E51EC;
	Wed, 11 Jun 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkBvjPn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA41198A1A;
	Wed, 11 Jun 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669398; cv=none; b=PCq1DMJd5PbstwPty6vO21i4XQrnbBDsvbAaIccAgPfP8sJ9s4wOLhe/j+NK5JB98qOxJJctbUMC1Krflz48KJ9UyFjrkk0u0u3yKHE8eEffmM3Mjem1eFwu6IQ1n3k40q+09l8jqV3jMNK6GwhV1VPK1NORP6tGg4Xaz2M+hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669398; c=relaxed/simple;
	bh=358NUKtMN4W7Wp9Bs1V/sn98LAqFcku5eccdeJV4uBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sxr5xw1KsL2hkFFCDJymQunbbLTebWU3biLKK+BuDOqVjQNZbe5rnEBg3wwf8zJQkNZ5KGPtSezEUFfnb9UcnMxSW9zwSSfQlaOugk8c8pi0KOCxhwpgGmAFKWdkdMjlozVc5sFPrvfYQfF2qC4oMv1ScFXn8aARzeoOxnWwEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkBvjPn1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so1401215e9.2;
        Wed, 11 Jun 2025 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749669394; x=1750274194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9/kIfdniyUa+utFuJ2JYd4o20expQw7bHU8xr65qBkM=;
        b=IkBvjPn1GIm2nNz37zOqACc7F9QH5eiWgtQQh0RkXscyYU4nqyW5onVmMKiwY4810W
         FfKyU7OwFmE/GEVhTRhmpisWPh5CH5bi8SDtYSp9lPhzdWArVOyYC6n4Pp146O8OeiAa
         ZOHgmHLS0SuA8n1JUl8+O6ja4gWtSy10n9DK8qugGiM5VLrC51c36+8kVUbDX5VtXxZJ
         /1Ve4BjPupkvZ2e5BDxpvVKfu+UcdG20FplGZTRd3OdatizexPcuUBupnOAN2+gCPoc7
         JhzmrdC5EaKjYfFsrbk2ulRGQZeTew/bnCl8wL0I8QhX2mrgwDZcayuuz3L7VKYg4CL5
         nsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749669394; x=1750274194;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/kIfdniyUa+utFuJ2JYd4o20expQw7bHU8xr65qBkM=;
        b=ZFPLbZFuIV3ps2xfyF6ltLw4Y8IjxHLVaWg0C079EZ6aE0r0cA4lM3BjJyJDrTB35t
         npNM9Pq0gayaQ0LKQ+dizWS0B/j5VNsiKBuiZwvfKcfib3ZSgGUSOCKdzEWNe4LD3KNl
         XSFkgnPgenKH9aYXoPBwdw7OIJSQwU8J8lqu52mm26Xe2/VZsrICPu/zYx/0kAJYGiNf
         LYDHovtzo4WrSjIZCRX8xMq34LoktDuafFklOKJemg9umpXkB3oTM8ABWz+FFv1y6yp8
         YWeXti3P8DMK3Kyz970rl/kE5clriIta3auE3krCZS78hvIInUfI2yOVdB3z2CghjAO1
         55+A==
X-Forwarded-Encrypted: i=1; AJvYcCU3GdNImRkvZyMLBSZ7Vl6IXkBGc8kCpOGMGCI9LGjqh7kJLLB7oqyXi5lvooQcYSW/ltzmk5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkfbKIqD8g9a1ekU/DPAcnQQu/mTrQnYMNm0dEu4Rf8gDAvOY
	uqj79nqpCb85bx0pYSpY6t/VDFJzp1sqMIxTV+sCErYtCxN9rXK8uMlC
X-Gm-Gg: ASbGncu3dvPexERLi7Vrsl8d3gtMyS+MDpAnRw7tQfYHmI90Z5+YRb3mGin6mcCJdjD
	Y/FAtzPxjKBeav7o8kGBBcFeZUA2igkdNjSpk5DBN7AYgNdd4/7uh+7k0iFA6Q0y9V1jmXbQsu+
	WxC78NF9TsrdzT6m1z5h8Cxg3UMXNI9pT3DYSLIBQL/Gw4FpKt4dnRwTqEXwUPCLHIi3Wlog4T+
	TDlpBvB/GfNvPkiICMHsrH81YTBNJ5nJNC/lejPjgYKp9NodTJGgwCx19s3X/7EeSZAePvQZ9nh
	/DrzHiTDmEvptBHBfdZGVYDwhSndoRABwU+Zc22fUKwuEhJILoQuXicJBpGG/nWsObstF5450cp
	DaODQQ8RXb526VVW6T+cQNgZ8iMwALDdbKhu+cXRzxB2qawz87vD2avqpKCtvwD9B+JXaOIc3Vb
	yvCP1QY/rBgo5zApv2+Q16KheGjQ==
X-Google-Smtp-Source: AGHT+IFz1DBINgpCFr/2Gx965i6I9Wyiocv1WZccwFZVJk3cQt99+Dx0h87QP3USUCk11ij2IOoFHQ==
X-Received: by 2002:a05:600c:3f09:b0:442:e0e0:250 with SMTP id 5b1f17b1804b1-4532d31d85dmr1325015e9.29.1749669393296;
        Wed, 11 Jun 2025 12:16:33 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1d:5400:69f2:2062:82e9:fc02? (p200300ea8f1d540069f2206282e9fc02.dip0.t-ipconnect.de. [2003:ea:8f1d:5400:69f2:2062:82e9:fc02])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45325141606sm30843635e9.1.2025.06.11.12.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 12:16:32 -0700 (PDT)
Message-ID: <be4598a3-7880-4efc-a1c7-d5093f4c9eaf@gmail.com>
Date: Wed, 11 Jun 2025 21:16:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: usb: lan78xx: make struct fphy_status
 static const
To: Thangaraj.S@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 Rengarajan.S@microchip.com, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, UNGLinuxDriver@microchip.com
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org
References: <0890f92e-a03d-4aa7-8bc8-94123d253f22@gmail.com>
 <58e97a033835bc9347e24ff50aea26275054e9b2.camel@microchip.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <58e97a033835bc9347e24ff50aea26275054e9b2.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.06.2025 09:02, Thangaraj.S@microchip.com wrote:
> Hi Heiner,
> Thanks for the patch
> On Tue, 2025-06-10 at 22:58 +0200, Heiner Kallweit wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> Constify variable fphy_status and make it static.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> v2:
>> - extend commit message
>> ---
>>  drivers/net/usb/lan78xx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
>> index 759dab980..17c23eada 100644
>> --- a/drivers/net/usb/lan78xx.c
>> +++ b/drivers/net/usb/lan78xx.c
>> @@ -2630,7 +2630,7 @@ static int lan78xx_configure_flowcontrol(struct
>> lan78xx_net *dev,
>>   */
>>  static struct phy_device *lan78xx_register_fixed_phy(struct
>> lan78xx_net *dev)
>>  {
>> -       struct fixed_phy_status fphy_status = {
>> +       static const struct fixed_phy_status fphy_status = {
>>                 .link = 1,
>>                 .speed = SPEED_1000,
>>                 .duplex = DUPLEX_FULL,
>> --
>> 2.49.0
>>
> 
> This patch changes fphy_status to static const, but as far as I can tell,the function is only called once during probe, and the struct is
> initialized and used immediately. Since it's not reused and doesn't
> need to persist beyond the function call, I don't see a clear reason
> for making it static const. Is there a specific motivation behind this
> change?
> 
From a compiler perspective there's not much of a difference, also as of today
the compiler uses a pre-filled struct instead of creating it dynamically.
At least that's the case for me with gcc 15.1.1. Just that with the change
the prefilled struct is properly placed in the rodata segment.

Main reason is to make clear to the reader, and to the compiler, that this
is immutable configuration data. Not different from e.g. regmap users, where
typically a static const struct regmap_config is used for initialization.

> Thanks,
> Thangaraj Samynathan

Heiner

