Return-Path: <netdev+bounces-107723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6291C253
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490D9284DC2
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70C1C688C;
	Fri, 28 Jun 2024 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkKjBum6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031D1C2332
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587696; cv=none; b=Ko0x1msqJ0TgQdb1z3NDF+iSBTwaWwG+faabVaeja4qb2dCQsZ6UUGL0mYJmGU+/CKYti0j4MYuoLYPIavefCJGX/l2u6qVW9CiZMKDJL9Y2Gz5DTFcwTwGL1/UyM2zxiBMxbho+BfLIZVDq3VucVj1uNFCyYDw4aklZhxb6++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587696; c=relaxed/simple;
	bh=sX/+p41y3brk69t0RUuAt3G/e9Jwo/Fomn/9QTFD1I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3F3ecGl4s/XGS3vN8rPmQCreZWbJMyMui4hXhpbzZiL0p8tAhS9phVBq0HeDUKRLANloklbvKajZOE4XZ7dnFLTIT0Bb9JBbfidlmYi1Ujowy6WZa4amQodxNVGz8izjuWGm4sEM/Y5M1opxSfoRxlNjWL49dimTCautDf9bsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkKjBum6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCACC116B1;
	Fri, 28 Jun 2024 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587695;
	bh=sX/+p41y3brk69t0RUuAt3G/e9Jwo/Fomn/9QTFD1I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkKjBum6lUEBSAK2CbaHMH2/s0/sOcZ39VfIhNreMA7oW/aJGfK+ZbzdaWc32S6J7
	 pRatz4Kui8frUrtSY2wsTsBxEpUnVtqer91676xRwpQ/N88AiN8VsIym7d/kI84aBZ
	 8bzEPeZDr61ePu26hTfwNKwiRn4Dscw/pgM3MXeUbN/ujL5Vei5+/9912vs8rSb827
	 4IgcZVGLYnKkaYLmgn15dpJTiHJ6juogFzgjB+19PSsaW9b7Bnkwq7fFd8jf096oxs
	 0of51vnLfj80FcWpS4PGXRevBq5TZdqHHBbOGSaaWUnHDrlcBceQ1Zgc6nC7cZ+Zaj
	 JlQl5nDAu4g/w==
Date: Fri, 28 Jun 2024 16:14:52 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH v2 09/15] eth: fbnic: Implement Rx queue
 alloc/start/stop/free
Message-ID: <20240628151452.GI783093@kernel.org>
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932617073.3072535.8918778399126638637.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171932617073.3072535.8918778399126638637.stgit@ahduyck-xeon-server.home.arpa>

On Tue, Jun 25, 2024 at 07:36:10AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Implement control path parts of Rx queue handling.
> 
> The NIC consumes memory in pages. It takes a full page and places
> packets into it in a configurable manner (with the ability to define
> headroom / tailroom as well as head alignment requirements).
> As mentioned in prior patches there are two page submissions queues
> one for packet headers and second (optional) for packet payloads.
> For now feed both queues from a single page pool.
> 
> Use the page pool "fragment" API, as we can't predict upfront
> how the page will be sliced.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |  103 +++++
>  drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    3 
>  drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |    3 
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |    2 
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   |  480 ++++++++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |   33 ++
>  6 files changed, 615 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> index db423b3424ab..853fb01f8f70 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> @@ -16,6 +16,37 @@
>  
>  #define FBNIC_CLOCK_FREQ	(600 * (1000 * 1000))
>  
> +/* Rx Buffer Descriptor Format
> + *
> + * The layout of this can vary depending on the page size of the system.
> + *
> + * If the page size is 4K then the layout will simply consist of ID for
> + * the 16 most signficant bits, and the lower 46 are essentially the page

nit: significant

...

