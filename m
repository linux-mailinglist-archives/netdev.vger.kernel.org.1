Return-Path: <netdev+bounces-164639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB3CA2E92C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3BD16206A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839C81CD219;
	Mon, 10 Feb 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVnO9qxC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF01CD213
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182736; cv=none; b=hI26kyeRH+GDH7qAOeFxqSFs/nFMqsMx+F5KZ9qjHq4ZF9CQ3mfrhP/6mcsvbqh2JJjRQSIGos7qSmqaFDXwA53vsKFvIxay23ZL1Duhi3RHiZpzw669ebfypybwGH9wKdkiIz8gDXepnRvBYN2l2F+DSRixda/X+E+8H4E8Kjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182736; c=relaxed/simple;
	bh=toBq8ao5ulma1PGaQoH6GOc583fwuhkt+ho+yDVJkaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqDeuYPkPAG2B1fBB71flx7SPS/gDI181Pv0wp0D3IaM8q1kza8/OZV4eRcAhe8Gzg1od9yBC60kzwaKGPnQmz+jl1DAqf6GyJf2wbPZpkX+SwPORd9G24vB6PucvjcSEncw7EeXhmEbMQrCWu2v0Sj2wkCRqnnXIC+OglG4VPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVnO9qxC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739182731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNFNsRnUDwZy+nRKMqXmAwrAdYaoOa6UkCTEVB/Y5kg=;
	b=UVnO9qxCvFUBxWHwUIzXCMRT+jnogied4tRFd+8oDwR5P08CBPi+GjjlrG/GiBhEQsUwS2
	bv8oj4QIetQztjkl+vUKqx5/53PqJ+RFP5Z5G77aV8z4Rl1wOdGS2kLhSQZDRypz+btuuK
	tijKGBqrO/pX3KHQQA9ZNZAKLlcPyZw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-bmzrYCGLODikfS9aDT6lZg-1; Mon, 10 Feb 2025 05:18:50 -0500
X-MC-Unique: bmzrYCGLODikfS9aDT6lZg-1
X-Mimecast-MFC-AGG-ID: bmzrYCGLODikfS9aDT6lZg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38de0201875so293668f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739182729; x=1739787529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNFNsRnUDwZy+nRKMqXmAwrAdYaoOa6UkCTEVB/Y5kg=;
        b=Fz+V8tS6i1dGKpZ0MXG11NU/BVRaBFtqvQPP4nVLHNzK2tFMTNcSv11lwP86pAytPz
         M42EEzIFqguxyWRmnxtrtfy9weO+P1qbHYL6aKskaUtWCQoffHiFB4oqDXvlpfPAGmTH
         SncBGIlNDUMAtVzRIJYLGZnytBzlAobaz2QfDwmxY5rVNUYtakwBsyUu46mbc3DYP9D9
         S93dAdA6KbQlQlMScpETQFP5zrqrm3tNvb+n2ZViExVonOltnD0EfBl1Dcds8p58szuY
         HSWy1lBjIcbEJ9Ru9Gd7RTWMYM7hi0SURQKzIfDCm7dKKK31MqZbzWkuftAdNkJN4T7E
         kcpA==
X-Forwarded-Encrypted: i=1; AJvYcCW4nFleTVTjEFeomqN7xAafC9ZGFvMYfMfs60b+KmkRRtOhABJdE+IppEyUb5bEe4cQoVA0/cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXiZeQEoz+YXukxxjetkB1ej/PXbptU+TlfIx5Gh697ZQg1wT
	HE9S/E1PiQZB6tM+roJjWQTUtCSxZ1SzV5tIye7uELZCvoQ3PWKzLhAeIyCddC4LLCANFH32taq
	hxraK6nNR7qHdePDxJxBtNeYIbiHlh4VNgPPIKXr57wZyZfAjcf5AZ0QvOQLIkQ==
X-Gm-Gg: ASbGncvmJ+fqfjLo7iPYxsFdsqfzB+MmnwUUDGD9HoUTow15yMXmA2DTfNgY7tCOppM
	AZiAiRw7vgNKUNfpgmWqCMsMI+/nWbNJxgCBGz/cTI974gvbBwMgdoDKzsWzFZXmC/Nm3bkm58p
	YiQ+UatCZYG4nJKebiZvjlALrQ0xpJY2pHH6rJzzCoe8tsV6i6UMjqjVtJ/io8Mxck0XrfWuKdz
	QR2LRs4D+T+JcARwhd3n2ciohuJIKjP7pnDTlUjQmC7lJmNVV2YF9d5TtC+fGwkw59aVGXmgfV+
	6gX9yhqvF9QDsoQzTV4vg0tY7A4OAl9/DA0vvBlgWO1pBXx/mFm5fA==
X-Received: by 2002:a05:6000:1448:b0:38d:b4c4:9f47 with SMTP id ffacd0b85a97d-38dc8da6665mr10332862f8f.3.1739182728811;
        Mon, 10 Feb 2025 02:18:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFImNQz2ZL2Jip+LcFIH0iQm1f1hwZG7FzSiWlKNe5OmlnXiW000OQ/Z63tEyXeHUIf5bNj3g==
X-Received: by 2002:a05:6000:1448:b0:38d:b4c4:9f47 with SMTP id ffacd0b85a97d-38dc8da6665mr10332806f8f.3.1739182728095;
        Mon, 10 Feb 2025 02:18:48 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc33939f3sm11028304f8f.17.2025.02.10.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:18:47 -0800 (PST)
Date: Mon, 10 Feb 2025 11:18:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Add test for SO_LINGER null ptr deref
Message-ID: <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-2-6eb1760fa93e@rbox.co>
 <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
 <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>

On Wed, Feb 05, 2025 at 12:20:56PM +0100, Michal Luczaj wrote:
>On 2/4/25 11:48, Stefano Garzarella wrote:
>> On Tue, Feb 04, 2025 at 01:29:53AM +0100, Michal Luczaj wrote:
>>> ...
>>> +static void test_stream_linger_client(const struct test_opts *opts)
>>> +{
>>> +	struct linger optval = {
>>> +		.l_onoff = 1,
>>> +		.l_linger = 1
>>> +	};
>>> +	int fd;
>>> +
>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>> +	if (fd < 0) {
>>> +		perror("connect");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>>> +		perror("setsockopt(SO_LINGER)");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>
>> Since we are testing SO_LINGER, will also be nice to check if it's
>> working properly, since one of the fixes proposed could break it.
>>
>> To test, we may set a small SO_VM_SOCKETS_BUFFER_SIZE on the receive
>> side and try to send more than that value, obviously without reading
>> anything into the receiver, and check that close() here, returns after
>> the timeout we set in .l_linger.
>
>I may be doing something wrong, but (at least for loopback transport) it

Also with VMs is the same, I think virtio_transport_wait_close() can be 
improved to check if everything is sent, avoiding to wait.

But this is material for another series, so this test should be fine for 
now!

Thanks,
Stefano

>seems that close() lingers until data is received, not sent (without even
>touching SO_VM_SOCKETS_BUFFER_SIZE).
>
>```
>import struct, fcntl, termios, time
>from socket import *
>
>def linger(s, timeout):
>	if s.family == AF_VSOCK:
>		s.setsockopt(SOL_SOCKET, SO_LINGER, (timeout<<32) | 1)
>	elif s.family == AF_INET:
>		s.setsockopt(SOL_SOCKET, SO_LINGER, struct.pack('ii', 1, timeout))
>	else:
>		assert False
>
>def unsent(s):
>	SIOCOUTQ = termios.TIOCOUTQ
>	return struct.unpack('I', fcntl.ioctl(s, SIOCOUTQ, bytes(4)))[0]
>
>def check_lingering(family, addr):
>	lis = socket(family, SOCK_STREAM)
>	lis.bind(addr)
>	lis.listen()
>
>	s = socket(family, SOCK_STREAM)
>	linger(s, 2)
>	s.connect(lis.getsockname())
>
>	for _ in range(1, 1<<8):
>		s.send(b'x')
>
>	while unsent(s) != 0:
>		pass
>
>	print("closing...")
>	ts = time.time()
>	s.close()
>	print(f"done in %ds" % (time.time() - ts))
>
>check_lingering(AF_INET, ('127.0.0.1', 1234))
>check_lingering(AF_VSOCK, (1, 1234)) # VMADDR_CID_LOCAL
>```
>
>Gives me:
>closing...
>done in 0s
>closing...
>done in 2s
>


