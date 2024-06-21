Return-Path: <netdev+bounces-105527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA391191B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 05:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206752838E9
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCAA86AE3;
	Fri, 21 Jun 2024 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA3E6GXy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60529A5;
	Fri, 21 Jun 2024 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718941488; cv=none; b=fXTRi5KeVeOb6yl1pktpCL2LuGeTsBKs3VfYBt+ZoJcZ1dKY1RdInO+1z7cCVuIynYGfSMbGTNK0T6TZryQ+m2kUGTZUKh4ITiTkHTpyrZAYTH+HxSC0W2D5cEgc9jRaksBlL2PN5vIwPj5VxvgJ72Z8nsXthKq54LWo8cgwvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718941488; c=relaxed/simple;
	bh=DnX9uAy1auF1e2vF25hratSY9Nq7L8HgluP7wty3M5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLdzIMNDzsGSFC2onitFIUJVg9eIK8Hbr4/5vIJBOQcXzHN8vrm8yPIbly1KlvaZK614Vq38homQQJ7Lm/D8WMbXnYycnEZ2/ONa4780xjNIJzubicbabTScupfqqtARNaNdf6UYADnXRJjIHy37IPFVuWAj8bsV9YPC1QUpwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA3E6GXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5AEC2BBFC;
	Fri, 21 Jun 2024 03:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718941488;
	bh=DnX9uAy1auF1e2vF25hratSY9Nq7L8HgluP7wty3M5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NA3E6GXyKzjY0Ubt91vp2aqjumFjhWuBdEzL9nbCOLoHYq5p1bsaWOGIIWPTZUHCZ
	 /+9vVhnFRdH/urD0PATrP/QBEi/Y6ZSnp+hByBIwc+S0VXTddin5lkh7RH3XEtQjvb
	 gyDWp0IOhB2nY06biaIpjQHuygfgd9BZRkPHS1bI9b1xvk8oGPBp79/O3lkeArgBD2
	 XfuQtA/853cnD2wp6GudrXOP1ooQc+wywsBEv57aDCHz+QOjPmjJmDQrLveqALmWiH
	 YW53w6M7WrOLESQKsIpKpbYTFF/T8CEoWhb1LvJVOTs9kk8PqFiO0f07wBnItge4YA
	 YYat1Z9/thJtQ==
Date: Thu, 20 Jun 2024 20:44:45 -0700
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
Message-ID: <20240620204445.2d589788@kernel.org>
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
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -1033,6 +1033,8 @@ Kernel response contents:
>    ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES``     u32     max aggr size, Tx
>    ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES``    u32     max aggr packets, Tx
>    ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
> +  ``ETHTOOL_A_COALESCE_RX_PROFILE``            nested  profile of DIM, Rx
> +  ``ETHTOOL_A_COALESCE_TX_PROFILE``            nested  profile of DIM, Tx
>    ===========================================  ======  =======================
>  
>  Attributes are only included in reply if their value is not zero or the

Maybe add a short line in the section for COALESCE_GET linking to dim?
Something like:

``ETHTOOL_A_COALESCE_RX_PROFILE`` and ``ETHTOOL_A_COALESCE_TX_PROFILE``
refer to DIM parameters, see ... <- add ReST link to net_dim.rst here.

