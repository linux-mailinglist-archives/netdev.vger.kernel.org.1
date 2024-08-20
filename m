Return-Path: <netdev+bounces-120037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E8958006
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8831F25217
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6DD189BBD;
	Tue, 20 Aug 2024 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR22vrcr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF351189B99
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139623; cv=none; b=k/vswyAWuUfrjYZ1LyeC51jC+LJ7vPe5kDH2AyxJe2E7oFqcRNTydPX0TCE6+gebKHlBTiOoWbrKI1KsfWbiEZWEU6Gqcb9Wg7LVrEL9hfV3UEY2eRQpLK+Dc1NvJVILWAkCwe2u4iJpy1zkljnWw5733tXi9LgshbgulMpwRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139623; c=relaxed/simple;
	bh=aYkN9CyGqEIYAw2LdxUgvvFJ/GqgBaxXltVMI7LxkmY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PU51j59Zfkl6fh8EBeqhU0xcBt96kzEdRbbSOsrTT11fWV5ocb4JcfKxtuTGq6MznoXOuilABPLsjD6wvf2doYddnT7wYyiNw9BPLnkzr7h3SwLiZssRHbzqbK8xbZIAIdCrI7tW21RFkcEYbz4A3wxM/DAzQ3NgK4lgtxfrr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NR22vrcr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724139620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LI6kfa5oLV045Jmdu7a0CojUb3GQJzHs7H4OiymNEbE=;
	b=NR22vrcrL5WHiVsh3++iAVWVQMrIyTOnupWW3H/zYjlNAQAKxOcq0zEFfmmcfe7U6XBLMB
	TEHqQaS5rzK27GNU6wn62IRfjO4LEup2OKtgiX5KyNCkPD51v8duHIeAzqNDUuRDnBgEn1
	XkHWodkDOnifyB1O8go6cXmWoKjVSXQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-vgWSjCSmP4KPX8vs2GlJKw-1; Tue, 20 Aug 2024 03:40:14 -0400
X-MC-Unique: vgWSjCSmP4KPX8vs2GlJKw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3f157cd18so136461fa.0
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 00:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724139612; x=1724744412;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LI6kfa5oLV045Jmdu7a0CojUb3GQJzHs7H4OiymNEbE=;
        b=cuTDXJbD1YRrTEEUnvi3AjZ+2LECi2mfsh5NLAGenHBvDYDv3IRyzUadRdESgbjEqs
         /NcZHCMEY5yoettDTgMjW9ZRdQfx/KCayRoU2Y/h/j+s/CVEciu8GROW1IKUhADysIt5
         iILNeg7R9+43+hI7OWPIGWfroNjQxCzpb9t9ql9bMEv7xvOM4rSfJYo30gKXZ8VzCzgv
         CpDKwUQ7m0PpxcgO7rD89a75+tVCGJpMhYdgjjeA8PiyRRJJY0V0n5lKWfINbVZ+DBZe
         0E1Je32ILJyFbvnqzOGjvReIWiluLtGFaJ5wURNe34BnwELwWtdv6TzKAWXHPfiL0Qrx
         ALZA==
X-Forwarded-Encrypted: i=1; AJvYcCWom9PvBo+xgfIetd9aKcFzBWE+lZoojGBeWzp2xRs+MfOYiQto3dQEWwuiC1VAbGFO0F47cPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDueOxxn01xBO8Ffv9u5bj2kh3bZ5VzCgsq7BtkRs6qgQn4pJq
	8lsIsD5v1R9OAPPcsFE0LSiJWMJnwM+tuKdgbTupz3r54MZ2zlyVSnGiAhqev6vazqYW5ykhtiQ
	nfrULizR61R5kBJLOm+LRvfX5XTEVIcI8bXRzPVNXWMhq/jgK+m2UNQ==
X-Received: by 2002:a05:6512:3d04:b0:52f:c0dd:d168 with SMTP id 2adb3069b0e04-5331c6e53bfmr4778902e87.7.1724139612396;
        Tue, 20 Aug 2024 00:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuY9Bjt5iBWcm2YKpDyt42mNkBOnX16tyh4gc9tacJQihXtDb0AW33sxGPjl0kWgtMyZPzMQ==
X-Received: by 2002:a05:6512:3d04:b0:52f:c0dd:d168 with SMTP id 2adb3069b0e04-5331c6e53bfmr4778883e87.7.1724139611750;
        Tue, 20 Aug 2024 00:40:11 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839344fdsm726051366b.100.2024.08.20.00.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:40:11 -0700 (PDT)
Message-ID: <5d70794731198ec7bc59bd95e50a8aa81cf97c7b.camel@redhat.com>
Subject: Re: [PATCH 6/9] ethernet: cavium: Replace deprecated PCI functions
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
Date: Tue, 20 Aug 2024 09:40:09 +0200
In-Reply-To: <ZsONiNkdXGMKMbRL@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-8-pstanner@redhat.com>
	 <ZsONiNkdXGMKMbRL@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 21:23 +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2024 at 06:51:46PM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with the function pcim_iomap_region().
>=20
> ...
>=20
> cavium_ptp_probe()
>=20
> > -	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
> > +	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
> > =C2=A0
> > =C2=A0error_free:
> > =C2=A0	devm_kfree(dev, clock);
>=20
> Both are questionable. Why do we need either of them?

You seem to criticize my pcim_iounmap_region() etc. in other unwind
paths, too. I think your criticism is often justified. This driver
here, however, was the one which made me suspicious and hesitate and
removing those calls; because of the code below:


	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);

error_free:
	devm_kfree(dev, clock);

error:
	/* For `cavium_ptp_get()` we need to differentiate between the case
	 * when the core has not tried to probe this device and the case when
	 * the probe failed.  In the later case we pretend that the
	 * initialization was successful and keep the error in
	 * `dev->driver_data`.
	 */
	pci_set_drvdata(pdev, ERR_PTR(err));
	return 0;
}


So in case of an error they return 0 and do... stuff.

I don't want to touch that without someone who maintains (and, ideally,
understands) the code details what's going on here.


P.


