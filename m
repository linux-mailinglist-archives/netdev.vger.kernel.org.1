Return-Path: <netdev+bounces-176467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3652A6A77E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316501B61AF8
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822D1DF755;
	Thu, 20 Mar 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVZcbaJJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907221C5D7E;
	Thu, 20 Mar 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477860; cv=none; b=DJP+uUOgKH0MtbRKTQzYxiRc5cGbkmxDUgJo33OrSanwXtjSv+o8mWpydO1ihG0vWYxIFcU0W4iSrlx7CQxprMPY2dSywQ/UYz52eP4D2FBkjI7WIvVwEN4m1LLddV/aIU08xvYzUQkykeFbKS3DEdyvA4nBV1U1ewMbKpZx71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477860; c=relaxed/simple;
	bh=2NJeORjTdJezn59fu5jLWUbOG+URhYEChILm92stz60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayNY/KI2LtQmrvPDQp8XNJr+oS21AQIGn7QtB4wLvUMP3PvSb30Ye88C2KF894ustneUcOF6tX/0I1JLHLkvviXAKvpcq0bHfS7N1qOjv5RvqJ8DHhbg7XUoEPUfFxGj2tGuvpoxwE1MTIZP3hMOGMcspFpQDlxGK3sbNWP39U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVZcbaJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035B2C4CEDD;
	Thu, 20 Mar 2025 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742477860;
	bh=2NJeORjTdJezn59fu5jLWUbOG+URhYEChILm92stz60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVZcbaJJSwKrl3EqnqniDdTeyeLGP5j1eSrB3nr+MYEguW23KL+II+kHuUWD558OA
	 Tj4JwHgqPCY4p97gxDkGaUSTfjvayL0kdqxkIS+EzVIvN86eb0SCA9KZTBA5MXEDt+
	 G0wq5FrTzTw0QmTfvoGmx8LVp+JzQ/tGF+yxDm/yE6b6MV0p4T0+cueJ+pl0ywZcRt
	 xPz1X9ATXH0ivjajqQDT8s8s5MZjDmZNOioaPj4V0Mlny9FxtWKdiVcTgDlUWqbCtY
	 z99aVGKOSiVLHq47ASooa2Rp1rjzXj3uzwz+aZovCxpUcCk1gq0pWb5IGwftvszov8
	 OoJubyk/VxOGw==
Date: Thu, 20 Mar 2025 13:37:36 +0000
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: David Ahern <dsahern@kernel.org>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	fw@strlen.de, daniel@iogearbox.net, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fix NULL pointer dereference in l3mdev_l3_rcv
Message-ID: <20250320133736.GR280585@kernel.org>
References: <20250313012713.748006-1-wangliang74@huawei.com>
 <20250318143800.GA688833@kernel.org>
 <e8da7ce4-c76c-488e-80cb-dff95bf00fe0@kernel.org>
 <94a34aa3-a823-4550-b16a-179e6f6d6292@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94a34aa3-a823-4550-b16a-179e6f6d6292@huawei.com>

On Wed, Mar 19, 2025 at 10:07:03AM +0800, Wang Liang wrote:
> 
> 在 2025/3/18 23:02, David Ahern 写道:
> > On 3/18/25 3:38 PM, Simon Horman wrote:
> > > On Thu, Mar 13, 2025 at 09:27:13AM +0800, Wang Liang wrote:
> > > > When delete l3s ipvlan:
> > > > 
> > > >      ip link del link eth0 ipvlan1 type ipvlan mode l3s
> > > > 
> > > > This may cause a null pointer dereference:
> > > > 
> > > >      Call trace:
> > > >       ip_rcv_finish+0x48/0xd0
> > > >       ip_rcv+0x5c/0x100
> > > >       __netif_receive_skb_one_core+0x64/0xb0
> > > >       __netif_receive_skb+0x20/0x80
> > > >       process_backlog+0xb4/0x204
> > > >       napi_poll+0xe8/0x294
> > > >       net_rx_action+0xd8/0x22c
> > > >       __do_softirq+0x12c/0x354
> > > > 
> > > > This is because l3mdev_l3_rcv() visit dev->l3mdev_ops after
> > > > ipvlan_l3s_unregister() assign the dev->l3mdev_ops to NULL. The process
> > > > like this:
> > > > 
> > > >      (CPU1)                     | (CPU2)
> > > >      l3mdev_l3_rcv()            |
> > > >        check dev->priv_flags:   |
> > > >          master = skb->dev;     |
> > > >                                 |
> > > >                                 | ipvlan_l3s_unregister()
> > > >                                 |   set dev->priv_flags
> > > >                                 |   dev->l3mdev_ops = NULL;
> > > >                                 |
> > > >        visit master->l3mdev_ops |
> > > > 
> > > > Add lock for dev->priv_flags and dev->l3mdev_ops is too expensive. Resolve
> > > > this issue by add check for master->l3mdev_ops.
> > > Hi Wang Liang,
> > > 
> > > It seems to me that checking master->l3mdev_ops like this is racy.
> > vrf device leaves the l3mdev ops set; that is probably the better way to go.
> 
> Thanks.
> 
> Only l3s ipvlan set the dev->l3mdev_ops to NULL at present, I will delete
> 'dev->l3mdev_ops = NULL' in ipvlan_l3s_unregister(), is that ok?

TBH, I am somewhat unclear on the correct tear down behaviour.
But I also understood that to be David's suggestion.
And I think that implementing that, and posting it as v2 would
be a good next step.

