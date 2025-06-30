Return-Path: <netdev+bounces-202542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C453AAEE399
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640F0170C05
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F10E29187E;
	Mon, 30 Jun 2025 16:07:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F4289E3B;
	Mon, 30 Jun 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299641; cv=none; b=nF7+3oUTEVe+BwILDHCAVJf3Q4DHJZ7crmM1Wr9LOQh+LH34jk//ugV02hMA3uOnR726L6rrWdLeUJ7McT7DIAOpkLDSgTyaD5DD8T310jKJ/8FJNWrN+HbjA99zkvOWEqGAIytvTiQcX2sfvcbH43u0XjEXRK9KbPu8WXumVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299641; c=relaxed/simple;
	bh=RCsCjlhXR/HUbxR5AZSkLwsZT9tC/sa/jVIRz5vQ3cE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwdcwdLHclzQd1MXyb3fySdw42BziKHIZpP0SrCi00AaBd9nmi5yQ0IOikJRd8WpeaOwirYGz3PLHAfsEUaPuOtwNgPbGQ8T0IW+IaCaKliqMmZdazFXgZKp6MOfGBJC9Ghp/0hKtAchtEFO7beqxA6GBjtOVqGxi32Dam1xV2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW9y65jyhz6M4Hf;
	Tue,  1 Jul 2025 00:06:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A2B31402F0;
	Tue,  1 Jul 2025 00:07:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 18:07:14 +0200
Date: Mon, 30 Jun 2025 17:07:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, "Edward Cree"
	<ecree.xilinx@gmail.com>, Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v17 02/22] sfc: add cxl support
Message-ID: <20250630170713.00001f72@huawei.com>
In-Reply-To: <f56886cd-ca42-459a-87d7-eb3f472e88b4@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
	<20250624141355.269056-3-alejandro.lucero-palau@amd.com>
	<20250625173750.00001da4@huawei.com>
	<1a6ba55b-3077-4db2-a6cf-c7dc96619c94@amd.com>
	<f56886cd-ca42-459a-87d7-eb3f472e88b4@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Jun 2025 15:55:39 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 6/30/25 15:52, Alejandro Lucero Palau wrote:
> >
> > On 6/25/25 17:37, Jonathan Cameron wrote: =20
> >> On Tue, 24 Jun 2025 15:13:35 +0100
> >> <alejandro.lucero-palau@amd.com> wrote:
> >> =20
> >>> From: Alejandro Lucero <alucerop@amd.com>
> >>>
> >>> Add CXL initialization based on new CXL API for accel drivers and make
> >>> it dependent on kernel CXL configuration.
> >>>
> >>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> >>> Reviewed-by: Alison Schofield <alison.schofield@intel.com> =20
> >> Hi Alejandro,
> >>
> >> I think I'm missing something with respect to the relative life times.
> >> Throwing one devm_ call into the middle of a probe is normally a recipe
> >> for at least hard to read code, if not actual bugs.=A0 It should be do=
ne
> >> with care and accompanied by at least a comment. =20
> >
> >
> > Hi Jonathan,
> >
> >
> > I agree devm_* being harder in general and prone to some subtle=20
> > problems, but I can not see an issue here apart from the objects kept=20
> > until device unbinding. But I think adding some comment can help.
> >
> >
> > <snip>
> > =20
> >> +
> >> +=A0=A0=A0 dvsec =3D pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_=
CXL,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CXL_D=
VSEC_PCIE_DEVICE);
> >> +=A0=A0=A0 if (!dvsec)
> >> +=A0=A0=A0=A0=A0=A0=A0 return 0;
> >> +
> >> +=A0=A0=A0 pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n"=
);
> >> +
> >> +=A0=A0=A0 /* Create a cxl_dev_state embedded in the cxl struct using =
cxl=20
> >> core api
> >> +=A0=A0=A0=A0 * specifying no mbox available.
> >> +=A0=A0=A0=A0 */
> >> +=A0=A0=A0 cxl =3D devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYP=
E_DEVMEM,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_dev->de=
v.id, dvsec, struct efx_cxl,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cxlds, fals=
e);
> >> The life time of this will outlast everything else in the efx driver.
> >> Is that definitely safe to do?=A0 Mostly from a reviewability and=20
> >> difficulty
> >> of reasoning we avoid such late releasing of resources.
> >>
> >> Perhaps add to the comment before this call what you are doing to=20
> >> ensure that
> >> it is fine to release this after everything in efx_pci_remove()
> >>
> >> Or wrap it up in a devres group and release that group in=20
> >> efx_cxl_exit().
> >>
> >> See devres_open_group(), devres_release_group()
> >>
> >> =20
> >
> > As I said above, I can not see a problem here, but maybe to explicitly=
=20
> > managed those resources with a devres group makes it simpler, so I=20
> > think it is a good advice to follow.
> >
> >
> > Thanks!
> >
> > =20
>=20
> FWIW, I just want to add that although I agree with this, it is somehow=20
> counterintuitive to me as the goal of devm is to avoid to care about=20
> when to release those allocations.

In my view not quite.  It's to enforce that those allocations are released
in the reverse order of the devm setup calls - which is almost always
the right thing to do as long as whole driver is using devm.

There are uses like you describe though so it's not a universal case
of one or the other.  One advantage of the devres group thing is that
folk who are not keen on devm can effectively have normal manual release
flows.

Jonathan




