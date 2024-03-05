Return-Path: <netdev+bounces-77568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5631C872323
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B961F22453
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B03127B53;
	Tue,  5 Mar 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LIEtn7ag"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63258662F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653848; cv=none; b=sM8ktBLFQQzjl6+1TUtWe8vJx++1kUO7AC8m0d4A/CXuQ5RfO6UQcMxMYJz+eSOUmqbtQWbr2oUuj7wtrwt9gCg9LAQCTpUTuSe5rCEwHb3dg2lv7gFvV1NNwn3H1odQi5lFTnfU9eeaYOXNlhnS8WiOJahVkt7EFG7kmCcY6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653848; c=relaxed/simple;
	bh=K91CF7B/TKu8Molwd47KN5MBBcZGC1kvBX1pBajt8sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBEg7uss2pqX+5WPDvcIHwRjI2A9WKVUDbwbm41vqytRPVVOE4qbmohuq8VmJNPN0Xfhs6U5WHMJWxc/VykA0ncq6pFtDL9Y5y6OGnM54bL5PF32ucxo7PSub77XFHq2xt/+VEhi8TH4IXxjw+X8rhh3LUDFbdUZ+hmWXkSWxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LIEtn7ag; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so982158866b.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 07:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709653845; x=1710258645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MB+bcF2mMsm2aSAUvXr3mBornRh+OQP43iYFdjMppqs=;
        b=LIEtn7ag+etayUwDcwoOT1cQlLzyGRDgr5F0iwq1FInqxAKAyFQmw7WdjcyimIsbwt
         G7un17Q2L5gy4X6vHMTzZfUoVINhLvrwpbOpiH/JFtFrxg9p6fgx47zcL3oBtcmqA+75
         FmoCDYHvfIVch7RtRyngYdQyLjTh9uAsewRMd0lsMZQV4tq2tYAcyn8gAt14Vg9vEh8h
         cFijcU1tBD3Aa74GSHUvzaxL7fkg9NeL8avJMpd+GJmhVHs0pY8sX4vMU2lm3aSKqCiO
         Pm+MYRYY5J4bz7mZ5/48SCMnvT7+Xzhbbyy18OQcsXy02IrEUUwzKsRJY7+UsbpP7d10
         wCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653845; x=1710258645;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB+bcF2mMsm2aSAUvXr3mBornRh+OQP43iYFdjMppqs=;
        b=ecwLZXpeVLuTWd8MruN4wkz5VH60LH9XaHu5HlmugxBGaDoEaVt+H5/g0xRCLG2CZT
         PxNR+z8lnFoqIz73Q4sCcyFchMXb51T9Z44XcclmqVVv5DBSAtMe2Wuttdurie8wPM+j
         7V8NncX2Nvv63ntgFRp2ESkDnRBucwBNtoF0UKUVLqETcIOZQP8Cs+7wbnyaHOUOKEP0
         asPxw9j4JGtxFOsrQ5/nirb2JfPWUvi1/+/j/fom1papU4Nc9oN0rpTul5FrhceFQCTT
         Uiyy0U8eiKTRLHlrlkFTLOG1Hz9l8JsFxMj1BycNS6CqD0D5laRk4bTEjUAJ0t5ktS9J
         WOFw==
X-Gm-Message-State: AOJu0YwdQtfiD8p4mL631hBqQW3xhefkHPT7El/FxaG3F4UcPN7Az06V
	yqLAr1UssFoyLRCe2Ud/uuHHM4Wd/+OCneGpW3Yi/6+zJxF3c8jygiHXJSngb80=
X-Google-Smtp-Source: AGHT+IErfmaFoRqt1WMUk/ZO6baJr5V+8DLVxJMvjnA4NgozhAagzBrmit/l+JJf5xgYfWKgTJ7Vwg==
X-Received: by 2002:a17:906:558:b0:a45:ae87:ec09 with SMTP id k24-20020a170906055800b00a45ae87ec09mr837293eja.60.1709653844929;
        Tue, 05 Mar 2024 07:50:44 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:f33:beb3:62e8:b7a? ([2001:67c:2fbc:0:f33:beb3:62e8:b7a])
        by smtp.gmail.com with ESMTPSA id ld1-20020a170906f94100b00a451e507cfcsm3001138ejb.52.2024.03.05.07.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 07:50:42 -0800 (PST)
Message-ID: <48188b78-9238-44cc-ab2f-efdddad90066@openvpn.net>
Date: Tue, 5 Mar 2024 16:51:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/22] ovpn: add basic interface
 creation/destruction/management routines
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-5-antonio@openvpn.net>
 <e89be898-bcbd-41f9-aaae-037e6f88069e@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <e89be898-bcbd-41f9-aaae-037e6f88069e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/03/2024 22:33, Andrew Lunn wrote:
>> +int ovpn_struct_init(struct net_device *dev)
>> +{
>> +	struct ovpn_struct *ovpn = netdev_priv(dev);
>> +	int err;
>> +
>> +	memset(ovpn, 0, sizeof(*ovpn));
> 
> Probably not required. When a netdev is created, it should of zeroed
> the priv.

ACK. There is a kvzalloc() involved.

> 
>> +int ovpn_iface_create(const char *name, enum ovpn_mode mode, struct net *net)
>> +{
>> +	struct net_device *dev;
>> +	struct ovpn_struct *ovpn;
>> +	int ret;
>> +
>> +	dev = alloc_netdev(sizeof(struct ovpn_struct), name, NET_NAME_USER, ovpn_setup);
>> +
>> +	dev_net_set(dev, net);
>> +
>> +	ret = ovpn_struct_init(dev);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	ovpn = netdev_priv(dev);
>> +	ovpn->mode = mode;
>> +
>> +	rtnl_lock();
>> +
>> +	ret = register_netdevice(dev);
>> +	if (ret < 0) {
>> +		netdev_dbg(dev, "cannot register interface %s: %d\n", dev->name, ret);
>> +		rtnl_unlock();
>> +		goto err;
>> +	}
>> +	rtnl_unlock();
>> +
>> +	return ret;
>> +
>> +err:
>> +	free_netdev(dev);
>> +	return ret;
>> +}
>> +
>> +void ovpn_iface_destruct(struct ovpn_struct *ovpn, bool unregister_netdev)
>> +{
>> +	ASSERT_RTNL();
>> +
>> +	netif_carrier_off(ovpn->dev);
> 
> You often see virtual devices turn their carrier off in there
> probe/create function, because it is unclear what state it is in after
> register_netdevice().

Are you suggesting to turn it off both here and in the create function?
Or should I remove the invocation above?

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

