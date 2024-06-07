Return-Path: <netdev+bounces-101871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5F900597
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1B5290336
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3789194C68;
	Fri,  7 Jun 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KezXAx2W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F012194AC7
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768250; cv=none; b=Lz4/yK6jddoGLJD9j4KzmWsDgaAmCJLrWKP2jRpjHz8k3SpCTlft7Tz1S+ZtCVYESUIG1O1H/d1RXwu8tj2AyA7rhBZys3qhjRTzfQxQAqbHtf+4RHJMOoUtJJWSrx0l/SFEiRsuoefOtIzZW3oaViU6HgMq7m9f7y2gJDFRMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768250; c=relaxed/simple;
	bh=Lsp/iG7vQmQA6feKEwyerNC8f/0/+dCbzXMWT7z0Br0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS29hdjW5kA4y6gbyh7rwRjeZXBhFTz/sM6wX1hHBWvhbEr8u70RTo7l7oAm2rhQtSzIQr8iyKR1uecbF5eZf9ROoyD9qdZKL9NB+E8AR3UUbIIjh9x6RiC06P7aXdd/Bmvc/q3j8LqeioxjQmB/KL6GlcFZYua0HEP2+jQPAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KezXAx2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAFDC32786;
	Fri,  7 Jun 2024 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717768250;
	bh=Lsp/iG7vQmQA6feKEwyerNC8f/0/+dCbzXMWT7z0Br0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KezXAx2WPlStxcKCCBg7AegMjAJqMO9qz2juR95gYGa8HErnGasTgAqerRnD7PqbE
	 +JkguFRMJ/v4zef0sRIm3+ZIsBmBvUvOyEtXIB4UiLcJS1b4267spphvc4+ehmN6SP
	 /yT6JwPAm6pdRrSxoSlFCL24uW0sEsXdBF2UOOeP0kIS7MAwTnsfTNBTtptsZmq6A2
	 Trjc8ejIeWn3RF+vlML7R5UkxWxWPMi/vQlkeGOC023vjLP7klvFf17g6nCozRtHnd
	 SS+iuP0Qm3zNaycRUBcHt0FWmdfIaN0qqrmLLPTeD7rlqldjjXVdg3JTLMz2JJSrx+
	 mRr9dLz3n1xKA==
Date: Fri, 7 Jun 2024 14:50:46 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG
 forwarded response
Message-ID: <20240607135046.GD27689@kernel.org>
References: <20240606175107.53130-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606175107.53130-1-michael.chan@broadcom.com>

On Thu, Jun 06, 2024 at 10:51:07AM -0700, Michael Chan wrote:
> Firmware interface 1.10.2.118 has increased the size of
> HWRM_PORT_PHY_QCFG response beyond the maximum size that can be
> forwarded.  When the VF's link state is not the default auto state,
> the PF will need to forward the response back to the VF to indicate
> the forced state.  This regression may cause the VF to fail to
> initialize.
> 
> Fix it by capping the HWRM_PORT_PHY_QCFG response to the maximum
> 96 bytes.  Also modify bnxt_hwrm_fwd_resp() to print a warning if the
> message size exceeds 96 bytes to make this failure more obvious.
> 
> Bug: DCSG01725771
> Change-Id: I4cd5e06a7625f9d06e779e4acd9603d355883e7c

Hi Michael,

Does the above relate to publicly available information?
If so, a link is probably in order. If not, let's drop it.

> Fixes: 84a911db8305 ("bnxt_en: Update firmware interface to 1.10.2.118")
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

...

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c

...

> @@ -1096,6 +1099,8 @@ static int bnxt_vf_set_link(struct bnxt *bp, struct bnxt_vf_info *vf)
>  		mutex_unlock(&bp->link_lock);
>  		phy_qcfg_resp.resp_len = cpu_to_le16(sizeof(phy_qcfg_resp));
>  		phy_qcfg_resp.seq_id = phy_qcfg_req->seq_id;
> +		phy_qcfg_resp.option_flags &=
> +			~PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED;

I may be missing something obvious, but it is not clear to me
how this change relates to the rest of the patch.

>  		phy_qcfg_resp.valid = 1;
>  
>  		if (vf->flags & BNXT_VF_LINK_UP) {
> -- 
> 2.30.1
> 



