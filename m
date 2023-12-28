Return-Path: <netdev+bounces-60428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF481F392
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 02:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21623281F59
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AF2643;
	Thu, 28 Dec 2023 01:27:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA972568
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VzMLDUl_1703726835;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzMLDUl_1703726835)
          by smtp.aliyun-inc.com;
          Thu, 28 Dec 2023 09:27:15 +0800
Message-ID: <1703726776.4667811-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 1/1] virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings
Date: Thu, 28 Dec 2023 09:26:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <yanjun.zhu@intel.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20231227142637.2479149-1-yanjun.zhu@intel.com>
 <723b710b-f9ff-431d-bde9-5d3deb657776@linux.dev>
In-Reply-To: <723b710b-f9ff-431d-bde9-5d3deb657776@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 27 Dec 2023 22:41:07 +0800, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>
> =E5=9C=A8 2023/12/27 22:26, Zhu Yanjun =E5=86=99=E9=81=93:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> >
> > Fix the warnings when building virtio_net driver.
> >
> > "
> > drivers/net/virtio_net.c: In function =E2=80=98init_vqs=E2=80=99:
> > drivers/net/virtio_net.c:4551:48: warning: =E2=80=98%d=E2=80=99 directi=
ve writing between 1 and 11 bytes into a region of size 10 [-Wformat-overfl=
ow=3D]
> >   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
> >        |                                                ^~
> > In function =E2=80=98virtnet_find_vqs=E2=80=99,
> >      inlined from =E2=80=98init_vqs=E2=80=99 at drivers/net/virtio_net.=
c:4645:8:
> > drivers/net/virtio_net.c:4551:41: note: directive argument in the range=
 [-2147483643, 65534]
> >   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
> >        |                                         ^~~~~~~~~~
> > drivers/net/virtio_net.c:4551:17: note: =E2=80=98sprintf=E2=80=99 outpu=
t between 8 and 18 bytes into a destination of size 16
> >   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
> >        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/virtio_net.c: In function =E2=80=98init_vqs=E2=80=99:
> > drivers/net/virtio_net.c:4552:49: warning: =E2=80=98%d=E2=80=99 directi=
ve writing between 1 and 11 bytes into a region of size 9 [-Wformat-overflo=
w=3D]
> >   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> >        |                                                 ^~
> > In function =E2=80=98virtnet_find_vqs=E2=80=99,
> >      inlined from =E2=80=98init_vqs=E2=80=99 at drivers/net/virtio_net.=
c:4645:8:
> > drivers/net/virtio_net.c:4552:41: note: directive argument in the range=
 [-2147483643, 65534]
> >   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> >        |                                         ^~~~~~~~~~~
> > drivers/net/virtio_net.c:4552:17: note: =E2=80=98sprintf=E2=80=99 outpu=
t between 9 and 19 bytes into a destination of size 16
> >   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> >
> > "
>
> Hi, all
>
> V1->V2: Add commit logs. Format string is changed.
>
> Best Regards,
>
> Zhu Yanjun
>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > ---

You can put the changes log after "---" inside the patch.

Thanks.

> >   drivers/net/virtio_net.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d16f592c2061..89a15cc81396 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4096,10 +4096,11 @@ static int virtnet_find_vqs(struct virtnet_info=
 *vi)
> >   {
> >   	vq_callback_t **callbacks;
> >   	struct virtqueue **vqs;
> > -	int ret =3D -ENOMEM;
> > -	int i, total_vqs;
> >   	const char **names;
> > +	int ret =3D -ENOMEM;
> > +	int total_vqs;
> >   	bool *ctx;
> > +	u16 i;
> >
> >   	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> >   	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed =
by
> > @@ -4136,8 +4137,8 @@ static int virtnet_find_vqs(struct virtnet_info *=
vi)
> >   	for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >   		callbacks[rxq2vq(i)] =3D skb_recv_done;
> >   		callbacks[txq2vq(i)] =3D skb_xmit_done;
> > -		sprintf(vi->rq[i].name, "input.%d", i);
> > -		sprintf(vi->sq[i].name, "output.%d", i);
> > +		sprintf(vi->rq[i].name, "input.%u", i);
> > +		sprintf(vi->sq[i].name, "output.%u", i);
> >   		names[rxq2vq(i)] =3D vi->rq[i].name;
> >   		names[txq2vq(i)] =3D vi->sq[i].name;
> >   		if (ctx)

