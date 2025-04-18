Return-Path: <netdev+bounces-184268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A8A94043
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 01:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB641B671ED
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1822CBE3;
	Fri, 18 Apr 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9HJXDT3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71D43AA9
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745018397; cv=none; b=BfgsDJsqHXoTh8ezfRrKtIyV/CliJg5EF41VlN/lH9jfz2FAXRYLlbna4ioergNb5oo/eql+vV+Yn+zqjVx/xw23K5GLd5rEdaeXvCHjoWNN7pZwnIZ0kAJjMueWeiWfDF2TK5fIyotjZwHhKMi0D2ls47wNVEzvUrW8qjWyvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745018397; c=relaxed/simple;
	bh=T1DEiUDS8fNKbFRavZeescM7MP2qpDM2EhmJhdqVeXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIpv8ipdOxi8f5jLzUnMul5EQxaP2H262B126aTGHqDDN7x2u22uPRhFShjm9W9G5od7imQV6IIP5lBN1pKVm3e+eGn8y/S/jXO5POy78qoXpPFvIv81coYEANWyGJ2o1c1jaVqtcSEgMoi25kg9QA5dXMicpyRoWl5TTVgwhA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9HJXDT3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ede096d73so16513825e9.2
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745018394; x=1745623194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bjz9Sf4avKV/4VzyVIBKH2cIPHMvXcXBJh10uk8FwqU=;
        b=W9HJXDT3sDjRKGjHP3e71kTj8+Ox33vda3m0DmYr/TwQVnSh5h8f/x4odSHqqeig1t
         w96q2F3EUuAF9JSb2q3jj8w4asYkl+jgWL6PsrKzVfI/lEPewu5h9uMqZKvltsW8U7jJ
         WUqWN/xoITavyqhRJuFjPr0EQqTdCxWp/TxOY0I1TrPJrkIAgUF0r+rXpi5W4icVegXz
         NH2mqBHPh/k9IeBsqg2m8NGkXPCP1K2chneHZbxXHD9iE8jgH96A/KFFHbRMEFtafyRn
         c/QLb0dHmdbneL5l0XThxTspZM52HeId027rJplKfNUCFChzJW+EUebKo283F4bCDb8h
         JYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745018394; x=1745623194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjz9Sf4avKV/4VzyVIBKH2cIPHMvXcXBJh10uk8FwqU=;
        b=EDTk8olsm/ELStpFYEOW6AvxHNzmPfnLdBV9tM4JaBJBzPlA7Ei/koHR/NcBlZcRO/
         qJgzMQvUbqS1chVHIBmDiC8hzCqKesFL5Qdpl/8d6kDzpCtkXx7t/dX8lZagXpuIUYdb
         cx+elyVSoE3l8bq2X3Ef4SqlGvMHDpePKoQnH5j/QsNzru90WY7NKWjdNL2jCeSVoEj/
         P22fyMTlRKLwTDgDvecDvfOEeGxK/pSMkX5Wd2DrXogHvm5x1SrOATqV9h3xubCxtL0/
         R+HNrtj5/khHqBbf0205dZJjOFJsRg9TMD19VeKvQGlm5HUlYFZXKkWfbt8+52hLS+Ii
         vwdA==
X-Forwarded-Encrypted: i=1; AJvYcCUzng6XenukKzTT+bYWNnlOGnanR5VJvyPoQ6pmo9pt3wj6JrR15KDb4WGxvWRyDYKFuyvVEaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpVFAswSBKLVLklcadOAEFyHl0AhBOJym/XwBK7WLLuHAgCFd
	IMaO+26/JP1hjayEco7Y7A3wCxkeLa7lv0mwjyla3+XR77MnUy8I
X-Gm-Gg: ASbGnct9HBl4C1hXYFUrRGUusgJO+mxI1kaIqGQE9PAkoTxZVZAxJxT02Pbs/kSAyAY
	4aIen7XcAlXmR9AIy9m3HfbRhj28m4dGuIWtn+vl9jTGcuekpDNaTO/IQIjOEA+mxSKzv0Cup+p
	6EjvQ4HyVHcFp7pkd1eqfKD81UR25uiPd/eVpT6KlIHHxLGZLVD2Fsv9ZtUvGwNQVM4VgX1n6yJ
	gxL/lrlALrT8p9YtBGClLjRn9cRIri9OzZdiFX5tl5zGgEVlioc3caR5//Ne4IG3uv3l0Rgf0y9
	8jo7FTWVrJD3Sdw8KtfgyW4di2f87M8oC2UGdvV5DZ18
X-Google-Smtp-Source: AGHT+IFFktvXc2+kbuvOhvPPTtHbWAgBXTcsjlM29nv0sR9FQ9Z/WP5IaNhW/Iqg/IsQ5u1p5Z5VJQ==
X-Received: by 2002:a05:600c:4e0b:b0:43a:ed4d:716c with SMTP id 5b1f17b1804b1-4406ac0ef62mr31688355e9.22.1745018393934;
        Fri, 18 Apr 2025 16:19:53 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a517dsm3958224f8f.100.2025.04.18.16.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 16:19:53 -0700 (PDT)
Message-ID: <8dcfecf3-f9ce-402b-8589-c1c1c770990b@gmail.com>
Date: Sat, 19 Apr 2025 02:20:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] net: wwan: add NMEA port support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Slark Xiao <slark_xiao@163.com>, Muhammad Nuzaihan <zaihan@unrealasia.net>,
 Qiang Yu <quic_qianyu@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johan Hovold <johan@kernel.org>
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
 <20250408233118.21452-5-ryazanov.s.a@gmail.com>
 <CAFEp6-1tHbVgAG8LZHyzB=5c0n9D-F7d-VFe7K+LC5gYMq0Thw@mail.gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAFEp6-1tHbVgAG8LZHyzB=5c0n9D-F7d-VFe7K+LC5gYMq0Thw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.04.2025 23:04, Loic Poulain wrote:
> On Wed, Apr 9, 2025 at 1:31 AM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>> Many WWAN modems come with embedded GNSS receiver inside and have a
>> dedicated port to output geopositioning data. On the one hand, the
>> GNSS receiver has little in common with WWAN modem and just shares a
>> host interface and should be exported using the GNSS subsystem. On the
>> other hand, GNSS receiver is not automatically activated and needs a
>> generic WWAN control port (AT, MBIM, etc.) to be turned on. And a user
>> space software needs extra information to find the control port.
>>
>> Introduce the new type of WWAN port - NMEA. When driver asks to register
>> a NMEA port, the core allocates common parent WWAN device as usual, but
>> exports the NMEA port via the GNSS subsystem and acts as a proxy between
>> the device driver and the GNSS subsystem.
>>
>>  From the WWAN device driver perspective, a NMEA port is registered as a
>> regular WWAN port without any difference. And the driver interacts only
>> with the WWAN core. From the user space perspective, the NMEA port is a
>> GNSS device which parent can be used to enumerate and select the proper
>> control port for the GNSS receiver management.
>>
>> CC: Slark Xiao <slark_xiao@163.com>
>> CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
>> CC: Qiang Yu <quic_qianyu@quicinc.com>
>> CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> CC: Johan Hovold <johan@kernel.org>
>> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> ---
>>   drivers/net/wwan/Kconfig     |   1 +
>>   drivers/net/wwan/wwan_core.c | 157 ++++++++++++++++++++++++++++++++++-
>>   include/linux/wwan.h         |   2 +
>>   3 files changed, 156 insertions(+), 4 deletions(-)
>>
> [...]
>> +static void wwan_port_unregister_gnss(struct wwan_port *port)
>> +{
>> +       struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
>> +       struct gnss_device *gdev = port->gnss;
>> +
>> +       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&gdev->dev));
>> +
>> +       gnss_deregister_device(gdev);
>> +       gnss_put_device(gdev);
>> +
>> +       __wwan_port_destroy(port);
>> +}
>> +#else
>> +static inline int wwan_port_register_gnss(struct wwan_port *port)
>> +{
>> +       __wwan_port_destroy(port);
>> +       return -EOPNOTSUPP;
>> +}
> 
> I don't think the wwan core should return an error in case GNSS_CONFIG
> is not enabled, a wwan driver may consider aborting the full
> probing/registration if one of the port registrations is failing.
> Maybe we should silently ignore such ports, and/or simply print a
> warning.

Good point. We can end up with the case of driver aborting the whole 
registration.

On the other hand, a driver author is supposed to know that for the GNSS 
functionality the corresponding subsystem should be enabled. And either 
don't even try to register the GNSS (NMEA) port if the system is 
disabled or handle the error properly. See for example, the Intel's NIC 
driver, which skips an embedded GNSS receiver exporting if the GNSS 
subsystem is disabled. We can catch such issues on the review stage or 
treat like bug if something like this going to sneak into the code.

So here, the WWAN core does its best to kindly inform that functionality 
is not enabled. This is what many other components do, and I personally 
like this approach.

Is it any good justification to clearly indicate the error in case of 
GNSS subsystem is not enabled?

--
Sergey

