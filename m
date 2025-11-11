Return-Path: <netdev+bounces-237390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B973C49E64
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B5CF4EF679
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8301F4CBF;
	Tue, 11 Nov 2025 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBxYEY5n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0B3RPjE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DFB288D2
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821952; cv=none; b=rm5A69JaNAdgcsxKrghPD7G2fAyjbCSGStO2zLsFFonkSqWYAHjfDWm1TIJawbuKBZcTDLLrl+iP9n5+5Vb3QaZh2d/ZJ/N9c1WwJeC7j5+hH5tXvvsKMbU8QQgGsffoaNkGk4I0HQ4OobDWRJtUxw+YkW/AXjwhEeAvf4VakDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821952; c=relaxed/simple;
	bh=dVuPMCslW28VmgSKRsWmna3DfC5pd3VD4foVAKXsE60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZPkVOYNsi1taiOGSJzU0MBQ6EO7Ky0alpuklFoE2Wm9bwH/QvtoFZ9FMzBAj6ZV4iVqWbXdqmO9tRG3UskD1XJnXZsrGLvUq5XQfnY+bEGcRZfzpyHsG1CAYtNC25tDd0AnyqmfC0cUmImFbUqPqmhRICYILtQENwYNkED3DwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBxYEY5n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0B3RPjE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762821949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVuPMCslW28VmgSKRsWmna3DfC5pd3VD4foVAKXsE60=;
	b=QBxYEY5nkpzJf8y5wFn9jSA8+M0EqBll7d5dO5rvMwqr44mjhHjm1BV0VpvWIwYkvACTaR
	2PNKZ0Jcr0z9mQdC1DBF7xRh8mKApEvJeUf8YFAeDsVTKilg6/pPAzUdhqZ76oy/J7F4V1
	kIaCfJ6Kzz5cIiHsQlMOu6hkK7Ec+ZM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-RD5Vg7DbMmmYUrhQKcOOew-1; Mon, 10 Nov 2025 19:45:48 -0500
X-MC-Unique: RD5Vg7DbMmmYUrhQKcOOew-1
X-Mimecast-MFC-AGG-ID: RD5Vg7DbMmmYUrhQKcOOew_1762821946
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3439fe6229aso440082a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762821946; x=1763426746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVuPMCslW28VmgSKRsWmna3DfC5pd3VD4foVAKXsE60=;
        b=i0B3RPjEfrXLh3iuYAOfne1jkjE8s9zDwfXy2cgD8m2x3KmBn6h/vxonrgBTQx2Nr8
         T4lTiR+HWY/hg6yGXgjeAiTnzoIVMFWX8HQ+yGO0kbsMVhNC7Pd+V9gJF3jiehbZ3+dj
         HJiYxy3lF6Kklfl54SMLqQnseAHVWrCocRZW+fW8aeKG+VmNa6I2I3Ouz41fc0waSx9t
         0CFH9+sTEPLUghLIoBNuAq16PysaYHqglBfUl/fpIFkyfQ6y/17cNVprw90oVRuo9GCi
         6zp3w/5psb0HHq516cP+XpHDSjoP6FoDe/G0+882x1uOlRk3JxfVVcwaU3p4LR1ivmif
         hY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762821946; x=1763426746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dVuPMCslW28VmgSKRsWmna3DfC5pd3VD4foVAKXsE60=;
        b=DtUtcvV0N1OvaWAdm70qxTKBxf7DnElTVt5qVxQSr3e+XmsrC3G160bQys4c8Vnuzz
         XIjM++hu+GtDb5eceOJmkLCTb+vW6xu6eS0+wGws/4p+T3xajqZvZBo1YdHqcsVNxYmu
         wzQvyqpLqR7jDq5ksiBgXvBrk6i2iEdRNfxHp1fYbcGBS1VANsBvz6IuT0rFsow+5fhV
         jVX+YBdmHzoowhWucH6V6JWHIwW64Ts7iSXLpXwfROCD4uYhKmxobtplZJIQxGEe4jgl
         peFY80XbxGGGkzQzQcfTblZ5p6Y7A6OehTIKEW/CV88Rlq+rPvbrXq62jSnD/iMu7w4Y
         eQag==
X-Forwarded-Encrypted: i=1; AJvYcCVgl+M0gCAXpSNaSWXVuEhIe9gX3dvRSpw/pafGDxvS2PjEVfuBGEmWb0/Cm0yyBhoAIt/WIns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsEOBj2qhphvT/cwFFUaWnN8FXUClIfKugrbFX5DJR9LeBAkg+
	PXN6B5LpFRjAqnWZdDt0NmPE87yX3sfF2hLQZrykwl5cKYVU7eK/2HxFVA7ovs+wIFMGaLYDRNZ
	5CBtmdvMIDrTWdcu21d1r6IxRCYJuwSIHw1qQfdbf2hUqDjBx4E1Pxh9acSrSZSr4eZIEPUt4e7
	ISL2GVDUCtAFPdE/0Q3FpiSmh1HpzQMDtY
X-Gm-Gg: ASbGnctvd5ius0gEiHlvVQRWMmKo59Nh2HS1nNbbdRE3v4qhEGVNvtmJCy4YI2D+5y1
	6JPPa8eI7XIeH3CnHBWwLXogClZicOT1wj7F8Cm1QqnuuL5tQqUxPbOWBpGGe8Iao3eBEUe5wp1
	D4hyCUQktlVOqFQv/iAiy7YcCXpsNmZICcOU/ztCAI9kONkKfPSEZb
X-Received: by 2002:a17:90b:3943:b0:343:78ed:8d19 with SMTP id 98e67ed59e1d1-343bf0bd417mr1695413a91.7.1762821946111;
        Mon, 10 Nov 2025 16:45:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQUmvPvGXxjrfxDrSY5BguI5eT/+blkmNjZR3Gj94t1Sfp7uvokh13xuEGRkj1wZchbTW3URKIPgxezklb2Po=
X-Received: by 2002:a17:90b:3943:b0:343:78ed:8d19 with SMTP id
 98e67ed59e1d1-343bf0bd417mr1695376a91.7.1762821945678; Mon, 10 Nov 2025
 16:45:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com> <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org> <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
 <20251110022550-mutt-send-email-mst@kernel.org> <CACGkMEt+czNGi_KFgnHkZteNVNmBc7ND_xh7R=uNDo-ZumFEfA@mail.gmail.com>
 <20251110110751-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251110110751-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Nov 2025 08:45:34 +0800
X-Gm-Features: AWmQ_blZvE7rBc4Z9MGidBidk5AJhCi--F0DfIvPMWElMJxReUbIA_Y-Jurf-ZU
Message-ID: <CACGkMEs9qwGfnmTR2zCS09QZpKG5OnpCJ19BUtL6AkAW3L-9eg@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:10=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Nov 10, 2025 at 03:39:50PM +0800, Jason Wang wrote:
> > On Mon, Nov 10, 2025 at 3:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Nov 10, 2025 at 03:16:08PM +0800, Jason Wang wrote:
> > > > On Mon, Nov 10, 2025 at 5:41=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > > > > > On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@li=
nux.alibaba.com> wrote:
> > > > > > >
> > > > > > > The commit be50da3e9d4a ("net: virtio_net: implement exact he=
ader length
> > > > > > > guest feature") introduces support for the VIRTIO_NET_F_GUEST=
_HDRLEN
> > > > > > > feature in virtio-net.
> > > > > > >
> > > > > > > This feature requires virtio-net to set hdr_len to the actual=
 header
> > > > > > > length of the packet when transmitting, the number of
> > > > > > > bytes from the start of the packet to the beginning of the
> > > > > > > transport-layer payload.
> > > > > > >
> > > > > > > However, in practice, hdr_len was being set using skb_headlen=
(skb),
> > > > > > > which is clearly incorrect. This commit fixes that issue.
> > > > > >
> > > > > > I still think it would be more safe to check the feature
> > > > >
> > > > > which feature VIRTIO_NET_F_GUEST_HDRLEN ?
> > > > >
> > > >
> > > > Yes.
> > > >
> > > > Thanks
> > >
> > > Seems more conservative for sure, though an extra mode to maintain is=
n't
> > > great. Hmm?
> >
> > Considering it's not a lot of code, it might be worth it to reduce the =
risk.
> >
> > But I'm fine if you think we can go with this patch.
> >
> > Thanks
>
> hard to say what does "not a lot of code" mean here.
> but generally if VIRTIO_NET_F_GUEST_HDRLEN is not set
> just doing a quick skb_headlen and not poking at
> the transport things sounds like a win.

Yes, this is exactly what I meant.

>
> I'd like to at least see the patch along the lines you propose,
> and we will judge if it's too much mess to support.

+1.

Thanks

>
>
> > >
> > > --
> > > MST
> > >
>


