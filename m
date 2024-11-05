Return-Path: <netdev+bounces-141963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FD69BCCAA
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EADABB2388A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E31D5AC8;
	Tue,  5 Nov 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1Q/HZ/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638071D5ABE;
	Tue,  5 Nov 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809522; cv=none; b=am80A04dw+1w5BICYCG8SzKwrW9WQgUp+8/NKpSXUboenz7OuFJVioaa2EsjZkYROhAWu3Un1lpHHqi6F+ySKu7FBkGVrRTXUcqNhmtkXU577xuA7K879ieiMPSKhJonwy5Mtnl6VmUVMLgUknpEKa0bvf8IvzBhCyri/rc6bcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809522; c=relaxed/simple;
	bh=1mbpazmu+4C62rw1mJMk75VTU/3sxg93VEd1wdeOvSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+wCkEuySsdDBBkI4tOWCcxMADscDQs/kMWnjqqQShiHjuiUYGwLzZoN8RrLyGA+R/eNqtuZldtyqDs7h8wnt3Reox61Ug5ztkAvM7ASI54IoQPieASeopyUZLFmbh848gjHQRswUNiAAWSrVb2Zhq+qHFsHCaS5BUy5ceyZYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1Q/HZ/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF7EC4CECF;
	Tue,  5 Nov 2024 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730809522;
	bh=1mbpazmu+4C62rw1mJMk75VTU/3sxg93VEd1wdeOvSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1Q/HZ/zszVhoiJJMQKjTdx8v5T4GOho6SOP1teg1BwnfgEUPv3NahLeifeGWy0kj
	 8S38toau6NUiBfVaVmtMwkfbV5RB2Z8bPk6VAEqq7HL9p7tLEXIM74eLKIZQSJWJoN
	 opOU9kSCpYWLbrb/a/3Hr8Z7Kr2YgTDnF5YxT9vDB3EZgHZTNikVlhrlZS5uwMU14k
	 kTuIOUnCWQ8JgFipKMGYsegl13ecVPDJb4hNEU2+JohfZAdFEZnwZYweOC5g2D6R+w
	 Ja7Sk8icKaFJLsr2yUmGDGuVipxcm/h23WA6SjNJal9h1G6Oy9MYl2glT4v9pYNzf8
	 eyYSyX89UdliQ==
Date: Tue, 5 Nov 2024 12:25:16 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	sedara@marvell.com, vimleshk@marvell.com, wizhao@redhat.com,
	kongyen@redhat.com, pabeni@redhat.com, kheib@redhat.com,
	mschmidt@redhat.com, Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Satananda Burla <sburla@marvell.com>,
	Abhijit Ayarekar <aayarekar@marvell.com>
Subject: Re: [PATCH net v1 2/3] octeon_ep: add checks to fix NULL pointer
 dereferences
Message-ID: <20241105122516.GA4507@kernel.org>
References: <20241101103416.1064930-1-srasheed@marvell.com>
 <20241101103416.1064930-3-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101103416.1064930-3-srasheed@marvell.com>

On Fri, Nov 01, 2024 at 03:34:14AM -0700, Shinas Rasheed wrote:
> Add Checks to avoid NULL pointer references that might
> happen in rare and corner cases
> 
> Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
> Fixes: 1f2c2d0cee02 ("octeon_ep: add hardware configuration APIs")
> Fixes: 0807dc76f3bf ("octeon_ep: support Octeon CN10K devices")

Hi Shinas,

As this has both three Fixes tags and three hunks, I suspect
it is fixing three separate but similar problems. And if so,
would be best split into three patches, one patch per problem.

Further, as an overall comment for the entire series, I think more
explanation of how these problems can arise is needed. Are they race
conditions, artifacts of tear-down or error handling, ... And what
execution paths lead to them? Stack traces, if available, would also be
useful to include.

> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c | 9 ++++++++-
>  drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c | 9 ++++++++-
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c    | 3 +++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> index b5805969404f..b87336b2e4b9 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> @@ -617,7 +617,14 @@ static irqreturn_t octep_rsvd_intr_handler_cn93_pf(void *dev)
>  static irqreturn_t octep_ioq_intr_handler_cn93_pf(void *data)
>  {
>  	struct octep_ioq_vector *vector = (struct octep_ioq_vector *)data;
> -	struct octep_oq *oq = vector->oq;
> +	struct octep_oq *oq;
> +
> +	if (!vector)
> +		return IRQ_HANDLED;
> +	oq = vector->oq;
> +
> +	if (!oq || !(oq->napi))

nit: I don't think you need parentheses around op->napi. Likeiwse in patch 3/3.

> +		return IRQ_HANDLED;
>  
>  	napi_schedule_irqoff(oq->napi);
>  	return IRQ_HANDLED;

...

-- 
pw-bot: changes-requested

