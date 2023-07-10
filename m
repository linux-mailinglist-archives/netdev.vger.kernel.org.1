Return-Path: <netdev+bounces-16455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32E74D4BA
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0E92811BC
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E0A10954;
	Mon, 10 Jul 2023 11:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86F101F3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 11:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D87BC433C7;
	Mon, 10 Jul 2023 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688989379;
	bh=hUf6J5WnjG0KbBU8bMn67a55iQIfrDSdaQj01gr/rbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTHDRXWqoGzeYmc28eSsX0eiH9NHeWLcA49Zf4XreaB3K8Fh49uO77hPdUv0BaZ/w
	 7oeFwp6RwUm/bEQ2bDEiDiLCyC/2VRGRnEOgaMZHuJhkpx+9cldu9vkW/irKQYC/f+
	 EzdvP2KEzuKQh7sxZqfEMn+Ml845gKZ2j6r+i5rPZ9ikWUztCdJaDs6PLKRsBaBSqx
	 skgLayoeSnyfjDjMT13mbFhHDXz447Rwyuu/hbia1z14i5a/6RH61+MN6hFudFh4/4
	 zolz1wWnKT1EevQJq0wVCfmbkl/3L8caz0SShW/r78W+SqBWjLX+bCc1HVEOgcgu4K
	 zBYlSOpDnKUmg==
Date: Mon, 10 Jul 2023 12:42:53 +0100
From: Lee Jones <lee@kernel.org>
To: Zheng Wang <zyytlz.wz@163.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, linyunsheng@huawei.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
	alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230710114253.GA132195@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311180630.4011201-1-zyytlz.wz@163.com>

On Sun, 12 Mar 2023, Zheng Wang wrote:

> In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> If timeout occurs, it will start the work. And if we call
> ravb_remove without finishing the work, there may be a
> use-after-free bug on ndev.
> 
> Fix it by finishing the job before cleanup in ravb_remove.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> v3:
> - fix typo in commit message
> v2:
> - stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
> add an empty line to make code clear suggested by Sergey Shtylyov
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

For better or worse, it looks like this issue was assigned a CVE.

Are we expecting v4 or was it resolved in another way?

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 0f54849a3823..eb63ea788e19 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2892,6 +2892,10 @@ static int ravb_remove(struct platform_device *pdev)
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
>  
> +	netif_carrier_off(ndev);
> +	netif_tx_disable(ndev);
> +	cancel_work_sync(&priv->work);
> +	
>  	/* Stop PTP Clock driver */
>  	if (info->ccc_gac)
>  		ravb_ptp_stop(ndev);
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]

