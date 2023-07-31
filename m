Return-Path: <netdev+bounces-22913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD32076A019
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FA3281656
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9761D31F;
	Mon, 31 Jul 2023 18:13:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B81D31B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B07AC433C7;
	Mon, 31 Jul 2023 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690827211;
	bh=JgYLR2p0UTU8jfWLZC91aaSiGzPX/p54RufKdswTSfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fv0gjn6meUczIYDumYbwS4gGefpf9Vxw+E9d5BDfhrUMlnDUxyfn3EuMJETmy+vIE
	 D1Gy3YcjvM907jdwBmPLtCek+s/7z9wtABc8mjmRl3C168LhTD0HibCXA4nkKDZkXg
	 EJ6Sj+JbY2bpyjhR3MpNsc9pZt+vWvtqmxGUp2Zr39DAeWaEJCHekj+DZ2I8MOEOR8
	 EBEIOHgzPYW6tu2vdPXSONfD9julemh6ZdDie2H4wJLLsambTyqqyhbzIKiWqbrkdJ
	 8rFgrPCQ1oOn71KP6G8IzKbJQhWVmAbCRa5LrgosmibsZFLHUquk0kWVMyBBQj0GMb
	 m4L00Bx0bKgnA==
Date: Mon, 31 Jul 2023 11:13:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: hayeswang@realtek.com, edumazet@google.com, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, linux-usb@vger.kernel.org, pabeni@redhat.com, Paul
 Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Error 'netif_napi_add_weight() called with weight 256'
Message-ID: <20230731111330.5211e637@kernel.org>
In-Reply-To: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
References: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 11:02:40 -0500 Limonciello, Mario wrote:
> Hi,
> 
> I noticed today with 6.5-rc4 and also on 6.1.42 that I'm getting an 
> error from an r8152 based dongle (Framework ethernet expansion card).
> 
> netif_napi_add_weight() called with weight 256
> 
> It seems that this message is likely introduced by
> 8ded532cd1cbe ("r8152: switch to netif_napi_add_weight()")
> 
> which if the card has support_2500full set will program the value to 256:
> 
> 	netif_napi_add_weight(netdev, &tp->napi, r8152_poll,
> 			      tp->support_2500full ? 256 : 64);
> 
> It's err level from
> 82dc3c63c692b ("net: introduce NAPI_POLL_WEIGHT")
> 
> Why is this considered an error but the driver uses the bigger value?
> Should it be downgraded to a warning?

Could you double check that the warning wasn't there before? The code
added by commit 195aae321c82 ("r8152: support new chips") in 5.13 looks
very much equivalent.
The custom weight is probably due to a misunderstanding. We have 200G
adapters using the standard weight of 64, IDK why 2.5G adapter would
need anything special.

