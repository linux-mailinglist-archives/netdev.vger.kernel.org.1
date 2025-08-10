Return-Path: <netdev+bounces-212365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10451B1FB06
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 18:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12423B5E4A
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1E23D2A0;
	Sun, 10 Aug 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqsg3gac"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED316157E6B;
	Sun, 10 Aug 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754843556; cv=none; b=a8unM+tzPQgsPrQamUdBlZgY7mJTJ2GhOwEyqIipykKSF6u7RK4vwx0zPWyUL4brPoSmKm4ioIvecxMzis8Vc2IXDvdSqv8B7ctQkIaPXi00DQmpwcexQxnol5T8Il3pMAIe1Hqz8E52W7bCElGOqbn+rQyNa/XkwPUleksOI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754843556; c=relaxed/simple;
	bh=c9gEEsNxj+x9pbEk5rYVT9g2jXSTWDkVgHLIFplCDUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw8MMF1l2rSIOdOrHuzrYoXycCQ7ppGOUzWXTFZW7r3ZXsk4KGAY3/n2hiMcbRWQ0c4+5Inh/Q6PsdL2OOelzIFy3c6RUHA7YNd154TK3Mc3ANC8yc3OsyfxNtWeziQ8tLoWxU2OrkLJYOPU8JNOOu3n554+Vwsv2Nahp0SnicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nqsg3gac; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b794c0b720so426880f8f.1;
        Sun, 10 Aug 2025 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754843553; x=1755448353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2rOo9oFeJToirvfpB6J/Lhvo2xvMGuGLJdL/jrK5OKk=;
        b=Nqsg3gactkV6u1piiIHdOt9mqvmMZwdrWImSVx9P9IGoijrAJA8BCzvHBBURKyscAJ
         X95FRvvCjDX11QkgwYhE6snADw1pHsTLSextsCAtTlaYCuLpO3EGy3Q2zwOwLkrUSw01
         LO3cLR5RTMA7ATj+SDFD95lyP2q9AxQRQuIgZEaMbKJLo7/yS+nA2POL6Khrktbvrxqr
         pDnIhCaZPiY5qReaN5ew9tcoN7daO5ZGUVzvxz6C3m/KC7+Dvsp9kQsZoEUojlPje74D
         UWYs1ebfuo7TlG+78ncbbkXF/cXEuKYdFhjhzt9LUluM+1UuIwlGVH39vJ+VptiZJb1n
         4JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754843553; x=1755448353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rOo9oFeJToirvfpB6J/Lhvo2xvMGuGLJdL/jrK5OKk=;
        b=PKD9Jq7tMR/9rnDoqCkOaCxfZDt65qxc9jy+NXxLrj/nt26i8Zn8nCVBsF2+jr7NNY
         7PRJjAz9SlnqtD7jk5tcfrLoljPWgZLhspFT8bPxngXf+EjlhJ8AUdIIRwW5quE6Umop
         v+ezdiHf1DCXF+tj1vVv2TU9Al2aSZLlOdHFMIVJW20RGHMMXb1evKedNl3VGfSIVWYs
         vUKgXvcNJQxsciww8eTN3xP++W8zodMR4dEwtGfuDSH5D6ftH6dm9zP1qxozWdV0R12H
         MrbyMJaxXEYVYj6bSuEwNYHI90extZWTTAgoqBrwcxQoZ/yQn413bBN0Ih1JpRE5Kwyd
         Y6oA==
X-Forwarded-Encrypted: i=1; AJvYcCUfDL9RhhuI7t6sPXqNOuj0BmaJkeWxVxAJnoZR5sxYev1VCXsXANL0F1px8AEn5TRaTNAEO9Z17BEgmXc=@vger.kernel.org, AJvYcCWrrxCqjJTSucekkvwl6/WubNhNwwkQ1fgcrCLB9JAAEPr8GTuvG3kbe3ZYuzDBj7BrM+itxn6i@vger.kernel.org
X-Gm-Message-State: AOJu0YzhF1hn8iFrMBw+gg+VSBVfYmB0mI9LwVZFKEAM0D8cC4XRaLlk
	6HTLgHGkPIDll9TtK4wFCBeO1vBS5drNYMD53fpY+4ihQ+5FNhB4OQAy
X-Gm-Gg: ASbGncuPORorv0GLJfdkQ7n5ngNnfCoHLglcZ8a4iVV7EkrkI3TpcHHaSngyMCGpZOb
	e+z2mi0uDzCAZeQ0oLoSu2GVxRDTRb/fY0GyvuRt0IbVn+DcfCHZbJQyQl6GFs0IVM0GKmS6tN7
	3Eem1yRv89NJ6xwHCRWgLTeQo0FTGpAh11VrW4we4zwMR2GL0gxvnwgbHq1zpsIHJeYztZJqmsQ
	FsjLm9LNWUoWYn5pAJXdtIUfquiKf22IS9epnRIrajWgVePRFD1IIIAqQyxCualvWQSKAA9yrK6
	yz1Gut2Lp5JnPmkCsrchuSrkU8jLsGWEXndcyBFRFJEUdkTui+Xa8HECdGsPevOI+1fGxhDiZdC
	yIvpaN7DFX4beQ3w=
X-Google-Smtp-Source: AGHT+IFzGJoHdY1WMREsnjDqYb+5+j4HV61VOnJ141EPHzzNV03WNSgwr3JXPrOlvg6sQOprtsbe2g==
X-Received: by 2002:a05:6000:2282:b0:3b7:95b2:2dd6 with SMTP id ffacd0b85a97d-3b906844e1amr1497341f8f.7.1754843552962;
        Sun, 10 Aug 2025 09:32:32 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:f9ef:f5a3:456e:8480])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459fb43b491sm83275295e9.3.2025.08.10.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 09:32:32 -0700 (PDT)
Date: Sun, 10 Aug 2025 19:32:29 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH/RFC net] net: dsa: lantiq_gswip: honor dsa_db passed to
 port_fdb_{add,del}
Message-ID: <20250810163229.otapw4mhtv7e35jp@skbuf>
References: <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <20250810130637.aa5bjkmpeg4uylnu@skbuf>
 <aJixPn_7gYd1o69V@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJixPn_7gYd1o69V@pidgin.makrotopia.org>

On Sun, Aug 10, 2025 at 03:48:30PM +0100, Daniel Golle wrote:
> [   66.300000] gswip 1e108000.switch: port 3 failed to add 6a:94:c2:xx:xx:xx vid 1 to fdb: -22
> [   66.300000] gswip 1e108000.switch: port 3 failed to add 1a:f8:a8:xx:xx:xx vid 0 to fdb: -22
> [   66.320000] gswip 1e108000.switch: port 3 failed to add 1a:f8:a8:xx:xx:xx vid 1 to fdb: -22
> [   66.320000] gswip 1e108000.switch: port 3 failed to delete 6a:94:c2:xx:xx:xx vid 1 from fdb: -2
> 
> So the problem is apparently that at the point of calling br_add_if() the
> port obviously isn't (yet) a member of the bridge and hence
> dsa_port_bridge_dev_get() would still return NULL at this point, which
> then causes gswip_port_fdb() to return -EINVAL.

Nope, this theory is false because the user port _is_ a member of the
bridge when it processes the SWITCHDEV_FDB_ADD_TO_DEVICE events.

There are 2 cases for handling these events. One is handling past events
which were missed and are re-generated during FDB replay:

[   65.510000] [<807ed128>] dsa_user_fdb_event+0x110/0x1c8
[   65.510000] [<807f89b8>] __switchdev_handle_fdb_event_to_device+0x138/0x228
[   65.510000] [<807f8ad8>] switchdev_handle_fdb_event_to_device+0x30/0x48
[   65.510000] [<807ec328>] dsa_user_switchdev_event+0x90/0xb0
[   65.510000] [<807c43c0>] br_switchdev_fdb_replay+0xd0/0x138
[   65.510000] [<807c4de8>] br_switchdev_port_offload+0x240/0x39c
[   65.510000] [<80799b6c>] br_switchdev_blocking_event+0x80/0xec
[   65.510000] [<80065e20>] raw_notifier_call_chain+0x48/0x88
[   65.510000] [<807f83e0>] switchdev_bridge_port_offload+0x5c/0xd0
[   65.510000] [<807e4c90>] dsa_port_bridge_join+0x170/0x410
[   65.510000] [<807ed5fc>] dsa_user_changeupper.part.0+0x40/0x180
[   65.510000] [<807f0ac0>] dsa_user_netdevice_event+0x5b4/0xc34
[   65.510000] [<80065e20>] raw_notifier_call_chain+0x48/0x88
[   65.510000] [<805edeec>] __netdev_upper_dev_link+0x1bc/0x450
[   65.510000] [<805ee1dc>] netdev_master_upper_dev_link+0x2c/0x38
[   65.510000] [<807a055c>] br_add_if+0x494/0x890

If you look at the order of operations, you'll see that:

int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
			 struct netlink_ext_ack *extack)
{
	...
	err = dsa_port_bridge_create(dp, br, extack); // this sets dp->bridge
	if (err)
		return err;

	brport_dev = dsa_port_to_bridge_port(dp);

	info.bridge = *dp->bridge;
	err = dsa_broadcast(DSA_NOTIFIER_BRIDGE_JOIN, &info); // this calls ds->ops->port_bridge_join()
	if (err)
		goto out_rollback;

	/* Drivers which support bridge TX forwarding should set this */
	dp->bridge->tx_fwd_offload = info.tx_fwd_offload;

	err = switchdev_bridge_port_offload(brport_dev, dev, dp,
					    &dsa_user_switchdev_notifier,
					    &dsa_user_switchdev_blocking_notifier,
					    dp->bridge->tx_fwd_offload, extack); // this calls br_switchdev_fdb_replay()
	if (err)
		goto out_rollback_unbridge;
	...
}

by the time br_switchdev_fdb_replay() is called, dp->bridge correctly
reflects the bridge that is generating the events.

The problem is not a race condition, the problem is that the driver does
not correctly handle host FDB entries.

The truly revealing step is to uncomment this:

	netdev_dbg(dev, "%s FDB entry towards %s, addr %pM vid %d%s\n",
		   event == SWITCHDEV_FDB_ADD_TO_DEVICE ? "Adding" : "Deleting",
		   orig_dev->name, fdb_info->addr, fdb_info->vid,
		   host_addr ? " as host address" : "");

and see it will print "as host address", meaning dsa_port_bridge_host_fdb_add()
will be called.

At the DSA cross-chip notifier layer, this generates a DSA_NOTIFIER_HOST_FDB_ADD
event rather than the port-level DSA_NOTIFIER_FDB_ADD. The major difference in
handling is that HOST_FDB_ADD events are matched by the *CPU* port, see
dsa_port_host_address_match().

The CPU port is not part of the bridge that generated the host FDB entry,
only the user port it services is.

The problem originates, roughly speaking, since commit 10fae4ac89ce
("net: dsa: include bridge addresses which are local in the host fdb
list"), which first appeared in v5.14. We rolled out a new feature using
existing API, and didn't notice the gswip driver wouldn't tolerate
ds->ops->port_fdb_add() getting called on the CPU port.

Anyway, your intuition for fixing this properly was somewhat correct.
Even if gswip does not implement FDB isolation, it is correct to look at
the dsa_db :: bridge member to see which bridge originated the host FDB
entry. That was its exact purpose, as documented in section "Address
databases" of Documentation/networking/dsa/dsa.rst. Even if cpu_dp->bridge
is NULL (as expected), drivers have to know on behalf of which user port
(member of a bridge) the CPU port is filtering an entry towards the host.
This is because CPU and DSA ports are servicing multiple address databases.

The only problem is that the API you're making use for fixing this was
introduced in commit c26933639b54 ("net: dsa: request drivers to perform
FDB isolation"), first appeared in v5.18. Thus, you can't fix an issue
in linux-5.15.y using this method, unless the API change is backported.

Alternatively, for stable kernels you could suppress the error and
return 0 in the gswip driver, with the appropriate comment that the API
doesn't communicate the bridge ID for host FDB entries, and thus, the
driver just won't filter them. Then, you could develop the solution
further for net-next, keeping in mind how things are supposed to work.

