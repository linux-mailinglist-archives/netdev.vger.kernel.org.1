Return-Path: <netdev+bounces-181790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792F3A8679F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F68A4A0891
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71095283CBB;
	Fri, 11 Apr 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CMUZhh1K"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4D283CB3
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404705; cv=none; b=WRq9eN0e5raBdQT8LmEs/UvEbEaRa5foNt3Wn/cYojC7hLaa1Qz859nvWbP3hsrmKsEqN8j++f6gpQTcN5u6GlzQSjJkRY9oFDMgq+FfY9sAQjloTHj+vmMo0dlsXpDs701i9zSyJlPX6wkuDGfrOfra/Jm4A1aU33wKX+eNLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404705; c=relaxed/simple;
	bh=wVIy8ayCd18WwaSqN1iZpBGnj+MDFYlmrExgC8P7dWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Io6L4+ZpYLWhWEmAE4Fn0bE358lGtbZ1q0JA2bdcZ+Rf0Zo+4D/Ntai7+ZuQaUCA6/GT20X80VXj0h8oNdkEAMjkLB2/JRTZVVWDQLXY0FIghUVgCyhIrjtPDEwKS6XdjPcHC/dER5L2QBasIHB2r8rGSB2VzJhuXoU2cHEIzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CMUZhh1K; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UbA83c4HLQ/RTL6SERdiNutEzBiSjFJ9PjEEDv4nZpw=; b=CMUZhh1KtfkcyJSue949cW7xrR
	OdBaDENFIQD+t5geWRwx+81dx5WzLykZbc/LVNctw3rDjcuyiCASjDRpQEaNTi+9JIXQAwnj0dHxN
	jOhpMpasx/LgSjwdWB8Q1HHNo4qhK7OE67wn+KmqPC4wO92sT6aSSlGOPwppA33IUgIHBH2m4sjaf
	JzQ0aA5tNuJsi3oHVY4tKtDPxXy2g5n24CUu52lx8WybH/sCBKIdKYOWoC35Me6VFzMg413yn9Gpo
	rjcqGVAFw/qEZ0gjYWYpaGVAygbZIwXyIyjZj0KIZ9mI3OU37IswKgT7TEEgYhigF6c3tFybqdIdb
	VUI3W3Rw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42312)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3LLg-0003qP-1p;
	Fri, 11 Apr 2025 21:51:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3LLf-0004vf-1v;
	Fri, 11 Apr 2025 21:51:39 +0100
Date: Fri, 11 Apr 2025 21:51:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [BUG] 6.14: WARNING: CPU: 0 PID: 478 at net/bridge/br_vlan.c:433
 nbp_vlan_flush+0xc0/0xc4
Message-ID: <Z/mA27oWj2eSvTTF@shell.armlinux.org.uk>
References: <Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk>
 <20250411184902.ajifatz3dmx6cqar@skbuf>
 <Z_mAFvJ9w4kn0v_G@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_mAFvJ9w4kn0v_G@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 11, 2025 at 09:48:22PM +0100, Russell King (Oracle) wrote:
> On Fri, Apr 11, 2025 at 09:49:02PM +0300, Vladimir Oltean wrote:
> > From 508d912b5f6b56c3f588b1bf28d3caed9e30db1b Mon Sep 17 00:00:00 2001
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Date: Fri, 11 Apr 2025 21:38:52 +0300
> > Subject: [PATCH] net: dsa: mv88e6xxx: fix -ENOENT while deleting user port
> >  VLANs
> > 
> > Russell King reports that on the ZII dev rev B, deleting a bridge VLAN
> > from a user port fails with -ENOENT:
> > https://lore.kernel.org/netdev/Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk/
> > 
> > This comes from mv88e6xxx_port_vlan_leave() -> mv88e6xxx_mst_put(),
> > which tries to find an MST entry in &chip->msts associated with the SID,
> > but fails and returns -ENOENT as such.
> > 
> > But we know that this chip does not support MST at all, so that is not
> > surprising. The question is why does the guard in mv88e6xxx_mst_put()
> > not exit early:
> > 
> > 	if (!sid)
> > 		return 0;
> > 
> > And the answer seems to be simple: the sid comes from vlan.sid which
> > supposedly was previously populated by mv88e6xxx_vtu_loadpurge().
> > But some chip->info->ops->vtu_loadpurge() implementations do not look at
> > vlan.sid at all, for example see mv88e6185_g1_vtu_loadpurge().
> 
> This paragraph isn't accurate. It's actually:
> 
> mv88e6xxx_port_vlan_leave()
> {
> 	struct mv88e6xxx_vtu_entry vlan;
> 
> 	err = mv88e6xxx_vtu_get(chip, vid, &vlan);
> 
> and _this_ leaves vlan.sid uninitialised when mv88e6xxx_vtu_get()
> ends up calling mv88e6185_g1_vtu_getnext().
> 
> I posioned to vlan (using 0xde) and then hexdump'd it after this call,
> and got:
> 
> [   50.748068] mv88e6085 mdio_mux-0.4:00: p9 dsa_port_do_vlan_del vid 1
> [   50.754802] e0b61b08: 01 00 02 00 de 01 de 03 03 03 03 03 03 03 03 03
> [   50.761343] e0b61b18: 00 de de 00 00 00 00 00 00 00 00 00 00 de de de
> [   50.767855] mv88e6085 mdio_mux-0.4:00: p9 vid 1 valid 0 (0-10)
> [   50.773943] mv88e6085 mdio_mux-0.4:00: p9 !user err=-2
> 
> Note byte 4, which is the sid, is the poison value.
> 
> So, should mv88e6xxx_vtu_get(), being the first caller of the iterator,
> clear vlan entirely before calling chip->info->ops->vtu_getnext()
> rather than just initialising a few fields? Or should
> mv88e6185_g1_vtu_getnext() ensure that entry->sid is set to zero?

Or maybe test mv88e6xxx_has_stu() before calling mv88e6xxx_mst_put() ?

If mv88e6xxx_has_stu() is not sufficient, then mv88e6xxx_vlan_msti_set()
is another site where mv88e6xxx_vtu_get() is used followed by use of
vlan.sid.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

