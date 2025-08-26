Return-Path: <netdev+bounces-216826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDED7B35522
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52858686CAB
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A30023A99F;
	Tue, 26 Aug 2025 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLWwBNPi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F28F9CB
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192608; cv=none; b=maPrXTx++g0C4+f/RfRAmCIX7pAr86Kjs4t8QksrS59gP9oziCXVH0tguodB1KujT9DoDWykpxFeULKFi379zdgLLxyWnLS4yeOiYlqNedRn1JURzUgfCe4yIX9m65JZ8FMrw8+1+nCFSnyFHMPLyOxkEoWm8NfwfWnAvs5/4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192608; c=relaxed/simple;
	bh=gt2EoZMUwOD2aof7rqoXa9hh71naIVx0zgK8xYArSCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiY+X6mtmn6QMcyFimxi0QbdJRNj8DXxR3RubomYjhxxHBVFYd/NXiElixxhvg8havEzxqr3mPfy/Ywn/5uugJ88tOBrUD5wjGzXmQ9PZnahVLIi6Eomwn9RaHs3zvB6ZqeUCZde3uVymGnQ6Q+xd74HXVIwEJ9CqR1YcGL7xM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLWwBNPi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756192605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGOUm3ZjEWWgJcIKsRM9VeWilY612T+0VZjpf8fa9v0=;
	b=WLWwBNPiyKhDvc3pT/NIq8xjynW7yf+d+4CFyDOBCKo+VCTZKkz6SF4tI/mUk2ip2hBVSa
	mGchEntvniE+zVh6u+vbLUumQqoCAbTP75qYKI/0ghQRrljgZQ0/A159kGBKS9F9hMbsgh
	KR0kOeyFSnlXasv2x9PEGhGu29ZN0fY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-Y4X6wMPbPkueaM7M-17SSQ-1; Tue, 26 Aug 2025 03:16:43 -0400
X-MC-Unique: Y4X6wMPbPkueaM7M-17SSQ-1
X-Mimecast-MFC-AGG-ID: Y4X6wMPbPkueaM7M-17SSQ_1756192603
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c7e901so124655211cf.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 00:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192603; x=1756797403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGOUm3ZjEWWgJcIKsRM9VeWilY612T+0VZjpf8fa9v0=;
        b=tzCgmQ1h8DicqETQdINbOTmAWEgYzVJQSO5nx0MQ8I/ANfw0UGlNPho10VMN1hfIvE
         hGNfAn+aPxDw18aI6WDc7Pr7mvVfdnnxCqZLvK+AY8RzWi7C0OZ6U2TvOuWaJ7dylVYx
         LdqNRoqiEJXF6j9KCKcQOiE3uowGp0rbF4/I4Bu+1/ICJp2Nyc40CXL/91yxkuxI4tH7
         eRBpQbkg6eRgVIc+2uSCKqmwp1+7uGBX/+anaXFskqcKTLnuE+Ao9WQUbCrT1gOK/GKP
         FVBZNZnswUH5Vg+ptaIu5o+GL3kYdN0XIhdOGgxPQL/SQeV/FAy0Y6H0S8sRH4O8GvFc
         LsnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/pOYOiBilSQu+041JpIM6QvsdKs6EMcbME1B3mrmBzWYaztcxcJV2ZmTMhHpwVOUMFP4mcAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE9nC6O0ZNl0+pJV1yPkAR3qXkiG6/oUbkNHmSy2xs0gkmNUFq
	+AXLfeLrYXjTi+BHEskxLirqc28l+X2IqCPYM6b8tKkHFqYvrOR6m291MwIjU77LnKAyX4Y4qwV
	AfakjV2KEkuXsu7k9yN+an18o0W/Xmnqo4LZP0lD7APMZSxyB+UlisQISvQ==
X-Gm-Gg: ASbGnct+/7eHdcnCUwiPmz9xdm80WdCPJX37FLgofxRIKGS5OTVRJFMm0O6G5V8maeB
	RPSVXz7wXvpuDp+97k8caP9ggWFFfmfXKtiKGIzDdHqEyCqQkdJo78qM73KueIcR88Ahw7GCVI+
	pk4tU9E+pnZwbp77lfC0ytrvHrKJtlEepYkE2Yn52TXmVdRXNoIDyrJUkPd0JD3WxJuUHGdOyxZ
	5gK3Yhe55PhECu1C5BC+a1YwH6KmhyDL7y7yzBwwNzvkkNfwMk9Xgz4TecMuoN2IRtva1G3J+oI
	Y5tXT11InlaPoiOyAy1cWegYNRVkjPW220S21FP7/DY5OyT5h6doIxgXvBuQayMHP+gzHZwEW9j
	d8j9QyCQbMPo=
X-Received: by 2002:ac8:5fd1:0:b0:4b2:d981:9d58 with SMTP id d75a77b69052e-4b2d9819f59mr61203331cf.78.1756192602889;
        Tue, 26 Aug 2025 00:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIcFQ75f59/1pub7iKKCxPmTi45KpO6D6wPXA/4YgxG/tZglNPVRYp/LJrJZkR1p7+QDXfZA==
X-Received: by 2002:ac8:5fd1:0:b0:4b2:d981:9d58 with SMTP id d75a77b69052e-4b2d9819f59mr61203251cf.78.1756192602296;
        Tue, 26 Aug 2025 00:16:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7f2d292e466sm238522985a.41.2025.08.26.00.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:16:41 -0700 (PDT)
Message-ID: <8f09830a-d83d-43c9-b36b-88ba0a23e9b2@redhat.com>
Date: Tue, 26 Aug 2025 09:16:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: add new sk->sk_drops1 field
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
References: <20250825195947.4073595-1-edumazet@google.com>
 <20250825195947.4073595-4-edumazet@google.com>
 <6e645155-1d2d-4b64-a19a-a6e90a12b684@redhat.com>
 <CANn89iLNnYXH0z4BOc0UZjvbuZ5gWWHVTP1MrOHkVUq26szCKA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLNnYXH0z4BOc0UZjvbuZ5gWWHVTP1MrOHkVUq26szCKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/26/25 8:46 AM, Eric Dumazet wrote:
> On Mon, Aug 25, 2025 at 11:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 8/25/25 9:59 PM, Eric Dumazet wrote:
>>> sk->sk_drops can be heavily contended when
>>> changed from many cpus.
>>>
>>> Instead using too expensive per-cpu data structure,
>>> add a second sk->sk_drops1 field and change
>>> sk_drops_inc() to be NUMA aware.
>>>
>>> This patch adds 64 bytes per socket.
>>
>> I'm wondering: since the main target for dealing with drops are UDP
>> sockets, have you considered adding sk_drops1 to udp_sock, instead?
> 
> I actually saw the issues on RAW sockets, some applications were using them
> in a non appropriate way. This was not an attack on single UDP sockets, but
> a self-inflicted issue on RAW sockets.
> 
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Mar 7 16:29:43 2024 +0000
> 
>     ipv6: raw: check sk->sk_rcvbuf earlier
> 
>     There is no point cloning an skb and having to free the clone
>     if the receive queue of the raw socket is full.
> 
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Reviewed-by: Willem de Bruijn <willemb@google.com>
>     Link: https://lore.kernel.org/r/20240307162943.2523817-1-edumazet@google.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I see, thanks for the pointer. Perhaps something alike the following
(completely untested) could fit? With similar delta for raw sock and
sk_drops_{read,inc,reset} would check sk_drop_counters and ev. use it
instead of sk->sk_drop. Otherwise I have no objections at all!
---
diff --git a/include/net/sock.h b/include/net/sock.h
index 63a6a48afb48..3dd76c04bd86 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -102,6 +102,11 @@ struct net;
 typedef __u32 __bitwise __portpair;
 typedef __u64 __bitwise __addrpair;

+struct socket_drop_counters {
+	atomic_t sk_drops0 ____cacheline_aligned_in_smp;
+	atomic_t sk_drops1 ____cacheline_aligned_in_smp;
+};
+
 /**
  *	struct sock_common - minimal network layer representation of sockets
  *	@skc_daddr: Foreign IPv4 addr
@@ -449,6 +454,7 @@ struct sock {
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
+	struct socket_drop_counters *sk_drop_counters;
 	__cacheline_group_end(sock_read_rxtx);

 	__cacheline_group_begin(sock_write_rxtx);
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 4e1a672af4c5..45eec01fbbb2 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -108,6 +108,8 @@ struct udp_sock {
 	 * the last UDP socket cacheline.
 	 */
 	struct hlist_node	tunnel_list;
+
+	struct socket_drop_counters drop_counters;
};

 #define udp_test_bit(nr, sk)			\
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cc3ce0f762ec..eff90755b6ac 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1818,6 +1818,7 @@ static void udp_destruct_sock(struct sock *sk)
 int udp_init_sock(struct sock *sk)
 {
 	udp_lib_init_sock(sk);
+	sk->sk_drop_counters = &udp_sk(sk)->drop_counters;
 	sk->sk_destruct = udp_destruct_sock;
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	return 0;
---

>> Plus an additional conditional/casting in sk_drops_{read,inc,reset}.
>>
>> That would save some memory also offer the opportunity to use more
>> memory to deal with  NUMA hosts.
>>
>> (I had the crazy idea to keep sk_drop on a contended cacheline and use 2
>> (or more) cacheline aligned fields for udp_sock only).
> 
> I am working on rmem_alloc batches on both producer and consumer
> as a follow up of recent thread on netdev :
> 
> https://lore.kernel.org/netdev/aKh_yi0gASYajhev@bzorp3/T/#m392d5c87ab08d6ae005c23ffc8a3186cbac07cf2
> 
> Right now, when multiple cpus (running on different NUMA nodes) are
> feeding packets to __udp_enqueue_schedule_skb()
> we are touching two cache lines, my plan is to reduce this to a single one.

Obviously looking forward to it!

Thanks,

Paolo


