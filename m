Return-Path: <netdev+bounces-102087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCD7901612
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E461F2115A
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343072E85E;
	Sun,  9 Jun 2024 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKrcbxr6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F61AAC4
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717935231; cv=none; b=Puf4RLmHU990xx3z7R3DVURz1cvvW0m8keOQG9Lc3ab8/Dk/+xAij2FjtcGEx91teZ1SaFtdixaCD5597MIktLEltaJ52mWFaSGJ3PPO0bpgv9pYzEjFGth21MffUM3R4AUrQ3xoZx2f9IAHOG8BE3bc0x2NVDRb+cuIU3CxYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717935231; c=relaxed/simple;
	bh=3gD72I4ji8jELOx9W4hKt4XOwXp4O8rVRPxCJo8g+VE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WNMQpn5CM3jqSe+uy5KGf5OLISKmJ33Jh7cxAHwzrpdnEuiirZJp2QlB6dWqTwT/9s6b0mhpsl9psRh4rv6gyfl493EeU4GPuNDdPE+iOMhCVaq0W/KQ6vUZHeHkCGUlb+0lEiKAvz4y7aZjhP7KTbGFPkpIWFXlLK7DzV0jDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKrcbxr6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c1baf8ff31so190755a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717935229; x=1718540029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCLnSVHq2odof+wl0IZ/009vpEAz0lDExV+kVQk64f0=;
        b=mKrcbxr6j/d1NB31W2SyftX4tFCkh84iqD6MOzAjOY/Cr3CJCn2gf8urpwEiqu97Xl
         0vyg7qjgXNptu5GquAW/lkXmGu8xCrXPsjiwqmQLPEZp6tnTKT0CcvFVQgj/JohPUNqJ
         8tblmdnsPZqoPBrCLAAjuUCVVfyob3UMmpw5QE6zY0jepjwMj2hi3bUw9KW70Q0ay69a
         baxKfNXnVOeR5PtGsQGS4S46aFV69PHWRYDChZzTgT2tjnvqh7X4fYhQzK1Dg0ggv94X
         4Y6qK32WmSea3v2yeHS3umyWJv6SgwE7mS5eUqRTtg8L9Y3KzmTmxs0JV2ZUPwk3HWMP
         upAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717935229; x=1718540029;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FCLnSVHq2odof+wl0IZ/009vpEAz0lDExV+kVQk64f0=;
        b=ghS+c2ZciuTc7tG/Ado4/H40kT+FMxvWv7xGgMScjXGHVkjJGO7yTSmzIhcWwqwN0s
         Bwl67JXp9yrddzRqsgmJ0UHDi5coObQih6Gfeop9xqzT8zDFBgg39VFYSkZyWF5lysSB
         a6qBVSa1/JUBkAu2qLhlVR6EqixN5ma+izV63zYXg+70dn8COtWTPJiY1zXb2pBN/T7m
         qSsGheUiRBkMW6K15qNw19o5jbRcol6O2rUX+XTmTwSz/ZDk+CiqtOVZISmck4kEOCmH
         3MAh97Bu5Nqe8LYOrDcmrhb2j4xyc4qH/nJKNH5nLq2/5eXtsaNmfp8FqzQ3Rh+NKAYA
         cV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+q5KR4MxXwCcWS7WSUfLatZVzLYRdIVBjkhIDg0qfpQwIOmyx1V3JTm05w6WZ+/+F6HO59KI8c9svZo8XNt9Sb44BYlJ/
X-Gm-Message-State: AOJu0Yw/jB69IjiMGs8Doo66RQNhuke14pGbBB4+4Pxn1k+f6T1+OOxN
	7b9TlWgfmqIocjgSYi6OMzqbey4hjCoxN//roUeaPWLuypZPnP97
X-Google-Smtp-Source: AGHT+IHAhZvcil5AMWd+ky6U19pfby9zV5jiSAyKLTD7+JCz2H3QGMTOXxsQjFjClYBwemqVnuTsng==
X-Received: by 2002:a17:90a:5912:b0:2bf:bcde:d2b0 with SMTP id 98e67ed59e1d1-2c2bcc7052emr6838080a91.4.1717935227358;
        Sun, 09 Jun 2024 05:13:47 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2c0fe3f22sm4907589a91.0.2024.06.09.05.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 05:13:46 -0700 (PDT)
Date: Sun, 09 Jun 2024 21:13:35 +0900 (JST)
Message-Id: <20240609.211335.6182990734312389.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 1/6] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <7a3af149-89bd-4c9f-88fe-813e84dc98d9@gmx.net>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
	<20240605232608.65471-2-fujita.tomonori@gmail.com>
	<7a3af149-89bd-4c9f-88fe-813e84dc98d9@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Jun 2024 13:17:30 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

> On 06.06.2024 01.26, FUJITA Tomonori wrote:
>> +
>> +static const struct pci_device_id tn40_id_table[] =3D {
>> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
>> +			 PCI_VENDOR_ID_TEHUTI, 0x3015) },
>> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
>> +			 PCI_VENDOR_ID_DLINK, 0x4d00) },
>> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
>> +			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
>> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
>> +			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
>> +	{ }
>> +};
>> +
> =

> Now that it seems we will have another revision of your patches, mayb=
e
> we can also continue to do a bit of cleanup:
> =

> Is there any reason why you specifically detail every single card wit=
h
> vendor ids?
> Couldn't it just do with the generic Tehuti device number, i.e.:
> =

> static const struct pci_device_id tn40_id_table[] =3D {
> =A0=A0=A0 { PCI_VDEVICE(TEHUTI, 0x4022), 0},
> =A0=A0=A0 { }
> };

The original driver tells that different hardware initialization
routines are required depending on the type of PHY hardware (e.g.,
mdio speed, register value for interrupt). I plan to add such
information to driver_data in the id table when I add new PHY support.

Seems that you could add AQR105 PHY soon so I'll update the table to
put QT2025 PHY specific info into the table.


>> --- /dev/null
>> +++ b/drivers/net/ethernet/tehuti/tn40.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* Copyright (c) Tehuti Networks Ltd. */
>> +
>> +#ifndef _TN40_H_
>> +#define _TN40_H_
>> +
>> +#define TN40_DRV_NAME "tn40xx"
>> +
>> +#define PCI_VENDOR_ID_EDIMAX 0x1432
> with my suggestion above, the definition of the vendor EDIMAX would
> become obsolete. If needed, it should probably anyway rather be place=
d
> in include/linux/pci_ids.h

Surely, I'll put it in include/linux/pci_ids.h in v10.

