Return-Path: <netdev+bounces-25499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3F577455B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB5928175A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD72D14ABF;
	Tue,  8 Aug 2023 18:41:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3C1427A
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EC0C433C7;
	Tue,  8 Aug 2023 18:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691520087;
	bh=Lc7JVkNFcw65RIJUGUc7Ey8+fVjd9Ixy2Gj31K040wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQYu/FVKgUAdSrDKuV0MH2RIjnSFK7i83eSY6On0P6crpWYl7Mo9uARai5o5vRgyD
	 dionhFqRqEafk/TxbbDk6Y7dwqmGUguFR12+zgjlbXWJiTxcliWUNLhOfumdSFTQEc
	 EhOkx/aati3Pv62QLBWauYMGKwYQm/unl15rnEXbAvW6E9FRsKc7iqcQ1nuSozi+QB
	 lyp4dQ4K6U0iD6WMyLEPdA4nTPI3WOa3S2I0bTuGNXnIzoKifGoYFoqfb3pk5o42Kz
	 0xWVikaBSA/mP0h8d1kWVNi8aQYiP56E+uWRn1hVBLNYL8QIa68k2SmocFhpA2DpaB
	 erW8A3s/9tE0w==
Date: Tue, 8 Aug 2023 21:41:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 4/4] net: hns3: fix deadlock issue when
 externel_lb and reset are executed together
Message-ID: <20230808184116.GF94631@unreal>
References: <20230807113452.474224-1-shaojijie@huawei.com>
 <20230807113452.474224-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807113452.474224-5-shaojijie@huawei.com>

On Mon, Aug 07, 2023 at 07:34:52PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> When externel_lb and reset are executed together, a deadlock may
> occur:
> [ 3147.217009] INFO: task kworker/u321:0:7 blocked for more than 120 seconds.
> [ 3147.230483] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 3147.238999] task:kworker/u321:0  state:D stack:    0 pid:    7 ppid:     2 flags:0x00000008
> [ 3147.248045] Workqueue: hclge hclge_service_task [hclge]
> [ 3147.253957] Call trace:
> [ 3147.257093]  __switch_to+0x7c/0xbc
> [ 3147.261183]  __schedule+0x338/0x6f0
> [ 3147.265357]  schedule+0x50/0xe0
> [ 3147.269185]  schedule_preempt_disabled+0x18/0x24
> [ 3147.274488]  __mutex_lock.constprop.0+0x1d4/0x5dc
> [ 3147.279880]  __mutex_lock_slowpath+0x1c/0x30
> [ 3147.284839]  mutex_lock+0x50/0x60
> [ 3147.288841]  rtnl_lock+0x20/0x2c
> [ 3147.292759]  hclge_reset_prepare+0x68/0x90 [hclge]
> [ 3147.298239]  hclge_reset_subtask+0x88/0xe0 [hclge]
> [ 3147.303718]  hclge_reset_service_task+0x84/0x120 [hclge]
> [ 3147.309718]  hclge_service_task+0x2c/0x70 [hclge]
> [ 3147.315109]  process_one_work+0x1d0/0x490
> [ 3147.319805]  worker_thread+0x158/0x3d0
> [ 3147.324240]  kthread+0x108/0x13c
> [ 3147.328154]  ret_from_fork+0x10/0x18
> 
> In externel_lb process, the hns3 driver call napi_disable()
> first, then the reset happen, then the restore process of the
> externel_lb will fail, and will not call napi_enable(). When
> doing externel_lb again, napi_disable() will be double call,
> cause a deadlock of rtnl_lock().
> 
> This patch use the HNS3_NIC_STATE_DOWN state to protect the
> calling of napi_disable() and napi_enable() in externel_lb
> process, just as the usage in ndo_stop() and ndo_start().
> 
> Fixes: 04b6ba143521 ("net: hns3: add support for external loopback test")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

