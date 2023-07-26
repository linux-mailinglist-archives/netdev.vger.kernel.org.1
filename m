Return-Path: <netdev+bounces-21148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449D976292E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FED281219
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69B1FA1;
	Wed, 26 Jul 2023 03:19:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6511C20
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA1CC433C8;
	Wed, 26 Jul 2023 03:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690341594;
	bh=BltmyiPPQL6jRY2ec5NbwR1NWR52L0x3e86Gyw3VwFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sRLJWeKnY5Prjmq6rcAVuByDIv+Vu2t4hA62N6jiPmR4xRcbYY5hc/8pQvMfPfBqo
	 9yVaIqQt2dCaQ4L41jLXV/MYSNF7z3xNws13KgC5yz6QE1XADxdbn+aW510JW8Pkp8
	 0mwZXCTrF28FkbS3L2VmOV0Q2w0YTMVg6mvLCU/5qET9LlBQohkw0tiu34VicLz73B
	 tQzAcseuNpD7J5VFFMljXkAMkH6Y6zM660NHMFnGvB2NyYThXJ3ByPU6azy1wyV+bd
	 Sr4UhK9K4fIvCGaYQZhVwA2JMf2KTgeoyweTffKH2cP/Ia77ekFwlKZLeM3S19crKB
	 yMHY8vESxt8Nw==
Date: Tue, 25 Jul 2023 20:19:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zheng Wang <zyytlz.wz@163.com>
Cc: s.shtylyov@omp.ru, lee@kernel.org, linyunsheng@huawei.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com, wsa+renesas@sang-engineering.com,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
 1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230725201952.2f23bb3b@kernel.org>
In-Reply-To: <20230725030026.1664873-1-zyytlz.wz@163.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 11:00:26 +0800 Zheng Wang wrote:
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 4d6b3b7d6abb..ce2da5101e51 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device *pdev)
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
>  
> +	netif_carrier_off(ndev);
> +	netif_tx_disable(ndev);
> +	cancel_work_sync(&priv->work);

Still racy, the carrier can come back up after canceling the work.
But whatever, this is a non-issue in the first place.
The fact that ravb_tx_timeout_work doesn't take any locks seems much
more suspicious.

