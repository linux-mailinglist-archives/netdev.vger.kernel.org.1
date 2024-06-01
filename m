Return-Path: <netdev+bounces-99928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0BD8D713C
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2732F1C20D7C
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E00153506;
	Sat,  1 Jun 2024 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGTgOKaq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3A54650;
	Sat,  1 Jun 2024 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717260828; cv=none; b=FsnRMjzCaWKXkPMRmzLIQt/9IYrTqjcrC8Hsx4xqE5ZcJ2/FH+QXnCidd1XaIbwI80gryeBe0o7WiGN7EZ6V61UTBNSozaS8/UoD1b4mXl3+IHadJwL3lOWxcO6PjA2/EZfjCnEe2zjyLrEkZ6DvZlXaSFs+URQB6DAKVCkmEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717260828; c=relaxed/simple;
	bh=5+heAb7w9OghR5Rbj6S0QhipYZU0tDVGNTFIVXQlkWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfgN2nWmfdGp8bKw89+6qJnntprAVd5/+4hUwT2+5DCeDfSoC45Kb+pF083ALkQgJZtWhv0ZmV9asnHaiD6Lgx1vT04ry8TVyyXiBE7KgEOCuoYLNcWKMJD+I6khCJrVvucJVEcXGuPdcI60We/BtL52JU7hAHSttj7BAfPBE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGTgOKaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DFBC116B1;
	Sat,  1 Jun 2024 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717260827;
	bh=5+heAb7w9OghR5Rbj6S0QhipYZU0tDVGNTFIVXQlkWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vGTgOKaqJtvaEtlvsYjd9Gnc4dwsk2TBsdU8/VmHb8BsT1AaWldaFA1f5FP3Cc6ae
	 uQRdCguUXjbn9i77mqk2sXPY8RxZSJQ9uM822PZ8zppCb0eb6oQvKbHYQD1FW99mH+
	 B47BVCpLXtQSQZ+3DCvrVaf/Gx86wMWdMjUv24tXeteD+BqqOWpwZCYu6TqBO6Q0nV
	 EBSCnmzqBdtHGyta1pCSZ6x0DIT8otTpbvkeW+QK2zs/sKyBSdZwn094QkewV2A1fT
	 Ys++UlyR5kDBvIDowL6+gOUwQIh+ClYJ7d6K+1MQsygRLBxWfMAYF8m+WW7IikjFeV
	 nz2LLaTStturw==
Date: Sat, 1 Jun 2024 17:53:42 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: smc91x: Refactor SMC_* macros
Message-ID: <20240601165342.GS491852@kernel.org>
References: <20240531120103.565490-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531120103.565490-2-thorsten.blum@toblux.com>

On Fri, May 31, 2024 at 02:01:04PM +0200, Thorsten Blum wrote:
> Use the macro parameter lp directly instead of relying on ioaddr being
> defined in the surrounding scope.
> 
> The macros SMC_CURRENT_BANK(), SMC_SELECT_BANK(), SMC_GET_BASE(), and
> SMC_GET_REV() take an additional parameter ioaddr to use a different
> address if necessary (e.g., as in smc_probe()).
> 
> Relying on implicitly defined variable names in C macros is generally
> considered bad practice and can be avoided by using explicit parameters.
> 
> Compile-tested only.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Add macro parameter ioaddr where necessary to fix smc_probe() after
>   feedback from Jakub Kicinski
> - Update patch description
> - Link to v1: https://lore.kernel.org/linux-kernel/20240528104421.399885-3-thorsten.blum@toblux.com/
> ---
>  drivers/net/ethernet/smsc/smc91x.c | 132 +++++++++++--------------
>  drivers/net/ethernet/smsc/smc91x.h | 152 ++++++++++++++---------------
>  2 files changed, 131 insertions(+), 153 deletions(-)

Hi Thorsten,

This is a large and repetitive patch, which makes it hard to spot any errors
(I couldn't see any :)

I'm not sure if it is worth doing at this point,
but it might have been worth splitting the patch up,
f.e. by addressing one MACRO at a time, removing
local ioaddr variables as they become unused.

As highlighted bellow, checkpatch flags a lot of issues with
the code updated by this patch. Perhaps they could be addressed
as the lines with issues are updated. Or by patch(es) before
those that make the changes made by this patch. Or some combination
of the two.

...

> diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h

...

> @@ -839,64 +839,64 @@ static const char * chip_ids[ 16 ] =  {
>  #define SMC_MUST_ALIGN_WRITE(lp)	SMC_32BIT(lp)
>  
>  #define SMC_GET_PN(lp)						\
> -	(SMC_8BIT(lp)	? (SMC_inb(ioaddr, PN_REG(lp)))	\
> -				: (SMC_inw(ioaddr, PN_REG(lp)) & 0xFF))
> +	(SMC_8BIT(lp)	? (SMC_inb(lp->base, PN_REG(lp)))	\
> +				: (SMC_inw(lp->base, PN_REG(lp)) & 0xFF))
>  
>  #define SMC_SET_PN(lp, x)						\
>  	do {								\
>  		if (SMC_MUST_ALIGN_WRITE(lp))				\
> -			SMC_outl((x)<<16, ioaddr, SMC_REG(lp, 0, 2));	\
> +			SMC_outl((x)<<16, lp->base, SMC_REG(lp, 0, 2));	\

While we are here, I think we can address the whitespace issues
flagged by checkpatch - there should be spaces around '<<'.

Likewise elsewhere.

...

> -#define SMC_CURRENT_BANK(lp)	SMC_inw(ioaddr, BANK_SELECT)
> +#define SMC_CURRENT_BANK(lp, ioaddr)	SMC_inw(ioaddr, BANK_SELECT)

lp is not used in this macro, can it be removed?
Possibly as a follow-up?

Flagged by checkpatch.

>  
> -#define SMC_SELECT_BANK(lp, x)					\
> +#define SMC_SELECT_BANK(lp, x, ioaddr)					\
>  	do {								\
>  		if (SMC_MUST_ALIGN_WRITE(lp))				\
>  			SMC_outl((x)<<16, ioaddr, 12<<SMC_IO_SHIFT);	\
> @@ -904,125 +904,125 @@ static const char * chip_ids[ 16 ] =  {
>  			SMC_outw(lp, x, ioaddr, BANK_SELECT);		\
>  	} while (0)
>  
> -#define SMC_GET_BASE(lp)		SMC_inw(ioaddr, BASE_REG(lp))
> +#define SMC_GET_BASE(lp, ioaddr)	SMC_inw(ioaddr, BASE_REG(lp))
>  
> -#define SMC_SET_BASE(lp, x)	SMC_outw(lp, x, ioaddr, BASE_REG(lp))
> +#define SMC_SET_BASE(lp, x)	SMC_outw(lp, x, lp->base, BASE_REG(lp))

lp is now evaluated twice in this macro.
As the motivation of this patch seems to be about good practice,
perhaps we should avoid introducing a bad one?

Likewise in several other macros.

Flagged by checkpatch.

...

> -#define SMC_GET_CTL(lp)		SMC_inw(ioaddr, CTL_REG(lp))
> +#define SMC_GET_CTL(lp)		SMC_inw(lp->base, CTL_REG(lp))

I don't think this is introduced by this patch,
but perhaps it could be addressed.

Checkpatch says: Macro argument 'lp' may be better as '(lp)' to avoid precedence issues

Likewise elsewhere.

...

