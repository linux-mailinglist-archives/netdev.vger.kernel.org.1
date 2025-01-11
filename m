Return-Path: <netdev+bounces-157451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A7EA0A575
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 19:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630701693AD
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27719F40B;
	Sat, 11 Jan 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f4fLkdK+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5CD1799F
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736621927; cv=none; b=iUslRF6UBeu1AdgyWJPPFUMMqaEsCgUvX19NPBlvVL+dwtYiUT60pVSsWfGr6WjLK4CDk5UhJpbMTGoCh0WMVB9AmBDqF7Mcj8BKf0RCyZ+eoJuzdo9nwLWtgCPnttBlU2GRXj6bWj4L3j5z/1d3QPBhyub8qliLAlHpgvh5R40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736621927; c=relaxed/simple;
	bh=3YUrNYE48WkuI1hN4pzvc6byMmzUcSpv7bTzEZi43h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2zPrNsWrnWiYFh3DwH29mrUNE5KpedwFJtdhUD+lujhsE12V0unt2Rp+TYzbedjD4e6urcG3o8XLWYdbIjFjGTlkWRCwZPkZf2AbfHBc3iFDB51U5UTP+xwAYe6eanr2Hs4vAKSSAt/30FkElpMAitxstdY1T3qxJNC+KiQ3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f4fLkdK+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SLpPtVWsxImyQQivTG/opC2j4WmmS7ulH2nNhGyOKTY=; b=f4fLkdK+9WyiaD4lV/5Hjp9Gj8
	mLNbhVd6PA4C90WDh5KehiPbvecdrMBCe77iwNdmHcjIsJ0loYxWK4Mf8MRUK4PRDNXgbfa7bLLUy
	XsX7AdAaLR1ZxJVUBCk+LXLQcsTXOK5H4EZEKefsWkPXtz6++GEvU6rBHFHut+9PaO78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWggy-003bPo-SM; Sat, 11 Jan 2025 19:58:40 +0100
Date: Sat, 11 Jan 2025 19:58:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 2/2] net: initialize netdev->lock on dummy
 devices
Message-ID: <30c4dfe3-8991-4659-8379-47f0ac0d6f31@lunn.ch>
References: <20250111065955.3698801-1-kuba@kernel.org>
 <20250111065955.3698801-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111065955.3698801-2-kuba@kernel.org>

On Fri, Jan 10, 2025 at 10:59:55PM -0800, Jakub Kicinski wrote:
> Make sure netdev->lock is always valid, even on dummy netdevs.
> 
> Apparently it's legal to call mutex_destroy() on an uninitialized
> mutex (and we do that in free_netdev()), but it doesn't seem right.
> Plus we'll soon want to take netdev->lock on more paths which dummy
> netdevs may reach.

I assume here that dummy does not call alloc_netdev_mqs() or one of it
wrappers? That is how the lock seems to get initialised for real MAC
drivers. Are there other bits of initialisation in that function which
dummy is missing? Should we really be refactoring alloc_netdev_mqs()
to expose an initialisation helper for everything which is not related
queues?

	Andrew

