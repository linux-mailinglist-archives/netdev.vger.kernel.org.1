Return-Path: <netdev+bounces-46249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906187E2CED
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 20:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93A0280CE2
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 19:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1F28DCF;
	Mon,  6 Nov 2023 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A19kRBUh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F175168BC
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 19:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA7AC433C9;
	Mon,  6 Nov 2023 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699299294;
	bh=Hl1nfA1hQNe7leKhITV5rp/ybaYc2SObTEPuCoXKzsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A19kRBUhdf908QakvSgKid7H5ILLcRyl3LZTCq1N1NbR7P1t/sgJRPyq2mGHLHvNQ
	 c1PmQQF3vJZi27wlDydYRDaG8WnnwIr0O2WZfJhX3FpFS6CHEqJ6CuB7YqBNsWEaZE
	 xyOMV1pLvMG22qoj0QveUa+peLUS08xdNIur+5Fr3xrEIfcoB+ObeLmiFlg1mq0m3q
	 0yN7lT3Uys4lMsk11MZaPaYEVjqE3WuxO6HHuReiJN0i9RJhbO12h4kRSoBuzqWNjB
	 idZCa47/HKlp/rFMD73n780muQHc7iYP5/kr+yLw9PIA6OnA231CX8KwxAGpxy4SoF
	 Lhij6W8x3MIrw==
Message-ID: <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
Date: Mon, 6 Nov 2023 12:34:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable
 frags
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com>
 <ZUk03DhWxV-bOFJL@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZUk03DhWxV-bOFJL@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> On 11/05, Mina Almasry wrote:
>> For device memory TCP, we expect the skb headers to be available in host
>> memory for access, and we expect the skb frags to be in device memory
>> and unaccessible to the host. We expect there to be no mixing and
>> matching of device memory frags (unaccessible) with host memory frags
>> (accessible) in the same skb.
>>
>> Add a skb->devmem flag which indicates whether the frags in this skb
>> are device memory frags or not.
>>
>> __skb_fill_page_desc() now checks frags added to skbs for page_pool_iovs,
>> and marks the skb as skb->devmem accordingly.
>>
>> Add checks through the network stack to avoid accessing the frags of
>> devmem skbs and avoid coalescing devmem skbs with non devmem skbs.
>>
>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
>> Signed-off-by: Mina Almasry <almasrymina@google.com>
>>
>> ---
>>  include/linux/skbuff.h | 14 +++++++-
>>  include/net/tcp.h      |  5 +--
>>  net/core/datagram.c    |  6 ++++
>>  net/core/gro.c         |  5 ++-
>>  net/core/skbuff.c      | 77 ++++++++++++++++++++++++++++++++++++------
>>  net/ipv4/tcp.c         |  6 ++++
>>  net/ipv4/tcp_input.c   | 13 +++++--
>>  net/ipv4/tcp_output.c  |  5 ++-
>>  net/packet/af_packet.c |  4 +--
>>  9 files changed, 115 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 1fae276c1353..8fb468ff8115 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_t;
>>   *	@csum_level: indicates the number of consecutive checksums found in
>>   *		the packet minus one that have been verified as
>>   *		CHECKSUM_UNNECESSARY (max 3)
>> + *	@devmem: indicates that all the fragments in this skb are backed by
>> + *		device memory.
>>   *	@dst_pending_confirm: need to confirm neighbour
>>   *	@decrypted: Decrypted SKB
>>   *	@slow_gro: state present at GRO time, slower prepare step required
>> @@ -991,7 +993,7 @@ struct sk_buff {
>>  #if IS_ENABLED(CONFIG_IP_SCTP)
>>  	__u8			csum_not_inet:1;
>>  #endif
>> -
>> +	__u8			devmem:1;
>>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
>>  	__u16			tc_index;	/* traffic control index */
>>  #endif
>> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_managed(struct sk_buff *skb)
>>  		__skb_zcopy_downgrade_managed(skb);
>>  }
>>  
>> +/* Return true if frags in this skb are not readable by the host. */
>> +static inline bool skb_frags_not_readable(const struct sk_buff *skb)
>> +{
>> +	return skb->devmem;
> 
> bikeshedding: should we also rename 'devmem' sk_buff flag to 'not_readable'?
> It better communicates the fact that the stack shouldn't dereference the
> frags (because it has 'devmem' fragments or for some other potential
> future reason).

+1.

Also, the flag on the skb is an optimization - a high level signal that
one or more frags is in unreadable memory. There is no requirement that
all of the frags are in the same memory type.

