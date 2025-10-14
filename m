Return-Path: <netdev+bounces-229130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6955BD862B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D77D4FAB4F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE02C11F0;
	Tue, 14 Oct 2025 09:18:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12126F28F
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433500; cv=none; b=gVrJFYy7Ved1BJo3QRA8Zqr04VdSz6QAQDz2H0i0yKW1PQnUDGBrfzq/dBm91txNxaElrdiQ1cpvTO5EzuVpPl7w/29GOd00R7yJw/6GbByJuSNi1sBMIwVXpNX/sjzXF52VJJfMzgCVm/Witm1axa92TOcgiacXZkusSXnwTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433500; c=relaxed/simple;
	bh=pRySc9wGvib0712pdmZwsSCJaX7osrehM2VEKQgyLbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMQpBO6TErI4EGv23Oz+caDLzQ9VgylncjLbOOvEr1KDDXiiFR+aEdJYVs1br1SyaqRbj/bIWZKxxq91McOMo13JoxoqzIPP3rxFqOVgdIQOkFbkWhuNLvlZhM8UonWoFaAc+HK42N4HjnYOddaxFP5Pt8V7qwR8bt6wr+WYKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so923257266b.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433497; x=1761038297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0XLyxJWaoIPYyxxXV4bvKlSgBwkx+wM+aGiKaURStA=;
        b=MO0arBxKkBQdydZMyD5ZtZh6H4dXdyVGLVAREShzuAeeENWvFiBeOufnwT6whJd4uB
         7cDH9zBL5zziqIkt20WT5TetUQxGLnTpmtcpByyq97u9xVJ9IfyM/zrUFbVLLgBoKTPe
         WjZyLW9rObzq0t+ms5PSJi/B9xF+Wx7poTKpM9kiSyG/RCjlZnu9Qk65iV+/7V92FL+8
         Ob5D9SA/qwb4VklT6WPUVCkHhZmswhvi3qjIzCuVTl8YL4OqpH4zWIfhKpaf/eNk4L+c
         b7sxyvVF9UQ5XDtEGrQW4AQzCfNzW1hCwcibl7s5CoajZjgA56uKyaRFc0aQxam8SPGM
         Z+ww==
X-Forwarded-Encrypted: i=1; AJvYcCXduuRij8wb6ivYDICFi1NI/bexf7ls9ay6FId2y7WuQW0fTy7dExTZamoWmkd+z/Z2pGgTG+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJIddJruEKJm5RmcZdjyLSg/dCcwsPTn3cL1aF3I2oC/Sbu8Cu
	BYM6SeD7agfzx5OoooUlCGeaSQo6J3d6ewBB2tbuvGAv4Fp2vnczlWMNaqHRSQ==
X-Gm-Gg: ASbGncvaEQ+MrxbP0PM9XEnmWKyqU2eaXAvOQT/yb6cVJPBTQ66ZpgB3FZQr8ztVNjC
	PFJuw+mb5yRlqPZe29yswjuFr68zQu2pXjUKwxi5vrnuYd7B1p0rhy8HP8UBwDR8QyV/BOeUowU
	o153hWBEJmIsG3OpOhClY8yHM9qKNuZzQRFxF+gGASWeqhnnZMnTHrqyJ+iz0We5Qxg3lBjFyQL
	CajyH/P2iKcDJLdzmO87pdKH0yY8rum5VcyUID0nfZ6wSJnUmtowYLdtxYhLyWkm1hI+s1YmZ7W
	XO9fEf9IYCQ5kHwpozr9/AyLsuA2jdUasO8dWy8rN62uMGB1hgXFk5pqtvipaXE99o9RCShR4Im
	zA/3jDZcLszbyWpt8TPOz0Vux6LCcpzxalMI=
X-Google-Smtp-Source: AGHT+IGKNEJ/R5tUjNTzQr8LYnYikZE7FzqSywVlP1BdDD46LFzgEzFplMLIppxM3bMlh8TiM4vnUA==
X-Received: by 2002:a17:907:868b:b0:b3e:babd:f257 with SMTP id a640c23a62f3a-b50aa49207amr2854806566b.10.1760433496877;
        Tue, 14 Oct 2025 02:18:16 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900e432sm1081271566b.65.2025.10.14.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:18:16 -0700 (PDT)
Date: Tue, 14 Oct 2025 02:18:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] netdevsim: set the carrier when the device goes up
Message-ID: <ha53dregkpznr6qeym7v65zcyl27u4oe6cwqtcyrxbmz2i7o5u@2gbcfwb42az6>
References: <20251013-netdevsim_fix-v1-1-357b265dd9d0@debian.org>
 <7e1d28c0-7276-448f-8d01-531b7e8bd195@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e1d28c0-7276-448f-8d01-531b7e8bd195@lunn.ch>

Hello Andrew,

On Mon, Oct 13, 2025 at 07:25:27PM +0200, Andrew Lunn wrote:
> On Mon, Oct 13, 2025 at 10:09:22AM -0700, Breno Leitao wrote:
> > Bringing a linked netdevsim device down and then up causes communication
> > failure because both interfaces lack carrier. Basically a ifdown/ifup on
> > the interface make the link broken.
> > 
> > When a device is brought up, if it has a peer and this peer device is
> > UP, set both carriers to on.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 3762ec05a9fbda ("netdevsim: add NAPI support")
> 
> It was not obvious what adding NAPI has to do with carrier status.  I
> had to go look at 3762ec05a9fbda to see that that was when nsim_stop()
> started to change the carrier on stop. This patch makes nsim_open()
> somewhat symmetrical. If you need a respin, maybe expand the commit
> message to explain this.

Thanks for the review. I've sent a v2 with the updated message, given it
adds clarity to the change.

--breno

