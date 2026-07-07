Return-Path: <netdev+bounces-305251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +VPCOddVTGoXjQEAu9opvQ
	(envelope-from <netdev+bounces-305251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:26:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A37168F5
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=NLpehEzj;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305251-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305251-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70353301D79A
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 01:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF62F8E95;
	Tue,  7 Jul 2026 01:26:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E282D47F1
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 01:26:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783387602; cv=none; b=kE5XIGBCZhiXIPVs5Z2oycXwYqWNn8i5S9xDs1G8HaYlfFNr0PzJTHOvMYk88jMaobUwYGO7LSUvKgw1zVNM64DNxnziDKgzvmU3z0OXSzKUyqfNnQvRPffMbPhiBAGsZ20P+6MpNGcijeIqfFu7PHfhKSiLgJdSiGxceVUS3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783387602; c=relaxed/simple;
	bh=rypkywCllkRCtt7lrzaFfAjRvYVR/iBmoYtPGMl+Hms=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=msv22JztYjA+M9FBiQnrJNgwmbleD7qV2KYusKccSLnEeWyzpUvCv8PBvkla+VPiGO9OyYzYjBtrrN5C81c9u0VMDwlDIwINO9eplSESXepsKl5OyVJ1LtZjIMbhlxm7kMjBnnXWcRmJydDt88DXGR224gzQOzkWKc3Bqsc9rLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NLpehEzj; arc=none smtp.client-ip=91.218.175.173
Message-ID: <5e2119f1-3c1c-43eb-984e-a8eeab2896e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783387597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOhHJ1dEBTNHFcbH9VoW95mNmVv3gt+0b86uohL6/ko=;
	b=NLpehEzjCglzQx+nvZdL1ZNVCLZDZoJdJq7jhEjuPkZangZaof5yjCXsyJ+ChqF6Cp/oS/
	uP6T7WxFcbSBuq61400mGJ5AP7270TSqRT62RqwObsREa/ldagd/m9nyad9A5Im+GmQXp/
	WapcEt534CmmlT9lKJSVR9NEXH3A+1E=
Date: Tue, 7 Jul 2026 09:26:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
Subject: Re: [PATCH net-next v2] ipv4: hold a consistent view of rt->dst.dev
 under RCU
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260701032434.17500-1-xuanqiang.luo@linux.dev>
 <20260705164649.GA295849@shredder>
In-Reply-To: <20260705164649.GA295849@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305251-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 576A37168F5


在 2026/7/6 00:46, Ido Schimmel 写道:
> On Wed, Jul 01, 2026 at 11:24:34AM +0800,xuanqiang.luo@linux.dev wrote:
>> From: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>>
>> rt_flush_dev() walks the per-CPU uncached route list and rewrites
>> rt->dst.dev in-place to blackhole_netdev under spin_lock_bh().
>> This lock does not exclude RCU readers, which may load rt->dst.dev
>> multiple times within a single rcu_read_lock() region.
>>
>> ip_rt_send_redirect() is a typical example: it reads rt->dst.dev
>> three times to obtain in_dev, the L3 master ifindex, and net.
>> A concurrent device unregistration can repoint rt->dst.dev to
>> blackhole_netdev between those reads, making the reader combine
>> state from two different net_devices — for instance, an in_dev
>> from the real device but a netns and peer lookup from the blackhole
>> device.  ip_rt_get_source() has the same problem: it reads
>> rt->dst.dev four times to obtain the output ifindex, the netns,
>> and the source address, so a concurrent flush can cause the source
>> selection to mix state from different devices.
> Why only change ip_rt_send_redirect() and ip_rt_get_source() when the
> patch is titled "ipv4: hold a consistent view of rt->dst.dev under RCU"?
> What is the criterion?

Thanks! You are right, the subject is too broad. I will make them
more accurate in the next version.

>> Take a single dst_dev_rcu() snapshot of rt->dst.dev at the start
>> of each affected RCU reader and use that snapshot throughout, so
>> concurrent flushes cannot cause mid-function inconsistency.
>> Publish the in-place write in rt_flush_dev() with rcu_assign_pointer()
>> to match the readers.
> The rt_flush_dev() change should be a separate change. Note that
> dst_dev_put() was already converted to use rcu_assign_pointer().
>
I will split the rt_flush_dev() change into a separate patch.

>> Fixes: caacf05e5ad1a ("ipv4: Properly purge netdev references on uncached routes.")
> Please remove the Fixes tag given you are targeting net-next.

Just to clarify: is the suggestion to drop the Fixes tag here solely
because this patch is targeted at net-next? Or are there any other
reasons?

>> Signed-off-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>> ---
>> v2:
>> - Use dst_dev_rcu() and dev_net_rcu() for the RCU readers.
>> - Use rcu_assign_pointer() when publishing the uncached route device
>>    replacement.
>> - Slightly adjust the commit message wording because this issue was found
>>    by inspection, not from an observed user-visible failure.
>>
>> v1:https://lore.kernel.org/all/20260630094250.29386-1-xuanqiang.luo@linux.dev/
>>
>>   net/ipv4/route.c | 29 +++++++++++++++++------------
>>   1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
>> index 3f3de5164d6e5..57f38467e6d0c 100644
>> --- a/net/ipv4/route.c
>> +++ b/net/ipv4/route.c
>> @@ -873,6 +873,7 @@ static void ipv4_negative_advice(struct sock *sk,
>>   void ip_rt_send_redirect(struct sk_buff *skb)
>>   {
>>   	struct rtable *rt = skb_rtable(skb);
>> +	struct net_device *dev;
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
>
> Same in other places.

Thanks for pointing this out!
I will fix the local variable ordering in the next version.


