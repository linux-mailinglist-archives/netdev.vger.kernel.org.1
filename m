Return-Path: <netdev+bounces-38135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C87B9896
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A12CA1C208E0
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B62266DE;
	Wed,  4 Oct 2023 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyjtM517"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E32250F0
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 23:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9311AC433C8;
	Wed,  4 Oct 2023 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696461043;
	bh=+qj7Fd/j1UGbEXGG0Id+mpKrby/cTsFIGxcvyLAQmj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PyjtM517WKKuMEraWKNla+zYruzOTrYBqY+NWy1tB+Q5VRxReMVeT14PJ433KyAv7
	 NHzsDqyMyrK7u3PZEqz/aG83UvTeHVmZaBEuuG3Y7qaa9sxc/kL4srk/sfYjpCAw/r
	 ojyLBnU4Kz94X3xBYW6XPg6F+umZzC9bBH+uSwHRPbcdTJ2LZ9jF11LW4Te0mTIS1h
	 Dngdib/2Irabrxkebm1xn9dz5MSTpEH0cYxpEFViOsYoX3X8FZs5LKM8l2CWM/zXfQ
	 nR8h3gImNm/iE00x9Uz9+YMKuZA419Tn2POIK3QFMMIh3DoGd+a1kHiBzKgtZP0F+z
	 T9xic7hJPsnyQ==
Date: Wed, 4 Oct 2023 16:10:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <linux-net-drivers@amd.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
 <habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
 <jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
 <linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
 <leon@kernel.org>
Subject: Re: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of
 custom RSS contexts to a netdevice
Message-ID: <20231004161041.027b2d80@kernel.org>
In-Reply-To: <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
	<4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 19:13:33 +0100 edward.cree@amd.com wrote:
>  /**
>   * struct ethtool_netdev_state - per-netdevice state for ethtool features
> + * @rss_ctx:		XArray of custom RSS contexts
> + * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID

Is this one set by the driver? How would it be set?
It'd be good if drivers didn't access ethtool state directly.
Makes core easier to refactor if the API is constrained.

>   * @wol_enabled:	Wake-on-LAN is enabled
>   */
>  struct ethtool_netdev_state {
> -	unsigned		wol_enabled:1;
> +	struct xarray		rss_ctx;
> +	u32			rss_ctx_max_id;
> +	u32			wol_enabled:1;

