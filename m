Return-Path: <netdev+bounces-243421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF398CA0458
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 18:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D78430006FC
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F5432FA07;
	Wed,  3 Dec 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RxRfiM+l"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C632F740;
	Wed,  3 Dec 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777583; cv=none; b=VW3YvNzDsOk6hRvagRhVwGCrjJko8O6LkP53fMpGnz8CcTrXOVGtN3Q6QvBjKpfUoEMQkPW2KCNltQU4dlYThPvrTYnxcxRebTjrv89gQr0IvhNVzoJJmKndj9LkDHmSH9QvJ+FS5/lBg8FSvNyVp3Obk+GSICh29bgBQLNOl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777583; c=relaxed/simple;
	bh=B36oONp39GILfEjUDrc8cwOGYq7/3VDI4lJqgOUo/wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrLO5GydSuf9iTgmOhwIZDtcy9no/543EIyUfTihjqDD7Ca1NgT7OnKEpVjr/eLfMGLzolitV9k2h227YIn4GhVXDVYZtymtcjhhjaoIC6y/wsLUpX/xgAd4DNOPI+6HgvdmOt98hmW+XqRtt1gzWa+WR11mgFfDn6SiYgCcH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RxRfiM+l; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BNrEYDusoPa2vxOXWr4+YH72hzHIHGHZr3/9V5K71zA=; b=RxRfiM+lTeAys3fOXt5OoysDpH
	9ZMEtXQ3T4m+ypoByBoNGmLIUCadTXiUafGbNPX6gtNXPWLd+iNsqX0lT+Mk6CT1hLlmwRygJ17I1
	3hgxUPaEcHvoi+v7RlUzp7y/+S2b4dp/4TzAfWW1B1p22jIalYck3OlK/UFuq1KH9VlQmBUz5cYJN
	cxBd1vB950ZTP2x2N91yI4JQ4EXGyWt3xJlMObs8pqwJXoyxco2Y9V6dmz+Uo2G7mAgutDKmv7zCH
	bN7q6WVHyRK8YCoVSgKKEeOtJN0ouZ/NkTxEeDFS7OgQt4DiW09coueoDEBiC3gBET5fZXQG5RV1r
	sxw9SC+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33336)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQpGE-000000002hx-414A;
	Wed, 03 Dec 2025 15:59:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQpG9-0000000008C-3Psp;
	Wed, 03 Dec 2025 15:59:17 +0000
Date: Wed, 3 Dec 2025 15:59:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Buday Csaba <buday.csaba@prolan.hu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: mdio: reset PHY before attempting
 to access ID register
Message-ID: <aTBeVTlsElGXUCSN@shell.armlinux.org.uk>
References: <5701a9faafd1769b650b79c2d0c72cc10b5bdbc8.1764337894.git.buday.csaba@prolan.hu>
 <79c050e9-83e7-4cc5-979e-457f098024bf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c050e9-83e7-4cc5-979e-457f098024bf@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 02, 2025 at 02:46:42PM +0100, Andrew Lunn wrote:
> > @@ -13,9 +13,12 @@
> >  #include <linux/phy.h>
> >  #include <linux/pse-pd/pse.h>
> >  
> > +#include "../phy/mdio-private.h"
> 
> Relative imports are generally not allowed. It sometimes suggests
> layering violations.
> 
> I'm not convinced the complexity and ugliness of partially registering
> a device in order to be able to reset it, is worth the effort when we
> have a simpler solution of just using the ID values in DT.
> 
> Give the merge window, i will mark this as change request for the
> moment.

It seems to me that PHY clocks and resets are a never-ending source of
problems, so I'm wondering whether we need to consider a radically
different solution, rather than keeping trying to put sticky plasters
over this in various different forms.

__mdiobus_register() is a path where deferred probing is possible,
and this is responsible for doing the bus scan, which is one source
of the problems.

If we add a new ops structure for firmware methods:

struct mii_bus_fw_ops {
	int (*init)(struct mii_bus *bus);
	int (*prescan)(struct mii_bus *bus);
	void (*postscan)(struct mii_bus *bus);
	void (*release)(struct mii_bus *bus);
};

This would be provided when we have e.g. a MII bus described in DT.

The init() method would be called by __mdiobus_register() before:

        err = device_register(&bus->dev);

and this method would:
- walk the sub-nodes of the bus, looking for reset and clock resources.
- it gets the reset and clock resources that are found.
- any that return deferred probe can safely propagate that error code.

__mdiobus_register() would then do its reset stuff, and then before
doing the scans, call the prescan() method. This will:

- walk the resources found in the init() method, noting the initial
  state of resets, then enabling clocks and finally releasing any
  resets.

During the scan, if a device is probed, then we need to consider how
to handle a potential updated reset state. Unlike clocks, which are
nestable, resets aren't. We don't want to re-assert a reset signal
if the PHY driver has specifically asked for it to be deasserted in
its probe() method.

After the bus scans have completed, then the postscan() op would be
called, and this will:

- walk the resources again, restoring the reset state (note the
  comment above concerning PHY driver probe()) and disabling
  any clocks (if the clock has already been "got" by something, e.g.
  a driver that probed as a result of successful scan, this doesn't
  affect it.)

The release() method would be called whenever we are unregistering
the bus (after device_del(&bus->dev) in __mdiobus_register() and
mdiobus_unregister()).

Maybe we should also consider whether phylib should have functions
for PHY drivers to call to control these resources that it has
obtained for each PHY device too?

Yes, this is a bigger change, but I think it should put a stop to
the dribble of problems that seem to be cropping up around the bus
scanning. It can be easily extended for other resources (e.g.
regulators) that are needed to scan and probe, and should also
avoid the need for relative-path includes.

If there are buses that we need to actively assert the reset, then
I feel that this should itself be a firmware property of the device,
as there are likely platforms that come up with the PHY already
released from reset and in a functional state, and causing their
link to drop by forcing a reset of the PHY could be undesirable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

