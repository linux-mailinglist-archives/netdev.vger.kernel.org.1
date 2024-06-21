Return-Path: <netdev+bounces-105567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8695D911D1E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BBD1C20CD9
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ADE16D4DF;
	Fri, 21 Jun 2024 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uLWM+gA4"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B8F16C6BD
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955849; cv=none; b=YMYktq/XSfTBY44vfOehRZ4Sa72HYDVOfgyNYoo8BGs0sQb8tnGd+weNddxaHEeJFgiaNpK+nicPQChYBDE6lvTU9g1lY7PJGl+Ko4rFxHM53uD8CGW8FVElaoYnQ62jp6BbOVUvFtMNf44Apm8tr14EBnPKKeQ9A0hmWJKiQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955849; c=relaxed/simple;
	bh=Sy9ZOn8NK7MnCsuHfevQ7ppL9Y9bZfsvNWY9MkGv39o=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=O8WYK0gsWaEL0pYZT/0aeRJGabJquWFcjmdVqB0/BlSasq7GqZ1kUOXWmMv+wkdlKJD9J6X+WjJHVvycRX+GUuYft7jh6lAG3GcT67aVsLQf8lEXt+K6oleMvN7OSSR6bZqh7V8DOjsB1/+PyTuqwZlaKU7Pv2dHU94JA+bIqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uLWM+gA4; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718955842; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=4xIHEedSkR7qBZvF3zyjozrFeMDZlYkrDToG/UgkIKU=;
	b=uLWM+gA41SYkt0s64kJk8i01LA4AIGS3iEK3+ESdCdOxctfip4ZOh5jgvuGWNoHpgQZ66WgZdVXj05tug8VURrwaeOYT8rhLPzx10VqcPBqEVYNKiUVFlw0vQ59IXoWxb+nv28UYLhhfCbabLkdr9W1pFP497ryLHMSDJIjeWnM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8vWSYq_1718955841;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8vWSYq_1718955841)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 15:44:02 +0800
Message-ID: <1718955706.2555537-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Date: Fri, 21 Jun 2024 15:41:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Heng Qi <hengqi@linux.alibaba.com>
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
Content-Type: text/plain; charset=utf-8
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
> > > >
> > > > And Qemu can calculate it correctly automatically since:
> > > >
> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > > > Author: Jason Wang <jasowang@redhat.com>
> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> > > >
> > > >     virtio-net: calculating proper msix vectors on init
> > > >
> > > >     Currently, the default msix vectors for virtio-net-pci is 3 whi=
ch is
> > > >     obvious not suitable for multiqueue guest, so we depends on the=
 user
> > > >     or management tools to pass a correct vectors parameter. In fac=
t, we
> > > >     can simplifying this by calculating the number of vectors on re=
alize.
> > > >
> > > >     Consider we have N queues, the number of vectors needed is 2*N =
+ 2
> > > >     (#queue pairs + plus one config interrupt and control vq). We d=
idn't
> > > >     check whether or not host support control vq because it was add=
ed
> > > >     unconditionally by qemu to avoid breaking legacy guests such as=
 Minix.
> > > >
> > > >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Yes, devices designed according to the spec need to reserve an interr=
upt
> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy=
 devices?
> > >
> > > Thanks.
> >
> > These aren't buggy, the spec allows this. So don't fail, but
> > I'm fine with using polling if not enough vectors.
>
> sharing with config interrupt is easier code-wise though, FWIW -
> we don't need to maintain two code-paths.


If we do that, we should introduce a new helper, not to add new function to
find_vqs().

if ->share_irq_with_config:
	->share_irq_with_config(..., vq_idx)

Thanks.


>
> > > >
> > > > Thanks
> > > >
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
> > > >
>

