Return-Path: <netdev+bounces-105525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFBA911914
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 05:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EEBB22679
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED7D12C465;
	Fri, 21 Jun 2024 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXBBK6rs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13312BF23;
	Fri, 21 Jun 2024 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718941161; cv=none; b=Da0MsmIJ84VISU5EGOUX9OdJpE8HjPcDdk3Zb5Uzny47SKJF0rLAv707C15uLbARv5ZCUMZJ71ouk6ssai3fQtMXccl0CrVKTKLh/fpQu/n8tlsDz02a0qXieYUBiICfBg4vl2sgf2d0odhkyrxaghjr1kV+qMKOxfamOBt2GRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718941161; c=relaxed/simple;
	bh=O2mjlvH6POTe7UflFnHi0jmr3UYZSQa9RjWHwGlsbrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDq/xq7rr82l0AuAZVtTxNwxFA7dgqfyB6T4VqDsK/VW7MWvnQ367qWunvQNTdJf0+rECCBg6fNYbrJQFcaTJinpE9EnRC4pepw/rjqs5gJerYsqE0M4tvb7BO4M321vsnif8hoKyc+0JiYEMDQNpseHbtZi2kRseyOWyD68I7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXBBK6rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EF9C2BBFC;
	Fri, 21 Jun 2024 03:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718941161;
	bh=O2mjlvH6POTe7UflFnHi0jmr3UYZSQa9RjWHwGlsbrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gXBBK6rsrzqoIc35nPQsRFsZZrHOcCqFZ1duUbyKqNPzCD032JyJr04UH3rHlVGeA
	 RsYKWZLdCZxWoamB2PYLWxvT4YjDavw49CF+Hm087FRvDVTMenPX2Bccc7okOQwjjS
	 2xIhaMadAZ7YidSd/23v3WJiM+2ymqXRpir/lcSgc3DQPowR4LHMR70qYxBCqZTn4s
	 4pp66v/TxOt6hz7Pcf97pCyNOboKCM8m6QIn4LUWjRHHxwra1yeUi2A6660EVDDpIP
	 yHI0PqR0sJ2z+WZl0rxir9s1IiX2+fQvJar3LKzysETDZwHpxha8MbGn21S9BSKVVj
	 CNPq28WF1Be0A==
Date: Thu, 20 Jun 2024 20:39:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Jason Wang <jasowang@redhat.com>, "Michael S
 . Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
 Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, donald.hunter@gmail.com, Eugenio =?UTF-8?B?UMOp?=
 =?UTF-8?B?cmV6?= <eperezma@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dragos Tatulea <dtatulea@nvidia.com>, Rahul
 Rameshbabu <rrameshbabu@nvidia.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 awel Dembicki <paweldembicki@gmail.com>
Subject: Re: [PATCH RESEND net-next v14 3/5] ethtool: provide customized dim
 profile management
Message-ID: <20240620203918.407185c9@kernel.org>
In-Reply-To: <20240618025644.25754-4-hengqi@linux.alibaba.com>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
	<20240618025644.25754-4-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 10:56:42 +0800 Heng Qi wrote:
> +	if (dev->irq_moder && dev->irq_moder->profile_flags & DIM_PROFILE_RX) {
> +		ret = ethnl_update_profile(dev, &dev->irq_moder->rx_profile,
> +					   tb[ETHTOOL_A_COALESCE_RX_PROFILE],
> +					   info->extack);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (dev->irq_moder && dev->irq_moder->profile_flags & DIM_PROFILE_TX) {
> +		ret = ethnl_update_profile(dev, &dev->irq_moder->tx_profile,
> +					   tb[ETHTOOL_A_COALESCE_TX_PROFILE],
> +					   info->extack);
> +		if (ret < 0)
> +			return ret;
> +	}

One last thing - you're missing updating the &mod bit.
When any of the settings were change mod should be set
to true so that we send a notification to user space,
that the settings have been modified.

