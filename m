Return-Path: <netdev+bounces-127143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB779744F9
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EE91C25630
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057171AAE34;
	Tue, 10 Sep 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6qTomJK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617C1A4F1E
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004698; cv=none; b=LHdNoC//wBOF5f2JJKTW752kLI2rmOUX2LOQHq6cuPDsyh7MFfu7Cbg9CTv2qBM5dU9rBygSPT+EFDJ6o/miRtIvJcmAymT3Xi7O81CpGv0C2HOq0sto6BZakdYIdbQqHuZj3Dkt+q0UlxGkLH1OHSD73ZM2trbJwmZW/x6e5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004698; c=relaxed/simple;
	bh=BcgxLMh1pYrFwiaAJ/zaZRoUUTkEakbXRZByJ0X8Cao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7/0Q/IYIbd3S1DgvUGX18CfT78ZOatLtqppl902diCAK+3wUPZ2xGgI3sMS3NIamUz02HpjlRIAu60CNhVtOOX4bvS7P3QFWv0IdzDMq0Q5NOCVxQOFM2Lq3BHsGKEd9oGpdOPoQ82b3IwAztNj2BjX4H2fshNOHTWUycZEYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6qTomJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECCBC4CEC3;
	Tue, 10 Sep 2024 21:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726004698;
	bh=BcgxLMh1pYrFwiaAJ/zaZRoUUTkEakbXRZByJ0X8Cao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o6qTomJKcbQiOp39fTaY/ETAuAbxBubF33H4FyZx0lH7gWyGARHfZekQzy5LPeYEB
	 Y+XHEHYA/0htgyTzCggtG1KsVjPdPZhvVKbMbuusStX1GK2L9lfEyS9cpvua4maddf
	 ftmU0FO5u+ICBaMrDbQPeRx03RHHfWBjjam2T7tvmJaHLKjmDxpGCii8/rpFryG+WW
	 RQWF/CCOWCqDQdMGPD1y3sgzsfDvoI27eICl04YggaHTgFtrtIRPs7cgV+ytM8Qq4Z
	 zKRjt8rD83GNObt7bY3/76HRLzP3kHxA2KxiAy6Cjvtl+ya6GPnyloxsIh1+51uddI
	 l0q8bZOvqnIhw==
Date: Tue, 10 Sep 2024 14:44:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <netdev@vger.kernel.org>, <aleksander.lobakin@intel.com>,
 <przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
 <michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
 <willemb@google.com>
Subject: Re: [PATCH net-next v3 0/6][pull request] idpf: XDP chapter II:
 convert Tx completion to libeth
Message-ID: <20240910144456.67667b69@kernel.org>
In-Reply-To: <c3ba53a1-0de6-7c15-8a74-415e91e55edc@intel.com>
References: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
	<20240910071649.4fba988f@kernel.org>
	<c3ba53a1-0de6-7c15-8a74-415e91e55edc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 09:46:57 -0700 Tony Nguyen wrote:
> > You're posting two series at once, again. I was going to merge the
> > subfunction series yesterday, but since you don't wait why would
> > I bother trying to merge your code quickly.  
> 
> I thought last month's vacations were over as I had seen Eric and Paolo 
> on the list and that things were returning to normal.

Stubbornly people continue to take vacations, have babies etc.
But that's besides the point.

Either we are merging stuff quickly, and there's no need to queue two
series, or we're backed up due to absences and you should wait.

The rule of 15 patches at a time is about breaking work up as much as
throttling.  Up to outstanding 15 patches to each tree.
I find it hard to believe you don't know this.

> > And this morning I got
> > chased by Thorsten about Intel regressions, again:
> >   https://bugzilla.kernel.org/show_bug.cgi?id=219143  
> 
> Our client team, who works on that driver, was working on that issue.
> I will check in with them.
> 
> > Do you have anything else queued up?
> > I'm really tempted to ask you to not post anything else for net-next
> > this week.  
> 
> I do have more patches that need to be sent, but it's more than can fit 
> in the time that's left. There are 1 or 2 more that I was hoping to get 
> in before net-next closed or Plumbers starts.

Higher prio stuff (read: exclusively authored by people who were
actively reviewing upstream (non-Intel) code within last 3 months) 
may be able to get applied in time. We have 250 outstanding patches
right now, and just 3 days to go.

