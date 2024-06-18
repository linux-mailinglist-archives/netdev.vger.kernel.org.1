Return-Path: <netdev+bounces-104321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3623D90C246
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2D9B221BF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471BE19B3E4;
	Tue, 18 Jun 2024 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bSFWsHAC"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B371CD35
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 03:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680451; cv=none; b=hwq9LHavrqyjemaEj50/nj4y4rSUvOc9U8S9IUeiMXvBQ5Q5VwDRVi0x94+0xcuwd8esmNqgFXVaMdFp36Co6U+RsSF6alZmpMZhtyE/73dSZGshsS6Hs4Cb6ROPaX/hQhl7tNMM3tje5HDmk/rBfG/sX+qxq87czAuv6t+9U3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680451; c=relaxed/simple;
	bh=qRXyTZX2OkUozJMOq8bWxKjMrFDG5Bgt0J8ZW5T6vaA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=mtrEDZeQ6XLzircijBYjWGFA10nON/IZwQ8gICCx31+AWpDibm7I4O1a6dHv2y4nEtwBdHq96Er1jb4iVDLZ39IOdZnJphzQ4FNX0eWzA3zZJM+bCATmght7svl5OKBasv8SoIslauYsRzhjmQDkVmMsT4aze9lleRcSJ4dATvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bSFWsHAC; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718680446; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=yybrKyGBgZZjnqqkeW4JhYtcDkLEbDWaCZ2xY5rQl28=;
	b=bSFWsHACIUJrQ1Jj/doQfc1WHzMf0n9c8ZpR/rreAfv47/rSKWPcaIttjfa+Ygy2L27cvftWBbOAtPl3vcbBWMVuJr1HgH7pq66HZhKZ8tSStkurDiamLB/FPRiDBHsrjpuBE8cHxUG7gunR3KtfM6RkHsikWV3s9EE6p+h5mfQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8iUe-2_1718680444;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8iUe-2_1718680444)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 11:14:05 +0800
Message-ID: <1718680142.7236671-11-hengqi@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
Date: Tue, 18 Jun 2024 11:09:02 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 Thomas Huth <thuth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-2-hengqi@linux.alibaba.com>
 <CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
In-Reply-To: <CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 18 Jun 2024 11:01:27 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jun 17, 2024 at 9:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > In virtio spec 0.95, VIRTIO_NET_F_GUEST_CSUM was designed to handle
> > partially checksummed packets, and the validation of fully checksummed
> > packets by the device is independent of VIRTIO_NET_F_GUEST_CSUM
> > negotiation. However, the specification erroneously stated:
> >
> >   "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device MUST set fl=
ags
> >    to zero and SHOULD supply a fully checksummed packet to the driver."
> >
> > This statement is inaccurate because even without VIRTIO_NET_F_GUEST_CS=
UM
> > negotiation, the device can still set the VIRTIO_NET_HDR_F_DATA_VALID f=
lag.
> > Essentially, the device can facilitate the validation of these packets'
> > checksums - a process known as RX checksum offloading - removing the ne=
ed
> > for the driver to do so.
> >
> > This scenario is currently not implemented in the driver and requires
> > correction. The necessary specification correction[1] has been made and
> > approved in the virtio TC vote.
> > [1] https://lists.oasis-open.org/archives/virtio-comment/202401/msg0001=
1.html
> >
> > Fixes: 4f49129be6fa ("virtio-net: Set RXCSUM feature if GUEST_CSUM is a=
vailable")
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
>=20
> Acked-by: Jason Wang <jasowang@redhat.com>
>=20
> (Should we manually do checksum if RXCUSM is disabled?)
>=20

Currently we do not allow RXCUSM to be disabled.

Thanks.

> Thanks
>=20

