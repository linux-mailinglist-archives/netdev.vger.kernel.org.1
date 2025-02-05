Return-Path: <netdev+bounces-162943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A57DA28915
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8E53A2960
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967221519BC;
	Wed,  5 Feb 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="l2XQXcQ+"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24DF15198E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754488; cv=none; b=Z2HqPWv0C0aQrd8YCAgjh4FSckDUOnPwwfSxlECbfybYhW7fFQ3VjEjLSpw9xLX+Om30j+TAIcBnoVam2EIdrCm5xbGp1uMr1qRd8+XsOWre4WY+JVCHVPeNMJfXGk0YfvxrvS6OnPmSpAlgtK4+bh0trvEbZkU3qi549XfIhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754488; c=relaxed/simple;
	bh=wC4ZSPavdgrkMNJsRCpMPJWle1EzRoFlYmR4iLGWvo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKNG0YblzZVYmCQ9Bk0K9TusR9uMLqJMvISmDI+9YjCW5TVVo/u8GeRPDqk35vjbsAfgb70ehymw3A8x5YhDJoOJt0ksLBWMdxbQ30kR21SugBs9qW5aaDMQqiDClpTYjSpVzmHtqHFdJMP9wS2+EDe4J15ng0/y4gSmsekKBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=l2XQXcQ+; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tfdT3-007Hvu-1q; Wed, 05 Feb 2025 12:21:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Gq50yz8J2ibkC5oqltQoTJImsQIwusgixJ8C+Dot1jA=; b=l2XQXcQ+/uiudnmgVLw85kcUUx
	bvhmM7g/gczf4lZCTriX88C9jOBFZhf6/zL1Z4ihUp10W4r6YUoXcbVazLzMgKqZNZFK9SaVqiCzp
	Spj4swkI5+eFoMgOX2EE3vLafX78JZk9UHcynjcGFY3HOpAkWThl4GlANn360ZbWOjk0KCaQveGUS
	yNeyCVwKYVd2gucjO/Vj+jbmqqo3rDfAf5tzVNTTx8dzufBwUa33Yyb8iP7RY0a0T8xAO3rBUdgn8
	pnqL+ocrmEadoC13SGW6/jnmgTqZfotsxRP59210/ngJBKxVEkj/N1ZysRRYplWSMmPzbVnBKk8Cf
	AYkkJQdA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tfdT2-0003fk-8l; Wed, 05 Feb 2025 12:21:16 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tfdSj-00CW8w-AC; Wed, 05 Feb 2025 12:20:57 +0100
Message-ID: <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>
Date: Wed, 5 Feb 2025 12:20:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-2-6eb1760fa93e@rbox.co>
 <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 11:48, Stefano Garzarella wrote:
> On Tue, Feb 04, 2025 at 01:29:53AM +0100, Michal Luczaj wrote:
>> ...
>> +static void test_stream_linger_client(const struct test_opts *opts)
>> +{
>> +	struct linger optval = {
>> +		.l_onoff = 1,
>> +		.l_linger = 1
>> +	};
>> +	int fd;
>> +
>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>> +	if (fd < 0) {
>> +		perror("connect");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>> +		perror("setsockopt(SO_LINGER)");
>> +		exit(EXIT_FAILURE);
>> +	}
> 
> Since we are testing SO_LINGER, will also be nice to check if it's 
> working properly, since one of the fixes proposed could break it.
> 
> To test, we may set a small SO_VM_SOCKETS_BUFFER_SIZE on the receive 
> side and try to send more than that value, obviously without reading 
> anything into the receiver, and check that close() here, returns after 
> the timeout we set in .l_linger.

I may be doing something wrong, but (at least for loopback transport) it
seems that close() lingers until data is received, not sent (without even
touching SO_VM_SOCKETS_BUFFER_SIZE).

```
import struct, fcntl, termios, time
from socket import *

def linger(s, timeout):
	if s.family == AF_VSOCK:
		s.setsockopt(SOL_SOCKET, SO_LINGER, (timeout<<32) | 1)
	elif s.family == AF_INET:
		s.setsockopt(SOL_SOCKET, SO_LINGER, struct.pack('ii', 1, timeout))
	else:
		assert False

def unsent(s):
	SIOCOUTQ = termios.TIOCOUTQ
	return struct.unpack('I', fcntl.ioctl(s, SIOCOUTQ, bytes(4)))[0]

def check_lingering(family, addr):
	lis = socket(family, SOCK_STREAM)
	lis.bind(addr)
	lis.listen()

	s = socket(family, SOCK_STREAM)
	linger(s, 2)
	s.connect(lis.getsockname())

	for _ in range(1, 1<<8):
		s.send(b'x')

	while unsent(s) != 0:
		pass

	print("closing...")
	ts = time.time()
	s.close()
	print(f"done in %ds" % (time.time() - ts))

check_lingering(AF_INET, ('127.0.0.1', 1234))
check_lingering(AF_VSOCK, (1, 1234)) # VMADDR_CID_LOCAL
```

Gives me:
closing...
done in 0s
closing...
done in 2s


