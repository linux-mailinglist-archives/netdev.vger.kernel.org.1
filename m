Return-Path: <netdev+bounces-73298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB4885BCC8
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E3728112A
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8AA69E06;
	Tue, 20 Feb 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho0S/pca"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8669DFF
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434132; cv=none; b=uaJPJqlkM1VIuJ4+HSZBk3TUfYryfZt6GtvCkGGRoEsGkRjOjCL6zq36CwUoOqty0ceKwuZ6x0xn2POH+axzZRWCc1uBQaOGjVeT6ZpX8Mn/mLAjoJJAkHCFGuOXb55mtVaQqxpIiDzpVzkKWAdJT/VfQhS18U6GCw2V46ERbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434132; c=relaxed/simple;
	bh=K4sWBSLWkN98NZHfv/IhFKshYSSGFh5pV20k4Ab3Big=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtGEGjNtr8kH0up4UfMgYis+T5DRp2U7O5JaLebHlgwYLNsSEp8oMGj0Z1JZ/IWiJ++ILUg2n5P2lxxzo56sOeP/lrMzVOc4VwMG8tW/bDymXwJqE0ZMAoR+h5vHSQbZvqE3Z/+L1Kt6ClW6mQro1Jc5NBne4hEiEfpazh2dnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho0S/pca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D90C433C7;
	Tue, 20 Feb 2024 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708434131;
	bh=K4sWBSLWkN98NZHfv/IhFKshYSSGFh5pV20k4Ab3Big=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ho0S/pca4wR8j4DAgV7+LGI+Cg1eQqHVTfP5ty2IbDllS1ZpjQkvHmNwnr+diFOn4
	 1IF+QXIadRdVmz+FU4mF9YsGHl/zSZ+gUKJCP+2Sc4CDI5PLpBmJ4COgjJRbu4B9SK
	 Wz9mpAminFyIYMOjsIpsUPASmVTL9wcZk3aib/WoVMunxI2q8i1hEMMI/gcFMvATmb
	 AKwI++kQlFN3O744vC8QRJHyHk8DQm43enuZmv7VAIU3vnpr6eHq53znl0FuMx6LLz
	 TYCXq7ZrZSHVgg5mZa8nk7P0/RwSrr6PVjKzYGmhHm4vRoZPMh0IjUgjN49eDdgPPb
	 KEHHS8gTaGHHw==
Date: Tue, 20 Feb 2024 13:02:06 +0000
From: Simon Horman <horms@kernel.org>
To: kovalev@altlinux.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	jacob.e.keller@intel.com, johannes@sipsolutions.net,
	idosch@nvidia.com, David Lebrun <david.lebrun@uclouvain.be>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH] genetlink: fix potencial use-after-free and
 null-ptr-deref in genl_dumpit()
Message-ID: <20240220130206.GH40273@kernel.org>
References: <20240215202309.29723-1-kovalev@altlinux.org>
 <20240219113240.GZ40273@kernel.org>
 <4462f60e-63eb-c566-818a-98523ca4d4ff@basealt.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4462f60e-63eb-c566-818a-98523ca4d4ff@basealt.ru>

On Mon, Feb 19, 2024 at 03:15:52PM +0300, kovalev@altlinux.org wrote:
> + Pablo Neira Ayuso <pablo@netfilter.org>
> 
> 19.02.2024 14:32, Simon Horman wrote:
> > + Jiri Pirko <jiri@resnulli.us>
> >    David Lebrun <david.lebrun@uclouvain.be>
> > 
> > On Thu, Feb 15, 2024 at 11:23:09PM +0300, kovalev@altlinux.org wrote:
> > > From: Vasiliy Kovalev <kovalev@altlinux.org>
> > > 
> > > The pernet operations structure for the subsystem must be registered
> > > before registering the generic netlink family.
> > > 
> > > Fixes: 134e63756d5f ("genetlink: make netns aware")
> > Hi Vasiliy,
> > 
> > A Fixes tag implies that this is a bug fix.
> > So I think some explanation is warranted of what, user-visible,
> > problem this resolves.
> > 
> > In that case the patch should be targeted at net.
> > Which means it should be based on that tree and have a net annotation
> > in the subject
> > 
> > 	Subject: [PATCH net] ...
> > 
> > Alternatively, the Fixes tag should be dropped and some explanation
> > should be provided of why the structure needs to be registered before
> > the family.
> > 
> > In this case, if you wish to refer to the patch where the problem (but not
> > bug) was introduced you can use something like the following.
> > It is just the Fixes tag that has a special meaning.
> > 
> > 	Introduced in 134e63756d5f ("genetlink: make netns aware")
> > 
> > I think the above comments also apply to:
> > 
> > - [PATCH] ipv6: sr: fix possible use-after-free and null-ptr-deref
> >    https://lore.kernel.org/all/20240215202717.29815-1-kovalev@altlinux.org/
> > 
> > - [PATCH] devlink: fix possible use-after-free and memory leaks in devlink_init()
> >    https://lore.kernel.org/all/20240215203400.29976-1-kovalev@altlinux.org/
> > 
> > And as these patches seem to try to fix the same problem in different
> > places, all under Networking, I would suggest that if you do repost,
> > they are combined into a patch series (3 patches in the same series).
> > 
> > But I do wonder, how such an apparently fundamental problem has been
> > present for so long in what I assume to be well exercised code.
> 
> Hi Simon,
> 
> The history of these changes began with the crash fix in the gtp module [1]
> 
> A solution to the problem was found [2] and Pablo Neruda Ayuso suggested
> fixing similar
> 
> sections of code if they might have the same problem.
> 
> I have sent patches, but do not have reproducers, relying on drawing
> attention to the problem.

Thanks Vasiliy,

I think it would be worth adding some text along those lines to
the commit messages for the patches you have posted.

> 
> 
> [1]
> https://lore.kernel.org/lkml/20240124101404.161655-1-kovalev@altlinux.org/T/
> 
> [2] https://lore.kernel.org/netdev/20240214162733.34214-1-kovalev@altlinux.org/T/#u
> 
> -- 
> Thanks,
> Vasiliy Kovalev
> 

