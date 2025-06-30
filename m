Return-Path: <netdev+bounces-202604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61934AEE561
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E183BF44E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284A28F94E;
	Mon, 30 Jun 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtzfYnaJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937228D822;
	Mon, 30 Jun 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303351; cv=none; b=s0aUkMUxhM3ngRaVgfXX7+0mIeWiW6BywQ0NcZKFWts+6+BWU5Zransbyf4p3cIll16fpM1cnBGgerJM+vMcMt98b5bkFkFp/soPkQKFcMxPdwN+lGFgajxE+u9xDmWoI4iKleRxs9zc/VW6nZM3ui52LJA+8AZi7jae/+1ogzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303351; c=relaxed/simple;
	bh=1300F16jOLHJYdm+B9ZlsabbWI8vL/9OqAKPHA1ppIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwYp83/rjrqsQ4X7OW66/xx8YMTLPr73na3yPTf8NgPwAF7/7DsZ76yh/UHAKj6fJp5VOBQ/6i9TB45t3ksQ6M14EuJ3IJcaQ5Ydha833lMcYjuPs9aeSO8NB5VZbs8J107S2yPCDJkTkiYyNCM6mi3d0PCgm1VQiJ8c18A5ZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtzfYnaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0982CC4CEE3;
	Mon, 30 Jun 2025 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751303350;
	bh=1300F16jOLHJYdm+B9ZlsabbWI8vL/9OqAKPHA1ppIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtzfYnaJmM4wzpkiJU0Ul5iDpm8MEC5B9QeDsaIo2QhoaQbQigBsXZzJIRGp3+/Z+
	 QP5/M3MNXhIuLXOz6QESFbLI4DEmLTqP7+OAhlKV9yvLMI7/IP/GpTjmSmzgCcmzsZ
	 fZOADdo2NF2QSLg40mJ3SYe9bP7HA9RxHrUOnYl8vk4/kFDoE1rzKYR8s0gsLz28Ro
	 Yk7BFskNPVVBYI58g+mQ5EU6siWuyr6e+M0Bwc2moZSMpV+kfRTW3x2W8DveI2Fs3b
	 AktBdUzYSU/qN/IMzmzMZ40sYJgRouFp40trAb7B7BP9yHkeMYUsjYtOc+Hoj8iJmT
	 5X6KUSKxUx/LQ==
Date: Mon, 30 Jun 2025 18:09:06 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Currier <dullfire@yahoo.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] nui: Fix dma_mapping_error() check
Message-ID: <20250630170906.GN41770@horms.kernel.org>
References: <20250630083650.47392-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630083650.47392-2-fourier.thomas@gmail.com>

On Mon, Jun 30, 2025 at 10:36:43AM +0200, Thomas Fourier wrote:
> dma_map_XXX() functions return values DMA_MAPPING_ERROR as error values
> which is often ~0.  The error value should be tested with
> dma_mapping_error().
> 
> This patch creates a new function in niu_ops to test if the mapping
> failed.  The test is fixed in niu_rbr_add_page(), added in
> niu_start_xmit() and the successfully mapped pages are unmaped upon error.
> 
> Fixes: ec2deec1f352 ("niu: Fix to check for dma mapping errors.")

I think it fixes a bit more than that.
But perhaps the above tag is sufficient.

> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Overall this looks good to me, thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/sun/niu.c | 31 ++++++++++++++++++++++++++++++-
>  drivers/net/ethernet/sun/niu.h |  4 ++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c

...

> @@ -10019,6 +10042,11 @@ static void niu_phys_unmap_single(struct device *dev, u64 dma_address,
>  	/* Nothing to do.  */
>  }
>  
> +static int niu_phys_mapping_error(struct device *dev, u64 dma_address)
> +{
> +	return false;

No need to resend just because of this, but
from a type PoV this should probably be:

	return 0;

> +}
> +
>  static const struct niu_ops niu_phys_ops = {
>  	.alloc_coherent	= niu_phys_alloc_coherent,
>  	.free_coherent	= niu_phys_free_coherent,

...

