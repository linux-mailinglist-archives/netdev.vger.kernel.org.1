Return-Path: <netdev+bounces-27719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F8277CFD7
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF1D281484
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4668154AB;
	Tue, 15 Aug 2023 16:04:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AC12B98
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FB1C433C8;
	Tue, 15 Aug 2023 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692115484;
	bh=FqbQcyY8lw4uZssoPI1tmRuNwg7LwJWGkrrg1B66Hmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfvpG8Tje5iBbDQIF9YVEAV9NlXnX31uXWKGP3ud68K7LiQ9KELOndUJyAicUZeSk
	 /AOT+kE5KEfDjKcGWSNq+gAxFYUgMiKn7b1ly5uqUNz9/5IsOAqmLXDkCBeWuN8kc9
	 dpZLbkz2nxbdXWcBgKudA04MKfAurmZ1QX8cV1caMjThZAM+ZIHKZ93O6aup907f3O
	 byC+cpzkfEsoPISpPCIi2aHt8wn/JusKd07f9FQJ6b6CAtFYCtOHcydy8W0sEJ+fgl
	 oxbiUlsKDfG5HB/E92FkjAFw5y+QarLNcBFkyEWLNjvllKV3Ni8rHuOoLroUQkgacD
	 O0DvG5s2pssxg==
Date: Tue, 15 Aug 2023 18:04:39 +0200
From: Simon Horman <horms@kernel.org>
To: Jialin Zhang <zhangjialin11@huawei.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
	ndagan@amazon.com, saeedb@amazon.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, yuancan@huawei.com, netdev@vger.kernel.org,
	liwei391@huawei.com, wangxiongfeng2@huawei.com
Subject: Re: [PATCH] net: ena: Use pci_dev_id() to simplify the code
Message-ID: <ZNuiF7D/fDRhPVoi@vergenet.net>
References: <20230815024248.3519068-1-zhangjialin11@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815024248.3519068-1-zhangjialin11@huawei.com>

On Tue, Aug 15, 2023 at 10:42:48AM +0800, Jialin Zhang wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to

nit: mannually -> manually

> simplify the code a little bit.
> 
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index d19593fae226..ad32ca81f7ef 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -3267,7 +3267,7 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
>  
>  	host_info = ena_dev->host_attr.host_info;
>  
> -	host_info->bdf = (pdev->bus->number << 8) | pdev->devfn;
> +	host_info->bdf = pci_dev_id(pdev);
>  	host_info->os_type = ENA_ADMIN_OS_LINUX;
>  	host_info->kernel_ver = LINUX_VERSION_CODE;
>  	strscpy(host_info->kernel_ver_str, utsname()->version,
> -- 
> 2.25.1
> 
> 

