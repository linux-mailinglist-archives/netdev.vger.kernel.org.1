Return-Path: <netdev+bounces-120283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895D2958C97
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59DA2841E5
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E676A19DF85;
	Tue, 20 Aug 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aY2D6wyf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9687E59A;
	Tue, 20 Aug 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172553; cv=none; b=IRqx5+yJDspOk4jU9/jbpeZ7zPV5wgtZMutZSdq0aYiq5F0jwvn2Qggzd2eblirK8KIgVb9/RQb2yP/vRbmC68mW/MbtJkJRgwXmosvQ3Eb9GT8m1I819QjXfnrDVhI5qg5ziB2nM4G31BjaYggla4p4k6AgXTWhNgXY9w2+5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172553; c=relaxed/simple;
	bh=CVigt6U9/LTrKxeFgQiSEgLNzF5xgZtMMGsdFZPRPGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spSWxzmXweHQ2JCsdICSPuYeJ8ovi2bi+D0OPoL3BsADgq0kAIS7b0GXY9IjWdjm7ssTGsoqY0f1Xd0NwxbdcVJcJ0IXHFKuakHRRjLaZjxfs+0kC1C5/16zcLMHh7H9dg/huK/XO/8kcDB32s8LbLfn38Rnyy56m7lg90bJEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aY2D6wyf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fVuICFdLW+JEgDFIP8zzlKLICsdLVoGfci5aYhFsYP4=; b=aY2D6wyfgPPwCOI7K7fRH1MXW8
	InUxzj9yI8k2afuPSogDfwpqGo5lsxbSFqM8M7ukVv0GdQSzmZqrKmkkQRf2biRHt7T0ECslreH1c
	NIqbnw1owVpVzEVPdcrAArId62tGmcH+ZabV7PFgYEsfllAlwBTRcmCboHF6q4jlGaKw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgS2W-005FRw-CS; Tue, 20 Aug 2024 18:49:00 +0200
Date: Tue, 20 Aug 2024 18:49:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 3/3] phy: dp83td510: Utilize ALCD for cable
 length measurement when link is active
Message-ID: <a02698f3-94b6-4e6c-b13a-7fbeba2ce42f@lunn.ch>
References: <20240820101256.1506460-1-o.rempel@pengutronix.de>
 <20240820101256.1506460-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820101256.1506460-4-o.rempel@pengutronix.de>

On Tue, Aug 20, 2024 at 12:12:56PM +0200, Oleksij Rempel wrote:
> In industrial environments where 10BaseT1L PHYs are replacing existing
> field bus systems like CAN, it's often essential to retain the existing
> cable infrastructure. After installation, collecting metrics such as
> cable length is crucial for assessing the quality of the infrastructure.
> Traditionally, TDR (Time Domain Reflectometry) is used for this purpose.
> However, TDR requires interrupting the link, and if the link partner
> remains active, the TDR measurement will fail.
> 
> Unlike multi-pair systems, where TDR can be attempted during the MDI-X
> switching window, 10BaseT1L systems face greater challenges. The TDR
> sequence on 10BaseT1L is longer and coincides with uninterrupted
> autonegotiation pulses, making TDR impossible when the link partner is
> active.
> 
> The DP83TD510 PHY provides an alternative through ALCD (Active Link
> Cable Diagnostics), which allows for cable length measurement without
> disrupting an active link. Since a live link indicates no short or open
> cable states, ALCD can be used effectively to gather cable length
> information.
> 
> Enhance the dp83td510 driver by:
> - Leveraging ALCD to measure cable length when the link is active.
> - Bypassing TDR when a link is detected, as ALCD provides the required
>   information without disruption.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/dp83td510.c | 83 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
> index 551e37786c2da..10a46354ad2b8 100644
> --- a/drivers/net/phy/dp83td510.c
> +++ b/drivers/net/phy/dp83td510.c
> @@ -169,6 +169,10 @@ static const u16 dp83td510_mse_sqi_map[] = {
>  #define DP83TD510E_UNKN_030E				0x30e
>  #define DP83TD510E_030E_VAL				0x2520
>  
> +#define DP83TD510E_ALCD_STAT				0xa9f
> +#define DP83TD510E_ALCD_COMPLETE			BIT(15)
> +#define DP83TD510E_ALCD_CABLE_LENGTH			GENMASK(10, 0)
> +
>  static int dp83td510_config_intr(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -327,6 +331,16 @@ static int dp83td510_cable_test_start(struct phy_device *phydev)
>  {
>  	int ret;
>  
> +	/* If link partner is active, we won't be able to use TDR, since
> +	 * we can't force link partner to be silent. The autonegotiation
> +	 * pulses will be too frequent and the TDR sequence will be
> +	 * too long. So, TDR will always fail. Since the link is established
> +	 * we already know that the cable is working, so we can get some
> +	 * extra information line the cable length using ALCD.
> +	 */
> +	if (phydev->link)
> +		return 0;
> +

> +static int dp83td510_cable_test_get_status(struct phy_device *phydev,
> +					   bool *finished)
> +{
> +	*finished = false;
> +
> +	if (!phydev->link)
> +		return dp83td510_cable_test_get_tdr_status(phydev, finished);
> +
> +	return dp83td510_cable_test_get_alcd_status(phydev, finished);

Sorry, missed this earlier. It seems like there is a race here. It
could be the cable test was started without link, but when phylib
polls a few seconds later link could of established. Will valid ALCD
results be returned?

	Andrew

