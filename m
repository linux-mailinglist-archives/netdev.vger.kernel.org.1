Return-Path: <netdev+bounces-200812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31504AE7005
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFAE87B373B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF3A2EA73E;
	Tue, 24 Jun 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1wXUiJw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0E2EA47F;
	Tue, 24 Jun 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794163; cv=none; b=DtigHPLCKLTRACXg/rFPbmuOEGRQ6WV5DqrjL95ShRfX3ZkLYd9Sr60Z+bkoEUrTPRR8MzHCDX6Bk51hJ4K0y/VW37umNqFmANpKnfWHgZ0NqTRdXssCKARegNw1hIHlNTGOOycfnQgxUHxtIaHmh+zNOC9/naI7dTDRKGplhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794163; c=relaxed/simple;
	bh=3lct2tXBhg0hauj12oOI+SFqS8LdvmA8WthvJzKPRso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaRRmfJ+YJm2XevN0++/dtyuQjh8BOltAKt3lbauQ8Q82HpElWXI02n5hNwgyx0y0r5BL4tWpL88e87jrW2WMVFKw9OBKhNrBbNzMaQAjoqp75pc9H4z+7/RcIWSfnkt5IRR/+PGWaK3EgCmwIkX3nfeTJ7df+uTKFO9hRQkQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1wXUiJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFACC4CEE3;
	Tue, 24 Jun 2025 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750794161;
	bh=3lct2tXBhg0hauj12oOI+SFqS8LdvmA8WthvJzKPRso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1wXUiJwFsgWiK18mURpjC5zrhYGFVh/Zp3epeiskMHVCNhcA88tQgmevNjsqOp6s
	 eNEoPcO1uYdQx0BENdHhS7YEr7LBXQkvMcJ41mgF8FMwsYzOPApQ37SM6dWDywGIz/
	 crWwbhMzpT4q6F9A5OLBmri8XebkHb6LjQ+tV1Pe/exaQfzcRGctDcTHueDO8rz/YV
	 hBzpGhDq8ICq5GzwjjWZOw9Zyzm/21nrqU3hMDSYdjfX7BTVU9h8NvUpJuNSpw+8i8
	 Ran+zMtyNo7mh/x4+56rUjaRno/912cy7uidRUMrmDC1vzhO2crrLVl1zBAhl3BpgX
	 +5uAkjkCEyxig==
Date: Tue, 24 Jun 2025 20:42:37 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vlad URSU <vlad@ursu.me>
Subject: Re: [PATCH v3 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
Message-ID: <20250624194237.GI1562@horms.kernel.org>
References: <91030e0c-f55b-4b50-8265-2341dd515198@jacekk.info>
 <5c75ef9b-12f5-4923-aef8-01d6c998f0af@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c75ef9b-12f5-4923-aef8-01d6c998f0af@jacekk.info>

On Tue, Jun 24, 2025 at 09:14:40PM +0200, Jacek Kowalski wrote:
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

I think that you need to update the patch description.
As of v3 it's the last word of the checksum that is being checked,
not the entire checksum.

> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Tested-by: Vlad URSU <vlad@ursu.me>
> Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
> Cc: stable@vger.kernel.org
> ---
> v2: new check to fix yet another checksum issue
> v2 -> v3: fix variable bein compared, drop u16 cast
>  drivers/net/ethernet/intel/e1000e/defines.h | 3 +++
>  drivers/net/ethernet/intel/e1000e/nvm.c     | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
> index 8294a7c4f122..2dcf46080533 100644
> --- a/drivers/net/ethernet/intel/e1000e/defines.h
> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
> @@ -638,6 +638,9 @@
>  /* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
>  #define NVM_SUM                    0xBABA
>  
> +/* Factory-default checksum value */
> +#define NVM_CHECKSUM_FACTORY_DEFAULT 0xFFFF

Perhaps it is too long, but I liked Vlad's suggestion of
naming this NVM_CHECKSUM_WORD_FACTORY_DEFAULT.

> +
>  /* PBA (printed board assembly) number words */
>  #define NVM_PBA_OFFSET_0           8
>  #define NVM_PBA_OFFSET_1           9
> diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
> index e609f4df86f4..56f2434bd00a 100644
> --- a/drivers/net/ethernet/intel/e1000e/nvm.c
> +++ b/drivers/net/ethernet/intel/e1000e/nvm.c
> @@ -558,6 +558,11 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
>  		checksum += nvm_data;
>  	}
>  
> +	if (hw->mac.type == e1000_pch_tgp && nvm_data == NVM_CHECKSUM_FACTORY_DEFAULT) {

Please wrap the line above so it is 80 columns wide or less.

	if (hw->mac.type == e1000_pch_tgp &&
	    nvm_data == NVM_CHECKSUM_FACTORY_DEFAULT) {

> +		e_dbg("Factory-default NVM Checksum on TGP platform - ignoring\n");
> +		return 0;
> +	}
> +
>  	if (checksum != (u16)NVM_SUM) {
>  		e_dbg("NVM Checksum Invalid\n");
>  		return -E1000_ERR_NVM;

-- 
pw-bot: changes-requested

