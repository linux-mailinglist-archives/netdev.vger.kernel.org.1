Return-Path: <netdev+bounces-249027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF34D12DFE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D36F63000DF8
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD042359F8B;
	Mon, 12 Jan 2026 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWUr2+59";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qiNS3od3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548AE35971B
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225476; cv=none; b=WrFm3mFF5JPhq0kFFlr+Z5r8gNlWC8KMMSV+8yRL9zQxX+57FgEA5blwh/MU86x+e3z+KlvZDuhgL3OvrDNNNvD2iefwc2FN/Abl1617HqTjrjwpxnbh6OUk6dtDUBRYKXoWJDQhKgxIjgz8iAzcJlbRGRWIM/YvDvMz5dAsbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225476; c=relaxed/simple;
	bh=DCCkMKE37W8wsRrMCbvNOdPo7w9XG07KVqWsm2N1Xpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5jC26M5H69G/WCKeTnGPywWLOrMgUzRYhVV7AtkZ742LUzV27mocmkAQGSS/EmgBlUzbDG2G34+4gJHkccx6qOry20xhrJW9Wh+KUIW6M1SvGbLOgBgNhkx3uzNq6AXPJBjxFJlCg0ONdCzduompAArHvJ17arScp+g6Dys1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWUr2+59; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qiNS3od3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768225474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GGW9mZKBtph9QlALl3Ep6OTQikES/GMT3cQq+RonefE=;
	b=AWUr2+59kaumIcEiBOCLbIFfzVrQtfWpY3tRIkWQDRUI8kjxlgvnw7zpvFhQjrKmsXAJ5J
	BCo0cFHhM9TNoTelVeUVsFoOaKumEJKsTm8RpxWMwZ/bpp3CcCenV4NnZVb0i4+a6NWpOW
	3Nr31bcTafrFcgwyO+hWk6O4i+Dr28k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-96mNIXxRMUmBY6jKAeGmIQ-1; Mon, 12 Jan 2026 08:44:33 -0500
X-MC-Unique: 96mNIXxRMUmBY6jKAeGmIQ-1
X-Mimecast-MFC-AGG-ID: 96mNIXxRMUmBY6jKAeGmIQ_1768225472
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so59961035e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 05:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768225472; x=1768830272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGW9mZKBtph9QlALl3Ep6OTQikES/GMT3cQq+RonefE=;
        b=qiNS3od3GOnLgq+P5/7oimKOOWqNtEzTGNDE1Y8jOTXWY/Mx/zbF2cQfEoo/xKuNSJ
         cJRhF/jxpe+geDPEHe3DEqMZpJ0QLAbtFQQCDoylksUczBezAg6HnK20djEVlR3uDBjK
         dz4qKoeaSk1E2xzcG0oW1YKCtGEpgG5M6zB1Gy9Q85jfq5iiuaLQvC7lDY1zuMFIOFEY
         Ai4xBGwkASoOY5bq79cl2K0YcrjI6GXqixAUKJlqOn0o9IpV4B1CaN2bOgjYvV9wJ2rA
         yn2NnevsMvbGtHPyBX7Dc51wxtVvZ1rnQKy6QYi8hR8icxb+sEQQNL1O4tT11sCjIFWN
         r2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768225472; x=1768830272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGW9mZKBtph9QlALl3Ep6OTQikES/GMT3cQq+RonefE=;
        b=o4di1/ZPDnsnEa1P/eOp+6b3HoAKUcegYS0ID+XvIp/bK1DwUZVSedV9jHXFyE7TYN
         18yp61x+h1d/EjSECeYLmhIm4JFo0HZBR/MX0s1M2kvXJAfTfUG4N9KK2C7zgmhhayoX
         5IYCh4mMlKpJ3NduNzr2OT8BgIAF31scEwuA72QYobKFXPQdJ/oMHRFvHolyJNYCOhqu
         uwHT2DTz+LCLLGCpegkATp04CqLyNPLr55Vi1o+C7opDs93TlMbptNT+h8kaaaqkN9WP
         0WHuW6/jBzMbR2bup0tVzxaSrZnS9HzDvGZETBVZy25Ss7StJBllDpeuKl9OGISA0KSE
         s9mw==
X-Forwarded-Encrypted: i=1; AJvYcCViYZZPV4dmOZOBpObo1F++c8tyYzjmAjpXDEktkNoAXu05z8MAKZS0CyMSPVj2ejiatjFnNyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2phCXCIz9Ir4ZRoYPm5aw+86xlEpf9R0+/S7y3lxmV4wMwmSy
	obx6w+uz5XooDgEsXzwerwvB0elWanQW6GVd81BEbrKUQ6Kr+p09P0fEtaULWj9rcqdZxXCBYyP
	RTlX+uHRsyGddBYM7iumoF/3jSoKI+RA+vCUmlU4OHKYdCUbl5uC/KMEnyg==
X-Gm-Gg: AY/fxX7QGa347RMtXNw5pawNoEtE2tRurebBpc8zldADTn462QO3EaIZ4dTjjRab94C
	Xbp4y2JAlEEsXmnTQCo+YVEkJb3Jjw/9coooBDln3WH4AcUi0VYBBE+59jSI2uTieDg8krVaLH/
	bvjfhsQ2p42zHKfT5JTplCJdEJ9DVI+hcl36bnJtWHayMJSryBkFpSNHMQwyWxuNXmaVXVjsB9i
	PnBbVFggpfaNgW+jG7LkbHrwAsHYNymz7Y5EINkS2UPRjJNJiI1XJDDKXJuLUUC1HvmTnicMize
	uDpMzLfEKLPHa8XzIzNwgHM5aTuhdxZRNajHeXIC6DIswjQ14Xand2UR5R7NK+sXS3ixes36a1q
	XgdFylO8r85uIPW1V6eZ4bNC+FZIvyiYp0jME1SNIGPHz0CvYN+QTKzZEl97oJA==
X-Received: by 2002:a05:600c:8506:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d849bd201mr172455725e9.0.1768225471668;
        Mon, 12 Jan 2026 05:44:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm2s3Ka0LVsovFun71Z5V7/5VR95//yL24AIdoBztX46nKJnlOhC/MqZHEuukOdh9k4vo5Pw==
X-Received: by 2002:a05:600c:8506:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d849bd201mr172455485e9.0.1768225471211;
        Mon, 12 Jan 2026 05:44:31 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d286cdecsm25026149f8f.7.2026.01.12.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:44:30 -0800 (PST)
Date: Mon, 12 Jan 2026 14:44:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vsock/test: Add test for a linear and non-linear skb
 getting coalesced
Message-ID: <aWT6EH8oWpw-ADtm@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-2-26f97bb9a99b@rbox.co>
 <aWEqjjE1vb_t35lQ@sgarzare-redhat>
 <76ca0c9f-dcda-4a53-ac1f-c5c28d1ecf44@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <76ca0c9f-dcda-4a53-ac1f-c5c28d1ecf44@rbox.co>

On Sun, Jan 11, 2026 at 11:59:54AM +0100, Michal Luczaj wrote:
>On 1/9/26 17:32, Stefano Garzarella wrote:
>> On Thu, Jan 08, 2026 at 10:54:55AM +0100, Michal Luczaj wrote:
>>> Loopback transport can mangle data in rx queue when a linear skb is
>>> followed by a small MSG_ZEROCOPY packet.
>>
>> Can we describe a bit more what the test is doing?
>
>I've expanded the commit message:
>
>To exercise the logic, send out two packets: a weirdly sized one (to ensure
>some spare tail room in the skb) and a zerocopy one that's small enough to
>fit in the spare room of its predecessor. Then, wait for both to land in
>the rx queue, and check the data received. Faulty packets merger manifests
>itself by corrupting payload of the later packet.

Thanks! LGTM!

>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> tools/testing/vsock/vsock_test.c          |  5 +++
>>> tools/testing/vsock/vsock_test_zerocopy.c | 67 +++++++++++++++++++++++++++++++
>>> tools/testing/vsock/vsock_test_zerocopy.h |  3 ++
>>> 3 files changed, 75 insertions(+)
>>>
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>> index bbe3723babdc..21c8616100f1 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -2403,6 +2403,11 @@ static struct test_case test_cases[] = {
>>> 		.run_client = test_stream_accepted_setsockopt_client,
>>> 		.run_server = test_stream_accepted_setsockopt_server,
>>> 	},
>>> +	{
>>> +		.name = "SOCK_STREAM MSG_ZEROCOPY coalescence corruption",
>>
>> This is essentially a regression test for virtio transport, so I'd add
>> virtio in the test name.
>
>Isn't virtio transport unaffected? It's about loopback transport (that
>shares common code with virtio transport).

Why virtio transport is not affected?

>
>>> +		.run_client = test_stream_msgzcopy_mangle_client,
>>> +		.run_server = test_stream_msgzcopy_mangle_server,
>>> +	},
>>> 	{},
>>> };
>>>
>>> diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
>>> index 9d9a6cb9614a..6735a9d7525d 100644
>>> --- a/tools/testing/vsock/vsock_test_zerocopy.c
>>> +++ b/tools/testing/vsock/vsock_test_zerocopy.c
>>> @@ -9,11 +9,13 @@
>>> #include <stdio.h>
>>> #include <stdlib.h>
>>> #include <string.h>
>>> +#include <sys/ioctl.h>
>>> #include <sys/mman.h>
>>> #include <unistd.h>
>>> #include <poll.h>
>>> #include <linux/errqueue.h>
>>> #include <linux/kernel.h>
>>> +#include <linux/sockios.h>
>>> #include <errno.h>
>>>
>>> #include "control.h"
>>> @@ -356,3 +358,68 @@ void test_stream_msgzcopy_empty_errq_server(const struct test_opts *opts)
>>> 	control_expectln("DONE");
>>> 	close(fd);
>>> }
>>> +
>>> +#define GOOD_COPY_LEN	128	/* net/vmw_vsock/virtio_transport_common.c */
>>
>> I think we don't need this, I mean we can eventually just send a single
>> byte, no?
>
>For a single byte sent, you get a single byte of uninitialized kernel
>memory. Uninitialized memory can by anything, in particular it can be
>(coincidentally) what you happen to expect. Which would result in a false
>positive. So instead of estimating what length sufficiently reduces
>probability of such false positive, I just took the upper bound.

I see, makes sense to me.

>
>BTW, I've realized recv_verify() is reinventing the wheel. How about
>dropping it in favour of what test_seqpacket_msg_bounds_client() does, i.e.
>calc the hash of payload and send it over the control channel for verification?

Yeah, strongly agree on that.

>
>>> +
>>> +void test_stream_msgzcopy_mangle_client(const struct test_opts *opts)
>>> +{
>>> +	char sbuf1[PAGE_SIZE + 1], sbuf2[GOOD_COPY_LEN];
>>> +	struct pollfd fds;
>>> +	int fd;
>>> +
>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>> +	if (fd < 0) {
>>> +		perror("connect");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	enable_so_zerocopy_check(fd);
>>> +
>>> +	memset(sbuf1, '1', sizeof(sbuf1));
>>> +	memset(sbuf2, '2', sizeof(sbuf2));
>>> +
>>> +	send_buf(fd, sbuf1, sizeof(sbuf1), 0, sizeof(sbuf1));
>>> +	send_buf(fd, sbuf2, sizeof(sbuf2), MSG_ZEROCOPY, sizeof(sbuf2));
>>> +
>>> +	fds.fd = fd;
>>> +	fds.events = 0;
>>> +
>>> +	if (poll(&fds, 1, -1) != 1 || !(fds.revents & POLLERR)) {
>>> +		perror("poll");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>
>> Should we also call vsock_recv_completion() or we don't care about the
>> result?
>>
>> If we need it, maybe we can factor our the poll +
>> vsock_recv_completion().
>
>Nope, we don't care about the result.
>

Okay, I see.

Thanks,
Stefano


