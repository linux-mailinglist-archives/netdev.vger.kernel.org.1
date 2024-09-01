Return-Path: <netdev+bounces-124039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767B596766C
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 14:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068C91F21AC9
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5617BB2F;
	Sun,  1 Sep 2024 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="SkarvkC0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62A170A3E
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725193564; cv=none; b=gy4r5tTNtNShEgHH8MZzQubjI4+Df79rhig4zALy2Ji8vvIDODmgHdkbDGKppLoGU86mp91cG1SLTs64jR4blJqt3Sgb/fLKE7O/hBUywviXqsCiTy7FMQpWcUitTnJI2ZmIIMshP4Rg3uEEQTfbmCXvenPmQ0wZJz0GZdyAoAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725193564; c=relaxed/simple;
	bh=wtMT4yjp2oCqRnV+gaEXldV84VXjgrC9Jt9aFVNCYFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDh/7WsdR5lHW/4nPrIuvGY7nbyRj4s7/rSzSz1eavwq4KtB5ljRnxAoPc3D/upam5bIbeAIfpfy1OEE94JDrNgRi6p9KZMVxPplqI18IFeGbkSmYt2ZhLlnUHjAh0M3Z8z0c+cKK5iyY0zSSth0RQtGCFUeFgR1nCE2FXovz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=SkarvkC0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bbd16fcf2so18507345e9.2
        for <netdev@vger.kernel.org>; Sun, 01 Sep 2024 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1725193559; x=1725798359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfjzMYPGdun4Uqh5AlSSekgDXw7dnEtWbRrdOH2n9uk=;
        b=SkarvkC0mDUz9+HGv2tOj27ljpEA7qYag3Rn0ZD0EIvNW38aho88Lnx31zEoslpGij
         3RCTfYwEakqukoRe7T1aZsn4uaqqbSeUE+l7C7v+wxJHBkbxyryuHnOwFYpTS71Hm26F
         1gBorMpLZqEutcrixRFzqY4i5RBSapT8RKkQOZ70YpylVpROYmAN5XCRFweb7v5stZL9
         n+99Kmd4wlpzC6MQn9gpheQ6ff+398o0OnD1+9lYFGVDvwZNgtxEUsTY7e0k9k1CWhSd
         dTeSRaFEG33bTua+K1ifJ5qqf44o2EwyDaKLuGxRZbYCPjYwslpGubta+rp8udjK+YrU
         7u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725193559; x=1725798359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfjzMYPGdun4Uqh5AlSSekgDXw7dnEtWbRrdOH2n9uk=;
        b=Ia6MU4dhlqoLVWyP4M3uOIQChlB681+slp746cG2w35eaom1gQlyPrzFjNnXvRverh
         Zw2/yfhSwdao9D+94wtgXKtLrGL9O8v2Isc2BFrl3bQJNtdW6XCvWgvnNahmYBIfmEkX
         EOo7pgq94nIrNdT72TRaTy6WFTS2VUivIAXCmzW8wFQMDh8XYQY6blmveDT28MkrnYHL
         xUQcxvlaO3MlcO3Z8tunHtmObNtk+4AlFtN9u75zoCHVaM4kDj8KfkVz/m/D6MJH5Z4c
         SoB25gZyh3PPr0ZOeW201CLcI8mXPvX551MSIfif20TZnOPEkd8bEaFDNVnzoPtwnv4O
         zXuA==
X-Forwarded-Encrypted: i=1; AJvYcCVLKcrKnQXFc5KG6mEYODrJFbUqH6hurdzOq5s2DHwMWMVO91jWLh4GZ6raCL+kNc+rRufCiTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cAGQBkvGhLCqRr+Hnms6EDCw4ExgVqgXIp5t9wSawNtSkU6K
	SwyDZ6p+umU8HODbppecB0K4Z2oD5tnAdpX/zit/e4HhEMf+OQmHc/JDOtnCDsw=
X-Google-Smtp-Source: AGHT+IFgUHyK/pnm+W9GRkV0kVurfeuGhFREN8PAh+L+WvmoxGLNk63wM861YFkf2tKhoDOhKQZzbw==
X-Received: by 2002:a05:600c:4585:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42bb01bfbdemr92680295e9.18.1725193558756;
        Sun, 01 Sep 2024 05:25:58 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4ddc8sm8819598f8f.21.2024.09.01.05.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 05:25:58 -0700 (PDT)
Message-ID: <003f02c3-33e0-4f02-8f24-82f7ed47db4c@blackwall.org>
Date: Sun, 1 Sep 2024 15:25:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: allow users setting EXT_LEARN for user
 FDB entries
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jonas Gorski <jonas.gorski@bisdn.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Petr Machata <petrm@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830145356.102951-1-jonas.gorski@bisdn.de>
 <b0544c31-cf64-41c7-8118-a8b504a982d1@blackwall.org>
 <ZtRWACsOAnha75Ef@shredder.mtl.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZtRWACsOAnha75Ef@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2024 14:54, Ido Schimmel wrote:
> On Sat, Aug 31, 2024 at 11:31:50AM +0300, Nikolay Aleksandrov wrote:
>> On 30/08/2024 17:53, Jonas Gorski wrote:
>>> When userspace wants to take over a fdb entry by setting it as
>>> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
>>> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
>>>
>>> If the bridge updates the entry later because its port changed, we clear
>>> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
>>> flag set.
>>>
>>> If userspace then wants to take over the entry again,
>>> br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
>>> setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
>>> update:
>>>
>>>    if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>>>            /* Refresh entry */
>>>            fdb->used = jiffies;
>>>    } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>>>            /* Take over SW learned entry */
>>>            set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
>>>            modified = true;
>>>    }
>>>
>>> Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LEARN
>>> by also allowing it if swdev_notify is true, which it will only be for
>>> user initiated updates.
>>>
>>> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
>>> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
>>> ---
>>>  net/bridge/br_fdb.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>>> index c77591e63841..c5d9ae13a6fb 100644
>>> --- a/net/bridge/br_fdb.c
>>> +++ b/net/bridge/br_fdb.c
>>> @@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>>>  		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>>>  			/* Refresh entry */
>>>  			fdb->used = jiffies;
>>> -		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>>> +		} else if (swdev_notify ||
>>> +			   !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>>>  			/* Take over SW learned entry */
>>>  			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
>>>  			modified = true;
>>
>> This literally means if added_by_user || !added_by_user, so you can probably
>> rewrite that whole block to be more straight-forward with test_and_set_bit -
>> if it was already set then refresh, if it wasn't modified = true
> 
> Hi Nik,
> 
> You mean like this [1]?
> I deleted the comment about "SW learned entry" since "extern_learn" flag
> not being set does not necessarily mean the entry was learned by SW.
> 
> [1]
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index c77591e63841..ad7a42b505ef 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>                         modified = true;
>                 }
>  
> -               if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> +               if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>                         /* Refresh entry */
>                         fdb->used = jiffies;
> -               } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> -                       /* Take over SW learned entry */
> -                       set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> +               } else {
>                         modified = true;
>                 }

Yeah, that's exactly what I meant. Since the added_by_user condition becomes
redundant we can just drop it.



