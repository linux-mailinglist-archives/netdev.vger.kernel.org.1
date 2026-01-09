Return-Path: <netdev+bounces-248373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE0D07739
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 07:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6B9730096AF
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 06:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A12E8B8F;
	Fri,  9 Jan 2026 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdbEHgo1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oeQfUp96"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129D2E8B78
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941442; cv=none; b=NyWSHT15YjggsaR81ye48lVlKtSKn9cmL6G7RZv/BDrB7hn4cjeOExPDXZFfdWXP8l7VQk5/NwsZFMDjk2CMhpTX1kYChvSuxnlYsdi1hHqehsYfLmo/woXSFX5Rz9tO2zaq0k+1YJZfBcyxcoDsrIXCGnMVHzA6VetokCUaUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941442; c=relaxed/simple;
	bh=iEtJOvOiVU5aWrZjX18IWSGkBx5iBhYUuqRnUN225Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BopgIDcAflHaDMXe65iNrcXIU2a58frUBPnIa8p0hIIKKS/tys4mLEBHLVGrOKLdt6qYe2VgJFOc6mKcVIzBp2TGlDyjHNz0JziMh+R8mha5HlHgRQkrESNrr3D/5gFmjfP1PLuthha5WjLDclzQsKFzhyoY24fh//WOIuzTx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdbEHgo1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oeQfUp96; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767941440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+ceZQaBHtSWEXMLCYeIz4W2mWMzIw2cMZlyfXRW3eI=;
	b=QdbEHgo1qA3u1MZsAU6PwOcUONFgqqZIPD4ZtAOb6S78MovX32AZIsv0WxU2t1sLowZ0Vx
	q4fWsLUp63OhqnROV9XgrzKHd9xQrK+3pw/TemYy5Ao+tHXyLVEXzanHQESjZxn5bhhoSI
	72VbQk5W1svbOJiBi/gX2UkqjSbJKzc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-cZPqRLznMOyA6xslCP5-lQ-1; Fri, 09 Jan 2026 01:50:39 -0500
X-MC-Unique: cZPqRLznMOyA6xslCP5-lQ-1
X-Mimecast-MFC-AGG-ID: cZPqRLznMOyA6xslCP5-lQ_1767941438
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso36664985e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 22:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767941438; x=1768546238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+ceZQaBHtSWEXMLCYeIz4W2mWMzIw2cMZlyfXRW3eI=;
        b=oeQfUp96AmgpTP63XV37OoB6dX47fYm7QWFWSQzRTASNVWlOUZzcZZRMM0L8OQZbg3
         HqxYeuyT5oO4OPvPcosLgQOvJYAq0KMf283+0e713ZQHbhirZapuieCZjd3k1ceHM877
         LsaFFds9NggkzNFAC+ZigPyCrjgLP+5fKpLuDF4fJ7RDc98nkQ3TpgQ1E+xtQV42P2QW
         JeH/BELCDefTpaW7d0gh+q+zO9C9jsPpJz7yjqvM49k4xfkTUK52u6VwatoRVKLDX4aD
         A0SIw4BKXUzDZFu7mAqyHZq8jICuxUTy9jXhtCbyQxMC+7OPhuiBqAKxWQyS07lHWJ8S
         Hdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767941438; x=1768546238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+ceZQaBHtSWEXMLCYeIz4W2mWMzIw2cMZlyfXRW3eI=;
        b=U4EjTQn91in5mCU5df+yCP+95BJ8c1vgjfQIn1vxIm6FqLG6kfrXMH4/fSA+Enf/3X
         5zVavqKwjMtfYFV7klQcK/92xwL3dZ95aA90boy66uklyWRaurkPag57ermiLU5QQ9cg
         nJbueJ9FfZ0ZSfDM0lLphfxmop2oeqErcHG66+ZR/5exr5uRjkKAps6vQJ5ugs86rzz8
         iDtvhqgZ8wfIlg2mn1cs6pP6DA8jWNoCcsw7jLZA8nFNv+FbtZbYe2Ujz/nF5VR8H7RO
         BUSfOmjyMedtGh6+OHKAHou6PaFiaRNtnT9zVZ8KKYc/ggeISuhzO7v5+6RECVw8lqZ8
         Vu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXtMg5b8YwXYp2BGxz5nQKeoeZGJr0m7f55uw29yP5A05gBVZHsnAEp6yWorCdDJ4PTjSOeP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzagK31VY1M9uPNd+UNHLzbTS5CbfaTRGuvtvYrsJF4YbimaHyh
	USm6/q5d4a+FGZuhBjA7D+YFhXSaAfBz/8ewvHE8to2Y8zjZbHzyoZ/CnwT6qnGAAzQ3yCSilVk
	qtSS6LgmKRy4hMWzI0CqQv19FDaTQzjsl6jbFdOBAbWPpj7uwP9Udt6cjgw==
X-Gm-Gg: AY/fxX4f9YMiW35AEwdDhySLE1XcGaUYcK1Mq/ZtKIc1vXJu4aJim6VsM7+oUmw8Lvb
	hBQgi+MRvSsXp/N4mFjDq2+ruGgpFNKZWprcAYQtm7gJxiYrz8Vg02orCg6/8Te2MOZP/3mqrZm
	ITSz30I33sk0YUUIAZvGmSp3VmNIVa7Bi1KXkn7zW8IgHbJGPWlb1dmvajW7ZtnMANreNKzAuVt
	coZ26gOtqW3NP/m/UjWyZNkIz4WpDv7GTSiTtEWVxaaaVwBTnGnVv2A+rKsbrOshexnpDMO01bM
	0G+S0mDB4SL4uvTr9QqMFIUMOT4CPSPbQlprx1F9UlpxenHS8ldD052gikQVLvYow9cDzNK6Nhj
	WuQH0vvfajaOMRU+zn2KLcCMgk+YyjIKykw==
X-Received: by 2002:a05:600c:1988:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d84b54025mr83032935e9.34.1767941437800;
        Thu, 08 Jan 2026 22:50:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPoTWz83P/iNwID/4Bvz08OjAhrzEJr6LK5HIHVnGFH5eW5Gjhe1uiWsZet3dbhgEY25lNqw==
X-Received: by 2002:a05:600c:1988:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d84b54025mr83032605e9.34.1767941437006;
        Thu, 08 Jan 2026 22:50:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f84besm59137085e9.1.2026.01.08.22.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 22:50:36 -0800 (PST)
Date: Fri, 9 Jan 2026 01:50:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Vishwanath Seshagiri <vishs@meta.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio_net: add page pool support for buffer
 allocation
Message-ID: <20260109014836-mutt-send-email-mst@kernel.org>
References: <20260106221924.123856-1-vishs@meta.com>
 <20260106221924.123856-2-vishs@meta.com>
 <CACGkMEsfvG5NHd0ShC3DoQEfGH8FeUXDD7FFdb64wK_CkbgQ=g@mail.gmail.com>
 <bba34d18-6b90-4454-ab61-6769342d9114@meta.com>
 <CACGkMEuChs5WHg5916e=odvLU09r8ER-1+VXi5rp+LLo0s6UUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuChs5WHg5916e=odvLU09r8ER-1+VXi5rp+LLo0s6UUg@mail.gmail.com>

On Fri, Jan 09, 2026 at 11:16:39AM +0800, Jason Wang wrote:
> > My concern was that virtio has its own DMA abstraction
> > vdev->map->map_page() (used by VDUSE), and I wasn't sure if page_pool's
> > standard dma_map_page() would be compatible with all virtio backends.
> 
> You are right, DMA is unware about virtio mappings, so we can't use that.

Or maybe we could add an API saying whether virtio mappings are DMA ones
and then enable that conditionally? Because on some platforms, mapping
in the pool can save *a lot* of cycles.

-- 
MST


