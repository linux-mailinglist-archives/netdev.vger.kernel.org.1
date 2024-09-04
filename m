Return-Path: <netdev+bounces-125262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F368A96C847
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EF01C22752
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A59146A79;
	Wed,  4 Sep 2024 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beAnG/KO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546AB1386A7
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481239; cv=none; b=fZGAMCOqIfExBuaz+h287xE5ygpio4a44yAVRhtTdXY8SsyrJ51o+lwCZx5NTusPIy7IKPRjM7W6GoVifd/YbkluW7mKcdNhIa1C4tvzel0hrT14Qv/qJL+CjAlEUN+4xws6CaToxi2U8yEOu3bB5E14HkZwEvYMC3JsvMgX2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481239; c=relaxed/simple;
	bh=Sg43O1ePYPQ9Cq/7OpArLSkv1jO6W47q7rmWSH/67LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCgusk8I+O+KFbcGEsO0VmUxlK2qiO3bKxFxiGtnUXs9tUHT2i6q1CgK1m1JuCQhDoqcM9p7oLQwO5Rc8yCxVYPfjeqQMeFb7Ha0J6HyHc286EAwkX6IIbTkw/2idMVBM0rNzxEeNNv3yptc9UbthrGr6QZRA8I8iCq6shwx/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beAnG/KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732B3C4CEC2;
	Wed,  4 Sep 2024 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481238;
	bh=Sg43O1ePYPQ9Cq/7OpArLSkv1jO6W47q7rmWSH/67LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beAnG/KOvH+K8qbo9uuB7urjvtKApfKwcEzey/pfb9OT+duyVH8o4X+UqNehaBjvq
	 kYiuwUTyp4Jw1ZQBDV5KCzzamj38NQAhPotZEi51YBixWpIqEbM1R01xSnE9GUrl/B
	 WF0xjkF/5c2VA3Xs90Pr1p19RchLOMVi7ciT6LX3yJN8fOuM9XnrbvgSyO4BZyudoS
	 GuwSDWHKJy85fNA3py2HrOVw0HqtemATIPKnYNSr+xshChN4H8jaX9AWAuPgYdr6yc
	 OHV+TiFCRFvh89pXZBef19N8rIlf7A8J4LMPybNgs7EkQdTx/johzXWQNdQeBVC2IG
	 m6V4NdaWeWorQ==
Date: Wed, 4 Sep 2024 21:20:35 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ptp: ocp: Improve PCIe delay estimation
Message-ID: <20240904202035.GF1722938@kernel.org>
References: <20240904132842.559217-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904132842.559217-1-vadim.fedorenko@linux.dev>

On Wed, Sep 04, 2024 at 01:28:42PM +0000, Vadim Fedorenko wrote:
> The PCIe bus can be pretty busy during boot and probe function can
> see excessive delays. Let's find the minimal value out of several
> tests and use it as estimated value.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/ptp/ptp_ocp.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index e7479b9b90cb..22b22e605781 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -1561,19 +1561,22 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>  	ktime_t start, end;
>  	ktime_t delay;
>  	u32 ctrl;
> +	int i;
>  
> -	ctrl = ioread32(&bp->reg->ctrl);
> -	ctrl = OCP_CTRL_READ_TIME_REQ | OCP_CTRL_ENABLE;
> +	for (i = 0; i < 3; i++) {
> +		ctrl = ioread32(&bp->reg->ctrl);
> +		ctrl = OCP_CTRL_READ_TIME_REQ | OCP_CTRL_ENABLE;
>  
> -	iowrite32(ctrl, &bp->reg->ctrl);
> +		iowrite32(ctrl, &bp->reg->ctrl);
>  
> -	start = ktime_get_ns();
> +		start = ktime_get_ns();
>  
> -	ctrl = ioread32(&bp->reg->ctrl);
> +		ctrl = ioread32(&bp->reg->ctrl);
>  
> -	end = ktime_get_ns();
> +		end = ktime_get_ns();
>  
> -	delay = end - start;
> +		delay = min(delay, end - start);

Hi Vadim,

It looks like delay is used uninitialised here
in the first iteration of this loop.

Flagged by Smatch.

> +	}
>  	bp->ts_window_adjust = (delay >> 5) * 3;
>  }
>  
> -- 
> 2.43.0
> 
> 

