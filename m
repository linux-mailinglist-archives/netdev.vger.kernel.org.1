Return-Path: <netdev+bounces-129209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958C97E37D
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 22:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698001C2042F
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 20:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F96F2F9;
	Sun, 22 Sep 2024 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbRclzC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932341E885
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727038296; cv=none; b=I6K34VOy+y+M0dHe19d5w+XdcCj+nmm4hn3qw41OT5U7kYpRBkFk2F3oZc3cWP6UNaCN4oZuG/9GlB/rDiZdCRsXVXohUHEMvPzkqGUZWQ255gH2gpYJxkgo5XfyrB3M/7yIxXZrXdB2QEDfqH9RCdKlF904K+WBqDn7AphbLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727038296; c=relaxed/simple;
	bh=EXYI4FXdl8FHyfjjpvzO/5LQxPPFW37EquwIX9xsVYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jU2uVYbZ4/MjJx7rFqFJBRRT5jWHxPK0/+tTH4BxlQ/QtUF9pU8HleISitCMj7tZ4ELhjWWRTRsZQ37QMK6LoPM9x0RYBzI7kuaNnVYPEDHXy/pHmps0y56a0WuhWPZpVBVfhV8G/Vq/od/VvQ3u7RxvNljFfqkzn92rw7WwJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbRclzC5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42e5e758093so31165005e9.1
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727038293; x=1727643093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gI9UWGl7XMJt/2E9deqz6qtBQi24UIAr7zZh6aHiWRk=;
        b=nbRclzC5rD/b5jn9nQfETENu5t3tOBq50y4SjdUVAm+DMH/fkgfeObWLOXRBHhMihP
         +kammsFrUFrI5xSVySMSZcjxkZ7N/4A2kq3wb39bSbjgfQb45u+j4OXYWAmBZjICHVhE
         fXiPv/PepRh0sNtS2RQB6kyWrlYmyqs4h9EuVXCSuuQL+tzWLuyle170LBS/6pm4GQck
         ZXq8Q9cnu4UgiK2H05yKbjhhhZtNhJzYss/63JZueVr1Cv7S5EmGT3oOgqiGmiNvFOIj
         /YfE2Zj+aJZfSshcvO4XdOM2YjEyTQAzYgStrpKMPcLUnt9RUw5x/lfhp0rYqq0/ye1t
         Jg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727038293; x=1727643093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI9UWGl7XMJt/2E9deqz6qtBQi24UIAr7zZh6aHiWRk=;
        b=SAMI40CnP9H1sULsYmiLeIygf1UEy2X5T2mnYmXtuadK3bcCdD9SWEwNMOVXEBNBIa
         vIqsIAAOtJdKjE3dsS1FuhEa71/7cImMuDBTTwyvS+5VeUXNqxG3ZOLNNBam5nLX52u5
         bc3/Hm5c5y0Mrt/s/xE5yxglammBo64BhljDwH0xunVzeqONJkjezGqdsD45CADL+LgG
         LxK7lk3vt+HzdyqgixGbc/u1onDfh6cuTid44m746WLGaQ82yLN3rRN/cU13JyCfgDme
         dOV3aHpLLJxl/PQUY4wXJYYIMfMgjdZP1Jc7JdXEKYEZikXDo5ztTyR+sQVGssbDk5nA
         Bj2w==
X-Forwarded-Encrypted: i=1; AJvYcCXwQuiBj43bZi2G08aTdVDPuBUcOlAQCPuGfeUpKvKpFQYeu1ZLLIGIVnhdW9YA+vZEmfLfIB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAAz8Dgqecxyslt9c/dIRGE2pqJiUlPu7x1jRW7L71SVoUAaq
	UtShI5xke0HfDQ0X1zH7kKw1Zm3O9nmqDyh4FwOKM3dHaxcE2qOd
X-Google-Smtp-Source: AGHT+IEfrAC2uRCz6Sz7t2TMc5GBNYaHCmrIFQOIpVQiRmFZfLneiSoQEiCbiAK1SVCTeFpLmEkVSA==
X-Received: by 2002:a05:600c:4ed0:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-42e7abeda5amr76229825e9.8.1727038292635;
        Sun, 22 Sep 2024 13:51:32 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7affa701sm84068815e9.43.2024.09.22.13.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 13:51:32 -0700 (PDT)
Message-ID: <cbd97c96-4972-4b4d-a5a5-d43968c1a2d0@gmail.com>
Date: Sun, 22 Sep 2024 23:51:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 03/25] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Antonio Quartulli <antonio@openvpn.net>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew@lunn.ch, antony.antony@secunet.com, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 sd@queasysnail.net, steffen.klassert@secunet.com
References: <a10dcebf-b8f1-4d9b-b417-cca7d0330e52@openvpn.net>
 <20240920093234.15620-1-kuniyu@amazon.com>
 <02420241-98a9-47dc-97a7-d3c1fad76573@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <02420241-98a9-47dc-97a7-d3c1fad76573@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Antonio, Kuniyuki,

On 20.09.2024 12:46, Antonio Quartulli wrote:
> Hi,
> 
> On 20/09/2024 11:32, Kuniyuki Iwashima wrote:
>> From: Antonio Quartulli <antonio@openvpn.net>
>> Date: Thu, 19 Sep 2024 13:57:51 +0200
>>> Hi Kuniyuki and thank you for chiming in.
>>>
>>> On 19/09/2024 07:52, Kuniyuki Iwashima wrote:
>>>> From: Antonio Quartulli <antonio@openvpn.net>
>>>> Date: Tue, 17 Sep 2024 03:07:12 +0200
>>>>> +/* we register with rtnl to let core know that ovpn is a virtual 
>>>>> driver and
>>>>> + * therefore ifaces should be destroyed when exiting a netns
>>>>> + */
>>>>> +static struct rtnl_link_ops ovpn_link_ops = {
>>>>> +};
>>>>
>>>> This looks like abusing rtnl_link_ops.
>>>
>>> In some way, the inspiration came from
>>> 5b9e7e160795 ("openvswitch: introduce rtnl ops stub")
>>>
>>> [which just reminded me that I wanted to fill the .kind field, but I
>>> forgot to do so]
>>>
>>> The reason for taking this approach was to avoid handling the iface
>>> destruction upon netns exit inside the driver, when the core already has
>>> all the code for taking care of this for us.
>>>
>>> Originally I implemented pernet_operations.pre_exit, but Sabrina
>>> suggested that letting the core handle the destruction was cleaner (and
>>> I agreed).
>>>
>>> However, after I removed the pre_exit implementation, we realized that
>>> default_device_exit_batch/default_device_exit_net thought that an ovpn
>>> device is a real NIC and was moving it to the global netns rather than
>>> killing it.
>>>
>>> One way to fix the above was to register rtnl_link_ops with netns_fund =
>>> false (so the ops object you see in this patch is not truly "empty").
>>>
>>> However, I then hit the bug which required patch 2 to get fixed.
>>>
>>> Does it make sense to you?
>>> Or you still think this is an rtnl_link_ops abuse?
>>
>> The use of .kind makes sense, and the change should be in this patch.
> 
> Ok, will add it here and I will also add an explicit .netns_fund = false 
> to highlight the fact that we need this attribute to avoid moving the 
> iface to the global netns.
> 
>>
>> For the patch 2 and dellink(), is the device not expected to be removed
>> by ip link del ?  Setting unregister_netdevice_queue() to dellink() will
>> support RTM_DELLINK, but otherwise -EOPNOTSUPP is returned.
> 
> For the time being I decided that it would make sense to add and delete 
> ovpn interfaces via netlink API only.
> 
> But there are already discussions about implementing the RTNL 
> add/dellink() too.
> Therefore I think it makes sense to set dellink to 
> unregister_netdevice_queue() in this patch and thus avoid patch 2 at all.

I should make a confession :) It was me who proposed and pushed the idea 
of the RTNL ops removing. I was too concerned about uselessness of 
addlink operation so I did not clearly mention that dellink is useful 
operation. Especially when it comes to namespace destruction. My bad.

So yeah, providing the dellink operation make sense for namespace 
destruction handling and for user to manually cleanup reminding network 
interfaces after a forceful user application killing or crash.

>>> The alternative was to change
>>> default_device_exit_batch/default_device_exit_net to read some new
>>> netdevice flag which would tell if the interface should be killed or
>>> moved to global upon netns exit.

--
Sergey

