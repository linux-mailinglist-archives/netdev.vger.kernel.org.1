Return-Path: <netdev+bounces-106760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD089178DF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E59C1F22493
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DC514C599;
	Wed, 26 Jun 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="R1VLxiey"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809913CFBC
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383110; cv=none; b=sWSwXCWnCDQler2829XqNxQIdw9AUJleopRnrUm7SQXCk6FNDkjgCoPjFLS90RcaGdkwoU3Y93CO/16fEYfU9/Gap2d4WOrAr1KsvDado0e/Qwidhf82E2Mg4S4hj9qbbNC3MrMe2LoFD2c73VshYxHGy848fl/JJf9q57LIOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383110; c=relaxed/simple;
	bh=y4GbLs9aDPGiypoZkBEyIwfTONHvGzJHq+C1CD9uq5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwMO90jyXSMvVU1Dx490qlMXyZRy6+JwhTIk5dn4ySKyuLBukOMaoolBs8PXaBZenuTgcPB+DARZiqTLeJRdNDID0Yhuariz+baQzT5Mf3O6DnFYJo50A6JKSjQzKTwk2DpGi/Gnj1BZKekjWCIzk2uh55m6CeBQDCO1PS55BwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=R1VLxiey; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so7024180a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719383107; x=1719987907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NneCkWcihB4SDc8i2s2Dweg0OO9fVfkDf5nD4K2ZOqk=;
        b=R1VLxieypuagKVqaJAsVkXj7bfro5rw2Qg8pc7lUZmInYVb/sBUaLBFgg/FEwx/Cty
         JAijx1AATdHvm+r8NlDneTrBulQM9tM5gVy8kGCVEfdlg4DAOz+mYqnpErKDm8r3MMpJ
         Kdts3YPbi6y41xtJ/F3i+aQjx77tNIg5jAg3E9YYerutUb/r66Igt7lmf0YkE++uzGhF
         yXSNE1sgeETN/qdMIGL3pHPcw+CBB8gVRyAJ9CbPkMxKDGgbQMcQe8uHSdoGP8pzZr09
         nBVRVmjwdR1Rdez6/904AzYj7UZMXuEUwVDUg5+/Vg9CEhPknmzpUzG38Hh0St0L3t0y
         5/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719383107; x=1719987907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NneCkWcihB4SDc8i2s2Dweg0OO9fVfkDf5nD4K2ZOqk=;
        b=av1L1TUBpw6vutgMPzIOwEPdo9CFfQGUj5JebXtb25dI+n9E9+ETbSXnxpzEQIDB/E
         uI2Rh44NP1Zxqs80FhwPmCJ0tt/s9j/GItFnvzILGCiVEgv+x5lEmaTXShADMpjcUais
         ZRVR02DMQTh3wM5+IMMd41yEDVbISXa91owdJXokE2I+CJC78QMPXEdIEMJH2XuSsi5d
         6IwpIvpv0ZJt+mnhR4Ud+PWoPU6jo52YMSeaFF/aeANqHLwk9crcS8NEq1JoaAyU/u2s
         07Mzm2L9JbdOQfDu/13HYGCIfThBryxAlzhrX9zgghpIaiIdwgiw9DqnWT33EYL05KRQ
         i2Sg==
X-Gm-Message-State: AOJu0YzKsEqpfGdWoyLYBIe3n5giFyBl/uejBbduRbLh8MgwS0o/vHlW
	IpWefvZfH+IjlEqxpcFXuLLUPvJiAT6V1DEATxpM625NlbyiBEbAJQ4JmiCB/sk=
X-Google-Smtp-Source: AGHT+IHNVVoFIwFamSGcmeT1TIo8K6K/3la88igLd4GfeXJzHY0MDxn3hMYCFYexEyiqqYvPDNLXCA==
X-Received: by 2002:a17:906:fcb0:b0:a6e:ffa2:3cce with SMTP id a640c23a62f3a-a7245b851aemr572667866b.41.1719383107043;
        Tue, 25 Jun 2024 23:25:07 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7261c5bc2asm195243366b.186.2024.06.25.23.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:25:06 -0700 (PDT)
Message-ID: <cda45c6a-7bc1-4c71-8352-e9147b81f41b@blackwall.org>
Date: Wed, 26 Jun 2024 09:25:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240625070057.2004129-1-liuhangbin@gmail.com>
 <13131adc-1e61-46ae-a48e-ab2b51037a98@blackwall.org>
 <ZntyFd3M9OXm_nqr@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZntyFd3M9OXm_nqr@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2024 04:42, Hangbin Liu wrote:
> On Tue, Jun 25, 2024 at 10:11:53AM +0300, Nikolay Aleksandrov wrote:
>> On 25/06/2024 10:00, Hangbin Liu wrote:
>>> Currently, administrators need to retrieve LACP mux state changes from
>>> the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
>>> this process, let's send the ifinfo notification whenever the mux state
>>> changes. This will enable users to directly access and monitor this
>>> information using the ip monitor command.
>>>
>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>> ---
>>> v2: don't use call_netdevice_notifiers as it will case sleeping in atomic
>>>     context (Nikolay Aleksandrov)
>>> ---
>>>  drivers/net/bonding/bond_3ad.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
>>> index c6807e473ab7..7a7224bf1894 100644
>>> --- a/drivers/net/bonding/bond_3ad.c
>>> +++ b/drivers/net/bonding/bond_3ad.c
>>> @@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>>>  		default:
>>>  			break;
>>>  		}
>>> +
>>> +		rtmsg_ifinfo(RTM_NEWLINK, port->slave->dev, 0, GFP_KERNEL, 0, NULL);
>>>  	}
>>>  }
>>>  
>>
>> GFP_KERNEL still allows to sleep, this is where I meant use GFP_ATOMIC if
>> under the locks in my previous comment.
> 
> Oh, damn! I absolutely agree with you. I did read your last comment and I plan
> to use GFP_ATOMIC. I modified my first version of the patch (that use
> rtmsg_ifinfo directly, which use GFP_KERNEL) but forgot to commit the changes...
> 
> Sorry for the low level mistake...
> 
>> Also how does an administrator undestand that the mux state changed by
>> using the above msg? Could you show the iproute2 part and how it looks for
>> anyone monitoring?
> 
> Do you mean to add the log in the patch description or you want to see it?
> It looks like the following:
> 
> 7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     veth
>     bond_slave state BACKUP mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 143 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,expired> ad_partner_oper_port_state 55 ad_partner_oper_port_state_str <active,short_timeout,aggregating,collecting,distributing> ...
> 7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     veth
>     bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 79 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,defaulted> ad_partner_oper_port_state 1 ad_partner_oper_port_state_str <active> ...
> 7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UP group default
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     veth
>     bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor_oper_port_state 63 ad_actor_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ad_partner_oper_port_state 63 ad_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,collecting,distributing> ...
> 
> You can see the actor and partner port state changes.
> 
> Thanks
> Hangbin

Yeah, I just wanted to see how it looks. Feel free to add it to the commit
description but I'm good either way. :)

Cheers,
 Nik


