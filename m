Return-Path: <netdev+bounces-57271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91989812B95
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14C5B210C5
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDC12E62C;
	Thu, 14 Dec 2023 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y2BSebg/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114CA6;
	Thu, 14 Dec 2023 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g+AbAvvUAcxOgP2sxiYrFEiKXBjFY3Ekd98W6+K77c0=; b=y2BSebg/CLwuP5JHyWJrCzKot0
	cZSyNtUeCI/PwUn62FpwvHMLHny8oA+ji8toNDHu2cWNS6ZtqQOv9BpkmXeuGDOF+N5UTRxthiTSE
	JCc1cnVG797LYwed7r+wE9uV/+0kgo+HTbEP7l2Lci5RM6dIMIjHPdEzgtfekgmUOKrU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDhzI-002u7t-L7; Thu, 14 Dec 2023 10:26:36 +0100
Date: Thu, 14 Dec 2023 10:26:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <b2cba04e-0201-48b7-a34f-81dbd7b799ff@lunn.ch>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux>
 <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
 <ZXfFzKYMxBt7OhrM@boqun-archlinux>
 <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
 <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
 <67da9a6a-b0eb-470c-ae43-65cf313051b3@lunn.ch>
 <ZXnfHbKE3K_J4yul@Boquns-Mac-mini.home>
 <83511ed4-1fbe-4cf6-ba63-5f7e638ea2a1@lunn.ch>
 <66c532cf-e56f-4364-94dd-c740f9dfdf69@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c532cf-e56f-4364-94dd-c740f9dfdf69@proton.me>

On Wed, Dec 13, 2023 at 11:40:26PM +0000, Benno Lossin wrote:
> On 12/13/23 22:48, Andrew Lunn wrote:
> >> Well, a safety comment is a basic part of Rust, which identifies the
> >> safe/unsafe boundary (i.e. where the code could go wrong in memory
> >> safety) and without that, the code will be just using Rust syntax and
> >> grammar. Honestly, if one doesn't try hard to identify the safe/unsafe
> >> boundaries, why do they try to use Rust? Unsafe Rust is harder to write
> >> than C, and safe Rust is pointless without a clear safe/unsafe boundary.
> >> Plus the syntax is not liked by anyone last time I heard ;-)
> > 
> > Maybe comments are the wrong format for this? Maybe it should be a
> > formal language? It could then be compiled into an executable form and
> > tested? It won't show it is complete, but it would at least show it is
> > correct/incorrect description of the assumptions. For normal builds it
> > would not be included in the final binary, but maybe debug or formal
> > verification builds it would be included?
> 
> That is an interesting suggestion, do you have any specific tools in
> mind?

Sorry, no. I've no experience in this field at all. But given the
discussions this patch has caused, simply a list of C or Rust
expressions which evaluate to True when an assumption is correct would
be a good start.

We have said that we assume the phydev->lock is held. That is easy to
express in code. We have said that phydev->mdio must be set, which is
again easy to express. phydev->mdio.addr must be in the range
0..PHY_MAX_ADDR, etc.

You probably cannot express all the safety requirements this way, but
the set you can describe should be easy to understand and also
unambiguous, since it is code. The rest still can be as comments.  It
would be easy to compile this code and insert it before the function
on a verification build. Its only runtime checking, but its more
functional than comments which the compiler just throws away. And
maybe subsystems like this which are pretty much always slow path
might even leave them enabled all the time, to act as a set of
assert()s, which you sometimes see in code bases.

	Andrew

