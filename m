Return-Path: <netdev+bounces-297667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nlj/KNJeKWpaVwMAu9opvQ
	(envelope-from <netdev+bounces-297667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:55:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1356697A8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:55:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b="Je7PZ1/I";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297667-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297667-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DBB5307DE28
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF453F8717;
	Wed, 10 Jun 2026 12:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E6407CC9
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095559; cv=none; b=e2JMGL46NJY7/e06CCTC0rvWBPNw4D7UgFhhICHBUkVMKxap1VSHRdOb2+i/sELfloaMBtGSjdu1ZGG1qF9pPAdXvjPo9ROEWFTQMSecIUjUdXhMvoSZ7JQXJJKpJOCdIhoufm1W1moNu2NeH0hJXkGKFJYWDyaXm+4K9IDQEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095559; c=relaxed/simple;
	bh=frB7CmpYjZ5rHybB4+5LlDeMnxO7eZk13f/53/RPBWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myt7SONPogARy/FG+Kb9Z88VzBSW63gFLUXCwgfQPMP2FG0TDIbFE8aMBvdLY0Usp2syEKVugfIF+3c9hQ0nocOoAu0u+Mje2ah2SGtOQ/UrkPgWIhDDOhmynumOOBtPQaedfrzzHUZitmVVZNAgQ5IQ9zWUkd00YVBnPRv2fy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Je7PZ1/I; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so38187675e9.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781095556; x=1781700356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fuuPFOpACi1anVNp8cLZECz8p8ED0ZCCOtyvVLKVlWk=;
        b=Je7PZ1/Im0XOqzY1hK/wNWiopKRwESu+M14kIh449QWipmAk+Y8f02fHNAEg/iZFs3
         FjINKm8npxzgu9nOCHqacs8KjBFsI/T8Qm6NP7BeDKfqWgWjRHRPOs+WhaidAHqAyLDm
         OFIOP4fzo93hvYm4zj/89B7aYnQEzNWGcHobMY5Yp26cvrVowYcbv6wkHTVnLRJchTBP
         sA4kim7dBEwuoJYcJT7uRRaV/oiAJ4/qpTe7oclGdR2eMuaMwJlOg0/7OHg7xqw3a7Pq
         5EYbBm9rzLxTO4hl9viuTPFsWd+Fbt0fr3yeQrTy9WP2D+kbzxeHdxUz9jLzvMWixw0O
         FOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095556; x=1781700356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuuPFOpACi1anVNp8cLZECz8p8ED0ZCCOtyvVLKVlWk=;
        b=H1JKtfQvveJAA/HE2H6/bB6PLXAU5FR020oQ61bSAksR6E9NBeQ55wuMJzZLKunzjD
         hNczJUXFkGEjgZotCSnZTaQHJJX1X5LK+diE6NlCHxlTPqvIm03tz6xHLvHSqm+sWHXS
         uPqEVDiRzHWA/5vGCuBuDzOW7iemnsiJ3oL2gnLze2lC6CdMgF6+mxapZq33SvcZZnf0
         ll368SJuWWdlKXn/ZvN+fyTSyScTRStP6bq12sA2dNCO2EX1Vpgnni1fyZdHEGrLUzJt
         3H78I00HJP3w+WDVXB/uCGpXq29hPyIXTZSATK34/jHwX9Wt8mzLf65tIVUqa2/7Zgrb
         Tcpg==
X-Forwarded-Encrypted: i=1; AFNElJ8Gcxpqx8I5eJwtEndHuoyZFQvwnSMA/y+OHVBEhi1f61PcdVBNfpT9hkMK2LESFjTi4D9dbDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWt0eq/clylJCsNHYXYREcVyyQhWJGTH0Uqzr4ejfBejbzhVoO
	Z/ShMmlWddFXJa2mV8aVzHeO+jY3X8K8LLI+BfPzO5q83Lc0khukHY5d0wIVIA2zn4U=
X-Gm-Gg: Acq92OF/uSfQr8ZJpvuPRsc0E1/5q+2dkTqLNv3y0JmPD0zMsnsPgmCv+4Yf9EjUUph
	Nmx6CufOJxGm0x8sYgA8PLpaJwob8MInhTwMcQNn8p+ZMon5LI4I7k23xEASG5xfRDxjrgDm5XS
	vudTx2tbCH2OfOs7+u+yvRAid39MTNPrPAfq/H3/hMMzrbDnqFjRdBVzsvfMLQ+gIPF/28dixbA
	+PKFdfxuxUVTtjCsrjwZ/0ppzx517PGJ8I8KRdAhrYzz4EIRUDyB6xqybA6G8IAOwISYPpYxwAn
	SLTCRrUICer4KasbCpIKwcWQz8e65zNUIeC4Pw3KFVROGjJxSZFxYO8NxjCtLWZaCNTkjw8xwYd
	NpUhMjo5M3UHv/Vl3/dsKmp8PGVQam5n7sg7WxycJoWlDWno/0zTOo2gHQc/OvZgGMjpjZi3tMv
	4MoJj6ParOSHFCmqg1zRwodfL1/nchxXS/C75E4zSD/t2WRVOcmRQYV+Xm50z+Mj/L
X-Received: by 2002:a05:600c:e548:10b0:490:cf76:dea4 with SMTP id 5b1f17b1804b1-490cf76dec2mr138346595e9.2.1781095556178;
        Wed, 10 Jun 2026 05:45:56 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm561068405e9.13.2026.06.10.05.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 05:45:55 -0700 (PDT)
Message-ID: <dd10cb23-261c-40b1-8b33-15a519f366c8@blackwall.org>
Date: Wed, 10 Jun 2026 15:45:54 +0300
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
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CALOAHbBeBez2DAQD+1PPc1Dmm0HH0PQcytG-eaxgWyThRt890A@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-297667-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bamaicloud.com:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,blackwall.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B1356697A8

On 10/06/2026 15:39, Yafang Shao wrote:
> On Wed, Jun 10, 2026 at 8:30 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 10/06/2026 15:08, Yafang Shao wrote:
>>> The upstream kernel has supported broadcast_neighbor for 802.3ad mode since
>>> commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
>>> When upgrading from our local kernel to 6.18.y stable, we switched from our
>>> out-of-tree implementation to the upstream one.
>>>
>>> However, the iproute2 package on our production servers is too old to
>>> support the broadcast_neighbor option. To enable this feature, add a new
>>> sysfs attribute at:
>>>
>>>     /sys/class/net/<bond>/bonding/broadcast_neighbor
>>>
>>> This allows enabling the feature by writing "1" to the sysfs file, matching
>>> the interface we previously maintained in our local kernel.
>>>
>>> The result is as follows,
>>>
>>> - For 802.3ad mode
>>>
>>>     $ ip link add bond0 type bond mode 802.3ad
>>>     $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
>>>     0
>>>     $ echo 1 > /sys/class/net/bond0/bonding/broadcast_neighbor
>>>     $ cat /sys/class/net/bond0/bonding/broadcast_neighbor
>>>     1
>>>
>>> - For other modes
>>>
>>>     $ ip link add bond1 type bond
>>>     $ cat /sys/class/net/bond1/bonding/broadcast_neighbor
>>>     0
>>>     $ echo 1 > /sys/class/net/bond1/bonding/broadcast_neighbor
>>>     bash: echo: write error: Permission denied
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
>>> ---
>>>    drivers/net/bonding/bond_sysfs.c | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
>>> index eaba44c76a5e..24eb23634d98 100644
>>> --- a/drivers/net/bonding/bond_sysfs.c
>>> +++ b/drivers/net/bonding/bond_sysfs.c
>>> @@ -750,6 +750,17 @@ static ssize_t bonding_show_ad_user_port_key(struct device *d,
>>>    static DEVICE_ATTR(ad_user_port_key, 0644,
>>>                   bonding_show_ad_user_port_key, bonding_sysfs_store_option);
>>>
>>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
>>> +                                            struct device_attribute *attr,
>>> +                                            char *buf)
>>> +{
>>> +     struct bonding *bond = to_bond(d);
>>> +
>>> +     return sysfs_emit(buf, "%d\n", bond->params.broadcast_neighbor);
>>> +}
>>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
>>> +                bonding_show_broadcast_neighbor, bonding_sysfs_store_option);
>>> +
>>>    static struct attribute *per_bond_attrs[] = {
>>>        &dev_attr_slaves.attr,
>>>        &dev_attr_mode.attr,
>>> @@ -789,6 +800,7 @@ static struct attribute *per_bond_attrs[] = {
>>>        &dev_attr_ad_actor_system.attr,
>>>        &dev_attr_ad_user_port_key.attr,
>>>        &dev_attr_arp_missed_max.attr,
>>> +     &dev_attr_broadcast_neighbor.attr,
>>>        NULL,
>>>    };
>>>
>>
>> Then update your iproute2 package, sysfs use for options is discouraged
> 
> Could you please explain in detail why this is discouraged?
> 
>> and is not being extended on purpose. Move to netlink.
> 

Networking has been moving to netlink-only options for awhile now. Check for 
example:
1e16f382ae0b ("net: bridge: add warning comments to avoid extending sysfs")

The preferred way to configure device types is via iproute2/netlink.



