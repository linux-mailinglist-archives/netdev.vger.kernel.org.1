Return-Path: <netdev+bounces-194683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E301ACBE66
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 04:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330931890656
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8512BF24;
	Tue,  3 Jun 2025 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGtk7Utp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0A13C8EA
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916700; cv=none; b=NWAivR/nkCGZGEwVmcZBscNF6UKERxtAH9qiHe9q4tEYHlg4WczloFWdZV0cyyU6U6t0usXEabCzB3yC4TgFs2wKKUbxxD7WJUxJNP9aTjIbdIcccbTdWVPuAMYdtgEnrxEs/d4yQxoRrD5mWBEKxJCykX6m/NIPLBrOR4GXtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916700; c=relaxed/simple;
	bh=IFAVQ4UING9oX/1n2SvsOJA1MJINrK1tg0yR2895O9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVcf0pJGGdXNsilH4MjHx3VWU+5stOMmM/ELrsOY0SOA6yPSoj5WBM0urEONVS008HInakoHN8r5JT268nq0Tu6RXM7uIgVQkHSDli+3eqOyuu95TejR3hs+HlZxd+kyxP74ksWQTHFTtwYPIONkanYY1F18STvSzgqCG5RDv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGtk7Utp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748916696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JWuMkEwwsom5qf5kXq4SjZnUeYV0R34R5Pw8jZ+uz8=;
	b=YGtk7Utpv0gGxbsJ4xVEZ4iRv51+PgViOC2Aat+F4LTmOUJQXbwxL8ZZ+aVz/6ByNBEOKC
	G8yg92K51iqKcupZXvoc32AJHAuhAQ4v6wsMvjhwyuPHsJGPcH3OnpqOXWJ8KuZCGOAYZ/
	/Yb0khWXKJHm1QjdyUWrHHGfmnEx1Fc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-kH6X8g-zMoOib8wvrHggNQ-1; Mon, 02 Jun 2025 22:11:35 -0400
X-MC-Unique: kH6X8g-zMoOib8wvrHggNQ-1
X-Mimecast-MFC-AGG-ID: kH6X8g-zMoOib8wvrHggNQ_1748916695
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-312436c2224so5657242a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 19:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748916694; x=1749521494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JWuMkEwwsom5qf5kXq4SjZnUeYV0R34R5Pw8jZ+uz8=;
        b=Fr62C+cHVwUn0cdaEPEzoTM9EY0qvP98kevqqz3XHkP8kfkSx4Jy2S3G7u4QGp9NEZ
         xjVZSYmNKTDMdG0fMbX2AO7SfentSn+I+u2UEAums1A4nl7gktcjdVHP/jLgFxG5hHc7
         BDYjzkrYyW8CDjpU7c/tirbZrTWmKv/Rp1PoeuHRwlJB4s2rw4uyfmaoHxEHkdGqWiEn
         PIVypZ49raaAbQ4PzUlQj0JNmmxjoAPaMXzgFzFwogl2OwNP5mQnqlvU1oiAGmy3CI0o
         Wp6Dcxjl9VN+wSS1Hyz3MoBT0hbQ0w8JvHLZZFVOM+Uds8XeEu05zxPvrZSnAqap+NHL
         jM4A==
X-Gm-Message-State: AOJu0Yxpzb0sJCaUtgcRegAniPmKlKItm8Mvm65NwdXljzN2s5SfbAQu
	2FUzbP6Fs3lTBtXndroDHGuwhyz/BJhf2aQZOTHY39Mqb4Y1KNSBG1Hl6aRH60vtJFWxLbgnHMT
	EW00H799T4+lYo6HtCjnfUnqwVC2QE3QHcxA1qVE4CsbfbTjprgC6fPTpr6JxVRR8dCmO38Wknm
	TZ3HVsybi/38UpGQIKubotAcu3MVHzYvJj
X-Gm-Gg: ASbGncuLq2kUk0eQ1YXfrNgKO6FmMALa+DBv3xNA684fJCYelEjnCRFFd6wF2Pps0jZ
	urW5Gx+vrp08UHzlEQmUAx74CptqYec7HgnLSF4/KmXaucZJW3831dKRdR711Cb576nubkw==
X-Received: by 2002:a17:90b:2783:b0:311:ba2e:bdc9 with SMTP id 98e67ed59e1d1-31241865d41mr24480143a91.27.1748916694591;
        Mon, 02 Jun 2025 19:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkPvJe0lDYRhqWt8OgeWfkLs0iqlsvvwTq9GEee7wGoIfp3sc8KeXMECQMLr24iJWfjMaDEqyHq84NxA0hyos=
X-Received: by 2002:a17:90b:2783:b0:311:ba2e:bdc9 with SMTP id
 98e67ed59e1d1-31241865d41mr24480112a91.27.1748916694182; Mon, 02 Jun 2025
 19:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <f85bc2d08dfd1a686b1cd102977f615aa07b3190.1747822866.git.pabeni@redhat.com>
 <CACGkMEv=XnqKDXCEitEOs-AL1g=H=7WiHEaHrMUN-RfKN1JCRg@mail.gmail.com>
 <53242a04-ef11-4d5b-9c7e-7a34f7ad4274@redhat.com> <CACGkMEtZZbN8vj-V-PSwAmQKCP=gDN5sDz4TOXcOhNXGPLp_yQ@mail.gmail.com>
 <3d5c65e0-d458-4a56-8c93-c0b5d37420b5@redhat.com> <CACGkMEuBrzozRYqrgu8pM-+Ke2-NhCbFRHr8NeVpP15Qo0RZGg@mail.gmail.com>
 <f0a36685-45d0-4c4a-a256-74f3d4a31bd5@redhat.com>
In-Reply-To: <f0a36685-45d0-4c4a-a256-74f3d4a31bd5@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 10:11:21 +0800
X-Gm-Features: AX0GCFvtcNWC4K8jDh0ACqxmzqGDPiJaYJCozvXdScJ9bIS_b_HyOIy6Byqzv3Q
Message-ID: <CACGkMEvzJ1OSZhvTi1YtAstxDaeKMvyuMo8dWDiQ2P0ZfVqWzA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/8] virtio_pci_modern: allow setting configuring
 extended features
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 7:07=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/29/25 4:22 AM, Jason Wang wrote:
> > On Thu, May 29, 2025 at 12:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >> On 5/27/25 5:04 AM, Jason Wang wrote:
> >>> On Mon, May 26, 2025 at 6:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>> On 5/26/25 2:49 AM, Jason Wang wrote:
> >>>>> On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.=
com> wrote:
> >>>>>>
> >>>>>> The virtio specifications allows for up to 128 bits for the
> >>>>>> device features. Soon we are going to use some of the 'extended'
> >>>>>> bits features (above 64) for the virtio_net driver.
> >>>>>>
> >>>>>> Extend the virtio pci modern driver to support configuring the ful=
l
> >>>>>> virtio features range, replacing the unrolled loops reading and
> >>>>>> writing the features space with explicit one bounded to the actual
> >>>>>> features space size in word.
> >>>>>>
> >>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>>>>> ---
> >>>>>>  drivers/virtio/virtio_pci_modern_dev.c | 39 +++++++++++++++++----=
-----
> >>>>>>  1 file changed, 25 insertions(+), 14 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virt=
io/virtio_pci_modern_dev.c
> >>>>>> index 1d34655f6b658..e3025b6fa8540 100644
> >>>>>> --- a/drivers/virtio/virtio_pci_modern_dev.c
> >>>>>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> >>>>>> @@ -396,12 +396,16 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
> >>>>>>  virtio_features_t vp_modern_get_features(struct virtio_pci_modern=
_device *mdev)
> >>>>>>  {
> >>>>>>         struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common=
;
> >>>>>> -       virtio_features_t features;
> >>>>>> +       virtio_features_t features =3D 0;
> >>>>>> +       int i;
> >>>>>>
> >>>>>> -       vp_iowrite32(0, &cfg->device_feature_select);
> >>>>>> -       features =3D vp_ioread32(&cfg->device_feature);
> >>>>>> -       vp_iowrite32(1, &cfg->device_feature_select);
> >>>>>> -       features |=3D ((u64)vp_ioread32(&cfg->device_feature) << 3=
2);
> >>>>>> +       for (i =3D 0; i < VIRTIO_FEATURES_WORDS; i++) {
> >>>>>> +               virtio_features_t cur;
> >>>>>> +
> >>>>>> +               vp_iowrite32(i, &cfg->device_feature_select);
> >>>>>> +               cur =3D vp_ioread32(&cfg->device_feature);
> >>>>>> +               features |=3D cur << (32 * i);
> >>>>>> +       }
> >>>>>
> >>>>> No matter if we decide to go with 128bit or not. I think at the low=
er
> >>>>> layer like this, it's time to allow arbitrary length of the feature=
s
> >>>>> as the spec supports.
> >>>>
> >>>> Is that useful if the vhost interface is not going to support it?
> >>>
> >>> I think so, as there are hardware virtio devices that can benefit fro=
m this.
> >>
> >> Let me look at the question from another perspective. Let's suppose th=
at
> >> the virtio device supports an arbitrary wide features space, and the
> >> uAPI allows passing to/from the kernel an arbitrary high number of fea=
tures.
> >>
> >> How could the kernel stop the above loop? AFAICS the virtio spec does
> >> not define any way to detect the end of the features space. An arbitra=
ry
> >> bound is actually needed.
> >
> > I think this is a good question ad we have something that could work:
> >
> > 1) current driver has drv->feature_table_size, so the driver knows
> > it's meaningless to read above the size
> >
> > and
> >
> > 2) we can extend the spec, e.g add a transport specific field to let
> > the driver to know the feature size
>
> So I guess we can postpone any additional change here until we have some
> spec in place, right?

I think 1) should be sufficient. Considering we agree that
virtio_features_t will use arrays in the future, I'm fine to start
with int128.

Thanks

>
> /P
>


