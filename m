Return-Path: <netdev+bounces-130883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78EA98BDC2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B3C1C20BA6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362091C5791;
	Tue,  1 Oct 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcw8b4MJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE01C5789;
	Tue,  1 Oct 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789554; cv=none; b=oAWQQC4rwhFC6/fYDVCO+ECbqf/dkDT+o78p6liGEfC0rYxYs2/yef9RdR3K5cOVt5Kziqms/rTDDEZqUbh3WlYJ+rhEU+lBoeFDN3DF3KP7wgVESJIfXoHyZvlM4zJTl/W8OELyq6eHK8SD5kkOqTBVWsAzXpKYMz47Zf4SRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789554; c=relaxed/simple;
	bh=2NrsjqMj3bFZZKByzA0JtBpTzL+rnZoKtA9F9HPNnbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMtNA3SamQOetArvh3ntjx8zKITwW787fDprylKhNue38CW8IePq5Q36gJnhHerpQdCmmObNdahQpWGU/REZ1kLhElIV/+bulT/r7YCThYql5SCAQSI/XnZEuiu6skcUdlUad8icXQYei7zgtCD3K8DnyIOWWWgFu3Gb9pW1ZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcw8b4MJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B198C4CEC6;
	Tue,  1 Oct 2024 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727789553;
	bh=2NrsjqMj3bFZZKByzA0JtBpTzL+rnZoKtA9F9HPNnbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcw8b4MJBja+e0QG2ktGaNnT3DoAe+R0G4Rkif2+HQEvWyzNKIZXBlkGKSHjVmDw1
	 7Av+4/JVtTAEiyFdgJhlTy6Xq+ulWE1Ot7PK6x+P8RbZlJo7IpkF29uZsDzShr+dsU
	 hUAKkmV6IxP3J/D7rGJCbgTjRdoOJqfKOD7l7ECfrJ6Ndd/DlLtA2dMndBS5ID+4CX
	 +NtZILuSxcS8lw7HHUy2lCEnsIviZSmhz8y2dcjisaxlTN9FmTVVITZn10wx3sJ81D
	 e1loR0kgmdhugHAudRt83qlFK06T85ND2a4Dwk8dqC4cZ0sRJNn15yECmEAajHolMm
	 g7qI/Vut2ke6A==
Date: Tue, 1 Oct 2024 14:32:29 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, jacob.e.keller@intel.com,
	sd@queasysnail.net, chunkeey@gmail.com
Subject: Re: [PATCH net-next 13/13] net: ibm: emac: mal: use devm for
 request_irq
Message-ID: <20241001133229.GR1310185@kernel.org>
References: <20240930180036.87598-1-rosenp@gmail.com>
 <20240930180036.87598-14-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930180036.87598-14-rosenp@gmail.com>

On Mon, Sep 30, 2024 at 11:00:36AM -0700, Rosen Penev wrote:
> Avoids manual frees. Also replaced irq_of_parse_and_map with
> platform_get_irq since it's simpler and does the same thing.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/mal.c | 47 ++++++++++++-----------------
>  1 file changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
> index 70019ced47ff..449f0abe6e9e 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.c
> +++ b/drivers/net/ethernet/ibm/emac/mal.c
> @@ -578,15 +578,15 @@ static int mal_probe(struct platform_device *ofdev)
>  #endif
>  	}
>  
> -	mal->txeob_irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> -	mal->rxeob_irq = irq_of_parse_and_map(ofdev->dev.of_node, 1);
> -	mal->serr_irq = irq_of_parse_and_map(ofdev->dev.of_node, 2);
> +	mal->txeob_irq = platform_get_irq(ofdev, 0);
> +	mal->rxeob_irq = platform_get_irq(ofdev, 1);
> +	mal->serr_irq = platform_get_irq(ofdev, 2);
>  
>  	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
>  		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
>  	} else {
> -		mal->txde_irq = irq_of_parse_and_map(ofdev->dev.of_node, 3);
> -		mal->rxde_irq = irq_of_parse_and_map(ofdev->dev.of_node, 4);
> +		mal->txde_irq = platform_get_irq(ofdev, 3);
> +		mal->rxde_irq = platform_get_irq(ofdev, 4);
>  	}
>  
>  	if (!mal->txeob_irq || !mal->rxeob_irq || !mal->serr_irq ||

I think this error handing needs to be updated.
platform_get_irq() returns either a non-zero IRQ number or
a negative error value. It does not return zero.

Flagged by Smatch.

...

