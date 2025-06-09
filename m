Return-Path: <netdev+bounces-195902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 955A1AD2A4F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 01:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703581890C53
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FC2227B9F;
	Mon,  9 Jun 2025 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR9KNz5t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF2221FB5;
	Mon,  9 Jun 2025 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510640; cv=none; b=hVLjwXviVrPpW7L7tpCumQ/U4d1M8/fcbOf8QTWAdrKTGznUb+OvdjpgohXjgdCJpQG8LtyYi64uvzOsPpNxM03/Yv5C8f4tpX4yCPapBunYcGj5eXw/rt2oN+eFPq9pGRbWT8JAR4sWZYp09Iqu0uiU3+pBMKbLewdTf6kwLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510640; c=relaxed/simple;
	bh=bx9NcLoyBc/X4erImU4fVAM54+jApjXbJj0OpnMy794=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQFNogKPxSYT1Iq9BxjvA6u4HRVkU5wZP3cwcG2Yd0o36+1NNRMxDO3PHt9LyHWC98IrVvnHxV45QPddfCa4IFZaTHHue4M7dWUysZUI8kNCFgbC4lRjlC9kEJIzE32ONpCgKqZaTbabCKl8qOdmpLl3DKfpAbDW8CEUav2LVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR9KNz5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D5EC4CEEB;
	Mon,  9 Jun 2025 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749510640;
	bh=bx9NcLoyBc/X4erImU4fVAM54+jApjXbJj0OpnMy794=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SR9KNz5tad0b3KJYbda9lzbutOkP8U46tf7U4qOgAZvF5AVUIS+zSaK3VPCkwN2jl
	 Pzu9ck8ArdBJcHVhaIuAoOQ3gW+u33fmwUUhtO01tBfXmVNtkmOh3t5SSIRW13du++
	 7eduBFBZI09YSse0pD2gRf4gyP6zQY6QjmjZz6JSnIBdhD/dSEO/SQXKbrtb4CMv90
	 kfjiAbLUiayqh+mdqac/AODWaid63bxPK6PwFs9eirJu1RWS73qzp4a3nJ1547UPpa
	 MxSbOOm4umvTATwh8a88Drq3qZfPF5Q8XBohC5AcXbSLOpnJiquOb4Ml4yQGQ+cVye
	 /T9ZvJzLscMhQ==
Date: Mon, 9 Jun 2025 16:10:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: horms@kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 brian.ruley@gehealthcare.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] igb: Fix watchdog_task race with shutdown
Message-ID: <20250609161039.00c73103@kernel.org>
In-Reply-To: <aEaAGqP-KtcYCMs-@50995b80b0f4>
References: <20250603080949.1681-1-ian.ray@gehealthcare.com>
	<20250605184339.7a4e0f96@kernel.org>
	<aEaAGqP-KtcYCMs-@50995b80b0f4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 09:32:58 +0300 Ian Ray wrote:
> On Thu, Jun 05, 2025 at 06:43:39PM -0700, Jakub Kicinski wrote:
> > On Tue,  3 Jun 2025 11:09:49 +0300 Ian Ray wrote:  
> > >       set_bit(__IGB_DOWN, &adapter->state);
> > > +     timer_delete_sync(&adapter->watchdog_timer);
> > > +     timer_delete_sync(&adapter->phy_info_timer);
> > > +
> > > +     cancel_work_sync(&adapter->watchdog_task);  
> > 
> > This doesn't look very race-proof as watchdog_task
> > can schedule the timer as its last operation?  
> 
> Thanks for the reply.  __IGB_DOWN is the key to this design.
> 
> If watchdog_task runs *before* __IGB_DOWN is set, then the
> timer is stopped (by this patch) as required.
> 
> However, if watchdog_task runs *after* __IGB_DOWN is set,
> then the timer will not even be started (by watchdog_task).

Well, yes, but what if the two functions run *simultaneously* 
There is no mutual exclusion between these two pieces of code AFAICT

