Return-Path: <netdev+bounces-174918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F5A614D0
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 16:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEE93BE409
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B95220127E;
	Fri, 14 Mar 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Ov3UmNuu"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78920127B
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965931; cv=none; b=jEK5xDlvnZfrH+FmR9qfRwI6ShStJk7wLWN6Q510VQ9qdwjwkwX1hKDIh/f0fttTKTphEVPIhGXsl3qMydLevc7nGHKvDGv+O0G3H6Kh9HQ5zdFedxD5WGpJQ9TRTqvM1UoXNRHJtbzGL5MQ8mwRHFQA9Ev+XAQDq5W6AjfBWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965931; c=relaxed/simple;
	bh=Efld773UrjiC7MqVyTE2H+2Z0zyZxwvJ4m+3qwF2Vag=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lV7IdCoR0lFIlIcb9Mb+yd9tsZ0tU1CuTMFgXbrytqONV5lUMyrduuXymX/MwgmvGSFkGr9Ff5RCglpLwp2Pl7xGvoTAXUW20vBCdHdx+/JcAow/bIt3TfHquW8ZQwvdtRwEIg3k9yISteCyQ7J+LzLH63+xN48akE1PMbGzVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Ov3UmNuu; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tt6ua-006G0N-UQ; Fri, 14 Mar 2025 16:25:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=GF8yeAEcYt6IruWxZy5cXJiDkIgb44Nnne8Yo4cgb/Q=; b=Ov3UmNuuVXkLo/+/V6/b85Rk3d
	5lBQDSww8s2gaPk9lol1zvBNhjY1zPCKW7c6W3AAsYzdyPz+Q2u2hEiSKKxIvuuy2soXXTztK+h/f
	YRQbKOJ9c0vqXdPO2a/Ovx+GBM3rKOAFnqeaKTuMjDDQ07VrsJsUj/Pah1BJL8kOInp2tirokcEVG
	7HxW4fexei1pdTJtgS9VX3K3ttKMRoGM7IY4WqKNXtvYMPOmz6M15crndke43ZjNVOhmZpQGPAhKZ
	P/N9asntUHewlxpwokj3JCpfzj8Jsp/G2cRwHEtwbGvQXkQ09wL74TWcndMH4SPrx5Iypph5sO/Ht
	GUQrdF4Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tt6ua-0004nO-71; Fri, 14 Mar 2025 16:25:24 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tt6uZ-00H1YK-7A; Fri, 14 Mar 2025 16:25:23 +0100
Message-ID: <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
Date: Fri, 14 Mar 2025 16:25:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-2-6eb1760fa93e@rbox.co>
 <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
 <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>
 <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
Content-Language: pl-PL, en-GB
In-Reply-To: <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 16:24, Stefano Garzarella wrote:
> On Fri, Mar 07, 2025 at 10:49:52AM +0100, Michal Luczaj wrote:
>> ...
>> I've tried modifying the loop to make close()/shutdown() linger until
>> unsent_bytes() == 0. No idea if this is acceptable:
> 
> Yes, that's a good idea, I had something similar in mind, but reusing 
> unsent_bytes() sounds great to me.
> 
> The only problem I see is that in the driver in the guest, the packets 
> are put in the virtqueue and the variable is decremented only when the 
> host sends us an interrupt to say that it has copied the packets and 
> then the guest can free the buffer. Is this okay to consider this as 
> sending?
>
> I think so, though it's honestly not clear to me if instead by sending 
> we should consider when the driver copies the bytes into the virtqueue, 
> but that doesn't mean they were really sent. We should compare it to 
> what the network devices or AF_UNIX do.

I had a look at AF_UNIX. SO_LINGER is not supported. Which makes sense;
when you send a packet, it directly lands in receiver's queue. As for
SIOCOUTQ handling: `return sk_wmem_alloc_get(sk)`. So I guess it's more of
an "unread bytes"?

>> +void vsock_linger(struct sock *sk, long timeout)
>> +{
>> +	if (timeout) {
>> +		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>> +		ssize_t (*unsent)(struct vsock_sock *vsk);
>> +		struct vsock_sock *vsk = vsock_sk(sk);
>> +
>> +		add_wait_queue(sk_sleep(sk), &wait);
>> +		unsent = vsk->transport->unsent_bytes;
> 
> This is not implemented by all transports, so we should handle it in 
> some way (check the pointer or implement in all transports).

Ah, right, I didn't think that through.

>> @@ -1056,6 +1075,8 @@ static int vsock_shutdown(struct socket *sock, int mode)
>> 		if (sock_type_connectible(sk->sk_type)) {
>> 			sock_reset_flag(sk, SOCK_DONE);
>> 			vsock_send_shutdown(sk, mode);
>> +			if (sock_flag(sk, SOCK_LINGER))
>> +				vsock_linger(sk, sk->sk_lingertime);
> 
> mmm, great, so on shutdown we never supported SO_LINGER, right?

Yup.

>> ...
>> This works, but I find it difficult to test without artificially slowing
>> the kernel down. It's a race against workers as they quite eagerly do
>> virtio_transport_consume_skb_sent(), which decrements vvs->bytes_unsent.
>> I've tried reducing SO_VM_SOCKETS_BUFFER_SIZE as you've suggested, but
>> send() would just block until peer had available space.
> 
> Did you test with loopback or virtio-vsock with a VM?

Both, but I may be missing something. Do you see a way to stop (or don't
schedule) the worker from processing queue (and decrementing bytes_unsent)?

Thanks,
Michal

