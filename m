Return-Path: <netdev+bounces-172941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ACDA568FD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23BA917565F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5017219A99;
	Fri,  7 Mar 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtMldoKe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596322EE5;
	Fri,  7 Mar 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354174; cv=none; b=EKnAoCSBsyOXDXGrYixr1uoYtQtrCsudfojopYNH2hfwpc1vAOLMc6yl8OzyX5CKlBqjXQh2FydLEfO18pC5S6Ts7SHvkX0NaVi6DN/B1nI8VocObEh/9se+M9+wme7BrktjbvmPf3uG+S67wTGxZkM96vjYwFG4tt/ZjuvXOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354174; c=relaxed/simple;
	bh=sXjXPzEurjcTKi7I5QMQAHWZwIehsKZ/bSlIEFiGpR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhWMOa7VTLJykkhvzqRm7Ou0aJPxJu5qwfSI6E32wt/nO3zUlPBVDPC5HZbl22ABDTuFQ/g48ovQpj1JY29Vm854hQmFodiEm59m6oeMv+dlRBZb9sYdUtBLZ/WshPFKa3dq5kdjLLiBjxuySkefYZ0IcDeGFVOxOXfSs/NrUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtMldoKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889D9C4CED1;
	Fri,  7 Mar 2025 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741354174;
	bh=sXjXPzEurjcTKi7I5QMQAHWZwIehsKZ/bSlIEFiGpR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtMldoKeDw1F2484Mm0M8y9C0/Sd09zWXY+vtjtvpuYfL3hctLJ7nvxGCOzPXZkve
	 J5Co7rmP5C5M3WL2RIMvmA0qzodpT30P7XSwmkLqnTFD6UYcSPeTFVH0nGwbOI8R9o
	 j9LkJgtZr50rIyi+pVgtao8Jyd4h1b5WDJeJ2NIxKR2QrQKcgEZ/Vbe4XwG7VGfgLH
	 XW1O6DTX0tvEdlisTEhH2Vy6RoPnSSbt66oDhsw1dwhYIuW5oD9TL52qjmxrSDe72Q
	 V5awErEpUUJoSF/i+2Y7VABUEUywG63eBnw4Kot8HozeO9oIJCKyx+OAC8m09BjbJ1
	 66sjNc9AcW/yQ==
Date: Fri, 7 Mar 2025 13:29:29 +0000
From: Simon Horman <horms@kernel.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com
Subject: Re: [PATCH net-next] qlcnic: Optimize performance by replacing
 rw_lock with spinlock
Message-ID: <20250307132929.GI3666230@kernel.org>
References: <20250306163124.127473-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306163124.127473-1-eleanor15x@gmail.com>

On Fri, Mar 07, 2025 at 12:31:24AM +0800, Yu-Chun Lin wrote:
> The 'crb_lock', an rwlock, is only used by writers, making it functionally
> equivalent to a spinlock.
> 
> According to Documentation/locking/spinlocks.rst:
> 
> "Reader-writer locks require more atomic memory operations than simple
> spinlocks. Unless the reader critical section is long, you are better
> off just using spinlocks."
> 
> Since read_lock() is never called, switching to a spinlock reduces
> overhead and improves efficiency.
> 
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>

Hi Yu-Chun Lin,

Thanks for your patch.

My main question is if you have hardware to test this?
And if so, was a benefit observed?

If not, my feeling is that although your change looks
correct, we'd be better off taking the lower risk option
of leaving things be.

