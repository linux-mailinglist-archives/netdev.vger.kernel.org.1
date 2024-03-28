Return-Path: <netdev+bounces-82707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D0D88F52E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 03:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F931C25084
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 02:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4330025601;
	Thu, 28 Mar 2024 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LENwLeZj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259724219
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591956; cv=none; b=Dsdk0vnxNnukKlS+RRZRTw1T50uQ+awg9zAdbW/jZRLnS2aMv9f2+gAXergp2ZtTk3iVXVkctp/v9mgqYblvptWlzNacgioTdDD/irEi81EQ7L3/7EGO0v9XwF43TZKpp3/fYoHSJB11keNavuw1MWgd4infqYqHdsCM6n19uPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591956; c=relaxed/simple;
	bh=fLF3XzQmLz9/YfHOAXn16tdFNgocJP6NXbReD+iAkdA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mZJmNl6eqxkZ46dm+GEOS43FybULPgdvAXlnHNkKNbylweRTrrn7bNYJHhf7y/Vpwep1ZQoauME12U6FxYErjW6toZ46lhc5R5UIMkQDwXomuwDNLyV4dey+T1c9Hqg4zRf5tvB3er6IqNoWfmzAXC0rz24Bq7uGFi7u3P0l6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LENwLeZj; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711591951; h=Message-ID:Subject:Date:From:To;
	bh=sFzlbq2Tm/dxTiPc+rmjtCef/WTUAgyVr5UHaAn5P/I=;
	b=LENwLeZjU8GVZ0CZKIJ+1atnXf7TgAfpRpmLheu8YvgSOO9RULHpTa6fvkoM2dUztwrncbuCQt7O19oQ2FlNyEGTIx85huhQDxbpDqcnVsKTUngmUjtOPsyI8t7NojEHaTYDtkmEJ/iqTLlNbenpbQJDcMxM5dut10fm7oNkh/I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3QIRhR_1711591949;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3QIRhR_1711591949)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 10:12:30 +0800
Message-ID: <1711591930.8288093-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile fine-tuning
Date: Thu, 28 Mar 2024 10:12:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
 <netdev@vger.kernel.org>,
 Eric  Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Vladimir  Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 vadim.fedorenko@linux.dev,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
 <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
 <556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
 <20240327173258.21c031a8@kernel.org>
In-Reply-To: <20240327173258.21c031a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 27 Mar 2024 17:32:58 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 27 Mar 2024 15:45:50 +0100 Alexander Lobakin wrote:
> > > +/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
> > > +#define VIRTNET_DIM_RX_PKTS 256
> > > +static struct dim_cq_moder rx_eqe_conf[] = {
> > > +	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
> > > +	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
> > > +	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
> > > +	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
> > > +	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
> > > +};
> >
> > This is wrong.
> > This way you will have one global table for ALL the virtio devices in
> > the system, while Ethtool performs configuration on a per-netdevice basis.
> > What you need is to have 1 dim_cq_moder per each virtio netdevice,
> > embedded somewhere into its netdev_priv(). Then
> > virtio_dim_{rx,tx}_work() will take profiles from there, not the global
> > struct. The global struct can stay here as const to initialize default
> > per-netdevice params.
>
> I've been wondering lately if adaptive IRQ moderation isn't exactly
> the kind of heuristic we would be best off deferring to BPF.
> I have done 0 experiments -- are the thresholds enough
> or do more interesting algos come to mind for anyone?


Yes, we are working on this as well.

For netdim, I think profiles are an aspect. In many cases, this can solve many
problems.

It is a good idea to introduce bpf, but what bpf should do is some logical
situations that are not universal. In our practice, modifying profiles can solve
most situations. We also have a small number of scenarios that cannot be handled,
and we hope to use ebpf to solve them.

Thanks.

