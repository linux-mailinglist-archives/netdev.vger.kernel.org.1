Return-Path: <netdev+bounces-181788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DADA8678F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697D67A7F8F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299D120B819;
	Fri, 11 Apr 2025 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S0SCS5Ai"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE3AD24
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404509; cv=none; b=E3UddCe7mFJH5ZhargoxHSR7rWb0RT3PIBkVSJe52AgjEV/LAQ/OaeWihLa60Nv3xCJk7rPBsQhV0x4bQnZoB+RF72xPLdl8U4QftJudrXexuI4mVS4E+eWTLlii09qx5jgNPp3PJsqrruOMwyBTeZD+nVi+PypQH/Tok/Q1rm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404509; c=relaxed/simple;
	bh=yHb8SAsnsSQEN0trvOLWkSZqfdaMB0gv4Mzhvb+mNUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOCmt9ZPj0LwjnBdroyQ4TOSHzn0ka5CA3rV/woOuFQbPX+TTwIwVfGVfbn9sgdWp9hfpTV0715wUoNVs1Cdag1fthB25kAhiLMNse93Goyoe1iXPxg2cw0ncWSWf3539VIZKF8KE+VQxhFwZPfJc9sc/y7H480oCb8nyduLrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S0SCS5Ai; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zEyAVY1Kzcy0t1hhmLkBWRKLTmBJSv2/Bzew7Dq5aWM=; b=S0SCS5AiWnoAPazps5ll+peNKm
	WEb08ukI2b1fyuFoQ+kYRGkZJJyt2VDrd7+KROGR9CBfDjw7QcAwv+yUMzttD1yL/+UJ5DOfhhcTs
	GHpx9+wuKb8QpPoIJXdPvsuli+TFIL1JS9q00mvd0mMWKLUvb3f970GNCPkNvHjrSjaEJTgxn1k2M
	c4MaleAHU6RmQa1reexrfQC7ZXx5GXTRKC3OHMaQpwwNfqMCyPBWJqqRqt2JwhlKUztXtW7QX236T
	CA/wRJCLoognhMUyslsjG9a/AWywdg4aSCZ1e5CxNSSKPzaUFNYEZtDfkKSbTgTP2d1q6vcWXkSeC
	ERVFxZQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37500)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u3LIV-0003q9-2I;
	Fri, 11 Apr 2025 21:48:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u3LIU-0004vX-1Z;
	Fri, 11 Apr 2025 21:48:22 +0100
Date: Fri, 11 Apr 2025 21:48:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [BUG] 6.14: WARNING: CPU: 0 PID: 478 at net/bridge/br_vlan.c:433
 nbp_vlan_flush+0xc0/0xc4
Message-ID: <Z_mAFvJ9w4kn0v_G@shell.armlinux.org.uk>
References: <Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk>
 <20250411184902.ajifatz3dmx6cqar@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411184902.ajifatz3dmx6cqar@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 11, 2025 at 09:49:02PM +0300, Vladimir Oltean wrote:
> From 508d912b5f6b56c3f588b1bf28d3caed9e30db1b Mon Sep 17 00:00:00 2001
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date: Fri, 11 Apr 2025 21:38:52 +0300
> Subject: [PATCH] net: dsa: mv88e6xxx: fix -ENOENT while deleting user port
>  VLANs
> 
> Russell King reports that on the ZII dev rev B, deleting a bridge VLAN
> from a user port fails with -ENOENT:
> https://lore.kernel.org/netdev/Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk/
> 
> This comes from mv88e6xxx_port_vlan_leave() -> mv88e6xxx_mst_put(),
> which tries to find an MST entry in &chip->msts associated with the SID,
> but fails and returns -ENOENT as such.
> 
> But we know that this chip does not support MST at all, so that is not
> surprising. The question is why does the guard in mv88e6xxx_mst_put()
> not exit early:
> 
> 	if (!sid)
> 		return 0;
> 
> And the answer seems to be simple: the sid comes from vlan.sid which
> supposedly was previously populated by mv88e6xxx_vtu_loadpurge().
> But some chip->info->ops->vtu_loadpurge() implementations do not look at
> vlan.sid at all, for example see mv88e6185_g1_vtu_loadpurge().

This paragraph isn't accurate. It's actually:

mv88e6xxx_port_vlan_leave()
{
	struct mv88e6xxx_vtu_entry vlan;

	err = mv88e6xxx_vtu_get(chip, vid, &vlan);

and _this_ leaves vlan.sid uninitialised when mv88e6xxx_vtu_get()
ends up calling mv88e6185_g1_vtu_getnext().

I posioned to vlan (using 0xde) and then hexdump'd it after this call,
and got:

[   50.748068] mv88e6085 mdio_mux-0.4:00: p9 dsa_port_do_vlan_del vid 1
[   50.754802] e0b61b08: 01 00 02 00 de 01 de 03 03 03 03 03 03 03 03 03
[   50.761343] e0b61b18: 00 de de 00 00 00 00 00 00 00 00 00 00 de de de
[   50.767855] mv88e6085 mdio_mux-0.4:00: p9 vid 1 valid 0 (0-10)
[   50.773943] mv88e6085 mdio_mux-0.4:00: p9 !user err=-2

Note byte 4, which is the sid, is the poison value.

So, should mv88e6xxx_vtu_get(), being the first caller of the iterator,
clear vlan entirely before calling chip->info->ops->vtu_getnext()
rather than just initialising a few fields? Or should
mv88e6185_g1_vtu_getnext() ensure that entry->sid is set to zero?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

