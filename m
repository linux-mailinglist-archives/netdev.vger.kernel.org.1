Return-Path: <netdev+bounces-165231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C227CA31258
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760D83A508D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6949262149;
	Tue, 11 Feb 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="OjLotQ+E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3F1DB34B
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293373; cv=none; b=ajpFvv/atZUX5JFjsA9/kE7NDGhzdUzJ/O4yi6wYjbWTEayMVA5IscgbKvYoQ9Ex2+wer/vH7dOrB3KU218m9mDRU4fd5MyfR4Z205WRdvmsdKaaHJ95BDlaIaGC/Ug7lL5b1lp0Kjl/LlxCA2VrzAK+t37yx2rt2umQvirMe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293373; c=relaxed/simple;
	bh=cl5VRTIaQVhnhX7Mp5CHjRfQCdJZoCwXZgpTFNL919I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8BnHYF5/c1JnrA30Pv5pqRKlHw0xnVyjL1fppfhXloffcw9+eIXHyKxDAkq9yCZyJfaaTpz7WJWXTSeCaSYeURz3emID6ceWDl0jqYG3R+5Lkc25oSj9Gb4zGBG4XlTLGn9g5uehBoalJXJAlJgY7l4SlMMCdbOzE5f2tYjiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=OjLotQ+E; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab744d5e567so1127974466b.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739293369; x=1739898169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/56BFQCA/x0+5Zxz4AvQg+9pW1+xObkEyrqUGNwQiI=;
        b=OjLotQ+EkgIV5vISUancQJtc0eeKOZMXVXSwgZe1m02PQqh3xxy0+mjYejvNijgYIV
         HXVtilq0D0SNYs8MA+VdjeVP1kmJ7sbs2MMPHKGHTwvrLKPnQXdAujeq1TBvdzIMzXLT
         W39uk+w4ZO8v5FCohIufqK28hcPTo3akvGGxH4c+39LgmS6HAMvJ5Rve8ep9cmIdjfVJ
         Zui4M562F11y15q9kICaksgfb6p+Br1A1Ue0kyW37GS8ZTkTdeTHmQjGs/mKTM8reVUY
         GWFxw+Jvw4ae1cS8RUVunFgMHKQvuBZv8n8AMfMMBY3MR8YR1nGIBRWbB+NYognomjUa
         JYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739293369; x=1739898169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/56BFQCA/x0+5Zxz4AvQg+9pW1+xObkEyrqUGNwQiI=;
        b=b/lIJDZ1E0k6UOHIN6hF1MktQQzFUdcyrbMj+HmHoaqGhFpM62xMs+p6Ax0ULHx7G8
         5GXtfKj5ClllO3LriGXMrs4KqkLf5+M5gqCgfuD541sljZBrJss34BwVjSSspuz4N7hK
         vZ6Bt+/7jojZ0q+WGy2ngCy20LuWZvvz4hko5lc5WuWNfQMjGb4gKFYja3SltMPmrbOo
         LG8AcYy64UHtO7DyJCJKFzZwAbVIibiQzpnZpTzSCrtbfLQ+sbalM7aay3ppEfR7Q5nP
         UC7L2BuKB6c3kJxyP1BNsazTTzz/mfP+i7dkOG2qU6vo2BphQI8Pp44ixfQjvPLNZW/W
         y7+g==
X-Forwarded-Encrypted: i=1; AJvYcCVWgMnvyYh4cKPbwPE9hXevI6naPq3vzwMWCQrJn6wJs8LqGAAE0jrqi+kQDn1BOnNJY/CTQjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoB7NANCw42Il97Apo5XOIxkRyseHHCX9rZjp174kAq8kzDn03
	JaHNeSSSPcnNTmwOqc3QGGYfAEPIO3kDxyJ95lcA9kzx7wEnW8/dJ+FqN3Qu0Ws=
X-Gm-Gg: ASbGncsOeE7GDFbT08Dz5R+ODN5Z+NVY4Ske2LIOTTYsUVtNR0wY9iP8g9//AWd8eYX
	he+lEcaXX8PYRzYEHQMRaMDs/WEwn0cQjQjsNYpGsc9Er/j7n+VPZe5MMK+RV9EYZPcxxedFL6R
	CC0XAGSfk4O7h2NvInJuj+jr/s7z3ZY6u+ZfdgryovvTnjHVIp/9W7ogE3R+hSOg9zpyWWVqx8v
	nq6lG/2VaUCKEiwbTdahuc0pA5PgAveXE9okjko3YY6vuJLNl1oV5xV3DvDqS0k2F3X+i0m/7M1
	u6q1AsZtcUwvwUvL5Dhn/BJJ2EX4uuI5RzIruIIlgKSIIY4=
X-Google-Smtp-Source: AGHT+IGAPbzjetBMyKn9xpkEx6mNiLaz6Iu+7FJStrC2CQYkHtGpuLCTUuKU+eMJA/ubyZG+xRvimw==
X-Received: by 2002:a17:907:7fac:b0:ab7:cd14:2472 with SMTP id a640c23a62f3a-ab7dafca27emr340636066b.23.1739293367291;
        Tue, 11 Feb 2025 09:02:47 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b4e96185sm543848166b.86.2025.02.11.09.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 09:02:46 -0800 (PST)
Message-ID: <2609939e-fce9-42ff-93ee-890598437f25@blackwall.org>
Date: Tue, 11 Feb 2025 19:02:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 05/14] bridge: Add filling forward path from
 port to port
To: Eric Woudstra <ericwouds@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250209111034.241571-1-ericwouds@gmail.com>
 <20250209111034.241571-6-ericwouds@gmail.com>
 <20250211132832.aiy6ocvqppoqkd65@skbuf>
 <91d709aa-2414-4fb4-b3e1-94e0e330d33c@blackwall.org>
 <1aa60578-ba4c-458b-b020-cff59b119bdc@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <1aa60578-ba4c-458b-b020-cff59b119bdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 18:35, Eric Woudstra wrote:
> 
> 
> On 2/11/25 5:00 PM, Nikolay Aleksandrov wrote:
>> On 2/11/25 15:28, Vladimir Oltean wrote:
>>> On Sun, Feb 09, 2025 at 12:10:25PM +0100, Eric Woudstra wrote:
>>>> @@ -1453,7 +1454,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
>>>>  	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
>>>>  		return;
>>>>  
>>>> -	vg = br_vlan_group(br);
>>>> +	if (p)
>>>> +		vg = nbp_vlan_group(p);
>>>> +	else
>>>> +		vg = br_vlan_group(br);
>>>>  
>>>>  	if (idx >= 0 &&
>>>>  	    ctx->vlan[idx].proto == br->vlan_proto) {
>>>
>>> I think the original usage of br_vlan_group() here was incorrect, and so
>>> is the new usage of nbp_vlan_group(). They should be br_vlan_group_rcu()
>>> and nbp_vlan_group_rcu().
>>>
>>
>> Oops, right. Nice catch!
>>
> 
> Hi Nikolay,
> 
> I gather that I can include your Acked-by also in the corrected patch.
> 

Yes, thanks.


