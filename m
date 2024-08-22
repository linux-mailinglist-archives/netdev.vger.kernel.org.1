Return-Path: <netdev+bounces-121066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915D295B8B7
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44ECF281832
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A611CBEB7;
	Thu, 22 Aug 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="g1RjXPBX"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ECC1CB31D
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337683; cv=none; b=Db9y9fgMBD/PT1aHLjvWZJF9dqLKqA/EhV+mvHO8dNB2S0Hhi+Q1iu3t8Qbant+6olqTfIljKNwdoEgVAML1+3QtzrmtM4JWhmaR0iNyEmajVQGV06hcn9Wf7qXpwmJt4tMwZ4N7yAy7UBlbxWqoXhhV+js9xet3mlWzGjaWjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337683; c=relaxed/simple;
	bh=EGdMmptgnR9+omJFU763etAhdoEGq9tQZFIwqAi4MKQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=MUwzFJQu5mewvM9zt/u3dCMdAXIrfbu0ajcBpEQ3p/iLqTvKtvlQMlmW+C0blnD5jI70WpwJ1FM7uQqrSe870L1OKrTTvcMmevx6jXwcCvjborHu1VRt3NC43fRf3omUFEil01DA3PcIzH5RWquDRihk59w6WMp7A6c6ByMILC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=g1RjXPBX; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:3c32:7100:fa85:d49] (unknown [IPv6:2a02:8010:6359:1:3c32:7100:fa85:d49])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id C15697D889;
	Thu, 22 Aug 2024 15:41:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1724337675; bh=EGdMmptgnR9+omJFU763etAhdoEGq9tQZFIwqAi4MKQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<a5468b0a-6963-5f04-4827-1f15aae7f3e7@katalix.com>|
	 Date:=20Thu,=2022=20Aug=202024=2015:41:14=20+0100|MIME-Version:=20
	 1.0|To:=20Paolo=20Abeni=20<pabeni@redhat.com>,=20netdev@vger.kerne
	 l.org|Cc:=20davem@davemloft.net,=20edumazet@google.com,=20kuba@ker
	 nel.org,=0D=0A=20dsahern@kernel.org,=20tparkin@katalix.com,=20xiyo
	 u.wangcong@gmail.com|References:=20<20240819145208.3209296-1-jchap
	 man@katalix.com>=0D=0A=20<cc6601a3-6657-4659-9f2b-6dd7856fe8e0@red
	 hat.com>|From:=20James=20Chapman=20<jchapman@katalix.com>|Subject:
	 =20Re:=20[PATCH=20net-next]=20l2tp:=20avoid=20using=20drain_workqu
	 eue=20in=0D=0A=20l2tp_pre_exit_net|In-Reply-To:=20<cc6601a3-6657-4
	 659-9f2b-6dd7856fe8e0@redhat.com>;
	b=g1RjXPBXz87cWjuTOstpltH8ZxeUwWOWxE4C/hqz+niUG8jO4t1mJLMnR4SUpYNuD
	 6yylaGj46iJsUIvm5C1DtZY0ZuArflrgtRdd46Asc72Xb+i0NXCsezXzWh6UdXBJHH
	 orkABFoovwTdppdnZM6FY+1IIS1Mn78XbvWCN9e0OEIXhULGbmZiU5RckSjNhOu4Jz
	 fj04d0HvWRJoyR/zALSLnwL6TVzlioEiS8SEMyArJsSd4LIz0hOHFG6ICx8pQNIFmH
	 7kxV23i5sDmXqCNmcwWQj68SOvA0nt03EUYvqxS7mwagD5wJHbdXwKLLTUdqvITfnd
	 GjKbhBMmuSt1Q==
Message-ID: <a5468b0a-6963-5f04-4827-1f15aae7f3e7@katalix.com>
Date: Thu, 22 Aug 2024 15:41:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, tparkin@katalix.com, xiyou.wangcong@gmail.com
References: <20240819145208.3209296-1-jchapman@katalix.com>
 <cc6601a3-6657-4659-9f2b-6dd7856fe8e0@redhat.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next] l2tp: avoid using drain_workqueue in
 l2tp_pre_exit_net
In-Reply-To: <cc6601a3-6657-4659-9f2b-6dd7856fe8e0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 11:22, Paolo Abeni wrote:
> 
> 
> On 8/19/24 16:52, James Chapman wrote:
>> Recent commit c1b2e36b8776 ("l2tp: flush workqueue before draining
>> it") incorrectly uses drain_workqueue. 
> 
> isn't the relevant commit fc7ec7f554d7d0a27ba339fcf48df11d14413329?

Good spot. Thanks.

>> The use of drain_workqueue in
>> l2tp_pre_exit_net is flawed because the workqueue is shared by all
>> nets and it is therefore possible for new work items to be queued
>> while drain_workqueue runs.
>>
>> Instead of using drain_workqueue, use a loop to delete all tunnels and
>> __flush_workqueue until all tunnel/session lists of the net are
>> empty. Add a per-net flag to ensure that no new tunnel can be created
>> in the net once l2tp_pre_exit_net starts.
> 
> We need a fixes tag even for net-next fixes :)

Oh ok. My mistake.

>> Signed-off-by: James Chapman <jchapman@katalix.com>
>> Signed-off-by: Tom Parkin <tparkin@katalix.com>
>> ---
>>   net/l2tp/l2tp_core.c    | 38 +++++++++++++++++++++++++++++---------
>>   net/l2tp/l2tp_core.h    |  2 +-
>>   net/l2tp/l2tp_netlink.c |  2 +-
>>   net/l2tp/l2tp_ppp.c     |  3 ++-
>>   4 files changed, 33 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
>> index af87c781d6a6..246b07342b86 100644
>> --- a/net/l2tp/l2tp_core.c
>> +++ b/net/l2tp/l2tp_core.c
>> @@ -107,6 +107,7 @@ static struct workqueue_struct *l2tp_wq;
>>   /* per-net private data for this module */
>>   static unsigned int l2tp_net_id;
>>   struct l2tp_net {
>> +    bool net_closing;
>>       /* Lock for write access to l2tp_tunnel_idr */
>>       spinlock_t l2tp_tunnel_idr_lock;
>>       struct idr l2tp_tunnel_idr;
>> @@ -1560,13 +1561,19 @@ static int l2tp_tunnel_sock_create(struct net 
>> *net,
>>       return err;
>>   }
>> -int l2tp_tunnel_create(int fd, int version, u32 tunnel_id, u32 
>> peer_tunnel_id,
>> +int l2tp_tunnel_create(struct net *net, int fd, int version,
>> +               u32 tunnel_id, u32 peer_tunnel_id,
>>                  struct l2tp_tunnel_cfg *cfg, struct l2tp_tunnel 
>> **tunnelp)
>>   {
>> +    struct l2tp_net *pn = l2tp_pernet(net);
>>       struct l2tp_tunnel *tunnel = NULL;
>>       int err;
>>       enum l2tp_encap_type encap = L2TP_ENCAPTYPE_UDP;
>> +    /* This pairs with WRITE_ONCE() in l2tp_pre_exit_net(). */
>> +    if (READ_ONCE(pn->net_closing))
>> +        return -ENETDOWN;
> 
> Is this necessary? the netns is going away, no user space process should 
> be able to touch it.

I considered this too. I was thinking that a bad process could cause 
l2tp_pre_exit_net to loop forever if it keeps creating tunnels. But if 
the net isn't usable by userspace when the pre_exit handler starts then 
I think we're ok to remove the flag.

> 
>> +
>>       if (cfg)
>>           encap = cfg->encap;
>> @@ -1855,16 +1870,21 @@ static __net_exit void 
>> l2tp_pre_exit_net(struct net *net)
>>       }
>>       rcu_read_unlock_bh();
>> -    if (l2tp_wq) {
>> -        /* ensure that all TUNNEL_DELETE work items are run before
>> -         * draining the work queue since TUNNEL_DELETE requests may
>> -         * queue SESSION_DELETE work items for each session in the
>> -         * tunnel. drain_workqueue may otherwise warn if SESSION_DELETE
>> -         * requests are queued while the work queue is being drained.
>> -         */
>> +    if (l2tp_wq)
>>           __flush_workqueue(l2tp_wq);
>> -        drain_workqueue(l2tp_wq);
>> +
>> +    /* repeat until all of the net's IDR lists are empty, in case 
>> tunnels
>> +     * or sessions were being created just before l2tp_pre_exit_net was
>> +     * called.
>> +     */
>> +    rcu_read_lock_bh();
>> +    if (!idr_is_empty(&pn->l2tp_tunnel_idr) ||
>> +        !idr_is_empty(&pn->l2tp_v2_session_idr) ||
>> +        !idr_is_empty(&pn->l2tp_v3_session_idr)) {
>> +        rcu_read_unlock_bh();
>> +        goto again;
> 
> This looks not nice, it could keep the kernel spinning for a while.
> 
> What about i.e. queue a 'dummy' work on l2tp_wq after 
> __flush_workqueue() and explicitly wait for such work to complete?
> 
> when such work completes are other l2tp related one in the same netns 
> should also be completed.

The loop is there in case one or more threads were in 
l2tp_tunnel_register or l2tp_session_register at the point where 
l2tp_pre_exit_net starts. If a tunnel or session is registered after 
l2tp_pre_exit_net loops over all tunnels calling l2tp_tunnel_delete, 
then it would be left behind.

I'll think more on this.

Thanks



