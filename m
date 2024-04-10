Return-Path: <netdev+bounces-86338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE2789E69C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704451C20EF8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891EB182;
	Wed, 10 Apr 2024 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Jl87Ac36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2877F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707726; cv=none; b=muh1dBaHTsnzBwyBlph8tYAGUPMqtcQG7U+PpA/Q0Yebps4LthaT2Hx+2ph+ywHEUgnBsp82g+tDWNQkSuqQBJ30H3YZsDRHXRUPgUPq5C9RjX73nFzJgZwjtORmiqhvl0LDqtliyj6+l/AXiYt8+QJokE11G9reLxugLMIbtCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707726; c=relaxed/simple;
	bh=m6BCkqS3yeshIORsE9wTfo1bU2FdyyGqS69dY9V0Cyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUM2B/p2b0VrFQsjUZpB4CRWPz1/DzL2Zvvnpp58sVYLpN6eckFfI1kCzAbOPZWScNMIuAfPln6AJIQwKBgNTTkSxDV3lLZISJq/al4+GTZkgZSxIxcmuM5ZJEcl3XSvTelLCOeHgnCqRpwQSIYqzEJZWENzHWv5xgjQdG6IB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Jl87Ac36; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22ecc103220so3154675fac.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 17:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712707722; x=1713312522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spZLMLy3RjQ1PoszDas5ItL/4HgkEho9b6BSOYCr70E=;
        b=Jl87Ac36M/h37xQRKpYHhe6aiHTOC86agDHRxx4lpSc0aQZ426sXrREUdFIsjbFb7N
         sUy4ZGS+zBrzHr4s/IO1Dyah2y/ewEW+RYikmerWZ5lOAGlBX8bD153gIEB5kAfM6r52
         pqpYxG1vOeuDy0J5EsllhbLqobdAc5Q7H/DTywWGNFrWxc3OReXo5iWtNoZhYEcW9Rn7
         TEYdKgVJy6r1E6SF6I3I5d3kGmTl2mcVaHSPkZ965B478UpBL76KKICzFwBBYQpe/vQp
         1WgNQPpa7YLdeSWWXkuprKJvlgkHsCXNRE7iTYlJliQRfp7/00CoWq+wXTL4nQgwWDNl
         t+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712707722; x=1713312522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spZLMLy3RjQ1PoszDas5ItL/4HgkEho9b6BSOYCr70E=;
        b=SIRrBr1jeib9CvsoJDrdT44sHHlYSIyDxg6CH6+7RThBCZkqhratN7xCjyhQz0+4ij
         tCDMf02sByZCcUT8cUQWVErJWGavwyovRJjvH6TAgQD8JNJf68nfZWSGXFGV5/J/NxWf
         xzYdUtfYCLrCHoCjkFBYIRlTpmQf0ZVqD7O5G8w4N3CQKwZdhYxZyRDF7IO8aUppI4iz
         /Mt9vQlOGPeyLlotTyzU9GqHsLlvH+XTWumZoUv7BU0e5jz5zdUD9Yy8d+uTtYhJqL00
         IP6WBNh+kasTJrbq5TGl+10hdJAnVwfBKfulUoxoZx8AsALrkEAfRpn1rsymue7IhH4F
         cD1A==
X-Forwarded-Encrypted: i=1; AJvYcCXV7JObxmStPN3YlmTSPC9KOibZ7/FPkmyFUAqYSjuYfX2ryKSmeTlTDZ0sMAmv8D8h32cb6a2O4qd6mUCdyzMB3Q8bwmT4
X-Gm-Message-State: AOJu0YxM4VX7LOvgRCESkHcHPBqX0wrcJZCcd38U2MHq3mR9Z223ZwDX
	pWESEBAmD8hEJYDCRiOwuDDVaQ5PgrBmA7KGSizBhY6CHmVy9HlT3ElWrdYsm2g=
X-Google-Smtp-Source: AGHT+IGSyVZrNqV07aJicYfgt7M7pI9R4xkn8JkE7b34CDZMCtwFCATyg2jz1Au+ZXQNklWsemZoAA==
X-Received: by 2002:a05:6870:702c:b0:22a:6c9a:ece8 with SMTP id u44-20020a056870702c00b0022a6c9aece8mr1283771oae.21.1712707722359;
        Tue, 09 Apr 2024 17:08:42 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id l5-20020a056870d3c500b0022f102480casm1811775oag.6.2024.04.09.17.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:08:42 -0700 (PDT)
Message-ID: <31d167c3-5974-4054-8697-f0835b05b721@bytedance.com>
Date: Tue, 9 Apr 2024 17:08:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <20240409205300.1346681-2-zijianzhang@bytedance.com>
 <6615b0a417f7a_24a51429479@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <6615b0a417f7a_24a51429479@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/9/24 2:18 PM, Willem de Bruijn wrote:
> zijianzhang@ wrote:
>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>
>> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
>> However, zerocopy is not a free lunch. Apart from the management of user
>> pages, the combination of poll + recvmsg to receive notifications incurs
>> unignorable overhead in the applications. The overhead of such sometimes
>> might be more than the CPU savings from zerocopy. We try to solve this
>> problem with a new option for TCP and UDP, MSG_ZEROCOPY_UARG.
>> This new mechanism aims to reduce the overhead associated with receiving
>> notifications by embedding them directly into user arguments passed with
>> each sendmsg control message. By doing so, we can significantly reduce
>> the complexity and overhead for managing notifications. In an ideal
>> pattern, the user will keep calling sendmsg with MSG_ZEROCOPY_UARG
>> flag, and the notification will be delivered as soon as possible.
>>
>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> 
> The idea to avoid POLLERR and errqueue receive cost by piggy-backing
> onto the send() call is appealing.
> 
> I also implemented this when initially adding MSG_ZEROCOPY. At the
> time my implementation did not warrant the modest performance
> improvement I measured. But this may be different.
> 
> The main reason my code was complex is that this requires changes
> to net/socket.c: controldata is intended to be user->kernel on
> send and kernel->user on recv, such as data. This feature breaks
> that. You'll have to copy msg_controldata in ____sys_sendmsg.
> 
> I don't think it requires this much new infrastructure: a separate
> queue in structs tcp_sock and udp_sock, a differente uarg callback.
> 
> I would suggest an optimistic algorithm, whereby the send call
> steaks a notification skb from the error queue if present. This
> could be a new mode set with a value 2 in SO_ZEROCOPY.
> 

Thanks for the suggestion! I also think that the new infrastructure
requires much code change, it will be nice to reuse the error queue.

And, I agree that the MSG_ZEROCOPY_UARG is not a good name, a new mode
set with a value 2 in SO_ZEROCOPY is a better idea.

I will update in the next patch set.

>> ---
>>   include/linux/skbuff.h                  |   7 +-
>>   include/linux/socket.h                  |   1 +
>>   include/linux/tcp.h                     |   3 +
>>   include/linux/udp.h                     |   3 +
>>   include/net/sock.h                      |  17 +++
>>   include/net/udp.h                       |   1 +
>>   include/uapi/asm-generic/socket.h       |   2 +
>>   include/uapi/linux/socket.h             |  17 +++
>>   net/core/skbuff.c                       | 137 ++++++++++++++++++++++--
>>   net/core/sock.c                         |  50 +++++++++
>>   net/ipv4/ip_output.c                    |   6 +-
>>   net/ipv4/tcp.c                          |   7 +-
>>   net/ipv4/udp.c                          |   9 ++
>>   net/ipv6/ip6_output.c                   |   5 +-
>>   net/ipv6/udp.c                          |   9 ++
>>   net/vmw_vsock/virtio_transport_common.c |   2 +-
>>   16 files changed, 258 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 03ea36a82cdd..19b94ba01007 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -1663,12 +1663,14 @@ static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
>>   #endif
>>   
>>   struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
>> -				       struct ubuf_info *uarg);
>> +				       struct ubuf_info *uarg, bool user_args_notification);
>>   
>>   void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
>>   
>>   void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
>>   			   bool success);
>> +void msg_zerocopy_uarg_callback(struct sk_buff *skb, struct ubuf_info *uarg,
>> +			   bool success);
>>   
>>   int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>>   			    struct sk_buff *skb, struct iov_iter *from,
>> @@ -1763,7 +1765,8 @@ static inline void net_zcopy_put(struct ubuf_info *uarg)
>>   static inline void net_zcopy_put_abort(struct ubuf_info *uarg, bool have_uref)
>>   {
>>   	if (uarg) {
>> -		if (uarg->callback == msg_zerocopy_callback)
>> +		if (uarg->callback == msg_zerocopy_callback ||
>> +			uarg->callback == msg_zerocopy_uarg_callback)
>>   			msg_zerocopy_put_abort(uarg, have_uref);
>>   		else if (have_uref)
>>   			net_zcopy_put(uarg);
>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>> index 139c330ccf2c..de01392344e1 100644
>> --- a/include/linux/socket.h
>> +++ b/include/linux/socket.h
>> @@ -326,6 +326,7 @@ struct ucred {
>>   					  * plain text and require encryption
>>   					  */
>>   
>> +#define MSG_ZEROCOPY_UARG	0x2000000 /* MSG_ZEROCOPY with UARG notifications */
>>   #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
>>   #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
>>   #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>> index 55399ee2a57e..e973f4990646 100644
>> --- a/include/linux/tcp.h
>> +++ b/include/linux/tcp.h
>> @@ -501,6 +501,9 @@ struct tcp_sock {
>>   	 */
>>   	struct request_sock __rcu *fastopen_rsk;
>>   	struct saved_syn *saved_syn;
>> +
>> +/* TCP MSG_ZEROCOPY_UARG related information */
>> +	struct tx_msg_zcopy_queue tx_zcopy_queue;
>>   };
>>   
>>   enum tsq_enum {
>> diff --git a/include/linux/udp.h b/include/linux/udp.h
>> index 3748e82b627b..502b393eac67 100644
>> --- a/include/linux/udp.h
>> +++ b/include/linux/udp.h
>> @@ -95,6 +95,9 @@ struct udp_sock {
>>   
>>   	/* Cache friendly copy of sk->sk_peek_off >= 0 */
>>   	bool		peeking_with_offset;
>> +
>> +	/* This field is used by sendmsg zcopy user arg mode notification */
>> +	struct tx_msg_zcopy_queue tx_zcopy_queue;
>>   };
>>   
>>   #define udp_test_bit(nr, sk)			\
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 2253eefe2848..f7c045e98213 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -544,6 +544,23 @@ struct sock {
>>   	netns_tracker		ns_tracker;
>>   };
>>   
>> +struct tx_msg_zcopy_node {
>> +	struct list_head node;
>> +	struct tx_msg_zcopy_info info;
>> +	struct sk_buff *skb;
>> +};
>> +
>> +struct tx_msg_zcopy_queue {
>> +	struct list_head head;
>> +	spinlock_t lock; /* protects head queue */
>> +};
>> +
>> +static inline void tx_message_zcopy_queue_init(struct tx_msg_zcopy_queue *q)
>> +{
>> +	spin_lock_init(&q->lock);
>> +	INIT_LIST_HEAD(&q->head);
>> +}
>> +
>>   enum sk_pacing {
>>   	SK_PACING_NONE		= 0,
>>   	SK_PACING_NEEDED	= 1,
>> diff --git a/include/net/udp.h b/include/net/udp.h
>> index 488a6d2babcc..9e4d7b128de4 100644
>> --- a/include/net/udp.h
>> +++ b/include/net/udp.h
>> @@ -182,6 +182,7 @@ static inline void udp_lib_init_sock(struct sock *sk)
>>   	skb_queue_head_init(&up->reader_queue);
>>   	up->forward_threshold = sk->sk_rcvbuf >> 2;
>>   	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
>> +	tx_message_zcopy_queue_init(&up->tx_zcopy_queue);
>>   }
>>   
>>   /* hash routines shared between UDPv4/6 and UDP-Litev4/6 */
>> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
>> index 8ce8a39a1e5f..86aa4b5cb7f1 100644
>> --- a/include/uapi/asm-generic/socket.h
>> +++ b/include/uapi/asm-generic/socket.h
>> @@ -135,6 +135,8 @@
>>   #define SO_PASSPIDFD		76
>>   #define SO_PEERPIDFD		77
>>   
>> +#define SO_ZEROCOPY_NOTIFICATION 78
>> +
>>   #if !defined(__KERNEL__)
>>   
>>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
>> index d3fcd3b5ec53..469ed8f4e6c8 100644
>> --- a/include/uapi/linux/socket.h
>> +++ b/include/uapi/linux/socket.h
>> @@ -35,4 +35,21 @@ struct __kernel_sockaddr_storage {
>>   #define SOCK_TXREHASH_DISABLED	0
>>   #define SOCK_TXREHASH_ENABLED	1
>>   
>> +/*
>> + * Given the fact that MSG_ZEROCOPY_UARG tries to copy notifications
>> + * back to user as soon as possible, 8 should be sufficient.
>> + */
>> +#define SOCK_USR_ZC_INFO_MAX 8
>> +
>> +struct tx_msg_zcopy_info {
>> +	__u32 lo;
>> +	__u32 hi;
>> +	__u8 zerocopy;
>> +};
>> +
>> +struct tx_usr_zcopy_info {
>> +	int length;
>> +	struct tx_msg_zcopy_info info[SOCK_USR_ZC_INFO_MAX];
>> +};
>> +
>>   #endif /* _UAPI_LINUX_SOCKET_H */
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 2a5ce6667bbb..d939b2c14d55 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -1661,6 +1661,16 @@ void mm_unaccount_pinned_pages(struct mmpin *mmp)
>>   }
>>   EXPORT_SYMBOL_GPL(mm_unaccount_pinned_pages);
>>   
>> +static void init_ubuf_info_msgzc(struct ubuf_info_msgzc *uarg, struct sock *sk, size_t size)
>> +{
>> +	uarg->id = ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
>> +	uarg->len = 1;
>> +	uarg->bytelen = size;
>> +	uarg->zerocopy = 1;
>> +	uarg->ubuf.flags = SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
>> +	refcount_set(&uarg->ubuf.refcnt, 1);
>> +}
>> +
>>   static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size)
>>   {
>>   	struct ubuf_info_msgzc *uarg;
>> @@ -1682,12 +1692,38 @@ static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size)
>>   	}
>>   
>>   	uarg->ubuf.callback = msg_zerocopy_callback;
>> -	uarg->id = ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
>> -	uarg->len = 1;
>> -	uarg->bytelen = size;
>> -	uarg->zerocopy = 1;
>> -	uarg->ubuf.flags = SKBFL_ZEROCOPY_FRAG | SKBFL_DONT_ORPHAN;
>> -	refcount_set(&uarg->ubuf.refcnt, 1);
>> +	init_ubuf_info_msgzc(uarg, sk, size);
>> +	sock_hold(sk);
>> +
>> +	return &uarg->ubuf;
>> +}
>> +
>> +static struct ubuf_info *msg_zerocopy_uarg_alloc(struct sock *sk, size_t size)
>> +{
>> +	struct sk_buff *skb;
>> +	struct ubuf_info_msgzc *uarg;
>> +	struct tx_msg_zcopy_node *zcopy_node_p;
>> +
>> +	WARN_ON_ONCE(!in_task());
>> +
>> +	skb = sock_omalloc(sk, sizeof(*zcopy_node_p), GFP_KERNEL);
>> +	if (!skb)
>> +		return NULL;
>> +
>> +	BUILD_BUG_ON(sizeof(*uarg) > sizeof(skb->cb));
>> +	uarg = (void *)skb->cb;
>> +	uarg->mmp.user = NULL;
>> +	zcopy_node_p = (struct tx_msg_zcopy_node *)skb_put(skb, sizeof(*zcopy_node_p));
>> +
>> +	if (mm_account_pinned_pages(&uarg->mmp, size)) {
>> +		kfree_skb(skb);
>> +		return NULL;
>> +	}
>> +
>> +	INIT_LIST_HEAD(&zcopy_node_p->node);
>> +	zcopy_node_p->skb = skb;
>> +	uarg->ubuf.callback = msg_zerocopy_uarg_callback;
>> +	init_ubuf_info_msgzc(uarg, sk, size);
>>   	sock_hold(sk);
>>   
>>   	return &uarg->ubuf;
>> @@ -1699,7 +1735,7 @@ static inline struct sk_buff *skb_from_uarg(struct ubuf_info_msgzc *uarg)
>>   }
>>   
>>   struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
>> -				       struct ubuf_info *uarg)
>> +				       struct ubuf_info *uarg, bool usr_arg_notification)
>>   {
>>   	if (uarg) {
>>   		struct ubuf_info_msgzc *uarg_zc;
>> @@ -1707,7 +1743,8 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
>>   		u32 bytelen, next;
>>   
>>   		/* there might be non MSG_ZEROCOPY users */
>> -		if (uarg->callback != msg_zerocopy_callback)
>> +		if (uarg->callback != msg_zerocopy_callback &&
>> +		    uarg->callback != msg_zerocopy_uarg_callback)
>>   			return NULL;
>>   
>>   		/* realloc only when socket is locked (TCP, UDP cork),
>> @@ -1744,6 +1781,8 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
>>   	}
>>   
>>   new_alloc:
>> +	if (usr_arg_notification)
>> +		return msg_zerocopy_uarg_alloc(sk, size);
>>   	return msg_zerocopy_alloc(sk, size);
>>   }
>>   EXPORT_SYMBOL_GPL(msg_zerocopy_realloc);
>> @@ -1830,6 +1869,86 @@ void msg_zerocopy_callback(struct sk_buff *skb, struct ubuf_info *uarg,
>>   }
>>   EXPORT_SYMBOL_GPL(msg_zerocopy_callback);
>>   
>> +static bool skb_zerocopy_uarg_notify_extend(struct tx_msg_zcopy_node *node, u32 lo, u16 len)
>> +{
>> +	u32 old_lo, old_hi;
>> +	u64 sum_len;
>> +
>> +	old_lo = node->info.lo;
>> +	old_hi = node->info.hi;
>> +	sum_len = old_hi - old_lo + 1ULL + len;
>> +
>> +	if (sum_len >= (1ULL << 32))
>> +		return false;
>> +
>> +	if (lo != old_hi + 1)
>> +		return false;
>> +
>> +	node->info.hi += len;
>> +	return true;
>> +}
>> +
>> +static void __msg_zerocopy_uarg_callback(struct ubuf_info_msgzc *uarg)
>> +{
>> +	struct sk_buff *skb = skb_from_uarg(uarg);
>> +	struct sock *sk = skb->sk;
>> +	struct tx_msg_zcopy_node *zcopy_node_p, *tail;
>> +	struct tx_msg_zcopy_queue *zcopy_queue;
>> +	unsigned long flags;
>> +	u32 lo, hi;
>> +	u16 len;
>> +
>> +	mm_unaccount_pinned_pages(&uarg->mmp);
>> +
>> +	/* if !len, there was only 1 call, and it was aborted
>> +	 * so do not queue a completion notification
>> +	 */
>> +	if (!uarg->len || sock_flag(sk, SOCK_DEAD))
>> +		goto release;
>> +
>> +	/* only support TCP and UCP currently */
>> +	if (sk_is_tcp(sk)) {
>> +		zcopy_queue = &tcp_sk(sk)->tx_zcopy_queue;
>> +	} else if (sk_is_udp(sk)) {
>> +		zcopy_queue = &udp_sk(sk)->tx_zcopy_queue;
>> +	} else {
>> +		pr_warn("MSG_ZEROCOPY_UARG only support TCP && UDP sockets");
>> +		goto release;
>> +	}
>> +
>> +	len = uarg->len;
>> +	lo = uarg->id;
>> +	hi = uarg->id + len - 1;
>> +
>> +	zcopy_node_p = (struct tx_msg_zcopy_node *)skb->data;
>> +	zcopy_node_p->info.lo = lo;
>> +	zcopy_node_p->info.hi = hi;
>> +	zcopy_node_p->info.zerocopy = uarg->zerocopy;
>> +
>> +	spin_lock_irqsave(&zcopy_queue->lock, flags);
>> +	tail = list_last_entry(&zcopy_queue->head, struct tx_msg_zcopy_node, node);
>> +	if (!tail || !skb_zerocopy_uarg_notify_extend(tail, lo, len)) {
>> +		list_add_tail(&zcopy_node_p->node, &zcopy_queue->head);
>> +		skb = NULL;
>> +	}
>> +	spin_unlock_irqrestore(&zcopy_queue->lock, flags);
>> +release:
>> +	consume_skb(skb);
>> +	sock_put(sk);
>> +}
>> +
>> +void msg_zerocopy_uarg_callback(struct sk_buff *skb, struct ubuf_info *uarg,
>> +				bool success)
>> +{
>> +	struct ubuf_info_msgzc *uarg_zc = uarg_to_msgzc(uarg);
>> +
>> +	uarg_zc->zerocopy = uarg_zc->zerocopy & success;
>> +
>> +	if (refcount_dec_and_test(&uarg->refcnt))
>> +		__msg_zerocopy_uarg_callback(uarg_zc);
>> +}
>> +EXPORT_SYMBOL_GPL(msg_zerocopy_uarg_callback);
>> +
>>   void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
>>   {
>>   	struct sock *sk = skb_from_uarg(uarg_to_msgzc(uarg))->sk;
>> @@ -1838,7 +1957,7 @@ void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
>>   	uarg_to_msgzc(uarg)->len--;
>>   
>>   	if (have_uref)
>> -		msg_zerocopy_callback(NULL, uarg, true);
>> +		uarg->callback(NULL, uarg, true);
>>   }
>>   EXPORT_SYMBOL_GPL(msg_zerocopy_put_abort);
>>   
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 5ed411231fc7..a00ebd71f6ed 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2843,6 +2843,56 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>>   	case SCM_RIGHTS:
>>   	case SCM_CREDENTIALS:
>>   		break;
>> +	case SO_ZEROCOPY_NOTIFICATION:
>> +		if (sock_flag(sk, SOCK_ZEROCOPY)) {
>> +			int i = 0;
>> +			struct tx_usr_zcopy_info sys_zcopy_info;
>> +			struct tx_msg_zcopy_node *zcopy_node_p, *tmp;
>> +			struct tx_msg_zcopy_queue *zcopy_queue;
>> +			struct tx_msg_zcopy_node *zcopy_node_ps[SOCK_USR_ZC_INFO_MAX];
>> +			unsigned long flags;
>> +
>> +			if (cmsg->cmsg_len != CMSG_LEN(sizeof(void *)))
>> +				return -EINVAL;
>> +
>> +			if (sk_is_tcp(sk))
>> +				zcopy_queue = &tcp_sk(sk)->tx_zcopy_queue;
>> +			else if (sk_is_udp(sk))
>> +				zcopy_queue = &udp_sk(sk)->tx_zcopy_queue;
>> +			else
>> +				return -EINVAL;
>> +
>> +			spin_lock_irqsave(&zcopy_queue->lock, flags);
>> +			list_for_each_entry_safe(zcopy_node_p, tmp, &zcopy_queue->head, node) {
>> +				sys_zcopy_info.info[i].lo = zcopy_node_p->info.lo;
>> +				sys_zcopy_info.info[i].hi = zcopy_node_p->info.hi;
>> +				sys_zcopy_info.info[i].zerocopy = zcopy_node_p->info.zerocopy;
>> +				list_del(&zcopy_node_p->node);
>> +				zcopy_node_ps[i++] = zcopy_node_p;
>> +				if (i == SOCK_USR_ZC_INFO_MAX)
>> +					break;
>> +			}
>> +			spin_unlock_irqrestore(&zcopy_queue->lock, flags);
>> +
>> +			if (i > 0) {
>> +				sys_zcopy_info.length = i;
>> +				if (unlikely(copy_to_user(*(void **)CMSG_DATA(cmsg),
>> +							  &sys_zcopy_info,
>> +							  sizeof(sys_zcopy_info))
>> +					)) {
>> +					spin_lock_irqsave(&zcopy_queue->lock, flags);
>> +					while (i > 0)
>> +						list_add(&zcopy_node_ps[--i]->node,
>> +							 &zcopy_queue->head);
>> +					spin_unlock_irqrestore(&zcopy_queue->lock, flags);
>> +					return -EFAULT;
>> +				}
>> +
>> +				while (i > 0)
>> +					consume_skb(zcopy_node_ps[--i]->skb);
>> +			}
>> +		}
>> +		break;
>>   	default:
>>   		return -EINVAL;
>>   	}
>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>> index 1fe794967211..5adb737c4c01 100644
>> --- a/net/ipv4/ip_output.c
>> +++ b/net/ipv4/ip_output.c
>> @@ -1005,7 +1005,7 @@ static int __ip_append_data(struct sock *sk,
>>   	    (!exthdrlen || (rt->dst.dev->features & NETIF_F_HW_ESP_TX_CSUM)))
>>   		csummode = CHECKSUM_PARTIAL;
>>   
>> -	if ((flags & MSG_ZEROCOPY) && length) {
>> +	if (((flags & MSG_ZEROCOPY) || (flags & MSG_ZEROCOPY_UARG)) && length) {
>>   		struct msghdr *msg = from;
>>   
>>   		if (getfrag == ip_generic_getfrag && msg->msg_ubuf) {
>> @@ -1022,7 +1022,9 @@ static int __ip_append_data(struct sock *sk,
>>   				uarg = msg->msg_ubuf;
>>   			}
>>   		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>> -			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb));
>> +			bool user_args = flags & MSG_ZEROCOPY_UARG;
>> +
>> +			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb), user_args);
>>   			if (!uarg)
>>   				return -ENOBUFS;
>>   			extra_uref = !skb_zcopy(skb);	/* only ref on new uarg */
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index e767721b3a58..6254d0eef3af 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -462,6 +462,8 @@ void tcp_init_sock(struct sock *sk)
>>   
>>   	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>>   	sk_sockets_allocated_inc(sk);
>> +
>> +	tx_message_zcopy_queue_init(&tp->tx_zcopy_queue);
>>   }
>>   EXPORT_SYMBOL(tcp_init_sock);
>>   
>> @@ -1050,14 +1052,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>>   
>>   	flags = msg->msg_flags;
>>   
>> -	if ((flags & MSG_ZEROCOPY) && size) {
>> +	if (((flags & MSG_ZEROCOPY) || (flags & MSG_ZEROCOPY_UARG)) && size) {
>>   		if (msg->msg_ubuf) {
>>   			uarg = msg->msg_ubuf;
>>   			if (sk->sk_route_caps & NETIF_F_SG)
>>   				zc = MSG_ZEROCOPY;
>>   		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>> +			bool zc_uarg = flags & MSG_ZEROCOPY_UARG;
>>   			skb = tcp_write_queue_tail(sk);
>> -			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb));
>> +			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb), zc_uarg);
>>   			if (!uarg) {
>>   				err = -ENOBUFS;
>>   				goto out_err;
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 11460d751e73..6c62aacd74d6 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -1126,6 +1126,15 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>   		if (ipc.opt)
>>   			free = 1;
>>   		connected = 0;
>> +
>> +		/* If len is zero and flag MSG_ZEROCOPY_UARG is set,
>> +		 * it means this call just wants to get zcopy notifications
>> +		 * instead of sending packets. It is useful when users
>> +		 * finish sending and want to get trailing notifications.
>> +		 */
>> +		if ((msg->msg_flags & MSG_ZEROCOPY_UARG) &&
>> +		    sock_flag(sk, SOCK_ZEROCOPY) && len == 0)
>> +			return 0;
>>   	}
>>   	if (!ipc.opt) {
>>   		struct ip_options_rcu *inet_opt;
>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index b9dd3a66e423..891526ddd74c 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -1493,7 +1493,7 @@ static int __ip6_append_data(struct sock *sk,
>>   	    rt->dst.dev->features & (NETIF_F_IPV6_CSUM | NETIF_F_HW_CSUM))
>>   		csummode = CHECKSUM_PARTIAL;
>>   
>> -	if ((flags & MSG_ZEROCOPY) && length) {
>> +	if (((flags & MSG_ZEROCOPY) || (flags & MSG_ZEROCOPY_UARG)) && length) {
>>   		struct msghdr *msg = from;
>>   
>>   		if (getfrag == ip_generic_getfrag && msg->msg_ubuf) {
>> @@ -1510,7 +1510,8 @@ static int __ip6_append_data(struct sock *sk,
>>   				uarg = msg->msg_ubuf;
>>   			}
>>   		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>> -			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb));
>> +			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb),
>> +						    flags & MSG_ZEROCOPY_UARG);
>>   			if (!uarg)
>>   				return -ENOBUFS;
>>   			extra_uref = !skb_zcopy(skb);	/* only ref on new uarg */
>> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
>> index 2e4dc5e6137b..98f6905c5db9 100644
>> --- a/net/ipv6/udp.c
>> +++ b/net/ipv6/udp.c
>> @@ -1490,6 +1490,15 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>   		if (!(opt->opt_nflen|opt->opt_flen))
>>   			opt = NULL;
>>   		connected = false;
>> +
>> +		/* If len is zero and flag MSG_ZEROCOPY_UARG is set,
>> +		 * it means this call just wants to get zcopy notifications
>> +		 * instead of sending packets. It is useful when users
>> +		 * finish sending and want to get trailing notifications.
>> +		 */
>> +		if ((msg->msg_flags & MSG_ZEROCOPY_UARG) &&
>> +		    sock_flag(sk, SOCK_ZEROCOPY) && len == 0)
>> +			return 0;
>>   	}
>>   	if (!opt) {
>>   		opt = txopt_get(np);
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 16ff976a86e3..d6e6830f6ffe 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -84,7 +84,7 @@ static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>>   
>>   		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>>   					    iter->count,
>> -					    NULL);
>> +					    NULL, false);
>>   		if (!uarg)
>>   			return -1;
>>   
>> -- 
>> 2.20.1
>>
> 
> 

