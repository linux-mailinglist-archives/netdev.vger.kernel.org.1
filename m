Return-Path: <netdev+bounces-16797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4645C74EB8A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C012812C3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB7182B9;
	Tue, 11 Jul 2023 10:12:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CB182AA
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBDBC433C8;
	Tue, 11 Jul 2023 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689070358;
	bh=1jPTmcG+D3o2OHcQGCOEXQA/egR+CjiCTfrDIYEPW0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efOX9wsuSGxcDAiJ52nPs2hqe3ibmghDTM5/r0t8kgKZvJqyryRf+ItOg9C1YysJE
	 iJMD/mWpBHCZTmpbwaSimCgQfl81GUGa/cnrp0IvmjUU9v1DzZ6AEouhDUyg0VMLyH
	 U/9gXeE3owG8YWEwfzsqlDZYWvquXq9xQmQptd6UlH1AOFh0WP8kjwzdf+SsFlmVU4
	 jUmPGZYAsKQ6fKo+AxPGO3Tf03Il6JmGR2Bnkks0azkrGDjKRlPVsv8Crt6WwTxaq4
	 b5mwEPDo6PRTS3I6tSOW+JJ2s6BlTUj06N6CxpeDadeAFt0ocqs6xhDQ4+1BqhpmUt
	 1FJNsIj/0VRhQ==
Date: Tue, 11 Jul 2023 13:12:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Florian Kauer <florian.kauer@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, kurt@linutronix.de,
	vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 5/6] igc: Fix launchtime before start of cycle
Message-ID: <20230711101233.GM41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-6-anthony.l.nguyen@intel.com>
 <20230711070902.GF41919@unreal>
 <7005af42-e546-6a7c-015f-037a5f0e08a9@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7005af42-e546-6a7c-015f-037a5f0e08a9@linutronix.de>

On Tue, Jul 11, 2023 at 10:37:48AM +0200, Florian Kauer wrote:
> On 11.07.23 09:09, Leon Romanovsky wrote:
> > On Mon, Jul 10, 2023 at 09:35:02AM -0700, Tony Nguyen wrote:
> >> From: Florian Kauer <florian.kauer@linutronix.de>
> >>
> >> It is possible (verified on a running system) that frames are processed
> >> by igc_tx_launchtime with a txtime before the start of the cycle
> >> (baset_est).
> >>
> >> However, the result of txtime - baset_est is written into a u32,
> >> leading to a wrap around to a positive number. The following
> >> launchtime > 0 check will only branch to executing launchtime = 0
> >> if launchtime is already 0.
> >>
> >> Fix it by using a s32 before checking launchtime > 0.
> >>
> >> Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
> >> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> >> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> >> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> >> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> >> index 5d24930fed8f..4855caa3bae4 100644
> >> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> >> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> >> @@ -1016,7 +1016,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
> >>  	ktime_t base_time = adapter->base_time;
> >>  	ktime_t now = ktime_get_clocktai();
> >>  	ktime_t baset_est, end_of_cycle;
> >> -	u32 launchtime;
> >> +	s32 launchtime;
> > 
> > The rest of igc_tx_launchtime() function is very questionable,
> > as ktime_sub_ns() returns ktime_t which is s64.
> > 
> >   1049         launchtime = ktime_sub_ns(txtime, baset_est);
> >   1050         if (launchtime > 0)
> >   1051                 div_s64_rem(launchtime, cycle_time, &launchtime);
> >   1052         else
> >   1053                 launchtime = 0;
> >   1054
> >   1055         return cpu_to_le32(launchtime);
> > 
> 
> If I understand correctly, ktime_sub_ns(txtime, baset_est) will only return
> something larger than s32 max if cycle_time is larger than s32 max and if that
> is the case everything will be broken anyway since the corresponding hardware
> register only holds 30 bits.

I suggest you to use proper variable types, what about the following
snippet?

ktime_t launchtime;

launchtime = ktime_sub_ns(txtime, baset_est);
WARN_ON(upper_32_bits(launchtime));
div_s64_rem(launchtime, cycle_time, &launchtime);

return cpu_to_le32(lower_32_bits(launchtime));

> 
> However, I do not see on first inspection where that case is properly handled
> (probably just by rejecting the TAPRIO schedule).
> 
> Can someone with more experience in that area please jump in?
> 
> Thanks,
> Florian
> 
> > 
> >>  	s64 n;
> >>  
> >>  	n = div64_s64(ktime_sub_ns(now, base_time), cycle_time);
> >> -- 
> >> 2.38.1
> >>
> >>
> 

