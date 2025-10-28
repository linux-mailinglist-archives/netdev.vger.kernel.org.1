Return-Path: <netdev+bounces-233464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF64C13BEC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D9CA56249D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2752E8E10;
	Tue, 28 Oct 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J69usoSV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8722E8B64
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642647; cv=none; b=sHtGzrpJZMel2hFLj22md3tTuedQtar9alVeyl4wBdksMU7I5Cq+jESzG221J5JJSEko9x1dZvd8huvODBb4GMq3OHPLXWQGY0oVKR3X3/i2NdMty8La38kkpWyYbzs+K68uGLVStcHq73Zp++eKizQZlbuY8rOj4cTNX3oVAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642647; c=relaxed/simple;
	bh=nUvmRIdePhWR1BVd6YS9hQ9Nhkp7ylTEdot9/hR9dxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNS0KTvqk31GzNi/ivsJxuEK9E48buKvDtfQ0AUlhukyX/sAmmD3KVzLguZgQ+R566hGtbWkMCEO6x7HIAikSOuIjbYQhPCMGtHH7IEkQYqXgtwoyB31syZ3PtcNEcrG1lQ6/JNyBN6q5pyFiM7ycEunpBinpR89qOUeeWl8UPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J69usoSV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761642645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jISGdCb1GJlrcq0k79tPP36lvaZ1ZSwf/Nio4tsSv8=;
	b=J69usoSV9WLiq38JTKJWuWL1kRLEvdmzZWkz2kvhuXVoY+M4Z0/NQAjX54tbzCziznT2U3
	uFCDY+R++rxCTMDoelA/pqkYbL6TFH8XX39jT5pn3pJs3+wrpRKRBxjdVJ9M/7AuywBOSs
	DajaVBqXbU8gfwuLNXzIyMWy1Q9XWa0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-vMrz2xKaOFWUkbOrdKsniQ-1; Tue, 28 Oct 2025 05:10:43 -0400
X-MC-Unique: vMrz2xKaOFWUkbOrdKsniQ-1
X-Mimecast-MFC-AGG-ID: vMrz2xKaOFWUkbOrdKsniQ_1761642642
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-634700fe857so6938978a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 02:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761642642; x=1762247442;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jISGdCb1GJlrcq0k79tPP36lvaZ1ZSwf/Nio4tsSv8=;
        b=knbfe1+mSZqT3+4tJ9cFfwEE9aeyWUwGFu4dGYJ/quhhprsYDUsYDl3eCAWlXtuRkf
         Zdz34W/LpqJLler4Yu2WsnB/ZNwnI05LAVYGIIYYIs+PE5GqvwhMB5wvUleJvbK0ewTK
         O1f8S2LiXC1P3er6WOGuzvA0v3XaNxiJp5SRSxK+3YPlh3zyPwrGri5mlsBy/8e2QbTY
         lO1a0lBOWKAGL9QUkfuwDzuW/mZx3ym+mND732e9JUScX7OiZ/IvVRMijp2MNo58GvjF
         i/QVsvYdsgsKa6AD1v9rKbkS7cOLEv3lUwDA8GrCxkIrhcYzR3BAzB7ltfgTZRINkg20
         CWtA==
X-Forwarded-Encrypted: i=1; AJvYcCV/R5ixQ54b1198/V5McbL5rd0p1AJjPd8ikCvLEOqPxk0/EJt5/wQ/Wiw2+ixpNkePnQVGVxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKxOA7PumOtFnakt4iheau/6/dJaFfi5ugu2tldjiV5Jwi6qJ
	yd76vu72Hmk4MvLfKBJUocJv9ftbeJwjez1pczmz8LBHoyoEzipAsMVOZCeIZu9EORPbBK5Yf2r
	7gzCrNxCYGWgprftQIoaR5cSsi2/gQa+Hk1nho9HcCAmlweMSTJt1tj/a7A==
X-Gm-Gg: ASbGncvrAlpkoc6At6pKk+kL2acic8ehzm8Ou8S0DgUflYDpzRaK0CgZjyc8UcUBAjc
	2BfnZIKeXVtKQpOmR5LzAPYfVg1ZeN07kksPipABqCRpr+bcIUHmsu8eg6jWgc4FJWLsNj62cwE
	VEgBSZ/JlosPsHU3mvXGknEQnOF5JzjgEjSWnFSjJwCZ/D/rYYhMn+YiosKR4eAR9OdN3/BkCNK
	xtSJ7OBMIbBjhfd/XnJ4VUlOhnokzKCcNS7z9DprFp2z1UfCVQpaBxGVaSddfhuguz8hX/3QJb/
	PYHtfXPPW7IaZaITzmjFNMKEb5TSjZkQOs2WWLTOetZ4RIal7u3pVjskJKi+pwfYJrCOgoxbG5O
	QjD7BFCPKEkgEJUpnk5usfGk=
X-Received: by 2002:a05:6402:3551:b0:63b:f48d:cf46 with SMTP id 4fb4d7f45d1cf-63f4bcb889dmr2198782a12.8.1761642642410;
        Tue, 28 Oct 2025 02:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYL1I7iYELO1BGl1eN/tsiGHTTVmgI6PfKI6Bfdq9lP4t6LQVqj/exevSCIOYmz6JDfKXGcg==
X-Received: by 2002:a05:6402:3551:b0:63b:f48d:cf46 with SMTP id 4fb4d7f45d1cf-63f4bcb889dmr2198759a12.8.1761642641927;
        Tue, 28 Oct 2025 02:10:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6402a6be2eesm1007717a12.16.2025.10.28.02.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:10:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9DF882EAC76; Tue, 28 Oct 2025 10:10:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid
 txq getting stuck
In-Reply-To: <176159553930.5396.4492315010562655785.stgit@firesoul>
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 28 Oct 2025 10:10:40 +0100
Message-ID: <87bjlre6i7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
> reduce TX drops") introduced a race condition that can lead to a permanen=
tly
> stalled TXQ. This was observed in production on ARM64 systems (Ampere Alt=
ra
> Max).
>
> The race occurs in veth_xmit(). The producer observes a full ptr_ring and
> stops the queue (netif_tx_stop_queue()). The subsequent conditional logic,
> intended to re-wake the queue if the consumer had just emptied it (if
> (__ptr_ring_empty(...)) netif_tx_wake_queue()), can fail. This leads to a
> "lost wakeup" where the TXQ remains stopped (QUEUE_STATE_DRV_XOFF) and
> traffic halts.
>
> This failure is caused by an incorrect use of the __ptr_ring_empty() API
> from the producer side. As noted in kernel comments, this check is not
> guaranteed to be correct if a consumer is operating on another CPU. The
> empty test is based on ptr_ring->consumer_head, making it reliable only f=
or
> the consumer. Using this check from the producer side is fundamentally ra=
cy.
>
> This patch fixes the race by adopting the more robust logic from an earli=
er
> version V4 of the patchset, which always flushed the peer:
>
> (1) In veth_xmit(), the racy conditional wake-up logic and its memory bar=
rier
> are removed. Instead, after stopping the queue, we unconditionally call
> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is scheduled,
> making it solely responsible for re-waking the TXQ.
>
> (2) On the consumer side, the logic for waking the peer TXQ is moved out =
of
> veth_xdp_rcv() and placed at the end of the veth_poll() function. This
> placement is part of fixing the race, as the netif_tx_queue_stopped() che=
ck
> must occur after rx_notify_masked is potentially set to false during NAPI
> completion.
>  This handles the race where veth_poll() consumes all packets and complet=
es
> NAPI before veth_xmit() on the producer side has called netif_tx_stop_que=
ue().
> In this state, the producer's __veth_xdp_flush(rq) call will see
> rx_notify_masked is false and reschedule NAPI. This new NAPI poll, even i=
f it
> processes no packets, is now guaranteed to run the netif_tx_queue_stopped=
()
> check, see the stopped queue, and wake it up, allowing veth_xmit() to pro=
ceed.
>
> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI=
 is
> about to complete (napi_complete_done), it now also checks if the peer TXQ
> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
> reschedule itself. This prevents a new race where the producer stops the
> queue just as the consumer is finishing its poll, ensuring the wakeup is =
not
> missed.
>
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to =
reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


