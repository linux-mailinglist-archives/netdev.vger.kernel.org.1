Return-Path: <netdev+bounces-121785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763F95E952
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2421C20F7A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A5884A31;
	Mon, 26 Aug 2024 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRVsNonU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03C8286F
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655332; cv=none; b=fSjODYi/waD0v5o2yrLGwOfxl6NFrhmUekXiJQf99HYBligC3HcNZuYFELLu+BHu6MIYKeVrmWVXBwgvZ01fF7oGpjo5Nm/an7JymkQ8e5KZMKfdUwaZXgCEvePwXyafYaMIeCLuy8O51v5wSekECBA+L3XJbBMRX/8qmStIEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655332; c=relaxed/simple;
	bh=QYLmQ33xF9IhHkHlckYjtaDgAb8yn61cdSbD9bi4KjQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HRp7+vE5K58irSIHmIoC4uWUS+l6JJBG4Xa1NyORksdH1RDW6wjfmG7O/p4PMbTc+dP9Add9D0FvQWzXr3qk2UZopkuH/LNJlHiiNIUwokxF4/jC0uHv131pbuhAz0PJlg0kxCpmomk+mPADy1hwsUEE1AOeTeWFp+FevDxdhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRVsNonU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724655330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2z2TGSU/AHVRPl6zHGllpDM2MIUry+mfdVEnD5XzqM=;
	b=VRVsNonUPf69gF9USxt58NZ7PWjxfnXLzRkIKtJZ71Ne8E6JRbfdZrtBFEQyVeUljX0pe+
	zIphCoMpeynUbCvC1vcd0G0BRmrnDge0+yuHCq5NWNTsXhUNLlsa0XJR/YRdTbgE9mvSxe
	9tK1YH4To5BVfpB2KNeB0xzEewFGoZM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-OqUOeWE8Neu8eXr7td22XA-1; Mon, 26 Aug 2024 02:55:27 -0400
X-MC-Unique: OqUOeWE8Neu8eXr7td22XA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280f233115so37743635e9.2
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 23:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724655326; x=1725260126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2z2TGSU/AHVRPl6zHGllpDM2MIUry+mfdVEnD5XzqM=;
        b=LbqF3dankJ1i8cN2Dam/QEcyj1sFDhlEamJ4M9bHeRpiYWeZS+IzQMGr8SmriQUykl
         nnDC96uDrlciPl9PxsLdW0orRBErounmzWJXNWUie7DohG+t0EQ0w0t+BRm7rKDjrgv6
         azoqXonry6aeuncR/VDdxTYOzBDA/jrlu+9iH9bv+M4NsCUvzZuKj0ZQ/Z/OAEzu+amA
         LL5zKGok13Okj1UgXbDi/c/d1fv27UTTx6mjVyTqUL+QcEPQ8NHVG6zpHcPUDcM4tig6
         sooTUWxDof87bpjhitLGIBrwxUf1F/A+3raf51l7XMKNoUylTcAaS/Ap0ciwXaOhLMtc
         O3fg==
X-Forwarded-Encrypted: i=1; AJvYcCXGGbgKj2LDr7vHeXFa/ayWOK0O6JCTrsRqyLdTNuZWEmH9DZucCUr0bFGakSIQSUrDOXm7oVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZy2sgamQqTb1zo1eBm4KFvu36754uyH7965ua2i2r6qMb8Nb
	H4TFxTFPd1VI6LwOSiPtH3wnka3DJRlBC60i+di+ces8gQMp5gAIRY5u+CUZf6xzAlY4VuHKCz1
	Jn2KGV0yjzMgbFdJUj4/qtDn7fsvIeRgjxJb3QuHfnJFk0NKjdOoF1w==
X-Received: by 2002:a05:600c:3b05:b0:428:1d27:f3db with SMTP id 5b1f17b1804b1-42b8925903bmr48419435e9.35.1724655326194;
        Sun, 25 Aug 2024 23:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDbFRllMEQMy18KUHdwX+H4HgEvRwxNEXxmAF22JEUYmhjpbjXAt/FXNy3VJHqD5ffhjLW9Q==
X-Received: by 2002:a05:600c:3b05:b0:428:1d27:f3db with SMTP id 5b1f17b1804b1-42b8925903bmr48419155e9.35.1724655325664;
        Sun, 25 Aug 2024 23:55:25 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef81777sm178404725e9.27.2024.08.25.23.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 23:55:25 -0700 (PDT)
Message-ID: <23f1b79be57f1a4d6ce0806fa149d687c2c6d275.camel@redhat.com>
Subject: Re: [PATCH v3 7/9] vdpa: solidrun: Fix UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alexandre.torgue@foss.st.com, alvaro.karsz@solid-run.com,
 andy@kernel.org,  axboe@kernel.dk, bhelgaas@google.com, brgl@bgdev.pl,
 broonie@kernel.org,  corbet@lwn.net, davem@davemloft.net,
 dlechner@baylibre.com, dlemoal@kernel.org,  edumazet@google.com,
 eperezma@redhat.com, hao.wu@intel.com, hare@suse.de,  jasowang@redhat.com,
 joabreu@synopsys.com, kch@nvidia.com, kuba@kernel.org, 
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com, 
 mdf@kernel.org, mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
 richardcochran@gmail.com, stable@vger.kernel.org, trix@redhat.com, 
 u.kleine-koenig@pengutronix.de, virtualization@lists.linux.dev, 
 xuanzhuo@linux.alibaba.com, yilun.xu@intel.com
Date: Mon, 26 Aug 2024 08:55:22 +0200
In-Reply-To: <81de3898-9af7-4ad1-80ef-68d1f60d4c28@wanadoo.fr>
References: <20240822134744.44919-1-pstanner@redhat.com>
	 <20240822134744.44919-8-pstanner@redhat.com>
	 <81de3898-9af7-4ad1-80ef-68d1f60d4c28@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 16:34 +0200, Christophe JAILLET wrote:
> Le 22/08/2024 =C3=A0 15:47, Philipp Stanner a =C3=A9crit=C2=A0:
> > In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed
> > to
> > pcim_iomap_regions() is placed on the stack. Neither
> > pcim_iomap_regions() nor the functions it calls copy that string.
> >=20
> > Should the string later ever be used, this, consequently, causes
> > undefined behavior since the stack frame will by then have
> > disappeared.
> >=20
> > Fix the bug by allocating the strings on the heap through
> > devm_kasprintf().
> >=20
> > Cc: stable@vger.kernel.org	# v6.3
> > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Closes:
> > https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanado=
o.fr/
> > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0 drivers/vdpa/solidrun/snet_main.c | 13 +++++++++----
> > =C2=A0 1 file changed, 9 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index 99428a04068d..67235f6190ef 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -555,7 +555,7 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > =C2=A0=20
> > =C2=A0 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > =C2=A0 {
> > -	char name[50];
> > +	char *name;
> > =C2=A0=C2=A0	int ret, i, mask =3D 0;
> > =C2=A0=C2=A0	/* We don't know which BAR will be used to communicate..
> > =C2=A0=C2=A0	 * We will map every bar with len > 0.
> > @@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev
> > *pdev, struct psnet *psnet)
> > =C2=A0=C2=A0		return -ENODEV;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	snprintf(name, sizeof(name), "psnet[%s]-bars",
> > pci_name(pdev));
> > +	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > bars", pci_name(pdev));
> > +	if (!name)
> > +		return -ENOMEM;
> > +
> > =C2=A0=C2=A0	ret =3D pcim_iomap_regions(pdev, mask, name);
> > =C2=A0=C2=A0	if (ret) {
> > =C2=A0=C2=A0		SNET_ERR(pdev, "Failed to request and map PCI
> > BARs\n");
> > @@ -590,10 +593,12 @@ static int psnet_open_pf_bar(struct pci_dev
> > *pdev, struct psnet *psnet)
> > =C2=A0=20
> > =C2=A0 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet
> > *snet)
> > =C2=A0 {
> > -	char name[50];
> > +	char *name;
> > =C2=A0=C2=A0	int ret;
> > =C2=A0=20
> > -	snprintf(name, sizeof(name), "snet[%s]-bar",
> > pci_name(pdev));
> > +	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > bars", pci_name(pdev));
>=20
> s/psnet/snet/

sharp eyes ;)

Thx,
P.

>=20
> > +	if (!name)
> > +		return -ENOMEM;
> > =C2=A0=C2=A0	/* Request and map BAR */
> > =C2=A0=C2=A0	ret =3D pcim_iomap_regions(pdev, BIT(snet->psnet-
> > >cfg.vf_bar), name);
> > =C2=A0=C2=A0	if (ret) {
>=20


