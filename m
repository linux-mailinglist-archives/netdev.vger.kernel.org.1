Return-Path: <netdev+bounces-141612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DCA9BBC37
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477611C2182A
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50B81C57B2;
	Mon,  4 Nov 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYU1a8Kk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EF1CD02;
	Mon,  4 Nov 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742199; cv=none; b=tyHgRLsXUNnrz4BcJQF3hvzZoBHkl4/USF4sNrk4tGbETdL1lUAi6vyVPcgPUNmLzl3bwxxO/U00jgrBKEr+dSK2BQEi+H0uWvFaFuOmvnp4MMFKuyKjbNkyutcMNZ/unecK6AZwuAaihmRCYNnvOcyCtiF7HGO8ysc9XnWGuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742199; c=relaxed/simple;
	bh=/kp4Uo8cHYf4NUGfCdvBAXtxpVRoti/Qt5j2UFIBDEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiVhAqqEUUBI3umwpgfl44F/ds+JpnVLPXhoGoz7XXYFtO9Xpxvqk09sNJX9BNo549qakXu1ifsp2TUjFh4UtQDArEjCjbpkZGhshqKk/HS27klp7SkZwcwaH9LF6ig1xKsG2kvEa0U660dABbpHclanVXMVpsg6DOjF3tYgWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYU1a8Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD368C4CECE;
	Mon,  4 Nov 2024 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730742197;
	bh=/kp4Uo8cHYf4NUGfCdvBAXtxpVRoti/Qt5j2UFIBDEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYU1a8Kk8gfeyrNdw5qJFWtWJzAn6yDeMuqsauoyFgGsorg/EH0U3EpJC/2NRL/7j
	 N8tdijP0tSn1jj8g+DwJJrpGr/+LCDmFosFD7LxBk+8cMJlxPhAea8c/6hZ4ZO/eZD
	 I8ZiU6NsEYS5BmzE7Ne5LDbCnDXxpIrQgOz0ZsmLfDVvFNhkMAxDH6pHk11/wC4lz7
	 16PHIm5uWdwtW21t8/YNONh9P71k6R4pjV28HFpTScsYC+aW9EuVWDefflGqDzR69T
	 DWdZbAEeOScwsuWRYZCEBvPq7dfVkPKaPzfyA5dasW5sdIZPWikEXFFHkH0U7jwzVH
	 s7GoZA2m7D+Xg==
Date: Mon, 4 Nov 2024 17:43:12 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	salil.mehta@huawei.com, liuyonglong@huawei.com,
	wangpeiyang1@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hns3: fix kernel crash when uninstalling driver
Message-ID: <20241104174312.GG2118587@kernel.org>
References: <20241101091507.3644584-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101091507.3644584-1-shaojijie@huawei.com>

On Fri, Nov 01, 2024 at 05:15:07PM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> When the driver is uninstalled and the VF is disabled concurrently, a
> kernel crash occurs. The reason is that the two actions call function
> pci_disable_sriov(). The num_VFs is checked to determine whether to
> release the corresponding resources. During the second calling, num_VFs
> is not 0 and the resource release function is called. However, the
> corresponding resource has been released during the first invoking.
> Therefore, the problem occurs:
> 
> [15277.839633][T50670] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
> ...
> [15278.131557][T50670] Call trace:
> [15278.134686][T50670]  klist_put+0x28/0x12c
> [15278.138682][T50670]  klist_del+0x14/0x20
> [15278.142592][T50670]  device_del+0xbc/0x3c0
> [15278.146676][T50670]  pci_remove_bus_device+0x84/0x120
> [15278.151714][T50670]  pci_stop_and_remove_bus_device+0x6c/0x80
> [15278.157447][T50670]  pci_iov_remove_virtfn+0xb4/0x12c
> [15278.162485][T50670]  sriov_disable+0x50/0x11c
> [15278.166829][T50670]  pci_disable_sriov+0x24/0x30
> [15278.171433][T50670]  hnae3_unregister_ae_algo_prepare+0x60/0x90 [hnae3]
> [15278.178039][T50670]  hclge_exit+0x28/0xd0 [hclge]
> [15278.182730][T50670]  __se_sys_delete_module.isra.0+0x164/0x230
> [15278.188550][T50670]  __arm64_sys_delete_module+0x1c/0x30
> [15278.193848][T50670]  invoke_syscall+0x50/0x11c
> [15278.198278][T50670]  el0_svc_common.constprop.0+0x158/0x164
> [15278.203837][T50670]  do_el0_svc+0x34/0xcc
> [15278.207834][T50670]  el0_svc+0x20/0x30
> 
> For details, see the following figure.
> 
>      rmmod hclge              disable VFs
> ----------------------------------------------------
> hclge_exit()            sriov_numvfs_store()
>   ...                     device_lock()
>   pci_disable_sriov()     hns3_pci_sriov_configure()
>                             pci_disable_sriov()
>                               sriov_disable()
>     sriov_disable()             if !num_VFs :
>       if !num_VFs :               return;
>         return;                 sriov_del_vfs()
>       sriov_del_vfs()             ...
>         ...                       klist_put()
>         klist_put()               ...
>         ...                     num_VFs = 0;
>       num_VFs = 0;        device_unlock();
> 
> In this patch, when driver is removing, we get the device_lock()
> to protect num_VFs, just like sriov_numvfs_store().
> 
> Fixes: 0dd8a25f355b ("net: hns3: disable sriov before unload hclge layer")
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

