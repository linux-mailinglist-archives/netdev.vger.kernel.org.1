Return-Path: <netdev+bounces-218728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84254B3E1C7
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F6C16CEC3
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4A314A93;
	Mon,  1 Sep 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f+/L+v4X"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B477305E27
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726726; cv=none; b=RaWDHS5jNPqyvtcKgbgOlPBBvdGojA8mQ56Irj4mAI0jKHDM8391Rn+M46vMTECRkrbckO5D3rAl8RSyiWMvH8zKVQYkHtMlUuTrrg6y11EC2l0nPOBUJXzrJ5eeRnL6c9IsKaVBF8N+Ts5TGOLPPgRZG33Ifyo3Hl52aah/hSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726726; c=relaxed/simple;
	bh=r7dtHC232Acdyffa/9b0fJREPMEdYDvs3aU0KENBw4U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpgI0j5vh10cwFjt9liCBr+J2RTvryNQoQ74JfzAWGI5BZIgtk6AJZuWAe1uhNo9ifumVTVpBYAMMKJWH1HnSxG7Rg53mftIWyX6SoX4bGEwXOR4ae4EbWAWMBWvkHSVyYZzJ4iCyjfGpdlIzHsd4XfbkdK2PIKtBQDz8GYClL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f+/L+v4X; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756726724; x=1788262724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r7dtHC232Acdyffa/9b0fJREPMEdYDvs3aU0KENBw4U=;
  b=f+/L+v4XM/sgurf1D+WIcSN8J/NxaWk4V7qkQqU4LToZKmMGy68bgUmT
   5O9oGhf0eDA0hmGMqAVW2Owzgm4ZjnfxalgzzLwh0w09771AMrGqMwVKO
   PwH9nAkj+XkCGnJiAUUlMUmK8yaEDqOOgmUBdKbDbAjpBP2pAV850KtNO
   yiBY32ddqcoxI+k1+emDMCwC/D+h/9sb5f49PAyrYrFCLayEVb28ttd4U
   oSq4Pei3N5aqXpkubsLqWHWjs5X3wMkKqRqRPBI1PeS+M2rmHPGbbVifV
   WERQB4VWquK6TjU4AzIgUGr7MQ3Qgz02+GAxl+BhTq7zkhtQ2J/Gw8K/1
   g==;
X-CSE-ConnectionGUID: R5lgB5FhQdC2EVVSG2GTjA==
X-CSE-MsgGUID: yLhaCcoOSaOoKG6R5Ab1Sg==
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="45884589"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 04:38:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 04:38:15 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 1 Sep 2025 04:38:14 -0700
Date: Mon, 1 Sep 2025 11:38:14 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, <horatiu.vultur@microchip.com>
Subject: Re: [PATCH net-next 2/2] net: lan966x: convert fwnode to of
Message-ID: <20250901113814.xiscq26yefs3t4qr@DEN-DL-M70577>
References: <20250827215042.79843-1-rosenp@gmail.com>
 <20250827215042.79843-3-rosenp@gmail.com>
 <20250828111216.bruz7lq7dz5e6b6f@DEN-DL-M70577>
 <CAKxU2N-zuZfCwU83UA1SQ4c8JrJc+oGSg0Vu28P316uZsVMgcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKxU2N-zuZfCwU83UA1SQ4c8JrJc+oGSg0Vu28P316uZsVMgcQ@mail.gmail.com>

> > > @@ -1179,7 +1179,7 @@ static int lan966x_probe(struct platform_device *pdev)
> > >                 }
> > >         }
> > >
> > > -       ports = device_get_named_child_node(&pdev->dev, "ethernet-ports");
> > > +       ports = of_get_child_by_name(pdev->dev.of_node, "ethernet-ports");
> > >         if (!ports)
> > >                 return dev_err_probe(&pdev->dev, -ENODEV,
> > >                                      "no ethernet-ports child found\n");
> > > @@ -1191,25 +1191,27 @@ static int lan966x_probe(struct platform_device *pdev)
> > >         lan966x_stats_init(lan966x);
> > >
> > >         /* go over the child nodes */
> > > -       fwnode_for_each_available_child_node(ports, portnp) {
> > > +       for_each_available_child_of_node(ports, portnp) {
> > >                 phy_interface_t phy_mode;
> > >                 struct phy *serdes;
> > >                 u32 p;
> > >
> > > -               if (fwnode_property_read_u32(portnp, "reg", &p))
> > > +               if (of_property_read_u32(portnp, "reg", &p))
> > >                         continue;
> > >
> > > -               phy_mode = fwnode_get_phy_mode(portnp);
> > > -               err = lan966x_probe_port(lan966x, p, phy_mode, portnp);
> > > +               err = of_get_phy_mode(portnp, &phy_mode);
> > > +               if (err)
> > > +                       goto cleanup_ports;
> > > +
> > > +               err = lan966x_probe_port(lan966x, p, phy_mode, of_fwnode_handle(portnp));
> >
> > As I see it, you could change the signature of lan966x_probe_port() to accept a
> > struct device_node, and instead pass that.  Then you can convert it to fwnode
> > for phylink_create, and ditch to_of_node().
> Will fix.

Thanks.

> >
> > Same goes for lan966x_port_parse_delays(), here you can change
> > fwnode_for_each_available_child_node() to for_each_available_child_of_node()
> > and fwnode_property_read_u32() to of_property_read_u32().
> I don't see this lan966x_port_parse_delays function.

Sorry, I was looking at an internal version that had this function. Disregard
this. The first comment still applies though.

/Daniel

