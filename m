Return-Path: <netdev+bounces-94824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CABC8C0C91
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0C91C20A24
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EEC14A081;
	Thu,  9 May 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fV1F62OE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DCF149DEB
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243379; cv=none; b=edKzDNu1gaDQAPGztVVYPJSAGTBB06xkt0GWNzF2Qq63HSslVo8v4YSOnwK/dtFijDtFqtFHrmV8mTnhWfTpT+cYK9JuycSDjXPC+KOSjuU/rBOG+Lv5MCZ3K8fDQO4O3q/plecBWDWUAddUdRTsZuDvY24NiP7gFQkDYXSPDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243379; c=relaxed/simple;
	bh=zkq4ruaaBI1AkUYT0ApAFfUAHFHrNu3wfkgQJ1nIms4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7kwXhZHyR8kwMJWXgNkX3/pvXoxCosnycG3gRb7mFZx0dHn5CffPB4rpM+ktQnSrODnJSUa4WwjznLU05fTNngKGTZ0v5nTYGOK2OOOKctY3gc5vvpYhLqRkRpGcy0Bwye9VgGbVXn7zGuoJ3zXTRlmNVtze6uRpAGn9vX30f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fV1F62OE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-346359c8785so433165f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 01:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715243375; x=1715848175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ap5et3rfjZAPPI6jdU2zvUzFqtxJdAXJo60vGkUc804=;
        b=fV1F62OE9S9Kvq0bNy858mf8MyJw45ZfVKsKLjqNq0nVBzCran/IMn2d5ql4kByv1I
         fwD7eAyKEnhf5L8P7VW6kiPB8RewNtjcIcbSiM0p50vOhDxk+tqjq6/oDbsCKp6QlG4o
         2h5eYusbj6yQ1QzP9/WCy0KEDpcl7p/vVK64ynXHfPtQkp4OgHgSOa2t+377MFwrcqJa
         LVZ/4LY1o9TXPeBBz8BuHuragT7ZrxcAYXcWOrYPnNBX7zAcL6dzq5te1YKHHL9TBmQg
         X/kjKySAk6L4xPINxS6//3h7NZrvbDhgTC/rHHRw9odSpVRHbyzGz7w0v3DBK24l91nl
         DqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715243375; x=1715848175;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap5et3rfjZAPPI6jdU2zvUzFqtxJdAXJo60vGkUc804=;
        b=kKeUjKlbaJ/Q/DjPgpgsfucYpcm2UWz8Vom9xV3PTmW5UYt2feqMVwwhzVSPcNIxa2
         /XhacVqhCAxFVFieF+hXInFT4igL9N3iIZaPVi9gRvnJGC6eHc/W06LQOttPFwypltck
         lMt24rRKJwchYzyE/5EdB2q3Jk/4fTCaE8llWzopnz/quyFW7939bgX6TQRftrzqiwcS
         Q0Y5WqvV2KTHAX6/20/FayNPXPFM2l2FZSpGV4cT+JHGnaLdA71OB9VyS2OKmvDWULqs
         VwIQcQpZjNEOuvkI9kInfyhl34b+2/0WJpbAlqnpXYDLOQh9HqYjDBnnIzOhSyikybgn
         JBnQ==
X-Gm-Message-State: AOJu0Yy6CX+rPUkIIL2LjVZ7DodvY8p0XqjVvjr+TbAlwTMiQOIUY1PC
	wC7psUc4pN1S5LmRqZ7aIARW5Ky4IONcZBvW3yh/0Xd/dKB9vHJfBm9lrJSEumikG52/Vt0FCbs
	2
X-Google-Smtp-Source: AGHT+IHol/FHAvT0PKf0FqIiYLjDGi9Ezkseav9fmCA4VXY+VH7nVYvTkbnj1BT/nms/Z4XFEIj7cA==
X-Received: by 2002:adf:f946:0:b0:34e:e770:9a11 with SMTP id ffacd0b85a97d-34fcb3a9282mr3001691f8f.55.1715243375428;
        Thu, 09 May 2024 01:29:35 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad04dsm1045533f8f.81.2024.05.09.01.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 01:29:34 -0700 (PDT)
Message-ID: <6cd53c57-0ec6-46e1-bfb3-e2ca02215a37@openvpn.net>
Date: Thu, 9 May 2024 10:30:51 +0200
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
 <3b9f43da-0269-4eba-a3c4-dcb635c0de75@openvpn.net>
 <20240508180946.47e6610a@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240508180946.47e6610a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/05/2024 03:09, Jakub Kicinski wrote:
> On Wed, 8 May 2024 11:49:07 +0200 Antonio Quartulli wrote:
>>>> +		netdev_err(dev, "%s: cannot add ifname to reply\n", __func__);
>>>
>>> Probably not worth it, can't happen given the message size
>>
>> Personally I still prefer to check the return value of functions that
>> may fail, because somebody may break the assumption (i.e. message large
>> enough by design) without realizing that this call was relying on that.
>>
>> If you want, I could still add a comment saying that we don't expect
>> this to happen.
> 
> In a few other places we put a WARN_ON_ONCE() on messages size errors.
> That way syzbot usually catches the miscalculation rather quickly.
> But no strong objections if you prefer the print.

I am fine as long as we have some check.
If WARN_ON_ONCE() helps syzbot, then I'll go with it.

>    
>>>> +		genlmsg_cancel(msg, hdr);
>>>> +		nlmsg_free(msg);
>>>> +		return -EMSGSIZE;
>>>> +	}
>>>> +
>>>> +	genlmsg_end(msg, hdr);
>>>> +
>>>> +	return genlmsg_reply(msg, info);
>>>>    }
>>>>    
>>>>    int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info)
>>>>    {
>>>> -	return -ENOTSUPP;
>>>> +	struct ovpn_struct *ovpn = info->user_ptr[0];
>>>> +
>>>> +	rtnl_lock();
>>>> +	ovpn_iface_destruct(ovpn);
>>>> +	dev_put(ovpn->dev);
>>>> +	rtnl_unlock();
>>>> +
>>>> +	synchronize_net();
>>>
>>> Why? 🤔️
>>
>>
>> hmm I was under the impression that we should always call this function
>> when destroying an interface to make sure that packets that already
>> entered the network stack can be properly processed before the interface
>> is gone for good.
>>
>> Maybe this is not the right place? Any hint?
> 
> The unregistration of the netdevice should take care of syncing packets
> in flight, AFAIU.

I have another call to synchronize_net() in ovpn_iface_destruct() after 
calling unregister_netdevice().

Sabrina was actually questioning that call too.

First of all I now realize that we are calling it twice, but from what I 
am understanding, I think we can just ditch any invocation and let core 
do the right thing.

I'll remove it and do some tests.


-- 
Antonio Quartulli
OpenVPN Inc.

