Return-Path: <netdev+bounces-224619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30158B86F8B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DB458104F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7452F39BC;
	Thu, 18 Sep 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cixrkRj9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C392F360B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229151; cv=none; b=jIbKB6huP5A/Cb18xfkxIGWUd2GtoqmR/04yT01OHvR6P6iWte6W5EyK0B5aayFW9wklrX2IXwNlHvrXbIynwROUEhoiUGwcqpHnYdNf36zGaQe7AqO+6Yc89AKAc5lrVxDlL18UZgXV5oOF3mxicg6JwA5pcXEqEvlUcDtRy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229151; c=relaxed/simple;
	bh=Axzj7/CPtA8I4i84pAkZuCVQvdOZIjQw7D1VbgxyLQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGjkBFseOuohvu9slRIiYlfa+/SrP6f1uhBVxcX/rDOJ8s83Yu71uAyzmU54/yIzd3wfPiD9VSiCozJOVWICFoD3AcRvYcRFLAG/991zRAmXVYi0apj11k6JBnS4wyyUbN8+zSqqz3rCHFARLzS6bYXqLtYFug2FsoJwRhtySaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cixrkRj9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=I0XqqrO72Og4XrnyWqfisJ1zvT6+/LLEHksFY1RBbqs=; b=cixrkRj9g+VmFL91Qe4pKaw7Xh
	34N/YMLO7cKc5jOaxJU7xXWP8LTSHYGmIaSYF3WF1tujvQjkMNfpnAnHOMJCEVjx/dzPmy87L9Gm9
	s8WlHSNV9y4iRd0n02RSKu9Kg5vgDxmJWJOcAMXtlOwVlJ8GqHDBoufpQSzTbvvB5TUE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzLid-008sNf-A2; Thu, 18 Sep 2025 22:59:07 +0200
Date: Thu, 18 Sep 2025 22:59:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 11/20] net: dsa: mv88e6xxx: split out EXTTS
 pin setup
Message-ID: <eabf052b-02a0-4440-b0f7-c831d9ebaa23@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbk-00000006n06-0a3X@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uzIbk-00000006n06-0a3X@rmk-PC.armlinux.org.uk>

>  static const struct mv88e6xxx_cc_coeffs *
>  mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
>  {
> @@ -352,27 +366,18 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
>  		return -EBUSY;
>  
>  	mv88e6xxx_reg_lock(chip);
> +	err = mv88e6352_ptp_pin_setup(chip, pin, PTP_PF_EXTTS, on);
>  
> -	if (on) {
> -		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_EVREQ;
> -
> -		err = mv88e6352_set_gpio_func(chip, pin, func, true);
> -		if (err)
> -			goto out;
> -
> +	if (!on) {

Inverting the if () makes this a little bit harder to review. But it
does remove a goto. I probably would of kept the code in the same
order. But:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

