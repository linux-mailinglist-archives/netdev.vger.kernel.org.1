Return-Path: <netdev+bounces-17054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A887274FF10
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FE9281632
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 06:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED9441F;
	Wed, 12 Jul 2023 06:11:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31482119
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FA7C433C7;
	Wed, 12 Jul 2023 06:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689142287;
	bh=3h52GPIj0Ovglzl8WsFa1ar6aDn3FMygoC50kqUn++E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GkuYl7tJ5hhMt0SAbJkih6K6rWGxAu2+AZv7CRsX625yU0QUSh6OOdUixZ0c1TE/l
	 d07TrX18KQqihUWlc7y8WDqm3WOvbH6E0sTCIBkDbx0YzS7K9M4fvrJAJFT2ptUyMp
	 3OBvAPs7P7o/KTxYhI4JeXPutZmYUv1+7pGbP+EcaL79NaV2CYPLucyQ5kqFlSCHYq
	 6PXkQoLIm1JuWe+C5fWVIN1exDjhzZJu9xDHGRV0BwPrkY6l6sFVZURzB9JtCqEocf
	 ta1K7MSjbry2olXwaAggPABesHk+gvHy5RN9aYXlWq4xeUr8lxpVCzEH8DEXLdrLg0
	 TOh0u1+rJvA4Q==
Date: Wed, 12 Jul 2023 09:11:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Kauer <florian.kauer@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
	kurt@linutronix.de, vinicius.gomes@intel.com,
	muhammad.husaini.zulkifli@intel.com, tee.min.tan@linux.intel.com,
	aravindhan.gunasekaran@intel.com, sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 5/6] igc: Fix launchtime before start of cycle
Message-ID: <20230712061122.GW41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-6-anthony.l.nguyen@intel.com>
 <20230711070902.GF41919@unreal>
 <7005af42-e546-6a7c-015f-037a5f0e08a9@linutronix.de>
 <20230711101233.GM41919@unreal>
 <20230711175454.040822b1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711175454.040822b1@kernel.org>

On Tue, Jul 11, 2023 at 05:54:54PM -0700, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 13:12:33 +0300 Leon Romanovsky wrote:
> > > If I understand correctly, ktime_sub_ns(txtime, baset_est) will only return
> > > something larger than s32 max if cycle_time is larger than s32 max and if that
> > > is the case everything will be broken anyway since the corresponding hardware
> > > register only holds 30 bits.  
> > 
> > I suggest you to use proper variable types, what about the following
> > snippet?
> > 
> > ktime_t launchtime;
> > 
> > launchtime = ktime_sub_ns(txtime, baset_est);
> > WARN_ON(upper_32_bits(launchtime));
> > div_s64_rem(launchtime, cycle_time, &launchtime);
> > 
> > return cpu_to_le32(lower_32_bits(launchtime));
> 
> That needs to be coupled with some control path checks on cycle_time?

I think so, as I didn't find any checks which protect from overflow.

Thanks

