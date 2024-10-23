Return-Path: <netdev+bounces-138389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF69AD459
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 20:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964BA1C21BF6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9A1D3195;
	Wed, 23 Oct 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWb4PeR8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83001D1728
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709934; cv=none; b=qKzZOxEVfw8XdMp8MQ56RuaNTNnifuOtbaQmb5co0Mukbfl2JrqDCnn/JaJ5Cjr31PMdbuQF9V4diIokDRAsZ3D4RKeGo41o1FYpCza3pczy5x2mwrdFAQe85RH4VaFVptSxAmjU7DE36E/x2zPw6pVT4WNdVwzQ7BVmxvBEU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709934; c=relaxed/simple;
	bh=zLSfamJbg+VTiQytxp0Z5NQKYHyn1+NPr//+WIT5Gbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1ipGxHnRuJ/kKSnEQSut4OjAysHt47XM3LmxI2LqzcNuevZJNw+a27Rv22mGSTQXtOc5dauQaJMPyROjojxyw1mxnlShbmsa6oYaW5X7uVxBe69oj8quOaRmGSEfoQKQLM2bFH6F79wBQCe996dxps8EQ+lO0E/hc6fRfjtVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWb4PeR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6C2C4CEC7;
	Wed, 23 Oct 2024 18:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729709934;
	bh=zLSfamJbg+VTiQytxp0Z5NQKYHyn1+NPr//+WIT5Gbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWb4PeR8bM3F0NLuCGSQc/2M9GehmryYQ2mEB9IzvTzQqqgHZ6DcndcHVPLpQXoVX
	 kuDOqB44ve+jnv5zTI2XPlwCpqfQyB6JP2hSb3lQnngyn+U0EdSAsp8xwBIUwr2tZN
	 kS1UOIjOkelbEIIunzl9JDRvTDvVi1Qz2TLRkuAhC9VOEabE5zaJqYG68sDtPhSDYM
	 yJIifKComB5VVx9PcmvjCa9Zt6Znew5y1cysbFAAjT88JoSyFjgm4i9X63pgaRrTB9
	 p10fuZE4KOvDISVdtbWaXU9lWMo4zJFCOk7mv/Kq+ocBZ7z2DORD0EZdWvuz7lkqHJ
	 ZqCBR8R+BlXQg==
Date: Wed, 23 Oct 2024 19:58:50 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 net-next 01/12] rtnetlink: Make per-netns RTNL
 dereference helpers to macro.
Message-ID: <20241023185850.GC402847@kernel.org>
References: <20241021183239.79741-1-kuniyu@amazon.com>
 <20241021183239.79741-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241021183239.79741-2-kuniyu@amazon.com>

On Mon, Oct 21, 2024 at 11:32:28AM -0700, Kuniyuki Iwashima wrote:
> When CONFIG_DEBUG_NET_SMALL_RTNL is off, rtnl_net_dereference() is the
> static inline wrapper of rtnl_dereference() returning a plain (void *)
> pointer to make sure net is always evaluated as requested in [0].
> 
> But, it makes sparse complain [1] when the pointer has __rcu annotation:
> 
>   net/ipv4/devinet.c:674:47: sparse: warning: incorrect type in argument 2 (different address spaces)
>   net/ipv4/devinet.c:674:47: sparse:    expected void *p
>   net/ipv4/devinet.c:674:47: sparse:    got struct in_ifaddr [noderef] __rcu *
> 
> Also, if we evaluate net as (void *) in a macro, then the compiler
> in turn fails to build due to -Werror=unused-value.
> 
>   #define rtnl_net_dereference(net, p)                  \
>         ({                                              \
>                 (void *)net;                            \
>                 rtnl_dereference(p);                    \
>         })
> 
>   net/ipv4/devinet.c: In function ‘inet_rtm_deladdr’:
>   ./include/linux/rtnetlink.h:154:17: error: statement with no effect [-Werror=unused-value]
>     154 |                 (void *)net;                            \
>   net/ipv4/devinet.c:674:21: note: in expansion of macro ‘rtnl_net_dereference’
>     674 |              (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
>         |                     ^~~~~~~~~~~~~~~~~~~~
> 
> Let's go back to the original simplest macro.
> 
> Note that checkpatch complains about this approach, but it's one-shot and
> less noisy than the other two.
> 
>   WARNING: Argument 'net' is not used in function-like macro
>   #76: FILE: include/linux/rtnetlink.h:142:
>   +#define rtnl_net_dereference(net, p)			\
>   +	rtnl_dereference(p)
> 
> Fixes: 844e5e7e656d ("rtnetlink: Add assertion helpers for per-netns RTNL.")
> Link: https://lore.kernel.org/netdev/20241004132145.7fd208e9@kernel.org/ [0]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410200325.SaEJmyZS-lkp@intel.com/ [1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks,

I was able to reproduce the build problem as described.

Reviewed-by: Simon Horman <horms@kernel.org>

