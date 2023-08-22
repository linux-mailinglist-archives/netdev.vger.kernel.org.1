Return-Path: <netdev+bounces-29638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C517842E3
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C9D2810AF
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB4A1CA0E;
	Tue, 22 Aug 2023 14:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AB1C9F0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5863CC433CB;
	Tue, 22 Aug 2023 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692713046;
	bh=ZIT11GIJSJZYc0Nk4zmM2lN1LnR6J6up+poTrlxkwEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAbSmcSAtB0IL2oIl2XBLF8PyEKDDiTf0zaaA6Ga32HyeZ0w4yhSkB0CYf5znMN0I
	 Xaja+9MY/z0jGyoJhVUgvmiNk59A4rq4qMPSSm0aAePihuhTprydi//vQvy1/NMZF3
	 KJwmVHXpsNik1D3NHQ0ua5wFNY0LcSyDzW0nOkRtPEVzvIT6aXqAh/FxU1NHnyYUlI
	 F1HLLTIXoBfJo3wUGCqTgjWhevl4sjq1kcu+N6NH4zVFlSP4dfhq1AXLjsN/EFxtEn
	 vOCK21l9S20rph4xnbd2tXoJOOcOCDfjtR230CZ63Sd67lApLo7DW+Mp+j+rmdQw8+
	 pb4cMcAsNYj6g==
Date: Tue, 22 Aug 2023 17:04:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/11] mlx4: Replace the mlx4_interface.event
 callback with a notifier
Message-ID: <20230822140403.GF6029@unreal>
References: <20230821131225.11290-1-petr.pavlu@suse.com>
 <20230821131225.11290-5-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821131225.11290-5-petr.pavlu@suse.com>

On Mon, Aug 21, 2023 at 03:12:18PM +0200, Petr Pavlu wrote:
> Use a notifier to implement mlx4_dispatch_event() in preparation to
> switch mlx4_en and mlx4_ib to be an auxiliary device.
> 
> A problem is that if the mlx4_interface.event callback was replaced with
> something as mlx4_adrv.event then the implementation of
> mlx4_dispatch_event() would need to acquire a lock on a given device
> before executing this callback. That is necessary because otherwise
> there is no guarantee that the associated driver cannot get unbound when
> the callback is running. However, taking this lock is not possible
> because mlx4_dispatch_event() can be invoked from the hardirq context.
> Using an atomic notifier allows the driver to accurately record when it
> wants to receive these events and solves this problem.
> 
> A handler registration is done by both mlx4_en and mlx4_ib at the end of
> their mlx4_interface.add callback. This matches the current situation
> when mlx4_add_device() would enable events for a given device
> immediately after this callback, by adding the device on the
> mlx4_priv.list.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leonro@nvidia.com>
> Acked-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c            | 40 +++++++++++++-------
>  drivers/infiniband/hw/mlx4/mlx4_ib.h         |  2 +
>  drivers/net/ethernet/mellanox/mlx4/en_main.c | 26 +++++++++----
>  drivers/net/ethernet/mellanox/mlx4/intf.c    | 24 ++++++++----
>  drivers/net/ethernet/mellanox/mlx4/main.c    |  2 +
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h    |  2 +
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  2 +
>  include/linux/mlx4/driver.h                  |  8 +++-
>  8 files changed, 75 insertions(+), 31 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

