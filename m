Return-Path: <netdev+bounces-137039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4279A4120
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4FEB238F5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A11EE020;
	Fri, 18 Oct 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="atABMoY+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B413AD39;
	Fri, 18 Oct 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261631; cv=none; b=VB3yJRkBi4idLvRUxvwZn9OfB6OZod+Li6KXFGP1HFgalSCWnn4m2dxqK3Vq9DT67SPcbQXWsO/et1mZqPcuRu8mEZvmRJr9UeD2SyN57a/8cqI3aiAyOdy6AhDXYaUNUeZz/CMJo+qTzWznxNdmwV+CSacM5e6ka/A+S4m4ypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261631; c=relaxed/simple;
	bh=pxYLz1RLjE1S9oxnCoEnnIw6FDWonp8MSx9mKjd1oww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pegn9pJ891B2IkUFb8/5CWluvOzh+CxT/sg9z6d+VdJzmd6JKV/Yvb3Ok1If+oswPgKGkoPXwnOBUPWQqaI2GkqkcHTuu4Lh+i7FUsx6upyz33g+ISot6bDNNDJpujqu3kwjevBCNtrC61jp38nsDPIkijFnVL2wY3zCq/aSGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=atABMoY+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G19Hg8C0DXlvtqEvbXiqc1qmbOu0MwLuYwanivdXEiY=; b=atABMoY+N4SDh4/9avcaaVycM1
	NRYX+1bIufbct+LtdPicg07znyY2clCum3121mRqDKdEseqKKQnWoq7YYZKHOnKmPFlXI9XYSFxM3
	pUDLM41UfKrXYt2o7F4of7RCo2a1UuGBwWsts3kreoxBkXrbe3xxpJdP4tTNnAv1Tq0k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1nwM-00AXlT-92; Fri, 18 Oct 2024 16:26:54 +0200
Date: Fri, 18 Oct 2024 16:26:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/8] rust: Add IO polling
Message-ID: <8dfee5f3-98f6-4b84-8da7-0bf4c61bae24@lunn.ch>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016035214.2229-1-fujita.tomonori@gmail.com>

On Wed, Oct 16, 2024 at 12:52:05PM +0900, FUJITA Tomonori wrote:
> polls periodically until a condition is met or a timeout is reached.
> By using the function, the 8th patch fixes QT2025 PHY driver to sleep
> until the hardware becomes ready.
> 
> As a result of the past discussion, this introduces a new type
> representing a span of time instead of using core::time::Duration or
> time::Ktime.
> 
> Unlike the old rust branch, This adds a wrapper for fsleep() instead
> of msleep(). fsleep() automatically chooses the best sleep method
> based on a duration.

This patchset is > 95% time handling, and only a small part
networking. So i'm not sure netdev is the correct subsystem to merge
this.

I can give an Acked-by for the last patch, and i don't expect any
merge conflicts.

    Andrew

---
pw-bot: cr

