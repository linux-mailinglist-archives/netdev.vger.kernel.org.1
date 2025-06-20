Return-Path: <netdev+bounces-199700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57BAAE182F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB5E7A6478
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9943238C0C;
	Fri, 20 Jun 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJrRXQAE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBC238C08
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412940; cv=none; b=j3ydnbeZI7rG+ThmpbYSkgqsUzjGMRhRUg91j93bVArRmIQcc09LTxeXUAXlESBWI66RTERaksahTyZ1v8ClviMqIPL3QFE1P2fEYigByaNI5eJM3bDUsZkENNnQfGArVqJf/mwuN4GSBap8thamKJHaJU84TpFkGvYTpr5mUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412940; c=relaxed/simple;
	bh=ZmhO7M2Y8zFmKYYEAbX+ccnhSmhCSAHgcj+UBa14GMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd83tnhJinqD2FTqVBHLJlhJo8Yk+4gDcpxGqmeS/Y0SeQjGrp8SwEvMUIu9oE+XjZ+7fb1+u1J5bU5sVCGB0YTe0LbgkqJXTksgSZC3uWUabgaLe01lnjZ0OmimG3/jXaksc2MgEQt3eSx4GlWtmaY88C9iKJVhSdKWSej9ptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJrRXQAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8230AC4CEE3;
	Fri, 20 Jun 2025 09:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750412938;
	bh=ZmhO7M2Y8zFmKYYEAbX+ccnhSmhCSAHgcj+UBa14GMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJrRXQAETfqXficchVHAVOtCR4i24c6Aw/HAkeS74LKBx7aZQb4aAlJ7F4x/VBfal
	 Ad4LlmuuVEno2O0s4jWPRwtp06O2++gKMWu3OKRgRw21ERD+4n2nDBThWLgRSvZA8g
	 Y5++D+xkJr0oRiG+wXt8z9SPp5Bg5pFHzsoCA5A0ljPpWADWZXuh2T14VjnewjtINJ
	 6QFAvpNaoXMf+cDDpKxiuXa3qpVEa060KhpeqOR5IkLQhdkni9suHuQsQ4TPe//j8n
	 zTsbeElg6hxonyW0epsbXK8pZULCcbr9X4fEgz30ppbEQFbUv7UtGt05hSs3INUvOn
	 TilPtYDltZGGQ==
Date: Fri, 20 Jun 2025 10:48:52 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, shenjian15@huawei.com,
	salil.mehta@huawei.com, shaojijie@huawei.com, cai.huoqing@linux.dev,
	saeedm@nvidia.com, tariqt@nvidia.com, louis.peens@corigine.com,
	mbloch@nvidia.com, manishc@marvell.com, ecree.xilinx@gmail.com,
	joe@dama.to
Subject: Re: [PATCH net-next 04/10] eth: benet: migrate to new RXFH callbacks
Message-ID: <20250620094852.GA194429@horms.kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
 <20250618203823.1336156-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618203823.1336156-5-kuba@kernel.org>

On Wed, Jun 18, 2025 at 01:38:17PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> The driver has no other RXNFC functionality so the SET callback can
> be now removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> @@ -1132,11 +1139,20 @@ static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>  	return 0;
>  }
>  
> -static int be_set_rss_hash_opts(struct be_adapter *adapter,
> -				struct ethtool_rxnfc *cmd)
> +

super nit: there are two consecutive blank lines are here now

> +static int be_set_rxfh_fields(struct net_device *netdev,
> +			      const struct ethtool_rxfh_fields *cmd,
> +			      struct netlink_ext_ack *extack)
>  {
> -	int status;
> +	struct be_adapter *adapter = netdev_priv(netdev);
>  	u32 rss_flags = adapter->rss_info.rss_flags;
> +	int status;
> +
> +	if (!be_multi_rxq(adapter)) {
> +		dev_err(&adapter->pdev->dev,
> +			"ethtool::set_rxfh: RX flow hashing is disabled\n");
> +		return -EINVAL;
> +	}
>  
>  	if (cmd->data != L3_RSS_FLAGS &&
>  	    cmd->data != (L3_RSS_FLAGS | L4_RSS_FLAGS))

