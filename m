Return-Path: <netdev+bounces-151684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 910169F0958
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6D21883484
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1A1B85D0;
	Fri, 13 Dec 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2QpEIiC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AC1B6D18;
	Fri, 13 Dec 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085484; cv=none; b=aC79DlBqLUUjjQhNwkYdS9RHeSuhmTERjcjhcXtMZ2frEQc586Vv3uVDkiYNd0NM7vd4SQtHDPHalvkXI3uqr07PgXU2pYDbrgo+HmfKiIVRgKGk5jfJuDaeTNQaXLvGZky6gBfT9gPN5JzmbLrU9M5rK+bqndMQieLLERKLlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085484; c=relaxed/simple;
	bh=GBwuXRVA5urw2FkBgJpYDpjVBAF2eARPTh5BSDS03KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbNcoBNcULV5tGpdhZfTJ+LZsJy/crX1ME5te6otJd7k0UzPD//OftkuvRXiKmakVIx7g+vvgr4/s8dScsjOyVxNyzWN4KkIfI5egYWixgUK3teUeDoTDiggvYaXGdD6L+m8kARc1cLy6AIBaT3a+tiy1Gfq0KyDJE8riQrFeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2QpEIiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142ABC4CED0;
	Fri, 13 Dec 2024 10:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734085484;
	bh=GBwuXRVA5urw2FkBgJpYDpjVBAF2eARPTh5BSDS03KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2QpEIiCGA91yqBQED7ypBeJwQAEYN4mI2MReFWR28Ub2nwW4Tj5JWI+yJRWVfYfE
	 my/awp1FHyIQ2F7BV7HTpr7E1SjdW/G30CYjn2WIgYXOseHeucGKJxcNaKSp9U+DAJ
	 VS6EZEatN6nV3Nct7a0/5al+mbn3fN/gwEYK4mI5ESgKssi7DcUGCLSZ+AU7DxDeCg
	 NJt8HDsqXSeftOCtFWlxepHAHQINEd0SgUnl6k46t51qMcQfMUP/g1W44VV9ajDwub
	 vcINH6qRplTTJICJ8EV74is67NpreIw84A1nm4KHxccijOm7+Bau5Gc0suIywlfJCy
	 cH9kVf1/R0txw==
Date: Fri, 13 Dec 2024 10:24:39 +0000
From: Simon Horman <horms@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v7 28/28] sfc: support pio mapping based on cxl
Message-ID: <20241213102439.GI2110@kernel.org>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
 <20241212212229.GD2110@kernel.org>
 <e46cd8f0-5e62-5e51-a901-384bdad689fe@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e46cd8f0-5e62-5e51-a901-384bdad689fe@amd.com>

On Fri, Dec 13, 2024 at 10:20:30AM +0000, Alejandro Lucero Palau wrote:
> 
> On 12/12/24 21:22, Simon Horman wrote:
> > On Mon, Dec 09, 2024 at 06:54:29PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > With a device supporting CXL and successfully initialised, use the cxl
> > > region to map the memory range and use this mapping for PIO buffers.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > ---
> > >   drivers/net/ethernet/sfc/ef10.c       | 48 +++++++++++++++++++++++----
> > >   drivers/net/ethernet/sfc/efx_cxl.c    | 19 ++++++++++-
> > >   drivers/net/ethernet/sfc/net_driver.h |  2 ++
> > >   drivers/net/ethernet/sfc/nic.h        |  3 ++
> > >   4 files changed, 65 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> > > index 452009ed7a43..4587ca884c03 100644
> > > --- a/drivers/net/ethernet/sfc/ef10.c
> > > +++ b/drivers/net/ethernet/sfc/ef10.c
> > > @@ -24,6 +24,7 @@
> > >   #include <linux/wait.h>
> > >   #include <linux/workqueue.h>
> > >   #include <net/udp_tunnel.h>
> > > +#include "efx_cxl.h"
> > >   /* Hardware control for EF10 architecture including 'Huntington'. */
> > > @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
> > >   			  efx->num_mac_stats);
> > >   	}
> > Hi Alejandro,
> > 
> > Earlier in efx_ef10_init_datapath_caps, outbuf is declared using:
> > 
> > 	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
> > 
> > This will result in the following declaration:
> > 
> > 	efx_dword_t _name[DIV_ROUND_UP(MC_CMD_GET_CAPABILITIES_V4_OUT_LEN, 4)]
> > 
> > Where MC_CMD_GET_CAPABILITIES_V4_OUT_LEN is defined as 78.
> > So outbuf will be an array with DIV_ROUND_UP(78, 4) == 20 elements.
> > 
> > > +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
> > > +		nic_data->datapath_caps3 = 0;
> > > +	else
> > > +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
> > > +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
> > > +
> > >   	return 0;
> > >   }
> > MC_CMD_GET_CAPABILITIES_V7_OUT_FLAGS3_OFST is defined as 148.
> > And the above will result in an access to element 148 / 4 == 37 of
> > outbuf. A buffer overflow.
> 
> 
> Hi Simon,
> 
> 
> This is, obviously, quite serious, although being the first and only flag in
> that MCDI extension explains why has gone hidden and harmless (as it is a
> read).
> 
> 
> I'll definitely fix it.
> 
> 
> Thanks!

Likewise, thanks.

Please to look at my analysis with a sceptical eye.
It is my understanding based on looking at the code in
the context of the compiler warnings.

