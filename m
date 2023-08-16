Return-Path: <netdev+bounces-27929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF1177DA89
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C22A2817EB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C69F210C;
	Wed, 16 Aug 2023 06:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B11840
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D260FC433C8;
	Wed, 16 Aug 2023 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692167905;
	bh=GRhakiEQ3/FMsETxHX+ABZi76L6G66hps1SeDx2g6KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OsO6aPxGlD4pX2xxdLPtr5fJGDw9X8TecFl0hTXE3cJjyNyjFyE4t+Xi9FU6GdBij
	 d+ncv/GADzOz8Xq3k3hoYWDywhcTovno97a8E2uklRRsOiW7UMrIy6kzs5N76ggXtw
	 21WN6l53VpwaPxoD4/ILP3SvAGsGZkIKm33s+Q51l6Ww2/PwzNL58Vx/PEo8jn2olg
	 mAxM6Hrju7ep/aesqIQOgLSgVzo9gjmBHfVNGWdRJLtDVtEFa1JcyTD46XFeCpmF/T
	 CtsOsw9lYFBCBZZ1swS8VbvTjBuB8FjIdcpBCh4RZY0mokLDnHDg3LktFIDkv2wMhf
	 EXtEpB60wdM7g==
Date: Wed, 16 Aug 2023 09:38:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, liwei391@huawei.com
Subject: Re: [PATCH net-next] pds_core: remove redundant pci_clear_master()
Message-ID: <20230816063820.GV22185@unreal>
References: <20230816013802.2985145-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816013802.2985145-1-liaoyu15@huawei.com>

On Wed, Aug 16, 2023 at 09:38:02AM +0800, Yu Liao wrote:
> pci_disable_device() involves disabling PCI bus-mastering. So remove
> redundant pci_clear_master().

I would say that this commit message needs to be more descriptive and
explain why pci_disable_device() will actually disable PCI in these
flows.

According to the doc and code:
  2263  * Note we don't actually disable the device until all callers of 
  2264  * pci_enable_device() have called pci_disable_device().

Thanks

> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/net/ethernet/amd/pds_core/main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 672757932246..ffe619cff413 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -374,7 +374,6 @@ static int pdsc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	return 0;
>  
>  err_out_clear_master:
> -	pci_clear_master(pdev);
>  	pci_disable_device(pdev);
>  err_out_free_ida:
>  	ida_free(&pdsc_ida, pdsc->uid);
> @@ -439,7 +438,6 @@ static void pdsc_remove(struct pci_dev *pdev)
>  		pci_release_regions(pdev);
>  	}
>  
> -	pci_clear_master(pdev);
>  	pci_disable_device(pdev);
>  
>  	ida_free(&pdsc_ida, pdsc->uid);
> -- 
> 2.25.1
> 
> 

