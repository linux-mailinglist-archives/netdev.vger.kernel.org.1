Return-Path: <netdev+bounces-105200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9059B910182
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106C4282510
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311631A8C3B;
	Thu, 20 Jun 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HyAMYTS+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C822594
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879612; cv=none; b=hxIP3zoHfODq9LuxKtWhez1BSjpS/sSNyFJcTzI/q0qaYBJfgJN7cOGNjPxZYskfFWT7HMnUMlAfzvdldfoHTm5ARQlhCRAY7BhEL1F/DTdvicRdXT96ZQZbpSQ59BlPCauWjDOekwG6vo+L6lYxbTr7+NfV//kudT59Oa3QQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879612; c=relaxed/simple;
	bh=lwjRdInxaz+BwwfNopbOTAclyOjdeOWa2bzPsTLxyzU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=MTPcuexS79xP7Ts3YctR2BaXeE8+rrpFSZYaTrE7r8vJqn81RuH9y+gnugbOQ5EDfxj0Dm1fPUkv3VnEdKO4mio5hq8PU2dVk2mDnCvAJpRimKbQm7++P3pw5i6e4Xn8bhz6knueyk9Gfu7UW6WOa1gvecgUkXtjp4iXpEYEyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HyAMYTS+; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718879607; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=Mga/fS+X7ChpebY6EN4dcVxyUcm7HRc2D3toPbZ37ig=;
	b=HyAMYTS+F7AYBIZpg907+cdtpJkmrYR1/4lUJdGdQSuQbZWkmkh14OirTnt0vJKqwq8bst5eB+KUpJluYKZ/xOvXiNO+Nk9j2jNaKvkmp9jj8a3nrE44qOkHIxHHbKvaFYzu5sqD27mYewxek0TWLGH+usyALsSktLegQYoo0RY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8s9a-Z_1718879606;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8s9a-Z_1718879606)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 18:33:26 +0800
Message-ID: <1718879494.952194-11-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Date: Thu, 20 Jun 2024 18:31:34 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
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
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620061109-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Jun 20, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.ali=
baba.com> wrote:
> > > > > >
> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@r=
edhat.com> wrote:
> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct vi=
rtnet_info *vi)
> > > > > > > >
> > > > > > > >     /* Parameters for control virtqueue, if any */
> > > > > > > >     if (vi->has_cvq) {
> > > > > > > > -           callbacks[total_vqs - 1] =3D NULL;
> > > > > > > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > > > > > >             names[total_vqs - 1] =3D "control";
> > > > > > > >     }
> > > > > > > >
> > > > > > >
> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > > > > this will cause irq sharing between VQs which will degrade
> > > > > > > performance significantly.
> > > > > > >
> > > > >
> > > > > Why do we need to care about buggy management? I think libvirt has
> > > > > been teached to use 2N+2 since the introduction of the multiqueue=
[1].
> > > >=20
> > > > And Qemu can calculate it correctly automatically since:
> > > >=20
> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > > > Author: Jason Wang <jasowang@redhat.com>
> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> > > >=20
> > > >     virtio-net: calculating proper msix vectors on init
> > > >=20
> > > >     Currently, the default msix vectors for virtio-net-pci is 3 whi=
ch is
> > > >     obvious not suitable for multiqueue guest, so we depends on the=
 user
> > > >     or management tools to pass a correct vectors parameter. In fac=
t, we
> > > >     can simplifying this by calculating the number of vectors on re=
alize.
> > > >=20
> > > >     Consider we have N queues, the number of vectors needed is 2*N =
+ 2
> > > >     (#queue pairs + plus one config interrupt and control vq). We d=
idn't
> > > >     check whether or not host support control vq because it was add=
ed
> > > >     unconditionally by qemu to avoid breaking legacy guests such as=
 Minix.
> > > >=20
> > > >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >=20
> > > Yes, devices designed according to the spec need to reserve an interr=
upt
> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy=
 devices?
> > >=20
> > > Thanks.
> >=20
> > These aren't buggy, the spec allows this. So don't fail, but
> > I'm fine with using polling if not enough vectors.
>=20
> sharing with config interrupt is easier code-wise though, FWIW -
> we don't need to maintain two code-paths.

Yes, it works well - config change irq is used less before - and will not f=
ail.

Thanks.

>=20
> > > >=20
> > > > Thanks
> > > >=20
> > > > >
> > > > > > > So no, you can not just do it unconditionally.
> > > > > > >
> > > > > > > The correct fix probably requires virtio core/API extensions.
> > > > > >
> > > > > > If the introduction of cvq irq causes interrupts to become shar=
ed, then
> > > > > > ctrlq need to fall back to polling mode and keep the status quo.
> > > > >
> > > > > Having to path sounds a burden.
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
> > > > >
> > > > > > >
> > > > > > > --
> > > > > > > MST
> > > > > > >
> > > > > >
> > > >=20
>=20

