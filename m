Return-Path: <netdev+bounces-34004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C77A159B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 07:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EB41C21241
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 05:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA246AB;
	Fri, 15 Sep 2023 05:45:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63FD809
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C79CC433C7;
	Fri, 15 Sep 2023 05:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694756746;
	bh=RkQ+VQK/LtyZI9gl6pg1mDINFpvds0mAdYYBVjSe2Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFmeNfCmf0UoU2TDXz1Q08pNza4cMwv4wVxKRKe9UD+B+ZRsXpTFSVLgpalZJp562
	 lxz2ddDGm3iwA9uamSzYoUyClxUMGDmnCFkhU3ZPzgcOYSRhxAzTxFuDLNBHztl9hc
	 6qwACV+O4ac+Ec/vlysxEeDvCvoKMBcBE79uTIWfbHK1bC1wv9GuF8CuCBvC0bDMeJ
	 Iqz74JV9xRnnA4qFRN9lQEdyqVTfWL8jwv8mriXX+1IKbid9loMRY9J8XWIfJdATEh
	 6amQveAa5iTUdzxteuxFLbRxYZhRLOEaGKF4zBYIVJwZU2VpBV2QhhyHkThy33rqPT
	 ryaHOif+TQ82g==
Date: Fri, 15 Sep 2023 07:45:41 +0200
From: Simon Horman <horms@kernel.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/qlcnic: fix possible use-after-free bugs in
 qlcnic_alloc_rx_skb()
Message-ID: <20230915054541.GB758782@kernel.org>
References: <20230913104119.3344592-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913104119.3344592-1-make_ruc2021@163.com>

On Wed, Sep 13, 2023 at 06:41:19PM +0800, Ma Ke wrote:
> In qlcnic_alloc_rx_skb(), when dma_map_single() fails, skb is freed
> immediately. And skb could be freed again. This issue could allow a
> local attacker to crash the system due to a use-after-free flaw.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> index 41894d154013..6501aaf2b5ce 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> @@ -832,6 +832,7 @@ static int qlcnic_alloc_rx_skb(struct qlcnic_adapter *adapter,
>  	if (dma_mapping_error(&pdev->dev, dma)) {
>  		adapter->stats.rx_dma_map_error++;
>  		dev_kfree_skb_any(skb);
> +		skb = NULL;
>  		return -ENOMEM;

Hi Ma Ke,

I am a unclear on how skb could be freed a second time.
skb is a local variable which goes out of scope when
the function returns.

