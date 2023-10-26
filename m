Return-Path: <netdev+bounces-44404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9247D7DA5
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74267281D96
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C2415ADC;
	Thu, 26 Oct 2023 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayxiNJor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668615AC9
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20C3C433C8;
	Thu, 26 Oct 2023 07:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698305403;
	bh=pAwP1jHpRtTe/CQMNXQpqHZtr7aLv1pmbZ62cYbAQc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayxiNJorqqVDQK8jmKxtM50/BnibcRizFqMdhq/Sj4UDMg0b7CQfdIQ7cHo2SO7Zm
	 cMIJJ3qOSOw6ivjTxNHfV7ksp7+RG44DY2FAToqF3hfkdMUH9JCPrOlC/au2gaLW9o
	 TWhpvME+eCn+3ogQ6hv2kcVzudJHsvjtQ6GSuqmQLxee+6Ovk2llun4+Q2PnIzPsQm
	 IrH3mqR2nKNI2RmBII5AoV6gCeUJWUi/lNzZx93Qj/kjjWy7txHQqnQMTKLwQVafjJ
	 yXeAAYCFYSMFL1QURR8pxC30EBsFtUaAVunvIGKe2niu04TPdkjJ7jqgSq5IQ6bfs8
	 Qjhjy9YRZNx/g==
Date: Thu, 26 Oct 2023 10:29:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <20231026072958.GD2950466@unreal>
References: <20231021064620.87397-1-saeed@kernel.org>
 <20231024180251.2cb78de4@kernel.org>
 <20231025085202.GC2950466@unreal>
 <20231025182502.54f79369@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025182502.54f79369@kernel.org>

On Wed, Oct 25, 2023 at 06:25:02PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 11:52:02 +0300 Leon Romanovsky wrote:
> > This patch won't fix much without following patch in that series.
> > https://lore.kernel.org/all/20231021064620.87397-8-saeed@kernel.org/
> > 
> > Yes, users will see their replay window correctly through "ip xfrm state"
> > command, so this is why it has Fixes line, but it won't change anything
> > in the actual behavior without patch 7 and this is the reason why it was
> > sent to net-next.
> 
> Odd ordering of patches, anyone doing backports would totally miss it.
> Neither does the commit message explain the situation nor is it
> possible to grok that fact from the ("pass it to FW") code :(

This is why these patches are bundled together as one series.

> 
> > From patch 3:
> >  Users can configure IPsec replay window size, but mlx5 driver didn't
> >  honor their choice and set always 32bits.
> > 
> > From patch 7:
> >  After IPsec decryption it isn't enough to only check the IPsec syndrome
> >  but need to also check the ASO syndrome in order to verify that the
> >  operation was actually successful.
> 
> Hm, patch 7 looks like an independent but related fix to my uneducated
> eye, should it also have a Fixes tag?
> 
> Is patch 7 needed regardless of what choice of (previously ignored)
> parameters user makes?

Yes, I missed register check and without that replay protection feature
didn't work as one would expect, so it is needed anyway. The patch is
large, complex (IMHO not for -rc7) and I agree with Saeed that "missed register"
sounds like "missed feature".

> One way to deal with the problems from patches 
> 3 and 4 could be to reject the de facto unsupported configurations.
> But if the supported config also doesn't check the "syndrome" correctly
> in all cases, that's no bueno..

Patch 4 was discovered before replay window testing, when we run HW vs.
SW interoperability testing. The feature of setting seq/oseq is orthogonal
to replay window.

Thanks

> 

