Return-Path: <netdev+bounces-152536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D849F481E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DFB188273E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4271DFE00;
	Tue, 17 Dec 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BHM4RtjL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F61DF732;
	Tue, 17 Dec 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429314; cv=none; b=D1VrYSXm8iPaxF8ad0QdEKHvuUMcMyjxvOODvcFmiAqIsON3ZnxCvU4C4S8KL/k4J3kbrX6xt07vpkGOpcNLUOiKEZSDT7IVjr3ZBL8glB58tomnZfekH0O2PqU0356Zr/XXJn0L47koIvP4hvSbcDFlGujo/qYSoRyuA195NYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429314; c=relaxed/simple;
	bh=NIx5ShykQZJraVJi5a8NXZU4G7QuEowfvW/D3LcyN2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgI6fmxIA504x36H0wtaACWkF7QiPhdWcEWawfr+PKIBZbxLL9ygcf9dCax1aa0Kk3ip2KcgsFjPy1HZl1P79PpX4VQq2l07HCyNm77M2ziA8BNUvXPIbMGol2gg1dgiF0C96JbP0x3Efjt2abBqHUpA41cY5R/D8q37mXCw6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BHM4RtjL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hJVIWV7/i6TbmMJliwFbx4hHKxHdXU1du0eHxIj5ujo=; b=BHM4RtjL2G046TRyNzh6CHdETq
	UmZuo/S10je1ZBZ5VVylPQT1GsRb9G4gZ12zp5sJgK8bCx9tNNrwp24Se+M5qyO1TDeEbnEt7PdGP
	Fx0EsTMmedgORWE1BleaZQYN9d0J8QZPowWrZ2A08NkwzmpHZgyylQ42x+P8Y48WRnFE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNUI1-000uRl-5t; Tue, 17 Dec 2024 10:54:53 +0100
Date: Tue, 17 Dec 2024 10:54:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix switchdev error code
Message-ID: <ab85afaf-bd9d-416a-b54c-9c85062f3f3f@lunn.ch>
References: <20241217043930.260536-1-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217043930.260536-1-elliot.ayrey@alliedtelesis.co.nz>

On Tue, Dec 17, 2024 at 05:39:30PM +1300, Elliot Ayrey wrote:
> Calling a switchdev notifier encodes additional information into the
> return code. Using this value directly makes error messages confusing.
> 
> Use notifer_to_errno() to restore the original errno value.
> 
> Fixes: 830763b96720 ("net: dsa: mv88e6xxx: mac-auth/MAB implementation")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  drivers/net/dsa/mv88e6xxx/switchdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/switchdev.c b/drivers/net/dsa/mv88e6xxx/switchdev.c
> index 4c346a884fb2..7c59eca0270d 100644
> --- a/drivers/net/dsa/mv88e6xxx/switchdev.c
> +++ b/drivers/net/dsa/mv88e6xxx/switchdev.c
> @@ -79,5 +79,5 @@ int mv88e6xxx_handle_miss_violation(struct mv88e6xxx_chip *chip, int port,
>  				       brport, &info.info, NULL);
>  	rtnl_unlock();
>  
> -	return err;
> +	return notifier_to_errno(err);

I just had a quick look at other users of call_switchdev_notifiers()
and all but vxlan_core.c and this one discarded the return
value. Would that be a better fix, making the code more uniform?

	Andrew

