Return-Path: <netdev+bounces-138937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A159AF7AD
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 04:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE52281B12
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 02:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131918A920;
	Fri, 25 Oct 2024 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aQuuBMR/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AE69D2B
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824680; cv=none; b=l+J62hWFfXKw1/yrO6i5NVUivfQCzl1Epa+T1EtS8J8ts2dmN2T+RanykUMniDhJvqNwWa+GF+3BG8VYEyZFa1w7DF0y1Uw7AvaySS/tKSJrhrqY/KJclgSXpYzV5lZF8BJOCALRpIv1e1FeGkM0o3qTgpGwZzcTOotiVnzplqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824680; c=relaxed/simple;
	bh=w9pcyUc5pF/PQmOmRHoh4Nt3toT9SxYtiGyodDbujyQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=p2dXLHFDCTR2stWWIZghT+VlSJw5LLh3z7F8lNx3XWWyL0nTOcCjdmSaFGFkmrO0Airrud+Jb5jhTITd+dBWRLU+Ha3bXi4TmC5gwp3xUvN4jYm+H8s+7EvdJi5diFJMyOtL7yac1nM05Sc6SSaGbNvSJWO8PJ8t6X6zcuLSuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aQuuBMR/; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729824675; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=07UWTBkzM2yiRN/O7Q6tLoUyU1iy6xWp8IdG2zScB4I=;
	b=aQuuBMR/YprPL9icklRKKHzcjwBTdHETojhgpGEVBP6UtWtaLsuFayJ42NbBR9Q3geQThRtSice9WrS+faT98hEco9/0buyEZGiAar9AsTR9CTIHvP9dLFgGsuZCOBh6NxnqbDxFgdjv/Qtf9f+HgDFSDJE3GqAPdDlk2myq9uE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WHqp3hH_1729824673 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 10:51:14 +0800
Message-ID: <1729824434.8051903-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 2/5] virtio_net: introduce vi->mode
Date: Fri, 25 Oct 2024 10:47:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014031234.7659-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEvP99H0qEUsgkznS6brMbJcwV8BP37Fht28G2KtP-PLow@mail.gmail.com>
In-Reply-To: <CACGkMEvP99H0qEUsgkznS6brMbJcwV8BP37Fht28G2KtP-PLow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 18 Oct 2024 15:48:38 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 14, 2024 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Now, if we want to judge the rx work mode, we have to use such codes:
> >
> > 1. merge mode: vi->mergeable_rx_bufs
> > 2. big mode:   vi->big_packets && !vi->mergeable_rx_bufs
> > 3. small:     !vi->big_packets && !vi->mergeable_rx_bufs
> >
> > This is inconvenient and abstract, and we also have this use case:
> >
> > if (vi->mergeable_rx_bufs)
> >     ....
> > else if (vi->big_packets)
> >     ....
> > else
> >
> > For this case, I think switch-case is the better choice.
> >
> > So here I introduce vi->mode to record the virtio-net work mode.
> > That is helpful to judge the work mode and choose the branches.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 61 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 47 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 59a99bbaf852..14809b614d62 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -385,6 +385,12 @@ struct control_buf {
> >         virtio_net_ctrl_ack status;
> >  };
> >
> > +enum virtnet_mode {
> > +       VIRTNET_MODE_SMALL,
> > +       VIRTNET_MODE_MERGE,
> > +       VIRTNET_MODE_BIG
> > +};
>
> I'm not sure if this can ease or not.
>
> [...]
>
> > +       if (vi->mergeable_rx_bufs)
> > +               vi->mode =3D VIRTNET_MODE_MERGE;
> > +       else if (vi->big_packets)
> > +               vi->mode =3D VIRTNET_MODE_BIG;
>
> Maybe we can just say big_packets doesn't mean big mode.
>
> > +       else
> > +               vi->mode =3D VIRTNET_MODE_SMALL;
> > +
> >         if (vi->any_header_sg)
> >                 dev->needed_headroom =3D vi->hdr_len;
>
> Anyhow this seems not a fix so it should be a separate series than patch =
1?



I think this series is not about fixing the problem, the feature was disabl=
ed in
the last Linux version. This series is about turning the pre-mapped mode of=
 rx
back on.

This commit tries to make things easier. The current code is very unintuiti=
ve
when we try to switch or check the virtio-net rx mode

Thanks.


>
> Thanks
>
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>

