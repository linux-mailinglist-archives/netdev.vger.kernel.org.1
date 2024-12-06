Return-Path: <netdev+bounces-149651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A689E6A77
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FE818869AA
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06551FAC50;
	Fri,  6 Dec 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViklMXlj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF21F9F43;
	Fri,  6 Dec 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477833; cv=none; b=rGL1C8MiC3k+IG7bHWlfLgov/M9fK479cw4fPSEOInXNyhfuPYOw+kp23TEoNLzZtfFSAVXKxyKNZAU+g+TulLCQRFoyTkfOJ0q51J/LCWyOZLi6vE0pPD/CIO17LJRNraTDlZOUUhLycbd/Fca28jO55pJDnxDFDQN1Uv+cZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477833; c=relaxed/simple;
	bh=pM3I9LaJcdLGXKHGOfytgDj//czg5lPUGDRR4kXGCgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQjwnY8zxpijstAYNShP4yPac6HvQZ4y10/7CeDRf0uW43jBG9Q6hkoe34H/pfbpqfFsUucwQiMIZfp49x+IUDN3fRHW2oE4RI1O6pazI5+a8QufSz474fUh/RXhoTkIXA/nAhphTWxKzU9pz6iTEVOZwn9s3YaTUMzKpFDLEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViklMXlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7094C4CED1;
	Fri,  6 Dec 2024 09:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733477833;
	bh=pM3I9LaJcdLGXKHGOfytgDj//czg5lPUGDRR4kXGCgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViklMXlj7RQwYJYgAqahW7PxSY16ARsma57cIVZcWLULFfteHs3ZNgv2AuhkK++b0
	 RC7nXSsswcLMjZzfrld1YPcpQCX+N1GvkY4Bxr9BTTukTwVWuN7EJm5U9SWVoeJHDF
	 OD0eqm2kJgrWejd/Cuhz8n/7sl9c5FokpC5RhEMW/Hy94h7ls3azGlQvFlBg+Wl/8k
	 fNweUJhR79WrXeE4TlJYi4gLiotyS4IPVckKDh/spXYbvtPavIQedrGQcVjGAFBCPo
	 zwGGsEXWRHfElBhfNc2dchUlNP6IU9OgDDTfcgOt4IFFY+JWgkj2w5vhCLXrQ7kWDm
	 pS6kGi2Y1/Y6w==
Date: Fri, 6 Dec 2024 09:37:08 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, frank.li@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 RESEND net-next 2/5] net: enetc: add Tx checksum
 offload for i.MX95 ENETC
Message-ID: <20241206093708.GI2581@kernel.org>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204052932.112446-3-wei.fang@nxp.com>

On Wed, Dec 04, 2024 at 01:29:29PM +0800, Wei Fang wrote:
> In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
> Tx checksum offload. The transmit checksum offload is implemented through
> the Tx BD. To support Tx checksum offload, software needs to fill some
> auxiliary information in Tx BD, such as IP version, IP header offset and
> size, whether L4 is UDP or TCP, etc.
> 
> Same as Rx checksum offload, Tx checksum offload capability isn't defined
> in register, so tx_csum bit is added to struct enetc_drvdata to indicate
> whether the device supports Tx checksum offload.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

...

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 4b8fd1879005..590b1412fadf 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -558,7 +558,12 @@ union enetc_tx_bd {
>  		__le16 frm_len;
>  		union {
>  			struct {
> -				u8 reserved[3];
> +				u8 l3_start:7;
> +				u8 ipcs:1;
> +				u8 l3_hdr_size:7;
> +				u8 l3t:1;
> +				u8 resv:5;
> +				u8 l4t:3;
>  				u8 flags;
>  			}; /* default layout */

Hi Wei,

Given that little-endian types are used elsewhere in this structure
I am guessing that the layout above works for little-endian hosts
but will not work on big-endian hosts.

If so, I would suggest an alternate approach of using a single 32-bit
word and accessing it using a combination of FIELD_PREP() and FIELD_GET()
using masks created using GENMASK() and BIT().

Or, less desirably IMHO, by providing an alternate layout for
the embedded struct for big endian systems.

...

