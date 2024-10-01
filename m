Return-Path: <netdev+bounces-130866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81A98BC99
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781341F22A4D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA531BFDF4;
	Tue,  1 Oct 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H3LTY+kl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4219D09C;
	Tue,  1 Oct 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786891; cv=none; b=uCGuTur52rWsLyEnNhoKOFXKzZWAU+HqpH11df1YnUAC40szPcDsF/XXtB/g/Cwfpx80s/V0p8Q/Ql9iaCKW9lZLPC2qVsI+oajAdf3NwD0fWErLZo8t8gDlzQAC4VjARbWRC/ms5mzvnD+P1dga+dj+e4qsYdW922oz46g1oQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786891; c=relaxed/simple;
	bh=JH7cHNSRABQXCP4CAPkjoQEVAXJ+qv07qiUqMegKvEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF0v62+abaOw2Tcqb785TB+21UiCR+R3cyPC/+divw8pTtwYco0Ki1EdJ5WfHJvzMLoC6wn1jEC0tarAIiIZ21cKq4DjSIAqhKXOqvmJXSByCQBJkrkesVupfKD2BdKkiRrp7ardA2EmbWDwLzIMfTcrJrjTbvraPgY5ieNnIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H3LTY+kl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ghJ1nxQ6dj56QeX/+sROb0R1OloDY0fqeyOidJftYdE=; b=H3
	LTY+klO7LM4kbJKGYcUhjrasQI53dH9+ao0zAPxjl7JV9i0D50G8BUv8+WsymQPaRQAw7ViUeDYk5
	2BNWoqNesoZyLbtmpwM5v2Q3vI0/9DkMukE1LxyjMozwZgLc4mex2mz8DX/actKONSKRtK0bemgHy
	c4n2KR7NGdVL1ag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svcIQ-008jFg-1j; Tue, 01 Oct 2024 14:48:06 +0200
Date: Tue, 1 Oct 2024 14:48:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 2/2] net: phy: qt2025: wait until PHY becomes
 ready
Message-ID: <c8ba40d3-0a18-4fb4-9ca3-d6cee6872712@lunn.ch>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
 <20241001112512.4861-3-fujita.tomonori@gmail.com>
 <CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>

On Tue, Oct 01, 2024 at 01:36:41PM +0200, Alice Ryhl wrote:
> On Tue, Oct 1, 2024 at 1:27 PM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > Wait until a PHY becomes ready in the probe callback by using a sleep
> > function.
> >
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > ---
> >  drivers/net/phy/qt2025.rs | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
> > index 28d8981f410b..3a8ef9f73642 100644
> > --- a/drivers/net/phy/qt2025.rs
> > +++ b/drivers/net/phy/qt2025.rs
> > @@ -93,8 +93,15 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
> >          // The micro-controller will start running from SRAM.
> >          dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
> >
> > -        // TODO: sleep here until the hw becomes ready.
> > -        Ok(())
> > +        // sleep here until the hw becomes ready.
> > +        for _ in 0..60 {
> > +            kernel::delay::sleep(core::time::Duration::from_millis(50));
> > +            let val = dev.read(C45::new(Mmd::PCS, 0xd7fd))?;
> > +            if val != 0x00 && val != 0x10 {
> > +                return Ok(());
> > +            }
> 
> Why not place the sleep after this check? That way, we don't need to
> sleep if the check succeeds immediately.

Nice, you just made my point :-)

I generally point developers at iopoll.h, because developers nearly
always get this sort of polling for something to happen wrong. 

The kernel sleep functions guarantee the minimum sleep time. They say
nothing about the maximum sleep time. You can ask it to sleep for 1ms,
and in reality, due to something stealing the CPU and not being RT
friendly, it actually sleeps for 10ms. This extra long sleep time
blows straight past your timeout, if you have a time based timeout.
What most developers do is after the sleep() returns they check to see
if the timeout has been reached and then exit with -ETIMEDOUT. They
don't check the state of the hardware, which given its had a long time
to do its thing, probably is now in a good state. But the function
returns -ETIMEDOUT.

There should always be a check of the hardware state after the sleep,
in order to determine ETIMEDOUT vs 0.

As i said, most C developers get this wrong. So i don't really see why
Rust developers also will not get this wrong. So i like to discourage
this sort of code, and have Rust implementations of iopoll.h.

	Andrew

