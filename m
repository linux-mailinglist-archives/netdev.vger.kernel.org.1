Return-Path: <netdev+bounces-97743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63488CCF9E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F32284061
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228413D53B;
	Thu, 23 May 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmK7osbv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20113D538
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457691; cv=none; b=USxW6Hf2AfhvPs3XZUi6LC4ZrJkYDyUnYLnSE412PH+dqo30SR2mSSq8wmQTxFzJ1s0Fk/6fVqWzsmKOOHDfwNzRpbgBMY2dFTl7e6VsGIgu6Ek4lhYGgPsqUcM10WomoZjAt5N+SUAnLv3qODlau9jK0YhCHDNSTaNzIA4wK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457691; c=relaxed/simple;
	bh=QrMzYhrV2IacT2KfZ9E7nRzq1wNpxR4NzwCsyy6N+mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMZ0w31VPJkbLhjL2MQlQqmR2kIjIAMVR2gIBJBi+LVs8SNPd+UtXLrxuB2rFmBmZqBh3LcvAzIgkCFkCIU93EKYYm0F7NvMmCRkRRkyNlDIVB9hF6mNpATwaez88lRwREc9ejPP4KHzhbnJoB6LonHFxw/2ZzB0IWrvrfrPgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmK7osbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9499BC32782;
	Thu, 23 May 2024 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457690;
	bh=QrMzYhrV2IacT2KfZ9E7nRzq1wNpxR4NzwCsyy6N+mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmK7osbv5Vw5XgQ2q8VULCez0Xv5BouS5rL7iyC1ztuGOQkD0+/tnYuX1K5ZL3Vit
	 uKrLmawjIOUJV4d5dywSuJhjxxpPG63gmmih+nwC7C4d96y3EP6vVgRJ9DK3+jVd4+
	 5IFj+0FJWfzTC7YzZ6LoQNgt3kgeJUH5m0nfg78yofH8FeBzSpm8hVdmaPOAxEWLWy
	 ddtNLbobloUpIDgF8iS5/yHjhkmU82ZNgEguyDuQbZaJC/ddMYwWOQXgQk71vDXcgT
	 mHsCBKbpoz5f4nkYOw0ws8RiTLbpa4u7jT1CAO78842fL/AuWbmk1V4uPFO1pCEsVD
	 9wzZQo5RiSGIA==
Date: Thu, 23 May 2024 10:48:06 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net 6/8] net/mlx5e: Do not use ptp structure for tx ts
 stats when not initialized
Message-ID: <20240523094806.GH883722@kernel.org>
References: <20240522192659.840796-1-tariqt@nvidia.com>
 <20240522192659.840796-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522192659.840796-7-tariqt@nvidia.com>

On Wed, May 22, 2024 at 10:26:57PM +0300, Tariq Toukan wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> The ptp channel instance is only initialized when ptp traffic is first
> processed by the driver. This means that there is a window in between when
> port timestamping is enabled and ptp traffic is sent where the ptp channel
> instance is not initialized. Accessing statistics during this window will
> lead to an access violation (NULL + member offset). Check the validity of
> the instance before attempting to query statistics.
> 
>   BUG: unable to handle page fault for address: 0000000000003524
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 109dfc067 P4D 109dfc067 PUD 1064ef067 PMD 0
>   Oops: 0000 [#1] SMP
>   CPU: 0 PID: 420 Comm: ethtool Not tainted 6.9.0-rc2-rrameshbabu+ #245
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.3-1-1 04/01/204
>   RIP: 0010:mlx5e_stats_ts_get+0x4c/0x130
>   <snip>
>   Call Trace:
>    <TASK>
>    ? show_regs+0x60/0x70
>    ? __die+0x24/0x70
>    ? page_fault_oops+0x15f/0x430
>    ? do_user_addr_fault+0x2c9/0x5c0
>    ? exc_page_fault+0x63/0x110
>    ? asm_exc_page_fault+0x27/0x30
>    ? mlx5e_stats_ts_get+0x4c/0x130
>    ? mlx5e_stats_ts_get+0x20/0x130
>    mlx5e_get_ts_stats+0x15/0x20
>   <snip>
> 
> Fixes: 3579032c08c1 ("net/mlx5e: Implement ethtool hardware timestamping statistics")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


