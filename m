Return-Path: <netdev+bounces-242196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61982C8D4BA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24AC54E3033
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBE7320A2C;
	Thu, 27 Nov 2025 08:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F623372C;
	Thu, 27 Nov 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764231204; cv=none; b=laCAPm799XSNj/X1s/ZZUBVc49MowTcmuWCeT25HhkdTRccfQaN+38VVD3YVxujEI4O0xw14jPGNghnB2Kcmk5ghat5pdoU1MLdE4sQlM4WGp5dP9ZBY6tdwe/mXOouz+hXKx2PEHuSlN7GIc8+OxOtVY08Z3w/vBPBUpDGPwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764231204; c=relaxed/simple;
	bh=so9MBS8IZy98NwwyePzW4F9CMHM6CChSefrP9+YDxV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jV9jPKNzdWdfdxbhXhZ5xYnNBhzMQQWeQ/KP0BwZi8egVV2tXTatK5oD1wi21BCvF3wyeJlNPM7ujskG9bF9FORV8cAtQOplNrpOjYhk+mjYds+sOJHHZTP+PwMW/QWAuw9EUwNpbSrAki0Aas1Dc7ebKhhZYY2rjM1MoQ813N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dH8L06S1XzHnGcW;
	Thu, 27 Nov 2025 16:12:24 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 080CB140417;
	Thu, 27 Nov 2025 16:13:13 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 11:13:12 +0300
Message-ID: <25e65682-9df4-4257-94cd-be97f0a49867@huawei.com>
Date: Thu, 27 Nov 2025 11:13:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] ipvlan: Support MACNAT mode
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, Guillaume Nault
	<gnault@redhat.com>, Eric Dumazet <edumazet@google.com>, Julian Vetter
	<julian@outer-limits.org>, Stanislav Fomichev <sdf@fomichev.me>, Etienne
 Champetier <champetier.etienne@gmail.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, "David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-2-skorodumov.dmitry@huawei.com>
 <3d5ef6e5-cfcc-4994-a8d2-857821b79ed8@redhat.com>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <3d5ef6e5-cfcc-4994-a8d2-857821b79ed8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)


On 25.11.2025 15:58, Paolo Abeni wrote:
> On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
>> +static inline void ipvlan_mark_skb(struct sk_buff *skb, struct net_device *dev)
>> +{
>> +	IPVL_SKB_CB(skb)->mark = dev;
> +	if (ipvlan_is_skb_marked(skb, port->dev))
> ... and this is the receiver path. Nothing guaratees the CB is preserved
> in between and that random data in there will not confuse the above
> check. Also I'm not sure what you are trying to filter out here.

I need to recheck.. unfortunately I didn't wrote enough comments here and now unsure about some details..

>> @@ -597,6 +690,9 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
>>  	port = ipvlan_port_get_rtnl(phy_dev);
>>  	ipvlan->port = port;
>>  
>> +	if (data && data[IFLA_IPVLAN_FLAGS])
>> +		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
> This looks like a change of behavior that could potentially break the
> user-space.
>
>> +
>>  	/* If the port-id base is at the MAX value, then wrap it around and
>>  	 * begin from 0x1 again. This may be due to a busy system where lots
>>  	 * of slaves are getting created and deleted.
>> @@ -625,19 +721,13 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
>>  	if (err)
>>  		goto remove_ida;
>>  
>> -	/* Flags are per port and latest update overrides. User has
>> -	 * to be consistent in setting it just like the mode attribute.
>> -	 */
>> -	if (data && data[IFLA_IPVLAN_FLAGS])
>> -		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
>> -
>> -	if (data && data[IFLA_IPVLAN_MODE])
>> -		mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
>> -
>>  	err = ipvlan_set_port_mode(port, mode, extack);
>>  	if (err)
>>  		goto unlink_netdev;
>>  
>>
Hm... What am I missing? The intention was to know "mode" a bit earlier and generate MAC as random for macnat-mode.. it's supposed to be just a simple line move a bit upper in the code

PS: I agree with other issues and will work on it

Dmitry


