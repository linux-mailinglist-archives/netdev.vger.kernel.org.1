Return-Path: <netdev+bounces-18031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7C7543C9
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 22:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02D02822B0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE995396;
	Fri, 14 Jul 2023 20:33:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60D2C80
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D54EC433C7;
	Fri, 14 Jul 2023 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689366783;
	bh=9pGg3qyIGxatEvYm6yxtfAAd27EdipAQ1cH7dSmgeMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ygq30yvC0f0SxWXbgbjuMKZb/8kotawzXKFrt9a0lI6H1XCoqehq0QMDqaFBcxWQG
	 tmACzFSZS/EkCh1P88uYyPKIXcX1qoikj6h0/7mh/W41fBfWNyEAm/IKbPnLB0KzD3
	 LHBPzSc1lwfC5GOaS7gWgb/QcxZqwl9dWUnuTxX/SQyBrmTeYtiXV0tNMgPjhKlZ3x
	 ipDmH8S06SW+32sUDDwGNyAJYT1dk6EOTUh9PHj6ThpPsdDe2UBAN7OFIEjmFQUMW9
	 yC46Tjom+ylYn32U5ckpWTSpTOWN5SUD5KykoT1nbJu7sVokF7eaVeqednFyfG1orC
	 hSVJbC0KEl7Aw==
Date: Fri, 14 Jul 2023 23:32:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230714203258.GL41919@unreal>
References: <5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
 <20230712173259.4756fe08@kernel.org>
 <20230713063345.GG41919@unreal>
 <20230713100401.5fe0fa77@kernel.org>
 <20230713174317.GH41919@unreal>
 <20230713110556.682d21ba@kernel.org>
 <20230713185833.GI41919@unreal>
 <20230713201727.6dfe7549@kernel.org>
 <20230714184013.GJ41919@unreal>
 <20230714121633.18d19c4c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714121633.18d19c4c@kernel.org>

On Fri, Jul 14, 2023 at 12:16:33PM -0700, Jakub Kicinski wrote:
> On Fri, 14 Jul 2023 21:40:13 +0300 Leon Romanovsky wrote:
> > > > In theory, we support any order, but in real life I don't think that TC
> > > > before IPsec is really valuable.  
> > > 
> > > I asked the question poorly. To clearer, you're saying that:
> > > 
> > > a)  host <-> TC <-> IPsec <-> "wire"/switch
> > >   or
> > > b)  host <-> IPsec <-> TC <-> "wire"/switch
> > > 
> > > ?  
> > 
> > It depends on configuration order, if user configures TC first, it will
> > be a), if he/she configures IPsec first, it will be b).
> > 
> > I just think that option b) is really matters.
> 
> And only b) matches what happens in the kernel with policy based IPsec,
> right? 

Can you please clarify what do you mean "policy based IPsec"?

> So can we reject a) from happening? 

Technically yes.

> IIUC what you're saying -
> the result depending on order of configuration may be a major source
> of surprises / hard to debug problems for the user.

When I reviewed patches, I came exactly to an opposite conclusion :)

My rationale was that users who configure IPsec and TC are advanced
users who knows their data flow and if they find a) option valuable,
they can do it.

For example, a) allows to limit amount of data sent to IPsec engine.

I believe both a) and b) should be supported.

Thanks

