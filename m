Return-Path: <netdev+bounces-121924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8195F460
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905D71F223AC
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA5F18D65B;
	Mon, 26 Aug 2024 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA4lXiLw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76A1553A3
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683874; cv=none; b=B8Eyalfc3VpAD9KnoKIS2sKFbQEMf88WmNj8nBFeKRFG4FVT5y1Xe36oGlKLalfiB1iQEGTLiM8DqtgTAVo1qCo/DwfcUaAEjD+z9aCl9aBohL9nU0p3EJLrxSTgYPNlteYMhOVOaAIRQa1eVSpThX80T6f/HNCVbzr5bu4qTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683874; c=relaxed/simple;
	bh=gejqF3lxPDzVKaKWaPqTWU5CZhdrvtg8FR6CXRKXq10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZTOhFM6niFVUb8gndkySFQ7mHAdTH8acRsKHwb1fdwPlVkfu4bYbwzw8s29dt21sX55rv4w1ZoM13as8GsQj1sjR0fnYhV2Xi79wuNu2CrA86l3jsKi+nibbOx7SQ7IOQBkdkIMnWpXsOtXelRiiAnC9UtXNUT0frBi5Qe4Pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bA4lXiLw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724683872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygoQZIsbD2qBAAmAvknxBdRGvmvE0QFAtlIfXcqGyiA=;
	b=bA4lXiLwLbxXH+chWnqogx2r3zeNyU2BAG7EXKp0TAbr+VgsMWZrBFK2X/vjyQYNAordpb
	CTrrECbjWibCTvnGfb9rOHN71bKIAo0heafCSIVLe3Rv8fGO0xWQ0+w+7D28s7wqXVj62g
	mQeEYjSsXNqTmBUSuwenOPOEb5sO+zE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-RTu9e3YBPOq9OfVLi56qtg-1; Mon, 26 Aug 2024 10:51:11 -0400
X-MC-Unique: RTu9e3YBPOq9OfVLi56qtg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-371ab0c02e0so3683071f8f.3
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 07:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724683870; x=1725288670;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygoQZIsbD2qBAAmAvknxBdRGvmvE0QFAtlIfXcqGyiA=;
        b=KGVn/UmOo3wi+Xcb9TrjBzKryet9B3jc5SfGFOXcDpgSGj/vj52v6xV+8pvSE/ZDkX
         gksF55zDGZJQeRebFPNxRLBAcrC17M5As3dWPwBMXNgGpbmRriM8Gzn7CJQ7nxkLb4qp
         EQVSNQ0MPrvUQPBrNYhhHZvjOhgLusqDe5+LDqsX6ave7BfN5CbTxpb1EVMT3k3ykKeQ
         GN09on7Rp5rsXLKutNrcgUWaWejKzk2ihCnH11/x56i1zyDkPsDHGpDmvsrjEVqwR/uX
         Zr/RtbEy554aFZdX8SpBf+zD7vEp+a2RRYwyrm0DmWJI+NmxrZznb0KNG3vW15LLZJ+l
         WTiA==
X-Forwarded-Encrypted: i=1; AJvYcCUv5cefmmbMQZviHUGq2s7En0kBCTxKeHiRVRYfNAsmGxTNH5VPScS35HgnILVAausv8aTWsg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKY02O/+UbxWPHkatXWK2igJF6kPLelNNCrGH0gNrGYR3ojaF
	eY50OeRTopI4VEaoFJWLFnurxcmSPDANQTeQFs+VjJvdOWiIscUOjEwRWUFAk8GcPeBFpPKU23H
	z4HNGV0SqeVoey6OELQw84wPgwCsFNRcJ4rLuw5TW0SrThx6Xtmxqdg==
X-Received: by 2002:a05:6000:18a4:b0:369:b842:5065 with SMTP id ffacd0b85a97d-373118c853bmr9315241f8f.41.1724683869833;
        Mon, 26 Aug 2024 07:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzcbeZGAiG9pR7gwgPFjZ9tQkwyQH6hKqQkC/ZviQjFl3Zuqsn+yKqro2WkBtRVRH4FkIJWQ==
X-Received: by 2002:a05:6000:18a4:b0:369:b842:5065 with SMTP id ffacd0b85a97d-373118c853bmr9315196f8f.41.1724683869319;
        Mon, 26 Aug 2024 07:51:09 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373082096bbsm10889215f8f.89.2024.08.26.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:51:08 -0700 (PDT)
Message-ID: <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
Subject: Re: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI
 functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Damien Le
 Moal <dlemoal@kernel.org>,  Hannes Reinecke <hare@suse.de>, Chaitanya
 Kulkarni <kch@nvidia.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Mon, 26 Aug 2024 16:51:07 +0200
In-Reply-To: <ZsdO2q8uD829hP-X@smile.fi.intel.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
	 <20240822134744.44919-6-pstanner@redhat.com>
	 <ZsdO2q8uD829hP-X@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 17:44 +0300, Andy Shevchenko wrote:
> On Thu, Aug 22, 2024 at 03:47:37PM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with the function pcim_iomap_region().
>=20
> ...
>=20
> > -	err =3D pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO,
> > pci_name(pdev));
> > -	if (err)
> > +	clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> > pci_name(pdev));
> > +	if (IS_ERR(clock->reg_base)) {
> > +		err =3D PTR_ERR(clock->reg_base);
> > =C2=A0		goto error_free;
> > -
> > -	clock->reg_base =3D pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
> > +	}
>=20
> Perhaps
>=20
> 	clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> pci_name(pdev));
> 	err =3D PTR_ERR_OR_ZERO(clock->reg_base);
> 	if (err)
> 		goto error_free;
>=20
> This will make your patch smaller and neater.
>=20
> P.S. Do you use --histogram diff algo when preparing patches?

So far not.
Should one do that?

P.


>=20


