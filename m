Return-Path: <netdev+bounces-118923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5801953866
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEBE1F23891
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93331BB683;
	Thu, 15 Aug 2024 16:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A91BA868;
	Thu, 15 Aug 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739899; cv=none; b=WQUV+4zDmqeb4at4HAYU7ZLphx8HMMSaYP0MAeVgOz8vGpWNrgUpbPFFsGDCWKTpq7NU+GEQiHcbVZpmjrncFxjzinOu2so0UO6IKPWIUrgY56w00F8Ml3bSTpAaTdnprrnoXb8v4mekyu51oMVdjgCJxfFN+u6vtifKe/fLDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739899; c=relaxed/simple;
	bh=/4iy8XpxkqlTVj92cqLlKAhtWDIqNKSZhRN0p2fHKUA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaEjic8zFC1RAVX4oxVbvUKrGaVbXuVFKpaGI1QqPnF8cj9D0VGVgm5kSA9UhtouXRzzwpBY8sD9ajQ8uUb7sBNTHI8MNpDRoPVk/Jb5rP2oCZEV0dnsZmrkZcDpYwcRJgChIZpkueS8p44UfTCNDRhxWmSQxQ8rzg9ZoJ8mf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl9hG6xFgz6K6Jj;
	Fri, 16 Aug 2024 00:34:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BBCDF1400DB;
	Fri, 16 Aug 2024 00:38:14 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 17:38:14 +0100
Date: Thu, 15 Aug 2024 17:38:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Message-ID: <20240815173812.0000447c@Huawei.com>
In-Reply-To: <c9391139-edc4-73a0-3ede-d67c40130354@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-2-alejandro.lucero-palau@amd.com>
	<20240804181045.000009dc@Huawei.com>
	<508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
	<c9391139-edc4-73a0-3ede-d67c40130354@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Aug 2024 09:30:08 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/12/24 12:16, Alejandro Lucero Palau wrote:
> >
> > On 8/4/24 18:10, Jonathan Cameron wrote: =20
> >> On Mon, 15 Jul 2024 18:28:21 +0100
> >> <alejandro.lucero-palau@amd.com> wrote:
> >> =20
> >>> From: Alejandro Lucero <alucerop@amd.com>
> >>>
> >>> Differientiate Type3, aka memory expanders, from Type2, aka device
> >>> accelerators, with a new function for initializing cxl_dev_state.
> >>>
> >>> Create opaque struct to be used by accelerators relying on new access
> >>> functions in following patches.
> >>>
> >>> Add SFC ethernet network driver as the client.
> >>>
> >>> Based on=20
> >>> https://lore.kernel.org/linux-cxl/168592149709.1948938.86634259871103=
96027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845=
b446d0e
> >>>
> >>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >>> Co-developed-by: Dan Williams <dan.j.williams@intel.com> =20
> >> =20
> > =20
> >>> +
> >>> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> >>> +{
> >>> +=A0=A0=A0 cxlds->cxl_dvsec =3D dvsec; =20
> >> Nothing to do with accel. If these make sense promote to cxl
> >> core and a linux/cxl/ header.=A0 Also we may want the type3 driver to
> >> switch to them long term. If nothing else, making that handle the
> >> cxl_dev_state as more opaque will show up what is still directly
> >> accessed and may need to be wrapped up for a future accelerator driver
> >> to use.
> >> =20
> >
> > I will change the function name then, but not sure I follow the=20
> > comment about more opaque ...
> >
> >
> > =20
>=20
> I have second thoughts about this.
>=20
>=20
> I consider this as an accessor=A0 for, as you said in a previous exchange=
,=20
> facilitating changes to the core structs without touching those accel=20
> drivers using it.
>=20
> Type3 driver is part of the CXL core and easy to change for these kind=20
> of updates since it will only be one driver supporting all Type3, and an=
=20
> accessor is not required then.
>=20
> Let me know what you think.

It's less critical, but longer term I'd expect any stuff that makes
sense for accelerators and the type 3 driver to use the same
approaches and code paths.  Makes it easier to see where they
are related than opencoding the accesses in the type 3 driver will
do.  In the very long term, I'd expect the type 3 driver to just be
another CXL driver alongside many others.

Jonathan

>=20
>=20


