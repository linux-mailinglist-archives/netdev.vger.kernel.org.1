Return-Path: <netdev+bounces-223995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12938B7C89F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A83BD37E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7757D30F93A;
	Wed, 17 Sep 2025 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZa3cJYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61F1E32B9;
	Wed, 17 Sep 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110148; cv=none; b=aVzD9oD0Lj10M9jlrDnzrABWPuBHAxDL5CjZh/xrRzQUiEfvpyITG8+YzNxF+u5sbzlNan9fxyXPAzGAUg/5P9fnyhzCPx//KZBX8t9lBHNiRaQ+5hDQul/cRrdjIYh69ZedDwnex+euXsf9/YUc2XUFjtrhyPGN22YlDGK3/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110148; c=relaxed/simple;
	bh=DU4gxgbx65FsLQiFOCl1ZpFN4B1SDz2XuaVWJL83vYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqOs+6vSy///uxQSMzJoeULoTBusQADDVNPgF220AB7tdxsOvQ6jZ7+B1YMKj7bDoyNxxaOVxtvBge9tpV7pxGgKAMhcvHlUoRz1I+4OFpqqfdwmcvOSfpIL4oLJpdw9RRyzn0MZArq0wVRgZcwyfPIiEhudsqEWxZIwaVGZc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZa3cJYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B5DC4CEF0;
	Wed, 17 Sep 2025 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758110146;
	bh=DU4gxgbx65FsLQiFOCl1ZpFN4B1SDz2XuaVWJL83vYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZa3cJYpPOWrn2Y3HUiznWvb7PqCcanOlOp/absxm7F1zW4SWZTK3MKNzNekiAF9L
	 rJfmsXWTbBf0pJRn50m8dHW51naVFpJChdsE4J0nvNiukmpOseJ64X+lpaPVdtBSnO
	 Z1kYCFboqxI8/aI7LKXqhkFiqBauC2xmETqN8Eb/4P2/DyLYCgRI6U8gi5yH7nyRAV
	 JEuEob9PvAE5UgRB5e4BSbObMZmH2lth1NEYrYGS5irhOPL4k/5OiayE4OwB199JIT
	 AHAW9MHO17dWPi69tktp+vwW3wkhvswah9sWW57lQmwbc13vwd/JNmneeQZUd7F2wo
	 x6XWoHXt0lrlA==
Date: Wed, 17 Sep 2025 12:55:42 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, hgani@marvell.com,
	andrew@lunn.ch, srasheed@marvell.com
Subject: Re: [net PATCH v2] octeon_ep: Clear VF info at PF when VF driver is
 removed
Message-ID: <20250917115542.GA394836@horms.kernel.org>
References: <20250916131225.21589-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916131225.21589-1-sedara@marvell.com>

On Tue, Sep 16, 2025 at 06:12:25AM -0700, Sathesh B Edara wrote:
> When a VF (Virtual Function) driver is removed, the PF (Physical Function)
> driver continues to retain stale VF-specific information. This can lead to
> inconsistencies or unexpected behavior when the VF is re-initialized or
> reassigned.
> 
> This patch ensures that the PF driver clears the corresponding VF info
> when the VF driver is removed, maintaining a clean state and preventing
> potential issues.
> 
> Fixes: cde29af9e68e ("octeon_ep: add PF-VF mailbox communication")
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>
> ---
> Changes:
> V2:
>   - Commit header format corrected.

Hi,

I feel that I must be missing something terribly obvious.
But this patch seems to be a subset of the one at the link below.

* [net PATCH v2] octeon_ep: fix VF MAC address lifecycle handling
  https://lore.kernel.org/netdev/20250916133207.21737-1-sedara@marvell.com/

> 
>  drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> index ebecdd29f3bd..f2759d2073d1 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> @@ -205,6 +205,8 @@ static void octep_pfvf_dev_remove(struct octep_device *oct,  u32 vf_id,
>  {
>  	int err;
>  
> +	/* Reset VF-specific information maintained by the PF */
> +	memset(&oct->vf_info[vf_id], 0, sizeof(struct octep_pfvf_info));
>  	err = octep_ctrl_net_dev_remove(oct, vf_id);
>  	if (err) {
>  		rsp->s.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> -- 
> 2.36.0
> 
> 

