Return-Path: <netdev+bounces-210303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B286B12BAA
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 19:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58927A3344
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE7244690;
	Sat, 26 Jul 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmzmFcwM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED018A6CF;
	Sat, 26 Jul 2025 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753551874; cv=none; b=WKym7qrfahQ/oxmHxvodsmKMiIEG/lpeiAlwKooxcnMEP0ipMoROkskftkEYOmrI/qHwWhPU6g2bcuugZrCUzfTdDQC07ZHOKB9WScxqQvPe1KYnJogqBhcOAXTbnBBpSKuIiEpULte7i+VA+O0pa8GCmO9J7LbHYJtzW0/j1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753551874; c=relaxed/simple;
	bh=/wk7CuIpOgogH/fiD0D2D+slPWNVuGX0Qcm0+ATe7fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0TBwEyZ2/Bbb3hVc3OYKXndLoIpkxglYmefm0Mcx+V+VSiYcufs4oufazCj+m35DpRxeamBU+zPM/miupSNQ0OLE+FHeSOSXb/+tewaYTwyJ21fDqsd9QETJOqpZcRLoOOEHBY7EcQexKx6e2TiQ9cxrFWdFfCPLd5VXvM90cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmzmFcwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEF0C4CEED;
	Sat, 26 Jul 2025 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753551873;
	bh=/wk7CuIpOgogH/fiD0D2D+slPWNVuGX0Qcm0+ATe7fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmzmFcwMsSpyiTFfO6ORcBoBuAEzRbuHtHeaXGJke2meZWmdeiuqONhAi9xUlYBK8
	 t66bS3j1iZ9Q1swxNpQWvSJAiKxgr0VblqYIuC3oUWPePL09iU+ucbIkXBa3vKgDhT
	 eaiqKji4Itf9MF0XErOKEuQeAAsWYZz+UAAAUroWUEzGYy6rAGk4D0jp2e/+XPL2+x
	 Sqz2JlzyggiOLWS9zRxT/jXowpx/46qha3WtDyfNjCbptqvYZkDGwPVt9fmN1kxqyw
	 qV6d/3sruI+rbwDn87+dGPd8MFgq+eShAud2FbYeUqtxg3CR9EioBVDAUayf6ur6sU
	 9zDhmAReTSyIA==
Date: Sat, 26 Jul 2025 18:44:28 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [net] Octeontx2-af: Skip overlap check for SPI field
Message-ID: <20250726174428.GL1367887@horms.kernel.org>
References: <20250725064802.2440356-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725064802.2440356-1-hkelam@marvell.com>

On Fri, Jul 25, 2025 at 12:18:02PM +0530, Hariprasad Kelam wrote:
> Octeontx2/CN10K silicon supports generating a 256-bit key per packet.
> The specific fields to be extracted from a packet for key generation
> are configurable via a Key Extraction (MKEX) Profile.
> 
> The AF driver scans the configured extraction profile to ensure that
> fields from upper layers do not overwrite fields from lower layers in
> the key.
> 
> Example Packet Field Layout:
> LA: DMAC + SMAC
> LB: VLAN
> LC: IPv4/IPv6
> LD: TCP/UDP
> 
> Valid MKEX Profile Configuration:
> 
> LA   -> DMAC   -> key_offset[0-5]
> LC   -> SIP    -> key_offset[20-23]
> LD   -> SPORT  -> key_offset[30-31]
> 
> Invalid MKEX profile configuration:
> 
> LA   -> DMAC   -> key_offset[0-5]
> LC   -> SIP    -> key_offset[20-23]
> LD   -> SPORT  -> key_offset[2-3]  // Overlaps with DMAC field
> 
> In another scenario, if the MKEX profile is configured to extract
> the SPI field from both AH and ESP headers at the same key offset,
> the driver rejecting this configuration. In a regular traffic,
> ipsec packet will be having either AF(LD) or ESP (LE). This patch

Should "AF" be "AH ?

> relaxes the check for the same.
> 
> Fixes: 12aa0a3b93f3 ("octeontx2-af: Harden rule validation.")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index 1b765045aa63..d8d491a01e5b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -607,7 +607,7 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
>  			*features &= ~BIT_ULL(NPC_OUTER_VID);
>  
>  	/* Set SPI flag only if AH/ESP and IPSEC_SPI are in the key */
> -	if (npc_check_field(rvu, blkaddr, NPC_IPSEC_SPI, intf) &&
> +	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&

As this checks now differs in form from that of other's in this function,
perhaps expanding the comment above is warranted.

>  	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
>  		*features |= BIT_ULL(NPC_IPSEC_SPI);
>  
> -- 
> 2.34.1
> 

