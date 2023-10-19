Return-Path: <netdev+bounces-42573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85B7CF601
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BA3281EC6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD611863C;
	Thu, 19 Oct 2023 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDPXtsxS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE001805D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1219DC433C8;
	Thu, 19 Oct 2023 11:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697713290;
	bh=ctzI0zVQ+/BXXhmiWUb7e9S8RnaVKm1Dt2VwODUgsyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDPXtsxShqd7hfbJhahnuDoppSq6DwvQ+CBGkeU2gT1049qUz1d7GcIO2J/ACxvnB
	 beFYVm6wQibknuQpDbxXU5Mhj6GeCM19bPxgz3sMoV+OtUmoL/tzLkA0IJVj6UjKYR
	 PaB4E1t6wk1cv0/Y6nrnJPLrL0Tq+Gj/06yVRKCH1CKRPEvjHgLfaRnHeYkaoYLv9g
	 TvAj/rUlHSBmPqt8AxAWuLT0YdCZY1LRw63YiXROiu2UcqwxwXx/s+gjPNwwh8XW2D
	 JVvupwn77IwDe+GMeBELP59vij6kuoLIs2C3TJ+386sBpoLppa25mCPqJi8xzbpNwN
	 2kK8bmvr0Z8AA==
Date: Thu, 19 Oct 2023 14:01:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	Raed Salem <raeds@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH xfrm-next 5/9] net/mlx5e: Unify esw and normal IPsec
 status table creation/destruction
Message-ID: <20231019110126.GL5392@unreal>
References: <cover.1697444728.git.leon@kernel.org>
 <d0bc0651c0d5f9afe79942577cf71e7d30859608.1697444728.git.leon@kernel.org>
 <ZS5WK8V0+JoTlNmu@gauss3.secunet.de>
 <20231017121357.GC5392@unreal>
 <ZTDszYAuNv16bGBO@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTDszYAuNv16bGBO@gauss3.secunet.de>

On Thu, Oct 19, 2023 at 10:46:05AM +0200, Steffen Klassert wrote:
> On Tue, Oct 17, 2023 at 03:13:57PM +0300, Leon Romanovsky wrote:
> > On Tue, Oct 17, 2023 at 11:38:51AM +0200, Steffen Klassert wrote:
> > > On Mon, Oct 16, 2023 at 12:15:13PM +0300, Leon Romanovsky wrote:
> > > > From: Patrisious Haddad <phaddad@nvidia.com>
> > > > 
> > > > Change normal IPsec flow to use the same creation/destruction functions
> > > > for status flow table as that of ESW, which first of all refines the
> > > > code to have less code duplication.
> > > > 
> > > > And more importantly, the ESW status table handles IPsec syndrome
> > > > checks at steering by HW, which is more efficient than the previous
> > > > behaviour we had where it was copied to WQE meta data and checked
> > > > by the driver.
> > > > 
> > > > Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > This one does not apply to the ipsec-next tree.
> > 
> > You are right, sorry about that. It is based on two net-next series
> > and I didn't expect such a fast response. 
> > 
> > 1. https://lore.kernel.org/netdev/20231002083832.19746-1-leon@kernel.org/ - accepted.
> > 2. https://lore.kernel.org/netdev/20231014171908.290428-16-saeed@kernel.org/#t - not accepted yet.
> > 
> > Do you feel comfortable with the series/xfrm patches? If yes, Saeed can
> > resend the series directly to net-next once patch #2 is accepted.
> 
> The xfrm changes look good and it does not conflict
> to anything that is in ipsec-next currently. So
> send it to net-next and I'll Ack it.

Thanks a lot.

> 
> Thanks!

