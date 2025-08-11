Return-Path: <netdev+bounces-212398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA727B1FE00
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 04:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F5A1894733
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 02:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90A2459C5;
	Mon, 11 Aug 2025 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXdweaMT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3251A5B9D
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754880303; cv=none; b=Ogxi1BQGZBKQJ7LG7ykDWFyqugIihtXDJUX7C8DKAm8eabpCIwvJnxZ3ke2vYQOjVyXb0ISThxUYIpiEuUfUD1kTVio9cVMjM1tiIOdzwCJx0NwIQSF1xxCeRPHiTHXeeRvS5IAH8Sy2/5VxIp21qinF4dR+PPqTi8/A0XgkA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754880303; c=relaxed/simple;
	bh=9ppwh54+HK1qVr+GRbb6FbUhHZWPWKbZ3u0a0GnFclk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4TFXXkP13P3fRRp8c7WvayKJF2LBKOVYtB28xwFhZGp66oj6PL1UQzbJVq0J1ghMRU+6U7W0nDR/hta8hS5Ez4emrRy4/ugMTtMMlc3FP96r4mast/1SIfchlfX0w7EDjWRNAFNqmAQ2E2+s4XHvAxkd6416QQaT0+UocbRN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXdweaMT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754880300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0/sM6aUkX502iExFjanLuFpVfhVyNcMUm7+a6rSkos=;
	b=hXdweaMTJKUvVSdO5PNExP2YBGJhDb762uZTi40KNG0MKvpH0C6i2coTdacT81SHNZOqiT
	i8Oa9i7rUhpt9gWvwVCoMUUtD8zoK1Ax8Av9zkGn17wzcfEc8GFFuZ6erYxo0DQfhGuCww
	fsrtA2jhzaQyeryCxht2hbfaA96m8G4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-etsPRn2IPqmBGjr95YMOPw-1; Sun, 10 Aug 2025 22:44:58 -0400
X-MC-Unique: etsPRn2IPqmBGjr95YMOPw-1
X-Mimecast-MFC-AGG-ID: etsPRn2IPqmBGjr95YMOPw_1754880298
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fed1492f6so60931095ad.2
        for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 19:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754880297; x=1755485097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0/sM6aUkX502iExFjanLuFpVfhVyNcMUm7+a6rSkos=;
        b=A1A0SVImkhvidMXeASAkZA2Ucdze4RmmbbDHntCcheE/LzTkWf1eUGT3t8R/wVikfE
         FFZ9Z5zBeQSkpB7t1ALHeaTUOMkvAjcRpRZKzNAUpVxoCaOFHcWGK6XlJOsbiWaeIbrF
         2QIelV591oQVLFryvRrPVjdLDenpVlO8J0Q78JRUlL/EugH1j5NEbG0SUg52iwI9330F
         rFcMPptsOV5ueBl7Hsdya2XxHi5UCe9+d4vTAt9vlWKgA4QkX8VZ4z33WGmYCuC+nXfz
         1OCvNZyHfpq79gzOwcQMWzSV5jy7Xh6ciyobg39C+qpPNkqAsg1PAypx5PgxiIM3ilzj
         AapA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7yE0zIsy9cvQMu3NVd4Fdi78MFRqdhMYYTjg1El0WJn+5W0nzWZ2HXVLtVmLCcXMAuOA2ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+r9vqFsOP6gcQcWtT1ZXxA2ZzbQnUXoGVVpKvlKiUcJBIHRd
	GnJZONdbE8Fk2FRw+oGTXgBCwDu//EhvXeAOI89VD5dRhNh9sYXwnjPy7NIyJKtHBtoudvk1Mc0
	gzD12LOhx4kvdzYuffiOMoGPdI0Io1lBuIhbrRxfDKdbdD0r8gGUvDxtFh1BAKsudyGWr4Ip27N
	SoaggnK1ckmFinQf0tvQDz2zmK8oqZtxw3gYlbeglyP3B/Ww==
X-Gm-Gg: ASbGncsxSQlskIzSvg6K2S4Sd2RzB8D+rHOHnNwlm9A6q0+Duw57IWYy87IGMSIWxqf
	AxK4ztnDwKgA5UrwKZQ9Gqxar6cmkYlQPxjjEI2WZV18j4dK1tXFKinXmpybiTisvX24CdPfqhh
	QaSo/Xueb7MUYW9DkxvbY=
X-Received: by 2002:a17:903:22ce:b0:240:a8c8:5f6f with SMTP id d9443c01a7336-242c22a0c4dmr149214435ad.27.1754880297118;
        Sun, 10 Aug 2025 19:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQGmESbcgQnsFMMENqJMFjx9cNlM1noV3xMR7G/xI2RDUr9pzR5lhTfwZsR29D3VOrmuAiSwzBZnYtSI+WvX4=
X-Received: by 2002:a17:903:22ce:b0:240:a8c8:5f6f with SMTP id
 d9443c01a7336-242c22a0c4dmr149214205ad.27.1754880296614; Sun, 10 Aug 2025
 19:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808153721.261334-1-simon.schippers@tu-dortmund.de> <689757e093982_2ad3722945f@willemb.c.googlers.com.notmuch>
In-Reply-To: <689757e093982_2ad3722945f@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Aug 2025 10:44:45 +0800
X-Gm-Features: Ac12FXzoWIUcI3SjBmgBouN2-NVQtxYqr_Frxhq9JvJ-Ez4KXxfRxpNoKJSZBpc
Message-ID: <CACGkMEuFXojXZ-tyaY284CXZmx+0nG4-bKB3dzsQvwuxmM9TwQ@mail.gmail.com>
Subject: Re: [PATCH net] TUN/TAP: Improving throughput and latency by avoiding
 SKB drops
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tim Gebauer <tim.gebauer@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 10:15=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Simon Schippers wrote:
> > This patch is the result of our paper with the title "The NODROP Patch:
> > Hardening Secure Networking for Real-time Teleoperation by Preventing
> > Packet Drops in the Linux TUN Driver" [1].
> > It deals with the tun_net_xmit function which drops SKB's with the reas=
on
> > SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
> > resulting in reduced TCP performance and packet loss for bursty video
> > streams when used over VPN's.
> >
> > The abstract reads as follows:
> > "Throughput-critical teleoperation requires robust and low-latency
> > communication to ensure safety and performance. Often, these kinds of
> > applications are implemented in Linux-based operating systems and trans=
mit
> > over virtual private networks, which ensure encryption and ease of use =
by
> > providing a dedicated tunneling interface (TUN) to user space
> > applications. In this work, we identified a specific behavior in the Li=
nux
> > TUN driver, which results in significant performance degradation due to
> > the sender stack silently dropping packets. This design issue drastical=
ly
> > impacts real-time video streaming, inducing up to 29 % packet loss with
> > noticeable video artifacts when the internal queue of the TUN driver is
> > reduced to 25 packets to minimize latency. Furthermore, a small queue
>
> This clearly increases dropcount. Does it meaningfully reduce latency?
>
> The cause of latency here is scheduling of the process reading from
> the tun FD.
>
> Task pinning and/or adjusting scheduler priority/algorithm/etc. may
> be a more effective and robust approach to reducing latency.
>
> > length also drastically reduces the throughput of TCP traffic due to ma=
ny
> > retransmissions. Instead, with our open-source NODROP Patch, we propose
> > generating backpressure in case of burst traffic or network congestion.
> > The patch effectively addresses the packet-dropping behavior, hardening
> > real-time video streaming and improving TCP throughput by 36 % in high
> > latency scenarios."
> >
> > In addition to the mentioned performance and latency improvements for V=
PN
> > applications, this patch also allows the proper usage of qdisc's. For
> > example a fq_codel can not control the queuing delay when packets are
> > already dropped in the TUN driver. This issue is also described in [2].
> >
> > The performance evaluation of the paper (see Fig. 4) showed a 4%
> > performance hit for a single queue TUN with the default TUN queue size =
of
> > 500 packets. However it is important to notice that with the proposed
> > patch no packet drop ever occurred even with a TUN queue size of 1 pack=
et.
> > The utilized validation pipeline is available under [3].
> >
> > As the reduction of the TUN queue to a size of down to 5 packets showed=
 no
> > further performance hit in the paper, a reduction of the default TUN qu=
eue
> > size might be desirable accompanying this patch. A reduction would
> > obviously reduce buffer bloat and memory requirements.
> >
> > Implementation details:
> > - The netdev queue start/stop flow control is utilized.
> > - Compatible with multi-queue by only stopping/waking the specific
> > netdevice subqueue.
> > - No additional locking is used.
> >
> > In the tun_net_xmit function:
> > - Stopping the subqueue is done when the tx_ring gets full after insert=
ing
> > the SKB into the tx_ring.
> > - In the unlikely case when the insertion with ptr_ring_produce fails, =
the
> > old dropping behavior is used for this SKB.
> > - In the unlikely case when tun_net_xmit is called even though the tx_r=
ing
> > is full, the subqueue is stopped once again and NETDEV_TX_BUSY is retur=
ned.
> >
> > In the tun_ring_recv function:
> > - Waking the subqueue is done after consuming a SKB from the tx_ring wh=
en
> > the tx_ring is empty. Waking the subqueue when the tx_ring has any
> > available space, so when it is not full, showed crashes in our testing.=
 We
> > are open to suggestions.
> > - Especially when the tx_ring is configured to be small, queuing might =
be
> > stopped in the tun_net_xmit function while at the same time,
> > ptr_ring_consume is not able to grab a packet. This prevents tun_net_xm=
it
> > from being called again and causes tun_ring_recv to wait indefinitely f=
or
> > a packet. Therefore, the queue is woken after grabbing a packet if the
> > queuing is stopped. The same behavior is applied in the accompanying wa=
it
> > queue.
> > - Because the tun_struct is required to get the tx_queue into the new t=
xq
> > pointer, the tun_struct is passed in tun_do_read aswell. This is likely
> > faster then trying to get it via the tun_file tfile because it utilizes=
 a
> > rcu lock.
> >
> > We are open to suggestions regarding the implementation :)
> > Thank you for your work!
> >
> > [1] Link:
> > https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publicatio=
ns/2
> > 025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> > [2] Link:
> > https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffec=
tive
> > -on-tun-device
> > [3] Link: https://github.com/tudo-cni/nodrop
> >
> > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > ---
> >  drivers/net/tun.c | 32 ++++++++++++++++++++++++++++----
> >  1 file changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index cc6c50180663..e88a312d3c72 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1023,6 +1023,13 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >
> >       netif_info(tun, tx_queued, tun->dev, "%s %d\n", __func__, skb->le=
n);
> >
> > +     if (unlikely(ptr_ring_full(&tfile->tx_ring))) {
> > +             queue =3D netdev_get_tx_queue(dev, txq);
> > +             netif_tx_stop_queue(queue);
> > +             rcu_read_unlock();
> > +             return NETDEV_TX_BUSY;
>
> returning NETDEV_TX_BUSY is discouraged.
>
> In principle pausing the "device" queue for TUN, similar to other
> devices, sounds reasonable, iff the simpler above suggestion is not
> sufficient.
>
> But then preferable to pause before the queue is full, to avoid having
> to return failure. See for instance virtio_net.

+1 and we probably need to invent new ptr ring helpers for that.

Thanks


