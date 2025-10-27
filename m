Return-Path: <netdev+bounces-233203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE5C0E515
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B2EA34E73C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EAB30BBBB;
	Mon, 27 Oct 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJBAlO7s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681F30BB90
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574375; cv=none; b=GMolKagfpLG+X/cku3v4Jt927f0aowmOaaCz8ZWSWXczdUBy1hDXxTx0eWUc7M8YgJIfJCQsWAAAr9nsgkEgfr1aJsFLWukNtJzduUMBalyi0EVVHkS3thjMwbTxt+ZrVEJvXcQ3WCRKbXpoMYDSEp74zs7z+Ennoh4JbAtfSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574375; c=relaxed/simple;
	bh=CI4EGzYex9h2DBQ9ogFFiNjzj5+5h41s1uUJ6ZNRQN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBVTV0hjfVRVs4y+TVkEsoJJjK/gZxt4JKDRY2f5jxYPqOrdwum1SfbK3R5N/4Zks8JQSfZl6PS8iP/xWMkZkvkljI+Og4Y7VMkTKMSV6/nQHfFVjYBT4VC8WvI0VPRQtGYrktiW6TOdGvSY26+RXWxVNIWZj1HhH3IzfuYOoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJBAlO7s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761574373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXDTiCe61PwOLvz4aepYZofM4YqcnPsE33GQcCHLC5k=;
	b=gJBAlO7slz/eErQXk7KZzhV1V/FOppNib8TbVHs4qc3TIi0YWPl0FWGvMFQJxaFInXhKze
	LnATcAOgB6/jgxnn11Nf+JSdaTGvc1zjHl/0ucIJvvqiaOUR+t+/8Xfy7x43LGMgy8WAYD
	Ty8jh1xuyHAMfbUfXJJw1Rq5eFbTFfQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-RnX0PA-ZOEq11JcvNxApbA-1; Mon, 27 Oct 2025 10:12:52 -0400
X-MC-Unique: RnX0PA-ZOEq11JcvNxApbA-1
X-Mimecast-MFC-AGG-ID: RnX0PA-ZOEq11JcvNxApbA_1761574371
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b5c6c817a95so469092666b.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574370; x=1762179170;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXDTiCe61PwOLvz4aepYZofM4YqcnPsE33GQcCHLC5k=;
        b=oNA5YwiM8A5QQwc68Z6W013Z6Gt7fwIrs31MPLI+1Qgp+p85n3OeJfUzQgiu6dFHpj
         nnDbVOcIK16LCCHsoi7n7y1ddHuNpjIAgj6W6MEKIDeiC0x/CshDkI2GjYUs0LeX7C02
         8jby8RF2aLNZ9mN/KbY5kLzQ8LhtzqPkLrVsmBLK5wpeFPzlIu1oPkaqUREPkGjwgLFH
         0m5S6kzA6eI5EVlxVKe9A/qkXQeZTQbsTXdWzKU9Q4xgIuq3dfddH4Wbw4M7FwU2lcS7
         wTYKawOk8y1KBZfOjIJ979lgvSPPxxOBGyPj2ylDSlEXMGtjRCvBqFPREVFCQZQQkrzb
         GwtA==
X-Forwarded-Encrypted: i=1; AJvYcCXi+hPftP+6Evk1yceipO/WfiI9BvKRfjjwHq2NadqXh2/z1n+AUdq6vjtFgnjdlHoHDv1Se/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwflVRes7EkdS2VR/eQcCR5p1a0/ijQBs7/qlAoS007cFdA0kLZ
	2hP03oTwTLfRqiemz0uQ6lbrm0L6Ax2paTIUFyqOu2W9bOu5Ma/Vfs/d5SnFplTbffaCy+hvvXt
	Gv+ieTqPuAhtl2vYFg776luK390PNfqrVkBMab1fYI8yBxrzRiOZPs+GXWQ==
X-Gm-Gg: ASbGncuqFhdJ5YTxYlYUJu7wVwNffbo9xJAkAG5JPiSmFjc/vR8mxEjxPJgJWmXy4e8
	5NoISnDZRnrWzv7Y+DAscqeSMDvTi0hhA+VHk6YJVoHlt5s713O+a9AXSeb0fbyAdb69m2UC26G
	W00OIXoEZGTY0fpLVOWsH6QTeKEFz8ZFlGMuzj731QqZ4/TlCUrr/psX2rT6PTN+PzYSt8qJA4c
	F+pqCI7+kJ8ybvwQihRObTrmar1NHkD3MR011SBmUDNmRzCPdVzq2RgrCSAv0p19L60IeHlt21d
	JNzn7n/1BroHZD+XXexEPznvpOYU8rVYQQemN7QIo3FPNoA46V1OstdbBF/WZxhkm9i5CP0kmNU
	d3e4YVFH0fXuQDUNufXEcuwz4Cg==
X-Received: by 2002:a17:907:7fa9:b0:b5c:66ce:bfe6 with SMTP id a640c23a62f3a-b6dba5b93c6mr7314666b.55.1761574370158;
        Mon, 27 Oct 2025 07:12:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHWFDRx5i9mX7rcWZGcqjqX78dTPRFO24SYv/vkyQCe2mPe6GEsHT6TdQO2AtM0Tv0FNE6dg==
X-Received: by 2002:a17:907:7fa9:b0:b5c:66ce:bfe6 with SMTP id a640c23a62f3a-b6dba5b93c6mr7309566b.55.1761574369676;
        Mon, 27 Oct 2025 07:12:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d9b536710sm451408066b.57.2025.10.27.07.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:12:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 721F12EAA56; Mon, 27 Oct 2025 15:12:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 makita.toshiaki@lab.ntt.co.jp
Cc: Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, ihor.solodrai@linux.dev, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net V1 3/3] veth: more robust handing of race to avoid
 txq getting stuck
In-Reply-To: <b021f5c3-5105-445d-b919-8282363a19fc@kernel.org>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123158453.2281302.11061466460805684097.stgit@firesoul>
 <871pmsfjye.fsf@toke.dk> <b021f5c3-5105-445d-b919-8282363a19fc@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Oct 2025 15:12:48 +0100
Message-ID: <87sef4e8m7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 24/10/2025 16.33, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
>>> reduce TX drops") introduced a race condition that can lead to a perman=
ently
>>> stalled TXQ. This was observed in production on ARM64 systems (Ampere A=
ltra
>>> Max).
>>>
>>> The race occurs in veth_xmit(). The producer observes a full ptr_ring a=
nd
>>> stops the queue (netif_tx_stop_queue()). The subsequent conditional log=
ic,
>>> intended to re-wake the queue if the consumer had just emptied it (if
>>> (__ptr_ring_empty(...)) netif_tx_wake_queue()), can fail. This leads to=
 a
>>> "lost wakeup" where the TXQ remains stopped (QUEUE_STATE_DRV_XOFF) and
>>> traffic halts.
>>>
>>> This failure is caused by an incorrect use of the __ptr_ring_empty() API
>>> from the producer side. As noted in kernel comments, this check is not
>>> guaranteed to be correct if a consumer is operating on another CPU. The
>>> empty test is based on ptr_ring->consumer_head, making it reliable only=
 for
>>> the consumer. Using this check from the producer side is fundamentally =
racy.
>>>
>>> This patch fixes the race by adopting the more robust logic from an ear=
lier
>>> version V4 of the patchset, which always flushed the peer:
>>>
>>> (1) In veth_xmit(), the racy conditional wake-up logic and its memory b=
arrier
>>> are removed. Instead, after stopping the queue, we unconditionally call
>>> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is schedul=
ed,
>>> making it solely responsible for re-waking the TXQ.
>>=20
>> This makes sense.
>>=20
>>> (2) On the consumer side, the logic for waking the peer TXQ is centrali=
zed.
>>> It is moved out of veth_xdp_rcv() (which processes a batch) and placed =
at
>>> the end of the veth_poll() function. This ensures netif_tx_wake_queue()=
 is
>>> called once per complete NAPI poll cycle.
>>=20
>> So is this second point strictly necessary to fix the race, or is it
>> more of an optimisation?
>>=20
>
> IMHO it is strictly necessary to fix the race.  The wakeup check
> netif_tx_queue_stopped() in veth_poll() needs to be after the code that
> (potentially) writes rx_notify_masked.
>
> This handles the race where veth_xmit() haven't called
> netif_tx_stop_queue() yet, but veth_poll() manage to consume all packets
> and stopped NAPI.  Then we know that __veth_xdp_flush(rq) in veth_xmit()
> will see rx_notify_masked=3D=3Dfalse and start NAPI/veth_poll() again, and
> even-though there is no packets left to process we still hit the check
> netif_tx_queue_stopped() which start txq and will allow veth_xmit() to
> run again.
>
> I'll see if I can improve the description for (2).

Right, okay. Yes, adding this reasoning to the commit message would be
good :)

-Toke


