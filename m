Return-Path: <netdev+bounces-157903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B6DA0C449
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35C9167089
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2A01DACAA;
	Mon, 13 Jan 2025 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EpmPMcu4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF31CDFCE
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805554; cv=none; b=oykqTrwdYcdw3R1TF+kveW59VNn/KMKUr2Jqh0ZzrniAalrlljjSqPJTovvTUQmVaT9pvcwtYlY1uaR+VL56VEbxaBy6M8lq63O964JikeODCWJhBjXM7wZ+k4AxEq2i6ger5gtui9Xokrzl0rx0XvZpynIm39o+EYQhi80ls7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805554; c=relaxed/simple;
	bh=joIHzGRTnVheagIpMpylCfW8uvI18v6OovtJWYYsHpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK5QDQdmCb4JrtwX/c/KgJJMcVXYiIUb8chgowkSV/l9sVWNJSeEZQL0e1XUUMIEb7Ia0s6HxOoMVJalRJ/AXCCfpayhWKVcwyeLNLt/Cy7KUHqCKCB0jWzJefDWrfLS0nEZSovmOipZrNmuokXxaVPnCxdZz5qrkvNf3t2glQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EpmPMcu4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KX8KB3eq+JWdbo9PbA8f3sh/r1iF4YYElJg7JWpJhS4=; b=EpmPMcu4S03j9PA/GW6a3mkDw/
	UpNS5hsZwM45cIKoPqmAKviVh+hp907MZBPWpF0rVXJnWhDhwalLKgz+Go/Bx1RiRb1MVThsvEVc0
	vAAyVlHvSckTNvdJQkMCkYfWRFdaXg4C18tmleWhwaif/ZSs4lcl/lYMquDfEEMSEmaw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXSSf-004EVS-NN; Mon, 13 Jan 2025 22:59:05 +0100
Date: Mon, 13 Jan 2025 22:59:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] tsnep: Select speed for loopback
Message-ID: <65db2d1b-10aa-4bf6-8205-3ede6726d87b@lunn.ch>
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
 <20250110144828.4943-5-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110144828.4943-5-gerhard@engleder-embedded.com>

On Fri, Jan 10, 2025 at 03:48:27PM +0100, Gerhard Engleder wrote:
> Use 100 Mbps only if the PHY is configured to this speed. Otherwise use
> always the maximum speed of 1000 Mbps.
> 
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> ---
>  drivers/net/ethernet/engleder/tsnep_main.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
> index 5c501e4f9e3e..45b9f5780902 100644
> --- a/drivers/net/ethernet/engleder/tsnep_main.c
> +++ b/drivers/net/ethernet/engleder/tsnep_main.c
> @@ -229,8 +229,19 @@ static void tsnep_phy_link_status_change(struct net_device *netdev)
>  static int tsnep_phy_loopback(struct tsnep_adapter *adapter, bool enable)
>  {
>  	int retval;
> +	int speed;
>  
> -	retval = phy_loopback(adapter->phydev, enable, 0);
> +	if (enable) {
> +		if (adapter->phydev->autoneg == AUTONEG_DISABLE &&
> +		    adapter->phydev->speed == SPEED_100)
> +			speed = SPEED_100;
> +		else
> +			speed = SPEED_1000;
> +	} else {
> +		speed = 0;
> +	}
> +
> +	retval = phy_loopback(adapter->phydev, enable, speed);

If phy_loopback() returns -EOPNOTSUPP, don't you want to retry without
a speed? There is no guarantee the PHY paired with this MAC does
support setting the loopback speed.

	Andrew

