Return-Path: <netdev+bounces-168919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F781A418A3
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5949D1898B08
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14D24502C;
	Mon, 24 Feb 2025 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k2mfxxUs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932D24501A
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388181; cv=none; b=UmGt8V8exWMFZnrsSi9u3n9RWqmwiiEHgYUjbko1G8jkv4mvFFTri4VNoGRcVfvMkMMNfoXb70UnqooPBEZNrFQVnj9McuhzZd4ugU7MzEqHd7bYbh8AZdH7LKQB4xs2NKGjzmjPT7P0ee6eBu7LH2YB1PnxnFWLdSM6Gjr+1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388181; c=relaxed/simple;
	bh=swRtZW74gLP0QkyAEAJcViyXMZk7ZNDdNaOjhBJmf2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISa0aJBg/T+VRvs7EvtwD0Hh2DjrVxrVV89AQsAHEwTYXygM89dSzgXK+peX+LEUQYvdTXqtbqEM0gobDUoofMpkaisSBrKwLhYeSITRYcsUD1eZ7syMayMSogtcF2MmwBNDxMxs4KySDnpiFvdxCYXzsRtk71DwfyCawFBqftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k2mfxxUs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pTALlKbSKJ0pfCW0bKggFYFpg7EFYynYFxwssKh+C9Q=; b=k2mfxxUsJMg20o414L508A20Sz
	IsMmCXwHj9Pve7EakuteAeW2Mijmx7tgNQvJFjEMhorcIp13CSNZUzKt7Sw/+drbSmQypPhFIjkzH
	zSL/HW3fMprv+bGoQucs7FWZUZLr/RMkNONqdbRoDhV5EI89H9aB0fCgWH5dUQcANxgEmiOVsLKAz
	Tysehk9IQp3OMgJLLqPeUuhrLaLXDkHr36NrY34n0hTZqRyIN8OlWEoVVqktJ84ZrUAnZHGM2puSo
	h+If2Gf1Ilku7oFCtXW2jEi1cWQQod7w61T/fqr2D7bPOCjw2noB8r+UstUy4m8wsDIb5gDNbE7V+
	gJemzfpw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53832)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmUSs-0005bT-1N;
	Mon, 24 Feb 2025 09:09:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmUSo-0004sM-28;
	Mon, 24 Feb 2025 09:09:22 +0000
Date: Mon, 24 Feb 2025 09:09:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Joe Perches <joe@perches.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <drew@pdp7.com>, Eric Dumazet <edumazet@google.com>,
	Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/2] net: stmmac: thead: clean up clock rate
 setting
Message-ID: <Z7w3QhcYhrzQk_5K@shell.armlinux.org.uk>
References: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
 <Z7sJHuiqbr4GU05c@shell.armlinux.org.uk>
 <7bf9577f4b6dcb818785be73c175bcd19b3b4f0c.camel@perches.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf9577f4b6dcb818785be73c175bcd19b3b4f0c.camel@perches.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 23, 2025 at 06:33:44AM -0800, Joe Perches wrote:
> On Sun, 2025-02-23 at 11:40 +0000, Russell King (Oracle) wrote:
> > Adding Joe Perches.
> > 
> > On Fri, Feb 21, 2025 at 02:15:17PM +0000, Russell King (Oracle) wrote:
> []
> > I've been investigating why the NIPA bot complains about maintainers
> > not being Cc'd, such as for patch 1 of this series:
> > 
> > https://netdev.bots.linux.dev/static/nipa/936447/13985595/cc_maintainers/stdout
> 
> Additional maintainers added or missing?

Let me be clear - NIPA is not something under my control. It is a bot
run by Jakub on netdev patches that are received by patchwork - so
patches that have been emailed out, and thus contain at least the
To:, Cc: and Subject: header lines, possibly all header lines that
have been added such as Received: etc. I don't know what it actually
does.

Now let me restate the problem, because the answer to your question
is in the problem description. Here's the short version:

	K: entries match email headers.

Here's the long version:

If one runs get_maintainers.pl on a patch produced from git, it
comes out with a list of maintainers. In the case of dwmac-thead.c,
this includes an email address that contains "riscv".

If one adds this list of maintainers to email headers in the patch
prior to sending it out and then re-runs get_maintainers.pl on it,
or if one receives the patch after it having been emailed out, and
then runs get_maintainers.pl to validate that all appropriate
maintainers were sent a copy of the patch, then get_maintainers.pl
comes out with *extra* *additional* maintainers because the "K: riscv"
line matches *email* *headers*.

In this exact case of dwmac-thead.c, the first run prior to sending
out reports an email address containing "riscv". On these subsequent
runs with the maintainers added to email headers, the presence of
"K: riscv" in MAINTAINERS causes get_maintainers.pl to report the
three maintains for the "RISCV ARCHITECTURE" entry.

This is an issue for you as get_maintainers.pl maintainer and Jakub
as NIPA bot author to hash out - either get_maintainers.pl is
acting incorrectly and needs to be fixed, or NIPA is abusing
get_maintainers.pl in a way that it's not designed to be used.

I'm merely an observer of this behaviour and am merely reporting the
problem - that NIPA's cc_maintainers claim that maintainers were not
copied in my patch submission is incorrect and I've done the research
to identify _why_ it's incorrect. It's now up to you two to decide
where the problem lies and what the solution should be.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

