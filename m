Return-Path: <netdev+bounces-173576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CDDA599ED
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E789188CCF8
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5F422E00A;
	Mon, 10 Mar 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yto1sMuq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271022B8AC
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620290; cv=none; b=Xm8U1PL1CujpktMPNEAbZ98Vul1r23L+8sAuXV5Qlhe126lwioSxqpA/vbCwdbmvfht4oWlLkmPyqyHB5s7t5vjInSLGQntBKRKTUT9QqccxF9+xidSNZ/0dw1ftS1+VdyHEP8rtlM8VxZkKKddh59BT0hC30eYS2RNFS/DC+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620290; c=relaxed/simple;
	bh=aoLgz/+B5M6Ue0urh34J2DEQqbA2DEThUix3a4L8j+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdKpKDoysHxZOBiapjw3Ek/Ajhs74+7pp+dcie/4po2dvqqzaOdR4elESgYqwGGF3J4TrNR9s4Rpe7Aeic4GLGORKNYJ7SaUgylAVZzMxS8qmMczlKq7PsPOKAtowlbmVChWeGDTxHfZLLG4YzNB5sQtanlQE5JATfK2MWCLVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yto1sMuq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741620287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DK6asDMWBozh4nnD9/ecKusAuaVfr39D6o2sOHql8QQ=;
	b=Yto1sMuq0TkQlwlaDL8zRsqUWgkr9poJrW68mwUKqsoGITggA+RtLNJW15vidaFoZU2/ht
	6YYJy2O7EgMkCk3f7Rha/PasENkuKIwyg4sWsMtWuU6eWBjxYNutLh1W48AT4piZY8Wqfk
	0aBdvapT98hev5m0H4BTAd1o+LcpEcg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663--6w3N7NqPMKPi2IQkbIPaw-1; Mon, 10 Mar 2025 11:24:44 -0400
X-MC-Unique: -6w3N7NqPMKPi2IQkbIPaw-1
X-Mimecast-MFC-AGG-ID: -6w3N7NqPMKPi2IQkbIPaw_1741620283
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912aab7a36so1670899f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 08:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741620283; x=1742225083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK6asDMWBozh4nnD9/ecKusAuaVfr39D6o2sOHql8QQ=;
        b=LjD80vsDsmOr8VFY8WdfRnuMcArgM9MoWa+kYS64EyaGO1+2nzrNCikqjuVdxFe4hD
         vtZNyBsnceurLhi0F/uFvg6ddPDWL7vCLtQYFvgEy0aNbtm/vCABgPGcha+LAINTcuKG
         u0bbfAdP3K9Hrp4yjBp+zUficDoFlI0Uc6f0GriLyb+6wJFWRt0EodpaBaIK9Q60nN0A
         fPPCAWIhcKk+ZZqYOVqIDUcaE+h2mIn+WtJ41R/MwmJxkJr3oJWqUPLApT//r5977+Nc
         sRKyHppVjowgHGpsmVZUCuyKuC9/ejzixy3dHN9ouwXBHYdGJZkAGagr8fAebjyz18TA
         offw==
X-Forwarded-Encrypted: i=1; AJvYcCVsiWAFjd1JJnzaT3qa8hjckE2XWiElUTpHy87xVJ4htTTP/PRc64VsoMsd4R1NBJBPcE+Nvro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8NpBhE3USdLvlezCZePfe+Zd6CYHtVx0O5fFuKgP1MeOrDAx
	WD5ccuBz0Bv7GTqW3dIwdqIwzcApLLPx2GRZbbGZfu7KnvIL6zViYKHZCbmUi13NYI9ccDoYEjk
	6MDVtbLMd/l5uILSy0g/4rI3F0O84PP5NG2MNBmhWsyzqNVdLnGCPdQ==
X-Gm-Gg: ASbGncspZzz8ibRm+4lVva4P8Q9XT+uWLUtbHGnk0yX1T/oH4yiazM/D/VJOVK0pZmg
	3tQwaEQLMfumw/q/nZsNXdBdRWzoxt20EiGtWPriSHl68aCfIiynY/wtqH20DjFmbiViBqzbD7C
	1g3OspaTI/I6g5SQeWD5JDNRyyGroYTbuH87VlsBRL8Bp5mBISn+09Q4eTTMM/uC7NIB3uiUW+v
	aNcLT80E6ozUDp9Ppo7i+7369N77hOvFZxPTmaBb7TFyAv1ZMhdVUYywrTQ4jwHXBs1XatODdZS
	2t5KLmSgJwkZueq4qBb5MMmRIr5OC1XUgLaT9FlVL7M4TsSme47pcxvAWwrj2R7P
X-Received: by 2002:a5d:47a2:0:b0:38d:d7a4:d447 with SMTP id ffacd0b85a97d-39132da0f2fmr8038496f8f.34.1741620283131;
        Mon, 10 Mar 2025 08:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQN6OVQ1ERenYck85dR/tsASM0tZl5g4GD00iL/oOsZyXtQUF9yRZHzjeixgZy14Jft6hXIw==
X-Received: by 2002:a5d:47a2:0:b0:38d:d7a4:d447 with SMTP id ffacd0b85a97d-39132da0f2fmr8038450f8f.34.1741620282509;
        Mon, 10 Mar 2025 08:24:42 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm15471309f8f.62.2025.03.10.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:24:41 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:24:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
Message-ID: <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-2-6eb1760fa93e@rbox.co>
 <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
 <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>
 <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>

On Fri, Mar 07, 2025 at 10:49:52AM +0100, Michal Luczaj wrote:
>On 2/10/25 11:18, Stefano Garzarella wrote:
>> On Wed, Feb 05, 2025 at 12:20:56PM +0100, Michal Luczaj wrote:
>>> On 2/4/25 11:48, Stefano Garzarella wrote:
>>>> On Tue, Feb 04, 2025 at 01:29:53AM +0100, Michal Luczaj wrote:
>>>>> ...
>>>>> +static void test_stream_linger_client(const struct test_opts *opts)
>>>>> +{
>>>>> +	struct linger optval = {
>>>>> +		.l_onoff = 1,
>>>>> +		.l_linger = 1
>>>>> +	};
>>>>> +	int fd;
>>>>> +
>>>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>>> +	if (fd < 0) {
>>>>> +		perror("connect");
>>>>> +		exit(EXIT_FAILURE);
>>>>> +	}
>>>>> +
>>>>> +	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>>>>> +		perror("setsockopt(SO_LINGER)");
>>>>> +		exit(EXIT_FAILURE);
>>>>> +	}
>>>>
>>>> Since we are testing SO_LINGER, will also be nice to check if it's
>>>> working properly, since one of the fixes proposed could break it.
>>>>
>>>> To test, we may set a small SO_VM_SOCKETS_BUFFER_SIZE on the receive
>>>> side and try to send more than that value, obviously without reading
>>>> anything into the receiver, and check that close() here, returns after
>>>> the timeout we set in .l_linger.
>>>
>>> I may be doing something wrong, but (at least for loopback transport) ...
>>
>> Also with VMs is the same, I think virtio_transport_wait_close() can be
>> improved to check if everything is sent, avoiding to wait.
>
>What kind of improvement do you have in mind?
>
>I've tried modifying the loop to make close()/shutdown() linger until
>unsent_bytes() == 0. No idea if this is acceptable:

Yes, that's a good idea, I had something similar in mind, but reusing 
unsent_bytes() sounds great to me.

The only problem I see is that in the driver in the guest, the packets 
are put in the virtqueue and the variable is decremented only when the 
host sends us an interrupt to say that it has copied the packets and 
then the guest can free the buffer. Is this okay to consider this as 
sending?

I think so, though it's honestly not clear to me if instead by sending 
we should consider when the driver copies the bytes into the virtqueue, 
but that doesn't mean they were really sent. We should compare it to 
what the network devices or AF_UNIX do.

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 9e85424c8343..bd8b88d70423 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> bool vsock_find_cid(unsigned int cid);
>+void vsock_linger(struct sock *sk, long timeout);
>
> /**** TAP ****/
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 7e3db87ae433..2cf7571e94da 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1013,6 +1013,25 @@ static int vsock_getname(struct socket *sock,
> 	return err;
> }
>
>+void vsock_linger(struct sock *sk, long timeout)
>+{
>+	if (timeout) {
>+		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+		ssize_t (*unsent)(struct vsock_sock *vsk);
>+		struct vsock_sock *vsk = vsock_sk(sk);
>+
>+		add_wait_queue(sk_sleep(sk), &wait);
>+		unsent = vsk->transport->unsent_bytes;

This is not implemented by all transports, so we should handle it in 
some way (check the pointer or implement in all transports).

>+
>+		do {
>+			if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>+				break;
>+		} while (!signal_pending(current) && timeout);
>+
>+		remove_wait_queue(sk_sleep(sk), &wait);
>+	}
>+}
>+
> static int vsock_shutdown(struct socket *sock, int mode)
> {
> 	int err;
>@@ -1056,6 +1075,8 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 		if (sock_type_connectible(sk->sk_type)) {
> 			sock_reset_flag(sk, SOCK_DONE);
> 			vsock_send_shutdown(sk, mode);
>+			if (sock_flag(sk, SOCK_LINGER))
>+				vsock_linger(sk, sk->sk_lingertime);

mmm, great, so on shutdown we never supported SO_LINGER, right?

> 		}
> 	}
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 7f7de6d88096..9230b8358ef2 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1192,23 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> 	vsock_remove_sock(vsk);
> }
>
>-static void virtio_transport_wait_close(struct sock *sk, long timeout)
>-{
>-	if (timeout) {
>-		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>-
>-		add_wait_queue(sk_sleep(sk), &wait);
>-
>-		do {
>-			if (sk_wait_event(sk, &timeout,
>-					  sock_flag(sk, SOCK_DONE), &wait))
>-				break;
>-		} while (!signal_pending(current) && timeout);
>-
>-		remove_wait_queue(sk_sleep(sk), &wait);
>-	}
>-}
>-
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout)
> {
>@@ -1279,7 +1262,7 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> 		(void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
>
> 	if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
>-		virtio_transport_wait_close(sk, sk->sk_lingertime);
>+		vsock_linger(sk, sk->sk_lingertime);
>
> 	if (sock_flag(sk, SOCK_DONE)) {
> 		return true;
>
>
>This works, but I find it difficult to test without artificially slowing
>the kernel down. It's a race against workers as they quite eagerly do
>virtio_transport_consume_skb_sent(), which decrements vvs->bytes_unsent.
>I've tried reducing SO_VM_SOCKETS_BUFFER_SIZE as you've suggested, but
>send() would just block until peer had available space.

Did you test with loopback or virtio-vsock with a VM?

BTW this approach LGTM!

Thanks,
Stefano


