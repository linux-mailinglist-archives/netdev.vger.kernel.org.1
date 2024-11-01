Return-Path: <netdev+bounces-140966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFC39B8EC0
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80C34B21212
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B715990C;
	Fri,  1 Nov 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQiLPR92"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95C14F9F8;
	Fri,  1 Nov 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455717; cv=none; b=koRqu4KVx2cpbGPeZaPREkcZUolhtiUuPTt9hTaAjiJ4y/RTrhicDg/OHb+P3AKliV+K7qZpDFQVxcZzUanOw0fPUb+82DHnTtZ212fN2VT+R6jagkHOg9AdnrUCdEzTyQN4GXda0xXN4Oqrwuan9nOmpsBfbn7wlNJo9KcvrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455717; c=relaxed/simple;
	bh=HtIMtOiyQPrNZJEKV7JSj/Zo5XtwvXo8ylCzsjnN/yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHhlB52WOV16tV4AzxUFE0v6tIBKe/Bn50TKbVU4P1uvX/5O2COp/4fF6PtHxIZFqTWN8ufQT+LIq+MaOeZDcbi5ijfZlA1hl0tuMOpNaaxH2SoZigB0xUOzJYXETaZCPYEuqNDebjJa42iaOEccJjD6xRyO1PvsiUVzKmvKzDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQiLPR92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BB4C4CECD;
	Fri,  1 Nov 2024 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730455717;
	bh=HtIMtOiyQPrNZJEKV7JSj/Zo5XtwvXo8ylCzsjnN/yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQiLPR92V2fsn0lt/2cFXJqYrrG+KW9fcFe3Vue+aU9rCu6hGKelhfaXhLBpHFGTk
	 we9vw69DLMG+w35Ltzhx0rAJ2lGzNPbKKtP75bMo6kQmydtRjGnAlci6ZrXA+dcqJW
	 n/c5lUQa7LTZPfv14yqwRtkrsFAP3mgR5dwrsPOZD1QmSf+O6Aq9H9FlaQWxguFUkE
	 JosHZe59MLd15DrvUjd6OnSVD5R2RbEKCiWI/woc1fo0SMlrZA7zMtWx0SnfbTL6kr
	 WSu/kMR1KSLDq0ap/5ucPJr+GkPPKLngDCr+Mcf67ZXfLcDvNAPs1tN6dwxjeqKk8P
	 zKTx2mrX158UA==
Date: Fri, 1 Nov 2024 10:08:32 +0000
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [net-next PATCH v2 1/6] octeontx2: Set appropriate PF, VF masks
 and shifts based on silicon
Message-ID: <20241101100832.GC1838431@kernel.org>
References: <20241022185410.4036100-1-saikrishnag@marvell.com>
 <20241022185410.4036100-2-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022185410.4036100-2-saikrishnag@marvell.com>

On Wed, Oct 23, 2024 at 12:24:05AM +0530, Sai Krishna wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Number of RVU PFs on CN20K silicon have increased to 96 from maximum
> of 32 that were supported on earlier silicons. Every RVU PF and VF is
> identified by HW using a 16bit PF_FUNC value. Due to the change in
> Max number of PFs in CN20K, the bit encoding of this PF_FUNC has changed.
> 
> This patch handles the change by exporting PF,VF masks and shifts
> present in mailbox module to all other modules.
> 
> Also moved the NIX AF register offset macros to other files which
> will be posted in coming patches.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 5016ba82e142..938a911cbf1c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -41,10 +41,10 @@
>  #define MAX_CPT_BLKS				2
>  
>  /* PF_FUNC */
> -#define RVU_PFVF_PF_SHIFT	10
> -#define RVU_PFVF_PF_MASK	0x3F
> -#define RVU_PFVF_FUNC_SHIFT	0
> -#define RVU_PFVF_FUNC_MASK	0x3FF
> +#define RVU_PFVF_PF_SHIFT	rvu_pcifunc_pf_shift
> +#define RVU_PFVF_PF_MASK	rvu_pcifunc_pf_mask
> +#define RVU_PFVF_FUNC_SHIFT	rvu_pcifunc_func_shift
> +#define RVU_PFVF_FUNC_MASK	rvu_pcifunc_func_mask

Hi Subbaraya and Sai,

I see that this is in keeping with the implementation prior to this patch.
But, FWIIW, if FIELD_PREP() and friends were used then I expect the _SHIFT
defines could be removed entirely.

Please consider as a follow-up at some point.

>  
>  #ifdef CONFIG_DEBUG_FS
>  struct dump_ctx {

...

