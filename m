Return-Path: <netdev+bounces-134856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F66E99B630
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D46B1B2245D
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A8154FAD;
	Sat, 12 Oct 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BhBms6GG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DE42A8B;
	Sat, 12 Oct 2024 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728753499; cv=none; b=MNu+iHJtv5amx6VVjXNzdUThSczyqxrU6dBAHhMtESOAbfH1ldLspMceyAYdF+xav1Letme1gvKnqft4yv/C3TRO6re/drmIq64za8bhxEVEzsb31oEzrUJ0fTjDhvbJST4fHFjDgP3BL8Qsl+Dbr2F3ibwtdR21JVRPMCz12es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728753499; c=relaxed/simple;
	bh=NULuAUl/txXW+gPsM35SLhVrxhpry3h6INgvOGfVwrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XttvYrcdjCvQwZF5DawK2WGS3D+fWQlFpyyrDGaC9vND7Ige+oEKfruSe/J2isMzn+UgT9mKk8pZvLx+CYlWdDxsjkSNOdg6pS4ajaVOdb+/+c5yvwV8FVcJ4lN6fpSat/Fq/mjZ0YOr0KWT2MjruL7a/FjUZHVJdr9OJFAkKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BhBms6GG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5d6c72w9wUF/3LQbANdW7l+NbbqSByq50oUXh0tn+Yo=; b=BhBms6GGOzGvIifwVRM7z2AtSv
	13cZIFMWYTxD1oxHKA9V87dUUfCS9kHtpKvFGBj2tQN3rzSgmuCzOE42lToDX3k4LZB+r3JuMg6dk
	o1vD1fwOk8E/5UYDkncBAvij4xLlo7KL1CiOEL8uIZ8TQgfxt/eWvErVZ+9FfPqK2ZC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1szfkS-009oEg-HD; Sat, 12 Oct 2024 19:17:48 +0200
Date: Sat, 12 Oct 2024 19:17:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jacob.e.keller@intel.com, rentao.bupt@gmail.com,
	f.fainelli@gmail.com, andrew@aj.id.au, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net] net: ftgmac100: refactor getting phy device handle
Message-ID: <be591afe-d70b-4208-a189-40e65227ad14@lunn.ch>
References: <20241011081633.2171603-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011081633.2171603-1-jacky_chou@aspeedtech.com>

On Fri, Oct 11, 2024 at 04:16:33PM +0800, Jacky Chou wrote:
> The ftgmac100 supports NC-SI mode, dedicated PHY and fixed-link
> PHY. The dedicated PHY is using the phy_handle property to get
> phy device handle and the fixed-link phy is using the fixed-link
> property to register a fixed-link phy device.
> 
> In of_phy_get_and_connect function, it help driver to get and register
> these PHYs handle.
> Therefore, here refactors this part by using of_phy_get_and_connect.
> 
> Fixes: 38561ded50d0 ("net: ftgmac100: support fixed link")
> Fixes: 39bfab8844a0 ("net: ftgmac100: Add support for DT phy-handle property")

Fixes: implies something is broken. What is actually wrong with this
code? What sort of problem does a user see?

> -		phy_support_asym_pause(phy);
> +		if (of_get_property(np, "phy-handle", NULL))
> +			phy_support_asym_pause(phy);

This is probably wrong. This is the MAC layer telling phylib that the
MAC supports asym pause. It should makes no difference to the MAC what
sort of PHY is being used, all the MAC is looking at/sending is pause
frames.

    Andrew

---
pw-bot: cr


