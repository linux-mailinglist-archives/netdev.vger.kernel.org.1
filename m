Return-Path: <netdev+bounces-82516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13EF88E702
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A4C1F2E266
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B83E158854;
	Wed, 27 Mar 2024 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igBxeSmS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E72130483
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546522; cv=none; b=lAQ9E028x0/3CD5e16+XFAc1Qjj3qup0/Hm2c5dfiIJlRJACIitio1/RqWzyb2UYi1UtTlhspyeWstLhf1xIrfPY5ZImDqbJHatOlGQcENvLItVUu6lu0egcHMpovx/RgbUmYHucAWUqfe6QvBH4joj4TdtywbsBnel8X/7tbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546522; c=relaxed/simple;
	bh=4PAqrg9dUBPe+VNGRO6PREAWBX5CjE7+Q4T65E6s8+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IRb4XQTU04nHc9kp5AWS8nAq0qP1C4WMM7yUiVMKvPT5A6rj16VEnq7T5RIeoG44hsZBLgqZ279urW8TOK5jPNq0go7SW2X7URBOvpHdWkPa6FlPET05sHHPHpbm8EPEJM1h+QYtJXFUrGuKIF8JNv1uG4GDcj9llM9NEPvJmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igBxeSmS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711546519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVrCuxpTJ0gCHZTB0QxvdcPy8C9E7vvFJM6R//tX0K4=;
	b=igBxeSmSbtod55Z+vnvZoSvOOSU5t5TcGXgWVYbLmj6ELbRpXvDzTNcUxC+EssBVoBelfY
	gdEc9cf5tQDoOnAdPrEHUikTDcGDpE41J5xx4yclfGzBLxeetv7TOnBoTVMH4gl5zenVc7
	M+gB7OEXDr9HB/RWkBvKSOLSEoTbJLo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-litk6JeXOiGqhK_742hPRw-1; Wed, 27 Mar 2024 09:35:17 -0400
X-MC-Unique: litk6JeXOiGqhK_742hPRw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-515a8e9bea9so600079e87.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 06:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711546516; x=1712151316;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVrCuxpTJ0gCHZTB0QxvdcPy8C9E7vvFJM6R//tX0K4=;
        b=YI3tF2p8iv7sM27XA6uU6EspRVp4ptEiU7koj6fMPm9D4nxcWKgB0zBL+8EdsxqYyv
         ysaJJpIUGB2ZPoCTr11dO9YGOp3wsTzOoUdIHz+2GQkn/KN/Jp5ztN29ZXyrT+8JUgc1
         bX6kdn/E2e19MTdlT8YNJ0DgRPAQcUZEdboXBtPUoDTsgy3h4GEMsULZqp6ndVN1s7tw
         8rV2nS8N/CLgBgrPXS7+4BVatNfvrdEkQa4aSKTH3uyFAxWWrnP/YwVOILRaUbgpM87j
         Dv81zF43LX77UgsGYhJYBKCd74TSgbhdGFW5ujH8OahVC+qJWx2Bb+GLH3NUaF7lk8Vr
         /Y5g==
X-Forwarded-Encrypted: i=1; AJvYcCWGzkZ2t4KkPuCQWjJwBBBwkEjbPu2/v+3MhU6WWov7Zfgabw58y1c0kFaLp7e7za7WYJGDkjjRKEI2ARJfDkhl20k4/2Xa
X-Gm-Message-State: AOJu0Yx4YgNIoaqHB3LrSNfUl1WtzguoY2YZUqdgMpKEed/nkyoHXYVO
	f2Jmv9do8gMktMq5dbJ5b6jodU7fFW+8KSvFdirM3PY5PENhIzUBIueN6lWAJq3ujAKY0lApUwr
	/RsPjNSBo54KyjzU9z1A+u/RXj/o9zfYHx9heYWSxqxEzsiVGlyAe0w==
X-Received: by 2002:ac2:464e:0:b0:514:b446:f5d9 with SMTP id s14-20020ac2464e000000b00514b446f5d9mr8965365lfo.3.1711546516388;
        Wed, 27 Mar 2024 06:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQKIU9SHXAL1+Jnd1RxSm68b2VOAzsmpECG/7Uos2n1azhI8UWjryVQIJwi+EZrekuHsWPbg==
X-Received: by 2002:ac2:464e:0:b0:514:b446:f5d9 with SMTP id s14-20020ac2464e000000b00514b446f5d9mr8965350lfo.3.1711546516004;
        Wed, 27 Mar 2024 06:35:16 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id dn1-20020a0560000c0100b0033ec7182673sm14913658wrb.52.2024.03.27.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:35:15 -0700 (PDT)
Message-ID: <cd94a64536b687ee07f4e59be5bc6fed0df48404.camel@redhat.com>
Subject: Re: [PATCH 2/2] r8169: use new function pcim_iomap_region()
From: Philipp Stanner <pstanner@redhat.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>,  Realtek linux nic maintainers
 <nic_swsd@realtek.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Date: Wed, 27 Mar 2024 14:35:14 +0100
In-Reply-To: <e1016eec-c059-47e5-8e01-539b1b48012a@gmail.com>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
	 <e1016eec-c059-47e5-8e01-539b1b48012a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 12:54 +0100, Heiner Kallweit wrote:
> Use new function pcim_iomap_region() to simplify the code.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> =C2=A0drivers/net/ethernet/realtek/r8169_main.c | 8 +++-----
> =C2=A01 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
> b/drivers/net/ethernet/realtek/r8169_main.c
> index 5c879a5c8..7411cf1a1 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5333,11 +5333,9 @@ static int rtl_init_one(struct pci_dev *pdev,
> const struct pci_device_id *ent)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (region < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return dev_err_probe(&pdev->dev, -ENODEV, "no MMIO
> resource found\n");
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D pcim_iomap_regions(pdev=
, BIT(region), KBUILD_MODNAME);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc < 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return dev_err_probe(&pdev->dev, rc, "cannot remap
> MMIO, aborting\n");
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tp->mmio_addr =3D pcim_iomap_t=
able(pdev)[region];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tp->mmio_addr =3D pcim_iomap_r=
egion(pdev, region,
> KBUILD_MODNAME);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!tp->mmio_addr)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return dev_err_probe(&pdev->dev, -ENOMEM, "cannot
> remap MMIO, aborting\n");
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0txconfig =3D RTL_R32(tp, =
TxConfig);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (txconfig =3D=3D ~0U)

You could use this patch then on top of my series; the only little
change necessary would be that you have to check for an ERR_PTR:

if (IS_ERR(tp->mmio_addr))
   ...


Looks very good otherwise.

P.


