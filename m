Return-Path: <netdev+bounces-182235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C97A884C2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A98616BD66
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A29274FE2;
	Mon, 14 Apr 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sk8Gf83k"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26E274FD7
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639076; cv=none; b=fcSaezIRWXvB8sXnaCqtIAALDiUvkvh4OLap/OtG2nkK7bDHNRYjC5RBNS6KZNiO8jD9jow1obAsjej+wBSFkfC/XDlYESYgfS2jjsvb3wk0J5EFurU4/YGufvelPYyDoxbMUguuZkTrIBS4XAp7r9Sf3yfeyzzLAgr6wG53h9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639076; c=relaxed/simple;
	bh=QjmgDS7PGY4l/dkpIoo4Ca6kD6gcTPgFLu051s1wLTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPwnhzM3RaikfUHFSwduiQtd+3RfDHMNOc3wGujteD/rG7yFQO0JZpRuKdIoDolwUYPKZqjUb4575/rEX0Qa2VHuvZZHGwWIxAuxdXCsxAlp/6a7UQ3zOt85JenoHqac1DOm0tU2583fZRUmxeLN4LhrcsMimO5como++fgtbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Sk8Gf83k; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mEL46ZEHPzNOvWO7vJTDhVAM23gYy2Oet0voTH1QzP0=; b=Sk8Gf83k1xK9pYTi2iM0cLWxJM
	5+ISyFiKN3W5EzJTz7voWDNybA/8GpgOk+qf8wKx+T7fusveqgtymIM/lDm+6itgtdMT4yb4MeBgC
	NCtPlcjFE3aPsMhNenfFd51Pb6XGG/69smb0+I+vdo9ZNGrvxDm8Nmva9lTyC67/zLwvOI3phADiN
	kpU4zPp4tFfofu2hFcRoPwpC8hNMMRe6YijfdhaH0PHUXiqrkvpfQAi4H+I2USHgPYuBKajbvfGt9
	WZf833zpqCZnZPqj2ZMhi2hS9DUFyrTaJnaaPc7FsGsYf/5nDyfGmORzv91cxL7/S37sf56vyHDAi
	L0vrn+vQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45212)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4KJn-0006do-1w;
	Mon, 14 Apr 2025 14:57:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4KJk-0007no-13;
	Mon, 14 Apr 2025 14:57:44 +0100
Date: Mon, 14 Apr 2025 14:57:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 3/5] net: phy: add Marvell PHY PTP support
Message-ID: <Z_0UWKouGwMF9G1w@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <E1u3Lta-000CP7-7r@rmk-PC.armlinux.org.uk>
 <20250414143306.036c1e2e@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414143306.036c1e2e@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 14, 2025 at 02:33:06PM +0200, Kory Maincent wrote:
> On Fri, 11 Apr 2025 22:26:42 +0100
> Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Add PTP basic support for Marvell 88E151x single port PHYs.  These
> > PHYs support timestamping the egress and ingress of packets, but does
> > not support any packet modification, nor do we support any filtering
> > beyond selecting packets that the hardware recognises as PTP/802.1AS.
> > 
> > The PHYs support hardware pins for providing an external clock for the
> > TAI counter, and a separate pin that can be used for event capture or
> > generation of a trigger (either a pulse or periodic). Only event
> > capture is supported.
> > 
> > We currently use a delayed work to poll for the timestamps which is
> > far from ideal, but we also provide a function that can be called from
> > an interrupt handler - which would be good to tie into the main Marvell
> > PHY driver.
> > 
> > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > drivers. The hardware is very similar to the implementation found in
> > the 88E6xxx DSA driver, but the access methods are very different,
> > although it may be possible to create a library that both can use
> > along with accessor functions.
> 
> I wanted to test it, but this patch does not build.
> 
> drivers/net/phy/marvell_ptp.c:269:33: error: passing argument 4 of ‘marvell_tai_probe’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   269 |                                 "Marvell PHY", dev);
>       |                                 ^~~~~~~~~~~~~
>       |                                 |
>       |                                 char *
> In file included from drivers/net/phy/marvell_ptp.c:9:
> ./include/linux/marvell_ptp.h:81:44: note: expected ‘struct ptp_pin_desc *’ but argument is of type ‘char *’
>    81 |                       struct ptp_pin_desc *pin_config, int n_pins,
>       |                       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
> drivers/net/phy/marvell_ptp.c:269:48: warning: passing argument 5 of ‘marvell_tai_probe’ makes integer from pointer without a cast [-Wint-conversion]
>   269 |                                 "Marvell PHY", dev);
>       |                                                ^~~
>       |                                                |
>       |                                                struct device *
> In file included from drivers/net/phy/marvell_ptp.c:9:
> ./include/linux/marvell_ptp.h:81:60: note: expected ‘int’ but argument is of type ‘struct device *’
>    81 |                       struct ptp_pin_desc *pin_config, int n_pins,
>       |                                                        ~~~~^~~~~~
> drivers/net/phy/marvell_ptp.c:267:15: error: too few arguments to function ‘marvell_tai_probe’
>   267 |         err = marvell_tai_probe(&tai, &marvell_phy_ptp_ops,
>       |               ^~~~~~~~~~~~~~~~~
> In file included from drivers/net/phy/marvell_ptp.c:9:
> ./include/linux/marvell_ptp.h:78:5: note: declared here
>    78 | int marvell_tai_probe(struct marvell_tai **taip,
>       |     ^~~~~~~~~~~~~~~~~
> 

Looks like it's because this patch is missing - it's marked in my tree
as a HACK and I don't remember why as it's been soo many years since I
was working on this.

I also have no way to test whether this even works (all of my platforms
that have any kind of PTP support don't wire any of the "ext" pins for
synchronisation.)

Simplest solution is as I said in my previous reply - pass NULL, 0 in
the appropriate place to marvell_tai_probe() and then this patch won't
be necessary.

8<===
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] net: phy: marvell TAI: pin support *HACK*

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/marvell_ptp.c | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/net/phy/marvell_ptp.c b/drivers/net/phy/marvell_ptp.c
index 3ba71c44ffb0..ff24d4a8ad41 100644
--- a/drivers/net/phy/marvell_ptp.c
+++ b/drivers/net/phy/marvell_ptp.c
@@ -29,6 +29,7 @@
 struct marvell_phy_ptp {
 	struct marvell_ptp ptp;
 	struct mii_timestamper mii_ts;
+	struct ptp_pin_desc pins[2];
 };
 
 static struct marvell_phy_ptp *mii_ts_to_phy_ptp(struct mii_timestamper *mii_ts)
@@ -101,6 +102,76 @@ static u64 marvell_phy_tai_clock_read(struct device *dev,
 	return lo | hi << 16;
 }
 
+static int marvell_phy_tai_extts_read(struct device *dev, int reg,
+				      struct marvell_extts *ts)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	int ret, oldpage;
+
+	oldpage = phy_select_page(phydev, MARVELL_PAGE_TAI_GLOBAL);
+	if (oldpage >= 0) {
+		ret = __phy_read(phydev, reg);
+		if (ret < 0)
+			goto restore;
+
+		ts->status = ret;
+		if (!(ts->status & MV_STATUS_EVENTCAPVALID)) {
+			ret = 0;
+			goto restore;
+		}
+
+		/* Read low timestamp */
+		ret = __phy_read(phydev, reg + 1);
+		if (ret < 0)
+			goto restore;
+
+		ts->time = ret;
+
+		/* Read high timestamp */
+		ret = __phy_read(phydev, reg + 2);
+		if (ret < 0)
+			goto restore;
+
+		ts->time |= ret << 16;
+
+		/* Clear valid */
+		__phy_write(phydev, reg, 0);
+
+		ret = 1;
+	}
+
+restore:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
+static int marvell_phy_tai_pin_verify(struct device *dev, int pin,
+				      enum ptp_pin_function func,
+				      unsigned int chan)
+{
+	if (pin == 1 && func == PTP_PF_EXTTS)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
+static int marvell_phy_tai_pin_setup(struct device *dev, int pin,
+				     unsigned int flags, int enable)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	struct marvell_phy_ptp *phy_ptp = mii_ts_to_phy_ptp(phydev->mii_ts);
+
+	if (phy_ptp->pins[pin].func != PTP_PF_EXTTS)
+		return -EOPNOTSUPP;
+
+	if (enable && (!(flags & PTP_RISING_EDGE) || flags & PTP_FALLING_EDGE))
+		return -EOPNOTSUPP;
+
+	/* Route LED[1] to event input */
+	return phy_modify_paged(phydev, MARVELL_PAGE_MISC, GCR,
+				GCR_PTP_INPUT_SOURCE,
+				enable ? GCR_PTP_INPUT_SOURCE : 0);
+}
+
 static int marvell_phy_tai_write(struct device *dev, u8 reg, u16 val)
 {
 	struct phy_device *phydev = to_phy_device(dev);
@@ -210,6 +281,9 @@ static long marvell_phy_ptp_aux_work(struct device *dev)
 static const struct marvell_ptp_ops marvell_phy_ptp_ops = {
 	.tai_enable = marvell_phy_tai_enable,
 	.tai_clock_read = marvell_phy_tai_clock_read,
+	.tai_extts_read = marvell_phy_tai_extts_read,
+	.tai_pin_verify = marvell_phy_tai_pin_verify,
+	.tai_pin_setup = marvell_phy_tai_pin_setup,
 	.tai_write = marvell_phy_tai_write,
 	.tai_modify = marvell_phy_tai_modify,
 	.ptp_global_write = marvell_phy_ptp_global_write,
@@ -225,6 +299,8 @@ static const struct marvell_tai_param marvell_phy_tai_param = {
 	.cc_mult_den = 15625U,
 	.cc_mult = 8 << 28,
 	.cc_shift = 28,
+
+	.n_ext_ts = 1,
 };
 
 /* This function should be called from the PHY threaded interrupt
@@ -263,9 +339,17 @@ int marvell_phy_ptp_probe(struct phy_device *phydev)
 	phy_ptp->mii_ts.hwtstamp = marvell_phy_ptp_hwtstamp;
 	phy_ptp->mii_ts.ts_info = marvell_phy_ptp_ts_info;
 
+	strscpy(phy_ptp->pins[0].name, "CONFIG", sizeof(phy_ptp->pins[0].name));
+	phy_ptp->pins[0].index = 0;
+	phy_ptp->pins[0].func = PTP_PF_NONE;
+	strscpy(phy_ptp->pins[1].name, "LED[1]", sizeof(phy_ptp->pins[1].name));
+	phy_ptp->pins[1].index = 0;
+	phy_ptp->pins[1].func = PTP_PF_NONE;
+
 	/* Get the TAI for this PHY. */
 	err = marvell_tai_probe(&tai, &marvell_phy_ptp_ops,
 				&marvell_phy_tai_param,
+				phy_ptp->pins, ARRAY_SIZE(phy_ptp->pins),
 			        "Marvell PHY", dev);
 	if (err)
 		return err;
-- 
2.30.2


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

