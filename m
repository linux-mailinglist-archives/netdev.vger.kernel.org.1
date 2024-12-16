Return-Path: <netdev+bounces-152415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995EF9F3E0A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 00:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCC416BCB5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1088C1D5CDE;
	Mon, 16 Dec 2024 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tij3HmyY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C5653;
	Mon, 16 Dec 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390610; cv=none; b=WPPZUvYtfTyAnpQvl9wP3SU15eGl+WeK2Ra5iVFc55UOnPM/BQ6KXpRn3RvdVCHro2TG0LZRnWkXAdkR49SxcHLRBqxbdq357vx+6TDfwb1HL7S1J75TS4kToaAKPs4zT/gHHflp7LafNPOUCjRMesbrJMF6iRh2CleX+iGdT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390610; c=relaxed/simple;
	bh=QlBcCsa9rqJa3IlOgPtbSnLtN0HKwL8f0kCn9NHOeGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kq/DHg/qQdL8YNLCqLscqEEEFn6LH9216UpCvn37Kd4/BZMwqcUmVOmWQPP90J40nZniW/ED/WM0wAj16RUY0DW4R4CyJgiaWIZ3F2UAWJ77fCy7JpRqTLBy16yy5B87JIU1j5WtqKQqR3yWzE33QSfvGOojGcLDXm2+pxzsBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tij3HmyY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O7ayzBDb1owGXw4wlr8s6CWivxZSkqrBGT0EtZZfKbY=; b=Tij3HmyYrJ9F5EYjUB0Rw8xTiQ
	OlpXytZy26ZrPaiQAL398NSbmHY7KZRmBTzcxJkP/pERsD1upSaJ0hAznPtaYpdL++eezJgcBgsNO
	iJbj+C7J+lvcWgzSWJR0lLekmBI83eSb5Ol2fwufUsF+x+uqohVyVroCbebpgkaXMXao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNKCp-000ljk-HK; Tue, 17 Dec 2024 00:08:51 +0100
Date: Tue, 17 Dec 2024 00:08:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: qca8k: Fix inconsistent use of
 jiffies vs milliseconds
Message-ID: <6f1c3d1f-8059-4038-bc2c-5729254a5b38@lunn.ch>
References: <20241215-qca8k-jiffies-v1-1-5a4d313c76ea@lunn.ch>
 <20241215231334.imva5oorpyq7lavl@skbuf>
 <87195b12-6dfa-4778-b0c0-39f3a64a399e@lunn.ch>
 <676085a7.050a0220.1e6031.2193@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676085a7.050a0220.1e6031.2193@mx.google.com>

On Mon, Dec 16, 2024 at 08:55:13PM +0100, Christian Marangi wrote:
> On Mon, Dec 16, 2024 at 10:21:12AM +0100, Andrew Lunn wrote:
> > On Mon, Dec 16, 2024 at 01:13:34AM +0200, Vladimir Oltean wrote:
> > > On Sun, Dec 15, 2024 at 05:43:55PM +0000, Andrew Lunn wrote:
> > > > wait_for_complete_timeout() expects a timeout in jiffies. With the
> > > > driver, some call sites converted QCA8K_ETHERNET_TIMEOUT to jiffies,
> > > > others did not. Make the code consistent by changes the #define to
> > > > include a call to msecs_to_jiffies, and remove all other calls to
> > > > msecs_to_jiffies.
> > > > 
> > > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > > ---
> > > 
> > > If my calculations are correct, for CONFIG_HZ=100, 5 jiffies last 50 ms.
> > > So, assuming that configuration, the patch would be _decreasing_ the timeout
> > > from 50 ms to 5 ms. The change should be tested to confirm it's enough.
> > > Christian, could you do that?
> > 
> > I've have an qca8k system now, and have tested this patch. However, a
> > Tested-by: from Christian would be very welcome.
> >
> 
> Hi need 1-2 days to test this, hope that is O.K.

That is fine, I don't really expect the remaining patches will go
anywhere until next year, with net-next closing soon.

	Andrew

