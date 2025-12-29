Return-Path: <netdev+bounces-246207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D3CCE5C48
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 03:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 501FC3007EF9
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 02:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986391E0B86;
	Mon, 29 Dec 2025 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNu0TqGd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXP2jp1p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A66B26B95B
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977046; cv=none; b=Xb0gizKkrz7MZRMOWCR0/CeAkJw0ceWgE5vW2/WC+z2V3Zm7aT4MphKQvDsvzxn/NY62fhAJuuREn7LTfnx+R2D0iN8BCwySsO1vaO+wRPg3EfusZ4cZYJ1f5IpYgY87nl9ukrsx8RphdCo99Ep2XkTvw/+Goertfl+AAH2jbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977046; c=relaxed/simple;
	bh=q8CggmDtPqjoKatzN9cmV7rMGBsJUMVlA1VHmEyJLpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCMebJDeKPW0zdIhsa97ULg6n5hhClQ/l/AgBiW9tSZKWxKo6HNsHTOUYaDVyXZ5ujquG6cRsgZlnrj1d18tHk7JX/hpEzRicPsWRjTevJ/y/1z33TX94pyWlgtu/nGiz9fgVwsvTSac0SmGNcBtJoLHg2zsbsxga81/TSBqK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNu0TqGd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXP2jp1p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766977043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeUpiAunVEWdA7rpWmyfKsCIf9QyNTsBMy3xWSGdlCE=;
	b=QNu0TqGdGFae6egsXEzsRA7Z840B1PhLy2NyQ4ZqWynNrV6iy5ZJb1WO8pTlUH324uaHFX
	7WRe8Wtwf2oF2C7/mfKP+47hlNkEr7FyQxYPsCMEyDAr3DZuxp2Z739nsdW2PkuTS1L9VS
	a2OIS7dJ/su94Su/FuFRp47Ey97SU7A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-0ROFTE22NMG_q-YGj9C-Og-1; Sun, 28 Dec 2025 21:57:22 -0500
X-MC-Unique: 0ROFTE22NMG_q-YGj9C-Og-1
X-Mimecast-MFC-AGG-ID: 0ROFTE22NMG_q-YGj9C-Og_1766977041
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c2f670a06so11302116a91.3
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 18:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766977041; x=1767581841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeUpiAunVEWdA7rpWmyfKsCIf9QyNTsBMy3xWSGdlCE=;
        b=ZXP2jp1pvsBPRfAU46b5Ng3gbGEIpzv6UYyKrSZcQAS5fyYOhv1ZCQ1bQRNY/P93fb
         eaAg8m/XSKKRZTj0k09J3Yu4j/NE4csb38RM4qcFCJ3cklaGwEv0KpdHAhFeGcKbqWI2
         JGXHsWsaq8M6i6lRE5PfHrvA3rC54oUYMHGogfYqtTGgNkLUGNkDSiy6U8YUG1+Yuf/1
         rkUUe3qxCeUXddVrlpeGtPC26Fao27rVY56zupSSCIEQyD/3mWtmfBGssr1r3gwK8IBi
         86nRf0bPQs893Du4ROqGMD0p4RoQWHrnTnCL2o7IaRfkBKzUOlzAzrQQRfrHSN8lQ+qa
         f20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766977041; x=1767581841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SeUpiAunVEWdA7rpWmyfKsCIf9QyNTsBMy3xWSGdlCE=;
        b=I8BxXAez0+iCY67xecUV3MR3T4SevqFx5Az2YcmqMCtATDPIns2BDllfE3NFpUb30N
         NcWH1g51ZI8o8K2sisM5az7s2fej8xfNs1DffdsA/8B88ZOT0ngc2En33KluLHYyfHKz
         mziIQYqupFsvCTgAjgEkq4WZXzmQ0fC4U2jCyCOwcclHgz4gqfuc7Mh+jdAZkojVmO9J
         PJofcfQ5hAKv+dAgi7JlbODIrWv32YfN0Mr7CMA2pNVcI7CLq0bXvAz0xCVLTYbTe2iK
         sIXqVEnxggVc7lZemSIw2VYf4b3NTfERBvqVlHyweHdN3L1rzejxxnatGdkqY+wcuBfA
         6lPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/RCUcQcpYS8S4ToUczIIlbteSSi88SHxFzdzdmBz0u45LvGz1tGv4tlpTucvlb/V98+wC34I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR04P6S/jfbkNjN/joEzSaMkJcmeOXaiAJmHYNX4DitullqCUE
	uqsoBTcG+pL/H5aGeXchwVBVDehMUEWxqoAZ6koHrm7IBKqA5+5mr1ERIgfOoX4dUtxbDiUUl5T
	DtS/n5ApVv2OxNJmTT/bcEyR7eUP3w8Z5tKScSLUVs5bF0oDN3cVMWGAuzPZmaXv+hg2kGSnucv
	hawrv35wF3b0vRnBRnzYIAPcFZuGe+ZPGm
X-Gm-Gg: AY/fxX4aRf0rDFrWKR23XdwmDN+6VRMhXbvSlofpU5XG9D5D630n9otydd001v+kVjj
	Q7A2VKuRbYD/B14cte322+pFkCK4yUeBUUwNrxzBCkX63wmy3FgX1BLWwKm0HxaF3VcKJuH/7Ni
	iBKlfJfMLh4fcyp3jbsRVERtW7WPInJn8RXxeQ7X8sSa8GeFuCdH9wy6Clbx9B/TnNwSI=
X-Received: by 2002:a17:90b:1f89:b0:340:6f07:fefa with SMTP id 98e67ed59e1d1-34e921af98amr26506151a91.20.1766977041126;
        Sun, 28 Dec 2025 18:57:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuFAQz5dl9OQ+OpMMXHah5Q6sBaKFfxj69JA6+1zJKrKUTujcPZF1v21aCgnbYDU1uoDCbceCpOFXb6k6AIFc=
X-Received: by 2002:a17:90b:1f89:b0:340:6f07:fefa with SMTP id
 98e67ed59e1d1-34e921af98amr26506133a91.20.1766977040697; Sun, 28 Dec 2025
 18:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com> <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com> <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org> <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
 <20251226022727-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251226022727-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Dec 2025 10:57:09 +0800
X-Gm-Features: AQt7F2pWXGO_bQQYrt8LO7PYTQ5B-41fYUS9oX18KEq5NxP7LasitQAJREo0FmA
Message-ID: <CACGkMEuTfKQCHqJFgtG1-HBn--fdGSKdPqF_=p078WbiGN=J=w@mail.gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Bui Quang Minh <minhquangbui99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 3:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
> > On Fri, Dec 26, 2025 at 12:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > > > On Wed, Dec 24, 2025 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > > >
> > > > > > Hi Jason,
> > > > > >
> > > > > > I'm wondering why we even need this refill work. Why not simply=
 let NAPI retry
> > > > > > the refill on its next run if the refill fails? That would seem=
 much simpler.
> > > > > > This refill work complicates maintenance and often introduces a=
 lot of
> > > > > > concurrency issues and races.
> > > > > >
> > > > > > Thanks.
> > > > >
> > > > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > > >
> > > > > And if GFP_ATOMIC failed, aggressively retrying might not be a gr=
eat idea.
> > > >
> > > > Btw, I see some drivers are doing things as Xuan said. E.g
> > > > mlx5e_napi_poll() did:
> > > >
> > > > busy |=3D INDIRECT_CALL_2(rq->post_wqes,
> > > >                                 mlx5e_post_rx_mpwqes,
> > > >                                 mlx5e_post_rx_wqes,
> > > >
> > > > ...
> > > >
> > > > if (busy) {
> > > >          if (likely(mlx5e_channel_no_affinity_change(c))) {
> > > >                 work_done =3D budget;
> > > >                 goto out;
> > > > ...
> > >
> > >
> > > is busy a GFP_ATOMIC allocation failure?
> >
> > Yes, and I think the logic here is to fallback to ksoftirqd if the
> > allocation fails too much.
> >
> > Thanks
>
>
> True. I just don't know if this works better or worse than the
> current design, but it is certainly simpler and we never actually
> worried about the performance of the current one.
>
>
> So you know, let's roll with this approach.
>
> I do however ask that some testing is done on the patch forcing these OOM
> situations just to see if we are missing something obvious.
>
>
> the beauty is the patch can be very small:
> 1. patch 1 do not schedule refill ever, just retrigger napi
> 2. remove all the now dead code
>
> this way patch 1 will be small and backportable to stable.

I fully agree here.

Thanks


