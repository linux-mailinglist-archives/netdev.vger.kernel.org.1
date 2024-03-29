Return-Path: <netdev+bounces-83163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CCF8911EF
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 04:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45756B231A2
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9242B38F87;
	Fri, 29 Mar 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaiJLN58"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828637165
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682667; cv=none; b=DslrECKlQx/DW2DiM7qnEJVAjjBWpWCwN3/s06wxf0xh8rNStsoz27gUlURtxdsvQRbUNhdoQJxOEL1XRtD7BCeBVyJ/LpmZxkUCwULKyeOh9uZRKGqbPyvFLTnOGIrVJw2v9xXyy6K0E+tNagm5RwQ3bKibxPq4EtInjZBl7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682667; c=relaxed/simple;
	bh=/fG2JnYUZfUyDB3Lw/EmsvV7Xz+nRAw6bOwVHap1V2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z60N25eL57DxqV+v7F6pH/3z0luicGkFnRXFvKpQIkyWzWwRSBtVUW9d4zE8mxIYUp6BA76DTb0nihAgIROwM1DMnBVf8c84PyUhA37Mqljohj1M/Il6xfGQsusCY3317LWjSv230C6Kteed/lqZfO0aEKZkiHUKRYU45E/ul1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaiJLN58; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711682664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Eq/UGEZlb6s/SpvkWTV9xqs1ZCeAFO66kFsPV97qNI=;
	b=XaiJLN58DTj9HRnOpql+G8765TeighrhH+H+jGqbrYdI4vairGU4s/bSRQ4SVGhran6kdY
	HD8uTL0U+6mNxWLBQMTap3ODJ2mV3hfPxwg91ZyZpTSgHFgGlPtGRlmL3PMDgN2aP/bwKB
	Qhg0/dBEDfrPOvy1twy6lcR83DKmq7I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-ofc7nJgsOfmrXD9EMMENXQ-1; Thu, 28 Mar 2024 23:24:23 -0400
X-MC-Unique: ofc7nJgsOfmrXD9EMMENXQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a04aded772so1562943a91.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 20:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682662; x=1712287462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Eq/UGEZlb6s/SpvkWTV9xqs1ZCeAFO66kFsPV97qNI=;
        b=wajFEmMMh/Ohk9sENgHYMVZfHHzlUan6w+D7GR7mayZpunbVDkUAGpcIc5VsM8yqw2
         8spQlmxqzAwV3ubQAIlPv6YF1/nw9puMR2kF6nXzSRziFSeKvhWGKyT9UzcCjj23dfWh
         gcvWxpXE4Z5dkO8hsv+h3gjg2l8EHFBae2TFlC6uD7RYI95MknLyv6+vrMEw/R3YnfYu
         5gnWzITlyLphqZ2NnBcxxrtIgD5MH6/8hu0DS130GmcDZrNdwFT/OyrYh+tuPUtBMKUI
         QIKLu0n6XEfDJ+Sawm9XBTeVxTOWGQofefDEdKtFpr8ZwYL3yVtbHdjCFdWNaY0FIjrt
         Bfxg==
X-Forwarded-Encrypted: i=1; AJvYcCXvuGM4piiInscj8RidxpC/B4cpp27orcXmHgNUktQrOPj+DVopwY8c9Dp2uUusCxv9joqNUwKp0WYwJqdcVwHgEVA0G4IL
X-Gm-Message-State: AOJu0YxLqy+tGRVh8cQJLRd/eZVNq9OJjjmjRiWB6gWpEPBgp3g4Sysc
	8fIbK65Ew2Guyr+4U81VNPI+xxcaxMhmcUV7ZOgxGpOWoLyqmO0l3euopTakHzQvbKJZm6sBG3s
	g2LhpEjY+lOh6V02eXLIgE3co6gEqXwJZsKLckmg5swTjVv7mnYoME+dSFXmo/DSRMAf3DdtNsa
	2bkRxUuSW8hh/PBXst7MhqbMiYSuau
X-Received: by 2002:a17:90b:1b43:b0:2a0:36b6:9683 with SMTP id nv3-20020a17090b1b4300b002a036b69683mr1322857pjb.29.1711682661948;
        Thu, 28 Mar 2024 20:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+EvkvcfjaydeOwYaJW0lwSV7DoBI7aD9GVFLZOcLfK1KCyjQkCEEzGIG4MJUVNxirLFIe6Rq90gxcw8WLRbw=
X-Received: by 2002:a17:90b:1b43:b0:2a0:36b6:9683 with SMTP id
 nv3-20020a17090b1b4300b002a036b69683mr1322849pjb.29.1711682661687; Thu, 28
 Mar 2024 20:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-3-xuanzhuo@linux.alibaba.com> <CACGkMEsG7+mNx4WqhAuhrpk1bhLEwrTzngT5q=CZ_aHkzRasVg@mail.gmail.com>
 <1711610846.0120149-1-xuanzhuo@linux.alibaba.com> <CACGkMEstpEfrnsuLwE2AaceXDzE97kOCu9ukMAeX0O80k9xTUw@mail.gmail.com>
 <1711613734.5560663-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711613734.5560663-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 11:24:10 +0800
Message-ID: <CACGkMEu894Fie1jvFfrfO2KvmKjdDvNBKE+EBELawacAiwPKfw@mail.gmail.com>
Subject: Re: [PATCH vhost v6 02/10] virtio_ring: packed: remove double check
 of the unmap ops
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:16=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 28 Mar 2024 16:07:14 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Mar 28, 2024 at 3:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 28 Mar 2024 14:56:47 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > In the functions vring_unmap_extra_packed and vring_unmap_desc_pa=
cked,
> > > > > multiple checks are made whether unmap is performed and whether i=
t is
> > > > > INDIRECT.
> > > > >
> > > > > These two functions are usually called in a loop, and we should p=
ut the
> > > > > check outside the loop.
> > > > >
> > > > > And we unmap the descs with VRING_DESC_F_INDIRECT on the same pat=
h with
> > > > > other descs, that make the thing more complex. If we distinguish =
the
> > > > > descs with VRING_DESC_F_INDIRECT before unmap, thing will be clea=
rer.
> > > > >
> > > > > For desc with VRING_DESC_F_INDIRECT flag:
> > > > > 1. only one desc of the desc table is used, we do not need the lo=
op
> > > > >     Theoretically, indirect descriptors could be chained.
> > > > >     But now, that is not supported by "add", so we ignore this ca=
se.
> > > > > 2. the called unmap api is difference from the other desc
> > > > > 3. the vq->premapped is not needed to check
> > > > > 4. the vq->indirect is not needed to check
> > > > > 5. the state->indir_desc must not be null
> > > >
> > > > It doesn't explain the connection to the goal of this series. If it=
's
> > > > not a must I'd suggest moving it to a separate patch.
> > >
> > >
> > > The "no store dma ..." depends this.
> > >
> > > I will add this message in next version.
> > >
> > >
> > > >
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >
> > > > Rethink this, it looks to me it would complicate the codes furtherl=
y.
> > > >
> > > > For example, vring_map_xxx() helpers will check premappred and
> > > > use_dma_api by itself. But in the case of vring_unmap() you want to
> > > > move those checks to the caller. This will result in tricky codes t=
hat
> > > > are hard to understand.
> > > >
> > > > We need to be consistent here.
> > > >
> > > > If we try to optimize unmap we need to optimize map as well. But
> > > > generally it would complicate the logic of the caller if we want to
> > > > let the caller to differ. Ideally, the caller of those function sho=
uld
> > > > know nothing about use_dma_api, premapped and other.
> > >
> > >
> > > The key is that we can check "use_dma_api, premapped" to skip the loo=
p.
> > > If the vring_unmap_xxx is called, the "use_dma_api, premapped" is che=
cked in
> > > advance, so that is a waste to check thest again.
> >
> > Right, but we have the same logic for map.
>
> But we can not skip the loop for map.

Ok, right. So I'm fine to leave it as is. We can optimize the checking
on top anyhow.

Thanks


