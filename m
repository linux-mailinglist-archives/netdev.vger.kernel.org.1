Return-Path: <netdev+bounces-259036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFZZAYxylGntDwIAu9opvQ
	(envelope-from <netdev+bounces-259036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:52:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4D14CC5B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354853007F4C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2777336AB72;
	Tue, 17 Feb 2026 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BYlL+joc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FE36164C;
	Tue, 17 Feb 2026 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336300; cv=none; b=J/vAqeRVe6lXzCoIbJFfCbz2USSJaSOTT7CYLPbLPG+4NU9vYgbmtRsD1N2BqzBOnNSsquLPwJynlCsPzexPuUl0XPCLc5b1b/8US7Au2BnrF9ftSnk00VVdMZCY9dvNLLJ1RVHfBx+dG8+1946qEKbtb/Iv60Q6rezehPyJzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336300; c=relaxed/simple;
	bh=JifY4cxqIDgOnWSv7Xr6rpbR1tA6sL7TqoYA3RTL4Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7XM+RPQ1TQCVimPz/xiCrz6D5OtS/YpMMgc5hxeQNIlmsFdc6+BOAvv58wdPB9OpcK1wVEwWbIYpKnBkTPpr4KJZ4Vk1M78ndK/sYj6T6oVRj7wnPfxRZpU0jIFgB8FK/gHvlg3DG+AFi6BE71HtyHm6gzoZhxDB8NpANLNXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BYlL+joc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KzubmU1ZR4qO5tPvu/ggmGbkoORAmw+LYtfRmNPB2jQ=; b=BYlL+jocubRl5wCDYBd959Aj7t
	4LEbIlRcac51FFL8xp0I/ACvEOKcl4dTMdwzQajHApt4Aaa5GO4BJFpFFxhoyPo8uBF4ge2tVli9K
	Zs7YCt/CexEPgN4vhsH/3o2ik/fcGElLK1oBKmIiTrAq5Vb6ER7IPNnWaF/tR9mUkEpo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsLU5-007dwd-Vg; Tue, 17 Feb 2026 14:51:25 +0100
Date: Tue, 17 Feb 2026 14:51:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: guard link replay helpers against
 NULL phylink instance
Message-ID: <877b4780-9f99-478c-82fa-a32817d72004@lunn.ch>
References: <20260205192344.21797-1-vladimir.oltean@nxp.com>
 <173190b1-aed6-4366-bb7d-c6ea64d26899@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173190b1-aed6-4366-bb7d-c6ea64d26899@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,vger.kernel.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-259036-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59D4D14CC5B
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 09:22:25AM +0100, Paolo Abeni wrote:
> On 2/5/26 8:23 PM, Vladimir Oltean wrote:
> > There is a crash when unbinding the sja1105 driver under special
> > circumstances:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> > Call trace:
> > phylink_run_resolve_and_disable+0x10/0x90
> > sja1105_static_config_reload+0xc0/0x410
> > sja1105_vlan_filtering+0x100/0x140
> > dsa_port_vlan_filtering+0x13c/0x368
> > dsa_port_reset_vlan_filtering.isra.0+0xe8/0x198
> > dsa_port_bridge_leave+0x130/0x248
> > dsa_user_changeupper.part.0+0x74/0x158
> > dsa_user_netdevice_event+0x50c/0xa50
> > notifier_call_chain+0x78/0x148
> > raw_notifier_call_chain+0x20/0x38
> > call_netdevice_notifiers_info+0x58/0xa8
> > __netdev_upper_dev_unlink+0xac/0x220
> > netdev_upper_dev_unlink+0x38/0x70
> > del_nbp+0x1a4/0x320
> > br_del_if+0x3c/0xd8
> > br_device_event+0xf8/0x2d8
> > notifier_call_chain+0x78/0x148
> > raw_notifier_call_chain+0x20/0x38
> > call_netdevice_notifiers_info+0x58/0xa8
> > unregister_netdevice_many_notify+0x314/0x848
> > unregister_netdevice_queue+0xe8/0xf8
> > dsa_user_destroy+0x50/0xa8
> > dsa_port_teardown+0x80/0x98
> > dsa_switch_teardown_ports+0x4c/0xb8
> > dsa_switch_deinit+0x94/0xb8
> > dsa_switch_put_tree+0x2c/0xc0
> > dsa_unregister_switch+0x38/0x60
> > sja1105_remove+0x24/0x40
> > spi_remove+0x38/0x60
> > device_remove+0x54/0x90
> > device_release_driver_internal+0x1d4/0x230
> > device_driver_detach+0x20/0x38
> > unbind_store+0xbc/0xc8
> > ---[ end trace 0000000000000000 ]---
> > 
> > which requires an explanation.
> > 
> > When a port offloads a bridge, the switch must be reset to change
> > the VLAN awareness state (the SJA1105_VLAN_FILTERING reason for
> > sja1105_static_config_reload()). When the port leaves a VLAN-aware
> > bridge, it must also be reset for the same reason: it is returning
> > to operation as a VLAN-unaware standalone port.
> > 
> > sja1105_static_config_reload() triggers the phylink link replay helpers.
> > 
> > Because sja1105 is a switch, it has multiple user ports. During unbind,
> > ports are torn down one by one in dsa_switch_teardown_ports() ->
> > dsa_port_teardown() -> dsa_user_destroy().
> > 
> > The crash happens when the numerically first user port is not part of
> > the VLAN-aware bridge, but any other user port is.
> > 
> > Tearing down the first user port causes phylink_destroy() to be called
> > on dp->pl, and this pointer to be set to NULL. Then, when the second
> > user port is torn down, this was offloading a VLAN-aware bridge port, so
> > indirectly it will trigger sja1105_static_config_reload().
> > 
> > The latter function iterates using dsa_switch_for_each_available_port(),
> > and unconditionally dereferences dp->pl, including for the
> > aforementioned torn down previous port, and passes that to phylink.
> > This is where the NULL pointer is coming from.
> > 
> > There are multiple levels at which this could be avoided:
> > - add an "if (dp->pl)" in sja1105_static_config_reload()
> > - make the phylink replay helpers NULL-tolerant
> > - mark ports as DSA_PORT_TYPE_UNUSED after dsa_port_phylink_destroy()
> >   has run, such that subsequent dsa_switch_for_each_available_port()
> >   iterations skip them
> > - disconnect the entire switch at once from switchdev and
> >   NETDEV_CHANGEUPPER events while unbinding, not just port by port,
> >   likely using a "ds->unbinding = true" mechanism or similar
> > 
> > however options 3 and 4 are quite heavy and might have side effects,
> > option 1 is very unassuming and option 2 seems a more elegant variant
> > of 1, given the fact that sja1105 is the only user of these phylink
> > replay helpers. It allows to keep the driver simple and is the option
> > I went with.
> > 
> > Functionally speaking, transforming the replay helpers into no-ops for
> > ports without a phylink instance is fine, because that only happens
> > during driver removal (an operation which cannot be cancelled). The
> > ports are not required to work.
> > 
> > Fixes: 0b2edc531e0b ("net: dsa: sja1105: let phylink help with the replay of link callbacks")
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> I think this patch could land on current net, but it would be nice an
> ack from phylib SMEs.

Sorry, weekend away.

I prefer option 1. I _think_ option 2 only works because the MAC
driver set dp->pl to NULL. phylink is not responsible for the NULL, so
it seems odd for phylink to assume there is a NULL. Only the MAC
driver knows if the MAC driver has set dp->pl to NULL.

       Andrew

