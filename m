Return-Path: <netdev+bounces-161518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD9FA21F4A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDEC3A1D98
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F182195980;
	Wed, 29 Jan 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="p8H1Xh27"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FC1474A7
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161369; cv=none; b=U2sDQ1ol43Wa083k1VR/EoJidDyeI5EwnF2C7aQeyYyUTaIIWwzs7UOgrUOL4pMsOTkHWZ95uAshedcOjDGUKfhAo91LZq2MfiI1/RAawmbgcXqdFft0Ac/qkDqrYCk/deimSwrDsZv9ZmJQR79SbWA8zMDr95ddyeIMx2bR54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161369; c=relaxed/simple;
	bh=UI7BF2vJZTjlFV2hITe8WmVRApBVcG3adoozoekMENs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzQfj1F3G+7NZ4z15XCNnZctt9n/XcEetuDQk8iHqtfOrvNy06M/YxPtjyNvdPzlYYyo3Wx9il0orC3l+vOspkFNuYbGEobP5JVbAzApHakbGsm+ErlOJpCojf2YoIQlbrWSP4Q83hKlyj6sLdsX5/cmiknRsiJQeIhT4b/ypWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=p8H1Xh27; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab69bba49e2so583300066b.2
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 06:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1738161364; x=1738766164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dREqLTaUkaXBI3BB09CWv/OKA4VNGyMw6wQOmVv2X1c=;
        b=p8H1Xh27ZMWNJzJO5Z9e2FPl/Q18txTQeEXLFeTYojb2iqDIowzNF3uudsAU/GFKxV
         nYmRofo9BhiHdSu8tZu4IdJPBjQt1/+tmh5KWp7/MdSZXtq55xX/WLsz9qe7SzXF4sVl
         rV7IPex3SW5RtY+Skk66ozPXXGuJTr6EqvqxHZxt6drMW7V+yu1iLZvXTih4Bx7l7ry7
         ro2GJ7SuJRWm9Wfd063nIhTUEsad3NIsnPGNgb8d7WA2eLSsOaVLcsz4HAf71oDP7yc7
         iHENb5Rs0p6MMuHDtuOqpHKyY5s595S8D2QQEgsEKAnk++L83d9vN92E+PUonBpR6H4O
         09Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738161364; x=1738766164;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dREqLTaUkaXBI3BB09CWv/OKA4VNGyMw6wQOmVv2X1c=;
        b=We5rmwK7NsCL16+kRnaglEX8LzLtwvn0hYsdjvEvIVB5+NQvc9fKPXwyBzK742HwCf
         VoJJiSiPX0Zb1CU0FqR59ZyD66rxMzJW4CL3moHBJTNs8TdzvcMekWpJWv8Vgky0viKw
         bEQuZAX7ew6CnQmvxKFrcrhAHdkm7pDsaRYF9X8MgglBZNpP6OZ1gihRJw/ay0drM8YN
         Pw0eHDs2gFasXQDjN528WgNHN+Nn49sZfRJwKUtMaGbbg5Eh3Q5r6ot5HdoWT0Unf5J+
         fZ91QQkO7xINtPAjL68wLfB2KcCmiI6LbVpTgy6iVzPjOCrTlXexGrZpfk2xoT0UBHbI
         tVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwxnspZ4xyOs50szu56yaQcIEtCA6EiSmR+a9VL+X5TcL79OXZ+GFOfFN6yx+YqRpe8eMIM3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGPGNfCIh20AqzM3nAGluoKYmUiozFM5lviMXJLlAF/Amyy6s
	WfGbaTPu6keTpgBgNQi7B32H/h0dVKcoBP81FpHSkxPXyVF6un6HQ96trxARqRs=
X-Gm-Gg: ASbGncv6xZO24zzAg4+jb5ZjfEhIa+f2nLUI4mz4TGeqV+zN+zrU5ZbzmihtaJ/swZy
	/GPidDqI958Nvcpz/wk+XJsqX7GyDPrqlpAN5hqHvJh7pap7Sk3sDtLI3EEaagozu6nzPhatWvv
	9uyKv+IeChRUNYS87aHFztZ9YruYiJBKoe4wk/4erTJIAXnKuoYUzeNPkxvTk8EIkq0jYfboNRl
	QHf88rUPlm+Xbh0vdWDTJMvGLsiyFVhMpG2ehy1WE8Bt5uRHgZVc5jE5GYqQ+iGDy/64xu1tS0N
	uDUb8BjkwQaOUf6qGYeBXpc=
X-Google-Smtp-Source: AGHT+IGLJBQE8tLxWwgvNgTFG/uBHrI5LPO+emzCOIWKd77Tbc+R5gOQ15j5uC93XR7lao+lO2hpTQ==
X-Received: by 2002:a05:6402:34c8:b0:5d9:84ee:ff31 with SMTP id 4fb4d7f45d1cf-5dc5efa8c21mr8157746a12.3.1738161364504;
        Wed, 29 Jan 2025 06:36:04 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69a26dc94sm664205966b.166.2025.01.29.06.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 06:36:03 -0800 (PST)
Message-ID: <eb131a53-a4d3-4dcf-9e04-8dc3da84c3a6@tuxon.dev>
Date: Wed, 29 Jan 2025 16:36:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: ravb: Fix missing rtnl lock in suspend
 path
To: Kory Maincent <kory.maincent@bootlin.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20250123-fix_missing_rtnl_lock_phy_disconnect-v2-0-e6206f5508ba@bootlin.com>
 <20250123-fix_missing_rtnl_lock_phy_disconnect-v2-1-e6206f5508ba@bootlin.com>
 <e39ac785-9d4e-43d1-9961-d6d67570ff49@bp.renesas.com>
 <20250123183358.502e8032@kmaincent-XPS-13-7390>
 <20250127112850.05d7769b@kmaincent-XPS-13-7390>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250127112850.05d7769b@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27.01.2025 12:28, Kory Maincent wrote:
> On Thu, 23 Jan 2025 18:33:58 +0100
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>  
>>>>  
>>>> @@ -3247,7 +3253,9 @@ static int ravb_resume(struct device *dev)
>>>>  
>>>>  	/* If WoL is enabled restore the interface. */
>>>>  	if (priv->wol_enabled) {
>>>> +		rtnl_lock();
>>>>  		ret = ravb_wol_restore(ndev);
>>>> +		rtnl_unlock();
>>>>  		if (ret)
>>>>  			return ret;
>>>>  	} else {
>>>> @@ -3257,7 +3265,9 @@ static int ravb_resume(struct device *dev)
>>>>  	}
>>>>  
>>>>  	/* Reopening the interface will restore the device to the working
>>>> state. */
>>>> +	rtnl_lock();
>>>>  	ret = ravb_open(ndev);
>>>> +	rtnl_unlock();
>>>>  	if (ret < 0)
>>>>  		goto out_rpm_put;
>>
>>> I don't like the multiple lock/unlock calls in each function. I think v1
>>> was better, where we take the lock once in each function and then unlock
>>> when it is no longer needed or when we're about to return.
>>
>> You will need to achieve a consensus on it with Claudiu. His point of view has
>> that the locking scheme looks complicated.
>>
>> On my side I don't have really an opinion, maybe a small preference for v1
>> which is protecting wol_enabled flag even if it is not needed.
> 
> Claudiu any remarks?

Sorry for the delay. I still consider it safe as proposed (taking the lock
around the individual functions) due to the above reasons:

1/ in ravb_suspend():
- the execution just returns after ravb_wol_setup()
- there is no need to lock around runtime PM function
  (pm_runtime_force_suspend()) as the execution through it reach this
  driver only though the driver specific runtime PM function which is a nop
  (and FMPOV it should be removed)

2/ in ravb_resume():
- locking only around ravb_wol_restore() and ravb_open() mimics what is
  done when the interface is open/closed through user space; in that
  scenario the ravb_close()/ravb_open() are called with rtnl_lock() held
  through devinet_ioctl()
- and for the above mentioned reason there is no need to lock around
  pm_runtime_force_resume()

Please follow the approach preferred by the maintainers.

Thank you,
Claudiu

> If not I will come back to the first version as asked by Paul who is the
> Maintainer of the ravb driver.
> 
> Sergey have asked to remove the duplicate of the if condition.
> Paul is this ok for you?
> 
> @@ -3245,19 +3250,21 @@ static int ravb_resume(struct device *dev)
>         if (!netif_running(ndev))
>                 return 0;
>  
> +       rtnl_lock();
>         /* If WoL is enabled restore the interface. */
> -       if (priv->wol_enabled) {
> +       if (priv->wol_enabled)
>                 ret = ravb_wol_restore(ndev);
> -               if (ret)
> -                       return ret;
> -       } else {
> +       else
>                 ret = pm_runtime_force_resume(dev);
> -               if (ret)
> -                       return ret;
> +
> +       if (ret) {
> +               rtnl_unlock();
> +               return ret;
>         }
>  
>         /* Reopening the interface will restore the device to the working
> state. */
>         ret = ravb_open(ndev);
> +       rtnl_unlock();
>         if (ret < 0)
>                 goto out_rpm_put;
> 
> 
> Note: Sergey, I have received your mail as spam. 
> 
> Regards,


