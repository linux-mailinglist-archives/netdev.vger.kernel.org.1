Return-Path: <netdev+bounces-134351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ADC998E97
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B485B2671F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E661CEABC;
	Thu, 10 Oct 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQ7K9TYT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EE1CDFB6
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582204; cv=none; b=bMhR0cNlsMZOlGznhhOoxp8znPdDV8YKjOEjwz15Q4ptTks5rnIvhi5cxyD4D5hWbBVdkiK02TcDV5q3/kJsW/ve7Kv2X+HIUFwua9alMyz4/SwUZvG/Y90y87XnJWqghqprlGRuzA3fnxgT0ZbL4d2kmdEAayejdGWXsDYfu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582204; c=relaxed/simple;
	bh=VkW56jTE0kaiaQu6sdNA9gReyPzVF9DBS+DAGqaddq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzMCIVHtctwhtTnZrAhlaqQp8eD/gz7Fco46a6JjKpeynjrgEO6nGJGMBNOcim8Spkq4jEgp9NHtI/PRQxDC0wuaGWtZBYcYt5D6ycMhOgY9FLoB6SRcINSq4qBQalA3ocllTZB8g963MWOawnzLzMip6qXqzU9cMObobI1QxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQ7K9TYT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728582201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irpjS10coO2t0wwvE3gFasz0R9ftgsaNlPSsljy/7YU=;
	b=CQ7K9TYTvLhSVqE4+9IDIoSp2u4pgVhGiXHJKIJ4K4VPClEaeIkq3zS3INt4aitZs4de5p
	RGSRq9zC/TUg1j+J6+6M0dPoet5fXUUxPY4JEgvGIeRrtHR303ATbQfCK7/tguXxdZqEfR
	uDwo9W4TDVAMNdWBOfHwc5k+KeI/23c=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-rkUyz4IoPkuh0dOaIAaVHQ-1; Thu, 10 Oct 2024 13:43:18 -0400
X-MC-Unique: rkUyz4IoPkuh0dOaIAaVHQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8354382ee26so21268139f.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582198; x=1729186998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irpjS10coO2t0wwvE3gFasz0R9ftgsaNlPSsljy/7YU=;
        b=oVJRDD/zxSi1PNQK96EwviQMco/gTPW8+MCXMZdieXTOIN9w/K2g4y+T8dHLpq4OWy
         +eUmn+odZyEL61Ej/ubvXL2eAvy+m9z5Vkhb+uxi5I375UEEoKTcSyVWs6pRNSWiswYg
         jE6fre3pHkJeuCbBAAVHVKPfaF3TRrWusWcOJ72mlHOJMoljWLfMo8izzd90LvhHHERK
         UrK1bCf95kHSej8Rg4RD6UFM/MBRB5VJfmj4k5o930M1JiUBM3nUpvD6icJaNAKheFCI
         sSja7GrDQW2/AmOp8tM/fDl9JbndKOBQLwxAXg+l/YgzLajrs0j21hTDIuYHyDz1Oyyu
         8vJA==
X-Forwarded-Encrypted: i=1; AJvYcCWoAtOSgopKi/uaHJKSlOqWLo1L5B7vIy9t+VD5yqE+KEWpxYuWN6X66A7uYgU0jOysmEgqnfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB69UfRDwi8ABGX6teTHlcjSkcfMlNRTJLkZpHBMmz1ChgCgbn
	Dhybr94e1qAtyze2/DxmkenbrnDNzoRm8MEL3OIXOJoj5Onk2bbTJehShnm+FPiLPKe/9f57WUU
	Ig9/1H6IrpWjSmiZxKpIXKS8GM9SnQr6XLHWkrVL02oIFboam9iQJrg==
X-Received: by 2002:a05:6e02:1c46:b0:3a0:a1ab:7ce6 with SMTP id e9e14a558f8ab-3a397cdda26mr18750745ab.1.1728582197749;
        Thu, 10 Oct 2024 10:43:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaLJzsYWJH/NUMC+IMyT+j/CP16HRwxWkCBGHxtTft8rw7tBisUdCTh60bMs+LHrYbLbadmw==
X-Received: by 2002:a05:6e02:1c46:b0:3a0:a1ab:7ce6 with SMTP id e9e14a558f8ab-3a397cdda26mr18750415ab.1.1728582197304;
        Thu, 10 Oct 2024 10:43:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadaa9f67sm322910173.153.2024.10.10.10.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:43:16 -0700 (PDT)
Date: Thu, 10 Oct 2024 11:43:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Sergey Shtylyov
 <s.shtylyov@omp.ru>, Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri
 Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Dubov <oakad@yahoo.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>, Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, Chen
 Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mostafa Saleh
 <smostafa@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Soumya Negi <soumya.negi97@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yi
 Liu <yi.l.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>,
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>, Marek
 =?UTF-8?B?TWFyY3p5a293c2tpLUfDs3JlY2tp?= <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>, Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Rui Salvaterra <rsalvaterra@gmail.com>,
 Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-staging@lists.linux.dev, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH 13/13] Remove devres from pci_intx()
Message-ID: <20241010114314.296db535.alex.williamson@redhat.com>
In-Reply-To: <f42bb5de4c9aca307a3431dd15ace4c9cade1cb9.camel@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	<20241009083519.10088-14-pstanner@redhat.com>
	<7f624c83-115b-4045-b068-0813a18c8200@stanley.mountain>
	<f42bb5de4c9aca307a3431dd15ace4c9cade1cb9.camel@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2024 11:11:36 +0200
Philipp Stanner <pstanner@redhat.com> wrote:

> On Thu, 2024-10-10 at 11:50 +0300, Dan Carpenter wrote:
> > On Wed, Oct 09, 2024 at 10:35:19AM +0200, Philipp Stanner wrote: =20
> > > pci_intx() is a hybrid function which can sometimes be managed
> > > through
> > > devres. This hybrid nature is undesirable.
> > >=20
> > > Since all users of pci_intx() have by now been ported either to
> > > always-managed pcim_intx() or never-managed pci_intx_unmanaged(),
> > > the
> > > devres functionality can be removed from pci_intx().
> > >=20
> > > Consequently, pci_intx_unmanaged() is now redundant, because
> > > pci_intx()
> > > itself is now unmanaged.
> > >=20
> > > Remove the devres functionality from pci_intx(). Remove
> > > pci_intx_unmanaged().
> > > Have all users of pci_intx_unmanaged() call pci_intx().
> > >=20
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com> =20
> >=20
> > I don't like when we change a function like this but it still
> > compiles fine.
> > If someone is working on a driver and hasn't pushed it yet, then it's
> > probably
> > supposed to be using the new pcim_intx() but they won't discover that
> > until they
> > detect the leaks at runtime. =20
>=20
> There wouldn't be any *leaks*, it's just that the INTx state would not
> automatically be restored. BTW the official documentation in its
> current state does not hint at pci_intx() doing anything automatically,
> but rather actively marks it as deprecated.
>=20
> But you are right that a hypothetical new driver and OOT drivers could
> experience bugs through this change.
>=20
> >=20
> > Why not leave the pci_intx_unmanaged() name.=C2=A0 It's ugly and that w=
ill
> > discorage
> > people from introducing new uses. =20
>=20
> I'd be OK with that. Then we'd have to remove pci_intx() as it has new
> users anymore.
>=20
> Either way should be fine and keep the behavior for existing drivers
> identical.
>=20
> I think Bjorn should express a preference

FWIW, I think pcim_intx() and pci_intx() align better to our naming
convention for devres interfaces.  Would it be sufficient if pci_intx()
triggered a WARN_ON if called for a pci_is_managed() device?  Thanks,

Alex


