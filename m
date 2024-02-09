Return-Path: <netdev+bounces-70526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8026284F61C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D081C20C31
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599CF37703;
	Fri,  9 Feb 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dq4juRgP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA020311
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486143; cv=none; b=OBFZCq4OT0Gn6/IUaqc4Djjui48ddwXU6tiWmttlIEWXg5oYe7zk6mTZNbj3xEFWXiM5UKtUl2KP0VNpez21cJT1tH+No5Nc9fEqa7nCDW72hYZK55RJGbx4GbJQOL3e5izYVUa5H/9rxI7RplRSagkFGwxYEgn2n08EDq5QuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486143; c=relaxed/simple;
	bh=/E0nQfdHcA+bplIE7jl2vutQaQnOdRSl7xp9ERc7Bpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDKpRNUb9g70mryryJWPeQgcA2OFr7a28t6awkH0lv+LNJ9jyLJBgJ739KdqRxJ5P9e22R/eEsHsZRo8ouEinnSovPxbLwLncQS8kTmfyjESExbcQH07Hj5LmrBMX0xSXQpRqfOS6niwr4f4+hXhDEglJCOWj91RwOBChlsDfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dq4juRgP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZA0d2tUx9BOaL4/iom+fr1y+VpaYISLBcmEVA4Ju7lw=; b=dq4juRgPOxXaaQxir8OfNJzP+m
	A00AGpu701wnkMxy9J0JsS4zVVZq0RWRPvcoOEc7h1FJPNek1MupZUMAlyC40+PwR6tV1q6Q9/RO1
	x0+0HcptEuJqgYsWb+3I/4yVZChRx1VJ3taZUIVrXPHSANR+AaTMurRmmVtABPhuY3AM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYR8w-007O4W-2E; Fri, 09 Feb 2024 14:42:14 +0100
Date: Fri, 9 Feb 2024 14:42:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Aithal, Srikanth" <sraithal@amd.com>
Subject: Re: [PATCH net-next] tg3: fix bug caused by uninitialized variable
Message-ID: <9fcaa6bb-3f31-4943-9731-251223e092bc@lunn.ch>
References: <3e4a74f6-3a3b-478d-b09a-6fb29b0f8252@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e4a74f6-3a3b-478d-b09a-6fb29b0f8252@gmail.com>

On Fri, Feb 09, 2024 at 07:47:39AM +0100, Heiner Kallweit wrote:
> The reported bug is caused by using mii_eee_cap1_mod_linkmode_t()
> with an uninitialized bitmap. Fix this by zero-initializing the
> struct containing the bitmap.
> 
> Fixes: 9bc791341bc9a5c22b ("tg3: convert EEE handling to use linkmode bitmaps")
> Reported-by: Srikanth Aithal <sraithal@amd.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


