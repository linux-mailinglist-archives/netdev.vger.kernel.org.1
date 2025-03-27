Return-Path: <netdev+bounces-177983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC99A73799
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 18:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE4D166BC0
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C115F306;
	Thu, 27 Mar 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXKDU4JI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5F535D8;
	Thu, 27 Mar 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094849; cv=none; b=s03jaaSP/1jefmRa1xHsBJ/avsDUOZrDC/XW+2iGvB4GMNGqnlHtAMRW+yJ+got8mbA9TZyKhvTfa56LxKz8EcGIb68OKtlcI0H4u9IKIeHdczH8d8DEJMgg4DWTDunD+baTXbnVuUcEijw0tBV6GFUmlSEHm6Sees3EnugFrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094849; c=relaxed/simple;
	bh=rnIm7xSXz/WBWTE43R0YHGZWzqA+dWsrh+VaEu1p+98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4b6H+IATZD0Wqecd8T5RnL0RLwjyFOX9HqGENKqO/VmDp+xgSM/t/a+uAE90DG61792s6t7JEmwewk0iIh719XEfgSfxm0zQeXWfuNOnJdMVlmZAVL9C31Fw6eN1Mv6kkRRywBcG7b1oakLzBGE1PM9hDSAb3tku/svISVd6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXKDU4JI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241E0C4CEE8;
	Thu, 27 Mar 2025 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743094849;
	bh=rnIm7xSXz/WBWTE43R0YHGZWzqA+dWsrh+VaEu1p+98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXKDU4JIvuO2ZvDBOkefSm6Z7L9RQE91yLLpOCEAJCGKMJogmPtLw9IFIsD7tTFtq
	 zjUNKcXsC/LkYofecb32cRTHgomThPRQlkX+SIKe/oIbJ97EwmcXbVPEdUoCW1jsJp
	 mqEwZOQqG80ZMlIJnXSkA00NMuDzu2Y89xU+mPOa3C/uvyuJfzaQ1fdnhXDCYap71/
	 Tf9Bs0meqZ95wNcbF0jzRcWpedgLfUxd5LNOnt4JOuf0KSGDolSwA9KzqjMmLRgAIu
	 Mu0aorlzUGqyMKkHtYa+4gdNFJpwIZ4vRFP7R4XbUIUXnmkJ9loB/9KtQScgLfIGwp
	 Ci0XaT8pdR7DQ==
Date: Thu, 27 Mar 2025 17:00:44 +0000
From: Simon Horman <horms@kernel.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: isdn@linux-pingi.de, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com
Subject: Re: [PATCH] mISDN: hfcsusb: Optimize performance by replacing
 rw_lock with spinlock
Message-ID: <20250327170044.GA1883535@horms.kernel.org>
References: <20250321172024.3372381-1-eleanor15x@gmail.com>
 <20250324142115.GF892515@horms.kernel.org>
 <Z-VumXiqJJkZKNZZ@eleanor-wkdl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-VumXiqJJkZKNZZ@eleanor-wkdl>

On Thu, Mar 27, 2025 at 11:28:25PM +0800, Yu-Chun Lin wrote:
> On Mon, Mar 24, 2025 at 02:21:15PM +0000, Simon Horman wrote:
> > On Sat, Mar 22, 2025 at 01:20:24AM +0800, Yu-Chun Lin wrote:
> > > The 'HFClock', an rwlock, is only used by writers, making it functionally
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
> > > ---
> > > Build tested only, as I don't have the hardware. 
> > > Ensured all rw_lock -> spinlock conversions are complete, and replacing
> > > rw_lock with spinlock should always be safe.
> > > 
> > >  drivers/isdn/hardware/mISDN/hfcsusb.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > Hi Yu-Chun Lin,
> > 
> > Thanks for your patch.
> > 
> > Unfortunately I think it would be best to leave this rather old
> > and probably little used driver as-is in this regard unless there
> > is a demonstrable improvement on real hardware.
> > 
> > Otherwise the small risk of regression and overhead of driver
> > changes seems to outweigh the theoretical benefit.
> 
> Thank you for your feedback.
> 
> I noticed that the MAINTAINERS file lists a maintainer for ISDN, so I
> was wondering if he might have access to the necessary hardware for
> quick testing.
> 
> Since I am new to the kernel, I would like to ask if there have been
> any past cases or experiences where similar changes were considered
> unsafe. Additionally, I have seen instances where the crypto maintainer
> accepted similar patches even without hardware testing. [1]
> 
> [1]: https://lore.kernel.org/lkml/20240823183856.561166-1-visitorckw@gmail.com/

I think it is a judgement call, and certainly the crypto maintainer is
free to make their own call. But in this case I do lean towards leaving
the code unchanged in the absence of hardware testing.

