Return-Path: <netdev+bounces-209051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDA3B0E1DF
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD91C85E65
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0C27C152;
	Tue, 22 Jul 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAFuwn1t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57E27BF89
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201669; cv=none; b=sbKa5xeTYZ3Bbnt8ThHFHSJZwC+sJdE8UhwAM+MwEUpy/QZfbj58vHUYTJFOE247b5RzoL2b02JtgFfADwovjtjgFV5HZOosNd8jwJLJItFUXIoivXLLCDQEx7vHj8qM+zE7UrDkOahXctG1h3uWOtBbBbVvTNxVSr+UCjG3jx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201669; c=relaxed/simple;
	bh=iwg2jPPHuouTBvDaVmFWT/7WpR84q9NUpZsaCWGq8cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMkvy6QLgY6f1xPQDtZ744T4jee2vM3uguShPze0GrJ7a/LdwXg5bQ7i/Y3/8qUhq+QyAb6X6e0339KH8fqAasmbV+BGSgcjW4EdHF/usyTcMmxSzTQPx035ESOFs3BaWAcggB6UGBq5oC9/YoJyinYn7NDCIV8KbidiRS5c+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAFuwn1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038A4C4CEEB;
	Tue, 22 Jul 2025 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201668;
	bh=iwg2jPPHuouTBvDaVmFWT/7WpR84q9NUpZsaCWGq8cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAFuwn1tWSuhZWPz6wZ3D2/hLGyKvVKGXRF/xOzqhPFZB2KbWW2wItEKYO7W9YYYg
	 e3f24dxZTffU2HMQXbZUFGs8ipTdtiSE/+/+eSM4gVVsBjDgCWefesSoeojEZtmu9h
	 IjMoPRa3hlCnt/H03+aX/cm1uEHXS5j/fvf62jWxgTlkavrliYSIhFAj1muM5KrVKw
	 hvXx2S170b1YNIaMCX5jVrM3py4XQCqM799hPk2f8bbKp1TLyaLwyyigJdydXCH1yO
	 kqnSI/MIwvhIG9JK7IneNHArjAkz0lbcut7ccz9Zei0n44PsVWLLRykQ5LhwlMAQEG
	 v0Er0h38kEF6g==
Date: Tue, 22 Jul 2025 17:27:43 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	lcherian@marvell.com, sgoutham@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 01/11] octeontx2-af: Simplify context writing
 and reading to hardware
Message-ID: <20250722162743.GN2459@horms.kernel.org>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-2-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752772063-6160-2-git-send-email-sbhatta@marvell.com>

On Thu, Jul 17, 2025 at 10:37:33PM +0530, Subbaraya Sundeep wrote:
> Simplify NIX context reading and writing by using hardware
> maximum context size instead of using individual sizes of
> each context type.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> index 0596a3ac4c12..1097c86fdc46 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
> @@ -13,6 +13,8 @@
>  
>  #define RVU_MULTI_BLK_VER		0x7ULL
>  
> +#define NIX_MAX_CTX_SIZE		128
> +
>  /* RVU Block Address Enumeration */
>  enum rvu_block_addr_e {
>  	BLKADDR_RVUM		= 0x0ULL,
> @@ -370,8 +372,12 @@ struct nix_cq_ctx_s {
>  	u64 qsize		: 4;
>  	u64 cq_err_int		: 8;
>  	u64 cq_err_int_ena	: 8;
> +	/* Ensure all context sizes are minimum 128 bytes */

Would this be better phrased as follows?

	/* Ensure all context sizes are 128 bytes */

> +	u64 padding[12];
>  };
>  
> +static_assert(sizeof(struct nix_cq_ctx_s) == NIX_MAX_CTX_SIZE);

I would suggest adding +static_assert() for all the
drivers that you expect to be NIX_MAX_CTX_SIZE.

So also:
- struct nix_rq_ctx_s
- struct nix_sq_ctx_s
- struct nix_bandprof_s

> +
>  /* CN10K NIX Receive queue context structure */
>  struct nix_cn10k_rq_ctx_s {

