Return-Path: <netdev+bounces-154290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEAC9FCACE
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 12:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40BF7A1103
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463FE1D517E;
	Thu, 26 Dec 2024 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOYY+ud7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8461D278A
	for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735214081; cv=none; b=XPyk/nUrD4sbjRwgG0UsNdGuemWE4lJ4Y5t5Ya33xiEA49JJdFe4rztocYi0fEQcHK3Qx8AIddJeWxTQ1W7UWiLxrb67+dgofRntqW4GITZmo/76Onk1vRILOnDJZXw9hmhWUGNHwiNKi1DXcGzQjd+aYwsgVngEhbygY9BsJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735214081; c=relaxed/simple;
	bh=iWkIeH7XpKncFP2q6VfoR5Zy250ww4ZI5R5aDEzlRHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPkgUxSVf7PQlOfVyr2fH8XB9ZUmACEQyZJO7edLSQ1UmdbmHWqRM966y9UikVF5wne6OulTlo+jXky2NLfeOzrx3JfOiLuf9HSfpNPedExFcr4Jnn133aUtrmIZKkstqQ76bUgCRjbFxgnvqvZmq0q0VK3PnTp77ULXj/hWdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOYY+ud7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735214076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLjAVdZBTOv5YjH5Y2Kd0YMJTvW51ihi5xrqHhONKz8=;
	b=UOYY+ud7XJHB6jBvPnaDdD/gA9kBt7omi9yk+nToFD0PcCNDVuKDrAiEy6fgErGh3g02bc
	RtEFsRwEuUccaphx6xikKnfGfmIg4y+5ZctpQMvL6uwFaGQVHNzAUmFmbja3In98GCj53d
	38JzIhMgEljibTrgjwSKiX6VOcUmf/o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-6GXt590FMNinRaWDCetxyA-1; Thu, 26 Dec 2024 06:54:35 -0500
X-MC-Unique: 6GXt590FMNinRaWDCetxyA-1
X-Mimecast-MFC-AGG-ID: 6GXt590FMNinRaWDCetxyA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa68b4b957fso513067966b.3
        for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 03:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735214074; x=1735818874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLjAVdZBTOv5YjH5Y2Kd0YMJTvW51ihi5xrqHhONKz8=;
        b=mXk4Ycn8fPUlVVCdh309/2xdIkONHXa78xQUBn269DyBH7aPjX8/sFiaUWTIFKpis2
         lxlGb/F0rpbYmg51/z9cQ1Zpumg1AErj25KjGKTZ3So2hWpjl+0M/n9zmrIGdQxviAY0
         juX2yrJg6CtN9afC1NJsVnc8j+Qf4CPqVXdA7wvLpjQAR1pi0PpW7CXygCl59nZ+na+g
         uJeGzzVBgiVQI9niNrfPj3on0nSFC5yl9fRyBLOlKAyFzn4+gMrNKCXnV1ssc1SPVUTp
         UwbT6ogGeETXDTu5WBdcIuGAF5RicUTcnnC5b2RClBXXotf/JnEvrQlSoYKlJxpFzgS2
         RltA==
X-Forwarded-Encrypted: i=1; AJvYcCVuHfv6+2VS+m7vdNpmiA40KcjqFPLWW8dn4agocdCjkUv3NlooUTe75Q4++WIXhzgkb4p6JZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweebQ5iZFf5okpFah21Miose3f/bJ7tPPU3n1nrVH/OVWcI4ez
	Aj5tHLHUzglxrPIIiv4YgGSwrP5Ra7iLFbHsM9/O4RpdyKuobnXWz+Tx6nSJAPm4unCkB/zVU1k
	JxhknU2lPg6Yqhgi+8AlNzi+7q828YdCPw2ey5na95ATTPO4707ZBPg==
X-Gm-Gg: ASbGncs2rzx8ehw7HXbPO72VAM+lTZ1SRDgnjdq29DFLGWLhu0giv7QbVVb9DE483cE
	V26gtKugnxs6/id9zBtRSWVzYdlbiVNPHm518Rmhdf7mwlcg1SaIQRvTCukBH+MKZvgwY8cp3P3
	lR4rBgoaXIbAAgg+6pBPs5YV3ehQLlmSesmBGGWp03W68b6lZuE0etg7gJubZpCHDyF2nI4Hx/I
	cQ988ThDPK6gZwEmmkOjR76zzulZviYH4htBrNJUARJvBM=
X-Received: by 2002:a17:907:60cc:b0:aab:736c:558 with SMTP id a640c23a62f3a-aac3368bd9amr2037709566b.55.1735214074270;
        Thu, 26 Dec 2024 03:54:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYnbh6gwrQFWWldDcanUaWJe0Ikrbn57WhRMyPauSRLl4E+qhWj414eKBdK7jKHQ4sxz/A6Q==
X-Received: by 2002:a17:907:60cc:b0:aab:736c:558 with SMTP id a640c23a62f3a-aac3368bd9amr2037707666b.55.1735214073922;
        Thu, 26 Dec 2024 03:54:33 -0800 (PST)
Received: from redhat.com ([31.187.78.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f0159f1sm938821566b.154.2024.12.26.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 03:54:33 -0800 (PST)
Date: Thu, 26 Dec 2024 06:54:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: Set num_buffers for virtio 1.0
Message-ID: <20241226064215-mutt-send-email-mst@kernel.org>
References: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
 <20241106035029-mutt-send-email-mst@kernel.org>
 <CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com>

On Mon, Nov 11, 2024 at 09:27:45AM +0800, Jason Wang wrote:
> On Wed, Nov 6, 2024 at 4:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Sep 15, 2024 at 10:35:53AM +0900, Akihiko Odaki wrote:
> > > The specification says the device MUST set num_buffers to 1 if
> > > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> > >
> > > Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >
> > True, this is out of spec. But, qemu is also out of spec :(
> >
> > Given how many years this was out there, I wonder whether
> > we should just fix the spec, instead of changing now.
> >
> > Jason, what's your take?
> 
> Fixing the spec (if you mean release the requirement) seems to be less risky.
> 
> Thanks

I looked at the latest spec patch.
Issue is, if we relax the requirement in the spec,
it just might break some drivers.

Something I did not realize at the time.

Also, vhost just leaves it uninitialized so there really is no chance
some driver using vhost looks at it and assumes 0.

There is another thing out of spec with vhost at the moment:
it is actually leaving this field in the buffer
uninitialized. Which is out of spec, length supplied by device
must be initialized by device.


We generally just ask everyone to follow spec.  So now I'm inclined to fix
it, and make a corresponding qemu change.


Now, about how to fix it - besides a risk to non-VM workloads, I dislike
doing an extra copy to user into buffer. So maybe we should add an ioctl
to teach tun to set num bufs to 1.
This way userspace has control.

Hmm?


> >
> >
> > > ---
> > >  drivers/vhost/net.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index f16279351db5..d4d97fa9cc8f 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -1107,6 +1107,7 @@ static void handle_rx(struct vhost_net *net)
> > >       size_t vhost_hlen, sock_hlen;
> > >       size_t vhost_len, sock_len;
> > >       bool busyloop_intr = false;
> > > +     bool set_num_buffers;
> > >       struct socket *sock;
> > >       struct iov_iter fixup;
> > >       __virtio16 num_buffers;
> > > @@ -1129,6 +1130,8 @@ static void handle_rx(struct vhost_net *net)
> > >       vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
> > >               vq->log : NULL;
> > >       mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
> > > +     set_num_buffers = mergeable ||
> > > +                       vhost_has_feature(vq, VIRTIO_F_VERSION_1);
> > >
> > >       do {
> > >               sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> > > @@ -1205,7 +1208,7 @@ static void handle_rx(struct vhost_net *net)
> > >               /* TODO: Should check and handle checksum. */
> > >
> > >               num_buffers = cpu_to_vhost16(vq, headcount);
> > > -             if (likely(mergeable) &&
> > > +             if (likely(set_num_buffers) &&
> > >                   copy_to_iter(&num_buffers, sizeof num_buffers,
> > >                                &fixup) != sizeof num_buffers) {
> > >                       vq_err(vq, "Failed num_buffers write");
> > >
> > > ---
> > > base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
> > > change-id: 20240908-v1-90fc83ff8b09
> > >
> > > Best regards,
> > > --
> > > Akihiko Odaki <akihiko.odaki@daynix.com>
> >


