Return-Path: <netdev+bounces-131680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA898F3A3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1B21C21045
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753E11A704C;
	Thu,  3 Oct 2024 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HJSJYdPw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2019DF7A;
	Thu,  3 Oct 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971764; cv=none; b=OY04JXbxvcrPHvn/wJvszz5pZZ11W+ZoijNNZGtgF1t/2gF9UumgO6uvzgI9VIiKjUX5198ka5MYJu/LHsgfsze/AKCTRSWhJGrtozSOs/pDCmz3MV4dPwcNbuw3zAWr3JAyXIQLZaXGao1CD4Vioo2JSLnNk9zg/SK2Hk8GDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971764; c=relaxed/simple;
	bh=mMtQ+d8Z/E6jzlTUBvguZb7KfPusOH3k/0WA9rVkHME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGNysBK8h8XYG8vSsGBO6PeJ3Oz6KQT5jFS4/VsFxXEBUebphlrak8O10wFP0Pui9RPORacIcn5E2DlZbuThpf36Rd1C2PCvDTxcCvz5VXT4v9G4v7cAwzXvQoS0zKpgFG9xlgx3seRaNSxVSs9nPTHkWNErP1mQGevzXtaavL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HJSJYdPw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n/f04e4AS6VVsH1Hrd9Cs74Ab69EsLVheygIhN4I7DE=; b=HJSJYdPwPPNdFVTtAtfk10Lpsa
	N3r0brJ1yBMYw2BbXb7lf0MOyFF3eSHtMUUT7FsPrcXzOegTEotJ8IeUJ3IZHdTue66It6/vPjNNx
	DJh2VVbUng+DSxBtHQmnufmMlw+8YdOaZn2MrqkTWpFsKiuCiD4go/kaWlPagIUd4UrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swOOB-008xiZ-3e; Thu, 03 Oct 2024 18:09:15 +0200
Date: Thu, 3 Oct 2024 18:09:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, dirk.behme@de.bosch.com,
	aliceryhl@google.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com
Subject: Re: iopoll abstraction
Message-ID: <203e2439-4bba-4a0a-911b-79c81646a714@lunn.ch>
References: <76d6af29-f401-4031-94d9-f0dd33d44cad@de.bosch.com>
 <20241002.095636.680321517586867502.fujita.tomonori@gmail.com>
 <Zv6FkGIMoh6PTdKY@boqun-archlinux>
 <20241003.134518.2205814402977569500.fujita.tomonori@gmail.com>
 <Zv6pW3Mn6qxHxTGE@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6pW3Mn6qxHxTGE@boqun-archlinux>

> we cover all the cases, but this is a good starting point. I would put
> the function at kernel::io::poll, but that's my personal preference ;-)

iopoll.h has a few variants. The variant being implemented here can
only be used in thread context where it can sleep. There is also
read_poll_timeout_atomic() which can be used in atomic context, which
uses udelay() rather than sleeping, since you are not allowed to sleep
in atomic context.

So we should keep the naming open to allow for the atomic variant
sometime in the future.

We probably also want a comment that this helper cannot be used in
atomic context.

Do we have a Rust equivalent of might_sleep()?

https://elixir.bootlin.com/linux/v6.12-rc1/source/include/linux/kernel.h#L93

	Andrew

