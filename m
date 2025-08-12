Return-Path: <netdev+bounces-212734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FDDB21B63
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE19A1A22BD8
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF5253359;
	Tue, 12 Aug 2025 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDMZAZKx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2539311C17
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968224; cv=none; b=SsYJRvrMV/jsZ/i1yhxG1iXJG+sUU5Pdx1DKFq3n3JK4HVXAdvomNHDQPeno5BVfHG4bKirB5WbYF4R8i0/m0+8Mv7qVlFnpfZW8Obvqom5l3a3lMNvB8kONDQQhIC+6aV2eEgDhX3TFaLibaW3dEEDWSmt2sPNcw5xBQ2PmjFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968224; c=relaxed/simple;
	bh=7v/0s5nP+fKPlg4zCbD/5YBz3mI28umU2OkTVOkQDcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYwJmRCtN+lPZsamOBNkcBcUwCDusMG4EwcOvU2mz3D4ElHVl1t/pWXFqsu/vFk15KNKAwiNZJ2ZL7aiA9/O0bkhieQGnisCtEer7NYnpp5EIom+KwOcM6AAVpL4ghpkmeCeoDQ9llaB5iO7/ZuM3R+W9x1h+v9WCLfxiAJGwPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDMZAZKx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754968221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DjDQ3z0BybAxITep+baEmHqyj5w4q7PIhLn/0gC8BA=;
	b=HDMZAZKxTJqci0EdglAziURaZQzlyJN/SS78vFC8vwXr4zwuqHrcaT2JBtJrMR817OOF41
	b5dz5BK5rmxcO/y2dlKAQ/ixUARWCJTVyM8nJdJePUJV3Z+0M3qkJFE8F7to1p3JNcSxTU
	GimEr8ci7ZN1XsbzDVTW8J24glPKIqs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-IsCUrTK3PPObMV1CA3-5nQ-1; Mon, 11 Aug 2025 23:10:19 -0400
X-MC-Unique: IsCUrTK3PPObMV1CA3-5nQ-1
X-Mimecast-MFC-AGG-ID: IsCUrTK3PPObMV1CA3-5nQ_1754968219
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2403e4c82ddso42708575ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 20:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754968219; x=1755573019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DjDQ3z0BybAxITep+baEmHqyj5w4q7PIhLn/0gC8BA=;
        b=pCFRNGCCktlGtyWsV9GlukKzYWc3FUf4lp+jtUC8AZ1m45QiFk0N5yUWvdv4MZGJf4
         kuhbUSZk2EAHGbCavZp/e3FGMXLOaZof4KniT5ky+BA3bQjbqopTZbzrKhSf197KXxRZ
         2UDxvvBe10u0T7lt1WgJ4ST7afDmx1QjgdMJVoM3EAxrcLokDFNeu2x/K21IoM2fwO5Q
         ij5avrqk8VFFiA96RsPCEliT10STXN/lTm+GlB4fCGle9Qepvbw9E7muAxmyeT6JaDQ+
         xVEM3nO2laoDBcAuscp9sb7i+bbCLlewj3RrBbxWyyL4GKaMdrB5XW/XT0h6lPi++daU
         c1rw==
X-Forwarded-Encrypted: i=1; AJvYcCV9bl5aKBDzbG8gSz16CjE9Fod2vpmKNHtKKvvdmDBge4uknNd3fo+h6OrRv4Ia9EonSqbfe64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8obcvSNlZmGKXGXaa9z1WV7L+cum1gZRpJc4l4oVrR7knn2k
	TWj7uqyfuLrZVLOtv4MImlerz9b2q+0tQo+eIvHwXL6UAH7JgQRm1WN7/bZ9vPE8YWISIIExNLH
	SBU8lt7lSH+7Fouyx1xhcfxpDYL7bx0FIf6MrY4/1wubSPaLh84StiiPdXlGklEW+PdhxieG3Fn
	Ws5SstDrIHSWw/DEDxX2ZvFEDe6a5OxYdr
X-Gm-Gg: ASbGnctkAEZQkgEoqmQYcukfvLt/p30BM3qBzZ2rQllJ6gX5uBJVslF+Z0ze9kJhF0N
	2jwv+D+V87XVrLy5OnxU5S/axTQupm87tjyar4KAGnRpDwPChEyq3rHA24q3hN23nJ8CjVwVwGE
	c9W/KL2CGJECJVRzCSucGpV74=
X-Received: by 2002:a17:902:ef47:b0:240:2e93:8a9a with SMTP id d9443c01a7336-242fc36fdbfmr26869875ad.42.1754968218558;
        Mon, 11 Aug 2025 20:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9qfM+3IY0AQWX0EvER9xl1Xdt/a7UxQFsq1gxRDMxeyfx9rCgxsUq4A5DuznfzS/HH0zz25IkIDYFKlUIVs4=
X-Received: by 2002:a17:902:ef47:b0:240:2e93:8a9a with SMTP id
 d9443c01a7336-242fc36fdbfmr26869535ad.42.1754968217949; Mon, 11 Aug 2025
 20:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Aug 2025 11:10:06 +0800
X-Gm-Features: Ac12FXw5kIUBogpDSpAswI2HzkUiTSu_KD1ROlTkjSnt_fp94queeq5ZE5CWHmQ
Message-ID: <CACGkMEvqYWH-dcG4ei8dERy_OXvyF3cgrzQ2_YO-imEsPoYSbQ@mail.gmail.com>
Subject: Re: [PATCH net v2] TUN/TAP: Improving throughput and latency by
 avoiding SKB drops
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tim Gebauer <tim.gebauer@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:04=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This patch is the result of our paper with the title "The NODROP Patch:
> Hardening Secure Networking for Real-time Teleoperation by Preventing
> Packet Drops in the Linux TUN Driver" [1].
> It deals with the tun_net_xmit function which drops SKB's with the reason
> SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
> resulting in reduced TCP performance and packet loss for bursty video
> streams when used over VPN's.
>
> The abstract reads as follows:
> "Throughput-critical teleoperation requires robust and low-latency
> communication to ensure safety and performance. Often, these kinds of
> applications are implemented in Linux-based operating systems and transmi=
t
> over virtual private networks, which ensure encryption and ease of use by
> providing a dedicated tunneling interface (TUN) to user space
> applications. In this work, we identified a specific behavior in the Linu=
x
> TUN driver, which results in significant performance degradation due to
> the sender stack silently dropping packets. This design issue drastically
> impacts real-time video streaming, inducing up to 29 % packet loss with
> noticeable video artifacts when the internal queue of the TUN driver is
> reduced to 25 packets to minimize latency. Furthermore, a small queue
> length also drastically reduces the throughput of TCP traffic due to many
> retransmissions. Instead, with our open-source NODROP Patch, we propose
> generating backpressure in case of burst traffic or network congestion.
> The patch effectively addresses the packet-dropping behavior, hardening
> real-time video streaming and improving TCP throughput by 36 % in high
> latency scenarios."
>
> In addition to the mentioned performance and latency improvements for VPN
> applications, this patch also allows the proper usage of qdisc's. For
> example a fq_codel can not control the queuing delay when packets are
> already dropped in the TUN driver. This issue is also described in [2].
>
> The performance evaluation of the paper (see Fig. 4) showed a 4%
> performance hit for a single queue TUN with the default TUN queue size of
> 500 packets. However it is important to notice that with the proposed
> patch no packet drop ever occurred even with a TUN queue size of 1 packet=
.
> The utilized validation pipeline is available under [3].
>
> As the reduction of the TUN queue to a size of down to 5 packets showed n=
o
> further performance hit in the paper, a reduction of the default TUN queu=
e
> size might be desirable accompanying this patch. A reduction would
> obviously reduce buffer bloat and memory requirements.
>
> Implementation details:
> - The netdev queue start/stop flow control is utilized.
> - Compatible with multi-queue by only stopping/waking the specific
> netdevice subqueue.
> - No additional locking is used.
>
> In the tun_net_xmit function:
> - Stopping the subqueue is done when the tx_ring gets full after insertin=
g
> the SKB into the tx_ring.
> - In the unlikely case when the insertion with ptr_ring_produce fails, th=
e
> old dropping behavior is used for this SKB.
>
> In the tun_ring_recv function:
> - Waking the subqueue is done after consuming a SKB from the tx_ring when
> the tx_ring is empty. Waking the subqueue when the tx_ring has any
> available space, so when it is not full, showed crashes in our testing. W=
e
> are open to suggestions.
> - When the tx_ring is configured to be small (for example to hold 1 SKB),
> queuing might be stopped in the tun_net_xmit function while at the same
> time, ptr_ring_consume is not able to grab a SKB. This prevents
> tun_net_xmit from being called again and causes tun_ring_recv to wait
> indefinitely for a SKB in the blocking wait queue. Therefore, the netdev
> queue is woken in the wait queue if it has stopped.
> - Because the tun_struct is required to get the tx_queue into the new txq
> pointer, the tun_struct is passed in tun_do_read aswell. This is likely
> faster then trying to get it via the tun_file tfile because it utilizes a
> rcu lock.
>
> We are open to suggestions regarding the implementation :)
> Thank you for your work!
>

I would like to see some benchmark results. Not only VPN but also a
classical VM setup that is using vhost-net + TAP.

> [1] Link:
> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications=
/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> [2] Link:
> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffecti=
ve-on-tun-device
> [3] Link: https://github.com/tudo-cni/nodrop
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
> V1 -> V2: Removed NETDEV_TX_BUSY return case in tun_net_xmit and removed
> unnecessary netif_tx_wake_queue in tun_ring_recv.
>
>  drivers/net/tun.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index cc6c50180663..81abdd3f9aca 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1060,13 +1060,16 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>
>         nf_reset_ct(skb);
>
> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +       queue =3D netdev_get_tx_queue(dev, txq);
> +       if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
> +               netif_tx_stop_queue(queue);
>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;

This would still drop the packet. Should we detect if the ring is
about to be full and stop then like a virtio-net?

Thanks


