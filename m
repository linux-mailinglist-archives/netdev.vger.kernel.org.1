Return-Path: <netdev+bounces-172831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B91A56456
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019F8188682B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0C320D4FA;
	Fri,  7 Mar 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="fu7Sr2P9"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672C20C494
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341004; cv=none; b=V1/M/XOlDXzzesp5z+oSw1wPnJFrccT57aJygs7PvGIwk51b3A/cgHuUy6dfG/lNCnyH5fBnytPwrQPwQ7W87nYuX7Bj+v23Jdu8Q1lxMeHNTY20wnerHDDoS7unJiNCgA3sZ8WNgt49qajawNiA2X9zWHqNlYEHbi5OorNg9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341004; c=relaxed/simple;
	bh=M4wqjklMqzfihUfML6VrwR7iZe9eYYBerx1SZwPE/7M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h2mInp49FrLqercqfj5gTIwzUt3ALYVho2BBDDs9i6L5T3A8qk1fHMvq8Eq6Q5tydY6/ONOMQ44xXVdcZe4XQTPVpRLL4eM9RoCYpio4tSRTCGYkQrX14ls8ntKJ+mDCsGH24TyYXLz4rkt9r7SYptbx7Nmw2KrljVdbUyD//Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=fu7Sr2P9; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tqUL8-0034MY-RP; Fri, 07 Mar 2025 10:49:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=huDG7ZbIt8GugscEWq8ZXv1zuJ0zeGUze6o1l8zpPq8=; b=fu7Sr2P9jOwvFwnJnIKIRmQbPt
	c5VCqmhqTHDisuo4oInr7WKWCktyvjw6M5tDuOFmu5tkFJI33DpoHS8GxjzNAUta2pZyxlOaPtFWu
	snFP7ngD9BqYVmgQ6+nfuP14qIwJ6D6MmTKltppsp2lNsfgC6mtrwV3XOGx6gPovO1tfSP7EkDSGf
	Qk0DCdHsYnz/wpnrYEmO7svsp6JnMWCmA2fIZ4fJnTOQhCqzqAzl6/cKETAsR95lMhFPFTND4HDiH
	SPTOk8N93tedcb8ynJcnwXhs8OlEc8VfKEP3Q8eEkl+oEBRRyjourRAEoZB9vxZSfAM1XxHu6mnSW
	qeGw/tug==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tqUL7-0003jk-TV; Fri, 07 Mar 2025 10:49:58 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tqUL3-006fcY-La; Fri, 07 Mar 2025 10:49:53 +0100
Message-ID: <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
Date: Fri, 7 Mar 2025 10:49:52 +0100
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
Content-Language: pl-PL, en-GB
In-Reply-To: <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 11:18, Stefano Garzarella wrote:
> On Wed, Feb 05, 2025 at 12:20:56PM +0100, Michal Luczaj wrote:
>> On 2/4/25 11:48, Stefano Garzarella wrote:
>>> On Tue, Feb 04, 2025 at 01:29:53AM +0100, Michal Luczaj wrote:
>>>> ...
>>>> +static void test_stream_linger_client(const struct test_opts *opts)
>>>> +{
>>>> +	struct linger optval = {
>>>> +		.l_onoff = 1,
>>>> +		.l_linger = 1
>>>> +	};
>>>> +	int fd;
>>>> +
>>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>> +	if (fd < 0) {
>>>> +		perror("connect");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>> +
>>>> +	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>>>> +		perror("setsockopt(SO_LINGER)");
>>>> +		exit(EXIT_FAILURE);
>>>> +	}
>>>
>>> Since we are testing SO_LINGER, will also be nice to check if it's
>>> working properly, since one of the fixes proposed could break it.
>>>
>>> To test, we may set a small SO_VM_SOCKETS_BUFFER_SIZE on the receive
>>> side and try to send more than that value, obviously without reading
>>> anything into the receiver, and check that close() here, returns after
>>> the timeout we set in .l_linger.
>>
>> I may be doing something wrong, but (at least for loopback transport) ...
> 
> Also with VMs is the same, I think virtio_transport_wait_close() can be 
> improved to check if everything is sent, avoiding to wait.

What kind of improvement do you have in mind?

I've tried modifying the loop to make close()/shutdown() linger until
unsent_bytes() == 0. No idea if this is acceptable:

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 9e85424c8343..bd8b88d70423 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
 int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
 bool vsock_find_cid(unsigned int cid);
+void vsock_linger(struct sock *sk, long timeout);
 
 /**** TAP ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 7e3db87ae433..2cf7571e94da 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1013,6 +1013,25 @@ static int vsock_getname(struct socket *sock,
 	return err;
 }
 
+void vsock_linger(struct sock *sk, long timeout)
+{
+	if (timeout) {
+		DEFINE_WAIT_FUNC(wait, woken_wake_function);
+		ssize_t (*unsent)(struct vsock_sock *vsk);
+		struct vsock_sock *vsk = vsock_sk(sk);
+
+		add_wait_queue(sk_sleep(sk), &wait);
+		unsent = vsk->transport->unsent_bytes;
+
+		do {
+			if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
+				break;
+		} while (!signal_pending(current) && timeout);
+
+		remove_wait_queue(sk_sleep(sk), &wait);
+	}
+}
+
 static int vsock_shutdown(struct socket *sock, int mode)
 {
 	int err;
@@ -1056,6 +1075,8 @@ static int vsock_shutdown(struct socket *sock, int mode)
 		if (sock_type_connectible(sk->sk_type)) {
 			sock_reset_flag(sk, SOCK_DONE);
 			vsock_send_shutdown(sk, mode);
+			if (sock_flag(sk, SOCK_LINGER))
+				vsock_linger(sk, sk->sk_lingertime);
 		}
 	}
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 7f7de6d88096..9230b8358ef2 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1192,23 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
 	vsock_remove_sock(vsk);
 }
 
-static void virtio_transport_wait_close(struct sock *sk, long timeout)
-{
-	if (timeout) {
-		DEFINE_WAIT_FUNC(wait, woken_wake_function);
-
-		add_wait_queue(sk_sleep(sk), &wait);
-
-		do {
-			if (sk_wait_event(sk, &timeout,
-					  sock_flag(sk, SOCK_DONE), &wait))
-				break;
-		} while (!signal_pending(current) && timeout);
-
-		remove_wait_queue(sk_sleep(sk), &wait);
-	}
-}
-
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout)
 {
@@ -1279,7 +1262,7 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
 		(void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
 
 	if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
-		virtio_transport_wait_close(sk, sk->sk_lingertime);
+		vsock_linger(sk, sk->sk_lingertime);
 
 	if (sock_flag(sk, SOCK_DONE)) {
 		return true;


This works, but I find it difficult to test without artificially slowing
the kernel down. It's a race against workers as they quite eagerly do
virtio_transport_consume_skb_sent(), which decrements vvs->bytes_unsent.
I've tried reducing SO_VM_SOCKETS_BUFFER_SIZE as you've suggested, but
send() would just block until peer had available space.

Thanks,
Michal

