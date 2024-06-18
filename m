Return-Path: <netdev+bounces-104284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB6390C0CA
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 02:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AF81C20E5E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 00:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994BE4C8F;
	Tue, 18 Jun 2024 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpTsahAs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E976FC2
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672042; cv=none; b=uvl0ekY2JaGAqUDQincPILlme5rnfkUPAXCILddoNTekO8f+Mx7qNBayXObqTfGwsx4yIr+Ud+Wl37dCYLTTQeB0FBh5W1N0hsaVnrXmpYGz3BL9IIRzW3Y/Co5gLRlp4NpBEk4zyu0v/CkxERWuhKvblsstlIRs01HrXj0gGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672042; c=relaxed/simple;
	bh=RYKtIx7uDfwbP0T9YiYoHYiypM9R1hDWXyVeUnsr7kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWWby/cxMpdS/r+ICTSSIv4KrbNkNfzblvOL7lr7cNS4jyB3b9g1BKXoiadB9kV0vNrqyRwqoZtQSN6ZBy0hX+9Tmf7lOdkDKKDiwSlboCSURKCbHiZftBG8xboWas1OQJRKksB3ToidK+eNmBzN68CkAOBiNUc1W1wgacEToSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpTsahAs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718672039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmL71C3FJTJByWMXzKPfpKXWNI3aDXcrDSNe1+QLOkQ=;
	b=YpTsahAsMpoIpd1rDIeyMLilWh3hYWOejVnBWC9SyOFsvvf7nJoNIfbHK2+0XJKx0RMgkB
	ozXrCKWaxdySkjYQoDgJXnJzJ1K+zHZHYiS6PH4u1P2wDnnInAWJJK1Wegp5EU69Vd8TIi
	7Vc9TR+nnZIp3X+lRT5Y7FX846FE0QA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-1uUaPSoFMR6w4EIZ4jwv2Q-1; Mon, 17 Jun 2024 20:53:57 -0400
X-MC-Unique: 1uUaPSoFMR6w4EIZ4jwv2Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c1a9e8d3b0so5355605a91.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672034; x=1719276834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmL71C3FJTJByWMXzKPfpKXWNI3aDXcrDSNe1+QLOkQ=;
        b=xAgdUQ1mHxiAxVh219Ev6Tzqrjfl1IU5mPl5jadMV62r9ZtF3VHk/yCc6XurkH6pTW
         qDJalm0vfs2YqaHlVhHQ3TnUy9oktNnf/3MTlRQ5WUvC1vvpX03oHBSZ+8IhpS1VSHBZ
         o55zaXNyF8OClSPUNAfhaG18Df3O/iRbAykMCA4J1oa43LVSVjdybhPDQHWFVK3NC1tr
         nzmq98evEJ6Fnu/KguGk85sZ+7NzyrRRMqP89vJ8bVdSf+1zVwhGHmGjH1e4FtUmVF20
         yj045zmNWH2hsBAFLYUBxMDyEo8zvQI69s435da5Dl7B1TFf96SkVksqbmwbRfjW4WVO
         DfhQ==
X-Gm-Message-State: AOJu0YxiadmiVNMTAvprRTBCfXmtd4hEIjhJ/4Cd4dwtaS1C6AkcLZ6m
	iUBbNzDKjak+9NcPtEo23YuZFCg/E6kAYmREnw+j9KG/p8wn9F21jYcUfAsPZQNWQotj0S8XGDm
	nAh78Ixu9CFCdCASg0UVt0DxFNGI9wUtyyATOReI51UVwA+7QEGL4faNy5vJngfdtUXH2U/yEKi
	V5w3IJD8TxJj4qWxK8uZWDpcFsKcOf
X-Received: by 2002:a17:90a:fe0b:b0:2c2:e0f1:ba7 with SMTP id 98e67ed59e1d1-2c4dbd3b008mr10580752a91.48.1718672033762;
        Mon, 17 Jun 2024 17:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE62BMEJg9Q4TfhENSHWt9inQEbHv/QKoiQpAfl/3nMwIg37/hLY6Q+1fhx0aVcZl4GGe+cJwWx96Vo3HitJhc=
X-Received: by 2002:a17:90a:fe0b:b0:2c2:e0f1:ba7 with SMTP id
 98e67ed59e1d1-2c4dbd3b008mr10580732a91.48.1718672033440; Mon, 17 Jun 2024
 17:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612170851.1004604-1-jiri@resnulli.us> <CACGkMEv-mO6Sus7_MkCR3B3QGukrig2e2KgBeVBcfOMU5uvo9g@mail.gmail.com>
 <Zm__WzuGEV8OdEKR@nanopsycho.orion>
In-Reply-To: <Zm__WzuGEV8OdEKR@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 08:53:42 +0800
Message-ID: <CACGkMEt9Vokeh6n8DKdBcqLRKVEXvNzM+-Zwad5eeMHvOdxXPw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	dave.taht@gmail.com, kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:18=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Jun 17, 2024 at 04:34:26AM CEST, jasowang@redhat.com wrote:
> >On Thu, Jun 13, 2024 at 1:09=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> From: Jiri Pirko <jiri@nvidia.com>
> >>
> >> Add support for Byte Queue Limits (BQL).
> >>
> >> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
> >> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
> >> running in background. Netperf TCP_RR results:
> >>
> >> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
> >> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
> >> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
> >> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
> >> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
> >> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
> >>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
> >>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
> >>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
> >>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
> >>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
> >>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
> >>
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >> v1->v2:
> >> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
> >>   propagate use_napi flag to __free_old_xmit() and only call
> >>   netdev_tx_completed_queue() in case it is true
> >> - added forgotten call to netdev_tx_reset_queue()
> >> - fixed stats for xdp packets
> >> - fixed bql accounting when __free_old_xmit() is called from xdp path
> >> - handle the !use_napi case in start_xmit() kick section
> >> ---
> >>  drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++--------------=
-
> >>  1 file changed, 32 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 61a57d134544..5863c663ccab 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
> >>
> >>  struct virtnet_sq_free_stats {
> >>         u64 packets;
> >> +       u64 xdp_packets;
> >>         u64 bytes;
> >> +       u64 xdp_bytes;
> >>  };
> >>
> >>  struct virtnet_sq_stats {
> >> @@ -506,29 +508,33 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
> >>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_F=
LAG);
> >>  }
> >>
> >> -static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> >> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queu=
e *txq,
> >> +                           bool in_napi, bool use_napi,
> >>                             struct virtnet_sq_free_stats *stats)
> >>  {
> >>         unsigned int len;
> >>         void *ptr;
> >>
> >>         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> >> -               ++stats->packets;
> >> -
> >>                 if (!is_xdp_frame(ptr)) {
> >>                         struct sk_buff *skb =3D ptr;
> >>
> >>                         pr_debug("Sent skb %p\n", skb);
> >>
> >> +                       stats->packets++;
> >>                         stats->bytes +=3D skb->len;
> >>                         napi_consume_skb(skb, in_napi);
> >>                 } else {
> >>                         struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> >>
> >> -                       stats->bytes +=3D xdp_get_frame_len(frame);
> >> +                       stats->xdp_packets++;
> >> +                       stats->xdp_bytes +=3D xdp_get_frame_len(frame)=
;
> >>                         xdp_return_frame(frame);
> >>                 }
> >>         }
> >> +       if (use_napi)
> >> +               netdev_tx_completed_queue(txq, stats->packets, stats->=
bytes);
> >> +
> >>  }
> >
> >I wonder if this works correctly, for example NAPI could be enabled
> >after queued but before sent. So __netdev_tx_sent_queue() is not
> >called before.
>
> How is that possible? Napi weight can't change when link is up. Or am I
> missing something?

Something like this:

1) packet were queued
2) if down
3) enable NAPI
4) if up
5) packet were sent

?

Thanks

>
> >
> >Thanks
> >
>


