Return-Path: <netdev+bounces-50941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FC7F7A17
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 18:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84ADAB20CC3
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4534C31754;
	Fri, 24 Nov 2023 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHxMm9u1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494831730
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 17:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDAEC433CA;
	Fri, 24 Nov 2023 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700845691;
	bh=N6eKa6WfMK+P6QxFOZlfSTYYVqTpDOay3TuZvDz49n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHxMm9u1mMdx4N1F/JdO5WDKNIARNwK+oEk/f5MTc2gwWWXdnb4XOhlos6fZv0ckr
	 1py3975fia0mRXMPlQMdjVjKxL53JpgTwcG3rvnHQpCr8BcrM7H6w+zU9dB77D/D5z
	 83YrmiGMtVn855hQ1ZmWM+NjyvOV6dQVgH+bmtjfwSWXd7FTC9DuqpBVan5Z+TJ44Q
	 R1HDPglOvv1jfIcHG3Tn7/h/iwhhgXLQvr6Sn3KAE9qLHCGzUkimLx/KpzvilSIitM
	 PC3BT4wrUiLNAkwnulC5I6OOvqMQiSBXdYaU7qBSDI4r9mygQeqrTHn45pxrxMIH9V
	 MODQ2dzif3ppw==
Date: Fri, 24 Nov 2023 17:08:04 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
	wizhao@redhat.com, konguyen@redhat.com, jesse.brandeburg@intel.com,
	sumang@marvell.com, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 2/2] octeon_ep: get max rx packet length from
 firmware
Message-ID: <20231124170804.GU50352@kernel.org>
References: <20231122183435.2510656-1-srasheed@marvell.com>
 <20231122183435.2510656-3-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122183435.2510656-3-srasheed@marvell.com>

On Wed, Nov 22, 2023 at 10:34:35AM -0800, Shinas Rasheed wrote:
> Max receive packet length can vary across SoCs, so
> this needs to be queried from respective firmware and
> filled by driver. A control net get mtu api should be
> implemented to do the same.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 2da00a701df2..423eec5ff3ad 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1307,6 +1307,7 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	struct octep_device *octep_dev = NULL;
>  	struct net_device *netdev;
> +	int max_rx_pktlen;
>  	int err;
>  
>  	err = pci_enable_device(pdev);
> @@ -1377,8 +1378,15 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	netdev->hw_features = NETIF_F_SG;
>  	netdev->features |= netdev->hw_features;
> +
> +	max_rx_pktlen = octep_ctrl_net_get_mtu(octep_dev, OCTEP_CTRL_NET_INVALID_VFID);
> +	if (max_rx_pktlen < 0) {
> +		dev_err(&octep_dev->pdev->dev,
> +			"Failed to get max receive packet size; err = %d\n", max_rx_pktlen);
> +		goto register_dev_err;

Hi Shinas,

This jump will cause this function to return err.  But err is 0 here.
Perhaps it should be set to a negative error value instead?

> +	}
>  	netdev->min_mtu = OCTEP_MIN_MTU;
> -	netdev->max_mtu = OCTEP_MAX_MTU;
> +	netdev->max_mtu = max_rx_pktlen - (ETH_HLEN + ETH_FCS_LEN);
>  	netdev->mtu = OCTEP_DEFAULT_MTU;
>  
>  	err = octep_ctrl_net_get_mac_addr(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
> -- 
> 2.25.1
> 

