Return-Path: <netdev+bounces-276874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL4jAghb12lqMwgAu9opvQ
	(envelope-from <netdev+bounces-276874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:53:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D073C74F1
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C5D3007CB5
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7723859E2;
	Thu,  9 Apr 2026 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H0LXRoOw"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398137AA77
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721062; cv=none; b=frQeS77mMPh50S8O7sSnx7KE0yoga4P8hareOAEzd8OyM/ffelTtL8RaeI4ibuWACE46lR79bohvjbVF3PuC6S7bQlCu3LF9pe5OsIZ2KWWCIn0t/2hRRGvPfUZilONeqv7ebEXomTSocuktbtfuXgqiY2G+z5CWVWy6sDL7ciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721062; c=relaxed/simple;
	bh=x/mDuO5aW+xOYVFPxn5cSkb/K6xswtpfQkRLRJmY8WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfxl+1V1Vg+zJGSlxE1Srz2dcBN+1BjxNa+NgbwDEJMbLlDytTmlaNCeGBy1D2WsI7/WdQST7D+BGMQsCtxSOfuxGnAX5czxU5uVa/R/5OLv4GymExoxv18Frbs2rpcpuziBD+Ekk3UTy6mBTE6td4jB0S99kR66ZMnKYMMJkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H0LXRoOw; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c761de0-4d8c-4b2e-89a6-80f12016fd78@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775721049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ctgvjMM21Mfyak3TqaT4DUpV4LWJB/jgFvuY7mWNIU=;
	b=H0LXRoOwVcEEhitNLv6wYSoG9Oz6fMQPfFb3ygTUhBxdAHj4UfkPq8kh7KsS9up+oTkUGs
	N2wjJL1EQS0eJJisdLfNftb/oaaH+CWn+sA4AzkIX8A9vFoVn89LRHj2SxvfqlkvEnbQFB
	bgifR4c8/eUoZFXeVZjFCuLXN5vgplY=
Date: Thu, 9 Apr 2026 15:50:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: fix __this_cpu_add() in preemptible code in
 dev_xmit_recursion_inc/dec
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260409035344.214279-1-jiayuan.chen@linux.dev>
 <CANn89iLEpVVo=q4FPpBQ5FomoLmdrfW3su7Mb0ZES4EV9=Q4xA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CANn89iLEpVVo=q4FPpBQ5FomoLmdrfW3su7Mb0ZES4EV9=Q4xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276874-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,lunn.ch,linutronix.de,goodmis.org,gmail.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 78D073C74F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/9/26 3:18 PM, Eric Dumazet wrote:
> On Wed, Apr 8, 2026 at 8:54 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> dev_xmit_recursion_inc/dec() use __this_cpu_inc/dec() which requires
>> migration to be disabled. However, some callers like SCTP's UDP
>> encapsulation path invoke iptunnel_xmit() from process context without
>> disabling BH or preemption:
>>
>>    sctp_inet_connect -> __sctp_connect -> sctp_do_sm ->
>>    sctp_outq_flush -> sctp_packet_transmit -> sctp_v4_xmit ->
>>    udp_tunnel_xmit_skb -> iptunnel_xmit -> dev_xmit_recursion_inc
>>
>> This triggers the following warning on PREEMPT(full) kernels:
>>
>>
>> Fix this by adding migrate_disable/enable() around the __this_cpu
>> operations in dev_xmit_recursion_inc/dec() to ensure the per-cpu
>> variable is accessed on the same CPU throughout the inc/dec pair.
>>
>> Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   include/linux/netdevice.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 7ca01eb3f7d2..6b1cd5380d70 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -3591,14 +3591,19 @@ static inline bool dev_xmit_recursion(void)
>>                          XMIT_RECURSION_LIMIT);
>>   }
>>
>> +/* Non PREEMPT_RT version: inc and dec must run on the same CPU,
>> + * migrate_disable is sufficient.
>> + */
>>   static inline void dev_xmit_recursion_inc(void)
>>   {
>> +       migrate_disable();
>>          __this_cpu_inc(softnet_data.xmit.recursion);
>>   }
>>
>>   static inline void dev_xmit_recursion_dec(void)
>>   {
>>          __this_cpu_dec(softnet_data.xmit.recursion);
>> +       migrate_enable();
>>   }
>>   #else
>>   static inline int dev_recursion_level(void)
>> --
>> 2.43.0
> This seems wrong.
>
> The migrate_disable() should happen before dev_recursion_level().

Thanks

I checked all callers of dev_xmit_recursion_inc(). Most are fine.

The only problematic ones are iptunnel_xmit() and ip6tunnel_xmit(),

I think adding guard(migrate)() at the top of both functions is enough


