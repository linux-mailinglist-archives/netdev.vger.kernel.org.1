Return-Path: <netdev+bounces-187710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5620AA90C9
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 12:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBE418972E3
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84F91FC104;
	Mon,  5 May 2025 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZghBQM+h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444815A8
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440425; cv=none; b=tm1ULLluZ4LW3d0EqCFAM8srrgIQ6Y44un3uP9fT6N67BLeueCn+CWhKDbcYmY7FWBhlugWrOWAdk9ju6Jq18GIbhQUCCXil/+X6p8j97zWVxndbkirxj5o6T1b2Kx5HuU236G2H+AFDSNOLE96vvAq4NJ+P4THb063kNZUSJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440425; c=relaxed/simple;
	bh=1q0KiD5Gt1yqXw7Y+iFSU8MDzySUGWLWfFaUy7qyoFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1CLfJa0fcQh0EkV4dTnRbLtfAqxTImdzo4fVTudtlqHURgDBxtFbCsaE4c1eVjoMpHJ4SP6HiATcZUWZpYlHaCxP46beEH6Wf4FLzZ7DsyG2RT3UEpdYa5LOuw35l8YN1FtiBqvfyPMuH5JVeAhycQqkcx9zC5jTr1HDQY4hdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZghBQM+h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746440422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xX5C1VaDkHWpoNEn9scG3WNylDkDETe0OqY0LqL1+Ps=;
	b=ZghBQM+himkS9MFhmGbQqEzOeXwawlpHS90MHzcGsrw0593JjLA9XRI7uzWjURUqWRJ0pP
	DJGSb8jAc4c9WNavOzAJS95kEmxXQOhlPR44CDFYkB1deluQ79dXIOJIFRataGa00QgEPN
	m7CGXos5aYEEmENyk90OWYrvLN31hIY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-2AZb2uWzPrSNflH4w_XY6Q-1; Mon, 05 May 2025 06:20:21 -0400
X-MC-Unique: 2AZb2uWzPrSNflH4w_XY6Q-1
X-Mimecast-MFC-AGG-ID: 2AZb2uWzPrSNflH4w_XY6Q_1746440420
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so30399985e9.1
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 03:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746440420; x=1747045220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xX5C1VaDkHWpoNEn9scG3WNylDkDETe0OqY0LqL1+Ps=;
        b=sdzM3KFyvCcUF/Uefb4Of623xFEBeauNgiwB4YN+I+yU3ZBzobJid9CiMnvAjD0Awy
         bSNSle/qca/XXvSwAK4P2cTzVGwWoHHv0/SDicOXY6ZdXIQzEMPIlgIyevfiDkfdSNXA
         oZeWmLjY/3qaWOl2wMEgtT6eLAhI6D0anQTPUCouMUnrhwoH9UOwZZC9TNvoWzi4nsuc
         B7NHkbcY9O2Cz9dOkKvSLif9RNctw4TrTJFwsjxfPRMTRayNqYE47xxN956s/k7gELxo
         uPXubHR4Qz9RGmrYsLqn2cIu46236b4G/ndVagl04bPk99LhdleRjYBYXDPRVV64/V1o
         9S8A==
X-Forwarded-Encrypted: i=1; AJvYcCVg71kfuBugN8BjSqP9V+ywO0yH8DvWVkti6n94JmC0yK4OqQohfrg8x9Q/xIt+U1uu9JcTbos=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqw4j6Gkl+us3aJiDJzFvwZI2bHK16WuvBZ04Glv0RKiScXdg+
	yp9lQwWWQW/1vqh2O7WCb41gd2bZWY/wRcFdDsPRMMcmUMJ9A7VlTXDxgNRPutwkiZ9slqyIFLr
	+WuFh4BNL6KbOoD2cFcYb+YL3xccetogClALI7ORIyUgz1lsp7LyONw==
X-Gm-Gg: ASbGnctrGy6QhKLTTKFLCR9bEb5iUjtJwiQUGgYuo4g+pyfW7bBiqdvpMwibguh8aJp
	5OALf0CmMoODvLfz12FH7aDyLSeh/bdP/DIo73hgz0c0M8vmdKbfvUQfIsDwiSBGRJoDthx86IW
	if/v3lnG3R5bvVpRLj0DPJIBKZ8RH6tB93WnK62gZQcVRvACqGGM0mjhSV25KRAsgSgIdCvbgHt
	9mPqMKkM3UPVrZseFnrHadddK20JSwCECkWWOe4wjZrn8zYB4pdPJ22uaVbfEu5WC4EvCTDTaNx
	kTdmg89PdJTAoPu1kIREa/GlQ09KESVE3t6R759VWymCHTfVlXLz6Bi8e+s=
X-Received: by 2002:a05:600c:8283:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-441c49483f8mr61593655e9.30.1746440420341;
        Mon, 05 May 2025 03:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJDdLb7cXPWDuOl+rtd+nJraEc73/KALgFwi1UqjkD1DwyXJd5fQQN6JL3USuftUBeiuqZAw==
X-Received: by 2002:a05:600c:8283:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-441c49483f8mr61593385e9.30.1746440419953;
        Mon, 05 May 2025 03:20:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ad781csm174083325e9.8.2025.05.05.03.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 03:20:19 -0700 (PDT)
Message-ID: <521265b1-1a32-4d5e-9348-77559a5a0af4@redhat.com>
Date: Mon, 5 May 2025 12:20:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/15] net: homa: create shared Homa header
 files
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-4-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250502233729.64220-4-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/25 1:37 AM, John Ousterhout wrote:
[...]
> +/* Forward declarations. */
> +struct homa;
> +struct homa_peer;
> +struct homa_rpc;
> +struct homa_sock;
> +
> +#define sizeof32(type) ((int)(sizeof(type)))

(u32) instead of (int). I think you should try to avoid using this
define, which is not very nice by itself.

> +
> +#ifdef __CHECKER__
> +#define __context__(x, y, z) __attribute__((context(x, y, z)))
> +#else
> +#define __context__(...)
> +#endif /* __CHECKER__ */

Why do you need to fiddle with the sparse annotation? Very likely this
should be dropped.

[...]
> +/**
> + * homa_get_skb_info() - Return the address of Homa's private information
> + * for an sk_buff.
> + * @skb:     Socket buffer whose info is needed.
> + * Return: address of Homa's private information for @skb.
> + */
> +static inline struct homa_skb_info *homa_get_skb_info(struct sk_buff *skb)
> +{
> +	return (struct homa_skb_info *)(skb_end_pointer(skb)) - 1;

This looks fragile. Why can't you use the skb control buffer here?

> +}
> +
> +/**
> + * homa_set_doff() - Fills in the doff TCP header field for a Homa packet.
> + * @h:     Packet header whose doff field is to be set.
> + * @size:  Size of the "header", bytes (must be a multiple of 4). This
> + *         information is used only for TSO; it's the number of bytes
> + *         that should be replicated in each segment. The bytes after
> + *         this will be distributed among segments.
> + */
> +static inline void homa_set_doff(struct homa_data_hdr *h, int size)
> +{
> +	/* Drop the 2 low-order bits from size and set the 4 high-order
> +	 * bits of doff from what's left.
> +	 */
> +	h->common.doff = size << 2;
> +}
> +
> +/** skb_is_ipv6() - Return true if the packet is encapsulated with IPv6,
> + *  false otherwise (presumably it's IPv4).
> + */
> +static inline bool skb_is_ipv6(const struct sk_buff *skb)
> +{
> +	return ipv6_hdr(skb)->version == 6;
> +}
> +
> +/**
> + * ipv6_to_ipv4() - Given an IPv6 address produced by ipv4_to_ipv6, return
> + * the original IPv4 address (in network byte order).
> + * @ip6:  IPv6 address; assumed to be a mapped IPv4 address.
> + * Return: IPv4 address stored in @ip6.
> + */
> +static inline __be32 ipv6_to_ipv4(const struct in6_addr ip6)
> +{
> +	return ip6.in6_u.u6_addr32[3];
> +}
> +
> +/**
> + * canonical_ipv6_addr() - Convert a socket address to the "standard"
> + * form used in Homa, which is always an IPv6 address; if the original address
> + * was IPv4, convert it to an IPv4-mapped IPv6 address.
> + * @addr:   Address to canonicalize (if NULL, "any" is returned).
> + * Return: IPv6 address corresponding to @addr.
> + */
> +static inline struct in6_addr canonical_ipv6_addr(const union sockaddr_in_union
> +						  *addr)
> +{
> +	struct in6_addr mapped;
> +
> +	if (addr) {
> +		if (addr->sa.sa_family == AF_INET6)
> +			return addr->in6.sin6_addr;
> +		ipv6_addr_set_v4mapped(addr->in4.sin_addr.s_addr, &mapped);
> +		return mapped;
> +	}
> +	return in6addr_any;
> +}
> +
> +/**
> + * skb_canonical_ipv6_saddr() - Given a packet buffer, return its source
> + * address in the "standard" form used in Homa, which is always an IPv6
> + * address; if the original address was IPv4, convert it to an IPv4-mapped
> + * IPv6 address.
> + * @skb:   The source address will be extracted from this packet buffer.
> + * Return: IPv6 address for @skb's source machine.
> + */
> +static inline struct in6_addr skb_canonical_ipv6_saddr(struct sk_buff *skb)
> +{
> +	struct in6_addr mapped;
> +
> +	if (skb_is_ipv6(skb))
> +		return ipv6_hdr(skb)->saddr;
> +	ipv6_addr_set_v4mapped(ip_hdr(skb)->saddr, &mapped);
> +	return mapped;
> +}
> +
> +static inline bool is_homa_pkt(struct sk_buff *skb)
> +{
> +	struct iphdr *iph = ip_hdr(skb);
> +
> +	return (iph->protocol == IPPROTO_HOMA);

What if this is an ipv6 packet? Also I don't see any use of this
function later on.

> +}
> +
> +/**
> + * homa_make_header_avl() - Invokes pskb_may_pull to make sure that all the
> + * Homa header information for a packet is in the linear part of the skb
> + * where it can be addressed using skb_transport_header.
> + * @skb:     Packet for which header is needed.
> + * Return:   The result of pskb_may_pull (true for success)
> + */
> +static inline bool homa_make_header_avl(struct sk_buff *skb)
> +{
> +	int pull_length;
> +
> +	pull_length = skb_transport_header(skb) - skb->data + HOMA_MAX_HEADER;
> +	if (pull_length > skb->len)
> +		pull_length = skb->len;
> +	return pskb_may_pull(skb, pull_length);
> +}
> +
> +#define UNIT_LOG(...)
> +#define UNIT_HOOK(...)

It looks like the above 2 define are unused later on.


> +extern unsigned int homa_net_id;
> +
> +void     homa_abort_rpcs(struct homa *homa, const struct in6_addr *addr,
> +			 int port, int error);
> +void     homa_abort_sock_rpcs(struct homa_sock *hsk, int error);
> +void     homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> +		      struct homa_rpc *rpc);
> +void     homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb);
> +int      homa_backlog_rcv(struct sock *sk, struct sk_buff *skb);
> +int      homa_bind(struct socket *sk, struct sockaddr *addr,
> +		   int addr_len);
> +void     homa_close(struct sock *sock, long timeout);
> +int      homa_copy_to_user(struct homa_rpc *rpc);
> +void     homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
> +void     homa_destroy(struct homa *homa);
> +int      homa_disconnect(struct sock *sk, int flags);
> +void     homa_dispatch_pkts(struct sk_buff *skb, struct homa *homa);
> +int      homa_err_handler_v4(struct sk_buff *skb, u32 info);
> +int      homa_err_handler_v6(struct sk_buff *skb,
> +			     struct inet6_skb_parm *opt, u8 type,  u8 code,
> +			     int offset, __be32 info);
> +int      homa_fill_data_interleaved(struct homa_rpc *rpc,
> +				    struct sk_buff *skb, struct iov_iter *iter);
> +struct homa_gap *homa_gap_new(struct list_head *next, int start, int end);
> +void     homa_gap_retry(struct homa_rpc *rpc);
> +int      homa_get_port(struct sock *sk, unsigned short snum);
> +int      homa_getsockopt(struct sock *sk, int level, int optname,
> +			 char __user *optval, int __user *optlen);
> +int      homa_hash(struct sock *sk);
> +enum hrtimer_restart homa_hrtimer(struct hrtimer *timer);
> +int      homa_init(struct homa *homa, struct net *net);
> +int      homa_ioctl(struct sock *sk, int cmd, int *karg);
> +int      homa_load(void);
> +int      homa_message_out_fill(struct homa_rpc *rpc,
> +			       struct iov_iter *iter, int xmit);
> +void     homa_message_out_init(struct homa_rpc *rpc, int length);
> +void     homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> +			   struct homa_rpc *rpc);
> +struct sk_buff *homa_new_data_packet(struct homa_rpc *rpc,
> +				     struct iov_iter *iter, int offset,
> +				     int length, int max_seg_data);
> +int      homa_net_init(struct net *net);
> +void     homa_net_exit(struct net *net);
> +__poll_t homa_poll(struct file *file, struct socket *sock,
> +		   struct poll_table_struct *wait);
> +int      homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> +		      int flags, int *addr_len);
> +void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
> +			 struct homa_sock *hsk);
> +void     homa_rpc_abort(struct homa_rpc *crpc, int error);
> +void     homa_rpc_acked(struct homa_sock *hsk,
> +			const struct in6_addr *saddr, struct homa_ack *ack);
> +void     homa_rpc_end(struct homa_rpc *rpc);
> +void     homa_rpc_handoff(struct homa_rpc *rpc);
> +int      homa_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
> +int      homa_setsockopt(struct sock *sk, int level, int optname,
> +			 sockptr_t optval, unsigned int optlen);
> +int      homa_shutdown(struct socket *sock, int how);
> +int      homa_softirq(struct sk_buff *skb);
> +void     homa_spin(int ns);
> +void     homa_timer(struct homa *homa);
> +int      homa_timer_main(void *transport);
> +void     homa_unhash(struct sock *sk);
> +void     homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
> +void     homa_unload(void);
> +int      homa_wait_private(struct homa_rpc *rpc, int nonblocking);
> +struct homa_rpc
> +	*homa_wait_shared(struct homa_sock *hsk, int nonblocking);
> +int      homa_xmit_control(enum homa_packet_type type, void *contents,
> +			   size_t length, struct homa_rpc *rpc);
> +int      __homa_xmit_control(void *contents, size_t length,
> +			     struct homa_peer *peer, struct homa_sock *hsk);
> +void     homa_xmit_data(struct homa_rpc *rpc, bool force);
> +void     homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk);
> +
> +int      homa_message_in_init(struct homa_rpc *rpc, int unsched);
> +void     homa_resend_data(struct homa_rpc *rpc, int start, int end);
> +void     __homa_xmit_data(struct sk_buff *skb, struct homa_rpc *rpc);

You should introduce the declaration of a given function in the same
patch introducing the implementation. That means the patches should be
sorted from the lowest level helper towards the upper layer.

[...]
> +static inline int homa_skb_append_to_frag(struct homa *homa,
> +					  struct sk_buff *skb, void *buf,
> +					  int length)
> +{
> +	char *dst = skb_put(skb, length);
> +
> +	memcpy(dst, buf, length);
> +	return 0;

The name is misleading as it does not append to an skb frag but to the
skb linear part

> +}
> +
> +static inline int  homa_skb_append_from_skb(struct homa *homa,
> +					    struct sk_buff *dst_skb,
> +					    struct sk_buff *src_skb,
> +					    int offset, int length)
> +{
> +	return homa_skb_append_to_frag(homa, dst_skb,
> +			skb_transport_header(src_skb) + offset, length);
> +}
> +
> +static inline void homa_skb_free_tx(struct homa *homa, struct sk_buff *skb)
> +{
> +	kfree_skb(skb);
> +}
> +
> +static inline void homa_skb_free_many_tx(struct homa *homa,
> +					 struct sk_buff **skbs, int count)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++)
> +		kfree_skb(skbs[i]);

'home' is unused here.

> +}
> +
> +static inline void homa_skb_get(struct sk_buff *skb, void *dest, int offset,
> +				int length)
> +{
> +	memcpy(dest, skb_transport_header(skb) + offset, length);
> +}
> +
> +static inline struct sk_buff *homa_skb_new_tx(int length)

please use 'alloc' for allocator.

/P


