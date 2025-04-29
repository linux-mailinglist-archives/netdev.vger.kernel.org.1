Return-Path: <netdev+bounces-186869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F0AA3B03
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D402188E09A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B9526FD9D;
	Tue, 29 Apr 2025 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1FaOVp4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86B268FF9;
	Tue, 29 Apr 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964420; cv=none; b=HjXSorIwfkOz3Xlccl33VH7xEt9F9kdy/ix1l09OJFjKUGQOKdiaMxFaD9DumNceDyK7HC8bQbqEplc64Csm+cFMX0o96T6V3WC4xXwDHjUYT7SuB1Zuwuqz+UxmjYq8dw1k9WQaMyc8xU1T2VSRpgwWqS7KTy0P7DCwOKvw8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964420; c=relaxed/simple;
	bh=rbjUHm4vjSzvx1jL+WAkU6QZDtxg0tARkYNO803VokE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuvmgiK6ALWj5/qgwctTINCTGF8p6fLTAInL45xG/7CLtxle7TIMXJunMaJnEVoXEkGETWRwACoBjN/3jKrnTIjV4ZTWyvzmycfI4UZlRu2do4FBNr9TiP1Do4HQlM/1XJrcUu5VjL+nClAtzTLsrp+PCPykdZWeV7FvM/I6Vbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1FaOVp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA51AC4CEE3;
	Tue, 29 Apr 2025 22:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745964419;
	bh=rbjUHm4vjSzvx1jL+WAkU6QZDtxg0tARkYNO803VokE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1FaOVp4vPjJOVaFgQpccjGeKpQRbecEknN1GqBvoKOQ6E4P+nz6dbQYNZEXu9IpE
	 JbcKLRKLakHdWad43gUWHVGnNso8m1GCmEfEIqM9E6TkRF+qDdo89DaJYjLlXqWVfM
	 2nzBDx99ftFBXBozrFAI4jsCUwwaP4JyKf482eyaRqs+hORdoM39rctNgXC6rYRb7g
	 dkow2i/PFMI+7XCgvNZh5g/440VEVK+SOhceTnB0roYTnQdfG2xV+96kJcwSStSrYm
	 xIsP+a81krD7lAB/TWTjwaFfSp+5zIXranaMwrCFST2+gdEdmqrXk0QSjPtrl1Fwc+
	 ns1LNv2vE+5Qg==
Date: Tue, 29 Apr 2025 15:06:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Xing <kernelxing@tencent.com>, Richard Cochran
 <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next] net: Add support for providing the PTP
 hardware source in tsinfo
Message-ID: <20250429150657.1f32a10c@kernel.org>
In-Reply-To: <20250425-feature_ptp_source-v1-1-c2dfe7b2b8b4@bootlin.com>
References: <20250425-feature_ptp_source-v1-1-c2dfe7b2b8b4@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 19:42:43 +0200 Kory Maincent wrote:
> Multi-PTP source support within a network topology has been merged,
> but the hardware timestamp source is not yet exposed to users.
> Currently, users only see the PTP index, which does not indicate
> whether the timestamp comes from a PHY or a MAC.
> 
> Add support for reporting the hwtstamp source using a
> hwtstamp-source field, alongside hwtstamp-phyindex, to describe
> the origin of the hardware timestamp.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Not sure moving the hwtstamp_source enum to uapi/linux/net_tstamp.h and
> adding this header to ynl/Makefile.deps is the best choice. Maybe it is
> better to move the enum directly to ethtool.h header.

Weak preference for the YAML and therefore ethtool.h from my side.
That way the doc strings will propagate to more places, like the HTML
docs.

> diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
> index ff0758e88ea1008efe533cde003b12719bf4fcd3..1414aed0b6adeae15b56e7a99a7d9eeb43ba0b6c 100644
> --- a/include/linux/net_tstamp.h
> +++ b/include/linux/net_tstamp.h
> @@ -13,12 +13,6 @@
>  					 SOF_TIMESTAMPING_TX_HARDWARE | \
>  					 SOF_TIMESTAMPING_RAW_HARDWARE)
>  
> -enum hwtstamp_source {
> -	HWTSTAMP_SOURCE_UNSPEC,

when is unspec used in practice? Only path I could spot that may not
set it is if we fetch the data by PHC index?

> -	HWTSTAMP_SOURCE_NETDEV,
> -	HWTSTAMP_SOURCE_PHYLIB,
> -};
> -
>  /**
>   * struct hwtstamp_provider_desc - hwtstamp provider description
>   *

> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index a93e6ea37fb3a69f331b1c90851d4e68cb659a83..bf5fb9f7acf5c03aaa121e0cda3c0b1d83e49f71 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -13,6 +13,19 @@
>  #include <linux/types.h>
>  #include <linux/socket.h>   /* for SO_TIMESTAMPING */
>  
> +/**
> + * enum hwtstamp_source - Source of the hardware timestamp
> + * @HWTSTAMP_SOURCE_UNSPEC: Source not specified or unknown
> + * @HWTSTAMP_SOURCE_NETDEV: Hardware timestamp comes from the net device

We should probably document that netdev here means that the timestamp
comes from a MAC or device which has MAC and PHY integrated together?

> + * @HWTSTAMP_SOURCE_PHYLIB: Hardware timestamp comes from one of the PHY
> + *			    devices of the network topology
> + */
> +enum hwtstamp_source {
> +	HWTSTAMP_SOURCE_UNSPEC,
> +	HWTSTAMP_SOURCE_NETDEV,
> +	HWTSTAMP_SOURCE_PHYLIB,
> +};

> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -920,12 +920,20 @@ int ethtool_get_ts_info_by_phc(struct net_device *dev,
>  		struct phy_device *phy;
>  
>  		phy = ethtool_phy_get_ts_info_by_phc(dev, info, hwprov_desc);
> -		if (IS_ERR(phy))
> +		if (IS_ERR(phy)) {
>  			err = PTR_ERR(phy);
> -		else
> -			err = 0;
> +			goto out;
> +		}
> +
> +		info->phc_source = HWTSTAMP_SOURCE_PHYLIB;
> +		info->phc_phyindex = phy->phyindex;
> +		err = 0;
> +		goto out;

The goto before the else looks a bit odd now.
Can we return directly in the error cases?
There is no cleanup to be done.

> +	} else {
> +		info->phc_source = HWTSTAMP_SOURCE_NETDEV;
>  	}
>  
> +out:
>  	info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
>  				 SOF_TIMESTAMPING_SOFTWARE;
>  
> @@ -947,10 +955,14 @@ int __ethtool_get_ts_info(struct net_device *dev,
>  
>  		ethtool_init_tsinfo(info);
>  		if (phy_is_default_hwtstamp(phydev) &&
> -		    phy_has_tsinfo(phydev))
> +		    phy_has_tsinfo(phydev)) {
>  			err = phy_ts_info(phydev, info);
> -		else if (ops->get_ts_info)
> +			info->phc_source = HWTSTAMP_SOURCE_PHYLIB;
> +			info->phc_phyindex = phydev->phyindex;
> +		} else if (ops->get_ts_info) {
>  			err = ops->get_ts_info(dev, info);
> +			info->phc_source = HWTSTAMP_SOURCE_NETDEV;

Let's move the assignment before the calls if we can?
Otherwise someone adding code below may miss the fact that err may
already be carrying an unhandled error.


