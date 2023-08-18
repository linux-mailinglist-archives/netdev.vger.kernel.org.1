Return-Path: <netdev+bounces-28973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF977814AB
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 23:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070EE1C209FF
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 21:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736C1BB26;
	Fri, 18 Aug 2023 21:20:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EB46B0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D84C433C7;
	Fri, 18 Aug 2023 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692393608;
	bh=RGoItvf8/5pJAf7mFwfWcz9JiaulcCOpFoXlUzUNleI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SGyFcOez9V9UGDTJtmv+QVpvoTZAOUIEpj7xFhdBzRcDDOh4j8TTxYsvg930MO6Kr
	 t8uLznKS+hSX10d6hD2wmnGmBgVwrCzWP6kCt+ABdWdOFMO0gNtZzF1tjkVgl1b1ZJ
	 UD1Rb/S15v/cAppSUJXGi/3Oa5tsPsMHiybPbHA8kG0CyOpBUpJlxDjUNtdQm8ZBKF
	 cdhDdInSB27LuHsLnO7bmvPM0A9fMEVqBynEnOcWIaIFqFwwkTt5HlKV2UX4CHUD2F
	 jdUqgU18fbYUBBZyqluKrLvufeYEq+EKAaNbEOgrOL7EpJ+V6ZKyAFWW0QRu4QPu94
	 8Lda91xsuQ1OA==
Date: Fri, 18 Aug 2023 14:20:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com, shayd@nvidia.com,
 leon@kernel.org
Subject: Re: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance
Message-ID: <20230818142007.206eeb13@kernel.org>
In-Reply-To: <ZN8eCeDGcQSCi1D6@nanopsycho>
References: <20230815145155.1946926-1-jiri@resnulli.us>
	<20230817193420.108e9c26@kernel.org>
	<ZN8eCeDGcQSCi1D6@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 09:30:17 +0200 Jiri Pirko wrote:
> >The devlink instance of the SF stays in the same network namespace 
> >as the PF?  
> 
> SF devlink instance is created in init_ns and can move to another one.
> So no.
> 
> I was thinking about this, as with the devlink handles we are kind of in
> between sysfs and network. We have concept of network namespace in
> devlink, but mainly because of the related netdevices.
> 
> There is no possibility of collision of devlink handles in between
> separate namespaces, the handle is ns-unaware. Therefore the linkage to
> instance in different ns is okay, I believe. Even more, It is handy as
> the user knows that there exists such linkage.
> 
> What do you think?

The way I was thinking about it is that the placement of the dl
instance should correspond to the entity which will be configuring it.

Assume a typical container setup where app has net admin in its
netns and there is an orchestration daemon with root in init_net 
which sets the containers up.

Will we ever want the app inside the netns to configure the interface
via the dl instance? Given that the SF is like giving the container
full access to the HW it seems to me that we should also delegate 
the devlink control to the app, i.e. move it to the netns?

Same thing for devlink instances of VFs.

The orchestration daemon has access to the "PF" / main dl instance of
the device, and to the ports / port fns so it has other ways to control
the HW. While the app would otherwise have no devlink access.

So my intuition is that the devlink instance should follow the SF
netdev into a namespace.

And then the next question is - once the devlink instances are in
different namespaces - do we still show the "nested_devlink" attribute?
Probably yes but we need to add netns id / link as well?

