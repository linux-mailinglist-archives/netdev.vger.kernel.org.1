Return-Path: <netdev+bounces-139085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 755529B018A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1651C2177A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB332003BC;
	Fri, 25 Oct 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWLGquna"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8741D63D9
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856693; cv=none; b=kE8YDxF6vrmCp56ij0SEWrAcg0qGwom70w+pCIf1cNWp51ukTHXixyG8sSfHjFxM/mSHOHhxnK9SJsXnvlExGr4jNZwebbUuEkII2vQ0YT4DsOcLOcZ6ahnWc6A3zFcaJ8tcmvyd2M5Qu3RaF24sP86OyQqS8tn87IWDGvQiFlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856693; c=relaxed/simple;
	bh=srgs50XnqZYWWUNRfL26dBWpda4HZdTN4BLsbObLcX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gke37WXXPqrWHgYtMNZBVsRAFoInP9bmpTfXuMKJ4rXbx0WXEDWhgtq0hyYhKmAF22GZtyc43QnaSaY5nHXVcJPoOS/zNhVPcvnNsBeoZ0WsFHPzSekyto529og+8sHzBXcVCIFLJwNinu3+FsQwvo+zKhKhopWCyprykH59wrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWLGquna; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so2135384a12.2
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729856690; x=1730461490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1WUJzfvBrno81gBu1O0r584+CRLMwbBR7QqJCfZBJm8=;
        b=OWLGqunaAHizR9e+iUEsDtotdps8xgu+2zLOpA4qrtYgmWFILj2NpTm9pBCg20bB5J
         QLfASAnJCYXO9w1AAeZ8h5/hdqH5VyoNhKoTtTYc8vZas7U31KsbaaLPCS6YiGUBdeqE
         dmePJw4or/FAwHhMpVusbVJvS+RpjsznQ70qaS3dQlrtHm1sKVEAFmLCnGF/OR/kUGqO
         ru+SpXUGuPgWVKajZfDDJ1b2gzUKeywBtE0fwg1yFjDKwo5r9BJrb5QQp7zyed2Cordm
         eFI6evUWx6ylDZY56/BZ77ogmgvAZEOyECumedsr8YXxB7O6v2I/BuakI364+2XRmpQb
         vwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729856690; x=1730461490;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WUJzfvBrno81gBu1O0r584+CRLMwbBR7QqJCfZBJm8=;
        b=riNBB3/K4o80L2oHphjcxc4RYEe4q62pl52hIzH0tVKXv8rmhM7JyMwjdYBGGtY/bX
         h1/1y/AynsFFnYLfA/+PcJLgS8jALr5eKfoOUk/T/p20ISF0RU7wD6dZuW4QInhpIgtQ
         Zx8Tt0eYlgQSQt5/gc3/b8MzI7RbJ1eT1GZ6rXJU5MfFdFrFsFdSfDYoLkk5mAwEU7ir
         i6J6TMUl3Dp5xk620uq0T7phOtXWg2LXGNjADIp8y5ULTXf62lUF5hXPMSGuVHoIwXDS
         a7ptaO4L6BWlbd7KKSupFpStGZvQI73x7H2q5bmmBsdDMPeEF2y8xAwOau6ZIxN2DJcV
         Od1g==
X-Forwarded-Encrypted: i=1; AJvYcCUxiXC3BJ0Pw0Bbg2Pe11ZJlsNzix9tgCgzCGyBijZ0o0qil112+5TfcSVWYHB0Tf98CwzlW5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmqu10fQgTss29KIEsY4whGV/ANgUUYzqKb6I9z5CoDTznxknD
	P3xZt4UfuqkNOFVpAeiV90zq07vzoCtpdF1MrgtUiL3rUvGcZNxc
X-Google-Smtp-Source: AGHT+IHsDqQbZXxZTwKfNZ0bHe1TO6kbV+eZDO9JqbwNtGjgOeUGZqqNy8VWvMcHEhsyhtyp6pEIPQ==
X-Received: by 2002:a05:6402:34d3:b0:5c9:3026:cf85 with SMTP id 4fb4d7f45d1cf-5cba2492e8emr5412704a12.22.1729856689914;
        Fri, 25 Oct 2024 04:44:49 -0700 (PDT)
Received: from ?IPV6:2a02:3100:ae16:8800:adb6:8043:f935:3540? (dynamic-2a02-3100-ae16-8800-adb6-8043-f935-3540.310.pool.telefonica.de. [2a02:3100:ae16:8800:adb6:8043:f935:3540])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6349806sm538476a12.95.2024.10.25.04.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 04:44:49 -0700 (PDT)
Message-ID: <9fece96e-9a38-4b97-93d9-885a5d8800cc@gmail.com>
Date: Fri, 25 Oct 2024 13:44:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: add support for RTL8125D
To: Simon Horman <horms@kernel.org>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d0306912-e88e-4c25-8b5d-545ae8834c0c@gmail.com>
 <20241025112523.GO1202098@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241025112523.GO1202098@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.10.2024 13:25, Simon Horman wrote:
> On Thu, Oct 24, 2024 at 10:42:33PM +0200, Heiner Kallweit wrote:
>> This adds support for new chip version RTL8125D, which can be found on
>> boards like Gigabyte X870E AORUS ELITE WIFI7. Firmware rtl8125d-1.fw
>> for this chip version is available in linux-firmware already.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> 
> ...
> 
>> @@ -3872,6 +3873,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
>>  	rtl_hw_start_8125_common(tp);
>>  }
>>  
>> +static void rtl_hw_start_8125d(struct rtl8169_private *tp)
>> +{
>> +	rtl_set_def_aspm_entry_latency(tp);
>> +	rtl_hw_start_8125_common(tp);
>> +}
>> +
>>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
> 
> Maybe as a follow-up, rtl_hw_start_8125d and rtl_hw_start_8126a could
> be consolidated. They seem to be the same.
> 
Thanks for the review. Yes, for now they are the same. Both chip versions are new
and once there are enough users, I wouldn't be surprised if we need version-specific
tweaks to work around compatibility issues on certain systems.
Therefore the separate versions for the time being.

> ...


