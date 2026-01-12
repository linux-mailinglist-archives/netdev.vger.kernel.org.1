Return-Path: <netdev+bounces-249056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CBD1342B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BED1303851D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06927C842;
	Mon, 12 Jan 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjCTacTc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178AA279DAF;
	Mon, 12 Jan 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228788; cv=none; b=HOwb/pVIS2hn597wpa4h3xy92MLlSie0U1bTmjAntdfMcHGZHejPf8WHw7yPfja3Lh4OvGO1qLlLc1JirjzkTGN5EIQ1HAW8OHeA3r3XklvIR6rBqBulUtqGNQ1/fQqsnYeMkFD37x99EXASBuiEVhhtL3UmIAApG2Eghy8ac1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228788; c=relaxed/simple;
	bh=Bjyt5KUV8P+4QGX2zRHH3aY+0f1xiaDf64lQ7qf9Kes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdqyGrzmPSLz5uf3gl1u1Ka8TkhBeUBz4m67fODjKDs9FnCK605ytDWYo8l+7GNE/18OaEpdtPo6tHAngxOjrkRnw32/EC04lBqjEp4iQn+/Z+LCjNTZrqfpKIefmJJeTIBndiXUSziChMpmMUEgJXjCqhTQ9f1lbLPShSp8TY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjCTacTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC38C19422;
	Mon, 12 Jan 2026 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228787;
	bh=Bjyt5KUV8P+4QGX2zRHH3aY+0f1xiaDf64lQ7qf9Kes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjCTacTc+HRb9n57RJgZKPsBGvNjKECq6ff2ShXpqijLvhKLoqJiIncpFASCvMnqE
	 R0s6ebAhisTQPDfGm3+dRFlJWLVYkRX4w9AByxdW8WQXYza2oFJk7LlxyKiZff87Nd
	 0y0FmyPnJ9VxaUyZcsvXgd1KVpPVFVpISjxbPSgWQ29oKChl+Y+GcbgeJm4B4GU899
	 Lw5F3isMGLC+n/UmhcZshTXyeRjDPyn1S0kg/69/h0k9UTAKHj+coRUeCUJoLL8LQn
	 WLpCLJdCzqXEFToaMi4mAM/4Sfy4RZpXocGx2Sq+FDjuwMLy5HWXrcWaa5K4ExifF/
	 TiqjkgKxHLN/A==
Date: Mon, 12 Jan 2026 14:39:42 +0000
From: Simon Horman <horms@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sedara@marvell.com, srasheed@marvell.com, hgani@marvell.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3 3/3] octeon_ep_vf: ensure dbell BADDR updation
Message-ID: <aWUHrqOpf-6hZqlu@horms.kernel.org>
References: <20260107131857.3434352-1-vimleshk@marvell.com>
 <20260107131857.3434352-4-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107131857.3434352-4-vimleshk@marvell.com>

On Wed, Jan 07, 2026 at 01:18:56PM +0000, Vimlesh Kumar wrote:
> Make sure the OUT DBELL base address reflects the
> latest values written to it.
> 
> Fix:
> Add a wait until the OUT DBELL base address register
> is updated with the DMA ring descriptor address,
> and modify the setup_oq function to properly
> handle failures.
> 
> Fixes: 2c0c32c72be29 ("octeon_ep_vf: add hardware configuration APIs")
> Signed-off-by: Sathesh Edara <sedara@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
> ---
> V3:
> - Use reverse christmas tree order variable declaration.
> - Return error if timeout happens during setup oq.

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> index d70c8be3cfc4..6446f6bf0b90 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> @@ -171,7 +171,9 @@ static int octep_vf_setup_oq(struct octep_vf_device *oct, int q_no)
>  		goto oq_fill_buff_err;
>  
>  	octep_vf_oq_reset_indices(oq);
> -	oct->hw_ops.setup_oq_regs(oct, q_no);
> +	if (oct->hw_ops.setup_oq_regs(oct, q_no))
> +		goto oq_fill_buff_err;
> +

Hi Vimlesh, all,

I think that a new label needs to be added to the unwind ladder such that
octep_vf_oq_free_ring_buffers() is called if the error condition above is met.

Likewise in patch 2/3.

Flagged by Claude Code with Review Prompts[1]

[1] https://github.com/masoncl/review-prompts/

>  	oct->num_oqs++;
>  
>  	return 0;

-- 
pw-bot: cr

