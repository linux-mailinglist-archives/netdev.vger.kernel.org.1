Return-Path: <netdev+bounces-20680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF6476097D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCF92817D0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A4847A;
	Tue, 25 Jul 2023 05:40:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6F8BE5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12EEC433C7;
	Tue, 25 Jul 2023 05:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690263651;
	bh=VEjQx7H1H+Mb+AJoPV4BZFXw7TX8zA9RwisdpdkLNwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFXTRYo1hIredh5OpbIa/0sE9HPeA7+c/oG6J17Iqb7+3ofR0Zj0Mj6PmdnelcXVd
	 4xbcYRK408jG39EjjZQF+NI1oyAQjemYoD8HN9rk9d4R+CB1LdxuclPhx9oJ8k12xb
	 HDpOHt1NG/1aRVJieW+CeGukcrf/9rOv6M9d3LJJP0CmvNrrH7TkQDl27SgmEUqZyr
	 4FBNNp6wAJA9VuMpZMysRlqUr3bQ9kGbKvmLVS1om/cD9WOzgxZwjpu1ZxexWyt/zy
	 8mIDWKZq57LQHlaxDZUX7F02niWvQMbDKVnnZ/s9IPRucVshhg5NLF027Tdz7nXIpc
	 EwUDUWkAfXT6Q==
Date: Tue, 25 Jul 2023 08:40:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
Message-ID: <20230725054046.GK11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
 <20230724174435.GA11388@unreal>
 <20230724142155.13c83625@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724142155.13c83625@kernel.org>

On Mon, Jul 24, 2023 at 02:21:55PM -0700, Jakub Kicinski wrote:
> On Mon, 24 Jul 2023 20:44:35 +0300 Leon Romanovsky wrote:
> > > @@ -13186,6 +13186,9 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
> > >  		if (nla_type(attr) != IFLA_BRIDGE_MODE)
> > >  			continue;
> > >  
> > > +		if (nla_len(attr) < sizeof(mode))
> > > +			return -EINVAL;
> > > +  
> > 
> > I see that you added this hunk to all users of nla_for_each_nested(), it
> > will be great to make that iterator to skip such empty attributes.
> > 
> > However, i don't know nettlink good enough to say if your change is
> > valid in first place.
> 
> Empty attributes are valid, we can't do that.

Maybe Lin can add special version of nla_for_each_nested() which will
skip these empty NLAs, for code which don't allow empty attributes.

> 
> But there's a loop in rtnl_bridge_setlink() which checks the attributes.
> We can add the check there instead of all users, as Leon points out.
> (Please just double check that all ndo_bridge_setlink implementation
> expect this value to be a u16, they should/)
> -- 
> pw-bot: cr

