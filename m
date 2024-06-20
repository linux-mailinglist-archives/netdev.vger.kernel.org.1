Return-Path: <netdev+bounces-105189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2849100D5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1D11F21C5A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002D1A4F37;
	Thu, 20 Jun 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZNwiLZnn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04DD199E91
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877290; cv=none; b=Cwp1+V37NlbwqO38Gr2mxBBAbG2YcpqIxFFJEKNJN4pIf3O1kvWfhpuQ/Ue2LcvXciRN0Sh5DY6dTIVu39NbTK1U3zYRPTc9J5IGv6pq0izXCzl8uh0myy5yzrcUQNPgbD5MCIJ0IqIjBL+hFvBFnrBAxK7DGcmd8IWs22W/pf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877290; c=relaxed/simple;
	bh=mfuiQNx4Y08gEmqvHzCsbcy3fnFUSlA+uYcce/ogIdk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=J0JDDFci9pRQlhbwub/3Z2I1kMl+zXyVuH35OliID6li1aUTeCKRKvGoHkqTw6zyCxgguX/nuqCkmQVAicvDPT+jziuV/Yx6/krnVcy2AnN+B7KC0IBoeRRexx+fnDYL9Fq5lq3xnoFbz9SKDT915RUPvSHExQkSlIP/vHIThNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZNwiLZnn; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718877281; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=IrEzfHdY3vnVmYLJx8eUcBUjvCBRCehaYVOpTDQCsH0=;
	b=ZNwiLZnnApq2oi1uAMaoQClE3ndlUYDplz8xibh4fjGdcuRnj5+Vg5y4zyh4B7qRHFgCU31aonmFq2bNeheSFc+V4QO+L5RjbRdNzgeuMREDtIxNCISpFMWbsR0Mpy2yQq0F/K1ZnX0tQlC/uEK/+Bi7f0hVynstlZrDJibfb9w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8rEzli_1718877280;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8rEzli_1718877280)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 17:54:41 +0800
Message-ID: <1718877195.0503237-9-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Date: Thu, 20 Jun 2024 17:53:15 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
In-Reply-To: <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.=
com> wrote:
> > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_=
info *vi)
> > > > >
> > > > >     /* Parameters for control virtqueue, if any */
> > > > >     if (vi->has_cvq) {
> > > > > -           callbacks[total_vqs - 1] =3D NULL;
> > > > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > > >             names[total_vqs - 1] =3D "control";
> > > > >     }
> > > > >
> > > >
> > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > this will cause irq sharing between VQs which will degrade
> > > > performance significantly.
> > > >
> >
> > Why do we need to care about buggy management? I think libvirt has
> > been teached to use 2N+2 since the introduction of the multiqueue[1].
>=20
> And Qemu can calculate it correctly automatically since:
>=20
> commit 51a81a2118df0c70988f00d61647da9e298483a4
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Mon Mar 8 12:49:19 2021 +0800
>=20
>     virtio-net: calculating proper msix vectors on init
>=20
>     Currently, the default msix vectors for virtio-net-pci is 3 which is
>     obvious not suitable for multiqueue guest, so we depends on the user
>     or management tools to pass a correct vectors parameter. In fact, we
>     can simplifying this by calculating the number of vectors on realize.
>=20
>     Consider we have N queues, the number of vectors needed is 2*N + 2
>     (#queue pairs + plus one config interrupt and control vq). We didn't
>     check whether or not host support control vq because it was added
>     unconditionally by qemu to avoid breaking legacy guests such as Minix.
>=20
>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Signed-off-by: Jason Wang <jasowang@redhat.com>

Yes, devices designed according to the spec need to reserve an interrupt
vector for ctrlq. So, Michael, do we want to be compatible with buggy devic=
es?

Thanks.

>=20
> Thanks
>=20
> >
> > > > So no, you can not just do it unconditionally.
> > > >
> > > > The correct fix probably requires virtio core/API extensions.
> > >
> > > If the introduction of cvq irq causes interrupts to become shared, th=
en
> > > ctrlq need to fall back to polling mode and keep the status quo.
> >
> > Having to path sounds a burden.
> >
> > >
> > > Thanks.
> > >
> >
> >
> > Thanks
> >
> > [1] https://www.linux-kvm.org/page/Multiqueue
> >
> > > >
> > > > --
> > > > MST
> > > >
> > >
>=20

