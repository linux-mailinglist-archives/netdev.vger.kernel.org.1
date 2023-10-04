Return-Path: <netdev+bounces-38137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB427B989D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C2DAB2815DC
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD828E05;
	Wed,  4 Oct 2023 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq8S6K15"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1952110B
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 23:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A67C433C7;
	Wed,  4 Oct 2023 23:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696461413;
	bh=xXnSxNXCYKBj1DiiZx2Wh0o09iVv7ahfMtaZr6caxrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rq8S6K15/UijMAdnO95A0BYj8rZ64OJfE5O/kZMxQm1ogB0xPuMKUGljvGJQAf/o6
	 dkAysvjFr4CFszk5YcBNxsndYmdR5XbYFi//fg5XEaKPUI36iYsRyRG/DUXsNwyQ8T
	 cNdxAfY3g4d6tXnCM+PJFigFtVHiyHCSyLFf3RmAFFdcwB1n3dPMuCL+bKibW092Y+
	 8vQFhQF6J+vlvD0ug7qmDByBsWS3Je4m6SAeMTf/s2w3vCmWaF1tWWviGww2RbUOOA
	 tzKmD/sWoUMQpLRHx85thmyFxIbRs3ZNrTSbTySJTZldy4wZAXHQGfijOhe8gHTd8o
	 yGOkU/n4Spv2A==
Date: Wed, 4 Oct 2023 16:16:51 -0700
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
Subject: Re: [PATCH v4 net-next 6/7] net: ethtool: add a mutex protecting
 RSS contexts
Message-ID: <20231004161651.76f686f3@kernel.org>
In-Reply-To: <b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
	<b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 19:13:37 +0100 edward.cree@amd.com wrote:
> While this is not needed to serialise the ethtool entry points (which
>  are all under RTNL), drivers may have cause to asynchronously access
>  dev->ethtool->rss_ctx; taking dev->ethtool->rss_lock allows them to
>  do this safely without needing to take the RTNL.

Can we use a replay mechanism, like we do in TC offloads and VxLAN/UDP
ports? The driver which lost config can ask for the rss contexts to be
"replayed" and the core will issue a series of ->create calls for all
existing entries?

Regarding the lock itself - can we hide it under ethtool_rss_lock(dev)
/ ethtool_rss_unlock(dev) helpers?

