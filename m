Return-Path: <netdev+bounces-220801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC19B48C91
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A976E173A6C
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A72EBDE6;
	Mon,  8 Sep 2025 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6eS8GTB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29A22D4F1;
	Mon,  8 Sep 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332280; cv=none; b=BcBfQSrrcl99Gl1bM2NbUnjMpn/A92PIXEA2ThDnT7imcNskJpCtYt8hnSnLsdy/D0x0wz6CrC6JRkgwkTiKnXv5hCdd5nxMzPa8JZay2zlmmYS2sXt7zgk6v4sjFjBDfK2btizgF5J6z3Yv09mi+wjs/WT3EcYXDMtIYzNJZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332280; c=relaxed/simple;
	bh=vUTnTma/8RIaYO0H0Kvma2cetHfMTmzLLUpsIQV0Rrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYcHmE9j+RMyhgIj1FSqReGHtlArSXblz323LBb9Eo73gv+BI45CxWXFOUMoxerLH8qeBG28bopF4E4N/ffQbEP7rcOIBerOmc6gMXqodbPzlEw2eH8Ep+ieVX7aDGizxqndkSLr0fEu1Hnl084zbMTv1jeanJpkosJlaEs+zMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6eS8GTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D878C4CEF1;
	Mon,  8 Sep 2025 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757332279;
	bh=vUTnTma/8RIaYO0H0Kvma2cetHfMTmzLLUpsIQV0Rrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6eS8GTB2Q3GpNZ77Ub9KoHolo515aunpbAUSsD7SVGt+z2NNCimiwffIiJiAHyml
	 QgWvePw5RoSLeLHmuOVk7Mt6w9VbVixs0YZ4f8ZhV3nLvLVXDZq+M4so+jXJcHY/in
	 c9MPYBvb1DK2MmjCcS8nZVIo2wV724iXKd5q85SLBIehLBkHy1LKjkZRkVpwCnC1Ql
	 7/jbDOesEd32kMNzvqpNKtdzdXjWHciENXaq43M9bx3mXB0szimGq5Pk9Z5ZS41OCR
	 1gjpwcaOX6+bTHGY+AdiD6q1IUZZA6sOU7N4cK8Y11y4DuEfE41tTk7Wc50OAG26Pv
	 EyZ203HNaY3yg==
Date: Mon, 8 Sep 2025 12:51:14 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kuba@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	jdamato@fastly.com, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next 4/7] net: ethtool: add get_rxrings callback
 to optimize RX ring queries
Message-ID: <20250908115114.GE2015@horms.kernel.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
 <20250905-gxrings-v1-4-984fc471f28f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-gxrings-v1-4-984fc471f28f@debian.org>

On Fri, Sep 05, 2025 at 10:07:23AM -0700, Breno Leitao wrote:
> Add a new optional get_rxrings callback in ethtool_ops to allow drivers
> to provide the number of RX rings directly without going through the
> full get_rxnfc flow classification interface.
> 
> Modify ethtool_get_rxrings() to use get_rxrings() if available,
> falling back to get_rxnfc() otherwise.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/ethtool.h |  1 +
>  net/ethtool/ioctl.c     | 25 +++++++++++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index de5bd76a400ca..4f6da35a77eb1 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1141,6 +1141,7 @@ struct ethtool_ops {
>  				 struct ethtool_ringparam *,
>  				 struct kernel_ethtool_ringparam *,
>  				 struct netlink_ext_ack *);
> +	int	(*get_rxrings)(struct net_device *dev);

Hi Breno,

Please also add get_rxrings to the Kernel doc for struct ethtool_ops.

>  	void	(*get_pause_stats)(struct net_device *dev,
>  				   struct ethtool_pause_stats *pause_stats);
>  	void	(*get_pauseparam)(struct net_device *,

