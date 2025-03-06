Return-Path: <netdev+bounces-172254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB9A53EF5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 01:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0841892E36
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 00:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155001C27;
	Thu,  6 Mar 2025 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXXXIp60"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077C1373
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220118; cv=none; b=c8bIlTrhrrf4pFpsUXHtMA6mafOVR5m0ThmWLFY1UqtoyD0Oa//gX7EmwXu2bi7iEBNXOIIKPHpDz8YEnr/9N52msn5GAetksuL58vgWKek6TqvLQ+FbkCtW6FLpu5Dc/kPD0XK+pv7jihpxdOYRlhZo/k8sLfPgsXXdZm94ROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220118; c=relaxed/simple;
	bh=/6IEXb3+kPC8h38g1+n1WPXpZUCUEbiDTLSputptZro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AVQ93FaZBFHrjpdOjohfIBNnGv/KQJGzw7q058lJOzWnkiygS7Xtca2lWpcJlRywlAcDrtt8W0ayVh45nTUI4O0c+ENO1XjxlU7paw3dEaeeAOu2elXAXYxP0USqZ5L2s4o26XYHnutIXi1iQtRTk9gZ6E9UNI2BfBpiiUnIWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXXXIp60; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741220115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzkSOfMIvpfEW3kC3MKb1XgIDTgn62WcB2Xn0huNZiQ=;
	b=QXXXIp6059+Y1VL9Qh1Y2DQbljO4TkTWiPLuKgG9pW/SyOdzlObBRBNR6pmae61ldT1K1Q
	pC9RDysQIsgF7vFcdAjk3LplZLmShd9+P/UQUPCCXs+zhfDerabqB77SFrk/ZG5uLRRxwm
	ZPhrPSVt8iSsCMiu0BIb7AtJs0K7aYY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-Iz6xZjIYO_CWw_V91Mx5aw-1; Wed, 05 Mar 2025 19:15:13 -0500
X-MC-Unique: Iz6xZjIYO_CWw_V91Mx5aw-1
X-Mimecast-MFC-AGG-ID: Iz6xZjIYO_CWw_V91Mx5aw_1741220113
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22379af38e0so801685ad.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 16:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220113; x=1741824913;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzkSOfMIvpfEW3kC3MKb1XgIDTgn62WcB2Xn0huNZiQ=;
        b=OBGyB3BJwWTYJ1UJAVo8aq7Wmn+Dp07SetFu4DbstsJblpJygO8Rsl+ROQ22WrCaPt
         jEZoNbxAPvLK/NemLu6XrY6TZQTKqTcp1h9V4tn2eAzgAyX7O8Y0K+SLe8Nppfkei2mV
         vJuqK8SGR1zG0eCXFqNQaRGsaXS1zytd35tiBgCcSxM/dOGXRccBBVk+bZV/7u0kqWTg
         GYvRnQO41C30z0Dt/huLp4xdHrEmZVk1vdQUzEj67GG5xxn2PF/cxfPVCL2LoD6MURXb
         +2LR44BryWs3kbPz7Xxq8yOeb+aw9TzdZtbs/tKjUeXPgJ5derpbKNlkDc+dT4wHCBwX
         SIAA==
X-Forwarded-Encrypted: i=1; AJvYcCWuvRlDNPoAdR3ZMdyt0KHYgC2PVwHLCevWBtCwo76JJoVBegXlTT884Gmwto7GjM32wTf7PJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytg7ovvSwhtcabrsaGIf0S67RU7DCEjbc1/3jivIC3Jh4UntRR
	E5bSke5O2kd+tQJf5pKgRdeeM7xSSHidFkvZNOK6I9hcD5VZ31sfF1vxQdrUHZLgGVoQdzLO7/T
	8Suq5h+3DLTaTRVSOToVs+h4k4vTcHKTHpfs02tlfWRF4cJc6QF7aHJ4mTNJ7bsk7qKMTaKb0zv
	C4Su9smEnJVqcir2EL/qYjQU8gENal
X-Gm-Gg: ASbGncvsjDv+2O9tXwmKtXH2sUdR9mD7RFbc+zPUjC22irGrBtlHatquRY38+1xcX3k
	/ZCBAwQ7u6Cq07e5cy4YM1yfH5ySMV9WXy1gtWdJLCTEovJQiGnIQ6XJLxQlAHdF1/oCmeFufZj
	U=
X-Received: by 2002:a05:6a00:3d0f:b0:736:3c6a:be02 with SMTP id d2e1a72fcca58-73682bfe22amr6348880b3a.11.1741220112729;
        Wed, 05 Mar 2025 16:15:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+Pz3spV69sGxcycRcHq7WRbf81Tq+kwPwJB61GZMQ3BtGGM82dqOuykRK2W4wGAVBuZATFe4m7QNuLdjS0w0=
X-Received: by 2002:a05:6a00:3d0f:b0:736:3c6a:be02 with SMTP id
 d2e1a72fcca58-73682bfe22amr6348836b3a.11.1741220112304; Wed, 05 Mar 2025
 16:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227185017.206785-1-jdamato@fastly.com> <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org> <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2> <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org> <Z8cXh43GJq2lolxE@LQ3V64L9R2>
 <CACGkMEug5+zjTjEiaUtvU6XtTe+tc7MEBaQSFbXG5YP_7tcPiQ@mail.gmail.com> <Z8h9IKvGh4z8h35Y@LQ3V64L9R2>
In-Reply-To: <Z8h9IKvGh4z8h35Y@LQ3V64L9R2>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Mar 2025 08:15:00 +0800
X-Gm-Features: AQ5f1JrbAXMd3bdeu_op8lg8kCwD5-0ozvqwDnLIuAighSIhe17FVCeIQAOl_N8
Message-ID: <CACGkMEvWuRjBbc3PvOUpDFkjcby5QNLw5hA_FpNSPyWjkEXD_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, mst@redhat.com, 
	leiyang@redhat.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:34=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Mar 05, 2025 at 01:11:55PM +0800, Jason Wang wrote:
> > On Tue, Mar 4, 2025 at 11:09=E2=80=AFPM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> > > > On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:
>
> [...]
>
> > > > Middle ground would be to do what you suggested above and just leav=
e
> > > > a well worded comment somewhere that will show up in diffs adding q=
ueue
> > > > API support?
> > >
> > > Jason, Michael, et. al.:  what do you think ? I don't want to spin
> > > up a v6 if you are opposed to proceeding this way. Please let me
> > > know.
> > >
> >
> > Maybe, but need to make sure there's no use-after-free (etc.
> > virtnet_close() has several callers).
>
> Sorry, I think I am missing something. Can you say more?
>
> I was asking: if I add the following diff below to patch 3, will
> that be acceptable for you as a middle ground until a more idiomatic
> implementation can be done ?

Yes, I misunderstand you before.

>
> Since this diff leaves refill_work as it functioned before, it
> avoids the problem Jakub pointed out and shouldn't introduce any
> bugs since refill_work isn't changing from the original
> implementation ?
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 76dcd65ec0f2..d6c8fe670005 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2883,15 +2883,9 @@ static void refill_work(struct work_struct *work)
>         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
>                 struct receive_queue *rq =3D &vi->rq[i];
>
> -               rtnl_lock();
> -               virtnet_napi_disable(rq);
> -               rtnl_unlock();
> -
> +               napi_disable(&rq->napi);
>                 still_empty =3D !try_fill_recv(vi, rq, GFP_KERNEL);
> -
> -               rtnl_lock();
> -               virtnet_napi_enable(rq);
> -               rtnl_unlock();
> +               virtnet_napi_do_enable(rq->vq, &rq->napi);
>
>                 /* In theory, this can happen: if we don't get any buffer=
s in
>                  * we will *never* try to fill again.
>

Works for me.

Thanks


