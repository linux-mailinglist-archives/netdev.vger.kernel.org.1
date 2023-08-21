Return-Path: <netdev+bounces-29426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C17831BD
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE641C209C0
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4967311724;
	Mon, 21 Aug 2023 20:19:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8B11720
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F37C433C8;
	Mon, 21 Aug 2023 20:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692649179;
	bh=B5GbIiLQcqlrw/H6yd0mLu55xRLNYQyjtziEVtRYnjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CnvIciW2XRsi+dDA7EMR4rKsriZ0/6JJLngtSwX4Cg/RLWcrQClRcdbQyNKvOuv9x
	 XQrs9kBPFnImMVncNo0LM/k8KzuhjfcSNUlXzXwWbwTNt14Gj4tmMjB1O4/3u48fn2
	 KcIJ9QiUiItGDpgA/6NC+yJS2CySJz9Y6XtZwpsTkpLsgDGn+Fl54DteabOmiPZFHG
	 m1WixYlvBppbMSr6ILZb9jVHeWtJMOG5bASWMZ5Uc+yOceh8wD3kxgc3U/zFmnraWa
	 QL9QWVHCKtMd1V2y+0D2QptY/B++DVo5ZGQNLXXkuutLcFm1vW7tLMf1ILWMF7od9r
	 1qi0zaGop/BxQ==
Date: Mon, 21 Aug 2023 13:19:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com, shayd@nvidia.com,
 leon@kernel.org
Subject: Re: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance
Message-ID: <20230821131937.7ed01b55@kernel.org>
In-Reply-To: <ZONBUuF1krmcSjoM@nanopsycho>
References: <20230815145155.1946926-1-jiri@resnulli.us>
	<20230817193420.108e9c26@kernel.org>
	<ZN8eCeDGcQSCi1D6@nanopsycho>
	<20230818142007.206eeb13@kernel.org>
	<ZONBUuF1krmcSjoM@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 12:49:54 +0200 Jiri Pirko wrote:
> Fri, Aug 18, 2023 at 11:20:07PM CEST, kuba@kernel.org wrote:
> >On Fri, 18 Aug 2023 09:30:17 +0200 Jiri Pirko wrote:  
> >> SF devlink instance is created in init_ns and can move to another one.
> >> So no.
> >> 
> >> I was thinking about this, as with the devlink handles we are kind of in
> >> between sysfs and network. We have concept of network namespace in
> >> devlink, but mainly because of the related netdevices.
> >> 
> >> There is no possibility of collision of devlink handles in between
> >> separate namespaces, the handle is ns-unaware. Therefore the linkage to
> >> instance in different ns is okay, I believe. Even more, It is handy as
> >> the user knows that there exists such linkage.
> >> 
> >> What do you think?  
> 
> First of all, I'm having difficulties to understand exactly what you
> say. I'll try my best with the reply :)
> 
> >The way I was thinking about it is that the placement of the dl
> >instance should correspond to the entity which will be configuring it.
> >
> >Assume a typical container setup where app has net admin in its
> >netns and there is an orchestration daemon with root in init_net 
> >which sets the containers up.
> >
> >Will we ever want the app inside the netns to configure the interface
> >via the dl instance? Given that the SF is like giving the container
> >full access to the HW it seems to me that we should also delegate   
> 
> Nope. SF has limitations that could be set by devlink port function
> caps. So no full HW access.
> 
> 
> >the devlink control to the app, i.e. move it to the netns?
> >
> >Same thing for devlink instances of VFs.  
> 
> Like VFs, SFs are getting probed by mlx5 driver. Both create the devlink
> instances in init_ns. For both the user can reload them to a different
> netns. It's consistent approach.
> 
> I see a possibility to provide user another ATTR to pass during SF
> activation that would indicate the netns new instance is going to be
> created in (of course only if it is local). That would provide
> the flexibility to solve the case you are looking for I believe.
> ***
>
> >The orchestration daemon has access to the "PF" / main dl instance of
> >the device, and to the ports / port fns so it has other ways to control
> >the HW. While the app would otherwise have no devlink access.
> >
> >So my intuition is that the devlink instance should follow the SF
> >netdev into a namespace.  
> 
> It works the other way around. The only way to change devlink netns is
> to reload the instance to a different netns. The related
> netdevice/netdevices are reinstantiated to that netns. If later on the
> user decides to move a netdev to a different netns, he can do it.
> 
> This behavious is consistent for all devlink instances, devlink port and
> related netdevice/netdevices, no matter if there is only one netdevice
> of more. What you suggest, I can't see how that could work when instance
> have multiple netdevices.

Netdevs can move to netns without their devlink following (leaving
representors aside). We can't change that because uAPI.
But can we make it impossible to move SFs by themselves and require
devlink reload to move them?

> >And then the next question is - once the devlink instances are in
> >different namespaces - do we still show the "nested_devlink" attribute?
> >Probably yes but we need to add netns id / link as well?  
> 
> Not sure what is the usecase. Currently, once VFs/SFs/ could be probed
> and devlink instance created in init_ns, the orchestrator does not need
> this info.
> 
> In future, if the extension I suggested above (***) would be
> implemented, the orchestrator still knows the netns he asked the
> instance to be created in.
> 
> So I would say is it not needed for anything. Plus it would make code
> more complex making sure the notifications are coming in case of SF
> devlink instance netns changes.
> 
> So do you see the usecase? If not, I would like to go with what I have
> in this patchset version.

I'm thinking about containers. Since the SF configuration is currently
completely vendor ad-hoc I'm trying to establish who's supposed to be
in control of the devlink instance of an SF - orchestrator or the
workload. We should pick one and force everyone to fall in line.

