Return-Path: <netdev+bounces-132061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45C3990491
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FAF285BDB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EAA20FAB8;
	Fri,  4 Oct 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PptLQ4kE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7915B97E;
	Fri,  4 Oct 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049084; cv=none; b=rDs/DwNqyufasd54d9A6J9LcdWDGSg9Hbq1RDZoCUHLa85InCq+yeeQSIGOWapvi4IQtVZ24DGSSLLoZT/APc68tO99AtkZ0fUAFxRYiGoIz41Z10uhn6Aa5SJg4DK5q9cJ7bzjFd/a26o0hS+/6HrVn42+RrNAXz2KoxYh8h20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049084; c=relaxed/simple;
	bh=SAv6tE5uobJ/ari3PuahIRMNPmjDcarA8K3D8CHdFh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITEIOgHPnaZacqm/2tLUyJoT/Z7jlU9L9Kcvbv3kG4/LLYsMG3uFWKWw7kvvCkS2w98bBGKZp0oXQxmt9TYlbFuUff+9qjEdHm3VpVID9SN/4Qf18eFKf4IZhQ015iJYskpwiL352RtWQ6bTKeO/+G18WV/lIlLWuljzsQE4IYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PptLQ4kE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WfuOri6Xulcam+GOkQMwfbcVmN85Q+p2dGxMABOyHw4=; b=PptLQ4kE594fyVPFXXQ6CHrs2p
	x1leUj0XMb/Fo1Poh1k4zCPWCpmE84pkaMUh5Gg3P7HIZ2FY+jyzkrncKIds9e9LRR6yzLOfH6GCU
	SH7T3enaeCohiDygwNx1H/CVbHnLxxnPEqtxn9iZRJjBCv1bd66/7kfPtfin8AVROyKI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swiVJ-00935M-Dr; Fri, 04 Oct 2024 15:37:57 +0200
Date: Fri, 4 Oct 2024 15:37:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, dirk.behme@de.bosch.com, aliceryhl@google.com,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: iopoll abstraction
Message-ID: <d2351ed1-c77c-4a2c-a0ed-d23d9bcc388a@lunn.ch>
References: <20241003.134518.2205814402977569500.fujita.tomonori@gmail.com>
 <Zv6pW3Mn6qxHxTGE@boqun-archlinux>
 <203e2439-4bba-4a0a-911b-79c81646a714@lunn.ch>
 <20241004.204803.2223000488444244418.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004.204803.2223000488444244418.fujita.tomonori@gmail.com>

On Fri, Oct 04, 2024 at 08:48:03PM +0900, FUJITA Tomonori wrote:
> On Thu, 3 Oct 2024 18:09:15 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > We probably also want a comment that this helper cannot be used in
> > atomic context.
> 
> Yeah, I'll add such.
> 
> > Do we have a Rust equivalent of might_sleep()?
> > 
> > https://elixir.bootlin.com/linux/v6.12-rc1/source/include/linux/kernel.h#L93
> 
> No. I'll add bindings for might_sleep() and cpu_relax().

Please make sure you involve the scheduler people. This is now well
outside of networking, same as the discussion around time has little
to do with networking.

The might_sleep() is not a strong requirement for iopoll, so you might
want to get the basic functionality merged first, and then once
might_sleep() is agreed on, add it to iopoll. It is just a debug
feature.

	Andrew

