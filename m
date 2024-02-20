Return-Path: <netdev+bounces-73124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8020185B0D2
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 03:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C081C21A15
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 02:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60FE3E485;
	Tue, 20 Feb 2024 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CYmB1hw9"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2944C73
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395673; cv=none; b=FeUoN6oAQjB9QAR7+iKV+//wet6Jvt8PQiT83DzaeHf9koTVOcH40be/EiHQNBOK2ZtttVBCsp9Facyo5lvzqvKHWSNduEnrs0IzGMC/o8nPUorlwHL6C9ORZqitqykzLfP0XzLRA/D523vjyUhdadMo76odsVJxyOzMc6HTvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395673; c=relaxed/simple;
	bh=1Vg3XtZsHz7xeUwpf5ALcIMT+nY0hjFYNYxbxGPzNTY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkfzwF40nXnrSGv01wyraJdB63PRlKrRYxNYpTsdX/Xg5csxB4XYA0dFNNAjeGC94Y6xb30PNPoZs5cqrtFUacLExrf1YnKdoXzrnoz0NvOJGtbUx4lkXaXEdnI/XFcR37JzOJHkC/mpf6DhfpcAPGgsiXNDEQ4xg9bXlrc2YFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CYmB1hw9; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0F80020016;
	Tue, 20 Feb 2024 10:21:08 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708395668;
	bh=X0oe+TQL6bjUZqVJCZRSUSH2FrXbI7m5DQWzdB1pw+Y=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=CYmB1hw9eMyJqR96qfv3TYXyLt/MtIwxmTeGWIqhRNtOkwvo1wL47yvFet0gY+gyP
	 +L+sVJSIiNIvoahH/WgxY8c884f3wylwjDwIRAOKG56krnrv9itqXUzQSrE30BfyGy
	 wmKnnRoKhP09cK1tMqyntUJElLCTjkZY8FEJLSYPc0+O9QHqXqjZTl+71X5Ia++z4b
	 58w97lYwCTThNYSscy5sKR2jNBY+NCUqqRCyPCnF+4pZKSjr6DflPG8nCaVnJkl3ju
	 DuZfKcJKasJWra1wPok42fqiH5BZCtnX5ITNOyPi4/ICLVTTnWjzbp6hoCj6+fKU8g
	 bR9fksWTB7VHw==
Message-ID: <202197c5a0b755c155828ef406d6250611815678.camel@codeconstruct.com.au>
Subject: Re: MCTP - Socket Queue Behavior
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "matt@codeconstruct.com.au"
	 <matt@codeconstruct.com.au>
Date: Tue, 20 Feb 2024 10:21:07 +0800
In-Reply-To: <SJ0PR19MB4415F935BD23A6D96794ABE687512@SJ0PR19MB4415.namprd19.prod.outlook.com>
References: 
	<SJ0PR19MB4415F935BD23A6D96794ABE687512@SJ0PR19MB4415.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dharma,

> Linux implementation of MCTP uses socket for communication with MCTP
> capable EP's. Socket calls can be made ASYNC by using fcntl. I have a
> query based on ASYNC properties of the MCTP socket.

Some of your questions aren't really specific to non-blocking sockets;
it seems like you're assuming that the blocking send case will wait for
a response before returning; that's not the case, as sendmsg() will
complete once the outgoing message is queued (more on what that means
below).

So, you still have the following case, still using a blocking socket:

  sendmsg(message1)
  sendmsg(message2)

  recvmsg() -> reply 1
  recvmsg() -> reply 2

- as it's entirely possible to have multiple messages in flight - either
  as queued skbs, or having being sent to the remote endpoint.

> 1. Does kernel internally maintain queue, for the ASYNC requests?

There is no difference between blocking or non-blocking mode in the
queueing implementation. There is no MCTP-protocol-specific queue for
sent messages.

(the blocking/nonblocking mode may affect how we wait to allocate a
skb, but it doesn't sound like that's what you're asking here)

However, once a message is packetised (possibly being fragmented into
multiple packets), those those *packets* may be queued to the device by
the netdev core. The transport device driver may have its own queues as
well.

In the case where you have multiple concurrent sendmsg() calls
(typically through separate threads, and either on one or multiple
sockets), it may be possible for packets belonging to two messages to be
interleaved on the wire. That scenario is well-supported by the MCTP
protocol through the packet tag mechanism.

> a. If so, what is the queue depth (can one send multiple requests
> without waiting for the response=20

The device queue depth depends on a few things, but has no impact on
ordering of requests to responses. It's certainly possible to have
multiple requests in flight at any one time: just call sendmsg()
multiple times, even in blocking mode.

(the practical limit for pending messages is 8, limited by the number of
MCTP tag values for any (remote-EID, local-EID, tag) tuple)

> and expect reply in order of requests)?

We have no control over reply ordering. It's entirely possible that
replies are sent out of sequence by the remote endpoint:

  local application          remote endpoint

  sendmsg(message 1)
  sendmsg(message 2)
                             receives message 1
                             receives message 2
                             sends a reply 2 to message 2
                             sends a reply 1 to message 1
  recvmsg() -> reply 2
  recvmsg() -> reply 1

So if a userspace application sends multiple messages concurrently, it
must have some mechanism to correlate the incoming replies with the
original request state. All of the upper-layer protocols that I have
seen have facilities for this (Instance ID in MCTP Control protocol,
Command Slot Index in NVMe-MI, Instance ID in PLDM, ...)

(You could also use the MCTP tags to achieve this correlation, but there
are very likely better ways in the upper-layer protocol)

> b. Does the Kernel maintain queue per socket connection?

MCTP is datagram-oriented, there is no "connection".

In terms of per-socket queues: there is the incoming socket queue
that holds received messages that are waiting for userspace to dequeue
via recvmsg() (or similar). However, there is nothing MCTP-specific
about this, it's all generic socket code.

> 2. Is FASYNC a mechanism for handling asynchronous events associated
> with a file descriptor and it doesn't provide parallelism for
> multiple send operation?

The non-blocking socket interfaces (FASYNC, O_NONBLOCK, MSG_DONTWAIT)
are mostly unrelated to whether your application sends multiple messages
at once. It's entirely possible to have multiple messages in flight
while using the blocking interfaces.

Cheers,


Jeremy

