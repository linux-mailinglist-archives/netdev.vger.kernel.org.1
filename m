Return-Path: <netdev+bounces-217545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFEDB39028
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF35982541
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA81DC075;
	Thu, 28 Aug 2025 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXzGQ7wo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646EF1D88B4
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341430; cv=none; b=AV8F+gQv30K83nZn0fU14+hqdXXQ1YYacU1ropSVuRo407JJIhp1PSz92bjYx/21s49DyhLonU/uaLV3U8nJf+Hu1xI3s2XKcCbBdA+/aDfsqDIEozoZLFn3beK3+SMKSlh0GvshNzvAOnrdyN75rWBb41BToLCm8UI74E4tse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341430; c=relaxed/simple;
	bh=snxDPEFVVAwyuOlhPMGIfa56OIh1JHIb1h0I/5AZ73E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNLXdXpQX3F9XdDhh+nvFs2Q2Qt9CmcezOUkYttpUo3Bp3qhqqo+/XlbLTkqmE4jkF6NkAn53gi6Fip7W2ALkcl9mzb5nPGpudfvXPqvak/lqEVkfP6+MP+oAZn/325pg2zO1R3Or92WO9L6fHEbBamOihkOqT8jOLg81IIEbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXzGQ7wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB9AC4CEEB;
	Thu, 28 Aug 2025 00:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756341429;
	bh=snxDPEFVVAwyuOlhPMGIfa56OIh1JHIb1h0I/5AZ73E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nXzGQ7wosCQ7TC2zoKxO6sIUbeYsq9lYpXswEmRqgRFGlU1m09LjKfo+rbEuDLM8B
	 lU+Ff13kAZpLs6dRMYH9jA3COH4zrZsOgAYXPQoWf93rXmDl1evc/JuO8o4di1OnPp
	 XBlU8RhN6a8mW6BLsDmTheBx0zXkINb2OlznIeDNBi67oaWkfPUf8DriYPPLHw6rKW
	 jccVl3Ee5z4I745ESA8HpTk9I05uIR3NhlVP6WlMMh2Y2DI1EdLsY0R7gPKMqYhePY
	 WF/wSfoyhbdqFkkEsxN3I9u8oMignOVZeNVXDzYiog5boBRYfZrsf7UNVpSEvbA6/j
	 IfnsXGVk5oTXg==
Date: Wed, 27 Aug 2025 17:37:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND net-next] ptp: Limit time setting of PTP clocks
Message-ID: <20250827173708.398bdb99@kernel.org>
In-Reply-To: <20250825111117.3846097-1-mlichvar@redhat.com>
References: <20250825111117.3846097-1-mlichvar@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 13:11:13 +0200 Miroslav Lichvar wrote:
> -		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
> +		/* Make sure the offset is valid */
> +		err = ptp_clock_gettime(pc, &ts2);
> +		if (err)
> +			return err;
> +		ts2 = timespec64_add(ts2, ts);
> +
> +		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC ||
> +		    !timespec64_valid_settod(&ts2))
>  			return -EINVAL;

Please leave the input validation (tv_nsec >= NSEC_PER_SEC)
separate and before we call gettime. It's easy to miss that
on part of the condition is checking ts and the other ts2.

Do we not need to apply the same treatment to adjphase?
-- 
pw-bot: cr

