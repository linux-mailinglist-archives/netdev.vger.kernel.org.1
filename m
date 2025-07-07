Return-Path: <netdev+bounces-204644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A41AFB8FF
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01537AF8BD
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34B622A7FC;
	Mon,  7 Jul 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxaJEAvc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8DD224B0E;
	Mon,  7 Jul 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906982; cv=none; b=kxyVB9ZpPaXsewjIa+qbOP/1jPgBBtN8quix40p9OanKazqTa+KRHM2wtYnDClzR5n7LjcIas40pB/hS+Lu65i2SewU4CBKjjTiwHo70cy6tU/GxCGAdOVZr3V7ipRoBv77k5iQ7meO0LoAg8+5EKjj7t1Pd+jVmYDPUh8ZkQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906982; c=relaxed/simple;
	bh=2qpWdHuWmXVbwdu0z0dszit3gKd+4ot0FUdDS48fSgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MppshHmWUOlCjZUM70nG6o0gkjk1oEEE1EAM/xkKEKL6Dmc+6iLYBaPx7NA3uwfMOvD4l76UBCMWJb1OluAPvywmj+gzTrs2k/Gz+dWGHV4p+HwxU6qt5zJOn3JmtY2VD1MhNKmuyUXY56sLhsVVIM11T5VBBO33AIlYkit1HaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxaJEAvc; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e8b3cc05665so1468358276.2;
        Mon, 07 Jul 2025 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906980; x=1752511780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1xOWZOyoPm540GobFdkxEMray8IVt4E7vfdVGtWbcI=;
        b=SxaJEAvcODg8FPB0/uuvtexW/OFfPehlsOjPdiW19C41zKOnu+FNFEEbV6+W77rEqY
         f3gk/RuPK8jmEyYg/ptLDfzxH9BaKBALv8aop4cgMoGuW3DV3rTCXDJfFIC2CkmkNSWL
         L5TQwoDRPDEHpfkmWFNaNOEan08HAZo4eWU8ZSj+lSvAurmsMuFQPSAjK2FNCs09clvb
         17t5LpA3HLMA1dqGo77fMkrAjNXG1B1B1GGz4QGWwH6AGHXq+cagJg2OxXOnT8ARHx73
         SN2NMAtsBIZvc8JGTG7hkp1Mrh3mWSEquYie4cs0irbUgSeIn2T5HAgCvfFcQWdabEGx
         xLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906980; x=1752511780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1xOWZOyoPm540GobFdkxEMray8IVt4E7vfdVGtWbcI=;
        b=DKmR7Dd1+Jg6QusXu4SHqIxOE98JDVsT31OZO56PCNQ9cqQf0G1pOC0YsKrsOUfOFv
         jMN/10+CFhSPArPj8P0K2FNKn8ggayAE2uu+XdKBPYTCPdvXQ0fzqlo7JjKOclcELXoO
         K63uu+2QiO+WcOxTIHI4tiUe8TAFcurwguD5iR8dIowEMzvvY8RJPpn027D06nOZmmTM
         GPrA9Pg7IYq3780/Wnvm/OgHjEgPHRxAexmm0elV9ZcThrpiR+arSTgVr/HpdHfgrJJC
         N0lHW2biwWyWPyceeOyDC+aGZyRm7XWwlmse69w1jWtiWBB7lFoDWFZlWUb4z3IBfu14
         NPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/iUJgghUHUvR/fsBYlnDkEk1cfAP31exKYjc5POj2CmM/a2WBXSnpMb4uOAaxjPQTQc+aHzf4ekVhpec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9rt3qw1eeKcTc2Rs6pDPdsACZRPkOa0HgGMiS73vKOK7d0WHc
	Jv04Z5wDcthVUTIXa4ygBGhGqr6GYS9RsoWbcewwCqARYMEvhEQHR+Q5
X-Gm-Gg: ASbGncv3mOhEE+OFvvijW9wmpE0TGq9b3wqIVn58H8JZQXenxePqRdPpVR6NK0e3g4Y
	AUa+W7bVcOSO6Hayto5N/LZjveLUHH3fSlmjqDzxOvrZn7rhXZ39Ni7C5oyHlWMUh9Ea/cf/EhE
	dKYHVYMY6+BYuCA8dvN8xR+gOOtENRW+wjHqh/XfMGmK5SNRzl2uQj4it49nrc5L+C6djFJQzqJ
	vVJY5pinZH0jwXahPyERuAY70o9YkgC/cPczMvZqaQaN2pBw2RWFieBTmZA9g0xWQ9lKXI5RroW
	fIGw9pD7sIGQGJCzwuumV6hcDPuy7hkOn3YnAbY/f9MqZZmgaIdn9xdzsMkkcKxg7tL1EV2NSGy
	iX5gPBg2O
X-Google-Smtp-Source: AGHT+IEb39Z0BOySPnuTvXs3SmBQemC+SyqVyRj1OliqOspcPBmsWCNbNxGyQ9B5BaQfJESFgNSDTw==
X-Received: by 2002:a05:690c:6082:b0:70e:2c7f:2ed4 with SMTP id 00721157ae682-71668b45afamr187921317b3.0.1751906979843;
        Mon, 07 Jul 2025 09:49:39 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665b12c7dsm17204217b3.93.2025.07.07.09.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 09:49:39 -0700 (PDT)
Message-ID: <4998a14e-f755-44a2-b5c3-f966056acb1d@gmail.com>
Date: Mon, 7 Jul 2025 12:49:39 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Do not offload IGMP/MLD messages
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250701193639.836027-1-Joseph.Huang@garmin.com>
 <20250707130052.wwd7e6fenp7imvy7@skbuf>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20250707130052.wwd7e6fenp7imvy7@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/2025 9:00 AM, Vladimir Oltean wrote:
> Hi Joseph,
> 
> On Tue, Jul 01, 2025 at 03:36:38PM -0400, Joseph Huang wrote:
>> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
>> being unintentionally flooded to Hosts. Instead, let the bridge decide
>> where to send these IGMP/MLD messages.
>> 
>> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
>> ---
>>  net/bridge/br_switchdev.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>> index 95d7355a0407..757c34bf5931 100644
>> --- a/net/bridge/br_switchdev.c
>> +++ b/net/bridge/br_switchdev.c
>> @@ -18,7 +18,8 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>>                 return false;
>> 
>>         return (p->flags & BR_TX_FWD_OFFLOAD) &&
>> -              (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
>> +              (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom) &&
>> +              !br_multicast_igmp_type(skb);
>>  }
>> 
>>  bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
>> --
>> 2.49.0
>>
> 
> Can you please incorporate the extra clarifications made to Tobias in
> the commit message? They provide valuable background.

Will do.

> 
> Also, keeping in mind I have no experience with IGMP/MLD snooping:
> aren't there IGMP/MLD messages which should be delivered to all hosts?
> Are you looking for BR_INPUT_SKB_CB_MROUTERS_ONLY(skb) as a substitute
> to br_multicast_igmp_type() instead?
> 

Yes, there are messages which should be delivered to all hosts, but if 
we offload these messages, we're at the mercy of the multicast_flood 
setting on each port and whether or not 224.0.0.1/ff02::1 are "known" 
multicast groups. (There's a discrepancy between the bridge and DSA 
subsystem on how 224.0.0.1/ff02::1 groups are handled.)

Group Specific Queries might be the only ones which are safe to offload 
regardless of what multicast_flood setting is, but I don't think the 
bridge has a flag specifically for those.

Thanks,
Joseph

