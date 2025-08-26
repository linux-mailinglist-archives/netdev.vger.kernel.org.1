Return-Path: <netdev+bounces-216845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0FB35804
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806392A4533
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033842874F5;
	Tue, 26 Aug 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dukWorCc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDE22820BA
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199160; cv=none; b=DDnunu8MX6Sz9WT4yP1eTCRXJwdxqaaazl+V5xYFgieFZN1StYXezUqM/7DsjNJDGqP3wtBKUroPhmIQKgdjI9MmRuHea67uU/GflRt+AK4/fFHhYNCx/hRLLjNY0emnioO49DFFqIyXmL8zzK6X6tMXBhZj82w3Wyltj+D0SKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199160; c=relaxed/simple;
	bh=rF9Am1Yzid/Jm5g/LlOtUyVYFUrDH+b5dV3gfybCfOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ossIPqzzX+l7ZAsa7rKszgoYzh36Gg821Rg1HhTI0PaiTjWtpnEJiYnZXUUmB8aNHjeNrX22dzv7EXCOZm8zcKxJYskF7+wXOcs+PbCUD5F4lkkdG6KWr306b6EHD7jc8vh1Zj1VOnEjpyyJCmOtV6G1FAhLy4A+Yvwuuo9eTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dukWorCc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756199158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MHo5H3mIDWBDpjMr1q5nuYEn9BTPnopBU4tC0IkY94=;
	b=dukWorCcxHKzBrd0EcLVOKPWnQgVnggWVN8Htuu83YUeeg02UC7M/VT+jvVUnj4rMOc8f5
	zkkDRRsaZdsaofQ41rDPbmfDyxX3fbF4VwyX2D9LOSZdVVgqWVa8sFdx2nShp4bpZ/sQo0
	YsW6uZ49h63s9A3vGOuUQ2CRTWZlKIs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-92NY1NkpNeelpZS2kRVT8A-1; Tue, 26 Aug 2025 05:05:56 -0400
X-MC-Unique: 92NY1NkpNeelpZS2kRVT8A-1
X-Mimecast-MFC-AGG-ID: 92NY1NkpNeelpZS2kRVT8A_1756199156
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2d09814efso31615211cf.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 02:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199156; x=1756803956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MHo5H3mIDWBDpjMr1q5nuYEn9BTPnopBU4tC0IkY94=;
        b=eR1B3NBdHgMi0RwsN0efOURl2HR7FYuvBAD0UsZ36WORUAx8bespMMa9RO/jFYwRdV
         iAvAvO2KPINHbdPdDtqkY/NjM/n9QUL36+TQH5EX+1rFWQKohhfgTOl2fP3/sxKmST02
         X5lxuugu06Z40uqWl2EyPb/KQ/caRVJ59UhDlHx1ugZLLhJCssT+SqPNwgO3QM9oi6Ne
         qnzKCJFyQ/U6wU6Qh8Q69bIjIXCz50reG2dIISYsn8LYGSD8tjb5u4R9U45PUqcFyMBB
         Z5KlPZnAS6zsZIib3fJchr3ZgYMmuHi8NciIWKhbNDda70vxemHyg0Ddc1dcJd5IOMSZ
         RYWA==
X-Forwarded-Encrypted: i=1; AJvYcCUdmNQNtVHq4wZYeE6pM8ysv03Bj0ncXEcNco17CTv0N0k6aRf1AgsyRNEW1K81zfwAy/y/+/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRqCxQg6jzwbZOZdTJLAuJTsx/s6sOp7b7fr4hO2eIoXKof3eo
	EJBlOaEoFGI9f0fEs9Eoy1isrDNWnJvVW5w0aCvLmNhWQf3prH4L0ES25vhQpbtQ2X4r899pKzz
	okDhBgPTorpJyKlm7mQGW61z3tECNUhFKS0GUIw6QAMT/sLDn4H+/pFGk7g==
X-Gm-Gg: ASbGncuKgROtTfXuIU8Y0S0GZ9KLr/x1QEcvzMTdfB921M/+IlLWCJeLwoXTK2RraoU
	0HW5rrdzM0bi3HRNJL/yO3iEAGw7SzMtcac4m8lG6B/IjnpSiEUQyufBJpOb5/c3CVe9Smlizmp
	u4MDtLaC65MYCdwRHeQBc45nc7TUeYKCs8PZlAOCbDpyedeYbLVqjbAt/HGQ7jV1fs5FbbEY3Sy
	c2Go79jS3YvrFeCsMUTd7KUgmIvNrZDhtQKF/C+ktAEzecbGlId5axKzizRNPYHw9nGKl9cjnuw
	yXfApd193J/+q+3/dOwQDyT137J0qM3MJV7gPnlvimUGcDqwJGFWU6yD7UVwAUEXpKRs5VJa6oj
	8eUiUvLApFLg=
X-Received: by 2002:a05:622a:15c7:b0:4b2:e166:7a84 with SMTP id d75a77b69052e-4b2e1667bb4mr24538631cf.0.1756199155441;
        Tue, 26 Aug 2025 02:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5hWfUAGjGThM9s464g2oD6cfZ5KM0cDcrbdKMSQH1bOmNu4hdeyST70zq36P8UQsuAfWXDQ==
X-Received: by 2002:a05:622a:15c7:b0:4b2:e166:7a84 with SMTP id d75a77b69052e-4b2e1667bb4mr24538371cf.0.1756199154930;
        Tue, 26 Aug 2025 02:05:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed8911aesm643603285a.19.2025.08.26.02.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:05:54 -0700 (PDT)
Message-ID: <ce4f62a8-1114-47b9-af08-51656e08c2b5@redhat.com>
Date: Tue, 26 Aug 2025 11:05:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 03/15] net: homa: create shared Homa header
 files
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-4-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818205551.2082-4-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:55 PM, John Ousterhout wrote:
> +/**
> + * struct homa_net - Contains Homa information that is specific to a
> + * particular network namespace.
> + */
> +struct homa_net {
> +	/** @net: Network namespace corresponding to this structure. */
> +	struct net *net;
> +
> +	/** @homa: Global Homa information. */
> +	struct homa *homa;

It's not clear why the above 2 fields are needed. You could access
directly the global struct homa instance, and 'struct net' is usually
available when struct home_net is avail.


> +/**
> + * is_homa_pkt() - Return true if @skb is a Homa packet, false otherwise.
> + * @skb:    Packet buffer to check.
> + * Return:  see above.
> + */
> +static inline bool is_homa_pkt(struct sk_buff *skb)
> +{
> +	int protocol;
> +
> +	/* If the network header hasn't been created yet, assume it's a
> +	 * Homa packet (Homa never generates any non-Homa packets).
> +	 */
> +	if (skb->network_header == 0)
> +		return true;
> +	protocol = (skb_is_ipv6(skb)) ? ipv6_hdr(skb)->nexthdr :
> +					ip_hdr(skb)->protocol;
> +	return protocol == IPPROTO_HOMA;
> +}

This helper is apparently unused in this series, just drop it / add it
later

> +#define UNIT_LOG(...)
> +#define UNIT_HOOK(...)

Also apparently unused.

> +extern unsigned int homa_net_id;
> +
> +/**
> + * homa_net_from_net() - Return the struct homa_net associated with a particular
> + * struct net.
> + * @net:     Get the Homa data for this net namespace.
> + * Return:   see above.
> + */
> +static inline struct homa_net *homa_net_from_net(struct net *net)

The customary name for this kind of helper is homa_net()

> +{
> +	return (struct homa_net *)net_generic(net, homa_net_id);
> +}
> +
> +/**
> + * homa_from_skb() - Return the struct homa associated with a particular
> + * sk_buff.
> + * @skb:     Get the struct homa for this packet buffer.
> + * Return:   see above.
> + */
> +static inline struct homa *homa_from_skb(struct sk_buff *skb)
> +{
> +	struct homa_net *hnet;
> +
> +	hnet = net_generic(dev_net(skb->dev), homa_net_id);
> +	return hnet->homa;

You can implement this using homa_net_from_skb(), avoiding some code
duplication

> +}
> +
> +/**
> + * homa_net_from_skb() - Return the struct homa_net associated with a particular
> + * sk_buff.
> + * @skb:     Get the struct homa for this packet buffer.
> + * Return:   see above.
> + */
> +static inline struct homa_net *homa_net_from_skb(struct sk_buff *skb)
> +{
> +	struct homa_net *hnet;
> +
> +	hnet = net_generic(dev_net(skb->dev), homa_net_id);
> +	return hnet;

You can implement this using homa_net(), avoid some code duplication.

> +}
> +
> +/**
> + * homa_clock() - Return a fine-grain clock value that is monotonic and
> + * consistent across cores.
> + * Return: see above.
> + */
> +static inline u64 homa_clock(void)
> +{
> +	/* As of May 2025 there does not appear to be a portable API that
> +	 * meets Homa's needs:
> +	 * - The Intel X86 TSC works well but is not portable.
> +	 * - sched_clock() does not guarantee monotonicity or consistency.
> +	 * - ktime_get_mono_fast_ns and ktime_get_raw_fast_ns are very slow
> +	 *   (27 ns to read, vs 8 ns for TSC)
> +	 * Thus we use a hybrid approach that uses TSC (via get_cycles) where
> +	 * available (which should be just about everywhere Homa runs).
> +	 */
> +#ifdef CONFIG_X86_TSC
> +	return get_cycles();
> +#else
> +	return ktime_get_mono_fast_ns();
> +#endif /* CONFIG_X86_TSC */
> +}

ktime_get*() variant are fast enough to allow e.g. pktgen deals with
millions of packets x seconds. Both tsc() and ktime_get_mono_fast_ns()
suffer of various inconsistencies which will cause the most unexpected
issues in the most dangerous situation. I strongly advice against this
early optimization.

> +/**
> + * homa_usecs_to_cycles() - Convert from units of microseconds to units of
> + * homa_clock().
> + * @usecs:   A time measurement in microseconds
> + * Return:   The time in homa_clock() units corresponding to @usecs.
> + */
> +static inline u64 homa_usecs_to_cycles(u64 usecs)
> +{
> +	u64 tmp;
> +
> +	tmp = usecs * homa_clock_khz();
> +	do_div(tmp, 1000);
> +	return tmp;
> +}

Apparently not used in this series.
FWIW do_div() would likely be much more costly than timestamp fetching.

> +
> +/* Homa Locking Strategy:
> + *
> + * (Note: this documentation is referenced in several other places in the
> + * Homa code)
> + *
> + * In the Linux TCP/IP stack the primary locking mechanism is a sleep-lock
> + * per socket. However, per-socket locks aren't adequate for Homa, because
> + * sockets are "larger" in Homa. In TCP, a socket corresponds to a single
> + * connection between two peers; an application can have hundreds or
> + * thousands of sockets open at once, so per-socket locks leave lots of
> + * opportunities for concurrency. With Homa, a single socket can be used for
> + * communicating with any number of peers, so there will typically be just
> + * one socket per thread. As a result, a single Homa socket must support many
> + * concurrent RPCs efficiently, and a per-socket lock would create a bottleneck
> + * (Homa tried this approach initially).
> + *
> + * Thus, the primary locks used in Homa spinlocks at RPC granularity. This
> + * allows operations on different RPCs for the same socket to proceed
> + * concurrently. Homa also has socket locks (which are spinlocks different
> + * from the official socket sleep-locks) but these are used much less
> + * frequently than RPC locks.
> + *
> + * Lock Ordering:
> + *
> + * There are several other locks in Homa besides RPC locks, all of which
> + * are spinlocks. When multiple locks are held, they must be acquired in a
> + * consistent order in order to prevent deadlock. Here are the rules for Homa:
> + * 1. Except for RPC and socket locks, all locks should be considered
> + *    "leaf" locks: don't acquire other locks while holding them.
> + * 2. The lock order is:
> + *    * RPC lock
> + *    * Socket lock
> + *    * Other lock
> + * 3. It is not safe to wait on an RPC lock while holding any other lock.
> + * 4. It is safe to wait on a socket lock while holding an RPC lock, but
> + *    not while holding any other lock.

The last 2 points are not needed: are obviously implied by the previous
ones.

> + *
> + * It may seem surprising that RPC locks are acquired *before* socket locks,
> + * but this is essential for high performance. Homa has been designed so that
> + * many common operations (such as processing input packets) can be performed
> + * while holding only an RPC lock; this allows operations on different RPCs
> + * to proceed in parallel. Only a few operations, such as handing off an
> + * incoming message to a waiting thread, require the socket lock. If socket
> + * locks had to be acquired first, any operation that might eventually need
> + * the socket lock would have to acquire it before the RPC lock, which would
> + * severely restrict concurrency.

FWIW, I think the above scheme can offer good performances if and only
if any operation requiring the socket lock is slow-path: multiple
RPCs/cores can content the same socket lock experiencing false sharing
and cache contention/misses and will hit performances badly.

If the operations requiring the socket lock are slow-path, the
RPC/socket lock order should be irrelevant for performances.

[...]
> +static inline void homa_skb_get(struct sk_buff *skb, void *dest, int offset,
> +				int length)
> +{
> +	memcpy(dest, skb_transport_header(skb) + offset, length);
> +}

Apparently unused.

/P


