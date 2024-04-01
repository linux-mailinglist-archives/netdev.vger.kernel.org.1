Return-Path: <netdev+bounces-83699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1DD8937AD
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E2B2817E8
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277F7F;
	Mon,  1 Apr 2024 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cnZI3ilr"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE381C0DF8
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941009; cv=none; b=UnzrqCANZkdeUjavAbNKVWZaChkrbtZ8hKhxW60u6PAC/kt+ld9q1mLgILPjWs4Ce5VS+Rn5ML0rpEYyVUPLuT7EG48Mz/URYOoT+Gm7IqkZiR1VFx3n4CRRlvIYquuy4DYAv4m6EFb9iC7MXLdnGChUtwxdlsJPcFhF3f7edzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941009; c=relaxed/simple;
	bh=5rD5pYwEBPF9mnrp6IGl9JPh+Hr+NE4RH/8JaLR//TY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=IgrMp5DcHUN741pxjBdsi70L8bute6XCp0PA2lfEDGvT4rBlW0IrVbMIRH27bhQ4GyKq8ZLDZtzg9MZtk2nSntCtsTSfpLHuZURJtHpcvZyf9wlaMTLw+q6n+dwnDVEg8BD5IIDu1nxlrjHFjBZoaMsjqXMOKJd9gBnfRrn7Bec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cnZI3ilr; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711941004; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=5rD5pYwEBPF9mnrp6IGl9JPh+Hr+NE4RH/8JaLR//TY=;
	b=cnZI3ilra/0J3mHE/KuIpUO0vC1TJZelyQCk7Iae+VZlTvF7fCGVqaQToMt/ACmPg2EcWox/jP6EGVIfzdHGlburBAKnotQf08Clw/j8knCkEdPDDDv0Cd9hB/OpTLSr9XDsL6B3JeZ69eVIJ+dTIe/CeuvzlqxrnGAI//x1+y8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3dgpyi_1711941003;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3dgpyi_1711941003)
          by smtp.aliyun-inc.com;
          Mon, 01 Apr 2024 11:10:03 +0800
Message-ID: <1711940418.2573907-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
Date: Mon, 1 Apr 2024 11:00:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
 <1711614157.5913072-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEuBhfMwrfaiburLG7gFw36GuVHSbRTtK+FycrGFVTgOcA@mail.gmail.com>
 <1711935607.4691076-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711935607.4691076-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 1 Apr 2024 09:40:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> w=
rote:
> On Fri, 29 Mar 2024 11:20:08 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Mar 28, 2024 at 4:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > Now, the virtio core can set the premapped mode by find_vqs().
> > > > > If the premapped can be enabled, the dma array will not be
> > > > > allocated. So virtio-net use the api of find_vqs to enable the
> > > > > premapped.
> > > > >
> > > > > Judge the premapped mode by the vq->premapped instead of saving
> > > > > local variable.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > >
> > > > I wonder what's the reason to keep a fallback when premapped is not=
 enabled?
> > >
> > > Rethink this.
> > >
> > > I think you are right. We can remove the fallback.
> > >
> > > Because we have the virtio dma apis that wrap all the cases.
> > > So I will remove the fallback from the virtio-net in next version.
> >
> > Ok.
> >
> > >
> > > But we still need to export the premapped to the drivers.
> > > Because we can enable the AF_XDP only when premapped is true.
> >
> > I may miss something but it should work like
> >
> > enable AF_XDP -> enable remapping
> >
> > So can we fail during remapping enablement?
>
>
> YES.
>
> Enabling the premapped mode may fail, then we must stop to enable AF_XDP.
>
> AF-XDP requires that we export the dma dev to the af-xdp.
> We can do that only when the virtio core works with use_dma_api.
> Other other side, if we support the page-pool in future, we may have the
> same requirement.

Rethink this.

Enable premapped MUST NOT fail. No care the use_dma_api is true or not, bec=
ause
we have the DMA APIs for virtio. Then the virtio-net rx will work with
premapped (I will make the big mode work with premapped mode)

AF_XDP checks the virtqueue_dma_dev() when enabling.

But disabling premapped mode may fail, because that virtio ring need to
allocate memory for dma.

Thanks.



>
>
> Thanks.
>
>
> >
> > THanks
> >
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
>

