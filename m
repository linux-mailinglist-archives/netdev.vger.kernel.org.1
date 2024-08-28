Return-Path: <netdev+bounces-122735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBEB9625D6
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5A1F21946
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53916C874;
	Wed, 28 Aug 2024 11:20:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF7B16BE1D;
	Wed, 28 Aug 2024 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844002; cv=none; b=Y52FAGfBxHDUSgZrTY6tau584jF6nroIMhd1gsr6ZnTJOBHxbA1f+8QKZMI+e5indeu4758j+aDyMlXZJVI/CGUYf+A6jwQqsEGAEd3d/WnqEPJc6ChX+Ad6FbiHwNiFLH4dsH2PCoAu/EtSwj2V2CO6AMQ6pmyMyAAOn1EJq8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844002; c=relaxed/simple;
	bh=Yn1bCe0Ywc5LYHwIAuylM9sxlTZCQHCCKjEHNXtUZP8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlE9rcbYJuvTfi/d15tGAEFfsEllYvOvm2jlhtxypQ3HTSwPS90MrauCig/pYtuNPWo22fkYB4xENvJuwUWb0Cc9YbJPYSmoaAXuxfWm44vHrYzVwJ7BAGkQHNwz5j8l/e8YCGZXK6Es6Q7V7vIyt4FuvIM0NJFeW03lQJwhh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv20y1b5mz6J7Ln;
	Wed, 28 Aug 2024 19:16:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C05B14038F;
	Wed, 28 Aug 2024 19:19:50 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 12:19:49 +0100
Date: Wed, 28 Aug 2024 12:19:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Message-ID: <20240828121948.00001105@Huawei.com>
In-Reply-To: <a6751e81-7a14-a8c9-b6b6-038e50b1b588@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-10-alejandro.lucero-palau@amd.com>
	<20240804185756.000046c5@Huawei.com>
	<a6751e81-7a14-a8c9-b6b6-038e50b1b588@amd.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Aug 2024 11:18:12 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/4/24 18:57, Jonathan Cameron wrote:
> > On Mon, 15 Jul 2024 18:28:29 +0100
> > alejandro.lucero-palau@amd.com wrote:
> > =20
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> CXL region creation involves allocating capacity from device DPA
> >> (device-physical-address space) and assigning it to decode a given HPA
> >> (host-physical-address space). Before determining how much DPA to
> >> allocate the amount of available HPA must be determined. Also, not all
> >> HPA is create equal, some specifically targets RAM, some target PMEM,
> >> some is prepared for device-memory flows like HDM-D and HDM-DB, and so=
me
> >> is host-only (HDM-H).
> >>
> >> Wrap all of those concerns into an API that retrieves a root decoder
> >> (platform CXL window) that fits the specified constraints and the
> >> capacity available for a new region.
> >>
> >> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.866342=
5987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95=
c8acdc347345b4f
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Co-developed-by: Dan Williams <dan.j.williams@intel.com> =20
> > Hi.
> >
> > This seems a lot more complex than an accelerator would need.
> > If plan is to use this in the type3 driver as well, I'd like to
> > see that done as a precursor to the main series.
> > If it only matters to accelerator drivers (as in type 3 I think
> > we make this a userspace problem), then limit the code to handle
> > interleave ways =3D=3D 1 only.  Maybe we will care about higher interle=
ave
> > in the long run, but do you have a multihead accelerator today?
> >
> > Jonathan
> > =20
> >> ---
> >>   drivers/cxl/core/region.c          | 161 +++++++++++++++++++++++++++=
++
> >>   drivers/cxl/cxl.h                  |   3 +
> >>   drivers/cxl/cxlmem.h               |   5 +
> >>   drivers/net/ethernet/sfc/efx_cxl.c |  14 +++
> >>   include/linux/cxl_accel_mem.h      |   9 ++
> >>   5 files changed, 192 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index 538ebd5a64fd..ca464bfef77b 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -702,6 +702,167 @@ static int free_hpa(struct cxl_region *cxlr)
> >>   	return 0;
> >>   }
> >>  =20
> >> +
> >> +struct cxlrd_max_context {
> >> +	struct device * const *host_bridges;
> >> +	int interleave_ways;
> >> +	unsigned long flags;
> >> +	resource_size_t max_hpa;
> >> +	struct cxl_root_decoder *cxlrd;
> >> +};
> >> +
> >> +static int find_max_hpa(struct device *dev, void *data)
> >> +{
> >> +	struct cxlrd_max_context *ctx =3D data;
> >> +	struct cxl_switch_decoder *cxlsd;
> >> +	struct cxl_root_decoder *cxlrd;
> >> +	struct resource *res, *prev;
> >> +	struct cxl_decoder *cxld;
> >> +	resource_size_t max;
> >> +	int found;
> >> +
> >> +	if (!is_root_decoder(dev))
> >> +		return 0;
> >> +
> >> +	cxlrd =3D to_cxl_root_decoder(dev);
> >> +	cxld =3D &cxlrd->cxlsd.cxld;
> >> +	if ((cxld->flags & ctx->flags) !=3D ctx->flags) {
> >> +		dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
> >> +			      cxld->flags, ctx->flags);
> >> +		return 0;
> >> +	}
> >> +
> >> +	/* A Host bridge could have more interleave ways than an
> >> +	 * endpoint, couldn=B4t it? =20
> > EP interleave ways is about working out how the full HPA address (it's
> > all sent over the wire) is modified to get to the DPA.  So it needs
> > to know what the overall interleave is.  Host bridge can't interleave
> > and then have the EP not know about it.  If there are switch HDM decode=
rs
> > in the path, the host bridge interleave may be less than that the EP ne=
eds
> > to deal with.
> >
> > Does an accelerator actually cope with interleave? Is aim here to ensure
> > that IW is never anything other than 1?  Or is this meant to have
> > more general use? I guess it is meant to. In which case, I'd like to
> > see this used in the type3 driver as well. =20
>=20
>=20
> I guess an accelerator could cope with interleave ways > 1, but not ours.
>=20
> And it does not make sense to me an accelerator being an EP for an=20
> interleaved HPA because the memory does not make sense out of the=20
> accelerator.
>=20
> So if the CFMW and the Host Bridge have an interleave way of 2, implying=
=20
> accesses to the HPA through different wires, I assume an accelerator=20
> should not be allowed.
That's certainly fine for now. 'maybe' something will come along that can
make use of interleaving (I'm thinking of Processing near memory type setup
where it's offloading minor stuff more local to the memory but is basically
type 3 memory)
>=20
>=20
> >> +	 *
> >> +	 * What does interleave ways mean here in terms of the requestor?
> >> +	 * Why the FFMWS has 0 interleave ways but root port has 1? =20
> > FFMWS? =20
>=20
>=20
> I meant CFMW, and I think this comment is because I found out the CFMW=20
> is parsed with interleave ways =3D 0 then the root port having 1, what is=
=20
> confusing.
>=20
I'm a bit lost.  Maybe this is just encoded and 'real' values?
1 way interleave is just not interleaving.

Jonathan



