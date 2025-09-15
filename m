Return-Path: <netdev+bounces-223121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C702B58051
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D3518888D5
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1DF24728E;
	Mon, 15 Sep 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnedSK9F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B941DE4E5
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949572; cv=none; b=NLfBW6et4+j6wWR8KEFmeEHG1txgTdJN7AnuXw7vRDANYOnsqbnVRO6jUQ3iiKcaEmROevrMNLyaKnu6kPXgibVW6dj59gY36LVIYxxcu/zYVEyg/bm+hZQ37dfNdt8SHyD+JhSqZgBOluB1piL381ZMBJQmRNeR7uAc/s2JAFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949572; c=relaxed/simple;
	bh=+zPXRJvQLGrQg5knOB0aVgDPejM02fyGGa6SPEbwTdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXqb8NDH1tLCz6OJMncSR6SPOej/UfIp62dNbkLL1Gkzm4l5ti2JenGJgY0NFQMhgPqHJItaJ6oLSt6ZIbBDMFBvLnfALEXlXIL7Tar5ddtS+Gy4QLaHPa5mJPV6Wz5mm8+bOvypo0iT7ap76LMzXMQqOeg/4MIcbbgdYHsxbTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnedSK9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A5EC4CEF7;
	Mon, 15 Sep 2025 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757949571;
	bh=+zPXRJvQLGrQg5knOB0aVgDPejM02fyGGa6SPEbwTdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PnedSK9FiWLSf1h+8yvnwvytyYIV1GvzvZ5H5oSMxMgZCXD9BnZrnur2iddMAmcxL
	 28aukGW4Mgdm7wiaq9u8ehvr5wGax0nHfvtk7X8i8om2yDDT03w8CHYIVm8YmftNrh
	 GAEeRZF0EkJ/yhWvIOF+MyBqN+ZL4lImnQnKkRixfYWRwImuDp6ADWmTYk1hTYq9/3
	 pQHOjLhJ2jRQS1I7lqNtaAPau+gOM0qSKzyO934lt3RUfMhgspEAvkoTvBHWBtnpoC
	 VrQhrg1GKeb9xuxs9nqpOBs3u2smT9GCtraaZ3kyo/t5cFEl+hxPQrWZUsQRt8TBNB
	 p7ddP2/EZI8xw==
Date: Mon, 15 Sep 2025 08:19:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 2/9] ice: move service task start out of
 ice_init_pf()
Message-ID: <20250915081930.32de8247@kernel.org>
In-Reply-To: <84554f92-5b57-4fcd-85f5-89d9ec0f2523@intel.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
	<20250912130627.5015-3-przemyslaw.kitszel@intel.com>
	<20250912161938.1647096b@kernel.org>
	<84554f92-5b57-4fcd-85f5-89d9ec0f2523@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 13:01:47 +0200 Przemek Kitszel wrote:
> On 9/13/25 01:19, Jakub Kicinski wrote:
> > On Fri, 12 Sep 2025 15:06:20 +0200 Przemek Kitszel wrote:  
> >> +	timer_setup(&pf->serv_tmr, ice_service_timer, 0);
> >> +	pf->serv_tmr_period = HZ;
> >> +	INIT_WORK(&pf->serv_task, ice_service_task);
> >> +	clear_bit(ICE_SERVICE_SCHED, pf->state);  
> > 
> > I should just read the code, but this looks like an open-coded
> > deferred_work ?  
> 
> I wanted to put some joke about our driver, but it is not funny :F
> 
> ice-service-task is scheduled both by the timer and work_queue (ice_wq),
> there is more flags that I could count around the scheduling, and it is
> a pain to stop/reset the thing - I will definitively try to simplify
> the thing (esp. given I have a bug with driver reset on me)
> 
> but for now, the cited thing is just a little chunk that I have moved
> from one function to another (and the whole series is not about a race)

FWIW a lot of races that used to exist around work scheduling are now
trivially resolved by disabling the work. But yeah, not a blocker here
obviously..

