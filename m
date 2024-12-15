Return-Path: <netdev+bounces-151992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F275F9F24B9
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7417A11B0
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF94190482;
	Sun, 15 Dec 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2ZgFHXOO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31723189912
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734278809; cv=none; b=KAmkQiyJzUk35KO72UZoVUM9R+voIk8UZHpl157qBr0rQEu82Ml/tU3myPwsFaYM+Jpcl4SPcQg0z9ZfNIjyG3vhiNYOZCBPlLee71Ly2O6Eex4sowaABDNpxhWFeG77j9xJC4tSosVn71B8FLwfprpICOjgqfOOgs7tQZPeYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734278809; c=relaxed/simple;
	bh=mm5Oh8V/RvSeF8ZP7FPYMezXUvILsPXnTBl1cwK7goY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMDJfQ3msrc9eMiLCSb+QS0XLUXgHL+AgEkNEdtNBlk2/KIFTkfmr5egU/6fj75NQbiUvv6/b0fge8HplX6ybmCNatFTD9me/mHOfCibCUgs423H4KAYRcI1f1OdhxuaefWzKpRwhmScgw50CnarDPblqsyCjbZcv+glLeyVPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2ZgFHXOO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9gm5Lc4qpnVEd7eDjpb5RL5mCtDXQHBFspjGUvYDV4s=; b=2ZgFHXOOZZMps3iGb4OZx2K7YZ
	w+kTY9yMY0cAgMOv7PNZ+9OOXCSAmVN+wtAD5hhWpwc0k6AV64d0o6cwC6p+bQOm5PTn3rTj5SPRm
	krF0vjov5Xq38AvmDarTK6KjC6yUiYHwxDvfBKRkGY8c4ed7UNBq5xRnJTjPGo6kZEiY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tMr8X-000Vbe-LK; Sun, 15 Dec 2024 17:06:29 +0100
Date: Sun, 15 Dec 2024 17:06:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: mdiobus: fix an OF node reference leak
Message-ID: <f68d5c96-ac9f-4042-8f00-c6641d06eee4@lunn.ch>
References: <20241215112417.2854371-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215112417.2854371-1-joe@pf.is.s.u-tokyo.ac.jp>

On Sun, Dec 15, 2024 at 08:24:17PM +0900, Joe Hattori wrote:
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
> Changes in v2:
> - Call of_node_put() after calling register_mii_timestamper() to avoid
>   UAF.
> ---
>  drivers/net/mdio/fwnode_mdio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> index b156493d7084..456f829e4d6d 100644
> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c
> @@ -41,6 +41,7 @@ static struct mii_timestamper *
>  fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>  {
>  	struct of_phandle_args arg;
> +	struct mii_timestamper *mii_ts;
>  	int err;
>  
>  	if (is_acpi_node(fwnode))
> @@ -56,7 +57,9 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>  	if (arg.args_count != 1)
>  		return ERR_PTR(-EINVAL);

Is there no need to put the node when arg.args_count != 1 ?

	Andrew

