Return-Path: <netdev+bounces-120107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD8958538
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84194289F00
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C8418E74B;
	Tue, 20 Aug 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4vCXuXm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E54818E05F
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151191; cv=none; b=dNT+rlgJoGSG1MFyMsC+OBa7BpVRRZ5k4FENNmW526WzLadPhCxlWt4SFsmpAY3AIFS+YZJEleN5zP3FCBM2bS/TDJU6e9XZCV/gHtpR3u31f0UPSNXR3A1SYZUM3atXRXx5e/jJ/aSb63yb7DM7PFyQkhAlBFjzwNSUsL9+wCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151191; c=relaxed/simple;
	bh=59xmhuA7Tu16YKZisndezlfAdU8Sxik/vzu7M4M8n84=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OtsKzZQC3LnaLMCpv7eBAy8ZyX1pB27x6MoB8PNerJS6V8dn9krygk9xAqsPi42Y+6jBXKMsdTOarmKTWxgDbxU9S32WGG02Kbv/ZSA6Jf/9Qsz1c0TzUn360oSOjF5xY55iXjPMI/sAiBnCRQEN5CxoEZiLaI+w1q6nkdK8f5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4vCXuXm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724151188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxNlY5XENKMDPYIPhdHxQsnynjxqCdYhZpUwRk8ipsw=;
	b=B4vCXuXm4csUI13cS6SRE36I1P86PvQh7pgKXLQS6YFaVwFeqIN0fo50e/62c7JdsAcHD9
	befsyXMghPzdsttpnYwIr3xO7Gux/cBPJfg6gqv4KvKRUO2iVz5F4oJtnbGFtBkKMO+a17
	zBinda9Os6XDZMP280l8HNFMsv/YXtM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-vrmkBcXcMsO4Hrrt3L3ZuQ-1; Tue, 20 Aug 2024 06:53:07 -0400
X-MC-Unique: vrmkBcXcMsO4Hrrt3L3ZuQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5becc2069b2so534557a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 03:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724151186; x=1724755986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxNlY5XENKMDPYIPhdHxQsnynjxqCdYhZpUwRk8ipsw=;
        b=gMkka6y7Itap8Gxl7CNGKPtQxSn8rqZzh68poGdVr9ONmqDn15tVNyIEp97mPIpdF/
         sksREEsSEG9S+j9eCW/HSZpbeKDnFufo7x4rKsKMHlHJQgRdjoGI2HvZMP1g7EA8HV/p
         DxxOeusAhqTs2y6FVGCC3X6ts1dW+BCiuZwYKluH/vI3B1eXvY1olGz3zQb5zclXU3JJ
         e/TknnmxxfHmFZOiq99U+4VAeS/pifaGmjmS/646hCIjXXwPXRfIOhFFXiDcgO+KJ9eA
         79IlCWS318DejUUODLTjJ935z3Slmm878Dy5qJ2aXRTVZDN/wUKhWq5kbXlYxz+Q0LTE
         +3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVC2Ai0H30AxzzEhLkIz5P2FRQvA8GgB+9qIB0GcX9PchTFfDf6y6mPNdth7QpcqK0EHcuG2KqnXp5NH0skd+Xpvt6VBHG0
X-Gm-Message-State: AOJu0YxQN1mvPcLeW2xFEim278Qn8GaCZSSDSfi5JgIh36ojxaPAmAs0
	3/0LNnG1ywrr8EHV1bmRcDwCWjFcoQlNGEqFA8jbFE05po3qB8dTtm701N1dC9LNhe7B7OsR3sQ
	uRZWtTpOif6vBlguqlCuclhazo0Ns5DvoY1tR85jEatpWDydbAGPWMA==
X-Received: by 2002:a17:907:3f1a:b0:a7a:9d1e:3b28 with SMTP id a640c23a62f3a-a8392a38e58mr576176466b.5.1724151185788;
        Tue, 20 Aug 2024 03:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/6EAdgReMTOuAWpstVpYQ93cEgThMtXJsIXsKn8TtmEKi0Ohh4lrRQAZ64k0Fs71t1ZO4MQ==
X-Received: by 2002:a17:907:3f1a:b0:a7a:9d1e:3b28 with SMTP id a640c23a62f3a-a8392a38e58mr576173566b.5.1724151185214;
        Tue, 20 Aug 2024 03:53:05 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfae7sm750027466b.58.2024.08.20.03.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:53:04 -0700 (PDT)
Message-ID: <d34214f18f994d255f640aefdf7f31814faa76f1.camel@redhat.com>
Subject: Re: [PATCH 7/9] ethernet: stmicro: Simplify PCI devres usage
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
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
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 12:53:03 +0200
In-Reply-To: <ZsRx6OyqHPL0ws0e@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-9-pstanner@redhat.com>
	 <ZsOO2uuGmD97Mocj@smile.fi.intel.com>
	 <ef48369d230ef1912da157e7b437040bece6b5f4.camel@redhat.com>
	 <ZsRx6OyqHPL0ws0e@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-20 at 13:37 +0300, Andy Shevchenko wrote:
> On Tue, Aug 20, 2024 at 09:52:40AM +0200, Philipp Stanner wrote:
> > On Mon, 2024-08-19 at 21:28 +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 19, 2024 at 06:51:47PM +0200, Philipp Stanner wrote:
>=20
> ...
>=20
> > > loongson_dwmac_probe()
> > >=20
> > > > +	memset(&res, 0, sizeof(res));
> > > > +	res.addr =3D pcim_iomap_region(pdev, 0, pci_name(pdev));
> > > > +	if (IS_ERR(res.addr)) {
> > > > +		ret =3D PTR_ERR(res.addr);
> > > > +		goto err_disable_device;
> > >=20
> > > It seems your series reveals issues in the error paths of
> > > .probe():s
> > > in many drivers...
> > >=20
> > > If we use pcim variant to enable device, why do we need to
> > > explicitly
> > > disable it?
> >=20
> > No.
>=20
> Can you elaborate? No issues being revealed, or no need to disable it
> explicitly, or...?

Oh, my bad, I overlooked your "why" in that question.

We do not explicitly have to disable it. It's wrong / unnecessary, as
many of the other calls you criticized in this series.

pcim_enable_device() (in pci/devres.c) calls devm_add_action(...,
pcim_disable_device,  ...), which will disable the device on driver
detach.

So the call of pci_disable_device() above is redundant. We could remove
it.

>=20
> > > > =C2=A0	}
>=20
> ...
>=20
> > > loongson_dwmac_remove()
> > >=20
> > > > =C2=A0	pci_disable_msi(pdev);
> > > > =C2=A0	pci_disable_device(pdev);
> > >=20
> > > Not sure why we need these either...
> >=20
> > It's complicated.
> >=20
> > The code uses pciM_enable_device(), but here in remove
> > pci_disable_device().
> >=20
> > pcim_enable_device() sets up a disable callback which only calls
> > pci_disable_device() if pcim_pin_device() has not been called.
> >=20
> > This code doesn't seem to call pcim_pin_device(), so I think
> > pci_disable_device() could be removed.
> >=20
> >=20
> > I definitely would not feel confident touching pci_disable_msi(),
> > though. The AFAIK biggest problem remaining in PCI devres is that
> > the
> > MSI code base implicitly calls into devres, see here [1]
>=20
> But isn't it a busyness of PCI core to call pci_disable_msi() at the
> right
> moment? Okay, I admit that there might be devices that require a
> special
> workflow WRT MSI, is this the case here?

I don't know enough about how MSI is intended to be used.

From what I've seen in the code base, pcim_setup_msi_release() does
register a devres callback that will indeed call pci_disable_msi()
after some intermediate calls.

But in my honest opinion, that code is _very_ broken. I was thinking
about how we might clean it up, but couldn't come up with an idea yet.

Only after the code in pci/msi/ has been cleanly separated from
implicit devres I myself would start touching function calls related to
MSI.

That being said, I suspect that one can remove pci_disable_msi() in the
line above. But the risk-benefit-ratio doesn't pay off for me.

P.


>=20
> > [1]
> > https://lore.kernel.org/all/ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.ca=
mel@redhat.com/
>=20


