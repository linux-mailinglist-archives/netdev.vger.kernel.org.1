Return-Path: <netdev+bounces-169453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B4A44017
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD42E3B8E8F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D382690C8;
	Tue, 25 Feb 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaTud2c5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F62686AF
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488689; cv=none; b=oeyVTMpcxuyVQ3kIm+UBCTr9N6pKIWa4ylvsR3TLb9h8ScYV9FvrnuJ3TxEKLRIt3SHrkVrg2E9GYtBrlvdKw1obDYh0UXgRzGRqnPVAsJyxPVb/i+8ZvCLCSDhtONTHAx40WgU9X97LiWbzxNipmEyeAkOrJ7pzsUpMX4ewVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488689; c=relaxed/simple;
	bh=PoqjAs48+8ee6d8AS/JvwD5Eq5M+o52O3KMWUPpMR28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkWS9jAU/6mD5KE+IqZ2pgn8S8Mh5BIgY3spl4iAsydDdf2GWI0Lj+5RQLYDsO/pc4m1GBK68V+mSs4YGlaYBh4tDQQl2j2BkC5inXnrmwZaothSWXkINskpr+zxtubd1oU1xchmrkKJCpoaQKDeiWDQkqbdP8lzMEEINOLibqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaTud2c5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740488686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEjZiA0tpgBSlB/iySqtUo2D0VDFNUAgdeGczXOHVDE=;
	b=GaTud2c5HIHMmftprbtdT0xJ1fLU8YLuxXPXiJ8M2CRN67uJmbnS71Dry9JNNpBuaG7cgF
	+Y10xwcG+sEt9MOjD44Rs12RQcfGcFAgmMjnsuOmJg2K6ohhJO3hyFiLCP5DwoNMGUqxSK
	RVpFYfMW81yJSF7ttDSWbS5eb4TSsK4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-o-eGLm6qNpuKTx9EPW_cPg-1; Tue, 25 Feb 2025 08:04:45 -0500
X-MC-Unique: o-eGLm6qNpuKTx9EPW_cPg-1
X-Mimecast-MFC-AGG-ID: o-eGLm6qNpuKTx9EPW_cPg_1740488684
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f39352f1dso2206261f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 05:04:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740488684; x=1741093484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEjZiA0tpgBSlB/iySqtUo2D0VDFNUAgdeGczXOHVDE=;
        b=Sl5qJ2uECnjd+CvjZqRehi1eaJ51noFav3tuBORTEDb0ajQ/Bl2LltW4aLFbpSvMJA
         X7AIWvXYaVP2w3itOkjHvQGiJ46sZft3VFfhvc/j1HWSF6gNpnS8Wve2IVfDBQUFL8/R
         +G0tDdOvn6acalAIhGin6SLg0cNQMerBtSLLMtgNAYfMQ2pOKEIR6+QaXO5flx7Qe/dw
         dtuO4EI3OVRTvVVEqrZJ7c+dVvCEOLBp6pcnykYrupSsBGxu6ZI1dOS/E66MCgrM9QGm
         /MVaVR1ekdrEDxPK+F7oS9o5IAEfgQ53i87ENDRM6d32kSHxpfD6/aYMIVRGmei8vVOd
         hRTw==
X-Forwarded-Encrypted: i=1; AJvYcCUvSJpDiIRUpYQkk6XPOVmL2sn+wHQoQ4YGyCXWQpUiL5dkgh4sc81enrLq/qv0pfo0naje5+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DQ46EjMflFn0B6RrXzjdi0UCVQHvbfxYGqYl3LB+/gx3IENB
	Rsm4jxJntmZAf7HHjiLdDplfAETZvDuvMZJebpLFa2o3OPxc+Z7MlnJ7k8O0e0OdDblYVFx4LqG
	SjNDe8oKGkFbwnbh1IYDN4BOaEikpMn7LPC7kzm9Di2QzkdpUk+mo5Q==
X-Gm-Gg: ASbGncszlRkEC+undzpTwvhvmiB1knI6ueZPX48xILywq63Dkf4yi4UiEKCK9AxHEFO
	TnPuM5F9A9u/+04fk1WPWQTRSCeVqHJtuOmHsy6eosbiDL6hQi/8yvyAIFE/TsCfAQoUwbruI6e
	7TMBtfV8ls4aXK+zelR1EzCW2HGv75QVVPrOr8RuftlBJ47hsjmlJEuVWP5x/RRzUfRGv3+jpfL
	FzP8W9OLtwAyExP7qb7InA7OhC+O+xyZHxG/MUSoIZ89QpKkB2hE7AyJeBOFiy/35f7bLzmh4tz
	Bsy1tQWukIgZs0vc8XKCn1dFY7lOIdFGWc6S9vZOoOE=
X-Received: by 2002:a05:6000:1a87:b0:38f:3344:361e with SMTP id ffacd0b85a97d-38f7079ec17mr15303977f8f.23.1740488684074;
        Tue, 25 Feb 2025 05:04:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzXYHaIMYF6GMizRa4fNCOG8+4IpljILlUq8KxSNpA12i9exQXViaMTl+bM5c0ACpAig5+BQ==
X-Received: by 2002:a05:6000:1a87:b0:38f:3344:361e with SMTP id ffacd0b85a97d-38f7079ec17mr15303910f8f.23.1740488683687;
        Tue, 25 Feb 2025 05:04:43 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab37403cfsm15578055e9.1.2025.02.25.05.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:04:43 -0800 (PST)
Message-ID: <a814c41a-40f9-4632-a5bb-ad3da5911fb6@redhat.com>
Date: Tue, 25 Feb 2025 14:04:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-4-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250222191517.743530-4-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/25 8:15 PM, Mina Almasry wrote:
[...]
> @@ -119,6 +122,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	unsigned long xa_idx;
>  	unsigned int rxq_idx;
>  
> +	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +
> +	/* Ensure no tx net_devmem_lookup_dmabuf() are in flight after the
> +	 * erase.
> +	 */
> +	synchronize_net();

Is the above statement always true? can the dmabuf being stuck in some
qdisc? or even some local socket due to redirect?

> @@ -252,13 +261,23 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  	 * binding can be much more flexible than that. We may be able to
>  	 * allocate MTU sized chunks here. Leave that for future work...
>  	 */
> -	binding->chunk_pool =
> -		gen_pool_create(PAGE_SHIFT, dev_to_node(&dev->dev));
> +	binding->chunk_pool = gen_pool_create(PAGE_SHIFT,
> +					      dev_to_node(&dev->dev));
>  	if (!binding->chunk_pool) {
>  		err = -ENOMEM;
>  		goto err_unmap;
>  	}
>  
> +	if (direction == DMA_TO_DEVICE) {
> +		binding->tx_vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> +						 sizeof(struct net_iov *),
> +						 GFP_KERNEL);
> +		if (!binding->tx_vec) {
> +			err = -ENOMEM;
> +			goto err_free_chunks;

Possibly my comment on v3 has been lost:

"""
It looks like the later error paths (in the for_each_sgtable_dma_sg()
loop) could happen even for 'direction == DMA_TO_DEVICE', so I guess an
additional error label is needed to clean tx_vec on such paths.
"""

[...]
> @@ -1071,6 +1072,16 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  
>  	flags = msg->msg_flags;
>  
> +	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags),
> +					.dmabuf_id = 0 };
> +	if (msg->msg_controllen) {
> +		err = sock_cmsg_send(sk, msg, &sockc);
> +		if (unlikely(err)) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +	}

I'm unsure how much that would be a problem, but it looks like that
unblocking sendmsg(MSG_FASTOPEN) with bad msg argument will start to
fail on top of this patch, while they should be successful (EINPROGRESS)
before.

/P


