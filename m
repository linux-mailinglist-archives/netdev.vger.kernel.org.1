Return-Path: <netdev+bounces-124641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB9096A4DA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E211C23A40
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98D18BC08;
	Tue,  3 Sep 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFVhE7HU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF818BB9F;
	Tue,  3 Sep 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382290; cv=none; b=cBDvjvUP9L9mkIbINHy86XoOVzTHl3odit9UidDtDfsWCiD6ElR18zXgE6gx4EBqOiH5ypcX4NSB7tyyi+9e2awupdO8yLq1/3swHYEbRZUZFXVRTkx9dXJFPlKvyylQevxkJg23fcVjasfk3ozTCfmOnZLaDJ4/FTGZ/iCnNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382290; c=relaxed/simple;
	bh=v6QUWDn3Xk0vLTb/0TXXT0hs0RxaaMRHOSxlGXdBePM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQpSfa9rb1G3yT7lKB4y8J7xIDpsOLaXL4wSdrrQqJjf+LSBZOb3fdwKwiyExWdeMqVMEFmV6CNYYXPwmdRKHg5BdLyHSyg5DNLc5cCNPQRwMK6itgX5rwPl8rvCTe9QcaQA6MmOaebzO1ifd2/wFxQwone0YGsIZfFNBfozqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFVhE7HU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9B3C4CEC4;
	Tue,  3 Sep 2024 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725382290;
	bh=v6QUWDn3Xk0vLTb/0TXXT0hs0RxaaMRHOSxlGXdBePM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFVhE7HUztDHKoswnzl716+1BfpdDKMFPobGsXUUzoyxEc/JwV1DKOdwH2dNzPPCp
	 +84ICnp9h4Vz4Os3Ngpo+r7TM0OLxTfH4We+YPI8IM3x5IQGojqgOsxeQIROIzBtHn
	 1V9tRetREZ2idlJ/DoIR1S1oZC+CH6Gf1KenFx0uo08pjZGigUD+4imoTwgV08yhkG
	 Nl355Yq8OYzFYRSInPciya4dZM/OVDn72lyB2nB7Q8ccPOwS7q0vEnMtwGSX9GAVob
	 7t8+z+dljI2JPLmFrBSNuCizFgeVOjKbcRwkdtIkkvE3jO9sE+B/2+5+icsNt6WeW3
	 O/pyypMxBEOiQ==
Date: Tue, 3 Sep 2024 17:51:24 +0100
From: Simon Horman <horms@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH net-next 0/2] octeontx2: Address some Sparse warnings
Message-ID: <20240903165124.GG4792@kernel.org>
References: <20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org>

On Tue, Sep 03, 2024 at 05:26:52PM +0100, Simon Horman wrote:
> Hi,
> 
> This patchset addresses some Sparse warnings that are flagged in files
> touched by recent patch submissions.

Oops, I now realise that the issue addressed by patch 1/2 is
not described there as being flagged by Sparse.

I'll plan to send a v2, with an updated cover letter,
after an appropriate timeout. Any review in the meantime
would be appreciated.

> 
> Although these changes do not alter the functionality of the code, by
> addressing them real problems introduced in future which are flagged by
> Sparse will stand out more readily.
> 
> Compile tested only.
> 
> ---
> Simon Horman (2):
>       octeontx2-af: Pass string literal as format argument of alloc_workqueue()
>       octeontx2-pf: Make iplen __be16 in otx2_sqe_add_ext()
> 
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.c        | 4 ++--
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> base-commit: 54f1a107bd034e8d9052f5642280876090ebe31c

-- 
pw-bot: cr

