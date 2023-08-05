Return-Path: <netdev+bounces-24641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C4F770EA6
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 10:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57211C20AEB
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 08:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1C79D8;
	Sat,  5 Aug 2023 08:03:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246611FDD
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 08:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8361EC433C8;
	Sat,  5 Aug 2023 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691222638;
	bh=ysdwb2f9JBYVRhXs8E7OHn6011Cc8W/DnSqtWah111w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InQWLTmImug2DrZP2/oD68GklkjvTF0cKUnTgVhR3IixzMrN+y0dbw34eA33DzfoZ
	 LUHDqNHOCYlJnAB5O8c2BN3CM0RPkX8olq8xpJvou3FTmLtkWi3L0Y5jHTPzHmSsXw
	 0w3dW9XfdYNtbvgczGlnHQ4OPxFVVtbqE46Uf1vodWnCNdOSMiZvUDJjkFpu7hSKZE
	 vvmLTlQwGygX3sDOKIBBPEhBGAUlA8EmwJNZPqdgJPiu1t1wd0FfzE7Kq2If4gcnfL
	 TowUArw6YrwjCcVXSqINm6R5+49v4pbfcQY8pbiim11rbbFhe3kWS/jaKjKp/lt79m
	 RyGoEbv0IsXQA==
Date: Sat, 5 Aug 2023 10:03:54 +0200
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next v2] ice: split ice_aq_wait_for_event() func into
 two
Message-ID: <ZM4CajvI1uNYRNf0@vergenet.net>
References: <20230803151347.23322-1-przemyslaw.kitszel@intel.com>
 <ZM0MlhZduLVa6YZV@kernel.org>
 <385c8607-bc52-af0b-829a-5b058f4a152d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385c8607-bc52-af0b-829a-5b058f4a152d@intel.com>

On Fri, Aug 04, 2023 at 04:54:48PM +0200, Przemek Kitszel wrote:
> On 8/4/23 16:35, Simon Horman wrote:
> > On Thu, Aug 03, 2023 at 11:13:47AM -0400, Przemek Kitszel wrote:
> > > Mitigate race between registering on wait list and receiving
> > > AQ Response from FW.
> > > 
> > > ice_aq_prep_for_event() should be called before sending AQ command,
> > > ice_aq_wait_for_event() should be called after sending AQ command,
> > > to wait for AQ Response.
> > > 
> > > struct ice_aq_task is exposed to callers, what takes burden of memory
> > > ownership out from AQ-wait family of functions.
> > > 
> > > Embed struct ice_rq_event_info event into struct ice_aq_task
> > > (instead of it being a ptr), to remove some more code from the callers.
> 
> see [1] below
> 
> > > 
> > > Additional fix: one of the checks in ice_aq_check_events() was off by one.
> > 
> > Hi Przemek,
> > 
> > This patch seems to be doing three things:
> > 
> > 1. Refactoring code, in order to allow
> > 2. Addressing a race condition
> 
> those two are hard to split, perhaps some shuffling of code prior to actual
> 2., eg [1] above.

Sure, that is a reasonable point.

> > 3. Correcting an off-by-one error
> 
> That's literally one line-fix, which would be overwritten/touched by next
> patch then.

True. But it also a bit hard to find in the current setup.
Anyway, I don't feel particularly strongly about this,
it was more a point for consideration.

> > All good stuff. But all complex, and 1 somewhat buries 2 and 3.
> > I'm wondering if the patch could be broken up into smaller patches
> > to aid both review new and inspection later.
> 
> Overall, I've started with more patches locally when developing that, and
> with "avoid trashing" principle concluded to squash.
> Still, I agree that next attempt at splitting would be beneficial, will post
> v3.
> 
> > 
> > The above notwithstanding, the code does seems fine to me.
> > 
> > > Please note, that this was found by reading the code,
> > > an actual race has not yet materialized.
> > 
> > Sure. But I do wonder if a fixes tag might be appropriate anyway.
> 
> For this off-by-one, (3. on your list) sure.
> 
> For the race (2.), I think it's not so good - ice_aq_wait_for_event() was
> introduced to handle FW update that is counted in seconds, so the race was
> theoretical in that scenario. Later we started adding new usages to
> (general, in principle) waiting "API", with more to come, so still worth
> "fixing".

Understood.

I think this does make me lean towards 3. being better off a separate patch.
But it's your call.

> > > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Anyway, let's see what v3 will bring :)

:)

