Return-Path: <netdev+bounces-179230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8227A7B59C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 03:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BA5179222
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167818AFC;
	Fri,  4 Apr 2025 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZNOlzVJ6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F783597E
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743731175; cv=none; b=k6rtbEvhGeIBmjdRvWuLjjRVGPlI4zfv5pasUE9Dbt+273sd35zgNOOm/WDZwg+L4bEvFfx99x86qDiLlKIA8YdPxAK7e+LyBsLx2rQZ7AiZPtKAlLPo9riio8gq2uKB929zDqjBy/9f0gaivueouqFSDcqsX9L6pc2fCpHytiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743731175; c=relaxed/simple;
	bh=xkkDx7iyHzZ/tIrtN7VXg6ZtIAEK6cdcyNBbV2w/5o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9u3LoivSb7D4UTKqsbOR2Nk7SZDjH6SkRAbJkTxs3RSdtLEroj89jLIxgcduhdM0hu5+PXCJfc+GCfml/S63kblGEWeDey6T3G/uAZObgNcPcrg15uvKdmKOFgSX2K4u67rDVCpOZeFY/8tkA7F9mM897gUPZOd0xzAdtlxv5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZNOlzVJ6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4JRMF1f6p2ll7QRTx7nPtzee8RBok98HTB9tLZ0OZ0M=; b=ZNOlzVJ6MtrXoj7vmJa4F/8nFs
	lffb8H8wHp0W/E+A4FIK6Dg8EXL+Yjj9t1Jb1zEHzg+qEtnsTxgxMF6BvfcOdfuw+9PDsAx8OzOWQ
	SKUFk5gLmKFl6N6nQiugGJIbjbSa7KWDgOIgJ5KRGCY4r16Qx7QaamS4Julk9hkXIWmY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u0W89-0080to-9v; Fri, 04 Apr 2025 03:46:01 +0200
Date: Fri, 4 Apr 2025 03:46:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <8acfd058-5baf-4a34-9868-a698f877ea08@lunn.ch>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8ZFzlAl1zys63e@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-8ZFzlAl1zys63e@shell.armlinux.org.uk>

On Fri, Apr 04, 2025 at 12:26:15AM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 03, 2025 at 02:53:22PM -0700, Alexander Duyck wrote:
> > How is it not a fixed link? If anything it was going to be more fixed
> > than what you described above.
> 
> I had to laugh at this. Really. I don't think you quite understand the
> case that Andrew was referring to.
> 
> While he said MAC to MAC, he's not just referring to two MACs that
> software can program to operate at any speed, thus achieving a link
> without autoneg. He is also talking about cases where one end is
> fixed e.g. by pinstrapping to a specific configuration including
> speed, and using anything different on the host MAC side results in
> no link.

Yep, this is pretty typical of SOHO switches, you use strapping to set
the port, and it never changes, at least not without a soldering iron
to take off/add resistors. There are also some SOHO switches which
have a dedicated 'cpu port' and there is no configuration options at
all. The CPU MAC must conform to what the switch MAC is doing.

> In that latter case, I don't think you could come up with something
> that is "more fixed" than that, because using anything other than
> the specified parameters means no link!

Well, you could maybe use the wrong duplex, and get link with all the
collision problems we had back in what the 90s? 00s?

	Andrew

