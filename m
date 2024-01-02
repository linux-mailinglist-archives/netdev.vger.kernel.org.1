Return-Path: <netdev+bounces-60860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F8B821B21
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C9281269
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1C5E57E;
	Tue,  2 Jan 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/QNuxwS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A7DEAC2
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDA0C433C8;
	Tue,  2 Jan 2024 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704195712;
	bh=p6uAENT5wNzxkdETdVxeEtYwLkJ3H980lBpYvczxd/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/QNuxwSB9diTkiQZlyYQZUn1V3Jcn4wl4YHo9Ki5n8elZUF4DXVF5xpcu1XCP8bd
	 PgIT9oO1yohK8w4yGJuH1vM06sze+5aJsGJ/KTrcCRyFbWvn8Z7yHyFdQ6I62ADrcv
	 Sa5hmNnsBeZMl1ObUi2LKmGw4m2FDU8ew0npr9NBjsJ51VDC7J5/oBBr1wvXBEccKG
	 XxefuJy8bm+LpYL4HPcFvmpK4YL4gw16Bxh2226QRl5eqRvEDAG81LmyyUEU+sQj/i
	 vf5h39KS6ZI/8ZpOpNT03y8Z6sTXJVD/KbvvaO0hqdrJXbt9EQOwjLHGoemb0ivJyH
	 YWwE8+xfJzzGg==
Date: Tue, 2 Jan 2024 13:41:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shachar Kagan <skagan@nvidia.com>, netdev@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
Message-ID: <20240102114147.GG6361@unreal>
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
 <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
 <20240102095835.GF6361@unreal>
 <CANn89iLd6EeC3b8DTXBP=cDw8ri+k_uGiCrAS6BOoG3FMuAxmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLd6EeC3b8DTXBP=cDw8ri+k_uGiCrAS6BOoG3FMuAxmg@mail.gmail.com>

On Tue, Jan 02, 2024 at 11:03:55AM +0100, Eric Dumazet wrote:
> On Tue, Jan 2, 2024 at 10:58 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Jan 02, 2024 at 10:46:13AM +0100, Eric Dumazet wrote:
> > > On Tue, Jan 2, 2024 at 10:01 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > From: Shachar Kagan <skagan@nvidia.com>
> > > >
> > > > This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
> > > >
> > > > Shachar reported that Vagrant (https://www.vagrantup.com/), which is
> > > > very popular tool to manage fleet of VMs stopped to work after commit
> > > > citied in Fixes line.
> > > >
> > > > The issue appears while using Vagrant to manage nested VMs.
> > > > The steps are:
> > > > * create vagrant file
> > > > * vagrant up
> > > > * vagrant halt (VM is created but shut down)
> > > > * vagrant up - fail
> > > >
> > >
> > > I would rather have an explanation, instead of reverting a valid patch.
> > >
> > > I have been on vacation for some time. I may have missed a detailed
> > > explanation, please repost if needed.
> >
> > Our detailed explanation that revert worked. You provided the patch that
> > broke, so please let's not require from users to debug it.
> >
> > If you need a help to reproduce and/or test some hypothesis, Shachar
> > will be happy to help you, just ask.
> 
> I have asked already, and received files that showed no ICMP relevant
> interactions.
> 
> Can someone from your team help Shachar to get  a packet capture of
> both TCP _and_ ICMP packets ?

I or Gal will help her, but for now let's revert it, before we will see
this breakage in merge window and later in all other branches which will
be based on -rc1.

> 
> Otherwise there is little I can do. I can not blindly trust someone
> that a valid patch broke something, just because 'something broke'

We use standard Vagrant, you can try to reproduce the issue locally.

Thanks

