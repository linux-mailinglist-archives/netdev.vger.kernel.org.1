Return-Path: <netdev+bounces-49031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528347F073E
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD31C2037A
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CEE11CB4;
	Sun, 19 Nov 2023 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u0wKdjaE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB597D8;
	Sun, 19 Nov 2023 07:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BrFjk1O06Djb+g7yO9ZoZAhKKoqCsxrQIL6sYYG8A34=; b=u0wKdjaE1JGEA1CTCqJzgl6eVs
	uNVW2PhbQEqnNtan5xFB4564+eELR7spYOcog/fhMsnmbI1NMBPwQo8M6wNGp0HY3untrZITysOqx
	tfwD7bG4y1G8IdCwRqa4u41l4/uNAcK+O13I5prR1qr4QHY5JZ+WfJFYsXTuDOlO1grU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4k4A-000ZPq-Sn; Sun, 19 Nov 2023 16:50:34 +0100
Date: Sun, 19 Nov 2023 16:50:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, boqun.feng@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
Message-ID: <8f7a7fe0-bfd3-4062-9b55-c1e18de2818a@lunn.ch>
References: <ZVfncj5R9-8aU7vB@boqun-archlinux>
 <66455d50-9a3c-4b5c-ba2c-5188dae247a9@lunn.ch>
 <7f300ba1-44e1-4a98-9289-a53928204aa7@proton.me>
 <20231119.182544.2069714044528296795.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119.182544.2069714044528296795.fujita.tomonori@gmail.com>

On Sun, Nov 19, 2023 at 06:25:44PM +0900, FUJITA Tomonori wrote:
> On Fri, 17 Nov 2023 23:01:58 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
> 
> > On 11/17/23 23:54, Andrew Lunn wrote:
> >> Each kernel module should be in its own symbol name space. The only
> >> symbols which are visible outside of the module are those exported
> >> using EXPORT_SYMBOL_GPL() or EXPORT_SYMBOL(). A PHY driver does not
> >> export anything, in general.
> >> 
> >> Being built in also does not change this.
> >> 
> >> Neither drivers/net/phy/ax88796b_rust.o nor
> >> rust/doctests_kernel_generated.o should have exported this symbol.
> >> 
> >> I've no idea how this actually works, i guess there are multiple
> >> passes through the linker? Maybe once to resolve symbols across object
> >> files within a module. Normal global symbols are then made local,
> >> leaving only those exported with EXPORT_SYMBOL_GPL() or
> >> EXPORT_SYMBOL()? A second pass through linker then links all the
> >> exported symbols thorough the kernel?
> > 
> > I brought this issue up in [1], but I was a bit confused by your last
> > reply there, as I have no idea how the `EXPORT_SYMBOL` macros work.
> > 
> > IIRC on the Rust side all public items are automatically GPL exported.
> 
> Hmm, they are public but doesn't look like exported by EXPORT_SYMBOL()
> or EXPORT_SYMBOL_GPL().

Do they need to be public? Generally, a PHY driver does not export
anything. So you can probably make them private. We just however need
to ensure the compiler/linker does not think they are unused, so
throws them away.

I would however like to get an understanding how EXPORT_SYMBOL* is
supposed to work in rust. Can it really be hidden away? Or should
methods be explicitly marked like C code? What is the Rust equivalent
of the three levels of symbol scope we have in C?

	Andrew

