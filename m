Return-Path: <netdev+bounces-94481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BCE8BF9C3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22DD1F24436
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59CB7BAE5;
	Wed,  8 May 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OFtexRnR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC279DC5
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161676; cv=none; b=RLdCDOP9eVTnxpIP1+kIrQxtj6uC8IMhE5hwJ48Z8yIAfGfOcEEg4a6QBIWyKl7Z/o7HuM57v78k43SLVuOuZ2X/galQ0VCyf9CcSJEKmSGisxrlgks5xLiuQ49PZHr3jOsCAV4g6nKbTHSwPC3CNtf5Wx7PQpDKkuFGEgZDtHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161676; c=relaxed/simple;
	bh=x7m1v2OV+noO39h54kEhcM8IvyUy8ABHlxXsyzz8WJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyesJcTqMOOvHRytvPfQjD46h44Be+s6L6kxhE6yP0hSAKlZBGQ8vxROLuMw8muQ6YYgE0WhgAYAMaUXbfHPZSO6b6VWUfgk8ohMHQJ22eBjULf3dqa5IQ0kORunb3WMk5bSS943W9eJ+HAJ9ICXxD/LfucGWoNOjZPrTyoVTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OFtexRnR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b782405bbso28929425e9.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715161673; x=1715766473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8TuKR5hHMhWVL77DCPEdE30zz0Wi6z1IRMgq9ENelI8=;
        b=OFtexRnR7+KWPFaMtLH7oe1L1O1yvvD5ON6Rt7S3bIwj9501m9AdPtKmdPs+U+lWYj
         NC5JDhwfIBz6bchT8XfoCLJclD0G2+E36nfEBzePXVDk6oWSfdoomUVaoe+AptM9SL/8
         Qza9ZYtf48NlJdbScps9CJEGj71wMrM0ixXvBYjc+fg6If8xzNwnVK7ifxSVcr1NhLJT
         kldpnLFNeQluXTlQ8G9xnJ0zE+gFExzZqe9uvX201qUc91/iJr3VJf/m8+nh5pFRkvhm
         I4VKp+t0qBc4ro0Ab0lzIuhqLo912G7mzKic7c0aKPzrvI7PpAplx5eM3JlVwccSjhZW
         5TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715161673; x=1715766473;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TuKR5hHMhWVL77DCPEdE30zz0Wi6z1IRMgq9ENelI8=;
        b=Glys4pheD1BAR68rVsnI96zuEngofJNU1VtBf572d3kRYOz9yOta1ghDDcsBIXVrlH
         qCrhSKOVdO7QqJpJelnta41vy4Rr+th9m5CoeinjrKjOAqs2KI41KH/nhnRdMt5xfA68
         +bhn6xDNLYTSeA8tM66Fb6DQyQEAq0kh+lqfvJoIfxe4g9RoP+b7qbVK2H8YmSYh8zU1
         2V+eBR7t+K19PXzQ8gn3aQH6iuzKouartomxQwBw5subdlB2Cy2CXeYUHEqM4pTkKVuL
         QNjBYXd0Ic8mK2KevWX/TVsAVjr9o+N5zN6NEGLF/hT1Rf0B/yteXOr74KUFgm9PIyQf
         pkrg==
X-Gm-Message-State: AOJu0YzGhKik8Fk30D9GouOchpPBAvuw+NxZYR/OLv2LkM9UkXuw0hXd
	Lwu+Xa7Hw91eRc93c/jvROmtO9pDKQQOQu/zHaxtRh1AX+ncBOANh0HhESGHdNc=
X-Google-Smtp-Source: AGHT+IGi5xRuUPpCjMlhoxyIrDymxKWNbyJ4h8cGCBnEDjfy9RdAzsodEVet90+KMdkwrVOqgjCjeQ==
X-Received: by 2002:a05:600c:3b82:b0:419:87ab:f6da with SMTP id 5b1f17b1804b1-41f71302982mr18371285e9.3.1715161672823;
        Wed, 08 May 2024 02:47:52 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:9ca5:af56:50eb:bcf3? ([2001:67c:2fbc:0:9ca5:af56:50eb:bcf3])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c311400b0041be58cdf83sm1688987wmo.4.2024.05.08.02.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 02:47:52 -0700 (PDT)
Message-ID: <3b9f43da-0269-4eba-a3c4-dcb635c0de75@openvpn.net>
Date: Wed, 8 May 2024 11:49:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/24] ovpn: implement interface
 creation/destruction via netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-6-antonio@openvpn.net>
 <20240507172122.544dd68e@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240507172122.544dd68e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/05/2024 02:21, Jakub Kicinski wrote:
> On Mon,  6 May 2024 03:16:18 +0200 Antonio Quartulli wrote:
>>   int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -ENOTSUPP;
>> +	const char *ifname = OVPN_DEFAULT_IFNAME;
>> +	enum ovpn_mode mode = OVPN_MODE_P2P;
>> +	struct net_device *dev;
>> +	struct sk_buff *msg;
>> +	void *hdr;
>> +
>> +	if (info->attrs[OVPN_A_IFNAME])
>> +		ifname = nla_data(info->attrs[OVPN_A_IFNAME]);
>> +
>> +	if (info->attrs[OVPN_A_MODE]) {
>> +		mode = nla_get_u32(info->attrs[OVPN_A_MODE]);
>> +		pr_debug("ovpn: setting device (%s) mode: %u\n", ifname, mode);
>> +	}
>> +
>> +	dev = ovpn_iface_create(ifname, mode, genl_info_net(info));
>> +	if (IS_ERR(dev)) {
>> +		pr_err("ovpn: error while creating interface %s: %ld\n", ifname,
>> +		       PTR_ERR(dev));
> 
> Better to send the error to the caller with NL_SET_ERR_MSG_MOD()

yeah, makes sense. I guess I can do the same for every other error 
generated in any netlink handler.

> 
>> +		return PTR_ERR(dev);
>> +	}
>> +
>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq, &ovpn_nl_family,
>> +			  0, OVPN_CMD_NEW_IFACE);
> 
> genlmsg_iput() will save you a lot of typing

oh, wow, nice one :) will switch to iput()

> 
>> +	if (!hdr) {
>> +		netdev_err(dev, "%s: cannot create message header\n", __func__);
>> +		return -EMSGSIZE;
>> +	}
>> +
>> +	if (nla_put(msg, OVPN_A_IFNAME, strlen(dev->name) + 1, dev->name)) {
> 
> nla_put_string() ?
> 

right.

>> +		netdev_err(dev, "%s: cannot add ifname to reply\n", __func__);
> 
> Probably not worth it, can't happen given the message size

Personally I still prefer to check the return value of functions that 
may fail, because somebody may break the assumption (i.e. message large 
enough by design) without realizing that this call was relying on that.

If you want, I could still add a comment saying that we don't expect 
this to happen.

> 
>> +		genlmsg_cancel(msg, hdr);
>> +		nlmsg_free(msg);
>> +		return -EMSGSIZE;
>> +	}
>> +
>> +	genlmsg_end(msg, hdr);
>> +
>> +	return genlmsg_reply(msg, info);
>>   }
>>   
>>   int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -ENOTSUPP;
>> +	struct ovpn_struct *ovpn = info->user_ptr[0];
>> +
>> +	rtnl_lock();
>> +	ovpn_iface_destruct(ovpn);
>> +	dev_put(ovpn->dev);
>> +	rtnl_unlock();
>> +
>> +	synchronize_net();
> 
> Why? 🤔️


hmm I was under the impression that we should always call this function 
when destroying an interface to make sure that packets that already 
entered the network stack can be properly processed before the interface 
is gone for good.

Maybe this is not the right place? Any hint?

-- 
Antonio Quartulli
OpenVPN Inc.

