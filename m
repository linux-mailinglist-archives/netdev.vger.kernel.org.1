Return-Path: <netdev+bounces-109403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A3B928563
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2228B2828D0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32141474AF;
	Fri,  5 Jul 2024 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOn7XLTj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF682146A8D
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172674; cv=none; b=KaNjeF10AvoIeZYwZEMW+iy4Rn52396+SjLhMH1Rf0cYPw4SlR9FzA69BudJyI2qccMHvyQCG88XB8B8rlUrmI6hAZPEi+VhU84+lnU5XVSjOy3CLUPPZ4qk2iGFMEvKplyiDj5zuoacwSGVyX08m8Ys6sDDljKuzpuYplaLAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172674; c=relaxed/simple;
	bh=odhNEpOhcJcVEmGLfNAw9CM4dxuY5tNci9MDXc4HW08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+CZkKGk1E5BLyH6B9V780hBXWpPbXlYkiKy4lPAq1+KHbPn9ptqlSy0idugAexwoyXz7MTBr3EBtjDftD0Z5wEThZnUZf8C3s5db1LD39DXnSo1RyP0dwHi+KKdSzrP9sAyA5+Dkcna7tZHoU+/oruxE0uuDOKoJ5tKkemOLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOn7XLTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A5CC116B1;
	Fri,  5 Jul 2024 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720172674;
	bh=odhNEpOhcJcVEmGLfNAw9CM4dxuY5tNci9MDXc4HW08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOn7XLTj/ZbJcAGkvcaxn/yW10uCuh2FcZtuLsXqdyROoxxcvxI4can/bsTHrFqvm
	 SD2GC0L2V9uGtcPFg1ZO9Qc0sIhhMDgFg3gJuHjulTFzZ8Aw+dTLMnNpMUFhWTTI+J
	 VrGHpfbPrCIYV9W8XDhNAXV/B9vY0hAplJQwntTW3MDmYWAULRQchsRcsPrzdHLAXv
	 jw9msB6yln/6oiPE8VVcZLzzVkD/NtpumBUcZYqTf0chIlqBe2bGUzeuE1jsfVTahM
	 5PqZnSYBKXRVGcGaunMmbdcVq8ddKDAg1YTQr6jWNdu8yFU1xe26Gj5VsR43cAPXTS
	 PvCHAn/49CKAw==
Date: Fri, 5 Jul 2024 10:44:30 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 07/10] net/mlx5: Implement PTM cross
 timestamping support
Message-ID: <20240705094430.GD1095183@kernel.org>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
 <20240705071357.1331313-8-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705071357.1331313-8-tariqt@nvidia.com>

On Fri, Jul 05, 2024 at 10:13:54AM +0300, Tariq Toukan wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Expose Precision Time Measurement support through related PTP ioctl.
> 
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Co-developed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../ethernet/mellanox/mlx5/core/lib/clock.c   | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index 0361741632a6..e023fb323a32 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -30,10 +30,13 @@
>   * SOFTWARE.
>   */
>  
> +#include <asm/tsc.h>

Hi Tariq, all,

This appears to break compilation on architectures that don't have tsc.h -
those other than x86.

E.g. allmodconfig on arm64.

-- 
pw-bot: changes-requested

...

