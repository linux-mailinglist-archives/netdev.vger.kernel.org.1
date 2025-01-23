Return-Path: <netdev+bounces-160576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9BA1A59C
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7450165186
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735272101B5;
	Thu, 23 Jan 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ffZXEtj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4920F98A
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737641884; cv=none; b=t4FUCkIzLflkdy9qDU7J0NUsRxjb/W4ywqB/hddKDbAkDXRkYvK3qfiu7eFAdM/rkpyCE859AGN2jiYuwM0arsLwbC+4uvdxjpEGxJJ+N2MY7BBU6wX87vR1iSz+g6zthlNFeVNo5IeKUMi5ihPNjRIrenxD7JTJDpZwyPI0KwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737641884; c=relaxed/simple;
	bh=Gme88OIa9d0Zm1YT4RizarMW6jToxRUammK6/HTQlh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8OMw3Zm9Cnyr4iCSL/Q5/gY02s9DeN6Za7quavqxzDY4V8g4VQlw0w0ZFefq5PnqvOIowrSVUmbT9lK4Lqqq/Q8RxTQorae4KdmcYus9By7sRW66pJLrdt9Dj6zPUf0MhwC6GeVlgZDKsZ2RDxAZQDIQ4+nsqGFpMqhcWqxgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ffZXEtj8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862d161947so535877f8f.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 06:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737641880; x=1738246680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8mkGjg257bx62zgZ81/jO5L5DyJuTeIxv/nJ1/7iVk=;
        b=ffZXEtj8bvvuBzHuB+jfxJdrX2FI6bUys+AvyWV8sRsOnJNE1/amzEvrXBpusrGobm
         Kx8xDYKgjIy0dlTXbt7QHXYt3UHkhfxmEBzC0Bl2Ekd92Xom2wT+fpkPi9OPqveuAOMg
         l/N8KWgz7PbWNEgU2IZiLfo69+6VaR3B/Y6HwdCQ9YdcwPRtbF1KY66TIMr2n5hzOBcG
         EXCO2cZcJ9GglIVdM/hQuGgmS/W3f/Ms066aY99A1xfduAaacTF2WAL3v2a9UdlbeCFx
         7pqs0pQaCOu85IvmBuT/x1RehBPlyeHqYpt0IpKDruWiijPNRZ+L2rnZdbQaLByO9HMH
         it9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737641880; x=1738246680;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8mkGjg257bx62zgZ81/jO5L5DyJuTeIxv/nJ1/7iVk=;
        b=Nz9qYLUopF1jwY2k3UWMPuI1yUJ4LklNMgfsUJKAXCLpUTW21xjib5sfZZr1awC/x4
         33x69d/OwWndbvST92wsoqTsmYRSAoeZ9IJxKDq1/V+2miDmc08aq32r5+jDr9M2wvpw
         3EsbXLhoeh0LjXG8DIM1fsjNdcz1iOrgP4LnyZ0y1bGj5bd6zv/Q+fewWTqpURb4azZm
         crnPKbWA5erpQ+YtTWO2YCt2BV+9e+VAf9qFTCWayNfJGtt/ceLMGOIwtD7uup5myDed
         1pbiqPwVCZKTCj4IRmoe9Bg8rDOteAQ5cJYWCd+GJFEOxUkbe+h6qpY/d6UXpr9+jwqZ
         okBw==
X-Forwarded-Encrypted: i=1; AJvYcCXoyiFDP6rlz9Dv9+fVMG08D0C7eiJ61A6tlHVcw4dDG31wyl8z+goiuFIR9pvOby1RB2+hg9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9/lQF+ioBsxsstGkmT40a959e/dmt/h83I0JiqYAtDCW5F6Y
	tByZkQ4TG8/gqXrn3c26+xXcDfGv2iVqMjpyTGP6lws4+0OneBtNXAOpQEki52k=
X-Gm-Gg: ASbGncsRNKDsrMm+CYnC7nBfCO3Gf7++HhYT/0y01sSKSggKL5sAtxwxq78Zc69AA3C
	yaExweXGsYLaWlf8ASDOIkeZhNwuGla3sT0dEmuB1cdYq/CbxFXSRaa3lHDEEW35E6UbOWuYafE
	ZpSVK6485BOuTokQgWyiOc/5jRGRsS9KdD1Ca7q/amZDlOpuqVaF9VG1w0fiUYUZfD0VqurRpmv
	lEcOxsNKnT2ti66Q2Yttidu/gAZ83AjebjUgDxZ7i0tdtPR5W5Sp67460Mqzp86wJvnFBnrQ7/N
	5UlkaBn20PF9
X-Google-Smtp-Source: AGHT+IFtr57UosG2pGmiCVthkL+VSFTHskgbZcS4A6RQRj6ApFRIOhESzT0gUQDfT5RyorhUri1ywQ==
X-Received: by 2002:a05:6000:1bca:b0:386:4a0d:bb21 with SMTP id ffacd0b85a97d-38bf5663c0emr17993931f8f.22.1737641880264;
        Thu, 23 Jan 2025 06:18:00 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327e06asm19687029f8f.95.2025.01.23.06.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 06:17:59 -0800 (PST)
Message-ID: <cdf4e312-92bc-44f3-a049-bd3ddf3222e1@tuxon.dev>
Date: Thu, 23 Jan 2025 16:17:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ravb: Fix missing rtnl lock in suspend path
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122-fix_missing_rtnl_lock_phy_disconnect-v1-0-8cb9f6f88fd1@bootlin.com>
 <20250122-fix_missing_rtnl_lock_phy_disconnect-v1-1-8cb9f6f88fd1@bootlin.com>
 <806d2df6-68d3-4319-8ce6-7049563508cf@tuxon.dev>
 <20250123150814.6c46ec9a@kmaincent-XPS-13-7390>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250123150814.6c46ec9a@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.01.2025 16:08, Kory Maincent wrote:
> On Thu, 23 Jan 2025 13:33:30 +0200
> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> 
>> Hi, Kory,
>>
>> On 22.01.2025 18:19, Kory Maincent wrote:
>>> Fix the suspend path by ensuring the rtnl lock is held where required.
>>> Calls to ravb_open, ravb_close and wol operations must be performed under
>>> the rtnl lock to prevent conflicts with ongoing ndo operations.
> 
>>
>> I've test it. Looks good.
>>
>> Thank you for your patch. However, I think this could be simplified. The
>> locking scheme looks complicated to me. E.g., this one works too:
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c
>> b/drivers/net/ethernet/renesas/ravb_main.c
>> index bc395294a32d..cfe4f0f364f3 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -3217,10 +3217,16 @@ static int ravb_suspend(struct device *dev)
>>
>>         netif_device_detach(ndev);
>>
>> -       if (priv->wol_enabled)
>> -               return ravb_wol_setup(ndev);
>> +       if (priv->wol_enabled) {
>> +               rtnl_lock();
>> +               ret = ravb_wol_setup(ndev);
>> +               rtnl_unlock();
>> +               return ret;
>> +       }
> 
> What happen if wol_enabled flag changes it state between the rtnl_lock and the
> if condition? We will be in the wrong path.

wol_enabled flag can't change in this suspend phase. The user space tasks
are fronzen when ravb_suspend() is called.

Thank you,
Claudiu

> 
> Regards,


