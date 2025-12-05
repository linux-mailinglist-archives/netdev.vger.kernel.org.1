Return-Path: <netdev+bounces-243813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76558CA7DA8
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 14:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C271C3020076
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550FF32E735;
	Fri,  5 Dec 2025 13:57:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE32D0615;
	Fri,  5 Dec 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943020; cv=none; b=CguMsaGxsBXknVX5I3Kx0gW6XZmY1+9TqngiX03AbzgL6k2OOACwyKvZ64N1/7H0L5ubeUb78qotzIayn4uXHkNdC1iOBbPl1EeRNvjvTx2l1gCBqYwppfThSKGStM+0ikiPekVH7V++EEOyJ+Cd3lDUFC0hFASmTa9OYuaRABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943020; c=relaxed/simple;
	bh=4vK8RvSUu+HXFJGIIiwMijQir3CuNO9sYtLER/WeW9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUae6Q2uSkTCEovd6wGeSAPcO+hwWkdqMYqyoM91rx3S4uvCFbdzC0YFQzu9cm8E02UoInr3AERWhAWea5QQrpn6tz/7X2NfCYjSgIY+s8RO6AT5DRaNT4hVN/ElJ12fwtCoc21UFX0zgXjC1s5J3dct1jlsjNT7sCGN0ZiN+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vRWIg-000000005gG-3xQH;
	Fri, 05 Dec 2025 13:56:47 +0000
Date: Fri, 5 Dec 2025 13:56:39 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mxl-gsw1xx: manually clear RANEG bit
Message-ID: <aTLkl0Zey4u4P8x6@makrotopia.org>
References: <ab836f5d36e3f00cd8e2fb3e647b7204b5b6c990.1764898074.git.daniel@makrotopia.org>
 <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97389f24-d900-4ff0-8a80-f75e44163499@lunn.ch>

On Fri, Dec 05, 2025 at 02:45:35PM +0100, Andrew Lunn wrote:
> On Fri, Dec 05, 2025 at 01:32:20AM +0000, Daniel Golle wrote:
> > Despite being documented as self-clearing, the RANEG bit sometimes
> > remains set, preventing auto-negotiation from happening.
> > 
> > Manually clear the RANEG bit after 10ms as advised by MaxLinear, using
> > delayed_work emulating the asynchronous self-clearing behavior.
> 
> Maybe add some text why the complexity of delayed work is used, rather
> than just a msleep(10)?
> 
> Calling regmap_read_poll_timeout() to see if it clears itself could
> optimise this, and still be simpler.

Is the restart_an() operation allowed to sleep? Looking at other
drivers I only ever see that it sets a self-clearing AN RESTART bit,
never waiting for that bit to clear. Hence I wanted to immitate
that behavior by clearing the bit asynchronously. If that's not needed
and msleep(10) or usleep_range(10000, 20000) can be used instead that'd
be much easier, of course.

