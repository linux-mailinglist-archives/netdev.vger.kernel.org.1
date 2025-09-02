Return-Path: <netdev+bounces-219288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A4B40E98
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A11556001C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DBC2E7647;
	Tue,  2 Sep 2025 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6osey4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931294A2D;
	Tue,  2 Sep 2025 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845637; cv=none; b=ImniHLo6kdZGq28XvRu5cMEh0W0GaMFJskOVlL9TX7zXDXIGrRf7fsQKiAZqiQ+6nC4kHG7TGE4c6ld/aDLWjX9XGQXM2we82nbqIYaAiTe517LsvCcngfxwndtW31plmrF9Cb11U6cp0KOqVXNr5NscL+FESVrXo/VdI2X9jBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845637; c=relaxed/simple;
	bh=WEHUUPNxQZrhEFxyGChJp8/cQIz5d8XM0qizCMR3v/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMaiAVqQpyQJ4Ke/vk+8XUrcTkAUsYpJPVdPsGNOnq/tXLdTdgSaSLM7ld3aZo+d7HFs/qTkHWS3vX68gOhZUEvdVLXQ6ih388AV7fMm5YavafpoLcXLxZ3/ySIzbyuY52J8TOTX857wCx/ExBxO92JBzKSBC86WZTR0NiaGP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6osey4q; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso4922076b3a.2;
        Tue, 02 Sep 2025 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756845635; x=1757450435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5158Zf4WCcOGY+QOB2Pve8WpYywNi1pdBq5czxFZQY=;
        b=B6osey4q0fUuFdYDWWUJvDfy10DNNLNufSCJkdYza9DCiE6E2/gGchOyAbtmilivML
         VBKxwaY5gX7G0XNn3h8WM9JT8VoWWFz2kX2/pCKCSG+u2zVgKcuXZyRim3znq/IZjh9q
         KjYy76nq9KA4ZNr6vWTQnlxz8NS3+97pK0ePY3hb5Z+0RftWU/CMWrm34qP5jDNZ6dan
         180GKQv+2J5hTBypykNJkohOoVv4CbPX/pqu7SvuZTJSNo05iUNeRWC03HYNyWaS3wis
         bUIjI5zoB9+rAK223pGBO9hnq70/hp38JavwqoIHIk4Ox0ephhgAnWEc8LpYHfuLQD8m
         CWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756845635; x=1757450435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5158Zf4WCcOGY+QOB2Pve8WpYywNi1pdBq5czxFZQY=;
        b=oDaNS0eHUL3LTKdDHUtMO552UbLMBQW1Vmhhy7H5ktVML92tLcMO0to3Whx+NUxn8Y
         FfjIyxx65jZhrzODx//Hy9+kK+1X3X7+XzJNwg6H7/C7CyvApzOPcY8Pf0cqb2gO/ew4
         pIDESfq4MKWH1A5Jh4gxE4GcXRb6rCWnF8afbhh9oaoNgQAsdwkAYilHhi8T3H0E1qK7
         GlkPIM/0mT2VxblkchEipmSM+cf+dlEbctNBlOYajrzsQ/hqrvRh+jgxbYXxR22pMwFA
         IA5KtcpWMTcTb7/vUs+yndqVgikPh6PDr+p9nadKgZ56zZ45JVG14vy3WLblKtwaSO65
         LFkg==
X-Forwarded-Encrypted: i=1; AJvYcCXuOMdB+BQjg90w8i/G6LtzzJiUSqlowTCyTC30mB/00Qmc7KWfEKuudpLR8fN4J8KvHH0zN0OVG6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5MsnMYLeyx4Eb4Fhl96sXOUiHUyF9TPW/dR8XAlfggaDHD/Y
	b1z7aSw63TOJ0H0knzskLLUQStiTaPNLAPnezHVb/wexmuQRwgfEoM8=
X-Gm-Gg: ASbGncuSk72S61Ic4zWB/rA4RbDYxBQzODaiBCm0XI96C4d14S9dkcortehPKrqzHRi
	YxKFn9YfybxocOaaGOEOEreO6LCkacJO0rKIQitKKp0v4Kx8nLbrc9qa8dmUvb2aXdjwGIhE/jE
	SqQWRc7F+phdYjWQJAEflje0Kj6zu4a2nP6v2l1kCHzxmn5XdYPI6PmcQ9TzSRN8TszX/TCsHYX
	rzQ1+tKQxHMKGhcTxe9h7GpXHdgWQu9Equ9dGxAz0YuBzacsbmwjTmJ7ZgAjMASVRJgQnQTEg45
	+Cd8kWfXQyIeTP/1J1mmWxun1dw0BIV6Xk307kj4qG+h988uZv27eSl5Bj6n2/Pnqv9anieS+lP
	86uCrXfUy9tolVuXD4UgIq/UPShSIKCPoubNw2BCoponpmoS0i7BuLKnzZSX/UgsRkv1djmqlyX
	IQpjFSxGk/4Z5lcnlsUC6d4APPC+4yeKiw+sUDhBzJHGNlzCpcb0FWj8iLe5bynpCxjMJOn8c3h
	oWKsJMWqoz12SE=
X-Google-Smtp-Source: AGHT+IGmbz2RswZWb+BBppLHNIr8CzRN+5aXuAzVj4jWPVksvTuRwxS8Vknqcvw1FxcuL2ulsolE8A==
X-Received: by 2002:a05:6a00:114b:b0:771:d7b0:6944 with SMTP id d2e1a72fcca58-7723e21ed20mr13241963b3a.3.1756845634438;
        Tue, 02 Sep 2025 13:40:34 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a71c60bsm14169978b3a.103.2025.09.02.13.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 13:40:34 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:40:33 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier
Message-ID: <aLdWQXU12AIEsAYu@mini-arch>
References: <2029487.1756512517@famine>
 <aLcXNO6ginmuiBOw@mini-arch>
 <2351814.1756842974@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2351814.1756842974@famine>

On 09/02, Jay Vosburgh wrote:
> Stanislav Fomichev <stfomichev@gmail.com> wrote:
> 
> >On 08/29, Jay Vosburgh wrote:
> >> 	 Remove the implementation of use_carrier, the link monitoring
> >> method that utilizes ethtool or ioctl to determine the link state of an
> >> interface in a bond.  Bonding will always behaves as if use_carrier=1,
> >> which relies on netif_carrier_ok() to determine the link state of
> >> interfaces.
> >> 
> >> 	To avoid acquiring RTNL many times per second, bonding inspects
> >> link state under RCU, but not under RTNL.  However, ethtool
> >> implementations in drivers may sleep, and therefore this strategy is
> >> unsuitable for use with calls into driver ethtool functions.
> >> 
> >> 	The use_carrier option was introduced in 2003, to provide
> >> backwards compatibility for network device drivers that did not support
> >> the then-new netif_carrier_ok/on/off system.  Device drivers are now
> >> expected to support netif_carrier_*, and the use_carrier backwards
> >> compatibility logic is no longer necessary.
> >> 
> >> 	The option itself remains, but when queried always returns 1,
> >> and may only be set to 1.
> >> 
> >> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> >> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> >> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
> >> 
> >> ---
> >> 
> >> Note: Deliberately omitting a Fixes tag to avoid removing functionality
> >> in older kernels that may be in use.
> >
> >What about syzbot metadata?
> >
> >Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
> >Closes: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> >
> >?
> 
> 	I can add these and repost in a day or so.
> 
> >>  Documentation/networking/bonding.rst |  79 +++----------------
> >>  drivers/net/bonding/bond_main.c      | 113 ++-------------------------
> >>  drivers/net/bonding/bond_netlink.c   |  14 ++--
> >>  drivers/net/bonding/bond_options.c   |   7 +-
> >>  drivers/net/bonding/bond_sysfs.c     |   6 +-
> >>  include/net/bonding.h                |   1 -
> >>  6 files changed, 28 insertions(+), 192 deletions(-)
> >> 
> >> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> >> index f8f5766703d4..a2b42ae719d2 100644
> >> --- a/Documentation/networking/bonding.rst
> >> +++ b/Documentation/networking/bonding.rst
> >> @@ -582,10 +582,8 @@ miimon
> >>  	This determines how often the link state of each slave is
> >>  	inspected for link failures.  A value of zero disables MII
> >>  	link monitoring.  A value of 100 is a good starting point.
> >> -	The use_carrier option, below, affects how the link state is
> >> -	determined.  See the High Availability section for additional
> >> -	information.  The default value is 100 if arp_interval is not
> >> -	set.
> >> +
> >> +	The default value is 100 if arp_interval is not set.
> >>  
> >>  min_links
> >>  
> >> @@ -896,25 +894,14 @@ updelay
> >>  
> >>  use_carrier
> >>  
> >> -	Specifies whether or not miimon should use MII or ETHTOOL
> >> -	ioctls vs. netif_carrier_ok() to determine the link
> >> -	status. The MII or ETHTOOL ioctls are less efficient and
> >> -	utilize a deprecated calling sequence within the kernel.  The
> >> -	netif_carrier_ok() relies on the device driver to maintain its
> >> -	state with netif_carrier_on/off; at this writing, most, but
> >> -	not all, device drivers support this facility.
> >> -
> >> -	If bonding insists that the link is up when it should not be,
> >> -	it may be that your network device driver does not support
> >> -	netif_carrier_on/off.  The default state for netif_carrier is
> >> -	"carrier on," so if a driver does not support netif_carrier,
> >> -	it will appear as if the link is always up.  In this case,
> >> -	setting use_carrier to 0 will cause bonding to revert to the
> >> -	MII / ETHTOOL ioctl method to determine the link state.
> >> -
> >> -	A value of 1 enables the use of netif_carrier_ok(), a value of
> >> -	0 will use the deprecated MII / ETHTOOL ioctls.  The default
> >> -	value is 1.
> >> +	Obsolete option that previously selected between MII /
> >> +	ETHTOOL ioctls and netif_carrier_ok() to determine link
> >> +	state.
> >> +
> >> +	All link state checks are now done with netif_carrier_ok().
> >> +
> >> +	For backwards compatibility, this option's value may be inspected
> >> +	or set.  The only valid setting is 1.
> >>  
> >>  xmit_hash_policy
> >>  
> >> @@ -2036,22 +2023,8 @@ depending upon the device driver to maintain its carrier state, by
> >>  querying the device's MII registers, or by making an ethtool query to
> >>  the device.
> >>  
> >> -If the use_carrier module parameter is 1 (the default value),
> >> -then the MII monitor will rely on the driver for carrier state
> >> -information (via the netif_carrier subsystem).  As explained in the
> >> -use_carrier parameter information, above, if the MII monitor fails to
> >> -detect carrier loss on the device (e.g., when the cable is physically
> >> -disconnected), it may be that the driver does not support
> >> -netif_carrier.
> >> -
> >> -If use_carrier is 0, then the MII monitor will first query the
> >> -device's (via ioctl) MII registers and check the link state.  If that
> >> -request fails (not just that it returns carrier down), then the MII
> >> -monitor will make an ethtool ETHTOOL_GLINK request to attempt to obtain
> >> -the same information.  If both methods fail (i.e., the driver either
> >> -does not support or had some error in processing both the MII register
> >> -and ethtool requests), then the MII monitor will assume the link is
> >> -up.
> >> +The MII monitor relies on the driver for carrier state information (via
> >> +the netif_carrier subsystem).
> >>  
> >>  8. Potential Sources of Trouble
> >>  ===============================
> >> @@ -2135,34 +2108,6 @@ This will load tg3 and e1000 modules before loading the bonding one.
> >>  Full documentation on this can be found in the modprobe.d and modprobe
> >>  manual pages.
> >>  
> >> -8.3. Painfully Slow Or No Failed Link Detection By Miimon
> >> ----------------------------------------------------------
> >> -
> >> -By default, bonding enables the use_carrier option, which
> >> -instructs bonding to trust the driver to maintain carrier state.
> >> -
> >> -As discussed in the options section, above, some drivers do
> >> -not support the netif_carrier_on/_off link state tracking system.
> >> -With use_carrier enabled, bonding will always see these links as up,
> >> -regardless of their actual state.
> >> -
> >> -Additionally, other drivers do support netif_carrier, but do
> >> -not maintain it in real time, e.g., only polling the link state at
> >> -some fixed interval.  In this case, miimon will detect failures, but
> >> -only after some long period of time has expired.  If it appears that
> >> -miimon is very slow in detecting link failures, try specifying
> >> -use_carrier=0 to see if that improves the failure detection time.  If
> >> -it does, then it may be that the driver checks the carrier state at a
> >> -fixed interval, but does not cache the MII register values (so the
> >> -use_carrier=0 method of querying the registers directly works).  If
> >> -use_carrier=0 does not improve the failover, then the driver may cache
> >> -the registers, or the problem may be elsewhere.
> >> -
> >> -Also, remember that miimon only checks for the device's
> >> -carrier state.  It has no way to determine the state of devices on or
> >> -beyond other ports of a switch, or if a switch is refusing to pass
> >> -traffic while still maintaining carrier on.
> >> -
> >>  9. SNMP agents
> >>  ===============
> >>  
> >> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >> index 257333c88710..f25c2d2c9181 100644
> >> --- a/drivers/net/bonding/bond_main.c
> >> +++ b/drivers/net/bonding/bond_main.c
> >> @@ -142,8 +142,7 @@ module_param(downdelay, int, 0);
> >>  MODULE_PARM_DESC(downdelay, "Delay before considering link down, "
> >>  			    "in milliseconds");
> >>  module_param(use_carrier, int, 0);
> >> -MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in miimon; "
> >> -			      "0 for off, 1 for on (default)");
> >> +MODULE_PARM_DESC(use_carrier, "option obsolete, use_carrier cannot be disabled");
> >>  module_param(mode, charp, 0);
> >>  MODULE_PARM_DESC(mode, "Mode of operation; 0 for balance-rr, "
> >>  		       "1 for active-backup, 2 for balance-xor, "
> >> @@ -830,77 +829,6 @@ const char *bond_slave_link_status(s8 link)
> >>  	}
> >>  }
> >>  
> >> -/* if <dev> supports MII link status reporting, check its link status.
> >> - *
> >> - * We either do MII/ETHTOOL ioctls, or check netif_carrier_ok(),
> >> - * depending upon the setting of the use_carrier parameter.
> >> - *
> >> - * Return either BMSR_LSTATUS, meaning that the link is up (or we
> >> - * can't tell and just pretend it is), or 0, meaning that the link is
> >> - * down.
> >> - *
> >> - * If reporting is non-zero, instead of faking link up, return -1 if
> >> - * both ETHTOOL and MII ioctls fail (meaning the device does not
> >> - * support them).  If use_carrier is set, return whatever it says.
> >> - * It'd be nice if there was a good way to tell if a driver supports
> >> - * netif_carrier, but there really isn't.
> >> - */
> >> -static int bond_check_dev_link(struct bonding *bond,
> >> -			       struct net_device *slave_dev, int reporting)
> >> -{
> >> -	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
> >> -	struct mii_ioctl_data *mii;
> >> -	struct ifreq ifr;
> >> -	int ret;
> >> -
> >> -	if (!reporting && !netif_running(slave_dev))
> >> -		return 0;
> >> -
> >> -	if (bond->params.use_carrier)
> >> -		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
> >> -
> >> -	/* Try to get link status using Ethtool first. */
> >> -	if (slave_dev->ethtool_ops->get_link) {
> >> -		netdev_lock_ops(slave_dev);
> >> -		ret = slave_dev->ethtool_ops->get_link(slave_dev);
> >> -		netdev_unlock_ops(slave_dev);
> >> -
> >> -		return ret ? BMSR_LSTATUS : 0;
> >> -	}
> >> -
> >> -	/* Ethtool can't be used, fallback to MII ioctls. */
> >> -	if (slave_ops->ndo_eth_ioctl) {
> >> -		/* TODO: set pointer to correct ioctl on a per team member
> >> -		 *       bases to make this more efficient. that is, once
> >> -		 *       we determine the correct ioctl, we will always
> >> -		 *       call it and not the others for that team
> >> -		 *       member.
> >> -		 */
> >> -
> >> -		/* We cannot assume that SIOCGMIIPHY will also read a
> >> -		 * register; not all network drivers (e.g., e100)
> >> -		 * support that.
> >> -		 */
> >> -
> >> -		/* Yes, the mii is overlaid on the ifreq.ifr_ifru */
> >> -		strscpy_pad(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
> >> -		mii = if_mii(&ifr);
> >> -
> >> -		if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIPHY) == 0) {
> >> -			mii->reg_num = MII_BMSR;
> >> -			if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIREG) == 0)
> >> -				return mii->val_out & BMSR_LSTATUS;
> >> -		}
> >> -	}
> >> -
> >> -	/* If reporting, report that either there's no ndo_eth_ioctl,
> >> -	 * or both SIOCGMIIREG and get_link failed (meaning that we
> >> -	 * cannot report link status).  If not reporting, pretend
> >> -	 * we're ok.
> >> -	 */
> >> -	return reporting ? -1 : BMSR_LSTATUS;
> >> -}
> >> -
> >>  /*----------------------------- Multicast list ------------------------------*/
> >>  
> >>  /* Push the promiscuity flag down to appropriate slaves */
> >> @@ -1966,7 +1894,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >>  	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
> >>  	struct slave *new_slave = NULL, *prev_slave;
> >>  	struct sockaddr_storage ss;
> >> -	int link_reporting;
> >>  	int res = 0, i;
> >>  
> >>  	if (slave_dev->flags & IFF_MASTER &&
> >> @@ -1976,12 +1903,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >>  		return -EPERM;
> >>  	}
> >>  
> >> -	if (!bond->params.use_carrier &&
> >> -	    slave_dev->ethtool_ops->get_link == NULL &&
> >> -	    slave_ops->ndo_eth_ioctl == NULL) {
> >> -		slave_warn(bond_dev, slave_dev, "no link monitoring support\n");
> >> -	}
> >> -
> >>  	/* already in-use? */
> >>  	if (netdev_is_rx_handler_busy(slave_dev)) {
> >>  		SLAVE_NL_ERR(bond_dev, slave_dev, extack,
> >> @@ -2195,29 +2116,10 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> >>  
> >>  	new_slave->last_tx = new_slave->last_rx;
> >>  
> >> -	if (bond->params.miimon && !bond->params.use_carrier) {
> >> -		link_reporting = bond_check_dev_link(bond, slave_dev, 1);
> >> -
> >> -		if ((link_reporting == -1) && !bond->params.arp_interval) {
> >> -			/* miimon is set but a bonded network driver
> >> -			 * does not support ETHTOOL/MII and
> >> -			 * arp_interval is not set.  Note: if
> >> -			 * use_carrier is enabled, we will never go
> >> -			 * here (because netif_carrier is always
> >> -			 * supported); thus, we don't need to change
> >> -			 * the messages for netif_carrier.
> >> -			 */
> >> -			slave_warn(bond_dev, slave_dev, "MII and ETHTOOL support not available for slave, and arp_interval/arp_ip_target module parameters not specified, thus bonding will not detect link failures! see bonding.txt for details\n");
> >> -		} else if (link_reporting == -1) {
> >> -			/* unable get link status using mii/ethtool */
> >> -			slave_warn(bond_dev, slave_dev, "can't get link status from slave; the network driver associated with this interface does not support MII or ETHTOOL link status reporting, thus miimon has no effect on this interface\n");
> >> -		}
> >> -	}
> >> -
> >>  	/* check for initial state */
> >>  	new_slave->link = BOND_LINK_NOCHANGE;
> >>  	if (bond->params.miimon) {
> >> -		if (bond_check_dev_link(bond, slave_dev, 0) == BMSR_LSTATUS) {
> >> +		if (netif_carrier_ok(slave_dev)) {
> >>  			if (bond->params.updelay) {
> >>  				bond_set_slave_link_state(new_slave,
> >>  							  BOND_LINK_BACK,
> >> @@ -2759,7 +2661,7 @@ static int bond_miimon_inspect(struct bonding *bond)
> >>  	bond_for_each_slave_rcu(bond, slave, iter) {
> >>  		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
> >>  
> >> -		link_state = bond_check_dev_link(bond, slave->dev, 0);
> >> +		link_state = netif_carrier_ok(slave->dev);
> >>  
> >>  		switch (slave->link) {
> >>  		case BOND_LINK_UP:
> >> @@ -6257,10 +6159,10 @@ static int __init bond_check_params(struct bond_params *params)
> >>  		downdelay = 0;
> >>  	}
> >>  
> >> -	if ((use_carrier != 0) && (use_carrier != 1)) {
> >> -		pr_warn("Warning: use_carrier module parameter (%d), not of valid value (0/1), so it was set to 1\n",
> >> -			use_carrier);
> >> -		use_carrier = 1;
> >> +	if (use_carrier != 1) {
> >> +		pr_err("Error: invalid use_carrier parameter (%d)\n",
> >> +		       use_carrier);
> >> +		return -EINVAL;
> >>  	}
> >>  
> >>  	if (num_peer_notif < 0 || num_peer_notif > 255) {
> >> @@ -6507,7 +6409,6 @@ static int __init bond_check_params(struct bond_params *params)
> >>  	params->updelay = updelay;
> >>  	params->downdelay = downdelay;
> >>  	params->peer_notif_delay = 0;
> >> -	params->use_carrier = use_carrier;
> >>  	params->lacp_active = 1;
> >>  	params->lacp_fast = lacp_fast;
> >>  	params->primary[0] = 0;
> >> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> >> index 57fff2421f1b..e573b34a1bbc 100644
> >> --- a/drivers/net/bonding/bond_netlink.c
> >> +++ b/drivers/net/bonding/bond_netlink.c
> >> @@ -259,13 +259,11 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
> >>  			return err;
> >>  	}
> >>  	if (data[IFLA_BOND_USE_CARRIER]) {
> >> -		int use_carrier = nla_get_u8(data[IFLA_BOND_USE_CARRIER]);
> >> -
> >> -		bond_opt_initval(&newval, use_carrier);
> >> -		err = __bond_opt_set(bond, BOND_OPT_USE_CARRIER, &newval,
> >> -				     data[IFLA_BOND_USE_CARRIER], extack);
> >> -		if (err)
> >> -			return err;
> >> +		if (nla_get_u8(data[IFLA_BOND_USE_CARRIER]) != 1) {
> >> +			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_BOND_USE_CARRIER],
> >> +					    "option obsolete, use_carrier cannot be disabled");
> >> +			return -EINVAL;
> >> +		}
> >>  	}
> >>  	if (data[IFLA_BOND_ARP_INTERVAL]) {
> >>  		int arp_interval = nla_get_u32(data[IFLA_BOND_ARP_INTERVAL]);
> >> @@ -688,7 +686,7 @@ static int bond_fill_info(struct sk_buff *skb,
> >>  			bond->params.peer_notif_delay * bond->params.miimon))
> >>  		goto nla_put_failure;
> >>  
> >> -	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, bond->params.use_carrier))
> >> +	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, 1))
> >>  		goto nla_put_failure;
> >>  
> >>  	if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL, bond->params.arp_interval))
> >> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> >> index 3b6f815c55ff..c0a5eb8766b5 100644
> >> --- a/drivers/net/bonding/bond_options.c
> >> +++ b/drivers/net/bonding/bond_options.c
> >> @@ -187,7 +187,6 @@ static const struct bond_opt_value bond_primary_reselect_tbl[] = {
> >>  };
> >>  
> >>  static const struct bond_opt_value bond_use_carrier_tbl[] = {
> >> -	{ "off", 0,  0},
> >>  	{ "on",  1,  BOND_VALFLAG_DEFAULT},
> >>  	{ NULL,  -1, 0}
> >>  };
> >> @@ -419,7 +418,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
> >>  	[BOND_OPT_USE_CARRIER] = {
> >>  		.id = BOND_OPT_USE_CARRIER,
> >>  		.name = "use_carrier",
> >> -		.desc = "Use netif_carrier_ok (vs MII ioctls) in miimon",
> >> +		.desc = "option obsolete, use_carrier cannot be disabled",
> >>  		.values = bond_use_carrier_tbl,
> >>  		.set = bond_option_use_carrier_set
> >>  	},
> >> @@ -1091,10 +1090,6 @@ static int bond_option_peer_notif_delay_set(struct bonding *bond,
> >>  static int bond_option_use_carrier_set(struct bonding *bond,
> >>  				       const struct bond_opt_value *newval)
> >>  {
> >> -	netdev_dbg(bond->dev, "Setting use_carrier to %llu\n",
> >> -		   newval->value);
> >> -	bond->params.use_carrier = newval->value;
> >> -
> >>  	return 0;
> >
> >Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> >nit: any reason not to return -EINVAL here when the new value is not "1"?
> >You do it for the module param, but not for the sysfs file here.
> 
> 	For the sysfs option path, the new setting is validated against
> the contents of use_carrier_tbl by __bond_opt_set before the above is
> called, so we don't need to check it here.  The sysfs parsing accepts
> either the number 1 or the text "on", so it's a bit more complicated.

Ah, I missed that .values validation part, thanks for the explanation!

