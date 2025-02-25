Return-Path: <netdev+bounces-169437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4FA43E45
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0DD188A431
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776E267F7F;
	Tue, 25 Feb 2025 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVJYGRWT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF26267F6C
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484268; cv=none; b=KHWWXDp4hGzWCioDAAZBulvOgDzifOtOhvklSZgo/QYK1bG0UURGcB5hUyw0nhRt2SoOFc9NSaihBVFxZCFFLNk+40omjkzr/D4n3+RxwBNehdHWKMmUoM08jaTO/EhjCuvb1F4LlZB6ME91xvjhD4urNPMXpGIETtI/WKCUPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484268; c=relaxed/simple;
	bh=QePXHl2U9MtyIxvRdGJ2Qim/13HHuPvhGGYsdMA6eis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npmn7k6Qfym99vA/GRbRbn1Iyo1cvJwuVUFCtVdblp2S2SMKM2td5Vf+SKTuRAP6v4ErbDcOSfoZub2jbP39MDNHj5bE1cxSWNihxnpHGhxco9itvbMX1pQ+964bltnRLKfxEnejDaznC7AyIUogtSJlN0jh6ff6SPQSijIppaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVJYGRWT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740484265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ontJTl4Ye52gOyy6bKdl6A+UrIOtPXjhHqAkL/9qqBI=;
	b=dVJYGRWTriRr1cfqe9AXuUKQl+roFJxa0C+uz0gON02ovkWAYYNc77SeMfM5wF8SS9KO/E
	cKgy5ycHD2K4w3wUymISq5fe+HoOIUpLDZihesP6bkRMV8pWmIWsiODOuKT4JHepOaHoyA
	sbJU8FRwYVdE5+7LKQLxGUPHXS2DViI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-0Fvd2LILOySmvWLnHI82IQ-1; Tue, 25 Feb 2025 06:51:04 -0500
X-MC-Unique: 0Fvd2LILOySmvWLnHI82IQ-1
X-Mimecast-MFC-AGG-ID: 0Fvd2LILOySmvWLnHI82IQ_1740484263
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4398a60b61fso27895345e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484262; x=1741089062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ontJTl4Ye52gOyy6bKdl6A+UrIOtPXjhHqAkL/9qqBI=;
        b=JndXkLqejamgA6lEfCezHDIXRxpGbneNijkyuzjRKMIXXCJR9llaPL2Crp8Pg4tl58
         Ka7+3UyLsdwVct/pSB/eB/lQf08zfiDm/J4d8vl42ykqOaY0n3cj5ZHcPG7aV1NxfA7L
         13yJut6qpMwg4DUgT9shWLTEPVtQpIE7xP1HNMnCS4dK0RwLgoOyKcwAHb/TdFW9iE24
         Mr5S3DJS0toiPmIiVTb2eUpkI9FCcws8urIQiKRaoN2WUiPv5K8eUNhg1HeluGaFxH64
         56wxHVvQvNVWLSL9w1hjqe1vZFXexKS/vJJ8VvYwMC93luvOQfYBvjoQKH4JYeDVlVxk
         EYow==
X-Gm-Message-State: AOJu0Yw9+qJJM/dpanW6on9HPBHj0R8WZVEqFX+aZEhNDZkBtBI+tAhp
	edzKx0HfScOxt2Ak/hQC43ilhqWBM+HWgeknfc+qxlnLMbbQVHff9yCIheQCmrLbDb5M8SCChGS
	ke13qbX0pnb2Cyyy6yK8BX5ZTrsGnjFQI3GWOsU4/MBH6ErPCVN2O7yHU/AciBQ==
X-Gm-Gg: ASbGncuqv+AUdIyh0iH6C2i7ZHBuEkDlRTskbFxi9526gsiGHW2vkYcPSBwopigL9gw
	4RjOdWotXSeJlhxBeB7C2IQY5GN+mKyoS3mzqNFH4HeCCKX9xM1GDxjU9KqCMF08WRISUYmX//D
	lPBcYvnz4DY3znhASArjnmGSDxTGj6AQKEW1uMKKdQ4P2weO9srCpFRNjtSnWGs2RQ+LgOTy6I6
	mLwYrTzS6P6s57zb+GRGfX/b/6WJmd1eRSPJMUy1IEgTFgne4wp/yd5N4A+KLz9HmwxvRrles8B
	wc0kkA==
X-Received: by 2002:a05:600c:46c7:b0:439:955d:c4e2 with SMTP id 5b1f17b1804b1-43ab0f3c192mr23661695e9.13.1740484262484;
        Tue, 25 Feb 2025 03:51:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2dHVGU6ySYQuybYU9lcVFOrTV02AAJUQfFCuRDy5a/7ieOIV1xaKLQg6gXsP2F92NHLpY1A==
X-Received: by 2002:a05:600c:46c7:b0:439:955d:c4e2 with SMTP id 5b1f17b1804b1-43ab0f3c192mr23661485e9.13.1740484262115;
        Tue, 25 Feb 2025 03:51:02 -0800 (PST)
Received: from fedora ([147.235.220.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7314sm2041729f8f.65.2025.02.25.03.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:51:01 -0800 (PST)
Date: Tue, 25 Feb 2025 13:50:59 +0200
From: Mohammad Heib <mheib@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net: Clear old fragment checksum value in
 napi_get_frags
Message-ID: <Z72uo1DtcEPPz03J@fedora>
References: <20250221161405.1921296-1-mheib@redhat.com>
 <20250224143430.5fa61a68@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224143430.5fa61a68@kernel.org>

On Mon, Feb 24, 2025 at 02:34:30PM -0800, Jakub Kicinski wrote:
> On Fri, 21 Feb 2025 18:14:05 +0200 Mohammad Heib wrote:
> > In certain cases, napi_get_frags() returns an skb that points to an old
> > received fragment, This skb may have its skb->ip_summed, csum, and other
> > fields set from previous fragment handling.
> > 
> > Some network drivers set skb->ip_summed to either CHECKSUM_COMPLETE or
> > CHECKSUM_UNNECESSARY when getting skb from napi_get_frags(), while
> > others only set skb->ip_summed when RX checksum offload is enabled on
> > the device, and do not set any value for skb->ip_summed when hardware
> > checksum offload is disabled, assuming that the skb->ip_summed
> > initiated to zero by napi_get_frags.
> > 
> > This inconsistency sometimes leads to checksum validation issues in the
> > upper layers of the network stack.
> > 
> > To resolve this, this patch clears the skb->ip_summed value for each skb
> > returned by napi_get_frags(), ensuring that the caller is responsible
> > for setting the correct checksum status. This eliminates potential
> > checksum validation issues caused by improper handling of
> > skb->ip_summed.
> 
> Could you give an example of a driver where this may happen?
> Otherwise the commit message reads too hypothetical.
> 
Hi Jakub,
Thank you so much for your review.
all the comments were addressed in v3.

Thanks,
> > Fixes: 76620aafd66f ("gro: New frags interface to avoid copying shinfo")
> > Signed-off-by: Mohammad Heib <mheib@redhat.com>
> > ---
> >  net/core/gro.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/core/gro.c b/net/core/gro.c
> > index 78b320b63174..e98007d8f26f 100644
> > --- a/net/core/gro.c
> > +++ b/net/core/gro.c
> > @@ -675,6 +675,8 @@ struct sk_buff *napi_get_frags(struct napi_struct *napi)
> >  			napi->skb = skb;
> >  			skb_mark_napi_id(skb, napi);
> >  		}
> > +	} else {
> > +		skb->ip_summed = CHECKSUM_NONE;
> >  	}
> >  	return skb;
> >  }
> 
> I think this belongs in napi_reuse_skb(), doesn't it ?
> 
> Please make sure you CC maintainers on v2, especially Eric.
> -- 
> pw-bot: cr
> 


