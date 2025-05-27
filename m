Return-Path: <netdev+bounces-193558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2A4AC46ED
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 05:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7905016F994
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 03:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E311AF0BB;
	Tue, 27 May 2025 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ig8LR//G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1A1802B
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 03:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748317878; cv=none; b=XtEK3twxoVKZaZjLUpC5WeyCG6TPwoEG4Ib4TYIMoOEafbocuEUEGkUN/42mozmOueWgSwJjqqnv5F7oCrHlMuBXLBhU0T97dMmF6n6AABmLDqWHIlGW20TgUo62yeYEip6BQWF8uJWrWubSv5DCl/m7NAjG1+jphLRW5alvngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748317878; c=relaxed/simple;
	bh=pd+T7iDccKIyZ7/hZ9BkJbfdNup6iOcCEMC7dfA0Nz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+pPyj+QjZZNT3TeuDnP+Ca6ISqYFbIOcgqOU3Coisdr+FS8P9qTUMImy0bV/1rZhkPOSRlQOEFMqnNqea+gNlqEUT21KChKxJqy0W456DXaBo3w5gAagJ5Gt/NIpQP3x/itJ3zpWNlO0zzr7/2CaAAk9zMJZC8D2VepP+G+BcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ig8LR//G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748317875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lm/wLe3TIw0czvYBQsnQAyj/qbDV9pHLOSo35dq/2k=;
	b=Ig8LR//GMQ005ECNDAsgmxBofWQKwm4Ow5AyIvsb11tmvt4UMfXKa6AZ8wSPwNbBC0PxNM
	NY+1Zqt6XiEmh9M4Yv8I9E7mbCCnK1V/bfrmQHdA85UV1haNrlMe933nJDUmzY2zg4KA8S
	iAyO0WRoNjpIL+nUVBGjo9wjakAWLwI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Iw7zKquPOCSz8oj4UwJOMg-1; Mon, 26 May 2025 23:51:13 -0400
X-MC-Unique: Iw7zKquPOCSz8oj4UwJOMg-1
X-Mimecast-MFC-AGG-ID: Iw7zKquPOCSz8oj4UwJOMg_1748317872
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311158ce5afso4310198a91.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748317872; x=1748922672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lm/wLe3TIw0czvYBQsnQAyj/qbDV9pHLOSo35dq/2k=;
        b=fBiKfiu/Nmz5k16ZyXblKEnBzEWvdbf0DZUjh1Wc3ihuWdEJSuvmeXQLmNf/GXMy7F
         gUH/02njFuMYZtOfQ9cHZEil8HjylIsXDLXJN3kKlM9b9VdQPPvlOlaXXaB5+f6rl95o
         7Fh+66dWgS5nZMPEeqzsywk7sPE/cwTYF/zZkGmr4Rdw90E4YNqsaoFcDXyV1y7Sz8HC
         ltQ39hs4rEFcz1Q6h/uDJCxihxux0Fq7T/BMG/FE4jTKfH8K8Gtw6LtVrXB0jk0nPWbM
         c0K6ptd7Z3TP6LSNkm0rnPnwJhTYS3OyueHVMnFQSyqWtai4Tfq3B1iRa7495/tMS7jd
         Jm8Q==
X-Gm-Message-State: AOJu0YxeWLgDn3RsENHnDdUs8RNyVmMLjeiCoVnJk5rqd4mgyc1CHvvR
	6HBRIxXjAa/Qyg1uXhXLa7Kyek+P/6ZYOzyDXoILO7LBJvqjvWGwiIOeZuukfLyHd19n5sUzCAE
	gmDv5bmRzUH1ZfMAuwiV6azVDrTo118vzhEYNPil5AcZtSEtVyrJL5I/FFDOhkfYk2oIgiK8FLo
	8mWlWBcv4IOcU6XWtbuNrFj64E8VWv6Hsm
X-Gm-Gg: ASbGnctPNiOtldqWhKiHDKfj9eOBjQ9MV7GUOroZ07saSnYxFo9XSlCzJuoV/s/4yAh
	OpThLhMwxgni53qWpl1kk5AVXGAOqWPMMS9hdIXNFb5NHWf3c/VmCGGcRyqqXv73kvwqRWA==
X-Received: by 2002:a17:90b:1910:b0:311:a314:c2d9 with SMTP id 98e67ed59e1d1-311a314c48bmr2517133a91.9.1748317871949;
        Mon, 26 May 2025 20:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbNBv2JDh0icmXeuFco9uKPr0++9JtWDVdYEW934MWwiCOo8EzgO73du3CVj4GjwqKZdhjzsKC1HmBpk2p5lI=
X-Received: by 2002:a17:90b:1910:b0:311:a314:c2d9 with SMTP id
 98e67ed59e1d1-311a314c48bmr2517118a91.9.1748317871486; Mon, 26 May 2025
 20:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
 <CACGkMEtGRK-DmonOfqLodYVqYhUHyEZfrpsZcp=qH7GMCTDuQg@mail.gmail.com> <2119d432-5547-4e0b-b7fc-42af90ec6b7a@redhat.com>
In-Reply-To: <2119d432-5547-4e0b-b7fc-42af90ec6b7a@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 May 2025 11:51:00 +0800
X-Gm-Features: AX0GCFu_Lp2HV8XWyOz2WpuBLu8yO9URSzDn045wGlaw2aZij3GwKPsLYeXaGtI
Message-ID: <CACGkMEsHn7q8BvfkaiknQTW9=WONLC_eB9DV0bcqL=oLa62Dxg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 3:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/26/25 2:43 AM, Jason Wang wrote:
> > On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_fe=
atures.h
> >> new file mode 100644
> >> index 0000000000000..2f742eeb45a29
> >> --- /dev/null
> >> +++ b/include/linux/virtio_features.h
> >> @@ -0,0 +1,23 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _LINUX_VIRTIO_FEATURES_H
> >> +#define _LINUX_VIRTIO_FEATURES_H
> >> +
> >> +#include <linux/bits.h>
> >> +
> >> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
> >> +#define VIRTIO_HAS_EXTENDED_FEATURES
> >> +#define VIRTIO_FEATURES_MAX    128
> >> +#define VIRTIO_FEATURES_WORDS  4
> >> +#define VIRTIO_BIT(b)          _BIT128(b)
> >> +
> >> +typedef __uint128_t            virtio_features_t;
> >
> > Consider:
> >
> > 1) need the trick for arch that doesn't support 128bit
> > 2) some transport (e.g PCI) allows much more than just 128 bit features
> >
> >  I wonder if it's better to just use arrays here.
>
> I considered that, it has been discussed both on the virtio ML and
> privatelly, and I tried a resonable attempt with such implementation.
>
> The diffstat would be horrible, touching a lot of the virtio/vhost code.

Let's start with the driver. For example, driver had already used
array for features:

        const unsigned int *feature_table;
        unsigned int feature_table_size;

For vhost, we need new ioctls anyhow:

/* Features bitmask for forward compatibility.  Transport bits are used for
 * vhost specific features. */
#define VHOST_GET_FEATURES      _IOR(VHOST_VIRTIO, 0x00, __u64)
#define VHOST_SET_FEATURES      _IOW(VHOST_VIRTIO, 0x00, __u64)

As we can't change uAPI for existing ioctls.

> Such approach will block any progress for a long time (more likely
> forever, since I will not have the capacity to complete it).
>

Well, could we at least start from using u64[2] for virtio_features_t?

> Also the benefit are AFAICS marginal, as 32 bits platform with huge
> virtualization deployments on top of it (that could benefit from GSO
> over UDP tunnel) are IMHO unlikely,

I think it's better to not have those architecture specific assumptions sin=
ce:

1) need to prove the assumption is correct or
2) we may also create blockers for 64 bit archs that don't support
ARCH_SUPPORTS_INT128.

> and transport features space
> exhaustion is AFAIK far from being reached (also thanks to reserved
> features availables).

I wouldn't be worried if a straightforward switch to int128 worked,
but it looks like that is not the case:

1) ARCH_SUPPORTS_INT128 dependency
2) new uAPI
3) we might want a new virtio config ops as well as most of transport
can only return 64 bit now

>
> TL;DR: if you consider a generic implementation for an arbitrary wide
> features space blocking, please LMK, because any other consideration
> would be likely irrelevant otherwise.
>
> /P
>

Thanks


