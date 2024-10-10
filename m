Return-Path: <netdev+bounces-134314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4912C998B3E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114382954EC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059A41CBEB4;
	Thu, 10 Oct 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opgY8dvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4D1CB312;
	Thu, 10 Oct 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573568; cv=none; b=Qb0X+cZMGXTcTU4zLzkW7EhAUrcZuQkmwxAPAMgKnR5V7w+mjYGOO9Y3QJw8c9CcLUMBLlgSMrqcuvyCWMfO6SpAoxvqKGrSjaDZMuzkK/p1i9q0ZS+JpwVk3FPIOCfg2AEYOtvcjNrKXjc0OqGj9x7geziUKDVNCvmGdELSbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573568; c=relaxed/simple;
	bh=0jq1OOUiN4khsOZmhP2/oYIr4K7zJJoz+UgPHvbmbSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDUMzl8nzHH+kul8zwk2C/020Ve8q8hdPUv6KAi/M//NMUXaSdM4+RyImGpTrdEyOaAJfUzU8maCApExaB7eR12BSVPebaKYGywjGCiPVZpZ+l8XVwsG6ZO1R649ZAPrpOAtCO++uqWUl1k6j+VZk9qilOQLwpZd1aRTYCJx0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opgY8dvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB28C4CEC5;
	Thu, 10 Oct 2024 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728573565;
	bh=0jq1OOUiN4khsOZmhP2/oYIr4K7zJJoz+UgPHvbmbSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=opgY8dvMb9mNGN6kR516XKuPlBjZjyD9K/myeQPzYM1IUHLf+2oq6nH3GucOOzGNl
	 PGbrH3wr8bEMMZqgjudvaYTw0NQXMPgGS2MLxAtmMab1WYacLzOW0Zt3HLlNpSz/4b
	 nxEbOlXdZ8MKRPGSyRjCW/qG/9Bg2H5Qv7dncQJMpTQIRmFP9MQMXcChjubQuqwfJJ
	 7K6JjNz6mTlfz38tEq4/IdqwGBsDiyBZLilaoUhy7bP6SOxQcBv572F4kxHiBU/tRn
	 Jic+R35GOIWPcPA8uobpK25nufbTTgixtNvKHPnnREDW91PGh66wUJ/Ti9FoVENP9E
	 TJC5jC5CPhEBg==
Date: Thu, 10 Oct 2024 08:19:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
 bjorn@rivosinc.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Mina Almasry
 <almasrymina@google.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 6/9] netdev-genl: Support setting per-NAPI config
 values
Message-ID: <20241010081923.7714b268@kernel.org>
In-Reply-To: <CANn89iJ1=xA9WGhXAMcCAeacE3pYgqiWjcBdxiWjGPACP-5n_g@mail.gmail.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
	<20241009005525.13651-7-jdamato@fastly.com>
	<CANn89iJ1=xA9WGhXAMcCAeacE3pYgqiWjcBdxiWjGPACP-5n_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 06:24:54 +0200 Eric Dumazet wrote:
> > +static const struct netlink_range_validation netdev_a_napi_defer_hard_irqs_range = {
> > +       .max    = 2147483647ULL,  
> 
> Would (u64)INT_MAX  work ?

I sent a codegen change for this. The codegen is a bit of a mess.

> > +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +       struct napi_struct *napi;
> > +       unsigned int napi_id;
> > +       int err;
> > +
> > +       if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
> > +               return -EINVAL;
> > +
> > +       napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
> > +
> > +       rtnl_lock();  
> 
> Hmm.... please see my patch there :
> 
>  https://patchwork.kernel.org/project/netdevbpf/patch/20241009232728.107604-2-edumazet@google.com/
> 
> Lets not add another rtnl_lock() :/

It's not as easy since NAPIs can come and go at driver's whim.
I'm quietly hoping we can convert all netdev-nl NAPI accesses
to use the netdev->lock protection I strong-armed Paolo into 
adding in his shaper series. But perhaps we can do that after
this series? NAPI GET already takes RTNL lock.

