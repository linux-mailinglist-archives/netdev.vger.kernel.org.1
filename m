Return-Path: <netdev+bounces-104288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433890C0DC
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5884C1C20FAF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81BC6AD7;
	Tue, 18 Jun 2024 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgxcR4og"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49B4C98
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672473; cv=none; b=qYsEzgPjuGMW+ZdecO2GeZIACpGYi+tQi6Wht5t9Ex6EAXboGOXwwMnT9a1r4NIqommmoiTk8kqlNLUq2OQHdi+JVSYg2+28+GduzzNQ29Doi+UrE/wBshOiVjNZaY3iP/dZ1X4SHmaMl3YSCKghTqgd0iAEXDP3Wlt3D0C8Mwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672473; c=relaxed/simple;
	bh=o9dUcKuCDkZLFH+Ize0uSknTGiExmyABhsMcYCOQ1LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4f8s+kPKIS6G4yPcU6kRYS3SvpSL/SSqrU8PEGFd97Kkweqyw2dEymzAqLELrG4qv60YEmgMMsssbpvEy8+35LEnrtCI3cZ/YXFDcUqlJJMVmHAi0idTP7Pc3obYgMg/FVSoMZM/d2qIP8EopcQzVtgzQVUknmL7TkA3EiyyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgxcR4og; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718672471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXvv2GQTrxLVyV8hwACjfrya2w52VLmD0zOMjFGecj4=;
	b=QgxcR4ogZWZOKMYi8l+jXRNiWQNQlZYZVSIPTP5avwQl0KbpVvCebStHA9dwttPpJBYioS
	Atim9JAmYybX35wm2UVQMj6+JEerj65k+nsYS43G6RGOO3164XQMTJcMOBlhylZxOPpgT/
	iHoxtgAUw5zB00lh2cej9wE8ZvP+Wpk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-KY7btAOvNdiNfhYxiLfanw-1; Mon, 17 Jun 2024 21:01:09 -0400
X-MC-Unique: KY7btAOvNdiNfhYxiLfanw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c2dfa5cfa5so5202473a91.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672468; x=1719277268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXvv2GQTrxLVyV8hwACjfrya2w52VLmD0zOMjFGecj4=;
        b=ANATvBt44sWS5wcFqgXdchehONJ19kuvF1NdLVgnpNVv0m+e4dlGTjdepBmlkq7zK+
         SKthEFtNei3lK4tjRAWERWtF2eohK0IxFlNPeaeplsdpTciftKVbt+aetOhj9nUKJmu1
         HOo0vAYUEoauYDZhCd1Mav8wH+7vqZ/1sWmR3sgzHz9ADO0cuL4DeY9ToIOo3RingNSS
         QF0HNovkD7bDM9HuiYDyKLZU/r2a/y+tHsEz9jj4DfnJ1PxZpzt3UvzIunKW6RLFY0+L
         DGIgA/NpRy259suAbkINe3bpuwk7RuJP0AvHNY/wsqX8jYZhC1i2ZIclGsk/9f136wQg
         oCmg==
X-Gm-Message-State: AOJu0YwlnVAAZXSjaW/IEPQEoEEyUKCGgMNnQT6EjXx7dgNYWivahwF0
	ertYtIyokrSkR2K/3JFzOPHBNAY2D9KP6F5ORhCC7iGvWGhLpq7FCB5vDfxLQr8ieuUR19KR9o0
	rHITsrZ5BKjO1nhICZixc5qQnTUAj9Z3nlFRcunoFEkxaKuvWcA1VX6kkoFclfq5r4ihm326NxG
	t9YqsvJjyzf1eVaWiwd6TIK8yp34Gm
X-Received: by 2002:a17:90a:b401:b0:2c4:a7af:4d79 with SMTP id 98e67ed59e1d1-2c4db2483f5mr10217150a91.11.1718672468410;
        Mon, 17 Jun 2024 18:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEOesevLHOR9KmJxw9wrE7RFv500NZL2XhwPTXQc8HuT59F/ZwbthYrkZcg2Fiy3f73wAPCU0c6b9+nYuQJqo=
X-Received: by 2002:a17:90a:b401:b0:2c4:a7af:4d79 with SMTP id
 98e67ed59e1d1-2c4db2483f5mr10217114a91.11.1718672467972; Mon, 17 Jun 2024
 18:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com> <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
 <CACGkMEuxhaPcSyvNnZH3q1uvSUTbpRMr+YuK4r0x6zG_SKesbg@mail.gmail.com> <1718610035.6750584-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1718610035.6750584-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 09:00:56 +0800
Message-ID: <CACGkMEuWCYdvYkxPBodw4cuxDhkszJkA0h9rwDOKVLJFjaxyEw@mail.gmail.com>
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

On Mon, Jun 17, 2024 at 3:41=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 17 Jun 2024 14:28:05 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jun 17, 2024 at 1:00=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > But the xsk requires that the send queue use the premapped mode.
> > > > So the send queue must support premapped mode when it is bound to
> > > > af-xdp.
> > > >
> > > > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mo=
de.
> > > >
> > > >     In this mode, the driver will record the dma info when skb or x=
dp
> > > >     frame is sent.
> > > >
> > > >     Currently, the SQ premapped mode is operational only with af-xd=
p. In
> > > >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will s=
hare
> > > >     the same SQ. Af-xdp independently manages its DMA. The kernel s=
tack
> > > >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> > > >     info.
> > > >
> >
> > Note that there's indeed a mode when we have exclusive XDP TX queue:
> >
> >         /* XDP requires extra queues for XDP_TX */
> >         if (curr_qp + xdp_qp > vi->max_queue_pairs) {
> >                 netdev_warn_once(dev, "XDP request %i queues but max
> > is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx
> > mode.\n",
> >                                  curr_qp + xdp_qp, vi->max_queue_pairs)=
;
> >                 xdp_qp =3D 0;
> >         }
> >
> > So we need to mention how the code works in this patch.
>
> Sorry, I do not get it.
>
> Could you say more?

I meant in the commit log, you said:

"""
In this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
the same SQ.
"""

is not correct if we have sufficient queue pairs.

We need to tweak it and explain if the code can still work if we have
exclusive XDP TX queues.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>


