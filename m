Return-Path: <netdev+bounces-241727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3152C87B11
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8433B3B2AAD
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3932F6586;
	Wed, 26 Nov 2025 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3V2p9aj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32451D61A3;
	Wed, 26 Nov 2025 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764120477; cv=none; b=Cor4ovwLsBSkvbnnPCH3cuFwSOmLMnpMGTmVhs2Lw3dIp9j6rTU+U0IowWJg+iOfjerF7iP5bmjSw57FFRHFoG52G4dUGbAuOkQ/ztaQYC3n40htQJZfYLkms1FhunvT46B+adKCBjrZEN1eczRrO6CqzPCfnUBiQUsuP3GQLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764120477; c=relaxed/simple;
	bh=1CT5BWI5xc1fkD/dsMPTW7rErVQVNs+8Yrs9ebTw7QI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1KXWzU4IyPcuKG4RJGBsTL38zbKDv19/MvT3wu4JU8EK5kmhJ+nSZt//m8rV+fI1ggFMOe7avhTwybxnimbqGBFEWLlJrRJkmMQd+RJ6t+S0cnpQIIIzeW/nOiWsrBSVCwvoomRndawdSgI+JKkmUN2dTEE71x4sW7rl1BRhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3V2p9aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28ADC4CEF1;
	Wed, 26 Nov 2025 01:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764120477;
	bh=1CT5BWI5xc1fkD/dsMPTW7rErVQVNs+8Yrs9ebTw7QI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U3V2p9ajaFgzSTuld9CvUbwKBQwusSOIjOsQhyOO/d5m/LSAk6+sk309VynFKa4sT
	 VZGMMVmsv8obx22Ulg/i535bdDEs2b1iDwO6BEEdvSLRF4hF7JK8zOyBflrVM8BlBZ
	 XeBevHOOZSAW+camTj4uNgGZr+KJsBkoHM6OuaIqx27LfMKP1BLGL0MQz2CJwsR2j9
	 pqaqPP7j7I7Fe2JnoPLUwGrBn5Pntr5CFuEzz9LDTaSSiSQegbDbmAhvdydVo5kSzX
	 81z/EId8dHnIwLZQrAUPYqpOeAsPtCEuDMFmQ4eNQ2q27znTBpw37boCtB53i/dGan
	 dZBzNBwk/nPxw==
Message-ID: <4aab1857efeaf2888b1c85cbac1fc5c8fc5c8cbc.camel@kernel.org>
Subject: Re: [PATCH v21 15/23] sfc: get endpoint decoder
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, 
	netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, 	dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>, Martin Habets	
 <habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Ben Cheatham
 <benjamin.cheatham@amd.com>
Date: Tue, 25 Nov 2025 17:27:56 -0800
In-Reply-To: <20251119192236.2527305-16-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
	 <20251119192236.2527305-16-alejandro.lucero-palau@amd.com>
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

On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>=20
> Use cxl api for getting DPA (Device Physical Address) to use through
> an
> endpoint decoder.
>=20
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> =C2=A0drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
> =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c
> index d7c34c978434..1a50bb2c0913 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data
> *probe_data)
> =C2=A0		return -ENOSPC;
> =C2=A0	}
> =C2=A0
> +	cxl->cxled =3D cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 EFX_CTPIO_BUFFER_SIZE);

I've been really struggling to get this flow working in my environment.
The above function call has a call-chain like this:

- cxl_request_dpa()
  =3D> cxl_dpa_alloc()
     =3D> __cxl_dpa_alloc()
        =3D> __cxl_dpa_reserve()
           =3D> __request_region()

That last call to __request_region() is not handling a Type2 device
that has its mem region defined as EFI Special Purpose memory. =C2=A0
Basically if the underlying hardware has the memory region marked that
way, it's still getting mapped into the host's physical address map,
but it's explicitly telling the OS to bugger off and not try to map it
as system RAM, which is what we want. Since this is being used as an
acceleration path, we don't want the OS to muck about with it.

The issue here is now that I have to build CXL into the kernel itself
to get around the circular dependency issue with depmod, I see this
when my kernel boots and the device trains, but *before* my driver
loads:

# cat /proc/iomem
[...snip...]
c050000000-c08fffffff : CXL Window 0
  c050000000-c08fffffff : Soft Reserved

That right there is my device.  And it's being presented correctly that
it's reserved so the OS doesn't mess with it.  However, that call to
__request_region() fails with -EBUSY since it can't take ownership of
that region since it's already owned by the core.

I can't just skip over this flow for DPA init, so I'm at a bit of a
loss how to proceed.  How is your device presenting the .mem region to
the host?

Cheers,
-PJ

