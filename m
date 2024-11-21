Return-Path: <netdev+bounces-146639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF09D4CC9
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 13:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2359B1F222D5
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 12:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2A1D4324;
	Thu, 21 Nov 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MJxppw5O"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2B1369AA;
	Thu, 21 Nov 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192019; cv=none; b=td5QSDxq9syx6Uch5NZ4ChpNalWDSc/DaZTRmzDdEhyLsqJGcDfLQbeT5jU4y3PS5lHgkWVzYSXhxc3R/lRRI3OLCUNMkdz+1HgiH+iMN1+2PvoneKdkQBOcO0tLZEaMojzZmhYkfYQDshqu1IdvLSVUoGDrKg9DZ69lTlqFMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192019; c=relaxed/simple;
	bh=2ZAUB9oFIKeca/Er3zGkA4H3Im80Tb3YzhGT+cD8KRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jos6iMt2aEtzYZpUkp9OCfGo9fbcMeemfeOVLyOcdoSIyN37CYXvKk5d+QNZd11Rf/3svEf11zhrV3cy4QvVLpQN+acmwSN2jWinFBuXTNY91SlDnmymvRJ/yoJ59xNurkhAI2qjzJdudLYC4UqqwIV0BkXRQfpZa2peXmack0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MJxppw5O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vGBe/SlEslXNILO1hzzry37IwImQIs+IkYPc77D/ijM=; b=MJxppw5OlhKbZQOZGZBK02s8PP
	8AMMwszYzMOvIXrCx4v/y6u0zQYxO5akN5WHyv/S02DQQni1GQZH73DRaEmVYHts6ZXXxXwryTW22
	pqXNTGisrbxUl7WXha173KMLqEg95AUQkZsK6bewY6UlWMos6ZD7LPBnEoCKFQmSrVJxyQKkR6cHj
	OtfHO+rQ4SAjD48YNyyIpLRuhCgeQeJ+Zm7W6AKbQnCIg+x9+W4Rm1uX+0k3vYHCClG89/RqEUv8k
	txdyV2q7sQH7U+CDkRi/6IM7REtpEzK/PEwXhw8h1FQrUzGjtL1yH6bzk8rjPaKY5ZH8ZXtIT0+Uu
	/RVtnPJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36868)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tE6Gl-0007BA-3B;
	Thu, 21 Nov 2024 12:26:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tE6Gi-00082p-1X;
	Thu, 21 Nov 2024 12:26:44 +0000
Date: Thu, 21 Nov 2024 12:26:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Cong Yi <yicong.srfy@foxmail.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <Zz8nBN6Z8s7OZ7Fe@shell.armlinux.org.uk>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
 <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
 <20241121105044.rbjp2deo5orce3me@skbuf>
 <Zz8Xve4kmHgPx-od@shell.armlinux.org.uk>
 <20241121115230.u6s3frtwg25afdbg@skbuf>
 <Zz8jVmO82CHQe5jR@shell.armlinux.org.uk>
 <20241121121548.gcbkhw2aead5hae3@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121121548.gcbkhw2aead5hae3@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 21, 2024 at 02:15:48PM +0200, Vladimir Oltean wrote:
> On Thu, Nov 21, 2024 at 12:11:02PM +0000, Russell King (Oracle) wrote:
> > On Thu, Nov 21, 2024 at 01:52:30PM +0200, Vladimir Oltean wrote:
> > > I don't understand what's to defend about this, really.
> > 
> > It's not something I want to entertain right now. I have enough on my
> > plate without having patches like this to deal with. Maybe next year
> > I'll look at it, but not right now.
> 
> I can definitely understand the lack of time to deal with trivial
> matters, but I mean, it isn't as if ./scripts/get_maintainer.pl
> drivers/net/phy/phylink.c lists a single person...

Trivial patches have an impact beyond just reviewing the patch. They
can cause conflicts, causing work that's in progress to need extra
re-work.

I have the problems of in-band that I've been trying to address since
April. I have phylink EEE support that I've also been trying to move
forward. However, with everything that has happened this year (first,
a high priority work item, followed by holiday, followed by my eye
operations) I've only _just_ been able to get back to looking at these
issues... meanwhile I see that I'm now being asked for stuff about
stacked PHYs which is also going to impact phylink. Oh, and to top it
off, I've discovered that mainline is broken on my test platform
(IRQ crap) which I'm currently trying to debug what has been broken.
Meaning I'm not working on any phylink stuff right now because of
other people's breakage.

It's just been bit of crap after another after another.

Give me a sodding break.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

