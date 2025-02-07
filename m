Return-Path: <netdev+bounces-163879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790E2A2BED3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB87169675
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA261D6182;
	Fri,  7 Feb 2025 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LJ96kNE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896E225414
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919454; cv=none; b=c/TbDMHq+9YOKSEbAbb1pKDCtmEq7Mb2bXtJsNDDgfgpVQXlbvrZmf7yDfJUdZjnKN599x/coUzkoQiO8rCTIHmt9WRFh5CeIUBZtBbH5kqVcKoy1FBhg85IJoTosNwilebTFosoFHrkrd3ihjbsFKI7Qy/oqrSkCsD2YfuHefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919454; c=relaxed/simple;
	bh=i9FrLIp0xti++pxUhBVlBVVgzsShx3zu32Fva3r+vFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiLsv3e9iE1gVHUVQMHz61lIY+LKSLYoE4B4SfwnlsRrf+OuqQKzzadB+Tk/5qNYq/hLy/hzgimsWnR0Rfly0lG5zp2on+p5MRAQtLonrpB6e3HxLUnaw3NDWTd+lEIYzYslETkQp+BTmFdAnOJEOZ8omkmMG3I3ARcMAdyEmKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LJ96kNE4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436381876e2so904605e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 01:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1738919451; x=1739524251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SXin1jIPEZdzBV/nyx95YL5g+3s8K+/hDEeF0PSYrYM=;
        b=LJ96kNE4tVD8dLgdqKpSN3iAVw6DVjHwe/kdsp3BIYSnX4iStMO4r1dHP2p4Fuyc6e
         LxWs8pUgUVrxzrIqG2vdh5C9rhiO5RPw32O32/5OaVOgysH4bxPibBnN0AjJv08UXGnb
         WAeBcaTdfeN1zFPadQBDYcW1g8WmAmzi6fqlt9DNiiyaxgcK/rJG6Es9+SWUh5noyzg+
         vB3pTiEvs3cDnYZCzjZVYnzQxH6BsiroSaKxZqAf/K6vjosQ6g+EF5QQ83f4dppQ09Iv
         mF0BuIV5O/MpeUlxdXqtIDYvC+7xJv4MTBjiSJOzlWoq3MLMD+pZSxyrypA0YC+fVjy+
         h6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738919451; x=1739524251;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXin1jIPEZdzBV/nyx95YL5g+3s8K+/hDEeF0PSYrYM=;
        b=Dycc2BEjpLsgNvHQXhmesuX6AAsCuUfkzwxYLaUXHD1fK8PLQS/6JCMiUSTNJ/vFCI
         eRgU+61h3K8n5Vs5TFePC/gyUHweJHyEdYWE9fNeVwEgW024+3ZJd433JwLp8ftQeHTg
         jF8mCZDx3sd2oUxhbGc4aZ3Qqv5XvQL9JW5seuU2ENVsk3tWPonrb+2srjx18hu+n9v9
         7+ScAMkzPGGElY6xpXnWTaUlJShzIU9YF/gkEOk+UP7USmwAhQMzEKllphRA4F/WwKVd
         5nlHWyRJVszEv2w37qALRBHvfzy5+kGuL/og1xLsySP3klDGtk8VFsyRz/lZtdjGFSTu
         bM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLVuopT00LfGoGB4tfA3dh/f3aU/bEXL0dLgjzKqhboAriloiCsc74ZiFhDvbLIWUKrQxVKpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRARX+7xdRHwOuJCVSJEnicch6sZHGOIcn51rUJsG2r4YFcuj
	hY2NFHRXLFYAbYos8ZY1Ddet3TtQfO5Vv7ZcO0A45VFLXLkpoMxxMsRW2ksNe8A=
X-Gm-Gg: ASbGncvIl2X1UdWvEKccFwVgdJKIQI2j6ZY5a1y7xG2enJrYBv9Dzj+IHf272fipL/0
	TIxVpBl7QJagF46CjXhE6cXFl/Jv6UPpQF0wZ4JpKJxHY+aWWl1b6RwKojB6HepsSQhPj3Q8ggj
	4XgIq5irJeJ4xQUWzeNA68psmfWavx8h5A+EsmHPxtxmUC2CZoUNDbbqYGkOR0gmDyE8GSX6T8K
	vPmpN92Zr0OqMPNrYWWFJ8KAm6w+xZpRbwbSmVoquDyRZRyrLUi98pFipUorMDTosLANnJlzANh
	r9lV5BcSaGM7Wq8l1hnXwr8FrJEqM+WfqNquUfI9ei+HraqqrH0vk/OwghHuCQ1zVcO+
X-Google-Smtp-Source: AGHT+IFZoMqCwF0khkQO1oubxwl8ImW8iWx20VcxKQxYC79R2Kwjaq7Eg4FjyZ2p9kPUjorzHwz4Dw==
X-Received: by 2002:a05:600c:4fcf:b0:42c:b55f:f4f with SMTP id 5b1f17b1804b1-43924b5dd96mr8296415e9.6.1738919451043;
        Fri, 07 Feb 2025 01:10:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:b6fc:4d17:365c:3cad? ([2a01:e0a:b41:c160:b6fc:4d17:365c:3cad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd1af07sm3962097f8f.15.2025.02.07.01.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 01:10:50 -0800 (PST)
Message-ID: <f052190e-f81e-491b-aaed-60eaa01fd968@6wind.com>
Date: Fri, 7 Feb 2025 10:10:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/2] net: advertise 'netns local' property via netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
 <20250206165132.2898347-2-nicolas.dichtel@6wind.com>
 <20250206153951.41fbcb84@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250206153951.41fbcb84@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 07/02/2025 à 00:39, Jakub Kicinski a écrit :
> On Thu,  6 Feb 2025 17:50:26 +0100 Nicolas Dichtel wrote:
>> Since the below commit, there is no way to see if the netns_local property
>> is set on a device. Let's add a netlink attribute to advertise it.
> 
> I think the motivation for the change may be worth elaborating on.
> It's a bit unclear to me what user space would care about this
> information, a bit of a "story" on how you hit the issue could
> be useful perhaps? The uAPI is new but the stable tag indicates
> regression..
To make it short: we were trying a new NIC with a custom distro provided by a
vendor (with out of tree drivers). We were unable to move the interface in
another netns. Thanks to ethtool we were able to confirm that the 'netns-local'
flag was set. Having this information helps debugging.

> 
>> @@ -2041,6 +2042,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>>  		       netif_running(dev) ? READ_ONCE(dev->operstate) :
>>  					    IF_OPER_DOWN) ||
>>  	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
>> +	    nla_put_u8(skb, IFLA_NETNS_LOCAL, dev->netns_local) ||
> 
> Maybe nla_put_flag() ? Or do you really care about false being there?
It depends if the commit is backported or not. If it won't be backported, having
the false value helps to know that the kernel support this attribute (and so
that the property is not set).

FWIW, I will be off for one week, I will come back to this later.

> The 3 bytes wasted on padding always makes me question when people pick
> NLA_u8.
> 
>>  	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
>>  	    nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
>>  	    nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||


