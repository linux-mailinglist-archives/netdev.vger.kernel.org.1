Return-Path: <netdev+bounces-207480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D6B07818
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DABA41E8C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41609263F5E;
	Wed, 16 Jul 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfowqy7L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E0262FF8;
	Wed, 16 Jul 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676200; cv=none; b=Vd+r2AiNtOqZXL/vzImhhHyfViPPokP05osFD36dv2YDrNYRnYp961C1KmAvQaXROFkC+KDXt81j/IADz2Jw+4kXef7jklw3hMuFd7ZmnEfVomLGJb9yhkd1qBOXfCeJXuBXh7ynJ1o2TEX61RWKxLisKWBlA338Dg501WSBo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676200; c=relaxed/simple;
	bh=R3X47Anq6N11xoa48VLLuGRxi8pi4MkwN/qO2tgC6wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MeRmhfIIsn5buRp5NLWrTjmYnyoGJ2IFmjdOHGhBbpROQa6/33L7JfLz/SYONaBT3NFwqDomC93dG7P76hoHZPw92NSORmrAT7kNmjQymYu7/4klfwThhx5sof574GkHOKZmQZ3dWaD9H5ST8RabpI9gfbbQW8HjechStILGXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfowqy7L; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e75668006b9so6767261276.3;
        Wed, 16 Jul 2025 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676196; x=1753280996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GncqGP7goJeoYVJ46y/gd3Gd5COzdFRWNNvDrQIFaFQ=;
        b=cfowqy7Lu7qOIrlsx1qSyVGf9S9xOcvV4qkoXLc/g3tgDe5MOIFdF09Qrr43nSV4IW
         ybaQx/7rJGEmOv4jW5It2StRTxxjnsJsosBt239p0gl/XOfN+nkzwdSQq6wZR+3khSf/
         d4B6R0bLG8vPJesS5OHFuvRiSzGqotGaRpkSdCSByhNJVrcDoMNKBpfdmBL+ZDjmMW5v
         vvvBGhSSKpYBar5gBqrMrfss++FjyUXjfqGVn7NPPa5we0aKWG5jkBh42Wl7VL3aHvFg
         0j8mqsNjPHYo4czncKD8xoWon/RNXVr4SRHgoJXn/5X0EcV3naUcIWFLAsGEa8RY+IYD
         e4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676196; x=1753280996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GncqGP7goJeoYVJ46y/gd3Gd5COzdFRWNNvDrQIFaFQ=;
        b=NkQ3Rdiqgsue3C88xz+UceRN3HvxzogxYeeLMniKpooh6lCTJnNexdr+NRT2Wt/viR
         j3+TdfS+3rosoqGNOBAlkUZ1f8OYkZa/GmTCF++4riTvKQ7H+lK8OAPlBIKY7+u+Bzbp
         c8nn2QNC4lpYVretnOz5+qSNFQJp3/AxYHR8HAmqf4IwloLhP8bKxHjxJlpuUkcjaI9h
         0LzFWfHJlI6g6uXeHR4/B3/Sd/c3Acfbfadu9bUe845zK7tSnqxMX21SIl7k2If6tQWF
         GXuaVo2mLsatfBKblJugPhhIXbLvpMBUw3eeXfgVVPACKi9zBghole6GCNWDS0DjIVKb
         EDhA==
X-Forwarded-Encrypted: i=1; AJvYcCVVLctc7TPlNyyxQLwDvc30ai0Qb8k+dq/cqXuDxGqBGI5C/v2mENAtfP3ZALXmQMs6jy+iJ9DgnD6gMo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy72245e26T7OhAyeFjG4QN1zv4f8oLzNatZNOExWERfdy0/i6
	RHxy/eKqWKCZwibZBZFc9KiBtv3c7eXZu7j8Ag7SkUEafFS8okCLxIQZ
X-Gm-Gg: ASbGncvEDXlXcFdqv8yY8gPfC8EvSbyRZYEuEQ3dUSydF176JqaYnwMV4Hf4nPH1Qlc
	pcVIic0QnONyLmfKuR4/d/j9YxmRnbOiax4cMX0qwrgcDCQgYfLtG0XTz/v57UNzP2bcM395Prl
	40JU7joCMhAytwT5A8VAHKB2dFF6KYOrY9htoZ3i/Pth0O+4J3aF/leCWyiJJNkSONtkwo1MpZ6
	Wei97WtXRQBhvNkLXhrBooYRCF70nIa4Vq89I2PRDihdSXeC/lg8eeJQ7Jr7g8tUAiIN0UjhJLq
	8gKknNhAynclpQeVM+NOsw7j7SKHexLm//1135vfFfmnUP48kobFu6WHugld3I5FCgD15wk+vP3
	OqAOzxSjrGqSo7ULNiiACAH7VApfHmHKr2Imk0BfQwZCH
X-Google-Smtp-Source: AGHT+IECZdXPUbZpvN2ZpX2PO+J3L3S4jMhg72Pi4l759WXRROZYGicT98mbxgDJQAus/1z4edwLdw==
X-Received: by 2002:a05:690c:6f82:b0:718:4511:e173 with SMTP id 00721157ae682-7184512026dmr7358367b3.12.1752676196435;
        Wed, 16 Jul 2025 07:29:56 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d734casm29278127b3.31.2025.07.16.07.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:29:56 -0700 (PDT)
Message-ID: <67753866-5237-4758-9bf3-d6a8611ac179@gmail.com>
Date: Wed, 16 Jul 2025 10:29:55 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: bridge: Do not offload IGMP/MLD messages
To: Ido Schimmel <idosch@nvidia.com>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250714150101.1168368-1-Joseph.Huang@garmin.com>
 <aHdF-1uIp75pqfSG@shredder>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <aHdF-1uIp75pqfSG@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/2025 2:26 AM, Ido Schimmel wrote:
> On Mon, Jul 14, 2025 at 11:01:00AM -0400, Joseph Huang wrote:
>> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
>> being unintentionally flooded to Hosts. Instead, let the bridge decide
>> where to send these IGMP/MLD messages.
>>
>> Consider the case where the local host is sending out reports in response
>> to a remote querier like the following:
>>
>>         mcast-listener-process (IP_ADD_MEMBERSHIP)
>>            \
>>            br0
>>           /   \
>>        swp1   swp2
>>          |     |
>>    QUERIER     SOME-OTHER-HOST
>>
>> In the above setup, br0 will want to br_forward() reports for
>> mcast-listener-process's group(s) via swp1 to QUERIER; but since the
>> source hwdom is 0, the report is eligible for tx offloading, and is
>> flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
>> well. (Example and illustration provided by Tobias.)
>>
>> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
>> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> 
> I don't have personal experience with this offload, but it makes sense
> to not offload the replication of control packets to the underlying
> device and instead let the CPU handle it. These shouldn't be sent at an
> high rate anyway.
> 
> 
> I think you can just early return if the packet is IGMP/MLD. Something
> like:
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..9a910cf0256e 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>   	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
>   		return false;
>   
> +	if (br_multicast_igmp_type(skb))
> +		return false;
> +
>   	return (p->flags & BR_TX_FWD_OFFLOAD) &&
>   	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
>   }

Talking about these packets being low rate, should I add unlikely() like so:

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 95d7355a0407..9a910cf0256e 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const 
struct net_bridge_port *p,
   	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
   		return false;

+	if (unlikely(br_multicast_igmp_type(skb)))
+		return false;
+
   	return (p->flags & BR_TX_FWD_OFFLOAD) &&
   	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
   }

Thanks,
Joseph

