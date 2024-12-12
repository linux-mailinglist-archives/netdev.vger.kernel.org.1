Return-Path: <netdev+bounces-151334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3D89EE353
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FD728278E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C977920FAB1;
	Thu, 12 Dec 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="r4EAFHGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534420E011
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996601; cv=none; b=RZiHNuPx3AKZCkuJ/Ho1YDML3uIZiqKo3t1LreIGF/Dm7VtbZa380Zqjr8fGcOrGCS/bU1lqA2mMiHbfghiomRtCzfhc0ItbQJgjwURdE5Ov2SomRwCSl7zVS+vZPVH7uT/SZuZEuGu6doGx7AZjRrozPTLVHUUfRCyTIbfKgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996601; c=relaxed/simple;
	bh=wlI6Vx9AQIzBF2jM0KW8GGqD5QzMTunPSWLwPFJk11I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo7qc1bqjq97q/5CcvB5rC9eQd++Paipm+gi5KQaoqTNRAM3/fxaDE8xAIabWjCA9VAw/sTsF4rEHa6NrrWAwsCNzrzpkk3SeK/V13DKMVKuJ0pRXtUMC+z2fH0y/kvI6ILs7PwJjGEbYFPAnS0nyxRJ/sgvfL18fL6GtYDX2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=r4EAFHGO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa67333f7d2so54338066b.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733996597; x=1734601397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyR2MXiFEoU2H13Rzo6SI2LM94SiVSjauzhtJPn93dI=;
        b=r4EAFHGOWIqHWNWF2CNx59wjBRx3cDKe0Qf1EXCQqnaFZGWdnFp7iISWFlcOXHJnfs
         R5MGHzA8/MxRSJEEASfmx+1aiwCUSwNxhW+zJIRmuQtojOlpF70zqTYjkzED6i6xJUkD
         sqflOHv5Ays4K4PsrVBfQWBKNtGROaSMyJqPy3fUMXAx3q8OhMcIfXjXg+PTVX4vW9Aa
         zem5lxdlaRJJp3/nDfe4wmRe6PDY1IGU0b1TQmQpeMyY8XHDNCcBWjtTmrrWyTuQVAJq
         /wEBTSOvUyjIjxejf9xONNxvNFTt7LR1m+UQV2KD7itl0qJssw83L/J+9Oadk2hTKjgQ
         tnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996597; x=1734601397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyR2MXiFEoU2H13Rzo6SI2LM94SiVSjauzhtJPn93dI=;
        b=QB4CcOzZ1Mg66CD7wETmnLZnmtG+sp6qvMtATzJBnQoJzyDAjEZ5TxTRQDX5HZETo2
         Pvi1G+WAR4n9hEVk1K66SvZ4I/WIwSpFdjxnOlTzAZXnPbAIXtKjcVBceN126O02lGjx
         0kNDchLeMweQwzUT1IS3ptxIZ9lu+GwJzgQ6cRKzASPd3pKLQJ8kR4uhjfiY3rzDm9xy
         7lvbdIwPEhG0+5HQZRxaSY6Ur/XXPCtoMvHvkpQ94YNgrgjAmzrFQD4KuuA56UeG6BBv
         DG9sW5Ybtjnlo7opRLYVLusd52xbbNy4doJTCfL8hfGnYum0ZEZk2AMSTOUXyqDQ4NjA
         WxQA==
X-Gm-Message-State: AOJu0YxWwjKjY9p3KFBXMVXoJZiD40BzW1fNUyt/fzQzkSNn4+0PtsF0
	68XOcsks0NFLq2C3R3bRASFJk+SYSFlKmWRhdrLJkqZwIbwGVCfmWWFkVLO4eXw=
X-Gm-Gg: ASbGncvtRskv8Nj0BGCbnj63BEFyXFDhiHQblbCe/I7XJdjq+cIkSOBWrGGX5nzW6Vc
	pXeU9sImDLqXVI4AFubQpHBraGWbrC1UXZgHslji7D66VKlhHLE+sV70hg9EBCCXECFPOXPR4Ez
	rPd4HNhulHjk+DTyM8KIfd4yaWOOuhBissNIdg+Ba+InbePJBnTsO/o/EOxDSuJ7l/cwh4E6gds
	FIypd8CQB8xUSkn/N8elWqQEQN8/LTB6TA+bHjE28la6LW0891ibAl8UBc=
X-Google-Smtp-Source: AGHT+IH4QMf5pvin6wVJSMpuuwVLXt6LuvTJ0Y3P9wBPqNEQoBBct151LQDukhxHB9I5tAqRnBsVXw==
X-Received: by 2002:a17:906:32d9:b0:aa6:19c9:ad08 with SMTP id a640c23a62f3a-aa6b13977bcmr641736766b.48.1733996597171;
        Thu, 12 Dec 2024 01:43:17 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a394d380sm358006366b.77.2024.12.12.01.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:43:16 -0800 (PST)
Message-ID: <d5606430-16cf-4a2b-ac29-88b73b4ef284@blackwall.org>
Date: Thu, 12 Dec 2024 11:43:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] bonding: fix xfrm offload feature setup on
 active-backup mode
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241211071127.38452-2-liuhangbin@gmail.com>
 <032ea83b-0df0-4c88-b0d1-153d9c1bf865@blackwall.org>
 <Z1qvb7Nz7zAv0L1w@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z1qvb7Nz7zAv0L1w@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 11:39, Hangbin Liu wrote:
> On Thu, Dec 12, 2024 at 11:19:33AM +0200, Nikolay Aleksandrov wrote:
>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>> index 49dd4fe195e5..7daeab67e7b5 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -4389,7 +4389,7 @@ void bond_work_init_all(struct bonding *bond)
>>>  	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
>>>  }
>>>  
>>> -static void bond_work_cancel_all(struct bonding *bond)
>>> +void bond_work_cancel_all(struct bonding *bond)
>>>  {
>>>  	cancel_delayed_work_sync(&bond->mii_work);
>>>  	cancel_delayed_work_sync(&bond->arp_work);
>>> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
>>> index 2a6a424806aa..7fe8c62366eb 100644
>>> --- a/drivers/net/bonding/bond_netlink.c
>>> +++ b/drivers/net/bonding/bond_netlink.c
>>> @@ -568,18 +568,21 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
>>>  			struct nlattr *tb[], struct nlattr *data[],
>>>  			struct netlink_ext_ack *extack)
>>>  {
>>> +	struct bonding *bond = netdev_priv(bond_dev);
>>>  	int err;
>>>  
>>> -	err = bond_changelink(bond_dev, tb, data, extack);
>>> -	if (err < 0)
>>> +	err = register_netdevice(bond_dev);
>>> +	if (err)
>>>  		return err;
>>>  
>>> -	err = register_netdevice(bond_dev);
>>> -	if (!err) {
>>> -		struct bonding *bond = netdev_priv(bond_dev);
>>> +	netif_carrier_off(bond_dev);
>>> +	bond_work_init_all(bond);
>>>  
>>> -		netif_carrier_off(bond_dev);
>>> -		bond_work_init_all(bond);
>>> +	err = bond_changelink(bond_dev, tb, data, extack);
>>> +	if (err) {
>>> +		bond_work_cancel_all(bond);
>>> +		netif_carrier_on(bond_dev);
>>
>> The patch looks good, but I'm curious why the carrier on here?
> 
> The current code set netif_carrier_off(bond_dev) after register_netdevice()
> success, So I make it on if register failed.
> 
> Thanks
> hangbin

I don't like adding code just for symmetry alone, I think you should drop it
unless there is an actual reason to turn carrier on.

>>
>>> +		unregister_netdevice(bond_dev);
>>>  	}
>>>  
>>>  	return err;


