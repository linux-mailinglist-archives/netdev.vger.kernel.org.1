Return-Path: <netdev+bounces-241993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE7C8B73E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 292D7345E4D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158CF286400;
	Wed, 26 Nov 2025 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBGkIfMn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE542248AE;
	Wed, 26 Nov 2025 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182140; cv=none; b=tHj2ZhNZm+2OLadvkPlDh29ErtnV9kvVv5XfeYLrqn8A1WZtWmfZMPqS8Q9D8DF9tuy/63trKMzyp3+g+rhS2nQS94UOdB0F/YsZcM5trsEIsuonIH+8PWlWSlViYh2G6YPZfd2Hc3Pit0sjrBs/smEJ/33xylUHFBSfiI1cLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182140; c=relaxed/simple;
	bh=oTaJfHnKsmK6inQoltB8x3WChksALN+IW6Kq2p4t8P8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3c8kb0KSHPMKWMiBNF/G3BOZ5JrXI9ghUYyMWNlb9d2X9vTDwoxER6P5ZY0u9OCXyKp33QuMmApDo+a+JZ32+Z6tAuTLqkeSO1ZHe77ZyOg3mrI/IURlAncf+TmjzVbQ7viBRJxngEeRy0MS5P0fors0qbbIRvvZVq+tZpV8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBGkIfMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B8AC4CEF7;
	Wed, 26 Nov 2025 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764182139;
	bh=oTaJfHnKsmK6inQoltB8x3WChksALN+IW6Kq2p4t8P8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TBGkIfMn6szVeVn2AuROOCU8qv8ps8NCC0q66qob7yBtbmFnTvG9VK7H61gpzst7N
	 YdgOlu4/HbUNxd0CAVxhIZ/S59Xh4qkZ1M03PN+9olXhbG5FICB7U0PUBAz6gcmuMh
	 uUiCQyO0/NCay3OLu5DJd4+4npO0RufzU0GtLScJYDU7YE0AH40KsaEGJ2UyvlVCXg
	 +eZO+4rwx2RhZsOTKbhfsug8qtv2GDEvy5GRgkRYE7czt0rZXk3TNFHAQkWrSGyepv
	 Xz47jhzjpWWJp4m6tvrNS3x8cNSUNxDnQP38Aodk0a26smRyc4+T05k3137jGHGN7K
	 5rsxcg2ba6B0g==
Message-ID: <7f1e56067bdc46195a9e36f914aa103dc76d4f7f.camel@kernel.org>
Subject: Re: [PATCH v21 15/23] sfc: get endpoint decoder
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>,
 alejandro.lucero-palau@amd.com, 	linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, 	edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>, Edward Cree
	 <ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>
Date: Wed, 26 Nov 2025 10:35:38 -0800
In-Reply-To: <34f7771f-7d6d-4bfd-9212-889433d80b4c@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
	 <20251119192236.2527305-16-alejandro.lucero-palau@amd.com>
	 <4aab1857efeaf2888b1c85cbac1fc5c8fc5c8cbc.camel@kernel.org>
	 <34f7771f-7d6d-4bfd-9212-889433d80b4c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alejandro,

On Wed, 2025-11-26 at 09:09 +0000, Alejandro Lucero Palau wrote:
>=20
> On 11/26/25 01:27, PJ Waskiewicz wrote:
> > Hi Alejandro,
> >=20
> > On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
> > wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > >=20
> > > Use cxl api for getting DPA (Device Physical Address) to use
> > > through
> > > an
> > > endpoint decoder.
> > >=20
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> > > Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > ---
> > > =C2=A0=C2=A0drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
> > > =C2=A0=C2=A01 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> > > b/drivers/net/ethernet/sfc/efx_cxl.c
> > > index d7c34c978434..1a50bb2c0913 100644
> > > --- a/drivers/net/ethernet/sfc/efx_cxl.c
> > > +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> > > @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data
> > > *probe_data)
> > > =C2=A0=C2=A0		return -ENOSPC;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > +	cxl->cxled =3D cxl_request_dpa(cxl->cxlmd,
> > > CXL_PARTMODE_RAM,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 EFX_CTPIO_BUFFER_SIZE);
> > I've been really struggling to get this flow working in my
> > environment.
> > The above function call has a call-chain like this:
> >=20
> > - cxl_request_dpa()
> > =C2=A0=C2=A0 =3D> cxl_dpa_alloc()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D> __cxl_dpa_alloc()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D> __cxl_dpa_reserve=
()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>=
 __request_region()
> >=20
> > That last call to __request_region() is not handling a Type2 device
> > that has its mem region defined as EFI Special Purpose memory.
> > Basically if the underlying hardware has the memory region marked
> > that
> > way, it's still getting mapped into the host's physical address
> > map,
> > but it's explicitly telling the OS to bugger off and not try to map
> > it
> > as system RAM, which is what we want. Since this is being used as
> > an
> > acceleration path, we don't want the OS to muck about with it.
> >=20
> > The issue here is now that I have to build CXL into the kernel
> > itself
> > to get around the circular dependency issue with depmod, I see this
> > when my kernel boots and the device trains, but *before* my driver
> > loads:
> >=20
> > # cat /proc/iomem
> > [...snip...]
> > c050000000-c08fffffff : CXL Window 0
> > =C2=A0=C2=A0 c050000000-c08fffffff : Soft Reserved
> >=20
> > That right there is my device.=C2=A0 And it's being presented correctly
> > that
> > it's reserved so the OS doesn't mess with it.=C2=A0 However, that call
> > to
> > __request_region() fails with -EBUSY since it can't take ownership
> > of
> > that region since it's already owned by the core.
> >=20
> > I can't just skip over this flow for DPA init, so I'm at a bit of a
> > loss how to proceed.=C2=A0 How is your device presenting the .mem regio=
n
> > to
> > the host?
>=20
>=20
> Hi PJ,
>=20
>=20
> My work is based on the device not using EFI_CONVENTIONAL_MEMORY +=20
> EFI_MEMORY_SP but EFI_RESERVED_TYPE. In the first case the kernel can
> try to use that memory and the BIOS goes through default
> initialization,=20

I'm not sure I follow.  Your device is based on using
EFI_RESERVED_TYPE?  Or is it based on the former?  My device is based
on EFI_RESERVED_TYPE, which translates into the Soft Reserved status as
a result of BIOS enumeration and the CXL core enumerating that memory
resource.

> the latter will avoid BIOS or kernel to mess with such a memory.
> Because=20
> there is no BIOS yet supporting this I had to remove DAX support from
> the kernel and deal (for testing) with some BIOS initialization we
> will=20
> not have in production.

Can you elaborate what you mean here?  Do you mean the proposed patches
here are trying to work around this BIOS limitation?

I'm not sure I understand what BIOS limitations you mean though.  I see
on both an AMD and Intel host (CXL 2.0-capable) the same behavior that
I'd expect of EFI_RESERVED_TYPE getting set aside so the OS doesn't
mess with it.  This is on CRB-level stuff plus production-level
platforms.

>=20
>=20
> For your case I thought this work=20
> https://lore.kernel.org/linux-cxl/20251120031925.87762-1-Smita.Koralahall=
iChannabasappa@amd.com/T/#me2bc0d25a2129993e68df444aae073addf886751
> =C2=A0
> was solving your problem but after looking at it now, I think that
> will=20
> only be useful for Type3 and the hotplug case. Maybe it is time to
> add=20
> Type2 handling there. I'll study that patchset with more detail and=20
> comment for solving your case.

I just looked through that, and I might be able to cherry-pick some
stuff.  I'll do the same offline and see if I can come up with a
workable solution to get past this wall for now.

That said though, I don't really want or care about DAX.  I can already
find and map the underlying CXL.mem accelerated region through other
means (RCRB, DVSEC, etc.).

What I'm trying to do is get the regionX object to instantiate on my
CXL.mem memory block, so that I can remove the region, ultimately
tearing down the decoders, and allowing me to hotplug the device.  The
patches here seem to still assume a Type3-ish device where there's DPA
needing to get mapped into HPA, which our devices are already allocated
in the decoders due to the EFI_RESERVED_TYPE enumeration.  But the
patches aren't seeing that firmware already set them up, since the
decoders haven't been committed yet.

My root decoder has 1GB of space, which is the size of my endpoint
device's memory size (1GB).  There is no DPA to map, and the HPA
already appears "full" since the device is already configured in the
decoder.

TL;DR: if your device you're testing with presents the CXL.mem region
as EFI_RESERVED_TYPE, I don't see how these patches are working.=20
Unless you're doing something extra outside of the patches, which isn't
obvious to me.

>=20
>=20
> FWIW, last year in Vienna I raised the concern of the kernel doing=20
> exactly what you are witnessing, and I proposed having a way for
> taking=20
> the device/memory from DAX but I was told unanimously that was not=20
> necessary and if the BIOS did the wrong thing, not fixing that in the
> kernel. In hindsight I would say this conflict was not well
> understood=20
> then (me included) with all the details, so maybe it is time to have=20
> this capacity, maybe from user space or maybe specific kernel param=20
> triggering the device passing from DAX.

I do recall this.  Unfortunately I brought up similar concerns way back
in Dublin in 2021 regarding all of this flow well before 2.0-capable
hosts arrived.  I think I started asking the questions way too early,
since this was of little to no concern at the time (nor was Type2
device support).

Cheers,
-PJ

