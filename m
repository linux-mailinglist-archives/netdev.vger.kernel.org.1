Return-Path: <netdev+bounces-240748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 267FCC78EFA
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDA9635DDB9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14F34A79A;
	Fri, 21 Nov 2025 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxgcDfvZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B77346785;
	Fri, 21 Nov 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726812; cv=none; b=XARPzITp55i0rO8zq2DhG3SR969UT6c6m+OkDDV8Fhkfp2W/ugSPjpp4y2hkDm4FMSU+qQKyDYdON9LZkywNWTB2enbgclazDkvw76EBnPF1CfTRB+KNdPg5O2OWpelSloSpAmy38zD1hu3ZMOoVPdzlug1bffAwrXpzk1UFG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726812; c=relaxed/simple;
	bh=e+w4JWef/hueSny6NsEj4e3hzhIwvQmxgphsfHCDEfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syFBA9hnBiLBf+AkOd14heFSbjkGMaRUqjfMXubaaXWM/j03Wc3PR5dPLxKjKC008GXPLsodhgCl3zlAdDOLFKSZReivPi09s5O0Ks7Am0gYE34qBKzeHW6dasLXyNMhRoW2H6cw0MF8LiuIO9nZNFXBhCm3oZlXGNlnfhRm8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxgcDfvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6779DC4CEF1;
	Fri, 21 Nov 2025 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763726811;
	bh=e+w4JWef/hueSny6NsEj4e3hzhIwvQmxgphsfHCDEfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxgcDfvZ9TlDzcRRrs6ykgmhIH2SWptIWo/gf/GabIQ5a33QUR7koAicCOYRTmL8U
	 MxSj773JiG9mqReae9KlQOv0KFW3+lwdMwXGkIEpZZmLcrryERV7lSH2Ct0tCkNecX
	 g+ouCVsTQApSMkkbV0+4h35kZzr+Ne0AR7K1XfKApeaAd2GEPrcoYfDtpyeejftICw
	 hYgGe0sZIgd+BPQRR/s4AyeVCgnBNxWIlROqOyg0cSX38oO/IXARp2CS3Qq1qEht4y
	 MGR40OWZubPtT/60TorCmfCwl9m/2ZBHyoEp2p40qnFdreyuBSbSmCpqrqzbVvmeXm
	 ZiXw6QXqOBIPg==
Date: Fri, 21 Nov 2025 12:06:46 +0000
From: Lee Jones <lee@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20251121120646.GB1117685@google.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120153622.p6sy77coa3de6srw@skbuf>

On Thu, 20 Nov 2025, Vladimir Oltean wrote:

> On Thu, Nov 20, 2025 at 02:41:36PM +0000, Lee Jones wrote:
> > On Tue, 18 Nov 2025, Vladimir Oltean wrote:
> > 
> > > I would like the "nxp,sja1110a" driver, in the configuration below, to
> > > be able to probe the drivers for "nxp,sja1110-base-t1-mdio" and for
> > > "nxp,sja1110-base-tx-mdio" via mfd_add_devices():
> > > 
> > > 	ethernet-switch@0 {
> > > 		compatible = "nxp,sja1110a";
> > > 
> > > 		mdios {
> > > 			mdio@0 {
> > > 				compatible = "nxp,sja1110-base-t1-mdio";
> > > 			};
> > > 
> > > 			mdio@1 {
> > > 				compatible = "nxp,sja1110-base-tx-mdio";
> > > 			};
> > > 		};
> > > 	};
> > 
> > This device is not an MFD.
> > 
> > Please find a different way to instantiate these network drivers.
> 
> Ok.. but what is an MFD? I'm seriously interested in a definition.
> 
> One data point: the VSC7512 (driver in drivers/mfd/ocelot-spi.c,
> bindings in Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml) is
> almost the same class of hardware (except the embedded Cortex-M7 in
> SJA1110 can't run Linux, and the CPU in VSC7512 can). It instantiates
> MDIO bus children, like this patch proposes too, except it works with a
> different device tree hierarchy which I need to adapt to, without breaking.

The devices should be different types i.e. be located in different
subsystems.  If you're simply instantiating Watchdog timers, the code
should live solely in drivers/watchdog.  If the devices all pertain to
Networking, the code should live in the Networking subsystem, etc.

MFD is Linuxisum, simply used to split devices up such that each
component can be located it their own applicable subsystem and be
reviewed and maintained by the subject matter experts of those domains.

TL;DR: if your device only deals with Networking, that's where it should
live.  And from there, it should handle its own device registration and
instantiation without reaching into other, non-related subsystems.

-- 
Lee Jones [李琼斯]

