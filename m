Return-Path: <netdev+bounces-149355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9525F9E5360
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B40816589F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970651DF251;
	Thu,  5 Dec 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INEamduz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA71DD0E7
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396892; cv=none; b=lQZonfo5MGE9Z3/JIZryuYz47urV5Yi7c4Sn/E2p+ULAWswkDKPshpqztfCyBu2VTXh1Iy6irg2vYCA/qHmgHh39dgV2AnaOdphNy8VvMn6wJTf1Qx+KwlJSuYEoN+GEciZmOOeM1pkJoii6Q4bxRIgqv9FBptTad1lq4s1g1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396892; c=relaxed/simple;
	bh=7jzak9MvPN4qRr12LbNBymHBYJIoEDZYDF3D3T6/bmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bUF9mxMs4jrao2aGfkI5RQSwtlKLlysFb+4HTB4BtFXQP0ikuvucyaSuclSewyz4UBymepAGd0Gk05W2Rs8mbKjmnmWXGAbeMehKwPePF3AaSJjc4W/+Rjs4FOVrb0zhF/oQhSZiyzKYALlvGfhoAcs5MR66NjcvU3DXLwwy+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INEamduz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733396886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFy/Xqar4Obttki81CGZmOSw2PSTZcRsLCRsN1Srm5E=;
	b=INEamduzY8TwIaYn4q9d1+dhDu5jCYtEweYKZeAVWMbq/3Aj80MI9+P+Ny6llgBeVzUUMv
	oweXwRSh6L6tjJV1Y7ilIJsUxwugvCqqVrbqnLYXQGTPwrJeTbhj027mgbZ45n2Vgi2C2G
	FvZJLUHTzWTTiL23w6Amg9UqYrNrtno=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-vz285ntzMSi2fDoIPFdgnQ-1; Thu, 05 Dec 2024 06:08:05 -0500
X-MC-Unique: vz285ntzMSi2fDoIPFdgnQ-1
X-Mimecast-MFC-AGG-ID: vz285ntzMSi2fDoIPFdgnQ
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d88e7976e3so9690166d6.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 03:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733396885; x=1734001685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFy/Xqar4Obttki81CGZmOSw2PSTZcRsLCRsN1Srm5E=;
        b=MxCZqcpsIXzSliQY6ktpsJTNykMad+MySocOcm85KkeFKWOtma6b9NkEpj2TRqHzgq
         UXQsZe/S9R8uwYd5zLhzfyAGN7xS9cHCa26zB07bB9PBKBhSuRJF0rr8ASEf0YrdB2eu
         +gR4UQTiuMUT/PcgLV/z/qpM2Par8RikwkQxjYNXran8dxNQFbC8JRtQl/sE9XJ9CID3
         PXNiMoZcwkeWg2bxQtMn7slgHJScYFpe/F75vcU2NRHlh0XHImJWz0FBFiaCelXDvJCw
         VQsoWsJbNHep3dJp0sebcGpiMxNvoiUj7/aybNSA0biXAUK8yDAWQRGL0owQlE5JwavH
         7Hgw==
X-Forwarded-Encrypted: i=1; AJvYcCW/kpMQO3zP+MCX0/TIEH3AVmGF0+rhjJ3Hxfeqy7orwS7qAWDLIYwEXpvQArLCKemryyPKh+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNE80X7W5H0EhryVAlW5d1dI/CBVjvvmLFsRY6yaFA1scP2ri
	I6XgcfvrHL3I2ILghKhBIMXlX0YmcxR+5orNs9Oz9+ZiQLYaLfzHi78DJG1sm5pScpE3Q5C7DkJ
	c2UBVGarlRR2xchmwhJhPWy99mYxooSrQjNRZzUJzL+lv7K8AeDBb0w==
X-Gm-Gg: ASbGncuUjhcNv1EcFtKcmOxMYRz2d+OKQN7tKw0idSX7GlQKzPG0mVALSFsamL+YMBi
	h1m+KYakMntoadbdVh8n5oWJ7/gUg0PDdQCqCKyJ0pkoAI9Gx7SMkuXoV6JPE0cFHlxHGb9u0X3
	GPiuBxVySZHFH7jbVu8szwf1DWs8uLFlciyaK0NIOMgrAowxp62DJa33xYS4PXSN7GNJ4aRFIr3
	hjnmw0F6qvNB/niKTWEiPMyHCA/3dNHtj3v7P+nlSTE4C+nN82iVRgDYMTSmHKPeIVLt3Ebd8O+
X-Received: by 2002:a05:6214:1947:b0:6d8:b5b8:702e with SMTP id 6a1803df08f44-6d8b72ceee9mr172147146d6.9.1733396883491;
        Thu, 05 Dec 2024 03:08:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF73BYHYSSO/IIW6W6xOI+A4Bs70aSZyUGPnoMs7ygn24W9AhjOy1ah5mIdbyjBd56P+hybQ==
X-Received: by 2002:a05:6214:1947:b0:6d8:b5b8:702e with SMTP id 6a1803df08f44-6d8b72ceee9mr172146696d6.9.1733396883142;
        Thu, 05 Dec 2024 03:08:03 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da696452sm5392486d6.36.2024.12.05.03.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 03:08:02 -0800 (PST)
Message-ID: <946b59e0-18f9-4e4f-a3c9-3de432db4340@redhat.com>
Date: Thu, 5 Dec 2024 12:07:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
To: Divya.Koppera@microchip.com, andrew@lunn.ch, Arun.Ramadoss@microchip.com,
 UNGLinuxDriver@microchip.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-3-divya.koppera@microchip.com>
 <ec73fe36-978b-4e3a-a5de-5aafb54af9a8@redhat.com>
 <CO1PR11MB477140866E76B0FCEFA05735E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CO1PR11MB477140866E76B0FCEFA05735E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 12:00, Divya.Koppera@microchip.com wrote:
> From: Paolo Abeni <pabeni@redhat.com> Thursday, December 5, 2024 3:17 PM
>> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>;
>> andrew@lunn.ch; Arun Ramadoss - I17769
>> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
>> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
>> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> richardcochran@gmail.com; vadim.fedorenko@linux.dev
>> Subject: Re: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp library
>> for Microchip phys
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> On 12/3/24 09:52, Divya Koppera wrote:
>>> +struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev, u8
>> mmd,
>>> +                                   u16 clk_base_addr, u16
>>> +port_base_addr) {
>>> +     struct mchp_ptp_clock *clock;
>>> +     int rc;
>>> +
>>> +     clock = devm_kzalloc(&phydev->mdio.dev, sizeof(*clock), GFP_KERNEL);
>>> +     if (!clock)
>>> +             return ERR_PTR(-ENOMEM);
>>> +
>>> +     clock->port_base_addr   = port_base_addr;
>>> +     clock->clk_base_addr    = clk_base_addr;
>>> +     clock->mmd              = mmd;
>>> +
>>> +     /* Register PTP clock */
>>> +     clock->caps.owner          = THIS_MODULE;
>>> +     snprintf(clock->caps.name, 30, "%s", phydev->drv->name);
>>> +     clock->caps.max_adj        = MCHP_PTP_MAX_ADJ;
>>> +     clock->caps.n_ext_ts       = 0;
>>> +     clock->caps.pps            = 0;
>>> +     clock->caps.adjfine        = mchp_ptp_ltc_adjfine;
>>> +     clock->caps.adjtime        = mchp_ptp_ltc_adjtime;
>>> +     clock->caps.gettime64      = mchp_ptp_ltc_gettime64;
>>> +     clock->caps.settime64      = mchp_ptp_ltc_settime64;
>>> +     clock->ptp_clock = ptp_clock_register(&clock->caps,
>>> +                                           &phydev->mdio.dev);
>>> +     if (IS_ERR(clock->ptp_clock))
>>> +             return ERR_PTR(-EINVAL);
>>> +
>>> +     /* Initialize the SW */
>>> +     skb_queue_head_init(&clock->tx_queue);
>>> +     skb_queue_head_init(&clock->rx_queue);
>>> +     INIT_LIST_HEAD(&clock->rx_ts_list);
>>> +     spin_lock_init(&clock->rx_ts_lock);
>>> +     mutex_init(&clock->ptp_lock);
>>
>> The s/w initialization is completed after successfully registering the new ptp
>> clock, is that safe? It looks like it may race with ptp callbacks.
> 
> If I understand your comment correctly ptp_lock in the clock instance is not initialized before registering the clock.
> Rest of the initializations are related to packet processing and also depends on phydev->default_timestamp and mii_ts instance only after which packets will be forwarded to phy.
> As we are also re-initializing the clock ptp4l/application need to restart.
> 
> Initializing ptp_lock before registering the clock should be safe from ptp point of view. 
> 
> Let me know your opinion?

I guess moving the lock initialization before the registration should be
safe.

Please not that the main issue open is WRT code reuse: I second Andrew
opinion about the need of consolidating the microchip ptp drivers
implementation. A library should be able to abstract above individual
device differences.

Thanks,

Paolo


