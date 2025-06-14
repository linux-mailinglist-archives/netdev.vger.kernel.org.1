Return-Path: <netdev+bounces-197753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F14EAD9C15
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 12:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B6B3AE848
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E201A01B9;
	Sat, 14 Jun 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZViLs5x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928916F841
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749896519; cv=none; b=M9LY9uHxANZuxr1bNpVwFu5L5/FQ3Pemg1puqlgtRSe8GaiaOKEVaZKKSQ+Kr8S2B/Sh/BONFCWmb78jZPDlz//VNfh/m8IIo6RFt/8Fi9XmxDRevlfm9w8wJlo3vew+3mhspCHjBhMvOkDF1ejq4zpL5y49yTkuA9nWO3TE1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749896519; c=relaxed/simple;
	bh=FtNy7STuv9GtELdi+n2fuP2s8khETAknE9arw1EHBkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0d78sLt/MFuk1ubzrAJuvP/VuNVuSxwIKLbmkbxUhdc3sYaEIoVTfs7NGHuUVzqQtnIx9ameU/2cdFJMmxxaJBDCwJlaFDPAjPZ5eDO1UBKPib62vBORv1VV3SWXn4hU4v0iGUXu0endqfvX4xLbyq2Q6PbNGla64B2BCMEHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZViLs5x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749896516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UafiXuMqi4LdfGj4sc+D7nsu7kRmyiXaHQorT8Cfz14=;
	b=iZViLs5xkvesftM8FFmiH8AHfWzxtKCFpD11TJr1CDSAkF8oBlge/pCYq46kBRA/vBFqLp
	aSfQG7oVeKXIzCL2CNIWLJNtW6uZaMtAAJji+ciwhqac9srFh3+R90p6xpEhLHHr5j+DG+
	xENHkSXDOybFD7uf/A80Mqq/vmJftxk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-0jQ1aLS_OfKVocY6QeOupQ-1; Sat, 14 Jun 2025 06:21:54 -0400
X-MC-Unique: 0jQ1aLS_OfKVocY6QeOupQ-1
X-Mimecast-MFC-AGG-ID: 0jQ1aLS_OfKVocY6QeOupQ_1749896514
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7111d608131so42903997b3.1
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 03:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749896514; x=1750501314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UafiXuMqi4LdfGj4sc+D7nsu7kRmyiXaHQorT8Cfz14=;
        b=n/tvdzMwKGibPuxy2djqryNflBYuACa2xApllp5xOSEmt7phBclNVjq/vF9uioH3W2
         fvEIhv9kTXaI9dhIQ6kVyhFvOkZisONzqNHmYWiZuB+OrJ1jPs/ntBjVvMijK/SxNi4A
         YvEWt/0NoyA3Fsgnu/bN4D5Ng1cZBjd4py+C8/4K0ieNRu6WXufR3xDM6l1FJM9zOJiO
         kkQb9FXNMmN4TnsqgnM4RN8Nj7uBOXsFKF0z5OZ7ZnHstTb7O0cZXLOH7/VpAORCH7Bq
         XSouK7l5//H/Tjk2WB5rU94ulekXraueFvV9Z67s5N15V6zRzo3y8/TSKSNnok3bUwcM
         khjQ==
X-Gm-Message-State: AOJu0YxOPTnndd+UFymxJCkbEu2ecPjMzA5j4h2ivx5B9Jo+nlkLcsF1
	+xOkU0LN+VTvPLGRdQ1Bq+EaLX/sRlipZwgdToJ56KzdM9U4NpYBdjpdfek5HWn8d9wgFdXCQ2v
	p1HrICZ9yAvORUpdYkEsoh2LODm+OAgH/e69CI17vnAG3VYVjT8ERw9NQJQqWiwQj9icy34qTHi
	YAaFsQyxAK8JH1URvXPqYHKRos/GHsHTLk
X-Gm-Gg: ASbGnctlO+J2ffc0ull9LojG+LRRzE62MGhlp0c3/cHJ/k93fwDukycfer7gGo/vh9F
	eHYnBqjl8Vy1jxDIKZpqfk4R9AbLq00/8zJEBEjIoCSMJaFNa1BPdfnAQJX70BfN7ygkdZ2O+N1
	JADVw=
X-Received: by 2002:a05:690c:6f91:b0:70f:84c8:311a with SMTP id 00721157ae682-7117537b4d0mr32036877b3.5.1749896514215;
        Sat, 14 Jun 2025 03:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsDio91UnA2Ova7tInCmKQ4BSCk38Pqzj/ai2/tPIxdj25CZvTMa1s7cKkJYaV6+/1IyNpviVdCRll9qlMots=
X-Received: by 2002:a05:690c:6f91:b0:70f:84c8:311a with SMTP id
 00721157ae682-7117537b4d0mr32036637b3.5.1749896513872; Sat, 14 Jun 2025
 03:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
 <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com> <b7099b02-f0d4-492c-a15b-2a93a097d3f5@redhat.com>
In-Reply-To: <b7099b02-f0d4-492c-a15b-2a93a097d3f5@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Sat, 14 Jun 2025 12:21:42 +0200
X-Gm-Features: AX0GCFsKmXxLyWjTg10wGCqtgMIVSqr3wy_FKKadD4Q_peMisig0qvJsYw2Xq60
Message-ID: <CAF6piCLcGbjjgmx_0O374giv3Yvc+qo_km2YLqyHrhsYcphGJQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/8] tun: enable gso over UDP tunnel support.
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 1:03=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> On 6/12/25 6:55 AM, Jason Wang wrote:
> > On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >> @@ -1720,8 +1732,16 @@ static ssize_t tun_get_user(struct tun_struct *=
tun, struct tun_file *tfile,
> >>
> >>         if (tun->flags & IFF_VNET_HDR) {
> >>                 int vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> >> +               int parsed_size;
> >>
> >> -               hdr_len =3D tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, =
from, &gso);
> >> +               if (vnet_hdr_sz < TUN_VNET_TNL_SIZE) {
> >
> > I still don't understand why we need to duplicate netdev features in
> > flags, and it seems to introduce unnecessary complexities. Can we
> > simply check dev->features instead?
> >
> > I think I've asked before, for example, we don't duplicate gso and
> > csum for non tunnel packets.

[...]

> Still the additional complexity is ~5 lines and makes all the needed
> information available on a single int, which is quite nice performance
> wise. Do you have strong feeling against it?

I forgot to mention a couple of relevant points: the tun_vnet_*
helpers are used also by tap devices, so we can't pass the tun struct
as an argument, and we will need to add a new argument to pass the
dev->features or dev pointer, which is IMHO not nice. Also we should
provide backward compatible variants for all the helpers to avoid
touching the tap driver. Overall using the 'dev->features' will
require a comparable code churn, likely even greater.

For plain GSO offload, currently the code validation is quite liberal
and doesn't check the actual offloaded features. We  can't change the
existing behaviour for backward compatibility, but we want to be more
conservative with the new code, when possible - so we want the
information available to the helpers.

/P


