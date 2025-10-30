Return-Path: <netdev+bounces-234251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C7C1E1FF
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAEF3A9CA3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5E325733;
	Thu, 30 Oct 2025 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETGG4pd7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C1325718
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791296; cv=none; b=b8A81EoXJWc9joaj+/0KzSq3K+rnNbHWIMsCyGsdJETizUpL13glJ2QPYDPy+y8/HEAkYpkwsj/EIAYu9qc5PQa5uN9kesxlS+akWOwgSFhf1HzhazU5eyAhY5Zi3SMQiXKkHjkbnK6+Lyoc8BFChwJoFBE+Q9go8r7aaup3Gl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791296; c=relaxed/simple;
	bh=ueYr4fDOrACBm0KAvR6isY3b4Yz0LjNUirZu7x5KA9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ufw0jpdD4gK0xNxg5sBZDjRLFeq8z57sTDUO2Bfsj4RteGK8IiY4G9oGZA9R79CL6WPr297/5+FicbNMkjIkebvHjPWC7T7mMnZfl811QxJ1jrlmUUcjbEmY7JKn5la/Ts2NnbuAxyfGwhIMPMIOhKqj8UM8qUZuB7jPzytk9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETGG4pd7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761791292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEN+zeuhvan/3gHVWq0QoHaYVhmGbEh/guxFqXcIed0=;
	b=ETGG4pd7xkWjleVmw39YJ0PUfQmvuhLwogP6CcDPV1bTwoAWmXWWsp3vF4kfQw5GqRKwEf
	16d3XkDvopdX9Ak2NhN2Sw56O8vW1z4XqWBOmoMKkv3ubLq/YD+bpXLG9hblxcl7A2jiEu
	HetIAz5QC67gyIeqyEUohw2t9+6AYO4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-CSDB9iiXPRO4fziOl3cj2Q-1; Wed, 29 Oct 2025 22:28:11 -0400
X-MC-Unique: CSDB9iiXPRO4fziOl3cj2Q-1
X-Mimecast-MFC-AGG-ID: CSDB9iiXPRO4fziOl3cj2Q_1761791290
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso376971a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761791290; x=1762396090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEN+zeuhvan/3gHVWq0QoHaYVhmGbEh/guxFqXcIed0=;
        b=YVx6mmSvh4+WlLkDPvyd/T9Qr4DKGlaLy8zr6NiRgmgW3ogvZ6oLk/1+FOK3iyF7AY
         5mjSuc83QK8WrP/E5ZIh1bBvf7KcdNmCAuYvPdNSKWJ7O8EZ4/hLkEzwXWIQ3D2Tdjsa
         2vhWmvgvl1YZHmyQOkAVbS29FkdVOuhsBO52kciG6g3gwOC1QR5DqNBGUoCjYKL7/FOS
         j5RNbxAimyvwrQKUMgwmb7y2HiQuz6ShE60fd+B2Rf0Pi+IcFvgmDM3kiNpBPsL79PAM
         G+o0ayaEWjunGfnPK1gi39FG7obOOVezP0VkE9apGCUU4f0grQriIINavJJ+mNI0Lgn2
         V7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXF8iBMkMt0i5p4hF/KNT7e/hWNhII2Q4HB3S+bXXHbwFyk6ELVMs3OWOzREoupazlSWEVQkVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8H+l21IQJzqJbo9sqhWx887/Yqartv+/e9THXtj87nMiPzXMA
	+Y8524tE/jF627C7jRTX4dTpfsoMQihtrZMrKSJIoTTNysi5HqWBR7ByzxPp19mM4fBmN2DpOPd
	xCgIbNz3XZuTgsUDYug90FMtwPnRV5GM6vuq6ahKkRzLUpgPm5kNIoUv6iKqXvyi6ULOaEB6RgE
	gyPyIVuAKIMJFWe2uXCs27rRFQ9VF2uHKy
X-Gm-Gg: ASbGncuZ6jsP5vsojjmvPUyoKqSaygmKfwrQhbQTfH8LJVvtCnvCRKHp7xFqMWPNoI4
	8iOl7lwFyv9e5xU8Pye18IlTj66IbFnuACbs2qqC2j73yHaQTFju4nDGRuoOu3NzQchrAAN4aeZ
	lg/Dx/WNSXrPlQERPqfusaZth4L5V5jy0BJyG701+dU39t2AeA8MQ1
X-Received: by 2002:a17:90b:52c5:b0:33e:2d0f:4792 with SMTP id 98e67ed59e1d1-3403a291b3cmr6059395a91.28.1761791289775;
        Wed, 29 Oct 2025 19:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHEWi/hchP75vr8TIP5GW4NVbW1uVRS0LdgxFaSgFw7RPLbuq2PN5WoSwups/PCd+nOV9QSlX3uJ5UVD6ygrA=
X-Received: by 2002:a17:90b:52c5:b0:33e:2d0f:4792 with SMTP id
 98e67ed59e1d1-3403a291b3cmr6059377a91.28.1761791289293; Wed, 29 Oct 2025
 19:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y0ota32b.fsf@alyssa.is>
In-Reply-To: <87y0ota32b.fsf@alyssa.is>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Oct 2025 10:27:55 +0800
X-Gm-Features: AWmQ_bmHhVnu561Asm5YRG2jN4tA7sSFzSe2trT2iThrq4EmrmxrrfR7rVVshjM
Message-ID: <CACGkMEuTnLX7EPuOLb2UhrZT2oH2AcXPQrvq-uw2ZydYV_FAgQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] virtio_net CSUM broken with Cloud Hypervisor
To: Alyssa Ross <hi@alyssa.is>
Cc: Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:03=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> Since 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support."),
> networking in Cloud Hypervisor is no longer working for me.
>
> I've narrowed down the problem to here:
>
> > @@ -2555,14 +2567,21 @@ static void virtnet_receive_done(struct virtnet=
_info *vi, struct receive_queue *
> >       if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> >               virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
> >
> > -     if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > -             skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > +     hdr->hdr.flags =3D flags;
>
> It looks like this was added because virtio_net_handle_csum_offload()
> looks at the flags from the hdr it's given, rather than having it passed
> separately, but it appears something later on relies on the previous
> value of hdr->hdr.flags.
>
> From my tracing, hdr->hdr.flags is set to either 0 or
> VIRTIO_NET_HDR_F_NEEDS_CSUM before this assignment, and flags is always
> 0, so in some cases VIRTIO_NET_HDR_F_NEEDS_CSUM now ends up being unset.

Are you using XDP, if not there should be no change.

>
> > +     if (virtio_net_handle_csum_offload(skb, &hdr->hdr, vi->rx_tnl_csu=
m)) {
> > +             net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: =
%x rx_tnl_csum %d\n",
> > +                                  dev->name, hdr->hdr.flags,
> > +                                  hdr->hdr.gso_type, vi->rx_tnl_csum);
> > +             goto frame_err;
> > +     }
>
> If I change it to save the previous value of hdr->hdr.flags, and restore
> it again here, everything works again.
>
> Disabling offload_csum in Cloud Hypervisor is a usable workaround,
> because then hdr->hdr.flags is always 0 to begin with anyway.
>
> #regzbot introduced: 56a06bd40fab

Is mergeable rx buffer enabled, if not, I wonder if this can be fixed by:

https://marc.info/?l=3Dlinux-netdev&m=3D176170721926346&w=3D2

Thanks


