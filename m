Return-Path: <netdev+bounces-123327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB429648C7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3AAB233B5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045971B0135;
	Thu, 29 Aug 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtrRqnwM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F51B011C
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942531; cv=none; b=olNsbwYs3lqW1IuH/1ntMbTreikh8rlrnfJ3Yu4kwM9eTouj2rVYoTaDhSnJUpiCOdyydT3nv9kDA5CALQcIIIrDqXnm6SJUjMgwho+2NWbXbSub+FWgE2OgQ/xmErbuw+liXyvR/kGkek48585a4IVpkZ5UzTf16b3cJvWqtH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942531; c=relaxed/simple;
	bh=FAL3Wk1GJKv1jtOh0SKb2Eaa3RAQlRHvFE9FQ3MaL28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqo+nMr4ILB/BVnwVTlrFe9Tse58CPbDNA3/e6kI/pxaRwJ5xQ9vqw/zkzIWpD7OU4+t786wet5x+Cr4/IaWjOHThsuAB/lhujYjb9I+mz9Vu8E1QC5B/lkTulGNJJNZCq4Gdi4DAm5wtNpj913bqYJ8YDKGcuEq2wBLciOuF4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtrRqnwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724942529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zMnahuLuC6i0N7ypZMSGEalm8mu6MNOeiFUlojCltE=;
	b=gtrRqnwMk99AT9UsVOr22hffuowNyK4fPGkrkl5GyBKfWI5xappvIhI7wXtuEbU1Sl6YyL
	RUmny2YAKZ8G8ZQDZ2W7CHyYDAcxPZoNNBC+iBUnfh65EBJGsA0sikz8+AMagFsu0uIDTD
	Tnio+PW3toFFNLw0xHlCxHtZtVatHkk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-yUr7sF81N7SlDvm-GwbZcQ-1; Thu, 29 Aug 2024 10:42:07 -0400
X-MC-Unique: yUr7sF81N7SlDvm-GwbZcQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c085b4f665so744123a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942527; x=1725547327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zMnahuLuC6i0N7ypZMSGEalm8mu6MNOeiFUlojCltE=;
        b=WoZe1llv4XxSLUrNIbqcG1j70HDD4AqIFSGHYcOC4TINfNxyq7O9vEH0Ez7eq9R0Hn
         PgvQvFwY3/6LFQLRqGGLhP3rEHTp7V7tV+T9kudoTuVKH/RjxnUdy8iUvVvODyTXidfa
         hIP6LKzldPCAWahXT2a2nmnW8D4DT9TtepwYV1dTfXhyJyjGbJka2k4zbU2VfAnfi9eF
         kOun6YleFnx3oZtgQUDCQDu8PWtP6L3+d0jgVF85guuTdXn0l/rSjKRGCn6GyCFf8EFk
         6aX/qtLHv2n6s7P6jXGxgasGsJkfA8PY/BTtx8NtskrzEDu9z2KjBeG/fLSRBZ/aJS83
         mtNw==
X-Forwarded-Encrypted: i=1; AJvYcCXpII/igkbFLSv3HccCMTZvYldRRXDmqrFEyZDvZa8LWe2A6pf3YQ6g3G/RqMW/kok2MpK0vss=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlou5+3p+QVf5jUS9kZyeB1lGtwotRapAUYYPeDpn4bmPYMyOy
	dzsexXqtlThEPhdSUn2eMeqW8Hrd+1Qjk/LSQlywfDEKAZhN3I45fqnjoKNsjVi2snax/fcZJfv
	XD2p/5PLYXsWJK65hKqOKWnc8WcxHRLqXsZ0ofICaifIbGSfh75Q2Iw==
X-Received: by 2002:a05:6402:278c:b0:5c0:a8c0:3960 with SMTP id 4fb4d7f45d1cf-5c21ed31e90mr2671862a12.4.1724942526558;
        Thu, 29 Aug 2024 07:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3Qxba/RJ3kvosiIqlnL9lYOS9AAEMC71M0lm83PE0iqKT0MhcHZDjA9fDLzTLomsiWqg1kg==
X-Received: by 2002:a05:6402:278c:b0:5c0:a8c0:3960 with SMTP id 4fb4d7f45d1cf-5c21ed31e90mr2671689a12.4.1724942525532;
        Thu, 29 Aug 2024 07:42:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:f3dd:4b1c:bb80:a038:2df3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989195e6bsm86599066b.99.2024.08.29.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:42:05 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:41:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Philipp Stanner <pstanner@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
Message-ID: <20240829104124-mutt-send-email-mst@kernel.org>
References: <20240829141844.39064-1-pstanner@redhat.com>
 <20240829141844.39064-7-pstanner@redhat.com>
 <20240829102320-mutt-send-email-mst@kernel.org>
 <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>

On Thu, Aug 29, 2024 at 05:26:39PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2024 at 5:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
> > > pcim_iomap_regions() is placed on the stack. Neither
> > > pcim_iomap_regions() nor the functions it calls copy that string.
> > >
> > > Should the string later ever be used, this, consequently, causes
> > > undefined behavior since the stack frame will by then have disappeared.
> > >
> > > Fix the bug by allocating the strings on the heap through
> > > devm_kasprintf().
> > >
> > > Cc: stable@vger.kernel.org    # v6.3
> > > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> > > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> >
> > Post this separately, so I can apply?
> 
> Don't you use `b4`? With it it as simple as
> 
>   b4 am -P 6 $MSG_ID_OF_THIS_SERIES
> 
> -- 
> With Best Regards,
> Andy Shevchenko

I can do all kind of things, but if it's posted as part of a patchset,
it is not clear to me this has been tested outside of the patchset.

-- 
MST


