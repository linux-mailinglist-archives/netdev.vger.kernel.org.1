Return-Path: <netdev+bounces-122632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191096201F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF211F25C6B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73115853C;
	Wed, 28 Aug 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh5WxIG1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D70157A46
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828229; cv=none; b=soW8duetMwNQ3bvhuGIvfiH+pkqvL8YbVBXzqZIEjIS7odsMa3UUGbDXt1AV8WJbYLOB10VbTawdlxRs0b70hYCx/4xmwLuJCUB/tvNcrIcW1baacu/uoN3LyZD6QYEh5pmimMvOO3GwzVSaSWJxAWC//VUzh2IxqpEfYhdZkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828229; c=relaxed/simple;
	bh=izbJSm/dMAeJoBvmjaTI3BgmtWSDjWSFXhQ4qPbupAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1rI37ByJrC2COdoXembyXWRIlr0NdIvLVCb6fA1uB5Y1Z3iL7bUyxLon6UCDLAQe2JGpuQPHgqh/2nWW/cNjtXR9WuOnnVw5p/zWTed3uJWFd8OXDWxn3MzOzPJNfX4QqhWKN8LPOpwxWxx+Oe1dAo5kzvI6Ruj0j7AWG4MV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oh5WxIG1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724828226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gw3wvVaoCeBr408n49O4Pdi63HLhXvtdsmY5OFuBV+k=;
	b=Oh5WxIG1vb3ih9huGrOwiYtRDOJQAZAi9cBU+/5W9iZUHkHGFXpzZ3VKnBisA/yvsgVofe
	89hd8LXI9ZET3Ut2g37jJjd3BIVOJB5AyMNKcTCzZeCroI/3NXx1QQ81rVL+Bde6pT1crp
	Rl+H+EsAAhcDF6jM6Tpgw4tzovWHTKw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-0KUA82HhM-KNhIqGn-HLkg-1; Wed, 28 Aug 2024 02:57:04 -0400
X-MC-Unique: 0KUA82HhM-KNhIqGn-HLkg-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e11741a4c92so8807240276.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 23:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724828224; x=1725433024;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gw3wvVaoCeBr408n49O4Pdi63HLhXvtdsmY5OFuBV+k=;
        b=QoPZRxhITnMhLvCDUHishk3r91iVUxv+BCGHAoU3cXRydJ6rsjAE0BXfM5nvzjoRWz
         oJiGGNoV+3DGeRJlZzEuQnlmxixAMmGeMNnQmuDun2GXKd7rumKC2FJVWevcilMj8AIQ
         vgcgp8oIOXxA9DxxjwCo5tlDFZ1z2e7TD3vsdQ3U3UliIqNVHxB4O6jebrGLBokboKWj
         ivueV0uaVVQG0kCSOPhZP/Ri+yqFDnT6HTZJiydTHelKqjktkNY7OJQPYsP+m5gi6Lab
         pITzcrEsTVEisV1gCqregCIXW1/1cvS8PaIqMWnP5n1l2/eZpT5R2YpdIm6sWsUW7ORG
         YcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYkFvHP//NUDYdeb/plz+iAQyah2CTHfUHEFWdnOeeucG9Ftyt3ZvoYwZpqfy7jw+2V5hqlYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+MkdY3HwpfiRGqxDrfrTUXcMaXYyPhgCG9NMwLgMgSjAmuRx
	zVQz252X93FvwDg+VnbYuVgGk44oVL6A1tw0sCijUfjRcEG5Qnl+4jmVVLcXCBblmiwwKvD2quV
	AsI+4koiAGTzkfeEYERVoERxFtJngxTT00bHIQnxxFINLGWKMxluPsQ==
X-Received: by 2002:a05:6902:993:b0:e16:6feb:e615 with SMTP id 3f1490d57ef6-e17a8e65ed9mr21826836276.48.1724828224118;
        Tue, 27 Aug 2024 23:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw9crM9PEJyMZU6PUA+WUeaokDcVujBrHJSlrQ83Ph8OhPg7rMBpJSwVwrxe8IOU4D66or7Q==
X-Received: by 2002:a05:6902:993:b0:e16:6feb:e615 with SMTP id 3f1490d57ef6-e17a8e65ed9mr21826809276.48.1724828223793;
        Tue, 27 Aug 2024 23:57:03 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0f4816sm60006381cf.44.2024.08.27.23.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:57:03 -0700 (PDT)
Message-ID: <fb3d77e09dd10995616eed5a490ab9339b3350e4.camel@redhat.com>
Subject: Re: [PATCH v4 5/7] ethernet: cavium: Replace deprecated PCI
 functions
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Wed, 28 Aug 2024 08:56:58 +0200
In-Reply-To: <20240827185616.45094-6-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
	 <20240827185616.45094-6-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 20:56 +0200, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>=20
> Furthermore, the driver contains an unneeded call to
> pcim_iounmap_regions() in its probe() function's error unwind path.
>=20
> Replace the deprecated PCI functions with pcim_iomap_region().
>=20
> Remove the unnecessary call to pcim_iounmap_regions().
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0drivers/net/ethernet/cavium/common/cavium_ptp.c | 6 ++----
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c
> b/drivers/net/ethernet/cavium/common/cavium_ptp.c
> index 9fd717b9cf69..914ccc8eaf5e 100644
> --- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
> +++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
> @@ -239,12 +239,11 @@ static int cavium_ptp_probe(struct pci_dev
> *pdev,
> =C2=A0	if (err)
> =C2=A0		goto error_free;
> =C2=A0
> -	err =3D pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO,
> pci_name(pdev));
> +	clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> pci_name(pdev));
> +	err =3D PTR_ERR_OR_ZERO(clock->reg_base);
> =C2=A0	if (err)
> =C2=A0		goto error_free;
> =C2=A0
> -	clock->reg_base =3D pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
> -
> =C2=A0	spin_lock_init(&clock->spin_lock);
> =C2=A0
> =C2=A0	cc =3D &clock->cycle_counter;
> @@ -292,7 +291,6 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
> =C2=A0	clock_cfg =3D readq(clock->reg_base + PTP_CLOCK_CFG);
> =C2=A0	clock_cfg &=3D ~PTP_CLOCK_CFG_PTP_EN;
> =C2=A0	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
> -	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);

I think I removed that by accident =E2=80=93 thinking about it, we should n=
ot
remove it since the driver later returns 0 from its probe(). So we
should not keep blocking the region.

Has to be addressed in v5.

P.

> =C2=A0
> =C2=A0error_free:
> =C2=A0	devm_kfree(dev, clock);


