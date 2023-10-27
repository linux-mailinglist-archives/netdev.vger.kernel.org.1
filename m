Return-Path: <netdev+bounces-44701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8987D94BA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74628B20E98
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E297F1774D;
	Fri, 27 Oct 2023 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJlfTOBp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E91773D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2811C433C8;
	Fri, 27 Oct 2023 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698401301;
	bh=KKDqOO58WW0FlKguUlH7wCgXb/zgOKHjOdctfLU9P4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJlfTOBpCVkwmnea8tV8eAsIUcQityDLBIVxoStiYW+FyQVcJaPr1ZjpjH0rZTGGF
	 DE6xxPSa6b27teX5YCkGjFq0GpATM3k5YkoZzSyAVApwz2XxgpeG3JqMnn2qsPuPdZ
	 bVt6cZiMULLjPZdfR3eOxRADeWp1a1mVMFKNsPOdBmrM0e1MtF+8IdaZpV1/pR5WU9
	 u17SLZXWKO4wSn6+iEYmGqIgPd6X4G7/iKkTyjFrSASWT6J3TnJHqQINukZOOCVR3k
	 /l0di+J+fUqQKbND10BHgsRIPX/bNfTJMgfBN371CX9sHyV3ZPQj4YKkRqREzngchE
	 vJMb38JMfz8fg==
Date: Fri, 27 Oct 2023 13:08:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <20231027100816.GE2950466@unreal>
References: <20231021064620.87397-1-saeed@kernel.org>
 <20231024180251.2cb78de4@kernel.org>
 <ZTrneUfjgEW7hgNh@x130>
 <20231026154632.250414b0@kernel.org>
 <ZTsH2n4k0kd+nChv@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTsH2n4k0kd+nChv@x130>

On Thu, Oct 26, 2023 at 05:44:10PM -0700, Saeed Mahameed wrote:
> On 26 Oct 15:46, Jakub Kicinski wrote:
> > On Thu, 26 Oct 2023 15:26:01 -0700 Saeed Mahameed wrote:
> > > When I sent V1 I stripped the fixes tags given that I know this is not an
> > > actual bug fix but rather a missing feature, You asked me to add Fixes
> > > tags when you know this is targeting net-next, and I complied in V2.
> > > 
> > > About Fixes tags strict policy in net-next, it was always a controversy,
> > > I thought you changed your mind, since you explicitly asked me to add the
> > > Fixes tags to a series targeting net-next.
> > 
> > Sorry, I should have been clearer, obviously the policy did not change.
> > I thought you'd know what to do.
> > 
> > > I will submit V3, with Fixes tags removed, Please accept it since Leon
> > > and I agree that this is not a high priority bug fix that needs to be
> > > addressed in -rc7 as Leon already explained.
> > 
> > Patches 3 / 4 are fairly trivial. Patch 7 sounds pretty scary,
> > you're not performing replay validation at all, IIUC.
> > Let me remind you that this is an offload of a security protocol.
> > 
> > BTW I have no idea what "ASO syndrome" is, please put more effort
> > into commit messages.
> 
> ASO stands for (Advanced Steering Operations), it handles the reply
> protection and in case of failure it provides the syndrome, yes I agree the
> commit message needed some work.
> 
> Now given the series is focused on reworking the whole reply protection
> implementation and aligning it with user expectation, and the complexity of
> the patches, I did agree to push it to net-next as the cover letter
> claimed, I am not sure what the severity of this issue in terms of
> security, so I will let Leon decide.

While replay protection attack is real issue, in this specific case, I
didn't see any urgency to push it in -rc7 (most likely, next week will
be merge window [1]). 

IPsec packet offload is supported in crypto flavor ConnectX cards, need
relatively new FW and very new strongswan/libreswan. Also, we (Mellanox)
work very closely with all our partners who needs backports as it is not
trivial.

There are zero or close to zero chances that anyone will run IPsec
offload in production with stable kernel which is not approved by us.

Thanks


[1] https://lwn.net/Articles/948468/

> 
> 

