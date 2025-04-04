Return-Path: <netdev+bounces-179338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE91A7C080
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A563BB3ED
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93BF1F4CBE;
	Fri,  4 Apr 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO2ug1Xr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFE3D6F;
	Fri,  4 Apr 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780357; cv=none; b=B3qQFRKIlpxoK+7aalivwm0PS9Xy9wZy2vkUcIixNuT2pNhiH0Crm2oLE49FdYDB9Ce99dpy5sWm/51fwVa2p3HPtTqWslLIVBCx5HHVPL4/+O5H0/PHsaArAiHN7twkYwya4IEj7fE+H5juYvjIe1EGkPZdQq+VaYQF8suU8uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780357; c=relaxed/simple;
	bh=xJg7HCoe0mVfJeMYzbUm1cWmxH+o1mewNNRakDyEJ2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1V0s5DrpO4uv6FiM+bB5fhslDKLoFeioNGwI6zMmLtmr+mpJlQPthBkKxuUO2Y5Ntgzo9/MGidPa1GMYsBKFvlLAp+HOLSVWjbl0Z4Y8cT7y5/TchoG/vg6uw5S5DzoKGGBplG7Ixfol/qamsH7q3sunvMFk4MgR0fskio5WLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO2ug1Xr; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6febbd3b75cso21127387b3.0;
        Fri, 04 Apr 2025 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743780355; x=1744385155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vK21i6Cm/oBnMUPYizwWzpUy62AvakVph2bcyRattBA=;
        b=HO2ug1Xr+0bmVBmbHzK02pgFRli/6i0OYbQVi6kDNvmnxLLPtMks5ZMOxGduN3+jKy
         2NfT2sL4CaukS6/uT51iSw2Z6ZE/c7wfDggEahCiPdlxj83m7Lx7ozXUrdvvoyVsuKvu
         k8/n7qEFxfVJCAARtYLsAlPNW28KCOYVzHksZQpFd4tOS3L2gp0pkiXSCD2Zl5RhbjV+
         0V8CgvBf0O/ocjKLGWnV7CatgQ5Rx/KrtRUQ39dXsWJZ6Ued3ZGdxIoXPZ8fSvoCXBav
         roHk/qQOdbhHkjFpSYg/cO3PQ6cWDSjtC4FGhQIW112nskTX9bQoKsJy4ILxBVStVL4N
         ZHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743780355; x=1744385155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vK21i6Cm/oBnMUPYizwWzpUy62AvakVph2bcyRattBA=;
        b=ENxOlgk8munFE3UggurQdmo4zbKCDZyp651kUCUOI4dLmZ1BqiHbGtyBdc0vp5btML
         b0GpbBs9hsVu7Zt4KdpHLoI7vVFGxfW+utpfi/s2TqMpibkslVdwhZOwfxKD5/FZnZ9g
         qpmeJ7o19h83Qty7KmtDzmtrLlhUPVrU4kexF6I2tadSrBb9TTWMfxoP/VwFdmHipHdU
         Wu0dGbgKfSlQx7ZXEAXoXqJy33gnUa9zSxnHyPQAmzENCL4nmJUkCiEX0Lpvy493IWGp
         ZpfGSbC7kTIck7UMoSM8C/uf4Vw3nCCadNMxtz4yCraITZ3F8YSxn+E/NEILdJbVPJYE
         7SaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBAM/H+ZJOWb6w/EXTrUoqTNMI52ukYh3kMH0OB4HToNAeLF6VtkZzzal3hgCMVG8HyyMwxbzHQr/fxHM=@vger.kernel.org, AJvYcCWQvpVI1AHGy4IoDMairPVgyRl57T8uhpu9RpuvKxjlOpmgNWrdt+4V+MXx0zDT3uYF3m4+Rb2N@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMDaJp/8l4r/ydhYTGozh7UqnS1n69/kRHHuKyeNfXhvVrPzM
	GlontyLVdIuULcE5SCkwGBI/WARhgs3aHavNdERtFN87njA/0T0X
X-Gm-Gg: ASbGncvv1D1ccRBUxZqpEgaPF61AklGzAGpkn85mL/N9inBQPnTn6vegPC/f5STuspH
	FaT2gyxSQIkMQwvtUTauHyon95k/xyGiuzCPIYb8WodJMBvPeBi9DQGu1VpRJO69FHYmMiduisO
	+Rk/VqGr6IaDDMt7o0fqSgY191suqv1b1jzvxuv1uXPiPW0cJLAaJfFndGyGJXy5SqP6cs4CzcJ
	QKfsTV3OhMWsNn5octz8lanwNMQBOkDg4+pdHpbr8N/6DfWdXNLJ1HPDP+2A+fFeWa9n2yZHmz6
	ma21Z9QbfGgWk7IfFZmDriAd54lhT61uXjmOMqo7v78kXnqqcOH+9x4cwPUKFCz3JH4=
X-Google-Smtp-Source: AGHT+IG/ho+VI52OyNB7S66WowmtRGN4XNsDzBAzrRZShq7geFV74ZMq2NsftP++30euSownAh+xnQ==
X-Received: by 2002:a05:690c:c8c:b0:6f9:97af:b594 with SMTP id 00721157ae682-703e151b83dmr63946907b3.10.1743780355016;
        Fri, 04 Apr 2025 08:25:55 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e8ac79sm9284137b3.60.2025.04.04.08.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 08:25:54 -0700 (PDT)
Message-ID: <917d4124-c389-4623-836d-357150b45240@gmail.com>
Date: Fri, 4 Apr 2025 11:25:54 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 3/3] net: bridge: mcast: Notify on mdb offload
 failure
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
 <20250403234412.1531714-4-Joseph.Huang@garmin.com>
 <36c7286d-b410-4695-b069-f79605feade4@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <36c7286d-b410-4695-b069-f79605feade4@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/2025 6:29 AM, Nikolay Aleksandrov wrote:
> On 4/4/25 02:44, Joseph Huang wrote:
>> Notify user space on mdb offload failure if mdb_offload_fail_notification
>> is set.
>>
>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>> ---
>>   net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>>   net/bridge/br_private.h   |  9 +++++++++
>>   net/bridge/br_switchdev.c |  4 ++++
>>   3 files changed, 34 insertions(+), 5 deletions(-)
>>
> 
> The patch looks good, but one question - it seems we'll mark mdb entries with
> "offload failed" when we get -EOPNOTSUPP as an error as well. Is that intended?
> 
> That is, if the option is enabled and we have mixed bridge ports, we'll mark mdbs
> to the non-switch ports as offload failed, but it is not due to a switch offload
> error.

Good catch. No, that was not intended.

What if we short-circuit and just return like you'd suggested initially 
if err == -EOPNOTSUPP?

>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>> index 40f0b16e4df8..9b5005d0742a 100644
>> --- a/net/bridge/br_switchdev.c
>> +++ b/net/bridge/br_switchdev.c
>> @@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>   	struct net_bridge_mdb_entry *mp;
>>   	struct net_bridge_port *port = data->port;
>>   	struct net_bridge *br = port->br;
>> +	u8 old_flags;
>>   

+	if (err == -EOPNOTSUPP)
+		goto notsupp;

>>   	spin_lock_bh(&br->multicast_lock);
>>   	mp = br_mdb_ip_get(br, &data->ip);
>> @@ -514,7 +515,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>   		if (p->key.port != port)
>>   			continue;
>>   
>> +		old_flags = p->flags;
>>   		br_multicast_set_pg_offload_flags(p, !err);
>> +		if (br_mdb_should_notify(br, old_flags ^ p->flags))
>> +			br_mdb_flag_change_notify(br->dev, mp, p);
>>   	}
>>   out:
>>   	spin_unlock_bh(&br->multicast_lock);
> 

+ notsupp:
	kfree(priv);

