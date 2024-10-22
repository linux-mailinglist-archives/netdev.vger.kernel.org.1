Return-Path: <netdev+bounces-137937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB09AB2E2
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C731C221F3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3201D1BBBFC;
	Tue, 22 Oct 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0BEtp0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA5619B5B4
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612596; cv=none; b=iNilx8QUUrFJ4Qxu5Gfu1DC95SUyo3tzg2sE7jruernVISAtuUXH+H9iX8zd5tsecsEnaGioXV7l6gcZGztQCaQRTu3EBUj5Ufz8FKgHHzxmWjYjjgEP4XR4jl2pDdYn8q4G/we/TtSL9UQ6G3d6Po7GiRw1x5lZqgo0Qa0AdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612596; c=relaxed/simple;
	bh=uCVIk7/ccIig2DOQ2XAujMwrdm+K7nR+OtKc6cpV5f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMLpXUUyTP86eXuMQeceaekLpjI3PoYJjlGblgZBhHzVLHfrQix7goqc6GRnYDtckc70h8I77UXXWa/n4y4GGD9ou0SuOP+wrCjJ7qqs4pay4fQUMGD9Jmnu5t6GmooRe3GJeOFiq1uV0C6OcL+HU7ppNyE83OTkmEBI0FnBEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0BEtp0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0EDC4CEC3;
	Tue, 22 Oct 2024 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729612595;
	bh=uCVIk7/ccIig2DOQ2XAujMwrdm+K7nR+OtKc6cpV5f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0BEtp0Pmnbl1mk0jjVZJ72/MvGmU271hvyxvJAWxKU9NbafEqaZxrgevHqJv32+w
	 4Sv3tQ18yDv6DRKqMvjWgQD0+rUJ6LRuzMqUaYJCJOJfck2c9WBR0Sp1wrXyJzPeX9
	 a3O4VU1uxlW6v1wUcs9khLhYahGWdNzl/ObqlOzKERZV24KLwdg1uQiTwgGaf69rpw
	 3ytmQojljhlbyqxh75vUGXvYphABeU4+e9BgXioW8vD48WVUyWp8GJN+j7s6q2J3vU
	 8W0J2ye7EX9pEE+4v2QOY2jgX12jqj7dlE/MFDdcNMa8/n8wVO4frVaGk9xHf4rz4z
	 vK90WY+7ad6/A==
Date: Tue, 22 Oct 2024 16:56:30 +0100
From: Simon Horman <horms@kernel.org>
To: Yuan Can <yuancan@huawei.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, cramerj@intel.com,
	shannon.nelson@amd.com, mitch.a.williams@intel.com,
	jgarzik@redhat.com, auke-jan.h.kok@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH] igb: Fix potential invalid memory access in
 igb_init_module()
Message-ID: <20241022155630.GY402847@kernel.org>
References: <20241022063807.37561-1-yuancan@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022063807.37561-1-yuancan@huawei.com>

+ Alexander Duyck

On Tue, Oct 22, 2024 at 02:38:07PM +0800, Yuan Can wrote:
> The pci_register_driver() can fail and when this happened, the dca_notifier
> needs to be unregistered, otherwise the dca_notifier can be called when
> igb fails to install, resulting to invalid memory access.
> 
> Fixes: fe4506b6a2f9 ("igb: add DCA support")

I don't think this problem was introduced by the commit cited above,
as it added the call to dca_unregister_notify() before
pci_register_driver(). But rather by the commit cited below which reversed
the order of these function calls.

bbd98fe48a43 ("igb: Fix DCA errors and do not use context index for 82576")

I'm unsure if it is necessary to repost the patch to address that.
But if you do, and assuming we are treating this as a bug fix,
please target it for the net (or iwl-net) tree like this:

Subject: [PATCH net v2] ...

> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index f1d088168723..18284a838e24 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -637,6 +637,10 @@ static int __init igb_init_module(void)
>  	dca_register_notify(&dca_notifier);
>  #endif
>  	ret = pci_register_driver(&igb_driver);
> +#ifdef CONFIG_IGB_DCA
> +	if (ret)
> +		dca_unregister_notify(&dca_notifier);
> +#endif
>  	return ret;
>  }
>  
> -- 
> 2.17.1
> 
> 

