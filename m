Return-Path: <netdev+bounces-194193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C532AC7BC7
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707861BC789D
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D63215F7D;
	Thu, 29 May 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJF6Q4bi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B841F37C5
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514673; cv=none; b=Y8hHjTdazDI0z60vhGhVV1UA3EYqV/9GoefnIZTbAro8V4OJ7ia4z8SNfvurEZLwgfq1ZWO9WvVSNuAF0eFCtw5Bfjk9CUTRJTHb9ygabycpmNLsdmWPYXQKFODA2gHf6EL6RvYDKHZCw5jUNFq//Kpu++dcpOvv8R2fmbQe684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514673; c=relaxed/simple;
	bh=VK9LKWSIsQvOOm9han8eds+TLPXXslFg92ON1wfPG9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yxf9x//lpA/CmCN0TWm/cO1TDb+DiY/26PSGwGSwi1rERqaYFY4d5JOu9Iin4Tr1wHCqmqyRB4bEJZ3Vx7qlpyuofplM9uciIH9hV8TaUAlA82KutQqdgSOtH8FYH0bW8/q2t2PVXv4AW6QXI/Mo7sO/tu1b5yE7Oqdy06C7xLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJF6Q4bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B358C4CEE7;
	Thu, 29 May 2025 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748514672;
	bh=VK9LKWSIsQvOOm9han8eds+TLPXXslFg92ON1wfPG9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJF6Q4biZqCd9/8+dd1uIt2VGk0NJtCVbYgQF+sNzvrdKOz/8yDfTv3eQkMuWhqN3
	 3TU4RyqjLwoIsqtV0kwaymApIm1GoDoAcbo0x1SPWs9Gr/bB6vszNSTBecI3tYdsyW
	 E15udnIcxpFkUwVuDG2fjPbey86dOR4XXPysp6JPRcKj9/jBaDmvzYyhIZFbyKU9ap
	 3vDsfV7gDLbHE0dYRsdMoN7ZdgsyjNCU/NJIpz40OXkwbXwCgOuhUG0HQesasxFpq9
	 ygSNEuQb89ysJ7sEYLRIPYbZ22FcuJQ31pX8ZUa5Fp3oGIgN3w474hAKICOn/VPY4a
	 bdyaiO0mdnZuA==
Date: Thu, 29 May 2025 11:31:06 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saikrishnag@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sgoutham@marvell.com,
	lcherian@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [net v3 PATCH] octeontx2-pf: Avoid typecasts by simplifying
 otx2_atomic64_add macro
Message-ID: <20250529103106.GM1484967@horms.kernel.org>
References: <1748407242-21290-1-git-send-email-sbhatta@marvell.com>
 <20250528150333.GB1484967@horms.kernel.org>
 <aDgHEPfNQvziIqpr@e6bae70a73d4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDgHEPfNQvziIqpr@e6bae70a73d4>

On Thu, May 29, 2025 at 07:04:48AM +0000, Subbaraya Sundeep wrote:
> Hi Simon,
> 
> On 2025-05-28 at 15:03:33, Simon Horman (horms@kernel.org) wrote:
> > On Wed, May 28, 2025 at 10:10:42AM +0530, Subbaraya Sundeep wrote:
> > > Just because otx2_atomic64_add is using u64 pointer as argument
> > > all callers has to typecast __iomem void pointers which inturn
> > > causing sparse warnings. Fix those by changing otx2_atomic64_add
> > > argument to void pointer.
> > > 
> > > Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
> > > Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> > > ---
> > > v3:
> > >  Make otx2_atomic64_add as nop for architectures other than ARM64
> > >  to fix sparse warnings
> > > v2:
> > >  Fixed x86 build error of void pointer dereference reported by
> > >  kernel test robot
> > 
> > Sorry, I seem to have made some some comments on v2 after v3 was posted.
> > 
> > 1) I'm wondering if you considered changing the type of the 2nd parameter
> >    of otx2_atomic64_add to u64 __iomem * and, correspondingly, the type of
> 
> My intention is to fix sparse warnings (no __force) and avoid typecasts
> so that code is correct and looks cleaner. If I change 2nd param of
> otx2_atomics64_add as u64 __iomem * then I still have to use
> __force to make sparse happy. This way only otx2_atomic64_add looks odd
> internally with assembly stuff.

Thanks. Based on your remarks above I agree this is a good approach.

> 
> >    the local variables updated by this patch. Perhaps that isn't so clean
> >    for some reason. But if it can be done cleanly it does seem slightly
> >    nicer to me.
> >
> > 2) I wonder if this is more of a clean-up for net-next (once it re-opens,
> >    no Fixes tag) than a fix.
> > 
> Sure. Will post as net-next material later.

Again, thanks.

