Return-Path: <netdev+bounces-194107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5BBAC75C1
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 04:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23323188EEDB
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5E1A83F9;
	Thu, 29 May 2025 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHw01IcK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AD26AEC
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484961; cv=none; b=XPkaakhMDTNKoIom4/+HIeXLNUnd4DUb9XDess80uYVdRAEQGIJ+GFSUom63m6mNqV+EN1Fjh0xYZNOKSykPQqP0FkbdHsCAUq0e8tgtQPJ8MZlwvB+HuR2nnGAjLYPP5ezTF4SyHGybGr+/ZbaZtoMH/oWEMRS8UeVwoAiVMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484961; c=relaxed/simple;
	bh=2gx0ydvNNPPYWmu0SpdmnMKXaH/eAqRQEtpGwbSuVjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzUlsPIP7EPdb5gjBlV44e+2+eSUJOsDl+AKd94LgRarshfUWoJsw3SmwZI9RfdoHl2s0S60XQQK7/kVWOGrs8OVZ+ffE5RSMc0+/MUbIfRYNZtgC6u/AWOxP8QfpDJz4eaoyOAQvhNAgaQHyO7dBPtS85ANSvKvu0uRmK13f5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHw01IcK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748484958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJVlOuSEzIfFfy62kQJHxuDO1FI1ZqJPlOuISiedEqE=;
	b=SHw01IcKxfDrXJVkisXEFtB8N/C9zcAKPdOgfnL0Y3kOr3oLt2dMXSMlS+pzrhhgWX5oyb
	qvm8bh3mgohOwREqDnIAbYPtzYtnnGkYtJ/2yltVLkDNp3huATRuItfYDJGGCCfGMJnN5Y
	xAR2KO2GVmg/vixdIWLka8eb/jqUdRE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-n8TVQQskMPWZ0wYMtOGadw-1; Wed, 28 May 2025 22:15:57 -0400
X-MC-Unique: n8TVQQskMPWZ0wYMtOGadw-1
X-Mimecast-MFC-AGG-ID: n8TVQQskMPWZ0wYMtOGadw_1748484956
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30a59538b17so327122a91.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 19:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748484956; x=1749089756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJVlOuSEzIfFfy62kQJHxuDO1FI1ZqJPlOuISiedEqE=;
        b=ntUCHIRyWF1o/DeYYXlq1JOuPZOdDxSYDUTJu3/4n4HSQzqzhbrpaCDHGX9pt3qFHx
         6X1J+0lKFQVvRHmuilv2nj7zUAu/QNbJpAHPQREJJwSdc7pUwnhncHuTtAPVptGSGESk
         FFiJsucwwNE0EbWLGQQSElTlWMaabBIEDlFmNQh4wF3Q11YhRoNKQy3I/4PTtCrfWSAR
         CAQCgghK6lRhy9hsvYImLYzqC2GCRMXgj9jve6nAekoYF2BBZRI4GqewqfDB8TYwalZK
         wfdLlzQpRIAfRYpIj5wMP8xMw1AwxTvHgRETiTPL/wvkI93CbQXnUhLpl1CPWxKTBI57
         0ZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4CRqIld6QdrSboq6aMHQoeEtTJPQMqkzFVZJU6yE3m4ryU7Mi3SP1AMpPO5f+OXYYD0me4y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMS3qyYPY3WuUoEyR44iozBwWkK5Z9zGo+qMzjKP4OTr6u6NP
	Osf+QaGFFJcrty/f9XWvcGEJ6J34ZpWcL/G3DBEsEsdx9H0XDDsPSlZpceumvWqgbzRagIJvzKC
	R0yLhcycdeRSt9/tOxGqu9KVVA0StEuE2DgpbN4WBaqqpdDvIHJv5HCVTvwMjSf4egBnw4z+mWq
	gUySdfS5qear2o5L0a2IOEouSWPZxv38+N
X-Gm-Gg: ASbGncsuYsOM0y7hELspm4pN5Bksjf1YapnM2Ms0FMp2N2rmEBu5ciKCaI9W/DI4fQl
	YWs4VzZ1tjW5u6sHih9syXLeMDrpxnuG/ytuOrJ7YEJdMnS1GpGP330ndl4EhjCmBg0f99w==
X-Received: by 2002:a17:90b:3dc5:b0:30e:77bf:6139 with SMTP id 98e67ed59e1d1-311e73d929dmr6538459a91.5.1748484955990;
        Wed, 28 May 2025 19:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDDEiS/CV5CbTJuEZbDlb0sD7NA2cv6EL8ndem95byk8dhBZKzElV4KXEAXyiIWW9AXNpDPY3D6IjqBfyef/M=
X-Received: by 2002:a17:90b:3dc5:b0:30e:77bf:6139 with SMTP id
 98e67ed59e1d1-311e73d929dmr6538425a91.5.1748484955564; Wed, 28 May 2025
 19:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
 <CACGkMEtGRK-DmonOfqLodYVqYhUHyEZfrpsZcp=qH7GMCTDuQg@mail.gmail.com>
 <2119d432-5547-4e0b-b7fc-42af90ec6b7a@redhat.com> <CACGkMEsHn7q8BvfkaiknQTW9=WONLC_eB9DV0bcqL=oLa62Dxg@mail.gmail.com>
 <3ae72579-7259-49ba-af37-a2eaba719e7e@redhat.com> <20250528115015-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250528115015-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 May 2025 10:15:43 +0800
X-Gm-Features: AX0GCFuVN6-eUvToQsHW20XcOBqpBbyooXU_p3CwpRuPuRfZExjWFlC44l0K1ak
Message-ID: <CACGkMEtgb=6kDfY-coiXz2+0k8azW_SgZ_EBUbRyKEvDfjoUNQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, May 28, 2025 at 05:47:53PM +0200, Paolo Abeni wrote:
> > On 5/27/25 5:51 AM, Jason Wang wrote:
> > > On Mon, May 26, 2025 at 3:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > >> On 5/26/25 2:43 AM, Jason Wang wrote:
> > >>> On Wed, May 21, 2025 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.=
com> wrote:
> > >>>> diff --git a/include/linux/virtio_features.h b/include/linux/virti=
o_features.h
> > >>>> new file mode 100644
> > >>>> index 0000000000000..2f742eeb45a29
> > >>>> --- /dev/null
> > >>>> +++ b/include/linux/virtio_features.h
> > >>>> @@ -0,0 +1,23 @@
> > >>>> +/* SPDX-License-Identifier: GPL-2.0 */
> > >>>> +#ifndef _LINUX_VIRTIO_FEATURES_H
> > >>>> +#define _LINUX_VIRTIO_FEATURES_H
> > >>>> +
> > >>>> +#include <linux/bits.h>
> > >>>> +
> > >>>> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
> > >>>> +#define VIRTIO_HAS_EXTENDED_FEATURES
> > >>>> +#define VIRTIO_FEATURES_MAX    128
> > >>>> +#define VIRTIO_FEATURES_WORDS  4
> > >>>> +#define VIRTIO_BIT(b)          _BIT128(b)
> > >>>> +
> > >>>> +typedef __uint128_t            virtio_features_t;
> > >>>
> > >>> Consider:
> > >>>
> > >>> 1) need the trick for arch that doesn't support 128bit
> > >>> 2) some transport (e.g PCI) allows much more than just 128 bit feat=
ures
> > >>>
> > >>>  I wonder if it's better to just use arrays here.
> > >>
> > >> I considered that, it has been discussed both on the virtio ML and
> > >> privatelly, and I tried a resonable attempt with such implementation=
.
> > >>
> > >> The diffstat would be horrible, touching a lot of the virtio/vhost c=
ode.
> > >
> > > Let's start with the driver. For example, driver had already used
> > > array for features:
> > >
> > >         const unsigned int *feature_table;
> > >         unsigned int feature_table_size;
> > >
> > > For vhost, we need new ioctls anyhow:
> > >
> > > /* Features bitmask for forward compatibility.  Transport bits are us=
ed for
> > >  * vhost specific features. */
> > > #define VHOST_GET_FEATURES      _IOR(VHOST_VIRTIO, 0x00, __u64)
> > > #define VHOST_SET_FEATURES      _IOW(VHOST_VIRTIO, 0x00, __u64)
> > >
> > > As we can't change uAPI for existing ioctls.
> > >
> > >> Such approach will block any progress for a long time (more likely
> > >> forever, since I will not have the capacity to complete it).
> > >>
> > >
> > > Well, could we at least start from using u64[2] for virtio_features_t=
?
> > >
> > >> Also the benefit are AFAICS marginal, as 32 bits platform with huge
> > >> virtualization deployments on top of it (that could benefit from GSO
> > >> over UDP tunnel) are IMHO unlikely,
> > >
> > > I think it's better to not have those architecture specific assumptio=
ns since:
> > >
> > > 1) need to prove the assumption is correct or
> > > 2) we may also create blockers for 64 bit archs that don't support
> > > ARCH_SUPPORTS_INT128.
> > >
> > >> and transport features space
> > >> exhaustion is AFAIK far from being reached (also thanks to reserved
> > >> features availables).
> > >
> > > I wouldn't be worried if a straightforward switch to int128 worked,
> > > but it looks like that is not the case:
> > >
> > > 1) ARCH_SUPPORTS_INT128 dependency
> > > 2) new uAPI
> > > 3) we might want a new virtio config ops as well as most of transport
> > > can only return 64 bit now
> > >>
> > >> TL;DR: if you consider a generic implementation for an arbitrary wid=
e
> > >> features space blocking, please LMK, because any other consideration
> > >> would be likely irrelevant otherwise.
> >
> > I read your comments above as the only way forward is abandoning the
> > uint128_t usage. Could you please confirm that?
> >
> > Side note: new uAPI will be required by every implementation of
> > feature-space extension, as the current ones are 64-bits bound.
> >
> > Thanks,
> >
> > Paolo
>
>
> Jason, I think what Paolo's doing is a step in the right direction, we
> can do this, then gradually transfer all drivers, devices and transports
> to use virtio_features_t, then make virtio_features_t an array if we want=
.
>
> If instead you jump to an array straight away, it's a huge change that
> can not be split up cleanly.

Ok, consider we're moving forward to arrays. I'm fine.

Thanks

>
>
> --
> MST
>


