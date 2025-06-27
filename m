Return-Path: <netdev+bounces-202079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0A9AEC2D7
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1FB4A7295
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A23021D3EB;
	Fri, 27 Jun 2025 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IZ8QXwnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6717C21C
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064879; cv=none; b=YGDka06ViJymIUBc4O7YDqta3yF820UtyFH+OK89NdIbgk53H+uosT4J5h6uoc5tqefkdlnBwvrvgj638rIS1AiiuJIrtoR7q/ZR/iT7EyrtQQaEOvL1mghrosPym3KWIWSoLptxYqsRqQ0WnWF1+ihFXSTM61bXOsjHFx4SyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064879; c=relaxed/simple;
	bh=waHra6StiXldzktlKKM3IolfZGQUqCrVEmvWBV/ZnKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+jrF0V5dIrGq5gdH0tEp1CHw0GLeWZW2+4kVy4Szuqi0A0K9T3hOeTWy7IKp+GWq477VYsBp1Pb9w3EkKHrf/p+np0gKS2cJosJ4BhZUrLB16fKMW5B3esBLfwoLQO0nY5muNVz2Bkj/qcozPPHlBFQ9+C0jY0yBspJ0JKRUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IZ8QXwnD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4eed70f24so385403f8f.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751064876; x=1751669676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ezLIkR/B4gCsYPXXa9biSbKg2Jc/4U24Spnp0ibhhew=;
        b=IZ8QXwnDZmOLQVaugzzuGWMHNtCb9azznX/R2xDvCbAJ9acuR3M6+bTJHadG4mVWBP
         ZrThpGxDLKtMSzKwuqWz1DLfahKZ6sURq9CcLWnG9xVkF4Aq8lB90IXk2SxXc5hEkFhv
         AFW06BMbLrnXdd18E475OtY2y1wOQFUQ4jPQKQ0cWBAtThOyUr10x1x7nDkmmglC7Fjn
         x9zp1bZoOs3aZPc/xzRHo1xe5/Boy2qFCDES59TPPbgsyBvFrEtKH6/EjCmncHpxLyzt
         vWQ1a6mIgE9Ja9pW23Kp8exUuRoRHzvHHjWQ2T6tdGB5hq/8RO++JoHU772GavWTJ5L+
         6CBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751064876; x=1751669676;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezLIkR/B4gCsYPXXa9biSbKg2Jc/4U24Spnp0ibhhew=;
        b=EGJi9/vHJjLAPsuRT6nFNvzJn7DVWYYgvJLkDBlFa/e8ZIRPDm5QMFkBzwFH1NZS/o
         pJ4PH+ZgjNawxGoJX5qMoRH0EvOcWnR3F2Mi6e5DESmMrbNO9Vk+1JtoG3J+3uC8M52R
         yGFwNJToyzUWDOlvIQsU+NBP4hMyEghyyJFvqXR+Y5vrxnTJafO+Pk0zDu/FIz4T9L3N
         30cgAMtHzERclpoDjeApwm0ROdw/L5d8ekZ28hTvmoZmL/AMoGrgu12Ye8PkAuXNgwp/
         Z7lNAh528Ci/eAGePYwVL2RicuZN6Nb8F0vxx5i2pHTb9giAXvKqP+gyvMX40aJhyyJp
         YVow==
X-Forwarded-Encrypted: i=1; AJvYcCUT2dgYa/Bl643R5rHZtXgX+sbDOTpUe1xeQOncb5bREbFNgxrYwqjZEHS2f4D4M3ZmQFZAJCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/MWSB0QE3IukOrKmU1kAYYgJx9aJ7F1Q2PV1d+fElwx6I6uw
	y0EIHFhTrrZY2iLRuGfi+CHoW1AFHBWf5O/IhKwAeL4DxQgTZsrV3z3/7WrrkIVqMxg=
X-Gm-Gg: ASbGncu/5FoYiDMzljU9pIl2LNo8U13ZrZJ89AR837r+OB228Dy21DKXCcEDgk4Tj/0
	+1WM82gP2nzJ8edbHmgYEj/x/acDVCORMDoNYUN1WL9IL8xLt3X5SVqrDMowjoHFa5LS5sCLNlq
	Z5rsy1dhnJ6YkKK3l7bMTlOse4PEKT5wyK+hoQwbIRExEYHAM0p3/AJ9FOb1hDu2g/6JwtSCYLw
	LoZvVRH+Nj43g5poX3NVwd9p2OxS8daEyM733K1IiOdQUlOTzFg0Q6ms748ck5TINa/3kZJ1L6G
	ajOTkY7r6vUAAR08rfT2gLtLWSvnzzvjpjlWcSspNGh/KsZh4KLfu80fR7dEAMVla/HnQpNPc2L
	hc+HcQVYfyZdg5Xx4CRbSbvFPMmHXvPc2SQ==
X-Google-Smtp-Source: AGHT+IHG24yLl5SQNV0yWjqNgWw2DnEBveW3OzCoYz2wIZc6UZJL7EmX5svjUuf04sRw+wr9fW6jcg==
X-Received: by 2002:a05:600c:4513:b0:453:590b:d392 with SMTP id 5b1f17b1804b1-4539535e2f7mr3640585e9.2.1751064875674;
        Fri, 27 Jun 2025 15:54:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:eee:e6f:30b9:59a8? ([2a01:e0a:b41:c160:eee:e6f:30b9:59a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f23sm3965413f8f.11.2025.06.27.15.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 15:54:34 -0700 (PDT)
Message-ID: <48ae4097-8c3d-4144-83f0-6ede7d8f9e50@6wind.com>
Date: Sat, 28 Jun 2025 00:54:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] ip6_tunnel: enable to change proto of fb
 tunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250626215919.2825347-1-nicolas.dichtel@6wind.com>
 <20250627152934.6379eefc@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250627152934.6379eefc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 28/06/2025 à 00:29, Jakub Kicinski a écrit :
> On Thu, 26 Jun 2025 23:55:09 +0200 Nicolas Dichtel wrote:
>> I finally checked  all params, let's do this properly (:
> 
> Nice :)
> 
>> -static void ip6_tnl0_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p)
>> +static int ip6_tnl0_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
>> +			   bool strict)
>>  {
>> -	/* for default tnl0 device allow to change only the proto */
>> +	/* For the default ip6tnl0 device, allow changing only the protocol (the
> 
> nit: the "(the" may look better on the next line?
Ok.

> 
>> +	 * IP6_TNL_F_CAP_PER_PACKET flag is set on ip6tnl0, and all other
>> +	 * parameters are 0).
>> +	 */
>> +	if (strict &&
>> +	    (!ipv6_addr_any(&p->laddr) || !ipv6_addr_any(&p->raddr) ||
>> +	     p->flags != t->parms.flags || p->hop_limit || p->encap_limit ||
>> +	     p->flowinfo || p->link || p->fwmark || p->collect_md))
>> +		return -EINVAL;
>> +
>>  	t->parms.proto = p->proto;
>>  	netdev_state_change(t->dev);
>> +	return 0;
>>  }
>>  
>>  static void
>> @@ -1680,7 +1691,7 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
>>  			} else
>>  				t = netdev_priv(dev);
>>  			if (dev == ip6n->fb_tnl_dev)
>> -				ip6_tnl0_update(t, &p1);
>> +				ip6_tnl0_update(t, &p1, false);
>>  			else
>>  				ip6_tnl_update(t, &p1);
>>  		}
>> @@ -2053,8 +2064,31 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
>>  	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
>>  	struct ip_tunnel_encap ipencap;
>>  
>> -	if (dev == ip6n->fb_tnl_dev)
>> -		return -EINVAL;
>> +	if (dev == ip6n->fb_tnl_dev) {
>> +		struct ip6_tnl *t = netdev_priv(ip6n->fb_tnl_dev);
> 
> the compiler complains that t is declared here but not used..
Oops

> 
>> +
>> +		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
>> +			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
>> +			 * let's ignore this flag.
>> +			 */
>> +			ipencap.flags &= ~TUNNEL_ENCAP_FLAG_CSUM6;
>> +			if (memchr_inv(&ipencap, 0, sizeof(ipencap))) {
>> +				NL_SET_ERR_MSG(extack,
>> +					       "Only protocol can be changed for fallback tunnel, not encap params");
>> +				return -EINVAL;
>> +			}
>> +		}
>> +
>> +		ip6_tnl_netlink_parms(data, &p);
>> +		if (ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p,
> 
> .. you probably meant to use it here?
Yes. It was used by the v1.1 :)


Regards,
Nicolas


