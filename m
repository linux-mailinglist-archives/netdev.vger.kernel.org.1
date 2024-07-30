Return-Path: <netdev+bounces-114128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DC794106B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26711B2321A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8174719DFA4;
	Tue, 30 Jul 2024 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bKVMqyYc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF181993B0;
	Tue, 30 Jul 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338640; cv=none; b=NIjplMJoHCUF5lpFMEiJ8sinOoxUzesAqIdamhuQlX+zlt0uJj4X4bfSNraXhuRAhrYX/eU+rrhgpDEy9LbSN5Hr/g6T32rgI6stygfuTmzM2WEE9p+8maNMxGi88wJ+RdOID0cplc4d2GFvdMA/FRHpd6+MEFK0y8/cI0ph7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338640; c=relaxed/simple;
	bh=pOA0+hxVfOzNZYEWL0amhMKDYvzHYLXnQpE9r0FHK8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLddsRfHnYqoBnAOtM+jc12mmoXgHhBUsKPIFJk46n0CcC+auji9a49w61KkntoltuAN+ZP/BU0dKVdmBWtNJHJVWu9P63Ovw1ajRfnbNmzoaqi2fYn6XfCWNd236iWig//pR6SDlTjwx+mQPnF2ydfA3QFtiWiDVRWQypgfztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bKVMqyYc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/KjOC3r37EogMaWUzeIP1eZFMIvbYUyiLZJrxK8c0Kk=; b=bKVMqyYcjJ2Min/cT7k5ohWK5N
	RjmDvjJdvdSWvLAZ8VG62e97C1MTtHeAu2HpP1tkbb7ldpbjObedkCgLPvvsLYkyMOWpsduRC8g3W
	f8zt8EDcPH9+tg/86eq31UTscOG85zeEtpWGgUL2/oTo2M7Fz1mwumOCv2yireeRM54L/KJFdjHit
	vUxG8jnWPk45FgOfsNAv/KhoZVEUO6Go2tNNRAAkLEs3UzuY9sl3dPLXA0NlHqpx+g0GPF7KSslUf
	Uq5k/fEiLVAQoH9HYIE6lK3CEvU8Ihv/xFPRKW130dvkUKCG2S43SBvaBoDBhEQQ0N+WhoGUEyiXA
	Mz5CUjOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57712)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYkxD-0006Yd-1d;
	Tue, 30 Jul 2024 12:23:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYkxF-0005E8-VO; Tue, 30 Jul 2024 12:23:46 +0100
Date: Tue, 30 Jul 2024 12:23:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>
Subject: Re: [RESEND PATCH net-next v3 2/4] net: phy: aquantia: wait for FW
 reset before checking the vendor ID
Message-ID: <ZqjNQW5HhTUgCc5x@shell.armlinux.org.uk>
References: <20240708075023.14893-3-brgl@bgdev.pl>
 <8ac00a45-ac61-41b4-9f74-d18157b8b6bf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ac00a45-ac61-41b4-9f74-d18157b8b6bf@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 30, 2024 at 10:59:59AM +0100, Jon Hunter wrote:
> Hi Bartosz,
> 
> On 08/07/2024 08:50, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Checking the firmware register before it complete the boot process makes
> > no sense, it will report 0 even if FW is available from internal memory.
> > Always wait for FW to boot before continuing or we'll unnecessarily try
> > to load it from nvmem/filesystem and fail.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >   drivers/net/phy/aquantia/aquantia_firmware.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> > index 0c9640ef153b..524627a36c6f 100644
> > --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> > +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> > @@ -353,6 +353,10 @@ int aqr_firmware_load(struct phy_device *phydev)
> >   {
> >   	int ret;
> > +	ret = aqr_wait_reset_complete(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> >   	/* Check if the firmware is not already loaded by pooling
> >   	 * the current version returned by the PHY. If 0 is returned,
> >   	 * no firmware is loaded.
> 
> 
> Although this fixed another issue we were seeing with this driver, we have
> been reviewing this change and have a question about it.
> 
> According to the description for the function aqr_wait_reset_complete() this
> function is intended to give the device time to load firmware and check
> there is a valid firmware ID.
> 
> If a valid firmware ID (non-zero) is detected, then
> aqr_wait_reset_complete() will return 0 (because phy_read_mmd_poll_timeout()
> returns 0 on success and -ETIMEDOUT upon a timeout).
> 
> If it times out, then it would appear that with the above code we don't
> attempt to load the firmware by any other means?

I'm also wondering about aqr_wait_reset_complete(). It uses
phy_read_mmd_poll_timeout(), which prints an error message if it times
out (which means no firmware has been loaded.) If we're then going on to
attempt to load firmware, the error is not an error at all. So, I think
while phy_read_poll_timeout() is nice and convenient, we need something
like:

#define phy_read_poll_timeout_quiet(phydev, regnum, val, cond, sleep_us, \
                                    timeout_us, sleep_before_read) \
({ \
        int __ret, __val; \
        __ret = read_poll_timeout(__val = phy_read, val, \
                                  __val < 0 || (cond), \
                sleep_us, timeout_us, sleep_before_read, phydev, regnum); \
        if (__val < 0) \
                __ret = __val; \
        __ret; \
})

#define phy_read_poll_timeout(phydev, regnum, val, cond, sleep_us, \
                                timeout_us, sleep_before_read) \
({ \
        int __ret = phy_read_poll_timeout_quiet(phydev, regnum, val, cond, \
						sleep_us, timeout_us, \
						sleep_before_read); \
        if (__ret) \
                phydev_err(phydev, "%s failed: %d\n", __func__, __ret); \
        __ret; \
})

and aqr_wait_reset_complete() needs to use phy_read_poll_timeout_quiet().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

