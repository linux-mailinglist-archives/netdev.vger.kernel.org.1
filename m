Return-Path: <netdev+bounces-224685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57906B88554
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE981C87325
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8A3043AE;
	Fri, 19 Sep 2025 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uxp/0H79"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A3303CB6
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269317; cv=none; b=G8zQW3NT4VJKElyyKPqZBDRc+m6isz5mhUN+74wd0IxC5PLhIJ6bNDdDeZ5GuqFgXERJmsHh4fjW6VjwzOnuwbbdaOKqKZH3TK3TcHIOOkVdeLDW+b1937VB7wcjbD7bHNDBc3Hj6gxN0PIA2w/fWEWBTWmg7at9527h+96Z3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269317; c=relaxed/simple;
	bh=VLZYffDAeaYgQlYikAN5MJfCakv0SHKRtux7+rgjz5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok0GxrqmIJxkE6wqfOwrGnLEDcmWwd4LkXEs47YwJvKh7OA8wKIVHB+X+2QkAiZrRBrqvXzNM4c5IiJ6pBKksOCnpf3Epj3ZBVbvhtYq6AAFmv+zo9jGnrZ/RUbPmtSAsSDGlzAeCnFZQnFL2cbJ8VVHJX+fBEfKJINnT2a7q3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uxp/0H79; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758269315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIxzvraroGndXUseXRYHpQ4xGsj43fuuer+gtznNY3k=;
	b=Uxp/0H79F75avWKIEJNDXCT/HmbvS11rjO5bcGBWRjw+UXGTExG03FwCuoTIgkSh+3dz1h
	mqEKo2wgcxJNZSZU2OlOcypWbrMFcutc4UHMx/09ySGH9FpP3awI4q3RCPlPJ0wASCyv7O
	ycQoaa6x8fFKaZDjFda518MqCBvAbrY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-8Lg_rzdJNRG83fyfI-qxvQ-1; Fri, 19 Sep 2025 04:08:34 -0400
X-MC-Unique: 8Lg_rzdJNRG83fyfI-qxvQ-1
X-Mimecast-MFC-AGG-ID: 8Lg_rzdJNRG83fyfI-qxvQ_1758269313
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45deddf34b9so18207225e9.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269313; x=1758874113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIxzvraroGndXUseXRYHpQ4xGsj43fuuer+gtznNY3k=;
        b=bA75gXxQ5FXMCtkoLSUr3ypxlwwyyaPYms6N9wsO+zwmVxliTzR/IxHZik727CPkxQ
         yzNUIob4nyCT2eKWP/9FhoyTtOFOlUMwdNfBn4Vfpjtq3NlnJ2rhWfbvIcGSfBKMelOO
         KfUQHeSxtxLo2B6p9ZROUHtoNWYhPXZagP/3WwwRSFSuI/ftJTqSmZBH0P4ftQM268Ef
         Zgo6LD//2XDzocxyT0TxRx+7xxlw1caFDz6pCgyYTfcqCfMWSBf37lKqYblKu8ORy4Bb
         J3Qy8KZy1k0gCCQuOMd1fZcgVDReHMYWcxI1ApEVrbhWj6ASNw6YcRtBrOkGt6vFkJ6Z
         b+hg==
X-Forwarded-Encrypted: i=1; AJvYcCVsSkVNGYEHKydsctDL5vV8aW7l3Tml2nbdXim6D+HgnL0p7PbUunGbLn8SEN6NfBzoEH+FTy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42B6KDAF/40FCO/1XK6L+vFkfVQ4/BsAcjm8wJjyEpvubBqD/
	qIbl1B8gCd3y/ublgSAqx/grb/Fiqh0F4zsz/rCsrv0c8W2PcDX5JQOmxTwmINcPDDwEaTfqs3R
	TdCECvoX1w9ZRQlbIs2yKYezlU1HBwSiIOxtHjUad/WcBDCXQ1Nj/ABgvyZljtuQT2A==
X-Gm-Gg: ASbGncvo3kGdemVkSVAA2j8FxEHB3M1psnMUjh8IfY7f4aw8XV9C5+rSrkQaHn+zsBh
	PhX3zT5asuZ4fIONxJ2zdPwJi95AeqxZpYa39leEHRJcP6w9Z5Bnx264+Luo9zG8DlUfl5M2kUc
	hVy0Z/DE/GAmTaD4uMcUxEaT2DGtPZ7123VdrbhRD+x3IDrYjeT1mYVB30SQQ7MNcAmGUVQgCdR
	OvnKHOtJGHvX1IIdQ4agqZ2jE+3Z5SkOcqZLiYfg2Fn+ATCH4OPsUQpYv5+P17gBDHT4gD2WXIR
	TaQ2xcn0O5vOiyoDC0+PbEeoXCFkrfM=
X-Received: by 2002:a05:600c:a316:b0:45b:86bb:af5f with SMTP id 5b1f17b1804b1-4650a0b8379mr52806625e9.6.1758269312581;
        Fri, 19 Sep 2025 01:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSYngzMvTigSbwISAEKdbUVkh+qjENhtjn2tbVqLzn3qz8kOruU3DQcxqKMxkEFwwZ+71K8w==
X-Received: by 2002:a05:600c:a316:b0:45b:86bb:af5f with SMTP id 5b1f17b1804b1-4650a0b8379mr52806335e9.6.1758269312176;
        Fri, 19 Sep 2025 01:08:32 -0700 (PDT)
Received: from redhat.com ([147.235.214.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f162726bsm73886815e9.7.2025.09.19.01.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:08:31 -0700 (PDT)
Date: Fri, 19 Sep 2025 04:08:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: fix incorrect flags recording in big mode
Message-ID: <20250919040736-mutt-send-email-mst@kernel.org>
References: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>

On Fri, Sep 19, 2025 at 10:11:55AM +0800, Jason Wang wrote:
> On Fri, Sep 19, 2025 at 9:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> > checksummed packets handling") is to record the flags in advance, as
> > their value may be overwritten in the XDP case. However, the flags
> > recorded under big mode are incorrect, because in big mode, the passed
> > buf does not point to the rx buffer, but rather to the page of the
> > submitted buffer. This commit fixes this issue.
> >
> > For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> > buf address when unmapping for small packets") fixed it.
> >
> > Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 975bdc5dab84..6e6e74390955 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >          */
> >         flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> >
> > -       if (vi->mergeable_rx_bufs)
> > +       if (vi->mergeable_rx_bufs) {
> >                 skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> >                                         stats);
> > -       else if (vi->big_packets)
> > +       } else if (vi->big_packets) {
> > +               void *p;
> > +
> > +               p = page_address((struct page *)buf);
> > +               flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> > +
> 
> Patch looks good but a I have a nit:
> 
> It looks better to move this above?
> 
> if (vi->big_packets) {
>                void *p = page_address((struct page *)buf);
>                flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> } else
>                flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> 
> To avoid twice the calculations and reuse the comment.


I think duplicating a bit of code is better than branching twice.
So I would move the flags assignment down instead.


> >                 skb = receive_big(dev, vi, rq, buf, len, stats);
> > -       else
> > +       } else {
> >                 skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
> > +       }
> >
> >         if (unlikely(!skb))
> >                 return;
> > --
> > 2.32.0.3.g01195cf9f
> >
> 
> Thanks


