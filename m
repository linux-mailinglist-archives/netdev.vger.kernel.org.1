Return-Path: <netdev+bounces-103921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E2690A5B9
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27695B27308
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 06:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86541836F7;
	Mon, 17 Jun 2024 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmC9tg+4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C322089
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605704; cv=none; b=dejCpRPrzMA4BwThWCQ8mSb58hej5hm+ZpJHZ1KQMVAxvPdw5F4G2liced6wwwz3On04SehboqLcagNADXvRy+4ZDy6IMtAF/Gij9dRsP6KjnoJpmUV3yN5EPG9XJ/Eq+6iysNBbeZE9ltzClsx/5mzywVMzqJH2zbTpxLpoCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605704; c=relaxed/simple;
	bh=OSTkYO2YEbZIEWcvOK8gFKoY42oPBjRDD1sYUp4a7Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf6G/dZgFp8Xdb+OXqRzq0ci2SQA2I6rhqwBMWEdqZvSZO9SAjgo3OahKe2UveRUx7AgLy4yUZtOAskDJf4Yzepb5zKU97SnHIvhpahaEkRiOJOEiUk0t9fBqcODNEv9vWd13VSbNjPo/hZryos5sDOFOMyNA8x9dYrzrzPcXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmC9tg+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718605702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ps5JswGrFVlCCUIk9N0xG3axjAOsPQkWEjzfIjAMKY=;
	b=QmC9tg+4stQv7TUOHiokkVQHdfDJY6mnoniX+JMv3474N+p2ay5i/Ka8paPxFS4FHuOGQ3
	UICtAiU5DAo+VwPX14p5EbD4M+B37hQHHI/Z/9z1VUBfruYuJqzBEROSRFZm5HLrCpZ8Hr
	eekcar8eBj7zLEebN05SkX/qalLDJro=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-renJwjSLNjG1wm9mdkGNMQ-1; Mon, 17 Jun 2024 02:28:19 -0400
X-MC-Unique: renJwjSLNjG1wm9mdkGNMQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6e53ddbbb1fso4174895a12.0
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 23:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605699; x=1719210499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ps5JswGrFVlCCUIk9N0xG3axjAOsPQkWEjzfIjAMKY=;
        b=UQDPdgQNRtjMocIoiuSUA2CnkRJ5ULbIPiO18M6XDA1Z8x6WzmloGrmrf6b/Jutnwj
         EIG4EvJOlJO1Y+WaY17mImCTfUtFQRlpijU/XRHjNlyhK8ya4Y3G7Hfvko+zhVxgiH27
         TL1klyLD7KX6v1oH16+5dLck49zeL89rgaixYF9g2sEC/BN0PAOfIO7vwrDIGYV/yA9F
         LVhgrw9AwP2dqshDAaKk138x955A8Z00elVdQ0tum1PN4rhaMT7WE5EF5Ph5Ffnn0wrY
         t9rwzNj7BQbUG5pBdNeGZ8wEded4cyCfBExasUibLa1jGmq5bxn85VvZs6gXjbh6gImI
         c6Jg==
X-Gm-Message-State: AOJu0Yyxmg15nfnrDe3MxfVckVcMzyCgEL8NDu+XUek5TUOhOdmqpPi1
	Q5H7GTEECFTLOHR5FTYeHCoFytU9lMjIoPtNhWm+hca0zKQWeyjx2d1tFNci0xDlCbXndPpLdiL
	RXpXIpJ03XJyicfVHcq0Tbu0N1KGlHjkfNh0nQTGfq5UwW+iY4aiutAycWQNvmt5zPOaLpIVJiU
	3CoYAa5jrXx/JkVlq4iRTdHnb7sdWv
X-Received: by 2002:a05:6a20:12c1:b0:1b8:7de9:6e3f with SMTP id adf61e73a8af0-1bae82b6515mr10689253637.53.1718605698723;
        Sun, 16 Jun 2024 23:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2baPcl2kCTFLwcSKILsceKj+PbJEWOMXTqE4MSXxS0p/rU+v6ZPazw+zzfETCZucrn8dwHiLbJUrZH9BYgxw=
X-Received: by 2002:a05:6a20:12c1:b0:1b8:7de9:6e3f with SMTP id
 adf61e73a8af0-1bae82b6515mr10689221637.53.1718605698270; Sun, 16 Jun 2024
 23:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com> <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
In-Reply-To: <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 14:28:05 +0800
Message-ID: <CACGkMEuxhaPcSyvNnZH3q1uvSUTbpRMr+YuK4r0x6zG_SKesbg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 1:00=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > If the xsk is enabling, the xsk tx will share the send queue.
> > But the xsk requires that the send queue use the premapped mode.
> > So the send queue must support premapped mode when it is bound to
> > af-xdp.
> >
> > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode.
> >
> >     In this mode, the driver will record the dma info when skb or xdp
> >     frame is sent.
> >
> >     Currently, the SQ premapped mode is operational only with af-xdp. I=
n
> >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
> >     the same SQ. Af-xdp independently manages its DMA. The kernel stack
> >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> >     info.
> >

Note that there's indeed a mode when we have exclusive XDP TX queue:

        /* XDP requires extra queues for XDP_TX */
        if (curr_qp + xdp_qp > vi->max_queue_pairs) {
                netdev_warn_once(dev, "XDP request %i queues but max
is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx
mode.\n",
                                 curr_qp + xdp_qp, vi->max_queue_pairs);
                xdp_qp =3D 0;
        }

So we need to mention how the code works in this patch.

Thanks


