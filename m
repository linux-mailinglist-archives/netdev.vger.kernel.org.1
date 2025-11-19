Return-Path: <netdev+bounces-240078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C2AC703B2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 583773C550C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F00F35B15E;
	Wed, 19 Nov 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ro9h3cFd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l/+cfj+t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5943590DB
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569884; cv=none; b=Xrq9oTAdaKee5E2JVahbHsn8TkDY+vKrSSaT2VUbqy94IoMXMzbEFHyoekMz96gSXEQHjvXBG7v/hdrasVqxDADmJadhmKXO8bKW14mSVrQSgXUqT27fGZ3RnVeQEp5+9mChcACxHL4Y08BB/hFZDiJI5WUYBer3dKOoK0Gs0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569884; c=relaxed/simple;
	bh=FqqvmkUPgSq7OZp9nrgzHtuk68f2+rkXNRL8blqM5Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbUFmg6NcjUIX4ombFUYdLRCeGzooguCqxJxnRUYP+zg/Vs/Mr+7G90Q5BPmtEC+DJ8YTOIrC5z6L0cfGzcduxrDSDMnMCO7qsaIlHfXsfqbhZPFfQ5tebRUaWjGbI4ZVL1/GsdW0q028qhdkXKORQtYIrVOQfK5BPC8150sot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ro9h3cFd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l/+cfj+t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763569881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3kVindzkKJ+KF8jM/3D9z51CP303MCzFh5WHNehWDM=;
	b=Ro9h3cFdnteI3rhSoL5Ws/nivj/ndNLcsVakvDcPQShDWaOSJF+C5eKJXokrDioauLnpKP
	Udk7QSv/0nZSzTR4TLodXaOeKiDPqw2Qi9E3sbltPqbYSTug4axcgGfvUTKe3C5xjLutfV
	+YdF0eCrILUup1f1gy5+2H/SOdpGOO0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-3iIw0qiCPjacl8w07gF0eA-1; Wed, 19 Nov 2025 11:31:20 -0500
X-MC-Unique: 3iIw0qiCPjacl8w07gF0eA-1
X-Mimecast-MFC-AGG-ID: 3iIw0qiCPjacl8w07gF0eA_1763569879
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8804b991976so194861126d6.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763569877; x=1764174677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3kVindzkKJ+KF8jM/3D9z51CP303MCzFh5WHNehWDM=;
        b=l/+cfj+tJXasJue0f8SeL2ebb7dhOO8XLamvf7AP5repUaUMkrl1aW6m5yiE3USAfj
         7LPlnUPhjQZZkehjo70qkRHDmc+9iLiybzfHRpzbViDK2Mto05xdhrufadkvU2KS/giO
         uFnwtrLnrVGcTh2a0itXYXabeq4b4cvELFvPdDlKi7lFCh9MZ0P53h2U+X6xT6iQd/6h
         L9QxJPueZpg5QeqXY0E1GQ1iOxXCT9xKebDEXqcF0mbtTOGVFX7/e4DjMecWbBYCoglB
         u9baXq4/j2a7L1gmFaZiI5DMb0DWstEsDNMKRm8cLiMJwCCM49Q6b31o9KbeWDxBmslN
         9vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569877; x=1764174677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3kVindzkKJ+KF8jM/3D9z51CP303MCzFh5WHNehWDM=;
        b=W1cpbQZlWjucnOYErw7MeQ0JIwIcexDYIXQ53tMbjOTGF/TuWyiphtUfVYxOamNuGA
         K0CPI5FpXUkUIKZBk0JvZ79UuEBROXo1SRc8LqnY1bc9/ZemD1J7bW6iDjlZ5Pdg3mVq
         Jz61TDBYf4XfhLW2f5F8CBHN4tpD9uH3g8IRKrA4qZlKNddX3lNoS25DqNn1eL/qp+Un
         IBN4eGW9jnqFMINSGDgfbK4IPIUVCz9yc0PKgBqc2kleEEtspps8dmWG9fmFapLNkFa+
         wn6EwpVEnfU2AXgmpyTUTXzjG0PCGCCbFWBFqVPTSfYH1res39IjNqHqfs7U+mZ+Vz3c
         U2eg==
X-Forwarded-Encrypted: i=1; AJvYcCWnbERDjv2VxyZ4vbDDVtz7nleQhCSbMR9wt1vV8ARvtdKRZFZCCiG+9Q/7UhEvW4rll4RJqqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywar6wb/g02+LHazOymqrris/XgQhRqFsqFNBnpqjtBI1QmHuxN
	UPCoqvbwQZMkIkyRFmumauLYkClCudkibrT1truqi68oqBIw01UXBlZ2Sih0uBdk7LFoPuor3Mh
	yrZtd9oi2UmES0aZ32gsvv4o+b4keZ8NG0KHauyaO9Acf72OoUE/68HmrmA==
X-Gm-Gg: ASbGncuGBWmlnYEOC+1QaMgEaK0TUQefT7G1hADHbpVMHTO8sCcraGVp0RW40/P/h6n
	NTJSAKVVjPT2me5fSRDJg2q/ZLqw2Ucikd1oH1bO4WG7EKMHc0I3llBTEFGVTRW8VNFp71XALKg
	qglsWjLXZWongmadvwYE7gQ1vYyabMBWx/jN9BhVyCHAuOCiMDg0MYca0a7zbocvs3FG+Srn+da
	mEjqwRYfgN5Y0QKEsyN/z2GReM02PaLlqvIjDmmPdApcrUQbDD82c7FWHjq8z+pbFAYfWKDL4TU
	giuDk0PT48UPTmatfY3ErYsSvGRMfgkPiowEtnMsriilfMSXaBYPAyaJjgLQlCg6XOjbmVLTKZJ
	QDM9DVH6b0Rf844y7hsz7B38eAKaNnMAQkv7VX3z/dNFz2NQ=
X-Received: by 2002:a05:6214:2246:b0:882:398d:3cf5 with SMTP id 6a1803df08f44-88292703764mr336989756d6.52.1763569876555;
        Wed, 19 Nov 2025 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlMoSDGo8RCC4ukLN3fwxkuNRsD7z+J9Dhyfp0NsIu40eZGeuMWPAwGp70A3xvg/lU9rghuw==
X-Received: by 2002:a05:6214:2246:b0:882:398d:3cf5 with SMTP id 6a1803df08f44-88292703764mr336988236d6.52.1763569875387;
        Wed, 19 Nov 2025 08:31:15 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314656sm136478176d6.21.2025.11.19.08.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:31:14 -0800 (PST)
Date: Wed, 19 Nov 2025 17:31:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
 <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>

On Wed, Nov 19, 2025 at 03:09:25PM +0100, Michal Luczaj wrote:
>On 11/19/25 11:36, Stefano Garzarella wrote:
>> On Tue, Nov 18, 2025 at 11:02:17PM +0100, Michal Luczaj wrote:
>>> On 11/18/25 10:51, Stefano Garzarella wrote:
>>>> On Mon, Nov 17, 2025 at 09:57:25PM +0100, Michal Luczaj wrote:
>>>>> ...
>>>>> +static void vsock_reset_interrupted(struct sock *sk)
>>>>> +{
>>>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>>>> +
>>>>> +	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>>>>> +	 * transport->connect().
>>>>> +	 */
>>>>> +	vsock_transport_cancel_pkt(vsk);
>>>>> +
>>>>> +	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
>>>>> +	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
>>>>> +	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
>>>>> +	 */
>>>>> +	sk->sk_state = TCP_CLOSE;
>>>>> +	sk->sk_socket->state = SS_UNCONNECTED;
>>>>> +}
>>>>> +
>>>>> static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>>>> 			 int addr_len, int flags)
>>>>> {
>>>>> @@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>>>> 		timeout = schedule_timeout(timeout);
>>>>> 		lock_sock(sk);
>>>>>
>>>>> +		/* Connection established. Whatever happens to socket once we
>>>>> +		 * release it, that's not connect()'s concern. No need to go
>>>>> +		 * into signal and timeout handling. Call it a day.
>>>>> +		 *
>>>>> +		 * Note that allowing to "reset" an already established socket
>>>>> +		 * here is racy and insecure.
>>>>> +		 */
>>>>> +		if (sk->sk_state == TCP_ESTABLISHED)
>>>>> +			break;
>>>>> +
>>>>> +		/* If connection was _not_ established and a signal/timeout came
>>>>> +		 * to be, we want the socket's state reset. User space may want
>>>>> +		 * to retry.
>>>>> +		 *
>>>>> +		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>>>>> +		 * vsock_connected_table. We keep the binding and the transport
>>>>> +		 * assigned.
>>>>> +		 */
>>>>> 		if (signal_pending(current)) {
>>>>> 			err = sock_intr_errno(timeout);
>>>>> -			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>>>>> -			sock->state = SS_UNCONNECTED;
>>>>> -			vsock_transport_cancel_pkt(vsk);
>>>>> -			vsock_remove_connected(vsk);
>>>>> +			vsock_reset_interrupted(sk);
>>>>> 			goto out_wait;
>>>>> -		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>>>>> +		}
>>>>> +
>>>>> +		if (timeout == 0) {
>>>>> 			err = -ETIMEDOUT;
>>>>> -			sk->sk_state = TCP_CLOSE;
>>>>> -			sock->state = SS_UNCONNECTED;
>>>>> -			vsock_transport_cancel_pkt(vsk);
>>>>> +			vsock_reset_interrupted(sk);
>>>>> 			goto out_wait;
>>>>
>>>> I'm fine with the change, but now both code blocks are the same, so
>>>> can we unify them?
>>>> I mean something like this:
>>>> 		if (signal_pending(current) || timeout == 0 {
>>>> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>>>> 			...
>>>> 		}
>>>>
>>>> Maybe at that point we can also remove the vsock_reset_interrupted()
>>>> function and put the code right there.
>>>>
>>>> BTW I don't have a strong opinion, what do you prefer?
>>>
>>> Sure, no problem.
>>>
>>> But I've realized invoking `sock_intr_errno(timeout)` is unnecessary.
>>> `timeout` can't be MAX_SCHEDULE_TIMEOUT, so the call always evaluates to
>>> -EINTR, right?
>>
>> IIUC currently schedule_timeout() can return MAX_SCHEDULE_TIMEOUT only
>> if it was called with that parameter, and I think we never call it in
>> that way, so I'd agree with you.
>>
>> My only concern is if it's true for all the stable branches we will
>> backport this patch.
>>
>> I would probably touch it as little as possible and continue using
>> sock_intr_errno() for now, but if you verify that it has always been
>> that way, then it's fine to change it.
>
>All right then, here's a v2 with minimum changes:
>https://lore.kernel.org/netdev/20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co/
>

Thanks!

>Note a detail though: should signal and timeout happen at the same time,
>now it's the timeout errno returned.
>

Yeah, I thought about that, but I don't see any problems with that.
I mean, it's something that if it happens, it's still not deterministic,
so we're not really changing anything.

Thanks,
Stefano


