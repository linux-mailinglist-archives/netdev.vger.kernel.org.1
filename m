Return-Path: <netdev+bounces-81085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1553C885B59
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FE71C219DA
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B7285C77;
	Thu, 21 Mar 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DTTpOzyE"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2555792
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033430; cv=none; b=mdQkSeWhVN+udRnGiob8YNT+GiWKYMVBZGPHdBUYCEs8xqiJVZ7V3FFalbO1VNnCuY5ZF8WGuc9vSgfFNYKMO5OB1h0lKpQLQkCZRNgk2ntoo1VdV1hPWZgyV5NphVxtITVP2wAmqsb3ofVsrmwC7n1SFju+FNZrAx79tfUw8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033430; c=relaxed/simple;
	bh=q4+x0aifIbtTM1xEwbov/PjIHQy/aphdvdy48hnYllk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdD/MaEoz/sU/e1IoSG9tjreE85+6bZmV/+9XCW7mBOVsOv/a2ZB8eyZWVbBXdG40tPsAmei00fvuVMVqpJHitu5uJ+K0oXiNUavrppA2h0ER63aKqwNQ8JpwAqze6B8ZnnOciTPYtfsgtzQsAizUehByoFPct9yTP2UzFl2Rlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DTTpOzyE; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bb4d62d9-fbe2-41e3-90ff-02d7c2a05443@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711033425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZkcn1F/1RBtLueSk/qCM/2jZl7o2S0liUO3Wa0+rRQ=;
	b=DTTpOzyENbR+CkYaYba7eMIyUSN3CS9rh8vHbc42AT4EeyrTfbZJvedpFCrsIKuDXG7nw2
	3v1Gbfg4d2xoB12i4QcJ7MvUqHT65McQ9wufUjIK1Bx1/o+1QCCPfJ49BvYKwWGDqgE0ew
	B0iQVC5lyC/laL0Jyn7DktlVxz2gl/o=
Date: Thu, 21 Mar 2024 17:03:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
To: Ido Schimmel <idosch@idosch.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org,
 Martin Pitt <mpitt@redhat.com>, Paul Holzinger <pholzing@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-4-kuba@kernel.org> <20240315124808.033ff58d@elisabeth>
 <20240319085545.76445a1e@kernel.org>
 <CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
 <20240319104046.203df045@kernel.org>
 <7e261328-42eb-411d-b1b4-ad884eeaae4d@linux.dev> <Zfw7YB4nZrquW4Bo@shredder>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <Zfw7YB4nZrquW4Bo@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/03/2024 15:51, Ido Schimmel wrote:
> On Thu, Mar 21, 2024 at 02:56:41PM +0200, Gal Pressman wrote:
>> We've encountered a new issue recently which I believe is related to
>> this discussion.
>>
>> Following Eric's patch:
>> 9cc4cc329d30 ("ipv6: use xa_array iterator to implement inet6_dump_addr()")
>>
>> Setting the interface mtu to < 1280 results in 'ip addr show eth2'
>> returning an error, because the ipv6 dump fails. This is a degradation
>> from the user's perspective.
>>
>> # ip addr show eth2
>> 4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
>> default qlen 1000
>>     link/ether 24:42:53:21:52:44 brd ff:ff:ff:ff:ff:ff
>>     altname enp6s0f0np0
>> # ip link set dev eth2 mtu 1000
>> # ip addr show eth2
>> RTNETLINK answers: No such device
>> Dump terminated
> 
> I don't think it's the same issue. Original issue was about user space
> not knowing how to handle NLMSG_DONE being sent together with dump
> responses. The issue you reported seems to be related to an
> unintentional change in the return code when IPv6 is disabled on an
> interface. Can you please test the following patch?
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 247bd4d8ee45..92db9b474f2b 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -5416,10 +5416,11 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
>  
>                 err = 0;
>                 if (fillargs.ifindex) {
> -                       err = -ENODEV;
>                         dev = dev_get_by_index_rcu(tgt_net, fillargs.ifindex);
> -                       if (!dev)
> +                       if (!dev) {
> +                               err = -ENODEV;
>                                 goto done;
> +                       }
>                         idev = __in6_dev_get(dev);
>                         if (idev)
>                                 err = in6_dump_addrs(idev, skb, cb,

This seems to fix it, thanks!
Will you submit a patch?

