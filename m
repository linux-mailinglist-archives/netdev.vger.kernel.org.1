Return-Path: <netdev+bounces-28333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7377F127
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A01C212DB
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCB8211F;
	Thu, 17 Aug 2023 07:26:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA1C8C7
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09AAC433C7;
	Thu, 17 Aug 2023 07:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692257173;
	bh=rX2u6IoDL8Tfw9baJxY2WocRZzgyIXdHAEvyzbI7lTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1MQdJ+5sr1HgzVKdueHfm+YtrXVIf3FgbPyt/t7NsCr4VBddewXNaSy6Xct+u7D4
	 W7wZSFtVyZD1dCe2Vg1CR+aehNyx8sB6+PLFszwlVdTfVejCjI8F+6QIvpOJbWz5NV
	 eMYseLrVOdaMv/uMmFYDJ0G7qI25dHsdx8t1FL26Izb7Ki+8DfxU9MvNtr3psTeKQ9
	 rm5zes2MFIBpU1FdJX20W+dBbw3BTaiyvhMHiWTvPYUKPJP0GGoTM1iPc1Fh6B6Ez6
	 Ge17Y6cdY6zxO+qm9h9QTyJnUNnabt5RKW4eI2p2e5C9XrlfTWcrpzp0KDuPLbCWmm
	 MfiaeP+z1vhaw==
Date: Thu, 17 Aug 2023 09:26:09 +0200
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com, linyunsheng@huawei.com,
	almasrymina@google.com
Subject: Re: [RFC net-next 05/13] net: page_pool: record pools per netdev
Message-ID: <ZN3LkR+b9Onpy1XH@vergenet.net>
References: <20230816234303.3786178-1-kuba@kernel.org>
 <20230816234303.3786178-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816234303.3786178-6-kuba@kernel.org>

On Wed, Aug 16, 2023 at 04:42:54PM -0700, Jakub Kicinski wrote:
> Link the page pools with netdevs. This needs to be netns compatible
> so we have two options. Either we record the pools per netns and
> have to worry about moving them as the netdev gets moved.
> Or we record them directly on the netdev so they move with the netdev
> without any extra work.
> 
> Implement the latter option. Since pools may outlast netdev we need
> a place to store orphans. In time honored tradition use loopback
> for this purpose.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

...

> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c

...

> +static void page_pool_unreg_netdev(struct net_device *netdev)
> +{
> +	struct page_pool *pool, *last;
> +	struct net_device *lo;
> +
> +	lo = __dev_get_by_index(dev_net(netdev), 1);
> +	if (!lo) {
> +		netdev_err_once(netdev,
> +				"can't get lo to store orphan page pools\n");
> +		page_pool_unreg_netdev_wipe(netdev);
> +		return;
> +	}
> +
> +	mutex_lock(&page_pools_lock);
> +	hlist_for_each_entry(pool, &netdev->page_pools, user.list) {
> +		pool->slow.netdev = lo;
> +		last = pool;
> +	}
> +
> +	hlist_splice_init(&netdev->page_pools, &last->user.list,

Hi Jakub.

I'm not sure if it is possible, but if the hlist loop above iterates zero
times then last will be uninitialised here.

Flagged by Smatch.

> +			  &lo->page_pools);
> +	mutex_unlock(&page_pools_lock);
> +}

...

