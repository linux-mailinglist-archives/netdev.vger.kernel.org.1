Return-Path: <netdev+bounces-25510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53961774679
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFAC281971
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3216154A8;
	Tue,  8 Aug 2023 18:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAA1427F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C49FC433C8;
	Tue,  8 Aug 2023 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691521050;
	bh=7Seo1kCcAWbKJDXYnddc40jOoKOigU0COVPnza5A49M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9CvqyNYAQUNB/rGumQkwxFdaYnAabKwXecWdoI3Wix0gorU0q3FpVFNT5BogKr7+
	 I4pENM3JYWD8Dm4xYU60zDAhlECd/Z7OmyC2JPCFzGlE/0zNCQO4EfW6h5olM24ukV
	 PzegwaSJWWiiRVBgiQgqJvCQ45gDHMoSVHe4YSRiYKLNXovZJpJ8AjXDlh2no9LRZR
	 DmfyCvEVYtki3GR2WJ3HBOW2alDCfLpmF9YbrGHrPKY/8jPvDxAJrEQUHS+RuCXUhw
	 ASC8SmgDnF7fw3W9hzmLUQ5niFjqBpOXx+hZL4jYgoud7o7mKCQdvWkET4xs6oWDSC
	 w+FqMEycVjvKg==
Date: Tue, 8 Aug 2023 21:57:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/10] mlx4: Register mlx4 devices to an
 auxiliary virtual bus
Message-ID: <20230808185720.GL94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-8-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-8-petr.pavlu@suse.com>

On Fri, Aug 04, 2023 at 05:05:24PM +0200, Petr Pavlu wrote:
> Add an auxiliary virtual bus to model the mlx4 driver structure. The
> code is added along the current custom device management logic.
> Subsequent patches switch mlx4_en and mlx4_ib to the auxiliary bus and
> the old interface is then removed.
> 
> Structure mlx4_priv gains a new adev dynamic array to keep track of its
> auxiliary devices. Access to the array is protected by the global
> mlx4_intf mutex.
> 
> Functions mlx4_register_device() and mlx4_unregister_device() are
> updated to expose auxiliary devices on the bus in order to load mlx4_en
> and/or mlx4_ib. Functions mlx4_register_auxiliary_driver() and
> mlx4_unregister_auxiliary_driver() are added to substitute
> mlx4_register_interface() and mlx4_unregister_interface(), respectively.
> Function mlx4_do_bond() is adjusted to walk over the adev array and
> re-adds a specific auxiliary device if its driver sets the
> MLX4_INTFF_BONDING flag.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/Kconfig |   1 +
>  drivers/net/ethernet/mellanox/mlx4/intf.c  | 230 ++++++++++++++++++++-
>  drivers/net/ethernet/mellanox/mlx4/main.c  |  17 +-
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h  |   6 +
>  include/linux/mlx4/device.h                |   7 +
>  include/linux/mlx4/driver.h                |  11 +
>  6 files changed, 268 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

