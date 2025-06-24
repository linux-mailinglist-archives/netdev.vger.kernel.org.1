Return-Path: <netdev+bounces-200555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1032EAE6183
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73967A67B6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCEA27AC28;
	Tue, 24 Jun 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcgmJv7O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15017AD5A;
	Tue, 24 Jun 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758798; cv=none; b=C8Z7Ej38A1xHxFerf8yQRg3p5k63bzDIaDyD8Rjg72rnTSLU9ujPhOUAc2RP9XRnt9K1AMu1M1ebO1TC6EvheJIBdQ61ww0OIK5VaDFzb/rfIoBdTXVtrhro4mjWQghlPPsQsKoiGYdvJP1u5e8gRG43zdaQlgwi8cJpIau1FvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758798; c=relaxed/simple;
	bh=5XAANTXu2gUsMh7qkGkdsQ8FsRgV4pWlfxM+TMLWEqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGguIdSd+8bZ4pFb4Ys/0pVCpQxdjKoN6bqzd3gtT8PB1FBMwfeg6IP82aSFp4kBhJxOMvBna860FFqZkhjzzFUqUKlFR1X5XHfblL4TH4vZ4qsMajdDL6uxAppcHbFruD6/u3mqwnvQ7x2Qiesb9EYKJgzt9TJCE2NJYEc2IyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcgmJv7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD82C4CEE3;
	Tue, 24 Jun 2025 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750758797;
	bh=5XAANTXu2gUsMh7qkGkdsQ8FsRgV4pWlfxM+TMLWEqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcgmJv7Oh6Z55J+dMDRSbEDApbfm0GMGr/iBroe01z57sF4pu8159EHNG15Z7RWst
	 UN6v6ULBSKQ0VNmcSy75aH3eEP3tnqzjL9BiW5Ts3JoPBuFA+awnTJ05JpqCmJC11V
	 bYNizUAEgtY93RtqDHBdnXI7Y2T+ughdJbFth5Dlt53J0Iy4JUYJZp7yNEV6s81NZC
	 cR1Jv8ECkGHTG345c2CGTY0f8XJ+xIpUpsTUWyh/8xbS4Pi2/+kA4BXKDUXdlVShmJ
	 SAuc3Rnisb3Yf2/qBQJoZL3w12dyVtFFX7/5wqHcuLhHqJrP5TdoYGikGQsOxCfufC
	 lhEp53L3Y6J6w==
Date: Tue, 24 Jun 2025 10:53:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
Message-ID: <20250624095313.GB8266@horms.kernel.org>
References: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
 <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>

On Mon, Jun 23, 2025 at 06:01:16PM +0200, Jacek Kowalski wrote:
> As described by Vitaly Lifshits:
> 
> > Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> > driver cannot perform checksum validation and correction. This means
> > that all NVM images must leave the factory with correct checksum and
> > checksum valid bit set.
> 
> Unfortunately some systems have left the factory with an empty checksum.
> NVM is not modifiable on this platform, hence ignore checksum 0xFFFF on
> Tiger Lake systems to work around this.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
> Cc: stable@vger.kernel.org
> ---
> v2: new check to fix yet another checksum issue
>  drivers/net/ethernet/intel/e1000e/defines.h | 1 +
>  drivers/net/ethernet/intel/e1000e/nvm.c     | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
> index 8294a7c4f122..01696eb8dace 100644
> --- a/drivers/net/ethernet/intel/e1000e/defines.h
> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
> @@ -637,6 +637,7 @@
>  
>  /* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
>  #define NVM_SUM                    0xBABA
> +#define NVM_SUM_FACTORY_DEFAULT    0xFFFF
>  
>  /* PBA (printed board assembly) number words */
>  #define NVM_PBA_OFFSET_0           8
> diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
> index e609f4df86f4..37cbf9236d84 100644
> --- a/drivers/net/ethernet/intel/e1000e/nvm.c
> +++ b/drivers/net/ethernet/intel/e1000e/nvm.c
> @@ -558,6 +558,11 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
>  		checksum += nvm_data;
>  	}
>  
> +	if (hw->mac.type == e1000_pch_tgp && checksum == (u16)NVM_SUM_FACTORY_DEFAULT) {

I see that a similar cast is applied to NVM_SUM. But why?
If it's not necessary then I would advocate dropping it.

> +		e_dbg("Factory-default NVM Checksum on TGP platform - ignoring\n");
> +		return 0;
> +	}
> +
>  	if (checksum != (u16)NVM_SUM) {
>  		e_dbg("NVM Checksum Invalid\n");
>  		return -E1000_ERR_NVM;
> -- 
> 2.47.2
> 
> 

