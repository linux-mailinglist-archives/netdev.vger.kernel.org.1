Return-Path: <netdev+bounces-118698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC3952823
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138D4284E1E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F0125DB;
	Thu, 15 Aug 2024 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7ob0/1l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA49C144
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691292; cv=none; b=RXb2gBOZPDMAC3Bg1Gm61CDs0HXmp2h29tPI92ZvSkD0rHgHmCHk3+get3xHMPJGJaLmzmocIqmFbyyxQR3cwpMdvwFvwwkDbyLC0G6Lzy0pQg02yR+moDI/vBgKF111LcU9VkRUrotFLQdR9k8GT8h4KZL32/3VHxgfw1lV/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691292; c=relaxed/simple;
	bh=3ozHmNdkZ2v8N6eG7o/Nxn+3HM0pFkyZxobj9G/AcmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hrbbcbu6PI5eI7DnDyAIL9eP1oTCaKYN4SFkSuVfsT7Ce8L9aB+D/KFH5Kr6xtvSU4J4ajZW1km/zLsR6F0RtxCkl2KcRz4fjjPzIpVeshuhPzPZndDSDfoQ1mYjuTtP5wtL5ZSXBjXGTs8rvEumMwmNuFjVKNcGzMUe3WsZlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7ob0/1l; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45007373217so14331891cf.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723691290; x=1724296090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HzWdHMoVQ+eRDULBpieL6S1q66BjR4OCEOqwKxTirkg=;
        b=F7ob0/1lTWsGW8gDEvSSzL4Dn/EKh80bjS6wZ+lPmqb2ck2HeYioksnarP4RK7ACJr
         5SXxfnfF9wGmluP+46Gt+KgLX2I1uwrmc3gf6f+7bLEc+1PFEaLtC1mAXR7/A3hjkrtO
         VlbmwNKSjoLKznckopFGKr2nGKhuN+iPVh7/sMiBURPxDZpiBmGkDQRN+VJ9t86IB1o5
         IgT+Ec1R3JOKnGAoRufOphYBLwjkcdqTnIgWjIGr2winkgcQD/BDH4j+cCd2RGEnXcA0
         YXmXIJa+Q7CayLcz038SrqhXPatySXDp2ZC6mlP5c22zH/lT6gXtzEMy+ea6wUi3bUZ0
         K9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723691290; x=1724296090;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzWdHMoVQ+eRDULBpieL6S1q66BjR4OCEOqwKxTirkg=;
        b=YXruvl8ffuiYEQxx7butO94DSzFMGomHsAYrP2fWoph6mh33RoHUzHin6JHQM+pK8O
         C9r3yI8Zeo1zUvrJba/5xx+AeYuL8shD/xPfS264L2OAn8cR7NlRXmyLBRumOXGQfG/w
         OF7mcCxJLSbd3YJizsmINJ2KqSZphDPHIv0fcOVc6XOYjTyuSjDgTbdPRoHKDM5QAz11
         ECqxBB7+hOXE0itT4ChLfsfdngMN8QiFIqfGH+nt3EQUkhEWtQ4v+LGOaDPGpTPBmHQh
         4n85AfQBQb51MzkntVKjSXJN9g/5VIJquJZxFvdwgu6zsOdcS9V7yL8Se9tc1PnwlLI4
         Qb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe0KmcFLl8ztnEvaY3zfjMM9av6fT/j4w3uB/TN2nTKRrfxXG67OCX4RmChjx36j51ovTD687n8BMpR1sNHG9pUmfacsoN
X-Gm-Message-State: AOJu0Yz95QMyQteigRrvd0y8wTkMiJDILJR4WdZ3GslW1CSg3Iq85kga
	QY60cq9jEt108lLu6YGhoYgMCcRyEPELAOyry0/eoXzRUnucmlaM
X-Google-Smtp-Source: AGHT+IFwJXHzWNlWIfyHuhGljHVYHKvpNYVw1ejdExI9Gp7rP9EXubZ9S6P40zEi0RFwttv0apvY+A==
X-Received: by 2002:ac8:5e13:0:b0:44f:eff9:d35 with SMTP id d75a77b69052e-4536784f750mr31675371cf.8.1723691289600;
        Wed, 14 Aug 2024 20:08:09 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a007515sm2766791cf.48.2024.08.14.20.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 20:08:08 -0700 (PDT)
Message-ID: <b46f8151-29ab-453c-9830-884adcecdcfb@gmail.com>
Date: Wed, 14 Aug 2024 20:08:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: add tunable api to disable various
 firmware offloads
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Doug Berger <opendmb@gmail.com>,
 Justin Chen <justin.chen@broadcom.com>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
 Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Yuyang Huang <yuyanghuang@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20240813223325.3522113-1-maze@google.com>
 <20240814173248.685681d7@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240814173248.685681d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

CC Doug, Justin,

On 8/14/2024 5:32 PM, Jakub Kicinski wrote:
> On Tue, 13 Aug 2024 15:33:25 -0700 Maciej Żenczykowski wrote:
>> In order to save power (battery), most network hardware
>> designed for low power environments (ie. battery powered
>> devices) supports varying types of hardware/firmware offload
>> (filtering and/or generating replies) of incoming packets.
>>
>> The goal being to prevent device wakeups caused by ingress 'spam'.
>>
>> This is particularly true for wifi (especially phones/tablets),
>> but isn't actually wifi specific.  It can also be implemented
>> in wired nics (TV) or usb ethernet dongles.
>>
>> For examples TVs require this to keep power consumption
>> under (the EU mandated) 2 Watts while idle (display off),
>> while still being discoverable on the network.
> 
> Sounds sane, adding Florian, he mentioned MDNS at last netconf.

Yes this looks fine to me:

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

> Tho, wasn't there supposed to be a more granular API in Android
> to control such protocol offloads?

I still am unable to find a public link for the 
com.google.tv.mdnsoffload package that describes how we can offload mDNS 
records in ATV, but that was what I mentioned during netconf that we 
needed to program into the hardware. Ideally using an ethtool API TBD, 
or a cfg80211 one, rather than some custom ioctls() and what not.

> 
> You gotta find an upstream driver which implements this for us to merge.
> If Florian doesn't have any quick uses -- I think Intel ethernet drivers
> have private flags for enabling/disabling an LLDP agent. That could be
> another way..

Currently we have both bcmgenet and bcmasp support the WAKE_FILTER 
Wake-on-LAN specifier. Our configuration is typically done in user-space 
for mDNS with something like:

ethtool -N eth0 flow-type ether dst 33:33:00:00:00:fb action 
0xfffffffffffffffe user-def 0x320000 m 0xffffffffff000fff
ethtool -N eth0 flow-type ether dst 01:00:5e:00:00:fb action 
0xfffffffffffffffe user-def 0x1e0000 m 0xffffffffff000fff
ethtool -s eth0 wol f

I would offer that we wire up the tunable into bcmgenet and bcmasp and 
we'd make sure on our side that the respective firmware implementations 
behave accordingly, but the respective firmware implementations 
currently look at whether any network filter have been programmed into 
the hardware, and if so, they are using those for offload. So we do not 
really need the tunable in a way, but if we were to add it, then we 
would need to find a way to tell the firmware not to use the network 
filters. We liked our design because there is no kernel <=> firmware 
communication.

Hummm
-- 
Florian


