Return-Path: <netdev+bounces-157447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6902A0A522
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B5A169355
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225CD1B4237;
	Sat, 11 Jan 2025 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEchh9fq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990E634
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736617971; cv=none; b=uz1CWNLbAcCwU0KrpNJ7q0qAZhxVN6xyJvkIzM7kv4HZg1aAH6OsZ8HTdj56UwNVeroge8FDnoW07H7xCFBFFjJuWqJmHmCovlK9GflJo38URz9o9TMnqJezWd7djaoSGI87BFDtiEOiUvx0kJwnMhqNTnASlg5/r8ukT0Icn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736617971; c=relaxed/simple;
	bh=AyoEIsjkzfJRGi5VoDqUO15IR0a/HN6gQb9yJ5fxKus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2NLsdDfIGRXuSDBTm8HZ3CWUPJVC/OEctsEGrN0nwLVa4TiO3IceoK14tEbz7ox8W3ovQN2w2bGrM2uE4ZCZ64EaRZ/rIK0ZEfsoHGs7g4wBWp+P646V6yfmrkjrj3VJ+Qo+PCoxqHdxOkWtG1y4asbqcdf2s230zLXAayKcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEchh9fq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4368a293339so34909585e9.3
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736617968; x=1737222768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XqZ66yjAE5qhs4GyMsFf3vMGRnI4zBHOdNRhbL33qLM=;
        b=eEchh9fqgURiFAhf7RyMNEP9jnfuc9sPWXMujPatWayIdpmrFB/gAqtKmCNML9SJa9
         U3xcKozfPVGGTdVc5UEGQieLuUNhzN3q5saM9/Y54oBOdSSZmww1D/F8kfHcHYQ46kpy
         HmOOUGjQH4LQ0gMzpC+1PIm1NYI4riNYjXVKDpFfvv0Jh+Bndca0HLEy97lWrVCaUcvj
         mLjB4vZxihauVF5qHWX1EaluNb7P/xeQLuVohnhW3vq+sCw88cxtXUe5MLDA//Pflutw
         Yhapj6CcrOkwyGv5DMlXWlJjmbyjJojRF+3y68Sj25HQLvfKMST8JKxyocJ49vp1bQiv
         Adtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736617968; x=1737222768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqZ66yjAE5qhs4GyMsFf3vMGRnI4zBHOdNRhbL33qLM=;
        b=dxe6DWM10rYDXqmaV+eU3fvv/sJD39O+bseQpVhYsh/M6InfnevKzcEZu4EiuAmFq/
         jXvmy9RbwDv0sk3sN2ozMO4tM/MyYCLvHp47iGYl6/c1cEXuJD9shr4AbwLeH5r0PkCM
         VZWlR9R6o1q1krsqeOJTWrxG8hYmfwQs1cZLdFImjvQx4aOoIpVYl5aPBobALi8Zd5BH
         R0+K/gubGGROikCH9hemHMHLXuz5vGMeSCEIu2CqZR9RqhJN06hnULBSo/S6ilpDpi/H
         cQlgh1UO3RCShcFolw1JzmRBBGYoX3GupBrD83vKjmnhUlTCqJtPgYu8b9ml7uLsYA+w
         xSgw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/3QE4otD9o803mhIxtx0PgyFrBb0MjNK5s3pM2PWamzFcg9Eth9ZLfJzNN/BgNwR4QsZaLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/J1y/cSsNDq+pG/WXg1/JJdhbPtZDj1WL6HWH5w01ZpUYflS7
	lxJQj3ym/UV0udLh7EpXkLNiS2Ia7eRHOjXxJVnF006rE7lFQMr6
X-Gm-Gg: ASbGncs4+qf3KmAtCNbZPvBxQFO1SjYndg3uc5h5BCoBmcXdsPzkoQ3JvWRP70jwOXO
	ECTfHBOj89GzloWmnT+PiYQwNHVqxK52DbtVduDKcwY4qqKfUZTnzhdPmz2jXwAQ7prnzb40VYJ
	nS3Ibolu2+7AiXy1COIXD20Jur82jT+R6kyf5WHeXJXrXJ7yDPOfSI0hh9nCDCAzalg2rEEqDJo
	LM7Vxm21m8UdGd1+JkgQrsc5dSCClnGxDfB9OVWbK7vYH+iNw2yqTEJ5ZSbOuz2gzdeaOFm1LuS
	0LcjBL1EzoiyGjp5Ik2Cc6pEjrX/SDrOiF7dX0w4rzpJn6lIw4fN/EwnZh2f+QWwnW95kO7otvY
	n57j6ZSFqTYR5/0Z8glI+DLrF2GcLRgbxQ2vZr13J5eDADoPa
X-Google-Smtp-Source: AGHT+IHOHlnsiYHW+Nr18ijinAl1O+/7cs54OBDwfzgdPuLsCVOnUsxbMvt7aKPBdnTwZUiBsWiJGg==
X-Received: by 2002:a05:6000:4020:b0:385:e3c1:50d5 with SMTP id ffacd0b85a97d-38a87338fa8mr14933038f8f.48.1736617967562;
        Sat, 11 Jan 2025 09:52:47 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm7899159f8f.13.2025.01.11.09.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 09:52:46 -0800 (PST)
Message-ID: <131dd9af-1fe2-4593-88c9-febd77b54ed1@gmail.com>
Date: Sat, 11 Jan 2025 18:52:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: phy: c45: don't accept disabled EEE
 modes in genphy_c45_ethtool_set_eee
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
 <Z4I4ADNO1nSdZRja@shell.armlinux.org.uk>
 <472f6fe4-18ff-4124-ba43-fd757df7cb4d@gmail.com>
 <Z4JBld9d_UkBgRR4@shell.armlinux.org.uk>
 <0212f9e8-8f60-461b-a7fe-bd4054f3689b@gmail.com>
 <Z4KKi2WxSrben9-Z@shell.armlinux.org.uk>
 <b1d56e22-5bbb-4881-abc1-6f8832bb575d@gmail.com>
 <be4d2a28-3618-451f-ab08-432489360410@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <be4d2a28-3618-451f-ab08-432489360410@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.01.2025 18:31, Andrew Lunn wrote:
>>> I disagree with some of this. Userspace should expect:
>>>
>>> - read current settings
>>> - copy supported modes to advertised modes
>>> - write current settings
>>>
>>> to work. If it fails, then how does ethtool, or even the user, work out
>>> which link modes are actually supported or not.
>>>
>>> If we're introducing a failure on the "disabled" modes, then that is
>>> a user-breaking change, and we need to avoid that. The current code
>>> silently ignored the broken modes, your new code would error out on
>>> the above action - and that's a bug.
>>>
>> OK, then I think what we can/should do:
>> - filter out disabled EEE modes when populating data->supported in
>>   genphy_c45_ethtool_get_eee
>> - silently filter out disabled EEE modes from user space provided
>>   EEE advertisement in genphy_c45_ethtool_set_eee
> 
> Ideally, the kAPI should work just the same as normal advertised
> modes. The read API returns what can actually be used, and write API
> expects a subset of that.
> 
> But maybe we have too much history and cannot enforce the subset
> without regressions, we just silently ignore the extra modes?
> 
> It might be too much plumbing, but it would be nice to include an
> extack saying some modes have been ignored? I _think_ extack can be
> used without an error.
> 
Nice idea, this could be done as a follow-up. I'll have a look into this.

> 	Andrew
> 
Heiner
> 
> 
> 


