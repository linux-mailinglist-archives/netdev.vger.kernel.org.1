Return-Path: <netdev+bounces-195034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0EACD950
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 10:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C0D7A33FE
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8F28B418;
	Wed,  4 Jun 2025 08:09:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEEB1B4240;
	Wed,  4 Jun 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024550; cv=none; b=alMASCalChIlwogrqqDDZt6Vl01AH0wZeBd5szFCTSKNYmPH512rNS/13H0hSNVj6U06NVMGTIbD35dTF/440ooB6lzJuCJA2ib76E/0yClAVZNqUdg473fEeSRk/Q4jtAOxkrEO3MVaLtGtTgjUmZrgeoQfnv4BOLrevNHglYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024550; c=relaxed/simple;
	bh=13cATS1c3OEXoHR24+vaOerFjz8R/1zsN0Fw1cBeNAA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAR0jr3WW4+nQZ7EPw72wy9e2Tm6A121mWuHRmoJgzU4d/RPnSCfCs1cuFnLfiRNPbjemn7sqMCM3hR9/iN1YlSdrqFqiBbjgRXfRXj8t/Os7F09QOq63nKGpeYZ1hnWtMYeC/RxR5Q5Xn7rYyOoRKBDMcb+uiuthYVM/n0phJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bC0Vs16bsz6DKsL;
	Wed,  4 Jun 2025 16:05:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1910A1400D9;
	Wed,  4 Jun 2025 16:09:04 +0800 (CST)
Received: from localhost (10.202.227.76) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Jun
 2025 10:09:03 +0200
Date: Wed, 4 Jun 2025 09:09:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v16 02/22] sfc: add cxl support
Message-ID: <20250604090906.000071ad@huawei.com>
In-Reply-To: <682f7ddf1f0b9_3e70100fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
	<20250514132743.523469-3-alejandro.lucero-palau@amd.com>
	<682c3129d6a47_2b1610070@dwillia2-mobl4.notmuch>
	<172834c6-0cc7-479b-be04-5ccd5cf8aae0@amd.com>
	<682e09813a374_1626e100e@dwillia2-xfh.jf.intel.com.notmuch>
	<8a993411-26db-44c6-954c-e58eb12f9d82@amd.com>
	<682f7ddf1f0b9_3e70100fb@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 22 May 2025 12:41:19 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Alejandro Lucero Palau wrote:
> >=20
> > On 5/21/25 18:12, Dan Williams wrote: =20
> > > Alejandro Lucero Palau wrote:
> > > [..] =20
> > >>>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> > >>>> +{ =20
> > >>> So this is empty which means it leaks the cxl_dev_state_create()
> > >>> allocation, right? =20
> > >>
> > >> Yes, because I was wrongly relying on devres ...
> > >>
> > >>
> > >> Previous patchsets were doing the explicit release here.
> > >>
> > >>
> > >> Your suggestion below relies on adding more awareness of cxl into
> > >> generic efx code, what we want to avoid using the specific efx_cxl.*=
 files.
> > >>
> > >> As I mentioned in patch 1, I think the right thing to do is to add
> > >> devres for cxl_dev_state_create. =20
> > > ...but I thought netdev is anti-devres? I am ok having a
> > > devm_cxl_dev_state_create() alongside a "manual" cxl_dev_state_create=
()
> > > if that is the case. =20
> >=20
> >=20
> > But a netdev is using the CXL API where devres is being used already.=20
> > AFAIK, netdev maintainers prefer to not use devres by netdev drivers,=20
> > but I do not think they can impose their view to external API, mainly=20
> > when other driver types could likely also make use of it in the future.=
 =20
>=20
> From the CXL perspective I am neutral. As long as the parallel manual
> interfaces arrange to undo everything it "should just work (TM)". You
> would need to create the manual version of devm_cxl_add_memdev(), and
> audit that the paired cxl_del_memdev() does not result in any cxl_core
> internal devres events to leak past the ->remove() event for the
> accelerator driver.

Maybe look at wrapping the CXL calls up in a devres group.  Those
are sometimes useful for cases where we need to wind all devm stuff
down at a particular point in a remove flow. Might allow us to
have devm_cxl_add_memdev() wrapped up by cxl_add_memdev() and
cxl_del_memdev() or versions of those in the the net driver.
Whether that group management sits in the network driver or is in
CXL helpers is an open question and might be refined over time.

Jonathan

>=20
> > >> Before sending v17 with this change, are you ok with the rest of the
> > >> patches or you want to go through them as well? =20
> > > So I did start taking a look and then turned away upon finding a
> > > memory-leak on the first 2 patches in the series. I will continue goi=
ng
> > > through it, but in general the lifetime and locking rules of the CXL
> > > subsystem continue to be a source of trouble in new enabling. At a
> > > minimum that indicates a need/opportunity to review the rules at a
> > > future CXL collab meeting. =20
> >=20
> > Great. And I agree about potential improvements mostly required after=20
> > all this new code (hopefully) ends up being merged, which I'll be happy=
=20
> > to contribute. Also, note this patchset original RFC and=A0 cover lette=
rs=20
> > since then states "basic Type2 support". =20
>=20
> It would help to define "basic" in terms of impact. How much end-user
> benefit arrives at this stage, and what is driving motivation to go
> beyond basic. E.g. "PIO buffer in CXL =3D=3D X amount of goodness, and Y
> amount of goodness comes with additional changes".
>=20


