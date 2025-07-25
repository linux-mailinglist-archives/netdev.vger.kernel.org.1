Return-Path: <netdev+bounces-209985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A838B11B04
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 11:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E890D3B7D15
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713022D3749;
	Fri, 25 Jul 2025 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Uj6ivPW0"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451329E10C
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436543; cv=none; b=l3BRW0gcCuVREIyBu0qL3A6PFh5+4fhP0z313xbHD9Y1lwAobg4odVjwaBVc6gPEKp7EbFX42lq/gPfM1sGeOwz3AT7BDYUzjpc2wbgYPpldFgF0AYkLCfpRTQhD78U/d0HeWSAxhhiW0FOoy8Ylv4DLychiltea7nLkosxW/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436543; c=relaxed/simple;
	bh=Cw7xQg5oHZkmoVtuqtcalTJ5D4bZo76Bop+lS/l1Y5U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iPFUi0hCmJwHBhGnIBGGzVaMpzqLe9tpJz1I33oF6FzZDpS+epokEWWq1wNJArzXR3u7Xfz+NNk0z/nFUortq/ICmpbxVY8u4ei6z0iSjVjhM3dGgfaZagDVpqVyu2WriZfojexNPnk6XIQRfbjA89QUQxvaHZ3tr/N8I1RV1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Uj6ivPW0; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1ufEOS-00CbDJ-Oj; Fri, 25 Jul 2025 11:07:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=e7kzg3vB/GvFsVkQFUkD3UMXNqsS9iU6/ZF+H0o3//E=; b=Uj6ivPW0CLL8hJI//BGdB/lZcL
	SUR9oBPb9V3nxdM/prc+cyyaUQDujaxMjVkGZ9eAFcEaHCy9796N0OlwHePeP4l8+caX7om1SnkgJ
	JsFs7Y/P+20jdb97pzh9eqCxTfHw7Hi15DIzIyMxsMqJjKtBuK2U7wNBWmrdY+PhaaXaMDIpGja17
	a6MSu6+R2ILjAHBBcbc7PA2fYZ+MqP0WekfIhaEXlGoGVrgf6bIy9oD57/dmPzAotqNXDh2hPQcQu
	ymOQ3Us/7coAtZzpBtyOQjkYI8uONbQ3XS6xzU5sr1nYH1QYh7i9t+Uo5WD0joFoxVB5+3cd8uhru
	/XkO+fXw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1ufEOR-0008LF-SV; Fri, 25 Jul 2025 11:07:08 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1ufEOD-001SlG-Jp; Fri, 25 Jul 2025 11:06:53 +0200
Message-ID: <70371863-fa71-48e0-a1e5-fee83e7ca37c@rbox.co>
Date: Fri, 25 Jul 2025 11:06:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: vsock broken after connect() returns EINTR (was Re: [PATCH net
 2/2] vsock/test: Add test for SO_LINGER null ptr deref)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
 <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
 <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
 <d3a0a4e3-57bd-43f2-8907-af60c18d53ec@rbox.co>
 <js3gdbpaupbglmtowcycniidowz46fp23camtvsohac44eybzd@w5w5mfpyjawd>
Content-Language: pl-PL, en-GB
In-Reply-To: <js3gdbpaupbglmtowcycniidowz46fp23camtvsohac44eybzd@w5w5mfpyjawd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 15:07, Stefano Garzarella wrote:
> On Fri, Apr 11, 2025 at 04:43:35PM +0200, Michal Luczaj wrote:
...
>> Once connect() fails with EINTR (e.g. due to a signal delivery), retrying
>> connect() (to the same listener) fails. That is what the code below was
>> trying to show.
> 
> mmm, something is going wrong in the vsock_connect().
> 
> IIUC if we fails with EINTR, we are kind of resetting the socket.
> Should we do the same we do in vsock_assign_transport() when we found 
> that we are changing transport?
> 
> I mean calling release(), vsock_deassign_transport(). etc.
> I'm worried about having pending packets in flight.
> 
> BTW we need to investigate more, I agree.

I took a look. Once I've added a condition to break the connect() loop
(right after schedule_timeout(), on `sk_state == TCP_ESTABLISHED`), things
got a bit clearer for me.

Because listener keeps child socket in the accept_queue _and_
connected_table, every time we try to re-connect() our
VIRTIO_VSOCK_OP_REQUEST is answered with VIRTIO_VSOCK_OP_RST, which kills
the re-connect(). IOW:

L = socket()
listen(L)
				S = socket()
				connect(S, L)
					S.sk_state = TCP_SYN_SENT
					send VIRTIO_VSOCK_OP_REQUEST

				connect() is interrupted
					S.sk_state = TCP_CLOSE

L receives REQUEST
	C = socket()
	C.sk_state = TCP_ESTABLISHED
	add C to L.accept_queue
	add C to connected_table
	send VIRTIO_VSOCK_OP_RESPONSE

				S receives RESPONSE
					unexpected state:
					S.sk_state != TCP_SYN_SENT
					send VIRTIO_VSOCK_OP_RST

C receives RST
	virtio_transport_do_close()
		C.sk_state = TCP_CLOSING

				retry connect(S, L)
					S.sk_state = TCP_SYN_SENT
					send VIRTIO_VSOCK_OP_REQUEST

C (not L!) receives REQUEST
	send VIRTIO_VSOCK_OP_RST

				S receives RST, connect() fails
					S.sk_state = TCP_CLOSE
					S.sk_err = ECONNRESET

I was mistaken that flushing the accept queue, i.e. close(accept()), would
be enough to drop C from connected_table and let the re-connect() succeed.
In fact, for the removal to actually take place you need to wait a bit
after the flushing close(). What's more, child's vsock_release() might
throw a poorly timed OP_RST at a client -- affecting the re-connect().

Now, one thing we can do about this is: nothing. Let the user space handle
the client- and server-side consequences of client-side's signal delivery
(or timeout).

Another thing we can do is switch to a 3-way handshake. I think that would
also eliminate the need for vsock_transport_cancel_pkt(), which was
introduced in commit 380feae0def7 ("vsock: cancel packets when failing to
connect").

All the other options I was considering (based on the idea to send client
-> server OP_SHUTDOWN on connect() interrupt) are racy. Even if we make
server-side drop the half-open-broken child from accept_queue, user might
race us with accept().

L = socket()
listen(L)
				S = socket()
				connect(S, L)
					S.sk_state = TCP_SYN_SENT
					send VIRTIO_VSOCK_OP_REQUEST

				connect() is interrupted
					S.sk_state = TCP_CLOSE
					send VIRTIO_VSOCK_OP_SHUTDOWN|CHILD

L receives REQUEST
	C = socket()
	C.sk_state = TCP_ESTABLISHED
	add C to L.accept_queue
	add C to connected_table
	send VIRTIO_VSOCK_OP_RESPONSE

				S receives RESPONSE
					unexpected state:
					S.sk_state != TCP_SYN_SENT
					send VIRTIO_VSOCK_OP_RST

C receives SHUTDOWN
	if !flags.CHILD
		send VIRTIO_VSOCK_OP_RST
	virtio_transport_do_close()
		C.sk_state = TCP_CLOSING
	del C from connected_table
	// if flags.CHILD
	//	(schedule?) del C from L.accept_queue?
	//	racy anyway

L receives RST
	nothing (as RST reply to client's RST won't be send)

So that's all I could come up with. Please let me know what you think.

Thanks,
Michal


