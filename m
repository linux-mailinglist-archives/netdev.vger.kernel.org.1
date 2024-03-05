Return-Path: <netdev+bounces-77496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59F871F34
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959D4B25760
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185F5A79C;
	Tue,  5 Mar 2024 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CXibehbN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6558205
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641756; cv=none; b=LJF1VCWMSPtywAGGV3ZYORJRypl1XbiryS/uGpze4w6QITwmNxhcA0qrLO8HvpulSC78bMdx8EjmmmaxZ9N46hiQgZU4hB2Pf90bXYq1jc/kmwQ9XpKInQQizRbKt/OjmhvaQkJtZj9N7m0qQc3b+QsXXyC99C8nev9AD75X69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641756; c=relaxed/simple;
	bh=L1n6YbFTGC16Hd1YNk0uIsYUHdTF6h8Fud1Te9nWxdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyQroIS+xqJF/ao8Nf9XV0xtLPP/VbzXwkdKqF5IWVUpMNmvX2YzWwNva+A+VPNErM0xCZSBLEazpTtymXO3jRVzUpE94rfV9x9Wh+q8vCDEbEl1h4s/1pncp5CLvF68YhgiujLoM+4ujUHTDHzFS8Mt/A7G8bRtylsxRZF1ZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CXibehbN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4595bd5f8cso123006466b.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 04:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709641752; x=1710246552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gd41x20ss/0XO62AK6dEYlhdq11chcAh+qcNcOCMp44=;
        b=CXibehbNUa2OSkwHJ/PNyb7CkbgeVqQ5rLEOB1z+oeTsZt68txoLZP+0M0p05omZUb
         ZDnkTSL7RViqDBcOvfB6Gzl39ZvLbZ4tHtOyPg6EVn5IbKn7laWXdzzdQop75qO22mw8
         ZKlHwYJdF1MjdyJI6fvNeV3g58D6osSg7sV6QrrAPv0v9je+AI8M10XA9dQyssG8VOPT
         3stc2otOEDHtUdBHoCxHSrb3Mq5xaJvlnVXL1QAfquxOeANRaXaNq/lKYPYI0N3H5222
         qRdfacnqomZiD/7XutMJMy2EylEjrzMOzgSGn30NlXWH4hBgh8e0LJUI+nVYeNwNsS7W
         T3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641752; x=1710246552;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd41x20ss/0XO62AK6dEYlhdq11chcAh+qcNcOCMp44=;
        b=Hogcij4CS1ZjkLhn+0zMOM+BlJ89j1pvIzA+M7j9mvYUwXzMcsyMXGN8MbdtUqO6ix
         dbGD1ABpboQg8RWCbVdvS4psOd87K0fIHsBGtWRGuw/Gnv8SilxKK1Uxx+FXUYxiaq+0
         IDozuXPtG9L34JqMbP4/mvn0Ktyaa9fNMEf9uTUG2nfD6pcg2yB5578kWyECTxX/rq7N
         IyUJ7CQd5De45h7ADeVhC3yKT4AbiibstGIRPBowvh4mHGhQsuOLhhaHiqOUQ7URnxXY
         Nz0ujqiPUGTryrOtPpX1owURAeUMRwB7Mj0uPelQTtgy5ZSO6v22453W1oDNsgzRxHJc
         v52Q==
X-Gm-Message-State: AOJu0YwmYitXIqEGvt3APyyAHuQIIBYoL80RGkALx63xRik+S/Q2NT/g
	38pqy+ApExPfc5ZswT7aMBYDR4j27YWCnxs/WUuIC35zI3evwJpC8SCX28ex4mc=
X-Google-Smtp-Source: AGHT+IFRWLXDQ/eGZdgPG+N2XHn7U4ylpF7QfVHhiv9oGnEpAuWgtfjcNJCMQT0gtICaM9nJNAuGVA==
X-Received: by 2002:a17:906:693:b0:a45:26fd:f5ab with SMTP id u19-20020a170906069300b00a4526fdf5abmr4713189ejb.23.1709641752263;
        Tue, 05 Mar 2024 04:29:12 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:f33:beb3:62e8:b7a? ([2001:67c:2fbc:0:f33:beb3:62e8:b7a])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170906e95400b00a44936527b5sm4794057ejb.99.2024.03.05.04.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 04:29:10 -0800 (PST)
Message-ID: <a7b262c8-5795-44b0-9544-26f12f78e703@openvpn.net>
Date: Tue, 5 Mar 2024 13:29:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/22] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-3-antonio@openvpn.net>
 <1f63398d-7015-45b2-b7de-c6731a409a69@lunn.ch>
 <517236bb-fd03-43cb-a264-c7d191058eef@openvpn.net>
 <07050ffc-aa8e-417a-b35b-0cf627fc226f@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <07050ffc-aa8e-417a-b35b-0cf627fc226f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2024 23:46, Andrew Lunn wrote:
> On Mon, Mar 04, 2024 at 10:30:53PM +0100, Antonio Quartulli wrote:
>> Hi Andrew,
>>
>> On 04/03/2024 21:47, Andrew Lunn wrote:
>>>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>>>> new file mode 100644
>>>> index 000000000000..a1e19402e36d
>>>> --- /dev/null
>>>> +++ b/drivers/net/ovpn/io.c
>>>> @@ -0,0 +1,23 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*  OpenVPN data channel offload
>>>> + *
>>>> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
>>>> + *
>>>> + *  Author:	James Yonan <james@openvpn.net>
>>>> + *		Antonio Quartulli <antonio@openvpn.net>
>>>> + */
>>>> +
>>>> +#include "io.h"
>>>> +
>>>> +#include <linux/netdevice.h>
>>>> +#include <linux/skbuff.h>
>>>
>>> It is normal to put local headers last.
>>
>> Ok, will make this change on all files.
>>
>>>
>>>> diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
>>>> new file mode 100644
>>>> index 000000000000..0a076d14f721
>>>> --- /dev/null
>>>> +++ b/drivers/net/ovpn/io.h
>>>> @@ -0,0 +1,19 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/* OpenVPN data channel offload
>>>> + *
>>>> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
>>>> + *
>>>> + *  Author:	James Yonan <james@openvpn.net>
>>>> + *		Antonio Quartulli <antonio@openvpn.net>
>>>> + */
>>>> +
>>>> +#ifndef _NET_OVPN_OVPN_H_
>>>> +#define _NET_OVPN_OVPN_H_
>>>> +
>>>> +#include <linux/netdevice.h>
>>>> +
>>>> +struct sk_buff;
>>>> +
>>>
>>> Once you have the headers in the normal order, you probably won't need
>>> this.
>>
>> True, but I personally I always try to include headers in any file where
>> they are needed, to avoid implicitly forcing some kind of include ordering
>> or dependency. Isn't it recommended?
> 
> It is a bit of a balancing act. There is a massive patch series
> crossing the entire kernel which significantly reduces the kernel
> build time by optimising includes. It only includes what is needed,
> and it breaks up some of the big header files. The compiler spends a
> significant time processing include files. So don't include what you
> don't need, and try at avoid including the same header multiple times.

ACK

>>>> +#define DRV_NAME	"ovpn"
>>>> +#define DRV_VERSION	OVPN_VERSION
>>>> +#define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
>>>> +#define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
>>>> +
>>>> +/* Net device open */
>>>> +static int ovpn_net_open(struct net_device *dev)
>>>> +{
>>>> +	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
>>>> +
>>>> +	if (dev_v4) {
>>>> +		/* disable redirects as Linux gets confused by ovpn handling same-LAN routing */
>>>
>>> Although Linux in general allows longer lines, netdev has kept with
>>> 80. Please wrap.
>>
>> Oh ok. I thought the line length was relaxed kernel-wide.
>> Will wrap all lines as needed then.
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20240304150914.11444-3-antonio@openvpn.net/
> 
> Notice the netdev/checkpatch test:
> 
> CHECK: Please don't use multiple blank lines WARNING: line length of
> 82 exceeds 80 columns WARNING: line length of 91 exceeds 80 columns
> WARNING: line length of 96 exceeds 80 columns
> 
> There are some other test failures you should look at.

Now that I think about it, I did not run checkpatch with --strict, so I 
must have missed some warnings/messages.

Will double check. thanks.

> 
>>>
>>>> +		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
>>>> +		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
>>>
>>> Wireguard has the same. How is Linux getting confused? Maybe we should
>>> consider fixing this properly?
>>>
>>>> +#ifndef OVPN_VERSION
>>>> +#define OVPN_VERSION "3.0.0"
>>>> +#endif
>>>
>>> What could sensible define it to some other value?
>>>
>>> These version numbers are generally useless. A driver is not
>>> standalone. It fits within a kernel. If you get a bug report, what you
>>> actually want to know is the kernel version, ideally the git hash.
>>
>> True, unless the kernel module was compiled as out-of-tree or manually
>> (back-)ported to a different kernel. In that case I'd need the exact version
>> to know what the reporter was running. Right?
> 
> With my mainline hat on: You don't compile an in tree module out of
> tree.
> 
>> Although, while porting to another kernel ovpn could always reference its
>> original kernel as its own version.
>>
>> I.e.: ovpn-6.9.0 built for linux-4.4.1
>>
>> Does it make sense?
>> How do other drivers deal with this?
> 
> $ ethtool -i enp2s0
> [sudo] password for andrew:
> driver: r8169
> version: 6.6.9-amd64
> 
> It reports uname -r. This is what my Debian kernel calls itself. And a
> hand built kernel should have a git hash. A Redhat kernel probably has
> something which identifies it as Redhat. So if somebody backports it
> to a distribution Frankenkernel, you should be able to identify what
> the kernel is.
> 
> We tell driver writes to implement ethtool .get_drvinfo, and leave
> ethtool_drvinfo.version empty. The ethtool core will then fill it with
> uname -r. That should identify the kernel the driver is running in.
> 
> There is no reason a virtual device should not implement ethtool.
> 
> BATMAN is a bit schizophrenic, both in tree and out of tree. I can
> understand that for something like BATMAN which is quite niche. But my
> guess would be, OpenVPN is big enough that vendors will do the
> backport, to their Frankenkernel, you don't need to keep an out of
> tree version as well as the in tree version.

I think the common usecase with batman-adv is OpenWrt: like batman-adv, 
also OpenVPN is widely used on small routers/gateways. It is convenient 
for distros like OpenWRT to be able to compile out-of-tree modules that 
are more recent than the kernel being shipped with the stable release.

Wifi drivers are also part of this roller-coaster, but they go through 
the "backports" project[1].

Maybe I should look into hooking in "backports" as well - it may give us 
what we need without requiring an out-of-tree package.

I guess I'll drop the internal version for now.

Regards,


[1] https://backports.wiki.kernel.org/index.php/Main_Page

> 
>        Andrew

-- 
Antonio Quartulli
OpenVPN Inc.

