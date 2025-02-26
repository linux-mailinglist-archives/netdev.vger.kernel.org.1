Return-Path: <netdev+bounces-169773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5209DA45A75
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4523F16C48D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5023814D;
	Wed, 26 Feb 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpKfPp8H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143F20CCEA
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562920; cv=none; b=lPDQhjctbvAmZ+LiTGKAEEmy5ccX1KdQFX9taR2N9LIOF10Zh7sz3eTFj14rxIQvGB6tTjEUAx/EYMVKSvoj7bR3S5qtBBcMiyvcx1oepaGLn/fUIc2/NearpiqMD5//jU1mjcHDgfqdnzXZ7zcU6YLQOS5XRpij4yPsFtA+NMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562920; c=relaxed/simple;
	bh=vlwe3g7egmkzEBkQSzX3LSMTW10UmJaDYSyt6uIJXOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5kkzZeAgBkt3ndANhMhJJkl1penW2JMTkCEaIzV+16lH7MeM30Gq/Pr+fiWkxkEQkUMu+nbDFEKhF0FxpA+ueflq4MSREBZuSmJs2KU32ajYXu4blpTG/HVXdWgRBbI/xliKhRB0ltctdTY+QceTl6gwnmrz2jB3Ve+w8aeqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpKfPp8H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740562917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35a45e+KUNfgdwWER78OhdI0cbUBUXNz7n/UkAMYBnI=;
	b=EpKfPp8HpxVn8JqCC1ibBn1m2L4+GDqC3siV7m6N0zI5joz/1ibxrLa2eOQAzxuhhJj1qJ
	agFTlelwPPKi5QFAq7yS/MblVSOAzTvyrQQaTdhleSMKLuysf/KZdK/JiiVBIwVrXQG6l+
	F+qEXO0ljfkddEF6hXYykUQheGNi4e0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290--lx0Y7sLPs-zl_V-bBwz5g-1; Wed, 26 Feb 2025 04:41:55 -0500
X-MC-Unique: -lx0Y7sLPs-zl_V-bBwz5g-1
X-Mimecast-MFC-AGG-ID: -lx0Y7sLPs-zl_V-bBwz5g_1740562914
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso21574314a91.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562914; x=1741167714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35a45e+KUNfgdwWER78OhdI0cbUBUXNz7n/UkAMYBnI=;
        b=hMEeWb9/HWlxilmvw24JK4SnbTKB6Oao0gULLvujGSLK4bIgzmMzzWfCNjNsR8OY9b
         cPoz4gQdgPhlJR+ec9/yd0u36KaC1TBoulYv9qzueESAYm52R++UF9c0tKBiA4LWODrO
         Nh65sW2OSbMPAxu4QOA0pZDDQjN3P5eqXKWp8kUfVHdcvIqYhDMBmxNo8PFIihmPYcMN
         pmzxEERDRySg3YJczThrnlvUDuBbLHC6rd0vns6hy/QNyQF5Iri+ZrOPo6FcuXVocJiQ
         Oea29EMC/qg3E7PQYdorv/+QyvnuYASSl1PEVQuQbv4lmxMbYTW0PBgHPG25qOQIBXzP
         5j+g==
X-Forwarded-Encrypted: i=1; AJvYcCUaxK4CXiqsC3Fdn2206T/O27aAApyRxQTjLpymuQF+MarLveep4IdS90ntbtFg04+w0oBNEig=@vger.kernel.org
X-Gm-Message-State: AOJu0YysL7tdKcUL3VlbeFKZRnuYiHkIVTkma9kyh1hgyZaCCFgHuS3+
	YUCK2mjVfblNys8MMg0mMo9w0zAktuPJndWRXssjiEh7XITE5OvdgewpG48xahx6ix1uoO/XnPM
	pFvHm5ck6GI0dNk21xC7kQt02DcR1rQVC3jqAtI/DuyyL6xjekPEHLD66PrYvNM72kGuC8M57vM
	Pozva4YHN5TlUXsecHXqBlZYw3fiaq
X-Gm-Gg: ASbGncvcU666mmYaOfTqmYXY5+q5+tnCz7Bbj7gBEBcqDnQLwtUoxYGcPkPlzO2I6bm
	nNtKXGQOHt00AHfp0WVLtPbCTSY88yKvEs4WfFy9ZyH9KTX6xQ591pwG3qEVU/8YnfW7Xg6ldJg
	==
X-Received: by 2002:a17:90b:3bcb:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2fe68ae7147mr9875969a91.19.1740562914026;
        Wed, 26 Feb 2025 01:41:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd2VtFq1+EBSUe5YRiKx2c1b8xErNTKsEKpyNpzK8NMUkxluegLLjCSvqusnZyPT8sBH5l6nTPU/LhghJl6kU=
X-Received: by 2002:a17:90b:3bcb:b0:2ea:b564:4b31 with SMTP id
 98e67ed59e1d1-2fe68ae7147mr9875939a91.19.1740562913645; Wed, 26 Feb 2025
 01:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <CAPpAL=w7e8F_0_RRhBuyM-qyaYxgR=miYf_h90j78HzR4dvQxg@mail.gmail.com>
In-Reply-To: <CAPpAL=w7e8F_0_RRhBuyM-qyaYxgR=miYf_h90j78HzR4dvQxg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 17:41:41 +0800
X-Gm-Features: AWEUYZkhxJqSexlmCxlZ4MpaYPDcVZbl2V5cw5njrD7GTgOGPeEvAyX7SCzxTvM
Message-ID: <CACGkMEvaYvrxsbOdiN8tfba4t5vH_L8=5MnZqb_P6qNwv2x0Tw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] virtio-net: Link queues to NAPIs
To: Lei Yang <leiyang@redhat.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:47=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrot=
e:
>
> I tested this series of patches with virtio-net regression tests,
> everything works fine.
>
> Tested-by: Lei Yang <leiyang@redhat.com>

If it's possible, I would like to add the resize (via ethtool) support
in the regression test.

Thanks

>
>
> On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> =
wrote:
> >
> > Greetings:
> >
> > Welcome to v4.
> >
> > Jakub recently commented [1] that I should not hold this series on
> > virtio-net linking queues to NAPIs behind other important work that is
> > on-going and suggested I re-spin, so here we are :)
> >
> > This is a significant refactor from the rfcv3 and as such I've dropped
> > almost all of the tags from reviewers except for patch 4 (sorry Gerhard
> > and Jason; the changes are significant so I think patches 1-3 need to b=
e
> > re-reviewed).
> >
> > As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> > API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> > commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> > correctly elides the TX-only NAPIs (instead of printing zero) when the
> > queues and NAPIs are linked.
> >
> > See the commit message of patch 3 for an example of how to get the NAPI
> > to queue mapping information.
> >
> > See the commit message of patch 4 for an example of how NAPI IDs are
> > persistent despite queue count changes.
> >
> > Thanks,
> > Joe
> >
> > v4:
> >   - Dropped Jakub's patch (previously patch 1).
> >   - Significant refactor from v3 affecting patches 1-3.
> >   - Patch 4 added tags from Jason and Gerhard.
> >
> > rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@f=
astly.com/
> >   - patch 3:
> >     - Removed the xdp checks completely, as Gerhard Engleder pointed
> >       out, they are likely not necessary.
> >
> >   - patch 4:
> >     - Added Xuan Zhuo's Reviewed-by.
> >
> > v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastl=
y.com/
> >   - patch 1:
> >     - New in the v2 from Jakub.
> >
> >   - patch 2:
> >     - Previously patch 1, unchanged from v1.
> >     - Added Gerhard Engleder's Reviewed-by.
> >     - Added Lei Yang's Tested-by.
> >
> >   - patch 3:
> >     - Introduced virtnet_napi_disable to eliminate duplicated code
> >       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
> >       refill_work as suggested by Jason Wang.
> >     - As a result of the above refactor, dropped Reviewed-by and
> >       Tested-by from patch 3.
> >
> >   - patch 4:
> >     - New in v2. Adds persistent NAPI configuration. See commit message
> >       for more details.
> >
> > v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fast=
ly.com/
> >
> > [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> > [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
> >
> > Joe Damato (4):
> >   virtio-net: Refactor napi_enable paths
> >   virtio-net: Refactor napi_disable paths
> >   virtio-net: Map NAPIs to queues
> >   virtio_net: Use persistent NAPI config
> >
> >  drivers/net/virtio_net.c | 100 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 73 insertions(+), 27 deletions(-)
> >
> >
> > base-commit: 7183877d6853801258b7a8d3b51b415982e5097e
> > --
> > 2.45.2
> >
> >
>


