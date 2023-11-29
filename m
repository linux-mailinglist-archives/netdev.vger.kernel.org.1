Return-Path: <netdev+bounces-52216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE297FDE55
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EC81C20945
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91E3D0BB;
	Wed, 29 Nov 2023 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFV1PVjk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B294338F91
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 17:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D050EC433C9;
	Wed, 29 Nov 2023 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701278798;
	bh=14utwrkfwECFxJzYSOTHRPRY0fg00Fk8Fx6zj6nhmNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFV1PVjk3CzHbKlN1oIZ5XYeQu/pCAOdI0THaCT1EYtCDNywxqA4dQUbX/hJQZZjG
	 NeDPEON1l7yf5VKQl95bmtIfQay+8PtARSWstCZhiFZzTp23wfcxB/CYm2NzYT43uq
	 LsVYSCgaatIi5iUztF+mHyynOvruD4TNrvA6zq+M50v+ncEz39bBoUlOt3ZRwSeWmk
	 b0EXyGmLIGU8OxURFvPFN4EP7LOGMZkOWGKsn8J9h2lxc7mC2oIX0RQ6AyrrsA0aP7
	 J2DHg9Qv57Gr9bhpWRYjVu/Nj0Lh0KH+JCkze9z7WKiV9b9MGQFNxPS8Y/cjdejmRU
	 pgkuURdsKUHag==
Date: Wed, 29 Nov 2023 17:26:33 +0000
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	lcherian@marvell.com, jerinj@marvell.com
Subject: Re: [PATCH v2 net] octeontx2-pf: Add missing mutex lock in
 otx2_get_pauseparam
Message-ID: <20231129172633.GG43811@kernel.org>
References: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>

On Wed, Nov 29, 2023 at 10:53:42AM +0530, Subbaraya Sundeep wrote:
> All the mailbox messages sent to AF needs to be guarded
> by mutex lock. Add the missing lock in otx2_get_pauseparam
> function.
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v2 changes:
>  Added maintainers of AF driver too

Hi Subbaraya,

I was expecting an update to locking in otx2_dcbnl_ieee_setpfc()
Am I missing something here?

Link: https://lore.kernel.org/all/CO1PR18MB4666C2C1D1284F425E4C9F38A183A@CO1PR18MB4666.namprd18.prod.outlook.com/

> 
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 9efcec5..53f6258 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -334,9 +334,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
>  	if (is_otx2_lbkvf(pfvf->pdev))
>  		return;
>  
> +	mutex_lock(&pfvf->mbox.lock);
>  	req = otx2_mbox_alloc_msg_cgx_cfg_pause_frm(&pfvf->mbox);
> -	if (!req)
> +	if (!req) {
> +		mutex_unlock(&pfvf->mbox.lock);
>  		return;
> +	}
>  
>  	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
>  		rsp = (struct cgx_pause_frm_cfg *)
> @@ -344,6 +347,7 @@ static void otx2_get_pauseparam(struct net_device *netdev,
>  		pause->rx_pause = rsp->rx_pause;
>  		pause->tx_pause = rsp->tx_pause;
>  	}
> +	mutex_unlock(&pfvf->mbox.lock);
>  }
>  
>  static int otx2_set_pauseparam(struct net_device *netdev,
> -- 
> 2.7.4
> 

