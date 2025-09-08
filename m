Return-Path: <netdev+bounces-220973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3982CB49AF2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 22:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38957B0277
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6402D9EED;
	Mon,  8 Sep 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay5sfv/K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCE2D7DC8;
	Mon,  8 Sep 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362843; cv=none; b=XHtIRqRzX9nsWi1WVzzKx5yhZeV2ru0VGO2bmQsXrQCfG0AEY9wmLVoLztMbtCMPkyYQ1HYFoc8b/10yIEr8tTWlpCbjNyzvssaS1d1JLDMBRFro/oWHjEoRcqTSh5pqvRIX+/xbyHyog7oUx4O75nA76HduGX0Az3j01P46mCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362843; c=relaxed/simple;
	bh=3JfEPiTReYJNL9FI/IDG+noi5J0PIaT1KrGz03xK3mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIGaNtkwuIEKLAwz4rF814xJg9cVtWLt+ufuxkUiG5K/0hyf8zWv0bwQzp5eAND96fZN0LcIPDtmRUpENtn1CVMm9Qp3251EX7Q/URxeAwMjIo31Z+lnYRiDaKsOYjCUGs6euz1Zm//eDrUU86xzLdx1kLaImG5/kbYseRPtFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay5sfv/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2AFC4CEF1;
	Mon,  8 Sep 2025 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757362843;
	bh=3JfEPiTReYJNL9FI/IDG+noi5J0PIaT1KrGz03xK3mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ay5sfv/Kpify9UWg3iCN726VZ404UXGzDc50Pe8T7mEaGWy24shClkXsuLuq2ausj
	 TcswAuShJlXjISqzpsjgKproS0B+/i9G1xwFA+sGICaAuKNozKSz5303IQVyWY6A58
	 7xWz6myJojXQG8yWArT90SbfzIJKtxRnzSZQCtqavYte/I8bOPN+qL1mSdvtVhCUqt
	 /L+bzW9RWU8DRj/GYMADqHHXhy+HqP08rAvn3OyQAbh7VcmuXRKlzBbSXn/hqWudNd
	 hq9UumDtQvoV5s4MeAWSYp/iArJLy6NafisxfPoIqDhVTXzs2YmI0aaEvWV8J9baC1
	 w79qfuXdrzWuQ==
Date: Mon, 8 Sep 2025 13:20:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 llvm@lists.linux.dev
Subject: Re: [PATCH net-next] page_pool: always add GFP_NOWARN for ATOMIC
 allocations
Message-ID: <20250908132041.5ae74626@kernel.org>
In-Reply-To: <CAHS8izPRupVvCDQr7-GF+-c3yeu83wZWgQth4_ub8bQ0AhQ9_w@mail.gmail.com>
References: <20250908152123.97829-1-kuba@kernel.org>
	<CAHS8izPRupVvCDQr7-GF+-c3yeu83wZWgQth4_ub8bQ0AhQ9_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 09:15:07 -0700 Mina Almasry wrote:
> > +       /* Unconditionally set NOWARN if allocating from the datapath.
> > +        * Use a single bit from the ATOMIC mask to help compiler optimize.
> > +        */
> > +       BUILD_BUG_ON(!(GFP_ATOMIC & __GFP_HIGH));
> > +       if (gfp & __GFP_HIGH)
> > +               gfp |= __GFP_NOWARN;
> > +  
> 
> I wonder if pp allocs are ever used for anything other than datapath
> pages (and if not, we can add __GPF_NOWARN here unconditionally. But
> this is good too I think.

datapath == in NAPI context, here. We still want the warning if 
the allocations fail with GFP_KERNEL, e.g. during ndo_open.

