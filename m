Return-Path: <netdev+bounces-247630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65FCFC9FA
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB792304D4BC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A095259C84;
	Wed,  7 Jan 2026 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4cFPih+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lUzZC1qc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E715285C9F
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774564; cv=none; b=kFw7bOi4XKWt380EWv56dN3zMFIHuKiLUZvWyBKUo7+DXStRNqqkLswf6mqEZWiu0ugstbIGonnY6QuW3+IQeus9tcvO2/Lk1qi1fTl8vY91PU9j58gFORpW2oRtvDYT+7ddbJiyZEVlEQaExc8toVWUoWXRI8wk4NCADZ9o1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774564; c=relaxed/simple;
	bh=Mg00K9PwbyrkiuHwFuf0JzVO3VWZFdCmsSSxAkDeO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6lTYek2N4j/tFa9bdRFldWRiq0wY3q6ipyzIFrz9nudYVcpSf07Og4GkZ+7U82wrnEmPNGoIgZQJto3rEQaoFHeMjO6kxu+L1h6mgEShtT1NsTbQuD3tX1zFT2dz2ouXMNqKOAuJqiZNw2fEwi46yQHeoI5r2ryqq9FYdIAKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4cFPih+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lUzZC1qc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767774561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cunsvOyBEpA2jF2JmeSIYeJboZyz9iSoN1/dk/+Kvfw=;
	b=S4cFPih+IQ+xSe394cTCLlJxV7Z4Lidfzh/MHce0eC1lSAldEdpn18FLflMSpuxFxiecLD
	sM52gCOSxcBQy+lDv8Wa/r4ju+7duq4FEkR9sPlzhVMnR6tQMaFRUwwo6hS4txgtPTmhBP
	YkcKTpWq5nG+dkNXThS7TkUyX8SqiUk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-RZp3VrQOOSGZp4d54_Anuw-1; Wed, 07 Jan 2026 03:28:10 -0500
X-MC-Unique: RZp3VrQOOSGZp4d54_Anuw-1
X-Mimecast-MFC-AGG-ID: RZp3VrQOOSGZp4d54_Anuw_1767774490
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d110fabso16765165e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 00:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767774489; x=1768379289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cunsvOyBEpA2jF2JmeSIYeJboZyz9iSoN1/dk/+Kvfw=;
        b=lUzZC1qc5IrPo+gs8ileoyOQ1gKGKaBYmyPVZtzm4wWI7ZvpNJHCbIvESzvb/6Z8V+
         49GAraZ8zTBr0fqE8qggdfI1DfWuwETkXj1st2FQm9UI3+/gHkta7aTjC1s2mL1+V57A
         pQUp53CJsaEYopLq8f8MO8cC9lnP6UweLh8YyrdZYwb6Kbt9p7TL4sR8fuH2BdS7wN8w
         OdATJ938+ogsCulb0OKiV12gHvzBexeCOUiMdVlwOv0DowtS3eHzpKiouD3AU8dwIU9w
         E2zJBs/WkqqkzJ6UIVLNayXUnqL5zCrd2hUEdZcBPpdJeH+Pd92AI/3OBItb5blRVwgS
         BK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774489; x=1768379289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cunsvOyBEpA2jF2JmeSIYeJboZyz9iSoN1/dk/+Kvfw=;
        b=vVZMwP2RWPFTFo+tCRpw2cjjXlk7NZr8tYETSjfjiIHMDe3XxDb/SOqQxrYTBBL1qh
         QweTfAeDQ4YtP20arYT/mo0ICeuNrNLkmggvWl+tjlbbUqQaoL5DFpkL7HZOD/T/SIiq
         3a6cHsNHa2Flp7woOvhGPOqNjpzicETjJtRZwyUjQ7uypxGBacfULxm7YSA+GJ5/Bgvg
         sNjUk8k4Lwqr1MksapQNu+BryACMPpFW85m3YTX+vuRR0vqX6PVlLnJbJ/deWofnvSXd
         Kj6dEYgMT5stbMyB0+e7+dNokSce/GeoEFM+XEPrXvPEHJtWEr4gp4jcvTNOCdHC6Sst
         VCsA==
X-Forwarded-Encrypted: i=1; AJvYcCVweGf9Mv/I6OKXF9ZCwCIFjZNNcVWiWNewTlhljBEC3lUf0zEP9wLoKc/KbVjnd6Utgev5ykY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOiS869vn8IYfX2PpwKUsUV6PrJCSYOiwEU/rrcfW14IHNo1Q
	IgswiOQFQKxhGGPh+mNspvWwpIrITt2o0DpuiRw6dDnfjglYujeCbWtOYbKoUdERETKI82wwxry
	TcVJnp6yB7KHfMQKUamhLALYv0tKPQdn91U4mtxTZcUVM4kpYJ/huAL/Mhw==
X-Gm-Gg: AY/fxX7twjis68MpqK8HYuf/2S5hxVAMBy5d919U5imiNtjiswf3NzfXzXe6FIo41Wv
	YL9BJ6T4E2IZMWbi+cUK1J6qIULowgRlgwpG/pm2ADG7LkBjWbpUzTHsHmO2Tmixwa8t3gxv4s0
	QHPS/OiIoLnrS+Tv3bAe8F4fj6hZ7MRckY0eRy+qB8jxInvLbCO4RbbZQtizve7pGV9gPnclZjE
	WkCpB/SDLVneRwmauvf0oSyDIAa7Z095XcZ/UttPjy1lWOu7TngN8A/xchD0vA8eSaR8IsXvvtp
	AMadW38sdqd52mL7QcbYJoKrGc6TEtlG/F1W0+ILb0SEAizrK2uJUYNxq860yB/Ejv6eiEhgWvO
	BbFtekJKGYHjvrSCe9LzAyw4d7B+ze7UQVg==
X-Received: by 2002:a05:600c:1d0a:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47d84b17b55mr17590575e9.15.1767774489505;
        Wed, 07 Jan 2026 00:28:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfTqFw1RFyOrDz3FTYetJ0O3Wwz0Nw74F1etDtvhfpLP8L/Oa0ngtxX/fuOMspIpUKEWiHKw==
X-Received: by 2002:a05:600c:1d0a:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47d84b17b55mr17590255e9.15.1767774488997;
        Wed, 07 Jan 2026 00:28:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636cb0dsm9019575e9.0.2026.01.07.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:28:08 -0800 (PST)
Date: Wed, 7 Jan 2026 03:28:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_net: add page_pool support
Message-ID: <20260107032738-mutt-send-email-mst@kernel.org>
References: <20260106221924.123856-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106221924.123856-1-vishs@meta.com>

On Tue, Jan 06, 2026 at 02:19:22PM -0800, Vishwanath Seshagiri wrote:
> Introduce page_pool support in virtio_net driver in order to recycle
> pages in RX buffer allocation and avoid reallocating through the page
> allocator. This applies to mergeable and small buffer modes.
> 
> The patch has been tested using the included selftests and additional
> edge case scripts covering device unbind/bind cycles, rapid interface
> open/close, traffic during close, ethtool stress with feature toggling,
> close with pending refill work, and data integrity verification.


Yay! thanks for working on this!
Could you share perf data please?
After all, page pool is an optimization.


> Vishwanath Seshagiri (2):
>   virtio_net: add page pool support for buffer allocation
>   selftests: virtio_net: add buffer circulation test
> 
>  drivers/net/virtio_net.c                      | 246 +++++++++++++++---
>  .../drivers/net/virtio_net/basic_features.sh  |  70 +++++
>  2 files changed, 275 insertions(+), 41 deletions(-)
> 
> -- 
> 2.47.3


