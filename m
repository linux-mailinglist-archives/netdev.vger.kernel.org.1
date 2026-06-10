Return-Path: <netdev+bounces-297673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lbC+MsBhKWoiWAMAu9opvQ
	(envelope-from <netdev+bounces-297673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:08:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142A66996D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:08:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=CQtPOJY2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297673-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297673-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A28A13070579
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B16176025;
	Wed, 10 Jun 2026 13:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40ED1A23A6
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:00:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096428; cv=none; b=rJFMQIECDtCws0Cb01EI8ksSZKuehNR2TqJ3jf/CA4F+xUXW4dbraU2wwfkoZzqJOBqTBvM2Tf6nYkWFLLqQfC/wZdwfYV/wMp0Eyz/uO1LNflx3Us+/5AiTa5r9z1sIIvOfvRfNTto4UW0slCkjMlyC874EUZFNYHVAPLF1NAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096428; c=relaxed/simple;
	bh=uq7wrb9BbQ1qXAKnJdJNozsHGi7MiMtjMK3/FO+D/6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsBaqPXkhQ8F5eh4/6PPqGbenvLR4/6iGjyZEa2suTl7OkdT5qlL2aqCAEa9VF5mv5b2SSZqFPCka23XGG3b7ucz3neOuqCo7Zd74beAEpO5d6Cu3jWBDv778amT+TCD61w5ayn/t29Cj58QSHvQ+Ap25hBE9Ifsv0VvfHjh/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=CQtPOJY2; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso4626527f8f.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781096425; x=1781701225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2P6FLzmFEnjYSd7sEJKghiq0OYnETpmGfmCNb5FcbA=;
        b=CQtPOJY2jisKI2aaW4keCgID1p1TlkxzLM/jYDgMT5szYv9qvByjG0lcBU2K1bm2Ay
         L4kROpfaJnXsq6pcA2hU3VqhElaxWiIoAClicW2te1//G0t379oR0WC+8nNSWfGmOO7f
         mqndrwVcmItvcEDv03IVHE1f0rbUf5ul9hmFxgs3yjyoqvjgtdJHBdUcM4kyqxmcP71f
         BpDry7soJaN3fcp/qDLJlMwjEObTfcfKfNyG96Qiy6Toqskuf3yCKD6dod9IUH8i9cSq
         ipORPJvh7TtTOMqp0eEk+fOwpC1vO9os1aQp+OR6WjezmSysEOANemvriztHTuwc5GhR
         Z5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096425; x=1781701225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2P6FLzmFEnjYSd7sEJKghiq0OYnETpmGfmCNb5FcbA=;
        b=mxfhmWryCIn8LjZ7sO3LSXh+hGaB5olQdYeMrPnnhc3DJdNn/Jk7D152Ex+Xhs92NQ
         FHHTcKuuewvkn8Ld/bY3shjn7HReg0k7rxtQQ3O/v/P9Sgwu5z6JgNjTmGkKwkEuRXVv
         Pdib4e8vOV+y2GNPh8YxpYnN9SaoZ+OniVNaVrxxiUfmmiQzOe9mB4Vic4HbwmB7nO4a
         oYtHE7hzqWIzETHd1XA7Dxi9sqtYk1xqFfJ3P5lVuZtlrzpNSHkotAPs2bPAvRsvVoYl
         2qwDshZB7eefpvEM6+NGfhjDU6WWxpFaSR4+4MCSTsZ/BpXKKECpvbmWDh0kCoxvMyqm
         W2Lg==
X-Forwarded-Encrypted: i=1; AFNElJ+ErpfVSkLlJelGLsMex51Vx6hXuYzehGFRfLp//pWAQrqYS1PTjB9KmP3KF189vYhv0obdAJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/AlVoBZa9vXfmgmTcTcukbbXxF47rBouMEiXSYmyByQMTlil
	W2R6I7gW7aJm0+30v8VL0Af0veLxTMZMigTX6xRDh+ryzf2wYK0XruqF9fzcG7MKP9w=
X-Gm-Gg: Acq92OFHapGWd1QxaxfS73BAg63tjMU3NIpeARtTA3ICCxDrLu2tKSUTrzH1vHDxL87
	oSesQWHVtiNw68nR61jg6K7HDFsPt0TPyg6B0sFtUd5slWGUAtjxnh3/McdEufFwvhRg7vv7WZO
	+wN1z512xPVSF/vQLuR+6sFl3h4x0nIxId3EsbCw4/BlXOZYjYqZDiKFWrOlqDUEH0sU/R5Q741
	EtJAzVFkgdNJqzWV83trUNY6ej5q52ISxadGEqtIye4E1KD9V5wv0ePIofoU48oVaTWYr1ftSIS
	GhObKJWnrkK1jS2BO1qGNw28dPwqduZJava1rtCzVQNPw+zi4B3EJ91PmR69SmUVO4uC9P33kkA
	Q5hNtIXeU+CtQPEnexzT9Uj1jIo4CtgHrnw24JjNPJ066KVQRkFTjCB6Oasy/MT1jUQs+rxEMkj
	FEqXdZrRPnjVhK6AsAtfb27TtRDjlfAhnK83sngRk+P6hG7shSnBYuPHWyh8/oL0mnhcvMKG7VL
	2M=
X-Received: by 2002:a5d:504e:0:b0:45e:f302:95b with SMTP id ffacd0b85a97d-46030767c03mr28533594f8f.37.1781096424749;
        Wed, 10 Jun 2026 06:00:24 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fb24sm76832421f8f.34.2026.06.10.06.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:00:24 -0700 (PDT)
Message-ID: <e1745196-d315-4dcc-8157-8a56a91f4e20@blackwall.org>
Date: Wed, 10 Jun 2026 16:00:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: add sysfs interface for
 broadcast_neighbor
Content-Language: en-US, bg
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, Tonghao Zhang <tonghao@bamaicloud.com>
References: <20260610120812.49054-1-laoar.shao@gmail.com>
 <1f949cfc-eebc-4813-9dfc-b9a9ec79494d@blackwall.org>
 <CALOAHbBeBez2DAQD+1PPc1Dmm0HH0PQcytG-eaxgWyThRt890A@mail.gmail.com>
 <dd10cb23-261c-40b1-8b33-15a519f366c8@blackwall.org>
 <CALOAHbAnKP96ZZrVZw8duABJTUhmdcUZ_yWcJoRdjCCV9_pb2g@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CALOAHbAnKP96ZZrVZw8duABJTUhmdcUZ_yWcJoRdjCCV9_pb2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297673-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:laoar.shao@gmail.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:tonghao@bamaicloud.com,m:laoarshao@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[blackwall.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bamaicloud.com:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,blackwall.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4142A66996D

On 10/06/2026 15:49, Yafang Shao wrote:
> On Wed, Jun 10, 2026 at 8:45 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 10/06/2026 15:39, Yafang Shao wrote:
>>> On Wed, Jun 10, 2026 at 8:30 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>>
>>>> On 10/06/2026 15:08, Yafang Shao wrote:
>>>>> The upstream kernel has supported broadcast_neighbor for 802.3ad mode since
>>>>> commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
>>>>> When upgrading from our local kernel to 6.18.y stable, we switched from our
>>>>> out-of-tree implementation to the upstream one.
>>>>>
>>>>> However, the iproute2 package on our production servers is too old to
>>>>> support the broadcast_neighbor option. To enable this feature, add a new
>>>>> sysfs attribute at:
>>>>>
>>>>>      /sys/class/net/<bond>/bonding/broadcast_neighbor
>>>>>
>>>>> This allows enabling the feature by writing "1" to the sysfs file, matching
>>>>> the interface we previously maintained in our local kernel.
>>>>>
>>>>> The result is as follows,
>>>>>
>>>>> - For 802.3ad mode
>>>>>
>>>>>      $ ip link add bond0 type bond mode 802.3ad
>>>>>      $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
>>>>>      0
>>>>>      $ echo 1 > /sys/class/net/bond0/bonding/broadcast_neighbor
>>>>>      $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
>>>>>      1
>>>>>
>>>>> - For other modes
>>>>>
>>>>>      $ ip link add bond1 type bond
>>>>>      $ cat /sys/class/net/bond1/bonding/broadcast_neighbor
>>>>>      0
>>>>>      $ echo 1 > /sys/class/net/bond1/bonding/broadcast_neighbor
>>>>>      bash: echo: write error: Permission denied
>>>>>
>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>>> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
>>>>> ---
>>>>>     drivers/net/bonding/bond_sysfs.c | 12 ++++++++++++
>>>>>     1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
>>>>> index eaba44c76a5e..24eb23634d98 100644
>>>>> --- a/drivers/net/bonding/bond_sysfs.c
>>>>> +++ b/drivers/net/bonding/bond_sysfs.c
>>>>> @@ -750,6 +750,17 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
>>>>>     static DEVICE_ATTR(ad_user_port_key, 0644,
>>>>>                    bonding_show_ad_user_port_key, bonding_sysfs_store_option);
>>>>>
>>>>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
>>>>> +                                            struct device_attribute *attr,
>>>>> +                                            char *buf)
>>>>> +{
>>>>> +     struct bonding *bond = to_bond(d);
>>>>> +
>>>>> +     return sysfs_emit(buf, "%d\n", bond->params.broadcast_neighbor);
>>>>> +}
>>>>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
>>>>> +                bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
>>>>> +
>>>>>     static struct attribute *per_bond_attrs[] = {
>>>>>         &dev_attr_slaves.attr,
>>>>>         &dev_attr_mode.attr,
>>>>> @@ -789,6 +800,7 @@ static struct attribute *per_bond_attrs[] = {
>>>>>         &dev_attr_ad_actor_system.attr,
>>>>>         &dev_attr_ad_user_port_key.attr,
>>>>>         &dev_attr_arp_missed_max.attr,
>>>>> +     &dev_attr_broadcast_neighbor.attr,
>>>>>         NULL,
>>>>>     };
>>>>>
>>>>
>>>> Then update your iproute2 package, sysfs use for options is discouraged
>>>
>>> Could you please explain in detail why this is discouraged?
>>>
>>>> and is not being extended on purpose. Move to netlink.
>>>
>>
>> Networking has been moving to netlink-only options for awhile now. Check for
>> example:
>> 1e16f382ae0b ("net: bridge: add warning comments to avoid extending sysfs")
>>
>> The preferred way to configure device types is via iproute2/netlink.
> 
> Thanks for your explanation, but I still don't understand the benefit
> of it. Could you elaborate further?
> 

The benefits of netlink over sysfs?? There are so many.. it will help if you
look into how netlink vs sysfs operate. Netlink is structured, transactional,
typed, easily extendable, you can dump, do specific queries, it is less calls 
and it supports notifications. I'm sure I'm missing, but in a nutshell it's
preferred. :)





