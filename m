Return-Path: <netdev+bounces-151981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D98A9F2340
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 12:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3734165882
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83A13C816;
	Sun, 15 Dec 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MR8ZeUBW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A95335C7
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260633; cv=none; b=Cq8wcoFlix9fppg13aDme/AN/ZZJKQS8i1+I9wZgxz/vtw1qXy/WlaT4qX/CWijE7dr5dIVZAz6FM4gJLW990mTVTX2nw7kEebni589SvidHbi9RbNdZZfx9xLEEau7nT8000glNxJkCp5d4KbPZAPIYdaqCb+SWgr9xBdw/xAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260633; c=relaxed/simple;
	bh=66zlDQZCWZDCg8wcn4cmB1TY4l8Ha6sOk6XCUrdsqg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hjyt7t44//lyGqEwTtB66IxxF4ygP/KQFdGCyxCQ31/vDB7fE88E2n2jeU8uBXZFNmxBxP4lqVFhfyKz7CEbLRwRWp4KUYUDTZ7t40WO00LcAXbLawfBIwSGTIeQRAst2qy/vsZoz+lcDknudXAnnG6gRX02IuTLqQt1xgLsTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MR8ZeUBW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MP4a2ZjR/4HXgH5qdOrEOoq0j/z5X9hMPDvoGVJWfRo=; b=MR8ZeUBWkSkniAjc+fqcdq9jlx
	iJfDB4E7WF3MFa+8/7LGFJCmrxrLAnuZtibyOijBbbAAvn4yuzMCjGdNkg1Ie7RAndVYguR+saSMm
	GSFqSaNR+SE7nWjI+LrPlHjKos7rHcV0WPT28ddK/zW1Qe7YB7ul2eN+/yC3hvow+hDs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tMmPM-000Uey-FH; Sun, 15 Dec 2024 12:03:32 +0100
Date: Sun, 15 Dec 2024 12:03:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: mdiobus: fix an OF node reference leak
Message-ID: <1e1c4c67-3e18-4364-9311-c9ba36a5e2b9@lunn.ch>
References: <20241214081546.183159-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214081546.183159-1-joe@pf.is.s.u-tokyo.ac.jp>

On Sat, Dec 14, 2024 at 05:15:46PM +0900, Joe Hattori wrote:
> fwnode_find_mii_timestamper() calls of_parse_phandle_with_fixed_args()
> but does not decrement the refcount of the obtained OF node. Add an
> of_node_put() call before returning from the function.
> 
> This bug was detected by an experimental static analysis tool that I am
> developing.
> 
> Fixes: bc1bee3b87ee ("net: mdiobus: Introduce fwnode_mdiobus_register_phy()")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/net/mdio/fwnode_mdio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> index b156493d7084..83c8bd333117 100644
> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -56,6 +56,7 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>  	if (arg.args_count != 1)
>  		return ERR_PTR(-EINVAL);
>  
> +	of_node_put(arg.np);
>  	return register_mii_timestamper(arg.np, arg.args[0]);

This looks wrong to me. If you do a put on an object, it can
disappear, because it is not being used. You then pass it to
register_mii_timestamper() and it gets to use something which no
longer exists.

Please think about what get/put are used for, and what that means for
ordering.

Maybe you can extend your tool to look for potential use after free
bugs.

    Andrew

---
pw-bot: cr

