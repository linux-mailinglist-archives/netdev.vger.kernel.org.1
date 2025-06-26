Return-Path: <netdev+bounces-201533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905F3AE9CE9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CC6188AE8D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE308F5E;
	Thu, 26 Jun 2025 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp5476xJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC368BEC
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750938939; cv=none; b=YAxhhyb2iwMJXoRBo8b1u2/mcRv8OktCpe8WseFGBWrh4d6ExWV+OGD7Zw/n4TC3pePhAC6RsG9zeVgXt5YS8funvmzMEeVKDVki53+N3P3uJF2SLEpGOVhB7TPTjMt4JJ6pPd6bZ5wklRS0x9bRm5sAAdaOBpaVm27ycZth+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750938939; c=relaxed/simple;
	bh=xHwHeiompaVMD6+jxIUEO2dIC3M5Odo1OeshqZJnwxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brtsttVg0XQbBYfkDmyZJ0vG2MZ2QCwDOmRQAge/+bqIbL4H/qiAE++Ac5pRySwe+dp0c+MIHINBWbWQrCgnJCXQ1iP0rPNoyIoJ1TwT/hihPRFnJsscUeb09F5zFPEpynNpmN5gdnhnOC1yD4nwddoilBiarFrWioieJ1kUEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp5476xJ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d3f1bd7121so84308185a.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750938936; x=1751543736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rxtz5aSjSJEDpVCbavnskh4RW/2vImQic7qw9+s0Q80=;
        b=Vp5476xJu/bgg1ZV4rWWSi1PR0S4AbW702r7hksbw3G82XdBewSwRZFs73dXVqlSDW
         +EanHIOth60ub7EGPbsvPCCfYomwbnksPsXyXmIr7lFudGauyd+U/XpkjCZ204N9ERg/
         W59HvpWnPumM+UvZ/0lKKG59ANIeP+OGgI24nolfAKl6L6rrJ7NNVP20IKt5CBW71aD6
         f67Bps6YQaCQePQHAGoSlSxoDd7osmDzRMPUA6ZVD2/Ue0bW75TqEs61KAkl4LByeKyE
         gMWHM9jjMlGKGRNPkZ3bz8XVGUhfy2IJJQ+hnv4Y0L4hieUMFWosJGie1bSqPnnJG2TY
         cQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750938936; x=1751543736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rxtz5aSjSJEDpVCbavnskh4RW/2vImQic7qw9+s0Q80=;
        b=RRUnwqmkPXh50JRdpiB0IFOokpw9BHyu3Bw+IUeqCFcW3l6nI3PpVLmmwwo8Ebzicj
         6Ba/5qjGHOVNzFYuYG/T72bWFVkPoqLcax71BoR/IRQCEg4/QUtcxbT9t8LslotzzCJ2
         ncIPHbYdOJAUSkydJdxXLHhOPNWn339FApVa+7fimlWYGqVon/UuxQrsgtHwjwBSKUcD
         XkT8uqdzZOZZw6rEpPAd/0k6xbwE6285ZGWBLrPcxBpmbstiNKIpaaA9MZwuhnZ97p8f
         IwIMgY8Th7eTOT0MYNFplD/EqDklhUyhtzxuUds+78u0qs1kNqWTSZ2G1m2gY4QkWySJ
         vTTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD8oo7bifWewDE4yxlFVXaocJL26LEYHuEa2GtXH9mRHydi/cegk5ud3iqfgBUCENdaeJErcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyblyiWNP+NvJh+grxBEqnpxhVl8LP6czv6i2cVmTWolvtyfoq
	V2Y8BY1/JfQ+z6CBd/udBTnXXoqlONzoUkWLJn9L/0obldX3fJ1I97Cg
X-Gm-Gg: ASbGnctLblkl71mVa9vjHllw7Zsn2m4TDQutZ95a/mMOBXn2w1U9V9FJ+boxagYFFU1
	/bmn9C2puVvEbNavb1eUrbPu8aGIEoCLanSX1jJpepGPyRWh/6DPEqLW4g3nAYiIGDoHPO9u4zL
	Kz8C0xhBBWHGubyX1/YPUX8hg0G/qE2K1JVCrOzLMPqm86QwiFZii9alNaG4MidxpKigec5uGw3
	vR2EgTR9ClF7tKY/AuOJY34oyswQEPMN5pJpGeT6NMqAjWgY4DKhpdmzYsAfw4hT4Hb+8jUxX0R
	p7DaL+QQy/qO+WXb50hIUNOOYAkapmujhNVJxny/w2/KDsYeZBkZmNpOEIY0Ia9i0NltxX/yqCw
	GAPjlvb7w1yHtfYJ3N//r1OeBGdu2oCHZTnQ1e6B7
X-Google-Smtp-Source: AGHT+IFllUwkrLbvGLdHk6j4sIMWaBe5RUg6/u1Yognw/KF4ElNG2hZJLwaJfZlQdBY/MiFk8I4U7A==
X-Received: by 2002:a05:620a:a518:b0:7d4:3af3:8ef9 with SMTP id af79cd13be357-7d43af393a9mr465402285a.19.1750938936360;
        Thu, 26 Jun 2025 04:55:36 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d4e97csm69867341cf.3.2025.06.26.04.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 04:55:35 -0700 (PDT)
Message-ID: <edaa7ae7-87f3-4566-b196-49c3ec97ed7d@gmail.com>
Date: Thu, 26 Jun 2025 07:55:34 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] psp: add documentation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-2-daniel.zahka@gmail.com>
 <685c89596e525_2a5da429467@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <685c89596e525_2a5da429467@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/25 7:42 PM, Willem de Bruijn wrote:
> Daniel Zahka wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> Add documentation of things which belong in the docs rather
>> than commit messages.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>> +Driver notes
>> +------------
>> +
>> +Drivers are expected to start with no PSP enabled (``psp-versions-ena``
>> +in ``dev-get`` set to ``0``) whenever possible. The user space should
>> +not depend on this behavior, as future extension may necessitate creation
>> +of devices with PSP already enabled, nonetheless drivers should not enable
>> +PSP by default. Enabling PSP should be the responsibility of the system
>> +component which also takes care of key rotation.
>> +
>> +Note that ``psp-versions-ena`` is expected to be used only for enabling
>> +receive processing. The device is not expected to reject transmit requests
> This means skb encryption for already established connections only,
> right? Establishing tx offload will be rejected for new connections.

As it is now, psp-versions-ena is only used to affect the device 
configuration. So, the code for handling sockets i.e. 
psp_nl_rx_assoc_doit() / psp_nl_tx_assoc_doit() does not include a check 
against anything controlled by this setting. We only have a check 
against psp_dev->caps->versions, which is fixed after psp_dev_create(). 
Perhaps that would make sense though.

>> +after ``psp-versions-ena`` has been disabled. User may also disable
>> +``psp-versions-ena`` while there are active associations, which will
>> +break all PSP Rx processing.
>> +
>> +Drivers are expected to ensure that device key is usable upon init
>> +(working keys can be allocated), and that no duplicate keys may be generated
>> +(reuse of SPI without key rotation). Drivers may achieve this by rotating
>> +keys twice before registering the PSP device.
> Since the device returns a { session_key, spi } pair, risk of reuse
> is purely in firmware. I don't follow the need for the extra double
> rotation.
>

Indeed that last sentence is superfluous. Re-initializing a device 
shouldn't leave a device key from a previous initialization, while 
resetting the spi space. If something like that were possible, it should 
probably be obvious to the driver writer to do something like double 
rotate the keys.

