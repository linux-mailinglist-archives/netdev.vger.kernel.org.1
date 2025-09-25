Return-Path: <netdev+bounces-226153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D5EB9D095
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503907A1542
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275CC27F732;
	Thu, 25 Sep 2025 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDFvjS4p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006041E98EF
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764098; cv=none; b=ibI2+g7zPPmZ81sqmhp3g2sVNfQ8G4wmlLXe6sIAoyKtOz54wuFn/85lDZjitLsBZi6S1X2+6EB7cxmGbORRSyqHI1gV9ve1OnH0DJmBu7iO8bxPqnq4dn/w+ZP7/OkDRPwBDvfMwwgNfSpOA7KqRYKzadwL3fuRjrp3sjPJXUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764098; c=relaxed/simple;
	bh=5NFsjewaLPU81+z/R5BrJU0sDFPRn9Qdv++Pp1tKv1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPqXuNSD7E8d4MVimaaLsr/ywpwZhWWVApk7Sop2kt9eNLcLkyg/iDOLhOoSqzoYvaH7qGBFvK5GF6v/R0vnd4ZOSJr7lZP30UR/FbgLW+rOlagNGP4/u5skfG/SUElaX9k4+ONjSNnD1lIkPxx5etgCOB5x48Vth2UESfuw8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDFvjS4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DB9C4CEE7;
	Thu, 25 Sep 2025 01:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758764097;
	bh=5NFsjewaLPU81+z/R5BrJU0sDFPRn9Qdv++Pp1tKv1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mDFvjS4pYGrUiHRQTapMtaqg9134Esriu0InJ4RFOogBylFBNpAbyw3d6x+rXfMQv
	 qYZPabSvuxD8Bw+m3wxwNCCjjKDyvxmWWbmOxupydVGWulLcrUEK6es2Ug5n20LVZj
	 dolYFEbCNIqwQGQpaCpDrPvz0Y1Gy3x722arOGH+l7BDkuWNsgUNPdoal+RTpJIe1P
	 K7Sneh5+G0nzBpWba/Vq/75CghnjptgpvsRvfDcWOSrwioaMpxUzHvPax37/mF0WcB
	 EtIIIoX2LdoRw+kDULfUJoly8saBFhgxGB6d6TXRfu2y6ZNi6G79WoXIReZkSF+ViA
	 x4/h5Vbjv62xQ==
Date: Wed, 24 Sep 2025 18:34:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v5 4/4] net: libwx: restrict change user-set
 RSS configuration
Message-ID: <20250924183456.5508ee95@kernel.org>
In-Reply-To: <20250922094327.26092-5-jiawenwu@trustnetic.com>
References: <20250922094327.26092-1-jiawenwu@trustnetic.com>
	<20250922094327.26092-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 17:43:27 +0800 Jiawen Wu wrote:
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -472,6 +472,12 @@ int wx_set_channels(struct net_device *dev,
>  	if (count > wx_max_channels(wx))
>  		return -EINVAL;
>  
> +	if (netif_is_rxfh_configured(wx->netdev)) {
> +		wx_err(wx, "Cannot change channels while RXFH is configured\n");
> +		wx_err(wx, "Run 'ethtool -X <if> default' to reset RSS table\n");
> +		return -EBUSY;
> +	}

Why the check in set_channels? Kernel already rejects attempts to
decrease queue count below what's configured in the indir table.
If table is set you should be able to change the ring count, just
don't override the table.

