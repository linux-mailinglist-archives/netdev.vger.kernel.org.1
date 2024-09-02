Return-Path: <netdev+bounces-124304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 204AE968E77
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 21:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96AD1F23361
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 19:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4DF19CC32;
	Mon,  2 Sep 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUk1MpnV"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0F1A3ABB
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725305734; cv=none; b=jewml2MZbSSbdEyEebaCALslqQVqr0+nymyNVKuk1sCIihPR+0bqHY37mDlSuykOVK6IVnzJyQLdcW9C8T6RNMDIjKN7i1tVvfUQM4MRCXMkbG0jDxGR+I/pJ/y+7pMBFTBwb70GpLHzkOlzlrjz9hm+7712if8hii7nvDZSDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725305734; c=relaxed/simple;
	bh=WMwM3sUAvJBRUO8zkQa/BmFXhFFcDDp3n1X3GZOD91o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4UwlOtVpxJwQVBWusIotQJajeM+1H22gXCuX4HIMHafXqiU2YWlpPmJpHfKEiHHL9VmawHgtmdiiewNf/3pGARqT4mMdqkeOze9f/T6Kzrlv6wEz+G9Vf11quZAt+t2yuk5kjU+6IuzVD9ZOsz5snTjRzk/FBPdcOe3cGfsHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUk1MpnV; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f2a5db09-decc-4e40-a6cc-d4f179a7ab68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725305729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLN86+xPOpxwENxvNDeU2pp+sDx1cVFn3bwwCu6PCfM=;
	b=QUk1MpnVZ3L3Sfi7vPLaM4HwV52ffgxLI68WkqQ15DACyGIYEfw2FB+W7dYZxJXgv11Ano
	n3T8Lql1tsocJCZexyZz1MmzfmgU/XuCsjqqJvNTisTA6CI9pP4Wa/MxjLbKOYc9Sw09Tr
	CDTrZWjpkfYcWoTQr/dAQ1+qijr44aU=
Date: Mon, 2 Sep 2024 20:35:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org
References: <20240902130937.457115-1-vadfed@meta.com>
 <20240902183833.GK23170@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240902183833.GK23170@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 02/09/2024 19:38, Simon Horman wrote:
> On Mon, Sep 02, 2024 at 06:09:35AM -0700, Vadim Fedorenko wrote:
>> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
>> timestamps and packets sent via socket. Unfortunately, there is no way
>> to reliably predict socket timestamp ID value in case of error returned
>> by sendmsg. For UDP sockets it's impossible because of lockless
>> nature of UDP transmit, several threads may send packets in parallel. In
>> case of RAW sockets MSG_MORE option makes things complicated. More
>> details are in the conversation [1].
>> This patch adds new control message type to give user-space
>> software an opportunity to control the mapping between packets and
>> values by providing ID with each sendmsg. This works fine for UDP
>> sockets only, and explicit check is added to control message parser.
>>
>> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> ...
> 
>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> 
> ...
> 
>> @@ -1543,10 +1546,15 @@ static int __ip6_append_data(struct sock *sk,
>>   			flags &= ~MSG_SPLICE_PAGES;
>>   	}
>>   
>> -	hold_tskey = cork->tx_flags & SKBTX_ANY_TSTAMP &&
>> -		     READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID;
>> -	if (hold_tskey)
>> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
>> +	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
>> +		if (cork->flags & IPCORK_TS_OPT_ID) {
>> +			tskey = cork->ts_opt_id;
>> +		} else {
>> +			tskey = atomic_inc_return(&sk->sk_tskey) - 1;
>> +			hold_tskey = true;
> 
> Hi Vadim,
> 
> I think that hold_tskey also needs to be assigned a value in
> the cases where wither of the if conditions above are false.

Hi Simon!

Yes, you are right. I should probably init it with false to avoid
'else' statement.

Thanks,
Vadim


> Flagged by Smatch.
> 
>> +		}
>> +	}
>>   
>>   	/*
>>   	 * Let's try using as much space as possible.
> 


