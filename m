Return-Path: <netdev+bounces-146504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F559D3CAA
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76BA2B21A58
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6C41A7274;
	Wed, 20 Nov 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dwQ/7DzW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDF174EDB;
	Wed, 20 Nov 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110280; cv=none; b=FWd+JDQpkcfGVZwYZGqkZVWAqo8PnVyFGX9F+agDvVd2s9TRNq/CtJP4G0bycUIrH01RwFBIW+A7gUCxLwsN1p4IAz0ZNgWkkDeTLzkocZklYyTaoOlrRd377kw2Xt/FLi9wn7XII+XD9qpoY8HvF+NLGLNi6eKEMqnespkr2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110280; c=relaxed/simple;
	bh=C2rql73uLMURyIBEH7UxHHjPWEFZgEpKP8fm9VyTVwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXRymbEgHC2R5kTBKHF6XbOEczb/dxC2VHxrjIoBu+33N1IFSGIiVOQCEfFosUdxEL5Q9BczNmSZWjH6P291z2SlNShyz6iFYdqNCdD1BtIbO80gw/pZ5kDDVCApV3VaNbKDKbMjB7XhAxNQlsj/jZq724nC8Pj8wgCX2TB0S5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dwQ/7DzW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vwDPiYIBxwEmAaxai1DgMFwF8LB6iOUHjsbt/QR1yko=; b=dwQ/7DzWt63C6SmfRoK5OrKV1l
	jRvx7JKVfjETzd8RbU+63a98l6A5iM/YrQfGnE+V3inVGUYSkESBNpTPj2Ig8sYuN1yDBXsL9ck6L
	8ILcrrEBhA5M3tzqu6J9pbDVSrda9UiViBg6CDjvGe5SID+sFJDX2PtAzet4YPzlLJNw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDkzw-00DxOS-NA; Wed, 20 Nov 2024 14:44:00 +0100
Date: Wed, 20 Nov 2024 14:44:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, joel@jms.id.au,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire control
Message-ID: <b6155c5f-3012-42d1-90dc-8ef39d1eef2d@lunn.ch>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
 <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28177c9152408d77840992f2b76efe3cb675b7a.camel@codeconstruct.com.au>

On Wed, Nov 20, 2024 at 03:13:11PM +1030, Andrew Jeffery wrote:
> On Tue, 2024-11-19 at 17:51 +0800, Jacky Chou wrote:
> > When the command bus is sometimes busy, it may cause the command is
> > not
> > arrived to MDIO controller immediately. On software, the driver
> > issues a
> > write command to the command bus does not wait for command complete
> > and
> > it returned back to code immediately. But a read command will wait
> > for
> > the data back, once a read command was back indicates the previous
> > write
> > command had arrived to controller.
> > Add a dummy read to ensure triggering mdio controller before starting
> > polling the status of mdio controller to avoid polling unexpected
> > timeout.
> 
> Why use the explicit dummy read rather than adjust the poll interval or
> duration? I still don't think that's been adequately explained given
> the hardware-clear of the fire bit on completion, which is what we're
> polling for.

I'm guessing here, but if the hardware has not received the write, the
read could return an indication that the hardware is idle, and so the
poll exits immediately. The returned value of the first read need to
be ignored. It is simpler and more reliable to do that with an
explicit read, rather than try to play with the poll timing.

AS i said, a guess. We need a good commit message explaining the
reality of what is happening here.

	Andrew

