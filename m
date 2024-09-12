Return-Path: <netdev+bounces-127700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F699761D7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1CB1F233B3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF218BC2E;
	Thu, 12 Sep 2024 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F30D2bQT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vsCFjHsJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4B18BBB5
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123921; cv=none; b=fPvmK49mQsozITYeJmLEbMmYUpn1HFWZSaprrjl8MOwH43glk4q2IB/PridF2Vrva7zLG7pgfA76NvMlLp0fAn3d1YWzW8Mk4gXDQNoFnjLUfCpRghwA/zIh+weg/7FGXXrg5uMK4/4DcvmUBCJ3AQhlvnruKdXpdNH+OEH3D6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123921; c=relaxed/simple;
	bh=Fj0bpl5JE/iT9e6GeiHa9AgQMuoUMJqW6V0YZBJ0qek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPwy/AAXUR3OOnQINWkCEddTf14HWYW9HhwuNF8Hhl/Hi8vSY6pCF+SC+gitrhniyYd1jCUwhLZXA10PY8tR4hQYZMX/HZCbO8nY6vJSYhbKJxaN+bGUgNj62rTgfTEd9q47YpCOxj/wpEJFkdTZEyKTJcqRlFEJg/GUy6w5esI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F30D2bQT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vsCFjHsJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Sep 2024 08:51:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726123917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8msmBQ9sA4r6hBZRR9rV+5WXPpMnMFtiyC5bpr/g3FE=;
	b=F30D2bQTKF7djqz5pwqjMMnzpAaWoBwmMeo3RKY+of1NrcuhWdtZaEXESvCUeqASLDVPq7
	AFgQDbrwp9Grb/glFDdejw/9YVwwcqCb4LgJ4APH1cHmNACRqX+K0vOv0L0P/NEdTDUvUS
	wt5hG5iY/LO0j1ed7fz8Kx/iU2UAXp9FGPiwplKWHIlnVLWl2YdS/GLXJhnJBjYZB6RiUL
	T6MarJtBvM22RZOOj4ujn1b0BXrMBp2XLvUDlg8mMs1/HtlSu5bvSh2l86XyeNPy4ZoqyD
	zH2sMLYMjVyEcozBiTnY6WyXlPpDqPYawnYQKwzl6frAIkO9cGmbhn71agVwEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726123917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8msmBQ9sA4r6hBZRR9rV+5WXPpMnMFtiyC5bpr/g3FE=;
	b=vsCFjHsJf89PpwcLSSFYMavKXkaj6+gQPtgWBiTV8ZTT8SE3+kNGfZKyy08wbvOwrrM2PV
	LWYxJqggTHX0BqDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net 0/2] net: hsr: Use the seqnr lock for frames received
 via interlink port.
Message-ID: <20240912065155.AyiTp0bn@linutronix.de>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
 <20240911155324.79802853@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911155324.79802853@kernel.org>

On 2024-09-11 15:53:24 [-0700], Jakub Kicinski wrote:
> On Fri,  6 Sep 2024 15:25:30 +0200 Sebastian Andrzej Siewior wrote:
> > I hope the two patches in a series targeting different trees is okay.
> 
> Not really. Out of curiosity did you expect them to be applied
> immediately but separately; or that we would stash half of the
> series somewhere until the trees converge?

1/2 should not clash with 2/2. So one could go to net and the other to
net-next. But now that I know, I won't do it again.

> > Otherwise I will resend.
> 
> The fix doesn't look super urgent and with a repost it won't have
> time to get into tomorrow's PR with fixes. So I just pushed them
> both into net-next.

I just noticed that you applied
   b3c9e65eb2272 ("net: hsr: remove seqnr_lock")

to net. Patch 1/2 should replace that one and clashes with this one now.
I tried to explain that removing the lock and making it atomic can break
things again.
Should I send a revert of b3c9e65eb2272 to net?

Sebastian

