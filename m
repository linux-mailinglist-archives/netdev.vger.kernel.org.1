Return-Path: <netdev+bounces-246074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0FCDE324
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 02:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B76AF3002066
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 01:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E361D5160;
	Fri, 26 Dec 2025 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yni7qfB7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3jn9EfH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9219D093
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766712706; cv=none; b=fEvTYKUY1srzapR5ZR2spicAKv7jftXzSU/Zdd1l2Z1oRE+vDOJFZZu0Yy1L3rCP7zf3Kk33q3+j76CEZpb7E4d0fejBqzuqlPyoSPkb4cT1R6UVd5vT416pN9Q+DN/hK8T1BfmBMrsTYlzmjC9mhtPOtgFRSnRnm/5Na4kCulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766712706; c=relaxed/simple;
	bh=EEJ0crxTC9rZ7Z/JWyJ1blAZ+MavApQb1iFxiRM/QeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOifDMPnKvysBO6VmItRssT3k6JVwt4MnkLP+1WdyA54H+uB/bu7WZIhYs9h4J9/vDxDybBGeK1FAVvQxMzXql6rPNCCoKD1nB6dNnHHv73vhq0RNZO/vQoaCAUmxlVxP6+V3KDh1MOm45V8jAwYWsIYhe0P5quPXAuM0b6uHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yni7qfB7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3jn9EfH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766712701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6vEHwSPLbMYTon6GIevS+ZEJhvcN0whZXuCpRgpcdQ=;
	b=Yni7qfB7m9OA3MXAhQYUDHf1O0/ax45Bd0cmOZpqoqrFYQbUIoV6l89HcPjwldAjU2qO4u
	Rf4qIiCb/nBa7QxEqBdz07AVdfyLBMtjKKK/Fi2jbBom5HqmvvZR40i1ndsb7vJS3QGdSq
	v2uE11ZBH3vyQ7mathg9Z86ZiNvdMWg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-8WNiTkMZMz6Eoov4kbhi6Q-1; Thu, 25 Dec 2025 20:31:39 -0500
X-MC-Unique: 8WNiTkMZMz6Eoov4kbhi6Q-1
X-Mimecast-MFC-AGG-ID: 8WNiTkMZMz6Eoov4kbhi6Q_1766712698
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34ab459c051so17513973a91.0
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 17:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766712698; x=1767317498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6vEHwSPLbMYTon6GIevS+ZEJhvcN0whZXuCpRgpcdQ=;
        b=H3jn9EfHyqO5+PVetWDV6hMTQXC0GoQof5e4PKnFu9nc24rTvnfdteYD11vAXdrDsN
         fBjnpZ0kuLouxnxtTB8TQzNyjHvfp4gvGfqw8MoOlplYFmMjMdqMQ8ixqIGeoXR6gjVU
         V0Y18U0T161qkOiyk7eSw87q8I2ZqHAmHDo4ni1PKVd520bHVUAER5BoA7KUwz69G5Ze
         1G0LGHIqg804xSQ5xY4cSRCP2jzolJSIPdHEFoWcR09uENOOmE5rqEvsvmOsm2oYUqmy
         GcyEU69gUP++KHoti+sVDbwpTX+pitx4wnfzTYXwD6HPGWQ1UFmmagiCVxGTSsc9BZcZ
         ebWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766712698; x=1767317498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F6vEHwSPLbMYTon6GIevS+ZEJhvcN0whZXuCpRgpcdQ=;
        b=LgfWdPpurQqWcA0E0fCTH2+n8QAuJk0rqd+0FVOi8PsQ1jMT7336ilzvbSLYJG34+W
         5Nh4XGWp8+bSlg8QhD+roJ/zTXsyJZl4pkYVKh9GjFd459Fwu1vcsM1VYSdKMRZpzoyL
         cKD9ruCsUbMANn6hwthnr1JkUnrrl4u6LBUU1CxDqm5flPxD/nGf7hKwRVfdLpEmdxcs
         fui7yQPXLJ6yf3il3MrVzdxFXEyNzctTK6eUTV/p1ID7LiplQA/AbkztnUaLR0uUjHe0
         SPkIXPOT7z23kkrnXiqTbw06l7fFbRheIqhLk75oCrRB9/f8QUPhZZgNWyvi6O9OT12R
         vcxg==
X-Forwarded-Encrypted: i=1; AJvYcCWT4B/BLJlED24Tk886AgFglMkIc7Qaj4rKOCQoQ1RfDhYKUcAh10r9FiLxVZtw2bP/OGeV2Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZRGZq0P0lhBh0YGBrVQgKEDR0x1MVBw7hfgzCdB3c2RK4Uug
	vdD2RNxMORaKRH+XNgq1X53GWNAbTZtUIKXRdThl05qPOFHvkURfVqsjv30kAgY0al9UzSDej9a
	ppcAc8N+qF7KavhM6Gbke/QbRJGC61PE5yiznd5a0PlXwCt1V2P+enLagbQZ15eFpLVc4S0r2fK
	ImHD6VPdtloV4Z4VIIOpLZ4a3F/BU5WseU
X-Gm-Gg: AY/fxX5EvUR9FJ5g0FiAOh08C/hR1KSzbo0JytRG8sdhvcb+Firai3KyT/OkvufMXgJ
	ju1dQlnEltlZqziT+y54WmUCBdvKEtzui5p98+7oETB72Nu17qfR1DvNRb2dlMiLk61ybIN0HFc
	stWfezKkvd1rv20kmRLKibJQFodlcLW4D93rk6pyPfYTY8iBR+lhDfD4eT5GjaR4vbbW9U
X-Received: by 2002:a17:90b:28ce:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-34e921448b2mr19061591a91.12.1766712698339;
        Thu, 25 Dec 2025 17:31:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfDLUNXaA4vnS159ahikBffjf95vdU5q9+k7UAJ9SZruAaAPrDNmu7aJdwlO54UokDbplRgWPYJOEMbtGxl40=
X-Received: by 2002:a17:90b:28ce:b0:340:c64d:38d3 with SMTP id
 98e67ed59e1d1-34e921448b2mr19061568a91.12.1766712697950; Thu, 25 Dec 2025
 17:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com> <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com> <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com> <20251225112729-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251225112729-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Dec 2025 09:31:26 +0800
X-Gm-Features: AQt7F2qcDC83KcLofPp3_PLoz1EWH_p2ikDpQkczGnwan7bSlzvlAkicGkB6Jgs
Message-ID: <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
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

On Fri, Dec 26, 2025 at 12:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > On Wed, Dec 24, 2025 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > >
> > > > Hi Jason,
> > > >
> > > > I'm wondering why we even need this refill work. Why not simply let=
 NAPI retry
> > > > the refill on its next run if the refill fails? That would seem muc=
h simpler.
> > > > This refill work complicates maintenance and often introduces a lot=
 of
> > > > concurrency issues and races.
> > > >
> > > > Thanks.
> > >
> > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > >
> > > And if GFP_ATOMIC failed, aggressively retrying might not be a great =
idea.
> >
> > Btw, I see some drivers are doing things as Xuan said. E.g
> > mlx5e_napi_poll() did:
> >
> > busy |=3D INDIRECT_CALL_2(rq->post_wqes,
> >                                 mlx5e_post_rx_mpwqes,
> >                                 mlx5e_post_rx_wqes,
> >
> > ...
> >
> > if (busy) {
> >          if (likely(mlx5e_channel_no_affinity_change(c))) {
> >                 work_done =3D budget;
> >                 goto out;
> > ...
>
>
> is busy a GFP_ATOMIC allocation failure?

Yes, and I think the logic here is to fallback to ksoftirqd if the
allocation fails too much.

Thanks

>
> > >
> > > Not saying refill work is a great hack, but that is the reason for it=
.
> > > --
> > > MST
> > >
> >
> > Thanks
>


