Return-Path: <netdev+bounces-244495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4CDCB8F01
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5062A306479F
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7775217F2E;
	Fri, 12 Dec 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AYmbSJij"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349D4A3E;
	Fri, 12 Dec 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765548165; cv=none; b=l7bTVy02/fK7XjOXTD5uftV5ZmHNMkJHXCLh4CAJRBLiqd6vzDaeewn9k6sxocsdfHidlEOKeH4WKBTbzjQBNnoBRzwRwZ1praeSb1HRIs9QbkKoK1GXvB1MwrA7n5xAWmLEmvRzKMG60kfjlvrdr/jXbKi3AexqF48V5IAqtfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765548165; c=relaxed/simple;
	bh=CofGzLjN8qMHC+pP76AwXfyHHA0eVcgx52TmHlYEpbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fipVWxbKJQZNGbjikN2/eZYjR1y9pDsVIl5N5dfJvm6Uhodt9lOikIUTFN+VaA74AsbvoeriHqXC4vwPGN5DpFn5Oq609APsYxnsNvCFWRQsrqLDku7iF1M5ekosyEls8/jckF+HSETYqOmh0rtKiRvpCYFMbFClOtX70sE27x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AYmbSJij; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=txFCOMIAGimWIxvvu3BjEp0qYpTUu9SDSlRBdjU59uQ=; b=AYmbSJijSdotb9sfTLhbLEKadA
	1vTe2u5ZGsKNoHYYMN5wmuTCJ3LXDUDAfxbrS1lTn2SKL30RcE5QgwpRZ7CmYS07X+rCMFHwMpH5k
	NlPyEVD6IPSUGn8kI9u4eVkCSRU1FIR0+U4/hCm0l7EY0+kEvuGMIMLdM27EQPaiA5as=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vU3j6-00Gl04-RN; Fri, 12 Dec 2025 15:02:32 +0100
Date: Fri, 12 Dec 2025 15:02:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tuo Li <islituo@gmail.com>
Cc: klassert@kernel.org, andrew+netdev@lunn.ch,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	mingo@kernel.org, tglx@linutronix.de, netdev@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] net: 3com: 3c59x: Possible null-pointer dereferences
 caused by Compaq PCI BIOS32 problem
Message-ID: <166381e1-5287-414c-baa4-be371fe46e3f@lunn.ch>
References: <CADm8Tem-jtBmmOO9S6jW-jzffCqe7X_DpJcy25KRkyY9Tn+TZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADm8Tem-jtBmmOO9S6jW-jzffCqe7X_DpJcy25KRkyY9Tn+TZA@mail.gmail.com>

On Fri, Dec 12, 2025 at 03:52:01PM +0800, Tuo Li wrote:
> Hi,
> 
> I found a few potential null-pointer dereferences in vortex_probe1() in
> Linux 6.18.

You might want to look at the history of this driver. The last time
anybody seemed to really care about this driver was:

commit a6522c08987daa6f9ac25a9c08870041a43db6b0
Author: Neil Horman <nhorman@tuxdriver.com>
Date:   Thu Feb 25 13:02:50 2016 -0500

    3c59x: mask LAST_FRAG bit from length field in ring
    
    Recently, I fixed a bug in 3c59x:
    
    commit 6e144419e4da11a9a4977c8d899d7247d94ca338
    Author: Neil Horman <nhorman@tuxdriver.com>
    Date:   Wed Jan 13 12:43:54 2016 -0500
    
        3c59x: fix another page map/single unmap imbalance
    
    Which correctly rebalanced dma mapping and unmapping types.  Unfortunately it
    introduced a new bug which causes oopses on older systems.

Everything since then has been tree wide changes.

> It looks like these issues stem from the call at line 987 used as a
> workaround for the Compaq PCI BIOS32 problem:

Also, maybe do some research into "Compaq PCI BIOS32". I _think_ that
was from the time of the 80386? Maybe 80486? Support for those
processors has been dropped, so i don't think it is even possible to
boot such a machine to invoke this possible NULL pointer dereference.

Please do some sanity checking before reporting potential issues. I
_think_ you are wasting your own time, and valuable Maintainer time.

	Andrew

