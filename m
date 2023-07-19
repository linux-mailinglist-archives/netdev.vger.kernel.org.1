Return-Path: <netdev+bounces-18930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AB77591A2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9F71C202D5
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29151111BF;
	Wed, 19 Jul 2023 09:29:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B8111BB
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7C9C433C7;
	Wed, 19 Jul 2023 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689758964;
	bh=jY8foJhzwaIYoiqIIU/wNHSPQWKg7KfSGXB7Q2CX3lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjZ+quM+Dj+kQmuY1wbVgU4Xty/zLJAuWW5Otid4ubFoyeajYZ0PVPVFueptE4RI7
	 otzcrJou1RGRq40ycdvXoIKFRNrYhe0RqLVeFtBSGmGQdLIak1wT8/wN5jeysf1bPq
	 iSRWJE5VuM8t3uUSBrLSAwjAiDKCCO/GXopi8T/abiENV5R9hWCiUTUch10roOsxtx
	 KOWPnHKDP7UTNHNsv+jnzQ+t+ahliStrqdhi8K3vJ0HQJW8ioMzZTgUMEJbsk0xG77
	 2Ub6C15fNgSra9Dzh5xRCmB3O/nElBVGvR6OTYhpZ+wKG5rf1nDbhbgg8pdHrpnbP9
	 w35e3WV+TWQBQ==
Date: Wed, 19 Jul 2023 12:29:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230719092920.GI8808@unreal>
References: <20230713100401.5fe0fa77@kernel.org>
 <20230713174317.GH41919@unreal>
 <20230713110556.682d21ba@kernel.org>
 <20230713185833.GI41919@unreal>
 <20230713201727.6dfe7549@kernel.org>
 <20230714184013.GJ41919@unreal>
 <20230714121633.18d19c4c@kernel.org>
 <20230714203258.GL41919@unreal>
 <20230714203032.7f1bf5f7@kernel.org>
 <20230716103947.GA27947@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716103947.GA27947@unreal>

On Sun, Jul 16, 2023 at 01:39:47PM +0300, Leon Romanovsky wrote:
> On Fri, Jul 14, 2023 at 08:30:32PM -0700, Jakub Kicinski wrote:
> > On Fri, 14 Jul 2023 23:32:58 +0300 Leon Romanovsky wrote:
> > > On Fri, Jul 14, 2023 at 12:16:33PM -0700, Jakub Kicinski wrote:
> > > > On Fri, 14 Jul 2023 21:40:13 +0300 Leon Romanovsky wrote:  
> > > > > It depends on configuration order, if user configures TC first, it will
> > > > > be a), if he/she configures IPsec first, it will be b).
> > > > > 
> > > > > I just think that option b) is really matters.  
> > > > 
> > > > And only b) matches what happens in the kernel with policy based IPsec,
> > > > right?   
> > > 
> > > Can you please clarify what do you mean "policy based IPsec"?
> > 
> > I mean without a separate xfrm netdev on which you can install TC
> > rules of its own.
> 
> I call it software IPsec.
> 
> > 
> > > > IIUC what you're saying -
> > > > the result depending on order of configuration may be a major source
> > > > of surprises / hard to debug problems for the user.  
> > > 
> > > When I reviewed patches, I came exactly to an opposite conclusion :)
> > > 
> > > My rationale was that users who configure IPsec and TC are advanced
> > > users who knows their data flow and if they find a) option valuable,
> > > they can do it.
> > > 
> > > For example, a) allows to limit amount of data sent to IPsec engine.
> > > 
> > > I believe both a) and b) should be supported.
> > 
> > What does it take to switch between the modes?
> > Even if we want both modes we should have an explicit switch, I reckon.
> > Or at least a way to read back what mode we ended up in.
> 
> I had several internal discussions about how TC and IPsec should work
> together, and will need some time to think about proper implementation.
> 
> For now I'll add patch which makes TC and IPsec mutually exclusive.

Even this so called trivial patch is not so trivial in mlx5 current
implementation. Jianbo is working on it.

Thanks

> 
> Thanks
> 
> > 
> 

