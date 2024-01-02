Return-Path: <netdev+bounces-60997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9F78221D3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 20:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07398B2215F
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8466B15ADC;
	Tue,  2 Jan 2024 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnogE//S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20115ACB
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 19:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CC3C433C8;
	Tue,  2 Jan 2024 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704222788;
	bh=NCkb8tqkA8HY7gh6lvwbzF5A/ByZUw4XdXim4tR6Y7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnogE//SeQW/U4BrnHUYNqZnlLzSG9HiH+UJCu+sbwqLusp5TVi6kg1o8Zg0a5uH8
	 JP+xGWrwbOf2swbpe+F5ndqpjvbFW2SkEMBq/DXU6Wxt0sRNNpf/jdyXq6v7rXdvu0
	 VDlw/TYfNV2+n9fD54ys2VtV5FRiLiPoIMSqCH5NgKIWv65raq4H0L8ATL7KRTK35y
	 kcBK3nJiQVSA7/7ztjiVBiItFDwcZmpFtbI1TIwBWWVLvy9gaM3ITout7jrtRpOf3P
	 HpC9NuautlbCUeLuvbvQuJCQYcQ3dVDJ6CfnwwsksR1JW/Yc3WarSDy9yvFm+vZPxI
	 VNsXlzTtXracg==
Date: Tue, 2 Jan 2024 21:13:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Gal Pressman <gal@nvidia.com>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shachar Kagan <skagan@nvidia.com>, netdev@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
Message-ID: <20240102191304.GB5160@unreal>
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
 <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
 <20240102095835.GF6361@unreal>
 <CANn89iLd6EeC3b8DTXBP=cDw8ri+k_uGiCrAS6BOoG3FMuAxmg@mail.gmail.com>
 <20240102114147.GG6361@unreal>
 <CANn89iJzBzcU=-ybbvOjNeNBqx2ap=uoS1dbYJEY59oWsSTUtg@mail.gmail.com>
 <20240102180102.GA5160@unreal>
 <CANn89iKcStXqo9rxpO_Dq3HQ0Sj8Ce_5YmjaKx7n9EF+9GjTmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKcStXqo9rxpO_Dq3HQ0Sj8Ce_5YmjaKx7n9EF+9GjTmA@mail.gmail.com>

On Tue, Jan 02, 2024 at 07:33:23PM +0100, Eric Dumazet wrote:
> On Tue, Jan 2, 2024 at 7:01 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Jan 02, 2024 at 04:31:15PM +0100, Eric Dumazet wrote:
> > > On Tue, Jan 2, 2024 at 12:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Tue, Jan 02, 2024 at 11:03:55AM +0100, Eric Dumazet wrote:
> > > > > On Tue, Jan 2, 2024 at 10:58 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Jan 02, 2024 at 10:46:13AM +0100, Eric Dumazet wrote:
> > > > > > > On Tue, Jan 2, 2024 at 10:01 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > > >
> > > > > > > > From: Shachar Kagan <skagan@nvidia.com>
> > > > > > > >
> > > > > > > > This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
> > > > > > > >
> > > > > > > > Shachar reported that Vagrant (https://www.vagrantup.com/), which is
> > > > > > > > very popular tool to manage fleet of VMs stopped to work after commit
> > > > > > > > citied in Fixes line.
> > > > > > > >
> > > > > > > > The issue appears while using Vagrant to manage nested VMs.
> > > > > > > > The steps are:
> > > > > > > > * create vagrant file
> > > > > > > > * vagrant up
> > > > > > > > * vagrant halt (VM is created but shut down)
> > > > > > > > * vagrant up - fail
> > > > > > > >
> > > > > > >
> > > > > > > I would rather have an explanation, instead of reverting a valid patch.
> > > > > > >
> > > > > > > I have been on vacation for some time. I may have missed a detailed
> > > > > > > explanation, please repost if needed.
> > > > > >
> > > > > > Our detailed explanation that revert worked. You provided the patch that
> > > > > > broke, so please let's not require from users to debug it.
> > > > > >
> > > > > > If you need a help to reproduce and/or test some hypothesis, Shachar
> > > > > > will be happy to help you, just ask.
> > > > >
> > > > > I have asked already, and received files that showed no ICMP relevant
> > > > > interactions.
> > > > >
> > > > > Can someone from your team help Shachar to get  a packet capture of
> > > > > both TCP _and_ ICMP packets ?
> > > >
> > > > I or Gal will help her, but for now let's revert it, before we will see
> > > > this breakage in merge window and later in all other branches which will
> > > > be based on -rc1.
> > >
> > > Patch is in net-next, we have at least four weeks to find the root cause.
> >
> > I saw more than once claims that netdev is fast to take patches but also
> > fast in reverts. There is no need to keep patch with known regression,
> > while we are in -rc8.
> 
> This patch is not in rc8, unless I am mistaken ?

Patch is not, but the timeline is. Right now, we are in -rc8 and in next
week, the merge window will start.

> 
> >
> > >
> > > I am a TCP maintainer, I will ask you to respect my choice, we have
> > > tests and reverting the patch is breaking one of them.
> >
> > At least for ipv6, you changed code from 2016 and the patch which I'm asking
> > to revert is not even marked as a fix. So I don't understand the urgency to keep
> > the patch.
> 
> Do you have an issue with IPv4 code or IPv6 ?

I think that IPv4, I looked on IPv6 dates just because it was easy to
do. It looks like IPv4 code which you are changing existed in its
current form even before git era.

> 
> It would help to have details.

We prepared raw PCAP files and I'm uploading them. It takes time.

> >
> > There are two things to consider:
> > 1. Linux rule number one is "do not break userspace".
> 
> No released kernel contains the issue yet. Nothing broke yet.

After merge window, it will and I want to avoid it.

> 
> net-next is for developers.

It is encouraged to test net-next, so we did it and reported.

> 
> > 2. Linux is a community project and people can have different opinions,
> > which can be different from your/mine.
> >
> > Thanks
> 
> I think we have time, and getting this patch with potential users on
> it will help to debug the issue.

Like I said, Shachar can test any debug patches, just ask her.

Thanks

