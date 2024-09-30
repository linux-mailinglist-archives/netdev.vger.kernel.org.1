Return-Path: <netdev+bounces-130444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA798A89D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF88D1F24E39
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C8192B90;
	Mon, 30 Sep 2024 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WY9An6KS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550B18FDCE
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710311; cv=none; b=NkiYQSC9LUj81V0hlIIZfK4FHmVNk2ZP4WO6RCSd6RE4NUJHh4FDfLr+XjtirFOV/Sma7gOxPzuk+Id7pHyRZaXmq6942PttjRDXbJmeyYwpwi/sggiQwpJLr6W3M5TcSSoIxMiFZowuYluCe8defdvb9TyAIlt/RPDBq86F08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710311; c=relaxed/simple;
	bh=HvfMkhxWgGVYLpHdzV9FThc7hJr/7zyw3h1RdE/vf7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj+kpW8z4e38s7f9wq+iEvyfbgVoPDgUFq057OguwptYrtHANM/M6QcmzxHb8huh8LiiYcLzlIh0Vpe/98aBt0WMRJEjIt9fqUKf4oSyl5Np1P32gzFJBCpOtLqxV5ctsEb4dAkwmsRLGOjq9jPV+nUIPxH7QBIKtBhb8P7dsKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WY9An6KS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p4qLyrNF/iHAH35mI0y2c59q6JSquD1qlPzFiFcbWsY=; b=WY9An6KS2q+xnI27mD8+KFwONd
	NfsFVO6GiVXibi8HBBRQb/YqZhGvh+c5rJZCH/efuCPqNglH5m2/GO3s5umHnMnpPDJefgDpOYwix
	Fm9mH+B6whcRqr58LE21uQY2I/63/jpLxyq2Nf/K4huIH8wKPlzmN//crCjM+9y/a0Pc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svING-008dXz-Ls; Mon, 30 Sep 2024 17:31:46 +0200
Date: Mon, 30 Sep 2024 17:31:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
Subject: Re: [PATCH net 2/3] net: dsa: mv88e6xxx: read cycle counter period
 from hardware
Message-ID: <36b11f88-f5d2-41a2-877e-e231c2985f30@lunn.ch>
References: <20240929101949.723658-1-me@shenghaoyang.info>
 <20240929101949.723658-3-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929101949.723658-3-me@shenghaoyang.info>

> +static const struct mv88e6xxx_cc_coeffs *
> +mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
> +{
> +	u16 period_ps;
> +	int err;
> +
> +	err = mv88e6xxx_tai_read(chip, MV88E6XXX_TAI_CLOCK_PERIOD, &period_ps, 1);
> +	if (err) {
> +		dev_warn(chip->dev, "failed to read cycle counter period");
> +		return chip->info->ops->ptp_ops->default_cc_coeffs;
> +	}
> +
> +	switch (period_ps) {
> +	case 8000:
> +		return &mv88e6xxx_cc_8ns_coeffs;
> +	case 10000:
> +		return &mv88e6xxx_cc_10ns_coeffs;
> +	default:
> +		dev_warn(chip->dev, "unexpected cycle counter period of %u ps",
> +			 period_ps);
> +		return chip->info->ops->ptp_ops->default_cc_coeffs;

This chip mv88e6xxx_cc_coeffs vs ptp_ops mv88e6xxx_cc_coeffs all seems
a bit messy.

The mv88e6xxx_tai_read() MV88E6XXX_TAI_CLOCK_PERIOD is not going to
fail, except for the hardware is dead. There is nothing you can do
about that, so return the error code and let the probe fail.

What you are more worried about is if the value you get back is not
what you expect. It is not 8000 or 10000. I would do a dev_err() and
return -ENODEV, and let the probe fail. The datasheets suggests this
should not happen. But if it does, we should get reports from users
that PTP is issuing an error and the switch is not probing. We can
then fix the problem.

You can then drop mv88e6xxx_cc_coeffs from ptp_ops.

    Andrew

---
pw-bot: cr

