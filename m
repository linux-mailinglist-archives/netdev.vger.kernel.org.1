Return-Path: <netdev+bounces-121933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4189895F597
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E538B2829A0
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B91946C2;
	Mon, 26 Aug 2024 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3FIzBZv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D919412F
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687529; cv=none; b=qu1Yxf0W43dA54ojb08aliM0xPVISi3frMvINiAJ5atdP/v2w1u04J8Fs2CQ2q34zNnu0Fx7EvJ3IvPzlIUlO4Ny6/2Aw1vH70lcivtQcVm5YsET7+E2Jtg6UoptU5I+DNwCnU5KOCtFc9D5f6vMIuMsQige2kmUxHh+1wifVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687529; c=relaxed/simple;
	bh=Dwazc+e0kXeS2xTQ712+0BIKFANt7k7hBlcLvCAFWPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hCPzmVfJIL/QnfNi++gyL2izzw2wUv9805Yo8CqpWABkQ1omo8LDAcK8P9pQSBVWsOMGl210p2RSwfvkVQBoHlcdY+Kr8VjX9UE6QgqLQUxi4Xi7nF/yOoMRdo3slYm2HdtIMPsxoU4MG0tf5zeZjRL1Gqh/MHAx62fYGfghWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3FIzBZv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724687526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dwazc+e0kXeS2xTQ712+0BIKFANt7k7hBlcLvCAFWPU=;
	b=e3FIzBZv0Hz32L1TuWGAEqcXh08IH0x7Lx5jYTzEncSKtvkEHFz/C8+6Qv9ZDgaKJXX6dV
	DPNVfAIFDexax9KOZNnjrhRSuck18vVR2tiODw3gCeoRaDGftiQSTnnw6/isBH2mvkQsjE
	/DjFLCEo3GPWtDMgObc1wTfG3WUS+xM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-Ni_PO5QrPdymBZHScz2LQQ-1; Mon, 26 Aug 2024 11:52:05 -0400
X-MC-Unique: Ni_PO5QrPdymBZHScz2LQQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4282164fcbcso42864695e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 08:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724687524; x=1725292324;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dwazc+e0kXeS2xTQ712+0BIKFANt7k7hBlcLvCAFWPU=;
        b=R7Ta5QzdekvDnhERUgE741Aw1ImHaK1GqScXlSKjNaOF+5/8FNkxFHQ4lu+9ba+FPw
         DdUo7DmaO9pIGz84DMjL3TqreOnOs63UKi58qjpi7p8xTb5WfkvY4VR8WCqJ4/6ZR1RV
         P3z5CRVoEfHwyddlZlm/IUJ2OYHhOiL3RMmQoJVOrhWoAx06Skm9s4FxFfzY+ronCBjY
         EeSrjPcwKd5hKwzFfjcAsasf7Gkqh89ij/VQ5yMQTcyZ+hPQ+QTmfV7UGHmd4eLnS0Au
         QqhEmWEPl0hu2ehJgbR82gZBwEAqRRyQsvYJ2hY+pxO3uIWqePGbm9aDT5HtnGzA8dHd
         N31g==
X-Forwarded-Encrypted: i=1; AJvYcCVlkHTsEvDzkRbsYKRX6SQyJE0LxnGjGEJexqVatFTHXWLJX7tbAv7w8+4GXBeokvC/2DsgSRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5V3s1nHd2snqBrOdJrYY1LAhOcXKfwQMPTHp46BUeH9BlufE
	FGn7AuB/X1maivtU3CoEJk2UzRjGMdcwHxDdGIJjlZ7Vu/CXmxbgI6A9utmvf4udIdgasAMDwgy
	GIle97Ix2Ql+8XeA4H/u4/sCm5nhj5WET5pwzPYjrVTG5wZVJoK+W1A==
X-Received: by 2002:adf:e44b:0:b0:360:7c4b:58c3 with SMTP id ffacd0b85a97d-3748c835e08mr49203f8f.54.1724687524279;
        Mon, 26 Aug 2024 08:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxAzHOXHhnfnYaxqHhgL/uz7vF7Nw5k64KjkexckDk+9QWCj+MHZcvnBNc7cGqudRMU7r7fA==
X-Received: by 2002:adf:e44b:0:b0:360:7c4b:58c3 with SMTP id ffacd0b85a97d-3748c835e08mr49174f8f.54.1724687523730;
        Mon, 26 Aug 2024 08:52:03 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm11021638f8f.44.2024.08.26.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:52:02 -0700 (PDT)
Message-ID: <f2d6345a8a684f62035108d74938ec0b2e162019.camel@redhat.com>
Subject: Re: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI
 functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Alvaro
 Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Damien Le Moal <dlemoal@kernel.org>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org,  linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Mon, 26 Aug 2024 17:52:00 +0200
In-Reply-To: <CAHp75VfKS_PWer2hEH8x0qgBUEPx05p8BA=c0UirAWjg0SaLeA@mail.gmail.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
	 <20240822134744.44919-6-pstanner@redhat.com>
	 <ZsdO2q8uD829hP-X@smile.fi.intel.com>
	 <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
	 <CAHp75VfKS_PWer2hEH8x0qgBUEPx05p8BA=c0UirAWjg0SaLeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-26 at 18:41 +0300, Andy Shevchenko wrote:
> On Mon, Aug 26, 2024 at 5:51=E2=80=AFPM Philipp Stanner <pstanner@redhat.=
com>
> wrote:
> > On Thu, 2024-08-22 at 17:44 +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 22, 2024 at 03:47:37PM +0200, Philipp Stanner wrote:
>=20
> ...
>=20
> > > > -=C2=A0=C2=A0 err =3D pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO,
> > > > pci_name(pdev));
> > > > -=C2=A0=C2=A0 if (err)
> > > > +=C2=A0=C2=A0 clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_B=
AR_NO,
> > > > pci_name(pdev));
> > > > +=C2=A0=C2=A0 if (IS_ERR(clock->reg_base)) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =
=3D PTR_ERR(clock->reg_base);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
goto error_free;
> > > > -
> > > > -=C2=A0=C2=A0 clock->reg_base =3D pcim_iomap_table(pdev)[PCI_PTP_BA=
R_NO];
> > > > +=C2=A0=C2=A0 }
> > >=20
> > > Perhaps
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock->reg_base =3D pcim_iomap_region(=
pdev, PCI_PTP_BAR_NO,
> > > pci_name(pdev));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D PTR_ERR_OR_ZERO(clock->reg_bas=
e);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto error_free;
> > >=20
> > > This will make your patch smaller and neater.
> > >=20
> > > P.S. Do you use --histogram diff algo when preparing patches?
> >=20
> > So far not.
> > Should one do that?
>=20
> Id doesn't alter your code, it's in addition to what I suggested, but
> as Linus shared that there is no reason to avoid using --histogram
> not
> only in Linux kernel, but in general as it produces more
> human-readable diff:s.

If the Boss says so, one can surely do that \o/

Though if it has 0 disadvantages I'd propose proposing to the git-devs
to make it the default.


P.

>=20


