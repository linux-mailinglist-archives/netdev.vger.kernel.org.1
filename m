Return-Path: <netdev+bounces-168173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08605A3DDF6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180F13A5C75
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A391D6DA1;
	Thu, 20 Feb 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Bjin4LgY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0571CEACB
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064307; cv=none; b=bKT+Cblm4F5kfl3zt7ln4YVxGC5fwqhd2d/F/KE2DSnNApdbIxXbP9tYq6c7SCwPi8mSN5Cfs26bo00Xj6RufYIEwkrWkgBR3YT5eO46Omc+Oln4VjHNjRaIU2KaE6k3jo9UnMUdAdYFSdt22NELabElsUaGasqXqMiFkCXQlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064307; c=relaxed/simple;
	bh=UxP0RStb+KDvNwHIWQMbqJeu2AyoXitJcLoIYo2flrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLucpq3Z3H8DwqYBGWerkgy3JOtgrzbd7n0n4Od9jmYUDcsBX+SZKwH/3de20FKLZvXDRXsyalTz4yOPwuxNM2xgRMo1l0d0VjnumCNMf77sUAQBAQ+s+ugDY8t1eQaWZkQaRCn01DJPb5S8ZnupjInlbabT/SVk+udmKo9oNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Bjin4LgY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43980f4d969so1553625e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740064304; x=1740669104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GfFrd6cEb38OzQfu+TOg0Pzb0Bby373tmrvPQGkGj9I=;
        b=Bjin4LgY/cqm+OtNyIdqN2kUkra6NmqJOKDlXq/qU3AZWZ6uPoUeenK0pF/5+nrcD0
         hrAwX0whwx11OLnoFInVMILUOcyEfWAq38/TDdzQhl1YYwnc6vD7OfJQ4WKRuYrePc3Q
         AS22oDUUxOaxW9EIaRBQxQUFKWK+hyaEqSX7fRl3PXqTtM69lhCy2UoBIEc4VIoprVoG
         dSo6/wsftuqNvSn+5Ro0M0WoLRF7TaMwqAP8K944CcyWTnlwiEEsnhQisqS+0NvEmxYW
         3V7RfutZlLS8Lj6vIllimEzpIitRwH5xEIKYm93maYYCgSdbf29K1vA+Rg5/fmy1AjuI
         DdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064304; x=1740669104;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfFrd6cEb38OzQfu+TOg0Pzb0Bby373tmrvPQGkGj9I=;
        b=YCDU1LIFfvgRHirx4UPt2mYQ7NsvaBeK0m4gTutVpqgBqjRHXdTq2cDXe2xUTr2vaf
         oHPj7lEUpbol6GWCw9gcF4+C55ltIgBqqIntaI7S61xJmyHwq+Y6s6PynTta6Y0PjBt/
         tAc29b7KKEOhEaApnUN78zRWWJ5/mttc64Bw/QYVRimaQJtpVFhZYUoJgB4+gL0nDIwI
         +IEPWEU60fRQOivcCLy3AFCHEdfVF1S5gVQJAlpLEpgsrAdx5Sx+mgOn6Ft+DbFqCi8F
         nDqfz8Jiz1bVYu/dGvJ4YMYdSXth2G6SpS3bOGC7viuN57tzPB91hjrswfBTCySpyRGE
         VHKw==
X-Forwarded-Encrypted: i=1; AJvYcCV9TyUiFf5aLeGiZgrL/Wi2GycRaASGLGScE5KGaxfApe/seyh3syzymMV9LyXqsFfECYi4Qtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybR1e3NMbkuPsyefZZpbkbPMA3orG6cHpBZO6PWKPWzQ/t/+6D
	BU918cIs+iEYei4K4iS1Fm9nkjF3hkwBwm57r/SrjXpHVRuKR4mGhUdvExO4cWI=
X-Gm-Gg: ASbGncv7iqpamxCDXwOKenZgdSk0N0OAcrU9OUvS+Tr2LL/AAKg7OBFNXtCYLg4Mhv3
	pkRAiGxeVoqc3wpjx6ATPZmACqZiwuWYssJBhwL4Th43NF3W6dyPCfB2bVTby9SQ+O3TOcAit1x
	RBzuxfYzQWjmrS8AtlieGnQnoiNEYglCfQJ8EgJ8FtGZx72nAGCmAZMUli01uBp6FAJkjBdgdNY
	JoNIMXQ5i3YeyiGY8hDOZQ8SIPk3cb7+2lqjXdGLpEH+1TckbjmEMRK5VDyyPySEjGoCKs6NcGJ
	QZEsd/pdemtm5E7A2x+Ln+YFaD7jMRI/ysvLbG+UomzxOJ8zArCFbqBKQBiMQ4sj/F+q
X-Google-Smtp-Source: AGHT+IG2EbNzaujZz4eyoUNNLAj1vxY3df3CDVHy6VjYcq6oRBaI8vCPgKlvs+WLYGLJrd8/s7lK+g==
X-Received: by 2002:a05:600c:4ece:b0:439:a1ce:5669 with SMTP id 5b1f17b1804b1-439a1dd9be3mr15840365e9.5.1740064304336;
        Thu, 20 Feb 2025 07:11:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:eba1:dfab:1772:232d? ([2a01:e0a:b41:c160:eba1:dfab:1772:232d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8730sm21386811f8f.93.2025.02.20.07.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 07:11:43 -0800 (PST)
Message-ID: <99d50d07-34af-4413-9748-5a286e430a3c@6wind.com>
Date: Thu, 20 Feb 2025 16:11:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3 2/2] net: plumb extack in
 __dev_change_net_namespace()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org
References: <20250220130334.3583331-1-nicolas.dichtel@6wind.com>
 <20250220130334.3583331-3-nicolas.dichtel@6wind.com>
 <CANn89iKdYXKqePQ5g5eU9UGuTi4fZaxwWy2BK7D+F2wkQHAXhg@mail.gmail.com>
 <101c5d62-d1e9-4ac4-a254-5aeafeac6033@6wind.com>
 <CANn89iKeTVp456WjapzFz5owvJ-af7EeGP7rB-O9K=GXi0F66Q@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CANn89iKeTVp456WjapzFz5owvJ-af7EeGP7rB-O9K=GXi0F66Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/02/2025 à 14:24, Eric Dumazet a écrit :
> On Thu, Feb 20, 2025 at 2:22 PM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
>>
>> Le 20/02/2025 à 14:17, Eric Dumazet a écrit :
>>> On Thu, Feb 20, 2025 at 2:03 PM Nicolas Dichtel
>>> <nicolas.dichtel@6wind.com> wrote:
>>>>
>>>> It could be hard to understand why the netlink command fails. For example,
>>>> if dev->netns_local is set, the error is "Invalid argument".
>>>>
>>>
>>> After your patch, a new message is : "  "The interface has the 'netns
>>> local' property""
>>>
>>> Honestly, I am not sure we export to user space the concept of 'netns local'
>>>
>>> "This interface netns is not allowed to be changed" or something like that ?
>> Frankly, I was hesitating. I used 'netns local' to ease the link with the new
>> netlink attribute, and with what was displayed by ethtool for a long time.
>> I don't have a strong opinion about this.
> 
> No strong opinion either, I always have been confused by NETNS_LOCAL choice.
Yes, it's not obvious. Maybe it could be renamed before exposing it to userspace
via netlink.
What about 'netns-locked'? Does someone have a better proposal?

