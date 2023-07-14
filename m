Return-Path: <netdev+bounces-18022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A80F754320
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 21:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806E02822A4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 19:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E91ED54;
	Fri, 14 Jul 2023 19:16:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441F713715
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C872C433C7;
	Fri, 14 Jul 2023 19:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689362194;
	bh=2ShBtr49RgYLrnaJuQTXSgJa8xVnq1iWZOXTE7Cak0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IDisoad2Yro7Si4mcpFFK6D+IegBQevrFTN588RKBta5fWULiLEUp0hJTYVTeUJMo
	 WSOVDiQmybOEfENRWP/LignIUmYyfgYlFsxSflaEJ4sI9hK50dPMUt/93+wOXqtiSn
	 p9Mdpqw3pDi7pRS6LDbvu9yzeyTeUcyNtGQpeSGWnUA37XYuv3eMMj4n+VgfNrD5hf
	 NL1BIyN1TyjaV7iNvjv/kZ2/GRAgt1/moBqxVAPpBt4fAy58pNtNuYNawYV1thRAJX
	 4s/bjK0gVYv6BOsmcEogXewz2rkD4h5akm3IYHsqicM/FS8iSOkWdeK+iGJuhlU6GA
	 sMF32fYoagdQw==
Date: Fri, 14 Jul 2023 12:16:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230714121633.18d19c4c@kernel.org>
In-Reply-To: <20230714184013.GJ41919@unreal>
References: <cover.1689064922.git.leonro@nvidia.com>
	<5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
	<20230712173259.4756fe08@kernel.org>
	<20230713063345.GG41919@unreal>
	<20230713100401.5fe0fa77@kernel.org>
	<20230713174317.GH41919@unreal>
	<20230713110556.682d21ba@kernel.org>
	<20230713185833.GI41919@unreal>
	<20230713201727.6dfe7549@kernel.org>
	<20230714184013.GJ41919@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jul 2023 21:40:13 +0300 Leon Romanovsky wrote:
> > > In theory, we support any order, but in real life I don't think that TC
> > > before IPsec is really valuable.  
> > 
> > I asked the question poorly. To clearer, you're saying that:
> > 
> > a)  host <-> TC <-> IPsec <-> "wire"/switch
> >   or
> > b)  host <-> IPsec <-> TC <-> "wire"/switch
> > 
> > ?  
> 
> It depends on configuration order, if user configures TC first, it will
> be a), if he/she configures IPsec first, it will be b).
> 
> I just think that option b) is really matters.

And only b) matches what happens in the kernel with policy based IPsec,
right? So can we reject a) from happening? IIUC what you're saying -
the result depending on order of configuration may be a major source
of surprises / hard to debug problems for the user.

