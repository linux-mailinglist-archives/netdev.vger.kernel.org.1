Return-Path: <netdev+bounces-54634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB7807AC8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F261F212FB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20D3FE55;
	Wed,  6 Dec 2023 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtg07h/r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FEC70986;
	Wed,  6 Dec 2023 21:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDBFC433C8;
	Wed,  6 Dec 2023 21:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701899465;
	bh=Q63swJ2+NLD0RQu6BuRcv9wlpDxUWII9x/AotwElN5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gtg07h/rVyTNJlt3F4T4oRHOwHZOOSt/Fz6u0Lz9rRctYwlhLlXPDS8sNgcv43vdt
	 WXvfR61K0Jl3tLU0VLDTaj17rbNITldFbGwEHpODlwE3kzvJ54L1JNcTTwEstCxtfs
	 Yi5bdrjKYOrtacSFWl9MZ6TAH7OiQtgZ9JfiduhVNsxMi8v18ahnScq2X3sN9pSdBZ
	 TYxIauEUgF5kupMmq+RogxxdVHFqXb8IAMPxSYpHgvarN75NoeEwWsqgxx9333SYWf
	 bV0SQhqwPKjq8HM344ZYI/hLTR8jwfVL+w9KbZh4Y9MKvbCj+F0gpykaUyzeG4EFQj
	 L/vQS5Stlb0TQ==
Date: Wed, 6 Dec 2023 13:51:04 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Shifeng Li <lishifeng@sangfor.com.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eranbe@mellanox.com, moshe@mellanox.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	dinghui@sangfor.com.cn, lishifeng1992@126.com,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net v4] net/mlx5e: Fix a race in command alloc flow
Message-ID: <ZXDsyLyQYWW4OZN3@x130>
References: <20231202080126.1167237-1-lishifeng@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231202080126.1167237-1-lishifeng@sangfor.com.cn>

On 02 Dec 00:01, Shifeng Li wrote:
>Fix a cmd->ent use after free due to a race on command entry.
>Such race occurs when one of the commands releases its last refcount and
>frees its index and entry while another process running command flush
>flow takes refcount to this command entry. The process which handles
>commands flush may see this command as needed to be flushed if the other
>process allocated a ent->idx but didn't set ent to cmd->ent_arr in
>cmd_work_handler(). Fix it by moving the assignment of cmd->ent_arr into
>the spin lock.
>
>[70013.081955] BUG: KASAN: use-after-free in mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
>[70013.081967] Write of size 4 at addr ffff88880b1510b4 by task kworker/26:1/1433361
>[70013.081968]
>[70013.082028] Workqueue: events aer_isr
>[70013.082053] Call Trace:
>[70013.082067]  dump_stack+0x8b/0xbb
>[70013.082086]  print_address_description+0x6a/0x270
>[70013.082102]  kasan_report+0x179/0x2c0
>[70013.082173]  mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
>[70013.082267]  mlx5_cmd_flush+0x80/0x180 [mlx5_core]
>[70013.082304]  mlx5_enter_error_state+0x106/0x1d0 [mlx5_core]
>[70013.082338]  mlx5_try_fast_unload+0x2ea/0x4d0 [mlx5_core]
>[70013.082377]  remove_one+0x200/0x2b0 [mlx5_core]
>[70013.082409]  pci_device_remove+0xf3/0x280
>[70013.082439]  device_release_driver_internal+0x1c3/0x470
>[70013.082453]  pci_stop_bus_device+0x109/0x160
>[70013.082468]  pci_stop_and_remove_bus_device+0xe/0x20
>[70013.082485]  pcie_do_fatal_recovery+0x167/0x550
>[70013.082493]  aer_isr+0x7d2/0x960
>[70013.082543]  process_one_work+0x65f/0x12d0
>[70013.082556]  worker_thread+0x87/0xb50
>[70013.082571]  kthread+0x2e9/0x3a0
>[70013.082592]  ret_from_fork+0x1f/0x40
>
>The logical relationship of this error is as follows:
>
>             aer_recover_work              |          ent->work
>-------------------------------------------+------------------------------
>aer_recover_work_func                      |
>|- pcie_do_recovery                        |
>  |- report_error_detected                 |
>    |- mlx5_pci_err_detected               |cmd_work_handler
>      |- mlx5_enter_error_state            |  |- cmd_alloc_index
>        |- enter_error_state               |    |- lock cmd->alloc_lock
>          |- mlx5_cmd_flush                |    |- clear_bit
>            |- mlx5_cmd_trigger_completions|    |- unlock cmd->alloc_lock
>              |- lock cmd->alloc_lock      |
>              |- vector = ~dev->cmd.vars.bitmask
>              |- for_each_set_bit          |
>                |- cmd_ent_get(cmd->ent_arr[i]) (UAF)
>              |- unlock cmd->alloc_lock    |  |- cmd->ent_arr[ent->idx]=ent
>
>The cmd->ent_arr[ent->idx] assignment and the bit clearing are not
>protected by the cmd->alloc_lock in cmd_work_handler().
>
>Fixes: 50b2412b7e78 ("net/mlx5: Avoid possible free of command entry while timeout comp handler")
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>


LGTM,
Applied to net-mlx5.

Thanks,
Saeed.

