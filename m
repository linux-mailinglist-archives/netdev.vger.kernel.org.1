Return-Path: <netdev+bounces-167113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F08DA38F2D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043ED16B26D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 22:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4C41A83E2;
	Mon, 17 Feb 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyAlXfJX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32718B495
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831860; cv=none; b=XgMNSKkfdHXjeioCv+iGyweNkJQ3DdSxizHPWNhQrcq7fjQ7vf2LFs8rTCo4US4Y0e3LQKWlKeqJrneY9McYiPrgNpwOPlezss1BcngrxudFd2jxbjhjvLz53FS2tALutGaRHzLcRmvqaD9uDyi8YES43XR7EL4k24hYFMS9Pks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831860; c=relaxed/simple;
	bh=/Z+u49m26mkK67b+XILnYG1Rgq+KyT/Itj1J0KC+6FI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h08He2uSODjB1XmHr8ckoNJWkOK8+en/URYv1NDb5+RuZRAxPrxMQK1TbIpGGcPlBzgKpauxWYbbvjcfoXwN2zQOZq5I5u2L7LwaXf90/wc7YdDuBU1S0uoBMndQe3ybWVAMLyzXo2kR+kYVTImfBe6O7w+HyAi8nXOJ5HER99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyAlXfJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0997C4CED1;
	Mon, 17 Feb 2025 22:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739831860;
	bh=/Z+u49m26mkK67b+XILnYG1Rgq+KyT/Itj1J0KC+6FI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FyAlXfJXPCnnRVnzODl00STV3IH7E9GjWKbEsaTzNJ6F39CnIycdAsaW+i7/BGf2C
	 zSumSLJyg12OUjlBto8xYG19bFTInn+j+3gZd6JO8juARJvExmAPS96H7521N1zhjK
	 JeFoLi9eKf82b9NT4E+ZAyJt6lAXWVTV0pRbrPDuN1CoOYqMYFEJiRInvseZg3euXJ
	 9ZQAwuGZDFvlBKpvxNBQnrF0SjFpy7klzd7B9IAH994cP2B5cYeJ+n7wf6AffG17vK
	 UZrPikt68On4IPK1slmYYWX+P6t6N4oooeefiJdXv6Gia6io/DfnYDz55AubMKHRbn
	 dl9jh+Y1MiIZg==
Date: Mon, 17 Feb 2025 14:37:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
 <horms@kernel.org>, <jacob.e.keller@intel.com>, <netdev@vger.kernel.org>,
 <vadim.fedorenko@linux.dev>, <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v7 0/4] Support PTP clock for Wangxun NICs
Message-ID: <20250217143738.24390532@kernel.org>
In-Reply-To: <050201db80dd$f4b45bb0$de1d1310$@trustnetic.com>
References: <20250213083041.78917-1-jiawenwu@trustnetic.com>
	<20250214165218.5bce48c3@kernel.org>
	<050201db80dd$f4b45bb0$de1d1310$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 09:47:51 +0800 Jiawen Wu wrote:
> On Sat, Feb 15, 2025 8:52 AM, Jakub Kicinski wrote:
> > On Thu, 13 Feb 2025 16:30:37 +0800 Jiawen Wu wrote:  
> > > Implement support for PTP clock on Wangxun NICs.  
> > 
> > Please run:
> > 
> > ./scripts/kernel-doc -none -Wall drivers/net/ethernet/wangxun/*/*
> > 
> > Existing errors are fine, but you shouldn't be adding new ones.
> > You're missing documentation for return values for a lot of functions.
> > 
> > Note that adding kdoc is not required, you can just remove it where
> > it doesn't add value. But if you add kdoc comments they need to be
> > fully specified.  
> 
> OK, I'll fix it in the V8 patch set.
> So what is the conclusion about the "work" item. Should I revert it to V6?

Not, why? IIUC people who replied on that thread were just backing up
my assertion that aux_work is much better.

