Return-Path: <netdev+bounces-122425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D90961418
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E3DB21E84
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0028C1CB14E;
	Tue, 27 Aug 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff3XjyZn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2A1C3F1D
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776343; cv=none; b=XVolCm4fxRraIAldjEckzrmcngS5kwZzE4/W/Znz/kuP4hV2Xvrkz+v3zyLOSwwjcR4tEz4TSREt6TggwwkFJ0tgojQFSEZ1F7k8oLK/dS14yQxYvuZOq9Nh2Bwl0fRbibNECzogjqWZpLS9Ut47eFVRJCEbfYUnyDr73guSzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776343; c=relaxed/simple;
	bh=Nbp+yuVnRc+tOJwPJCa9jHXAgbZF9LHPie1TyjZFmTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyKN+VokVfjJkHAEkmOM0loF9uJg1XRbglYLqsDYyryoQJruxJHdP6lH1bWl5KUgDPUCt4e2OOl9DJm2tcHf9UYusaN0pOShY8Dd24gyP/YSmiaGhIhWwkrxJaYqZqXUUU+IKFWpIY451HpoVF6o+Ed5rbc3oBgE+fOvtoqXbZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff3XjyZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D020EC4CA0B;
	Tue, 27 Aug 2024 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776343;
	bh=Nbp+yuVnRc+tOJwPJCa9jHXAgbZF9LHPie1TyjZFmTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ff3XjyZnmxBOSQ8HI/6e2mPPz2rrrmfn9E2N1WsoitmCrMF5EoTvsX8QBBkhNpukU
	 X5RojnNNvmjgbOzVeIyUgYwN1mD9NCuP5112B14UoOeWgEqu2uT8KrhdaLjoIYGYTG
	 SKOHmZhBMNFPLzvhXcjlUJmn2bRmmAcZ1T3ZBQ8QfmC2+pVZ+/YwlC4jjE8bkn9/26
	 8PwyN+MmpteeNxZ7KTmdNHos6UCzUPYwvOhO/S5JWfNJd1ebAyEdzoH58ely6FOTII
	 FKMTiNVeSXrXhbxC5iBZZY4omIzfl9ysUzaVcU1r4AgA0dEUBMgkurZboqDgVyeAno
	 C3O+wOqCXgrUA==
Date: Tue, 27 Aug 2024 17:32:18 +0100
From: Simon Horman <horms@kernel.org>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
	ndabilpuram@marvell.com
Subject: Re: [PATCH net-next,1/2] octeontx2-af: reduce cpt flt interrupt
 vectors for CN10KB
Message-ID: <20240827163218.GO1368797@kernel.org>
References: <20240827042512.216634-1-schalla@marvell.com>
 <20240827042512.216634-2-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827042512.216634-2-schalla@marvell.com>

On Tue, Aug 27, 2024 at 09:55:11AM +0530, Srujana Challa wrote:
> On CN10KB, number of flt interrupt vectors are reduced to
> 2. So, modify the code accordingly for cn10k.

I think it would be nice to state that the patch moves
away from a hard-coded to dynamic number of vectors.
And that this is in order to accommodate the CN10KB,
which has 2 vectors, as opposed to chips supported by
the driver to date, which have 3.

> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> index 3e09d2285814..e56d27018828 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
> @@ -37,6 +37,44 @@
>  	(_rsp)->free_sts_##etype = free_sts;                        \
>  })
>  
> +#define MAX_AE  GENMASK_ULL(47, 32)
> +#define MAX_IE  GENMASK_ULL(31, 16)
> +#define MAX_SE  GENMASK_ULL(15, 0)

nit: Maybe a blank line here.

> +static u32 cpt_max_engines_get(struct rvu *rvu)
> +{
> +	u16 max_ses, max_ies, max_aes;
> +	u64 reg;
> +
> +	reg = rvu_read64(rvu, BLKADDR_CPT0, CPT_AF_CONSTANTS1);
> +	max_ses = FIELD_GET(MAX_SE, reg);
> +	max_ies = FIELD_GET(MAX_IE, reg);
> +	max_aes = FIELD_GET(MAX_AE, reg);
> +
> +	return max_ses + max_ies + max_aes;

Maybe I am wrong, but it looks like this will perform u16 addition.
Can that overflow? I ask because the return type is u32, implying
values larger than 64k are expected.

> +}
> +
> +/* Number of flt interrupt vectors are depends on number of engines that the
> + * chip has. Each flt vector represents 64 engines.
> + */
> +static int cpt_10k_flt_nvecs_get(struct rvu *rvu)
> +{
> +	u32 max_engs;
> +	int flt_vecs;
> +
> +	max_engs = cpt_max_engines_get(rvu);
> +
> +	flt_vecs = (max_engs / 64);
> +	flt_vecs += (max_engs % 64) ? 1 : 0;

I don't think the parentheses are needed on the lines above.
And likewise elsewhere in this patch.

At any rate, here, I think you can use DIV_ROUND_UP.

> +
> +	if (flt_vecs > CPT_10K_AF_INT_VEC_FLT_MAX) {
> +		dev_warn(rvu->dev, "flt_vecs(%d) exceeds the max vectors(%d)\n",
> +			 flt_vecs, CPT_10K_AF_INT_VEC_FLT_MAX);
> +		flt_vecs = CPT_10K_AF_INT_VEC_FLT_MAX;
> +	}

cpt_max_engines_get seems to get called quite a bit.
I think dev_warn_once() is probably appropriate here.

> +
> +	return flt_vecs;
> +}
> +
>  static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
>  {
>  	struct rvu_block *block = ptr;
> @@ -150,17 +188,25 @@ static void cpt_10k_unregister_interrupts(struct rvu_block *block, int off)
>  {
>  	struct rvu *rvu = block->rvu;
>  	int blkaddr = block->addr;
> +	u32 max_engs;
> +	u8 nr;
>  	int i;
>  
> +	max_engs = cpt_max_engines_get(rvu);
> +
>  	/* Disable all CPT AF interrupts */
> -	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(0), ~0ULL);
> -	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(1), ~0ULL);
> -	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(2), 0xFFFF);
> +	for (i = CPT_10K_AF_INT_VEC_FLT0; i < cpt_10k_flt_nvecs_get(rvu); i++) {

I think it would be best to cache the value of cpt_10k_flt_nvecs_get()
rather than run it for each iteration of the loop. I'm assuming it has a
non-zero cost as it reads a register, the value of which which I assume
does not change.

Also, the same register is already read by the call to
cpt_max_engines_get(). It would be nice to read it just once in this scope.

Likewise elsewhere.

Also, there is an inconsistency between the type of i and the return type
of cpt_10k_flt_nvecs_get(). Probably harmless, but IMHO it would be nice to
fix.

> +		nr = (max_engs > 64) ? 64 : max_engs;
> +		max_engs -= nr;
> +		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(i),
> +			    INTR_MASK(nr));
> +	}
>  
>  	rvu_write64(rvu, blkaddr, CPT_AF_RVU_INT_ENA_W1C, 0x1);
>  	rvu_write64(rvu, blkaddr, CPT_AF_RAS_INT_ENA_W1C, 0x1);
>  
> -	for (i = 0; i < CPT_10K_AF_INT_VEC_CNT; i++)
> +	/* CPT AF interrupt vectors are flt_int, rvu_int and ras_int. */
> +	for (i = 0; i < cpt_10k_flt_nvecs_get(rvu) + 2; i++)

It would be nice to avoid the naked '2' here.
Perhaps a macro is appropriate.

>  		if (rvu->irq_allocated[off + i]) {
>  			free_irq(pci_irq_vector(rvu->pdev, off + i), block);
>  			rvu->irq_allocated[off + i] = false;

...

-- 
pw-bot: cr

