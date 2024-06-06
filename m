Return-Path: <netdev+bounces-101512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EC88FF23C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AFD1C26058
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0837519885E;
	Thu,  6 Jun 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jJC88ykM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C3196D8C;
	Thu,  6 Jun 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690508; cv=none; b=DoDsC2yAscX+TI0KkKzcgkP6ETo0tBcIdBEyzadeHC/4xr0lbjkOX+pqFJ7JL2la7+/6YRrCa8CULG+Q1Johv1qMJymcsoyRMztf7ILy1uZbCQeYrAnZ6TB3vxTcuN7lSize+ZC6I8RE6PUBBd7ZIqaQ3Nq/5Vc7lsZhgSp3kks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690508; c=relaxed/simple;
	bh=6v0CUPRfaXGAoLPrPrKauXw7CPWZ+MBBWv69fm/Az0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdPMwL+DJtIpl3MY+znVQGmnxa3Rhzeo8zxkzt/nGeiIJJ4GU/+eRMHjB04YiDciHQ427QIpy6g2+iZt4gTjIvG2lx5XA2hq1aakgDgjTXkkESFulzxJGzQr7wUyI2Am0upTQlo5zYXtDLIp5QEDFVmynb1DVpSuKI+A4KjYQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jJC88ykM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mDaT/6dqllCZHo2gumWmEXOi5NqdI3/lfYccvH9BDkE=; b=jJC88ykMQtPQhL2WJaUqKKQ3OQ
	2vavJMlgub9cow1wxW4ZK6+JCMiX5cuj0eWf1lP+mKMb4XCYxC1XGS9ujavcTrrmiWL9bKbQaIRqc
	sX2pmN3KA2ak5W4iMcgMRzmkpK1KmVtcZHPFoG2UDpU6a1batT48h6/3nYURzwWrcNSs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFFlX-00H2Fg-5T; Thu, 06 Jun 2024 18:15:03 +0200
Date: Thu, 6 Jun 2024 18:15:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?iso-8859-1?B?Q3Pza+FzLFw=?= Bence <csokas.bence@prolan.hu>,
	Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: sfp: Always call `sfp_sm_mod_remove()` on remove
Message-ID: <7768e181-19a5-4579-9113-c6d70479c452@lunn.ch>
References: <20240605084251.63502-1-csokas.bence@prolan.hu>
 <24a48e5a-efb3-4066-af6f-69f4a254b9c3@lunn.ch>
 <20240606082830.30e3a294@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606082830.30e3a294@kernel.org>

On Thu, Jun 06, 2024 at 08:28:30AM -0700, Jakub Kicinski wrote:
> On Thu, 6 Jun 2024 17:21:45 +0200 Andrew Lunn wrote:
> > I was expecting Russell to review this. Maybe he missed it.
> 
> While it's fresh in your mind - does it look like a fix to you?
> From a quick look - we're failing to unregister a device?

Yes. A Fixes of:

commit d2e816c0293fc263b3f168c14992a5f1a50d7593
Author: Russell King <rmk+kernel@armlinux.org.uk>
Date:   Sun Nov 10 14:06:28 2019 +0000

    net: sfp: handle module remove outside state machine
    
    Removing a module resets the module state machine back to its initial
    state.  Rather than explicitly handling this in every state, handle it
    early on outside of the state machine.

is probably best, since that refactored to code.

	Andrew

