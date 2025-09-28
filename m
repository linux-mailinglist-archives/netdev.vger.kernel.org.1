Return-Path: <netdev+bounces-227015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C0BA6E4D
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0729A1898D97
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A82D837C;
	Sun, 28 Sep 2025 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ewWGVe3W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2E248F51
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053075; cv=none; b=nd/IFdVNkBVAxg7wyq3cyXsuGJEA1GoZ9AjpRSasGgqemT1qzuSBEJ21GGhdZ44E6xRya2VTO5qqePh5PK6oUDTK8QLq0TdyZtmexssskcuRel5m9j7iB5GoWc0ORqdQzdR/qHz/uUJXZc1v0msMCUfWZ9jf5Ea5GsTaN0QKRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053075; c=relaxed/simple;
	bh=sH7BY+yftEWOmV5+CBFuciiemI+6cPg5ETATp6icdQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeTX5/UE2BTYC3znk5yvg5jD85QUdSvXFZTrP7OnVe4CuBvs8IQM5nTOgz7ZNr5Pz7eXRcGZiEuoYnOnyAfrX7lgneIUROO/q0mRCTcd+GbBO//Zo8SdPAimEmKrlcIu4Tt6I6oT1rR4v6I0hf3Vfkfd+HKja7LAHGPRwSdyLbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ewWGVe3W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FI12eMvVoMJL57V5n681dIivJzNSe8NDLqayNDsDEV8=; b=ewWGVe3WYPeMRiN/NVirmpuIFn
	VNow/t8OKcBqaRs3Z+r9CI8s8QZ63573Im23f+mZ54IMdO3nuQfxU7K2YXc6PkcDbLOqmCptGDrFY
	wTg8Xpd/K6Vwjh8K+N0q+ti4ZX0TF5kgAYwqmVkJTdyk0+Nu+uNbc2qzNgm31rgvRaW7mHSaeNyqg
	W7TZW7UfnZMqU4WMCpFifh/MOVjRz1TVBzSrFWI4Ufzagw1KWjHlipLCk6wwPNWrWGIcWD4zXCo0K
	JLmIp5hyeAupXDI5D2ZWCaofLvdBbFq27Ivceud4qGpI25I2M6HO62uT/8Lke7ZiJXP1kDXfWI+9W
	KpuaJy3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35958)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v2o3i-000000005Xk-0wml;
	Sun, 28 Sep 2025 10:51:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v2o3g-000000002Tl-1QDe;
	Sun, 28 Sep 2025 10:51:08 +0100
Date: Sun, 28 Sep 2025 10:51:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 11/20] net: dsa: mv88e6xxx: split out EXTTS
 pin setup
Message-ID: <aNkFDGQwm-qkgkvV@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbk-00000006n06-0a3X@rmk-PC.armlinux.org.uk>
 <eabf052b-02a0-4440-b0f7-c831d9ebaa23@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eabf052b-02a0-4440-b0f7-c831d9ebaa23@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 18, 2025 at 10:59:07PM +0200, Andrew Lunn wrote:
> >  static const struct mv88e6xxx_cc_coeffs *
> >  mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
> >  {
> > @@ -352,27 +366,18 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
> >  		return -EBUSY;
> >  
> >  	mv88e6xxx_reg_lock(chip);
> > +	err = mv88e6352_ptp_pin_setup(chip, pin, PTP_PF_EXTTS, on);
> >  
> > -	if (on) {
> > -		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_EVREQ;
> > -
> > -		err = mv88e6352_set_gpio_func(chip, pin, func, true);
> > -		if (err)
> > -			goto out;
> > -
> > +	if (!on) {
> 
> Inverting the if () makes this a little bit harder to review. But it
> does remove a goto. I probably would of kept the code in the same
> order. But:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

It's not the goto, but:

	if (on && !err) {
                schedule_delayed_work(&chip->tai_event_work,
                                      TAI_EVENT_WORK_INTERVAL);

                err = mv88e6352_config_eventcap(chip, rising);
	} else if (!on) {
                /* Always cancel the work, even if an error occurs */
                cancel_delayed_work_sync(&chip->tai_event_work);
	}

would be the alternative, which is IMHO less readable, and more
error-prone. However, there is an issue that if
mv88e6352_config_eventcap() returns an error, we leave the work
scheduled. So maybe:

	if (on && !err) {
                schedule_delayed_work(&chip->tai_event_work,
                                      TAI_EVENT_WORK_INTERVAL);

                err = mv88e6352_config_eventcap(chip, rising);
	}

	if (!on || err) {
                /* Always cancel the work, even if an error occurs */
                cancel_delayed_work_sync(&chip->tai_event_work);
	}

which is more difficult to get one's head around.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

