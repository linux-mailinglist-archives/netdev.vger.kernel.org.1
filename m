Return-Path: <netdev+bounces-125487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9235A96D582
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529E72883BA
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E042F198E86;
	Thu,  5 Sep 2024 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XQJ2F85/"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740613AA2B
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531033; cv=none; b=H7F0wSFcX45bmhhEQtMcrufQlfyu8IRU+DR7B7SP1N5pSEislnLRYqC7vpO1sESVPLhykg87knIKqrog9EN7GKGdv4d6jDn8mbu804NMALGsGUiByc9BfkOtBrwVbHOJEu8t5vSChFyaNDk18qOrLou01WXBQ5NuIp4Q1XR+878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531033; c=relaxed/simple;
	bh=Cu4GN+9mpshBCzDvhBUo3q3pTBYAlYKQhcfg8WfpTZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bs4CqauLWTVOoMMgbUvNcG/Ku+T3MGz/7Icq+aL2b9x3yZns04iwT42dfpc8ukRo9TMKFh/CAKXAHvZJ55c/9bbbKd0R8MVbC124GU8xqIkjnJ+oJV74gt93iYuwSVN7++kkVHxBSeGVqOl0zaFpPfugap+uZSZUpRCKBm++j4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XQJ2F85/; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1946af56-9f6f-439d-b954-6bcb82367741@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725531028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hQpSq5swIZhAMqb9y4whS27vanROuONfydCjD4K6K8=;
	b=XQJ2F85/pPT+hWkUg93Joez3WU9k6bSbNHeEFys5dJqhgfjeMEAF/rrVjPDBinuu8/qTcM
	VIzxCDkeLTgJfIPaxB74B6LQozUKIcIWbmAjHxZsCba2mdBzUCVtOZYxi/VSSoceZNfCJO
	cwQH8y8DQ4Gn3TM5pgy4He/uMJBnjmk=
Date: Thu, 5 Sep 2024 11:10:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>, Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-2-vadfed@meta.com>
 <66d8c903bba20_163d9329498@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <66d8c903bba20_163d9329498@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/09/2024 21:54, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
>> timestamps and packets sent via socket. Unfortunately, there is no way
>> to reliably predict socket timestamp ID value in case of error returned
>> by sendmsg. For UDP sockets it's impossible because of lockless
>> nature of UDP transmit, several threads may send packets in parallel. In
>> case of RAW sockets MSG_MORE option makes things complicated. More
>> details are in the conversation [1].
>> This patch adds new control message type to give user-space
>> software an opportunity to control the mapping between packets and
>> values by providing ID with each sendmsg for UDP sockets.
>> The documentation is also added in this patch.
>>
>> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   Documentation/networking/timestamping.rst | 13 +++++++++++++
>>   arch/alpha/include/uapi/asm/socket.h      |  2 ++
>>   arch/mips/include/uapi/asm/socket.h       |  2 ++
>>   arch/parisc/include/uapi/asm/socket.h     |  2 ++
>>   arch/sparc/include/uapi/asm/socket.h      |  2 ++
>>   include/net/inet_sock.h                   |  4 +++-
>>   include/net/sock.h                        |  2 ++
>>   include/uapi/asm-generic/socket.h         |  2 ++
>>   include/uapi/linux/net_tstamp.h           |  7 +++++++
>>   net/core/sock.c                           |  9 +++++++++
>>   net/ipv4/ip_output.c                      | 18 +++++++++++++-----
>>   net/ipv6/ip6_output.c                     | 18 +++++++++++++-----
>>   12 files changed, 70 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
>> index a2c66b3d7f0f..1c38536350e7 100644
>> --- a/include/uapi/linux/net_tstamp.h
>> +++ b/include/uapi/linux/net_tstamp.h
>> @@ -38,6 +38,13 @@ enum {
>>   				 SOF_TIMESTAMPING_LAST
>>   };
>>   
>> +/*
>> + * The highest bit of sk_tsflags is reserved for kernel-internal
>> + * SOCKCM_FLAG_TS_OPT_ID. This check is to control that SOF_TIMESTAMPING*
>> + * values do not reach this reserved area
>> + */
>> +static_assert(SOF_TIMESTAMPING_LAST != (1 << 31));
> 
> Let's not leak any if this implementation detail to include/uapi.
> 
> A BUILD_BUG_ON wherever SOCKCM_FLAG_TS_OPT_ID is used, such as in case
> SCM_TS_OPT_ID, should work.

Makes sense. I'll change the check and will try to add meaningful message.

>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>> index eea443b7f65e..bd2f6a699470 100644
>> --- a/net/ipv4/ip_output.c
>> +++ b/net/ipv4/ip_output.c
>> @@ -973,7 +973,7 @@ static int __ip_append_data(struct sock *sk,
>>   	unsigned int maxfraglen, fragheaderlen, maxnonfragsize;
>>   	int csummode = CHECKSUM_NONE;
>>   	struct rtable *rt = dst_rtable(cork->dst);
>> -	bool paged, hold_tskey, extra_uref = false;
>> +	bool paged, hold_tskey = false, extra_uref = false;
>>   	unsigned int wmem_alloc_delta = 0;
>>   	u32 tskey = 0;
>>   
>> @@ -1049,10 +1049,15 @@ static int __ip_append_data(struct sock *sk,
>>   
>>   	cork->length += length;
>>   
>> -	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>> -		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
>> -	if (hold_tskey)
>> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
>> +	    READ_ONCE(sk->sk_tsflags) & SOCKCM_FLAG_TS_OPT_ID) {
> 
> s/SOCKCM_FLAG_TS_OPT_ID/SOF_TIMESTAMPING_OPT_ID/

Ack

>> +		if (cork->flags & IPCORK_TS_OPT_ID) {
>> +			tskey = cork->ts_opt_id;
>> +		} else {
>> +			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +			hold_tskey = true;
>> +		}
>> +	}
>>   
>>   	/* So, what's going on in the loop below?
>>   	 *
>> @@ -1325,8 +1330,11 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
>>   	cork->mark = ipc->sockc.mark;
>>   	cork->priority = ipc->priority;
>>   	cork->transmit_time = ipc->sockc.transmit_time;
>> +	cork->ts_opt_id = ipc->sockc.ts_opt_id;
>>   	cork->tx_flags = 0;
>>   	sock_tx_timestamp(sk, ipc->sockc.tsflags, &cork->tx_flags);
>> +	if (ipc->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID)
>> +		cork->flags |= IPCORK_TS_OPT_ID;
> 
> We can move initialization of ts_opt_id into the branch.
> 
> Or conversely avoid the branch with some convoluted shift operations
> to have the rval be either 1 << 1 or 0 << 1. But let's do the simpler
> thing.

What is the reason to move initialization behind the flag? We are not
doing this for transmit_time even though it's also used with flag only.

It's not a big deal to change, I just wonder what are the benefits?


