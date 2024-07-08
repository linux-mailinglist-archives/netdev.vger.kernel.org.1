Return-Path: <netdev+bounces-109884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EAC92A27D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87081F227D6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088AF48CDD;
	Mon,  8 Jul 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MtJkaH0z"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8113C08A
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441244; cv=none; b=eARtSeo3fnnvuq2nsY3LjacNmsZigTQLUYxWuJ6pYXNhaEMFijskyFyXAyhzEC1/GnbL1WgA/uD39aUvw18Iy7XCnHianRJMJ6SjVGTdV0B3mSRsB87Gvd2MxiMMhWMkAS6hiVf5T4/bKxt1GLkwP68C7xRJqJFJYDcUSFej5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441244; c=relaxed/simple;
	bh=JUywPYK7LdYZcdkUZ+5/1PJDqoKNkpUP+hJwIvzPJXE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=sVOVgqYVls/dhFyuUHG/QVL9Mvujpn9n63qAjmukmJgoI/6LqIXwU8bUSIaejyUvR8wARGPlEizBxQiNKPAITzSEqF1UWdRYDlPMEAB0SpOLOaF9IuZ826rredNl5KNfDjs4EIMeM2zq7EV5KjP1WGpNfYqDilBbt6Klk2iLSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MtJkaH0z; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720441239; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=Rx6Ae7eRfpLUjn9z1ZNbbEHUalJk1s+zD1SaKmK9B94=;
	b=MtJkaH0zdemC0qdd/KIlfiMOMAx6aX+nJmZWPZpxSYrfjlVgeH45U1Sk/RK/lZFOBHcFwCMLeXHYVU8+/l3xK5KUSydsE2BpbfXmhMHPZTVW6jYdrKIy5V0dOAOTxTrL5N7OIRvAgVmAK8UbFJ+KfhIO748njDAJ2vrC+OEkjkY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WA5tnPr_1720441238;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WA5tnPr_1720441238)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 20:20:38 +0800
Message-ID: <1720441175.5614002-23-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Date: Mon, 8 Jul 2024 20:19:35 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718879494.952194-11-hengqi@linux.alibaba.com>
 <ZnvI2hJXPJZyveAv@nanopsycho.orion>
 <20240626040730-mutt-send-email-mst@kernel.org>
 <ZnvUn-Kq4Al0nMQZ@nanopsycho.orion>
 <20240626045313-mutt-send-email-mst@kernel.org>
 <ZnwApCUjIijZ7o0b@nanopsycho.orion>
 <ZovQOpmfOMs77lJ2@nanopsycho.orion>
In-Reply-To: <ZovQOpmfOMs77lJ2@nanopsycho.orion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 8 Jul 2024 13:40:42 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, Jun 26, 2024 at 01:51:00PM CEST, jiri@resnulli.us wrote:
> >Wed, Jun 26, 2024 at 11:58:08AM CEST, mst@redhat.com wrote:
> >>On Wed, Jun 26, 2024 at 10:43:11AM +0200, Jiri Pirko wrote:
> >>> Wed, Jun 26, 2024 at 10:08:14AM CEST, mst@redhat.com wrote:
> >>> >On Wed, Jun 26, 2024 at 09:52:58AM +0200, Jiri Pirko wrote:
> >>> >> Thu, Jun 20, 2024 at 12:31:34PM CEST, hengqi@linux.alibaba.com wro=
te:
> >>> >> >On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@red=
hat.com> wrote:
> >>> >> >> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wr=
ote:
> >>> >> >> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> >>> >> >> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> >>> >> >> > > > On Thu, Jun 20, 2024 at 4:21=E2=80=AFPM Jason Wang <jasow=
ang@redhat.com> wrote:
> >>> >> >> > > > >
> >>> >> >> > > > > On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi=
@linux.alibaba.com> wrote:
> >>> >> >> > > > > >
> >>> >> >> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirk=
in" <mst@redhat.com> wrote:
> >>> >> >> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi w=
rote:
> >>> >> >> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs=
(struct virtnet_info *vi)
> >>> >> >> > > > > > > >
> >>> >> >> > > > > > > >     /* Parameters for control virtqueue, if any */
> >>> >> >> > > > > > > >     if (vi->has_cvq) {
> >>> >> >> > > > > > > > -           callbacks[total_vqs - 1] =3D NULL;
> >>> >> >> > > > > > > > +           callbacks[total_vqs - 1] =3D virtnet_=
cvq_done;
> >>> >> >> > > > > > > >             names[total_vqs - 1] =3D "control";
> >>> >> >> > > > > > > >     }
> >>> >> >> > > > > > > >
> >>> >> >> > > > > > >
> >>> >> >> > > > > > > If the # of MSIX vectors is exactly for data path V=
Qs,
> >>> >> >> > > > > > > this will cause irq sharing between VQs which will =
degrade
> >>> >> >> > > > > > > performance significantly.
> >>> >> >> > > > > > >
> >>> >> >> > > > >
> >>> >> >> > > > > Why do we need to care about buggy management? I think =
libvirt has
> >>> >> >> > > > > been teached to use 2N+2 since the introduction of the =
multiqueue[1].
> >>> >> >> > > >=20
> >>> >> >> > > > And Qemu can calculate it correctly automatically since:
> >>> >> >> > > >=20
> >>> >> >> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> >>> >> >> > > > Author: Jason Wang <jasowang@redhat.com>
> >>> >> >> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> >>> >> >> > > >=20
> >>> >> >> > > >     virtio-net: calculating proper msix vectors on init
> >>> >> >> > > >=20
> >>> >> >> > > >     Currently, the default msix vectors for virtio-net-pc=
i is 3 which is
> >>> >> >> > > >     obvious not suitable for multiqueue guest, so we depe=
nds on the user
> >>> >> >> > > >     or management tools to pass a correct vectors paramet=
er. In fact, we
> >>> >> >> > > >     can simplifying this by calculating the number of vec=
tors on realize.
> >>> >> >> > > >=20
> >>> >> >> > > >     Consider we have N queues, the number of vectors need=
ed is 2*N + 2
> >>> >> >> > > >     (#queue pairs + plus one config interrupt and control=
 vq). We didn't
> >>> >> >> > > >     check whether or not host support control vq because =
it was added
> >>> >> >> > > >     unconditionally by qemu to avoid breaking legacy gues=
ts such as Minix.
> >>> >> >> > > >=20
> >>> >> >> > > >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com
> >>> >> >> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >>> >> >> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> >> >> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>> >> >> > >=20
> >>> >> >> > > Yes, devices designed according to the spec need to reserve=
 an interrupt
> >>> >> >> > > vector for ctrlq. So, Michael, do we want to be compatible =
with buggy devices?
> >>> >> >> > >=20
> >>> >> >> > > Thanks.
> >>> >> >> >=20
> >>> >> >> > These aren't buggy, the spec allows this. So don't fail, but
> >>> >> >> > I'm fine with using polling if not enough vectors.
> >>> >> >>=20
> >>> >> >> sharing with config interrupt is easier code-wise though, FWIW -
> >>> >> >> we don't need to maintain two code-paths.
> >>> >> >
> >>> >> >Yes, it works well - config change irq is used less before - and =
will not fail.
> >>> >>=20
> >>> >> Please note I'm working on such fallback for admin queue. I would =
Like
> >>> >> to send the patchset by the end of this week. You can then use it =
easily
> >>> >> for cvq.
> >>> >>=20
> >>> >> Something like:
> >>> >> /* the config->find_vqs() implementation */
> >>> >> int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >>> >>                 struct virtqueue *vqs[], vq_callback_t *callbacks[=
],
> >>> >>                 const char * const names[], const bool *ctx,
> >>> >>                 struct irq_affinity *desc)
> >>> >> {
> >>> >>         int err;
> >>> >>=20
> >>> >>         /* Try MSI-X with one vector per queue. */
> >>> >>         err =3D vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
> >>> >>                                VP_VQ_VECTOR_POLICY_EACH, ctx, desc=
);
> >>> >>         if (!err)
> >>> >>                 return 0;
> >>> >>         /* Fallback: MSI-X with one shared vector for config and
> >>> >>          * slow path queues, one vector per queue for the rest. */
> >>> >>         err =3D vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
> >>> >>                                VP_VQ_VECTOR_POLICY_SHARED_SLOW, ct=
x, desc);
> >>> >>         if (!err)
> >>> >>                 return 0;
> >>> >>         /* Fallback: MSI-X with one vector for config, one shared =
for queues. */
> >>> >>         err =3D vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
> >>> >>                                VP_VQ_VECTOR_POLICY_SHARED, ctx, de=
sc);
> >>> >>         if (!err)
> >>> >>                 return 0;
> >>> >>         /* Is there an interrupt? If not give up. */
> >>> >>         if (!(to_vp_device(vdev)->pci_dev->irq))
> >>> >>                 return err;
> >>> >>         /* Finally fall back to regular interrupts. */
> >>> >>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names,=
 ctx);
> >>> >> }
> >>> >>=20
> >>> >>=20
> >>> >
> >>> >
> >>> >Well for cvq, we'll need to adjust the API so core
> >>> >knows cvq interrupts are be shared with config not
> >>> >datapath.
> >>>=20
> >>> Agreed. I was thinking about introducing some info struct and pass ar=
ray
> >>> of it instead of callbacks[] and names[]. Then the struct can contain
> >>> flag indication. Something like:
> >>>=20
> >>> struct vq_info {
> >>> 	vq_callback_t *callback;
> >>> 	const char *name;
> >>> 	bool slow_path;
> >>> };
> >>>=20
> >>
> >>Yes. Add ctx too? There were attempts at it already btw.
> >
> >Yep, ctx too. I can take a stab at it if noone else is interested.
>=20
> Since this work is in v4, and I hope it will get merged soon, I plan to

I've seen your set and will help review it tomorrow.

> send v2 of admin queue parallelization patchset after that. Here it is:
> https://github.com/jpirko/linux_mlxsw/tree/wip_virtio_parallel_aq2
>=20
> Heng, note the last patch:
> virtio_pci: allow to indicate virtqueue being slow path
>=20
> That is not part of my set, it is ment to be merged in your control
> queue patchset. Then you can just indicate cvq to be slow like this:
>=20
>         /* Parameters for control virtqueue, if any */
>         if (vi->has_cvq) {
>                 vqs_info[total_vqs - 1].callback =3D virtnet_cvq_done;
>                 vqs_info[total_vqs - 1].name =3D "control";
>                 vqs_info[total_vqs - 1].slow_path =3D true;
>         }
>=20
> I just wanted to let you know this is in process so you may prepare.
> Will keep you informed.

Thanks for letting me know!

Regards,
Heng

>=20
> Thanks.

