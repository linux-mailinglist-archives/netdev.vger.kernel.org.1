Return-Path: <netdev+bounces-235752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F418C34DB2
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 10:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBFC5672BA
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 09:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E266D2FD1CA;
	Wed,  5 Nov 2025 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bB6PrvHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCAA2FC871
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334764; cv=none; b=djajWUjDTTfYRBB2exptVMOQf2sycnRw3oYsoz1mSXgYpWBBb7Qx7aYWP9k9wAi9PrrnOxLMkTW9x1t0TWreu+nhHQ/Sk1Hn1RyYPUVZcX+e1SEzAVcbw0WIqJoTFs3rMzkejzeS/wVSiqWuCbpBrtij/qhxBquTvC7MFz7fAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334764; c=relaxed/simple;
	bh=GqMkXKsGqN0+Gqq4C/IHZLpfl50dHLp5chkEPgO7Rxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1D1FZxHwd2wQEmFeVFpbW1ETRnz8gibP0OLs3XqaJHbnGjvXSlbbgw4uVIl1DwsvepqEyQvJ1DMukw1Jxps79i5xgFlWqI6LntJ5fWEALi49bU8bgtQBF/sLZ/BGNcydcHt/hFqkTSiMQ2RCWtTQQsgeo8SV++i2SdMf4q7SlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bB6PrvHd; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so967187966b.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 01:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762334761; x=1762939561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIcShUHghIbttH+Fiw9oOghCKixyC+FkGCQ9kttXoaU=;
        b=bB6PrvHdGQBpqrlkV3craeEwl9I5vBjvsFkYC0wKmlPft1y1X9vEkw1a3+7IXnGzgU
         +0lsy7KioMXqadLDeVkRLhx4Azeb73GXvwM30ouOhBznpWm7pZ0eXg4vme0aYMbVN7AS
         zc9YHvGgYCOYM3xmB3QfOiZZ7smDyCjdtf0yvE9MYKY5QeUcaUvgy/8D9Lg+tMLBQ+G+
         WIal0qRTxWlTxwwpk+93V5GTsu92wF6yy+eXqgvSjDVKObP1//71HtxogdOs25XsWonU
         Oxy+45JjIS8D6vIs/5/CXTpoDvTT9sAFMq6L2WDZn9XS7sH0o3a/KV5nYU7iOtDCJ1Zg
         Ir4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334761; x=1762939561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIcShUHghIbttH+Fiw9oOghCKixyC+FkGCQ9kttXoaU=;
        b=KLQq40xaeZ7ELSU601CLTB32IXY0pB+Y55Bw3IUNc+2M/vWUdxUa/3o/8WbeGlVpEX
         QVqg2fGi3cSjX/RjN/vypA/ABUi3o5HqN2H4DkJPrFP/zHEuknz3GpMXILh8fPsGUD6D
         3Gpm0gHiakQiO1dFEXa3ASB46RHhL1OHpqKIl20Q4Z71U9RaOP3tQfiSddp7bnZtLeJh
         A3RxRb96UII4IMoJJNCC09AUhh87vWM//Q5bkx0JjlkUQKQciNnX/B3GizngDpAMpWMT
         8W6rWvtX1Soc7Ldcn8Oec+QXwZwcabCgsKiY4d1exDF0+y+nLl+IjI27ZOQeqyq6DiO8
         bNKw==
X-Gm-Message-State: AOJu0YyUR7ZYLeXEMBn0OZaRm4FHqP9gtavppBgP5OqrHkC+p8tpH8ZU
	Ha3j/YonNTuoMpcwLqWtk9kXxh0rbzPV37Ug3wosz0LJlntTVrNHNb2DKBBl+anSj2E=
X-Gm-Gg: ASbGncsog3n7dZlilRSGNoO7HhuapFXzCuSIMA3t7RBiE+CdXueMI5RqXX/zLF7S5X0
	DxPS+fWi5JEoSf8fxuBVFe46yxJCPYu4FHJWU0zMwrr5/r5Q4jDUwcVOsIa35wP0FIGsEkjDDbS
	1jO+DZorzvBAvJFkGZY3W0S3IjNLVXIi1kf/dQI0KAGwHMe8zTyvD8jlhvYnXFTRz/ybSxcjrna
	3+Atp2VVJZiD7ZHSeSmSVXlEXO0athBf2bMxCtCbyyc2fkx5is8r0pefdZTHpkLCFQFTj6bZs+d
	CSdDqmzM0kbyP1yW2+vzQZ695Dy4iaUkkrSXq3kXML/Jss53XJWCORLn/Rh0aGrxkKjlqCH7K8D
	rnyvYfLHPqGK5pr+1eW262KdZ/kERTh7NKXYxAE4UrDEpzsXMwc0rhtKzhNSYY+rhpNCsy+e/BK
	0nIxiFRUJ0sssLMV0IDf8c02kaOx/Wqkl2
X-Google-Smtp-Source: AGHT+IEwYWQoAgzR7tSa/a29/LZCHC7aXdNluYiG6IxOdndYNsK3NBgggmlX+oT+UtRAQmQ7/BkElw==
X-Received: by 2002:a17:907:72c6:b0:b70:b4db:ae83 with SMTP id a640c23a62f3a-b7265605335mr232961466b.60.1762334760889;
        Wed, 05 Nov 2025 01:26:00 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3d4asm438406266b.2.2025.11.05.01.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:26:00 -0800 (PST)
Message-ID: <db8450b0-35bb-485d-af33-3ed32a9e0845@blackwall.org>
Date: Wed, 5 Nov 2025 11:25:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bridge: fix use-after-free due to MST port
 state bypass
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, kuba@kernel.org,
 davem@davemloft.net, bridge@lists.linux.dev, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org,
 syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
References: <20251104120313.1306566-1-razor@blackwall.org>
 <20251104120313.1306566-2-razor@blackwall.org> <aQsOUyVTGCD4Tpkb@shredder>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aQsOUyVTGCD4Tpkb@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 10:44, Ido Schimmel wrote:
> On Tue, Nov 04, 2025 at 02:03:12PM +0200, Nikolay Aleksandrov wrote:
>> syzbot reported[1] a use-after-free when deleting an expired fdb. It is
>> due to a race condition between learning still happening and a port being
>> deleted, after all its fdbs have been flushed. The port's state has been
>> toggled to disabled so no learning should happen at that time, but if we
>> have MST enabled, it will bypass the port's state, that together with VLAN
>> filtering disabled can lead to fdb learning at a time when it shouldn't
>> happen while the port is being deleted. VLAN filtering must be disabled
>> because we flush the port VLANs when it's being deleted which will stop
>> learning. This fix avoids adding more checks in the fast-path and instead
>> toggles the MST static branch when changing VLAN filtering which
>> effectively disables MST when VLAN filtering gets disabled, and re-enables
>> it when VLAN filtering is enabled && MST is enabled as well.
>>
>> [1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be
> 
> Nice analysis!
> 
>>
>> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
>> Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>> Initially I did look into moving the rx handler
>> registration/unregistration but that is much more difficult and
>> error-prone. This solution seems like the cleanest approach that doesn't
>> affect the fast-path.
>>
>>  net/bridge/br_mst.c     | 18 +++++++++++++-----
>>  net/bridge/br_private.h |  5 +++++
>>  net/bridge/br_vlan.c    |  1 +
>>  3 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
>> index 3f24b4ee49c2..4abf8551290f 100644
>> --- a/net/bridge/br_mst.c
>> +++ b/net/bridge/br_mst.c
>> @@ -194,6 +194,18 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v)
>>  		v->state = v->port->state;
>>  }
>>  
>> +void br_mst_static_branch_toggle(struct net_bridge *br)
>> +{
>> +	/* enable the branch only if both VLAN filtering and MST are enabled
>> +	 * otherwise port state bypass can lead to learning race conditions
>> +	 */
>> +	if (br_opt_get(br, BROPT_VLAN_ENABLED) &&
>> +	    br_opt_get(br, BROPT_MST_ENABLED))
>> +		static_branch_enable(&br_mst_used);
>> +	else
>> +		static_branch_disable(&br_mst_used);
> 
> I believe the current code is buggy and these
> static_branch_{enable,disable}() should be converted to
> static_branch_{inc,dec}(). The static key is global and MST can be
> enabled / disabled on multiple bridges, which makes this fix
> problematic.
> 

Indeed, multiple bridges could re-enable it. That code is buggy..

> Can we instead clear BR_LEARNING from a port that is being deleted?
> 

Yeah, if done before the vlan flush (i.e. before synchronize_rcu), it should
work for this case, but I'd like to avoid bypassing port state altogether
because it could lead to other bugs in the future. I am tempted to make
MST enabled dependent on VLAN filtering enabled (as it should have been),
running with vlan filtering 0 and mst enabled 1 is nonsense anyway.

I think we should add one check when MST is enabled for port's vlan group,
if it is NULL then don't bypass its state since that means it is getting
deleted, that would prevent state bypass altogether.

>> +}
>> +
>>  int br_mst_set_enabled(struct net_bridge *br, bool on,
>>  		       struct netlink_ext_ack *extack)
>>  {
>> @@ -224,11 +236,7 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
>>  	if (err && err != -EOPNOTSUPP)
>>  		return err;
>>  
>> -	if (on)
>> -		static_branch_enable(&br_mst_used);
>> -	else
>> -		static_branch_disable(&br_mst_used);
>> -
>> +	br_mst_static_branch_toggle(br);
>>  	br_opt_toggle(br, BROPT_MST_ENABLED, on);
>>  	return 0;
>>  }
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index 16be5d250402..052bea4b3c06 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -1952,6 +1952,7 @@ int br_mst_fill_info(struct sk_buff *skb,
>>  		     const struct net_bridge_vlan_group *vg);
>>  int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
>>  		   struct netlink_ext_ack *extack);
>> +void br_mst_static_branch_toggle(struct net_bridge *br);
>>  #else
>>  static inline bool br_mst_is_enabled(struct net_bridge *br)
>>  {
>> @@ -1987,6 +1988,10 @@ static inline int br_mst_process(struct net_bridge_port *p,
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> +
>> +static inline void br_mst_static_branch_toggle(struct net_bridge *br)
>> +{
>> +}
>>  #endif
>>  
>>  struct nf_br_ops {
>> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> index ce72b837ff8e..636d11f932eb 100644
>> --- a/net/bridge/br_vlan.c
>> +++ b/net/bridge/br_vlan.c
>> @@ -911,6 +911,7 @@ int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val,
>>  	br_manage_promisc(br);
>>  	recalculate_group_addr(br);
>>  	br_recalculate_fwd_mask(br);
>> +	br_mst_static_branch_toggle(br);
>>  	if (!val && br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
>>  		br_info(br, "vlan filtering disabled, automatically disabling multicast vlan snooping\n");
>>  		br_multicast_toggle_vlan_snooping(br, false, NULL);
>> -- 
>> 2.51.0
>>


