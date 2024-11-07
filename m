Return-Path: <netdev+bounces-142611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6939BFC58
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05210B20A50
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29979F6;
	Thu,  7 Nov 2024 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDi4rXJY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95DD17548
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945321; cv=none; b=JG5aO5ciNV6+FYoN+NMPfrDwfqFiiAjUZQ+tL+mxvniepFWhEYOlaPsjkq21e2QZtgz09cT2poaPqVaB4LHmb8njFlFN7iRfm52wqvOZOn9zp2h4ekUvtZlzxZ1xLlAXhktvUSM8QBTNU61MYDcw9Tw1F/KA5zwC7+GbxC3554U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945321; c=relaxed/simple;
	bh=i5yAoEiW+KQFkmSkCeqeNF6e6oLdoKQqLIzj0ZIpfKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6Y9I8o1m8tONFgIxm3i82DcuDcc24eD+suNltFlg3iewe9w5II84EVW9MkJzSrQJ22p0F/yDIRriJMemut7kCCZYAdUmtW3vZa75y6bjrQNIYqS0z68agVIPlkfG6T5Yt/Jlu94JIId6HXzETH2k7rdJ2p8bnOySWz+RYWJgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDi4rXJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC86C4CEC6;
	Thu,  7 Nov 2024 02:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730945320;
	bh=i5yAoEiW+KQFkmSkCeqeNF6e6oLdoKQqLIzj0ZIpfKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDi4rXJYtRXKSypHZIRiyix/JGCW2/dwBhNr/dSVSNMNz/jxjcR+hfXVWEp+jH2Jg
	 xPXY9hYV41nJYyvOGU9YsnwZU4By2GvtggpFVfL/0JeWkBUy7scwido/ED1jRHwJUw
	 3yfLM/usI7C1IoI7ElljvyH3KmfUG3iDPEijdceLGd7hUTntzlu5POX5YwMHqEliiC
	 dTK+g/OyWyy/V0XARGQHj/SxrsvorsjIakSJ6ZI0RBndQTrveFm7tJXltPkitOfqOX
	 YmpR2O25iIiXzFJFe06iiZkqMaxV1BRekuzMC+wkxGJt+OZwP51BlSlBbFgALrZrvv
	 6PmI6ZmjlarQA==
Date: Wed, 6 Nov 2024 18:08:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Paul Greenwalt
 <paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>, Eric
 Joyner <eric.joyner@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 01/15] ice: Add E830 checksum offload support
Message-ID: <20241106180839.6df5c40e@kernel.org>
In-Reply-To: <20241105222351.3320587-2-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
	<20241105222351.3320587-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 14:23:35 -0800 Tony Nguyen wrote:
> +static netdev_features_t
> +ice_fix_features_gcs(struct net_device *netdev, netdev_features_t features)
> +{
> +	if (!((features & NETIF_F_HW_CSUM) && (features & NETIF_F_ALL_TSO)))
> +		return features;
> +
> +	if (netdev->features & NETIF_F_HW_CSUM) {
> +		netdev_warn(netdev, "Dropping TSO. TSO and HW checksum are mutually exclusive.\n");
> +		features &= ~NETIF_F_ALL_TSO;
> +	} else {
> +		netdev_warn(netdev, "Dropping HW checksum. TSO and HW checksum are mutually exclusive.\n");
> +		features &= ~NETIF_F_HW_CSUM;
> +	}

why dropping what the user requested with a warning and not just return
an error from ice_set_features()?

