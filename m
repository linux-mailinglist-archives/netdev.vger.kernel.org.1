Return-Path: <netdev+bounces-173832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAAA5BEA7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FE33B194A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49296224AF3;
	Tue, 11 Mar 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8lSvO2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE9F1DEFFC;
	Tue, 11 Mar 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691736; cv=none; b=ip2BVF2bjCmEbHf/hITGvHaBMOUxXaVZhpEGw/FqNoFXnz5mmC37tyI+tCqWfE0oOYwxwTd6keqbC+V9/1LWXNm6a4/GRN69NnZZrtRGvY99zfPBpRpRbccF9cB0rIWEukPivuiFOIuGpaFC49z7zbrUttwv/hYHfdD+rHUl++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691736; c=relaxed/simple;
	bh=va1by/3p8+ybPKxwukKtBv1gAiHFNUyh60yOFGE+flY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJsavit5Q9a4G8M/kyU2DdP3WhOl+hubtAwzxzQQk4GeQmYb4u1c8QcUuMtamDMy8AHb3AkHPM+kKuVD560ibkKnGx22nuJYBRuaJbPywKtAByezOhrXbdna7i/2SVZXaHSWtmpKmimBpIw0upYybHqbVTgAC/0AYdDJnlawuO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8lSvO2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCD4C4CEE9;
	Tue, 11 Mar 2025 11:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741691735;
	bh=va1by/3p8+ybPKxwukKtBv1gAiHFNUyh60yOFGE+flY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8lSvO2rGMe+Nzq6zhEaimTDOAUiBeWNsBX5H3YkPa2UfUr4fHtvfqyLnELvotVFi
	 icnIRV1M31GceJQYoovc5tF0e1vkawKd89jNj6L3tfLx5imnYQOeVP9UiSQUAgCTo6
	 qELVS4uuxKK+pH9v2xZLvGtT66hJlaYSXkL2eoYNBUlgfIoHtDyGkxkhJSjRRaiyJp
	 1WWDiz/tlD6N2CvTZSHg9QYoN0IfFY3TrALefCTT9TQVABfhGXG5AHpRFKO174lhlB
	 +72+giQyK4eZFUP4JzajufVfqTuJIOBot9Ut1HqeF5BymKsrxqL4AagHSADv4WmXTB
	 V5gABTBzrrZvw==
Date: Tue, 11 Mar 2025 12:15:29 +0100
From: Simon Horman <horms@kernel.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com
Subject: Re: [PATCH net-next] qlcnic: Optimize performance by replacing
 rw_lock with spinlock
Message-ID: <20250311111529.GM4159220@kernel.org>
References: <20250306163124.127473-1-eleanor15x@gmail.com>
 <20250307132929.GI3666230@kernel.org>
 <Z8xx0aN4vA7d-73i@eleanor-wkdl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8xx0aN4vA7d-73i@eleanor-wkdl>

On Sun, Mar 09, 2025 at 12:35:29AM +0800, Yu-Chun Lin wrote:
> On Fri, Mar 07, 2025 at 01:29:29PM +0000, Simon Horman wrote:
> > On Fri, Mar 07, 2025 at 12:31:24AM +0800, Yu-Chun Lin wrote:
> > > The 'crb_lock', an rwlock, is only used by writers, making it functionally
> > > equivalent to a spinlock.
> > > 
> > > According to Documentation/locking/spinlocks.rst:
> > > 
> > > "Reader-writer locks require more atomic memory operations than simple
> > > spinlocks. Unless the reader critical section is long, you are better
> > > off just using spinlocks."
> > > 
> > > Since read_lock() is never called, switching to a spinlock reduces
> > > overhead and improves efficiency.
> > > 
> > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > 
> > Hi Yu-Chun Lin,
> > 
> > Thanks for your patch.
> > 
> > My main question is if you have hardware to test this?
> > And if so, was a benefit observed?
> > 
> > If not, my feeling is that although your change looks
> > correct, we'd be better off taking the lower risk option
> > of leaving things be.
> 
> Hi Simon
> 
> I perform a compile test to ensure correctness. But I don't have the
> hardware to run a full test.

Thanks Yu-Chun Lin,

Unfortunately I think we need hardware testing to accept this
kind of change.

