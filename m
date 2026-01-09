Return-Path: <netdev+bounces-248533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769ED0ABB3
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB97303EBA8
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3435FF63;
	Fri,  9 Jan 2026 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNRayfPk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98063382E9
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969830; cv=none; b=ipOsmMJ5WVZyQHzfmt6K+JSe1acPtvO+GpUhrvNXJaKlguayIL0Aud56Z93SpVJ1gfBfsTEBRC+F4I9Nvcv/rdUJTY8RnLmyVgAhgARNkxWpmW3VsIEQZesfr27dH+JNgaRvENluT+mEzjaNg4gNGUX0t43IEkSWujuT+Lw+4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969830; c=relaxed/simple;
	bh=DKa53dLtShv+gRwSQDwhs8b/RNZdveoQZik2VMnDRuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltE5UwR/X0IY4F0ZzWplIspkHg93PaMVSlFpFDADcjB1M4ADMdTd41XeCPkKsc5sqwNmvXO3ennjJKZORN3+MYqkEOaj4hIJkNG/PQ0w5xDRkD0XBoJ/iD3pRhbeojZ7nhlWXnXkzepjDN7k9nljBRpQFLveayuErH9plxCsedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNRayfPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2990BC4CEF1;
	Fri,  9 Jan 2026 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969830;
	bh=DKa53dLtShv+gRwSQDwhs8b/RNZdveoQZik2VMnDRuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HNRayfPkl8RGRAEPw7ZS+HCssCM/K1W+hrqFUGRm0jj2MKzO8jm6LOsueXSd1JrAP
	 cIfnfav0JYM23uH+JOyhDIA2Lec09N8dph4wrems6pd4md9SPlL1WIhWAX1B6B7rgL
	 ENzkVvYIfpu7NYFMxMUQt/9mXq6aHkJ7sI/foV8XBoN1st4RVMkh1EW2lKyGKYKS1h
	 LIuhNtXsFjbdTed7Q2JTHYmedm1mBZrOhMeHysnjAaXCu/XaZxLEOikjJdP2yp8SWP
	 ilQXsXjMJiOwEXfBqO0hQSUCZXs6we2psCu776s6iMfVOqz1f29VK0uzrXtUKp6ms9
	 S5eVqpfIh4HfA==
Date: Fri, 9 Jan 2026 06:43:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: fixed_phy: replace list of fixed
 PHYs with static array
Message-ID: <20260109064349.22c71a09@kernel.org>
In-Reply-To: <1263a26d-a622-45d7-8043-262f2b92ed3b@gmail.com>
References: <e14f6119-9bf9-4e9d-8e14-a8cb884cbd5c@gmail.com>
	<20260108181102.4553d618@kernel.org>
	<1263a26d-a622-45d7-8043-262f2b92ed3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 12:00:41 +0100 Heiner Kallweit wrote:
> >> +static struct fixed_phy fmb_fixed_phys[NUM_FP];
> >>  static struct mii_bus *fmb_mii_bus;
> >> -static LIST_HEAD(fmb_phys);
> >> +static DEFINE_IDA(phy_fixed_ida);  
> > 
> > Isn't IDA an overkill for a range this tiny?
> > IDA is useful if the ID range is large and may be sparse.
> > Here a bitmap would suffice.
> 
> Thanks for the suggestion! The IDA has been there forever, just the definition
> has been moved now. I think switching to a bitmap is a good option.
> Can we handle this as a follow-up?

I see.. Still I think that deleting the IDA in the same patch makes
sense. IDA makes no sense for a small fixed-size array and we're
touching a number of the relevant lines, anyway.

