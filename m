Return-Path: <netdev+bounces-165913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7ADA33B0D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3252D164AFE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12724211468;
	Thu, 13 Feb 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfQwXpN1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970020FA9B
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438283; cv=none; b=mwrfZ/nf/7Hz5jMQ4bW1nBh1eFB2uqpY98gFws8hWhinfU/Z5Twbic/Vh4Il6E13uAc/bN1zbRgH3oJoclH+VWgJgMAVkbzlXgJNto9X5nTU3okL/U7yfGfuxYdrqxZoCcNVt2m5EpQVR+cpjv6B5EQ5yEgVKXsuCifHrQe2gTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438283; c=relaxed/simple;
	bh=tZFHp6UCOiU6zKu3uGe+iZ5zxsFxAKP2QH0K61+Dvo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQ3+h00fbd3/KdkEVgKMWEJoCAI4UfHL9Rq1CBzAmeJbN+0AAVkn31uKabgIvzBkDbfGZEGwm8qIEWZiUd/5Kk4h4FUm2n/K3DIHndA+GoXpFS0Fwro7cT0LIBwIN5+1QhkgCYSdx4zCKuBKHOYgQc3WJedkGGneB9pqFLYn/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfQwXpN1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739438280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
	b=DfQwXpN1Hr3GOEx8IfO8UuzV5eNkLCezUUN3xPGdHRF3xQIDrufh7i0bbaN4JxVqGqiv1F
	MPKAhUrqma4ZWUNLuMSMXgmGdty0O0XjqeSQdfGAuJBdGxOgxscg2XDJ0P3JNb4kJBEzSy
	QEfjz4zMG0KH0ClRAa6SnIC7y1P0Zac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-siXgF4T1PZip5hYJsLUC4A-1; Thu, 13 Feb 2025 04:17:56 -0500
X-MC-Unique: siXgF4T1PZip5hYJsLUC4A-1
X-Mimecast-MFC-AGG-ID: siXgF4T1PZip5hYJsLUC4A
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dd5031ee7so318703f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438275; x=1740043075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
        b=BLFotudPMIfKc03fel3L3k623wccGplIlavpC9hFb9lNnk69afqZFqxE3/1zuww7VY
         lZ2o6GiJHTBC89PFCJFcddAAqlZz8usR8WZoPKMF6KoSIMk/CdwQAa/2O4awXQi21rjT
         +ipDGwtrwwP8KMYZooyjsHuVUc2txfF1jkCeqFNy3hQZ5n6cVM38GVttDP8mbPvgQBIr
         NVgHjuxWyplsYy/oOtAKg/9hDdcITZp8sJ1b2GDl36msr9R8o/Ymo8F6q/vp5wqQzZG+
         9MeTgcPvsiwESxgZnEvQKJjaHJlxBknpqkjFkqb7qZpXDxxakDwOymcUGmOnLZMG+6X+
         Fe/w==
X-Forwarded-Encrypted: i=1; AJvYcCWCoCM9yXljVgpqx5p2+KV1ZTIjE75z1Ffmj0y+92FwpwC/vNdJXfTq219Ai4tcQK2Un0ybfUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydy4kj69ZeRq8dXuRTrfbiQ/NHeoR3KZBheMl6g1LvvAZ6LHRs
	Qyuyve06vEGg4nJvvWSIAzoU4OstEsFkQBCJ8+wj3qiPNpb+GaJwZ5OVVjQFHCwWCkMZyQTOLp3
	GTL75Y3wlHytQ0cpuxdY8LAwwqaf+fDS15qtGilv4bMW3f0PoSpBGYw==
X-Gm-Gg: ASbGncuXNmmJlTMwm63yDwhz855yU3Qjm3jwshfd9EQ8TPY7GKfWGH+1+UoTwq0lUKd
	SaI7rrzGrl7HKs01cHnRZ/xSaZKH3rWxj06acbxE8o2SW8r7GIPPpAK6TIPzm88fF22phLgtMb5
	2iG/f9Y8BAWeSdp1K+j/ESHLZn6Cp4mIjgsVjp8Qj0ppUUSjk8rtLOLnL+CWUdGDnXopT6t4H8c
	Ta0I1X95PHZmHVisvNcxVndujcdJRDqNIZBztx4HRIEDIOfs5yLC8Z9yP6j3MXFTsUjNDkI4saG
	1wqPJ6OCZ7i/r49OD/RNl+/xJX2RzuVGGUc=
X-Received: by 2002:a5d:59ad:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38dea2e8252mr5537714f8f.42.1739438275362;
        Thu, 13 Feb 2025 01:17:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvdEpVIGWCwTdkiFI9VeLvCiv6OrrtGDZTcFYpY+kBOdDZTqd8HRvUuOkaOwq9itdXLKF4sg==
X-Received: by 2002:a5d:59ad:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38dea2e8252mr5537666f8f.42.1739438274976;
        Thu, 13 Feb 2025 01:17:54 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm1314704f8f.26.2025.02.13.01.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:17:54 -0800 (PST)
Message-ID: <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
Date: Thu, 13 Feb 2025 10:17:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into
 struct
To: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch,
 b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org,
 bridge@lists.linux.dev, davem@davemloft.net, donald.hunter@gmail.com,
 dsahern@kernel.org, edumazet@google.com, herbert@gondor.apana.org.au,
 horms@kernel.org, kuba@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-ppp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
 miquel.raynal@bootlin.com, netdev@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, shuah@kernel.org,
 stefan@datenfreihafen.org, steffen.klassert@secunet.com,
 wireguard@lists.zx2c4.com
References: <20250210133002.883422-3-shaw.leon@gmail.com>
 <20250213065348.8507-1-kuniyu@amazon.com>
 <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 9:36 AM, Xiao Liang wrote:
> On Thu, Feb 13, 2025 at 2:54 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> [...]
>>> diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
>>> index 523025106a64..0f7281e3e448 100644
>>> --- a/include/linux/if_macvlan.h
>>> +++ b/include/linux/if_macvlan.h
>>> @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct macvlan_dev *vlan,
>>>
>>>  extern void macvlan_common_setup(struct net_device *dev);
>>>
>>> -extern int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
>>> -                               struct nlattr *tb[], struct nlattr *data[],
>>> +struct rtnl_newlink_params;
>>
>> You can just include <net/rtnetlink.h> and remove it from .c
>> files, then this forward declaration will be unnecessary.
> 
> OK. Was not sure if it's desirable to include include/net files from
> include/linux.

I think we are better of with the forward declaration instead of adding
more intra header dependencies, which will slow down the build and will
produces artifacts in the CI runs (increases of reported warning in the
incremental build, as any warns from the included header will be
'propagated' to more files).

>>> +extern int macvlan_common_newlink(struct net_device *dev,
>>> +                               struct rtnl_newlink_params *params,
>>>                                 struct netlink_ext_ack *extack);
>>>
>>>  extern void macvlan_dellink(struct net_device *dev, struct list_head *head);
>>
>>
>> [...]
>>> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
>>> index bc0069a8b6ea..00c086ca0c11 100644
>>> --- a/include/net/rtnetlink.h
>>> +++ b/include/net/rtnetlink.h
>>> @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
>>>               return AF_UNSPEC;
>>>  }
>>>
>>> +/**
>>> + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
>>
>> The '\t' after '*' should be single '\s'.
>>
>> Same for lines below.
> 
> This is copied from other structs in the same file. Should I change it?

https://elixir.bootlin.com/linux/v6.13.2/source/Documentation/process/maintainer-netdev.rst#L376

In this series, just use the good formatting for the new code.

Thanks,

Paolo


