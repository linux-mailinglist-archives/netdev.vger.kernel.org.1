Return-Path: <netdev+bounces-97875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0BF8CD9FA
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 20:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D73B2298A
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676558405F;
	Thu, 23 May 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZW83zNRl"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AD82488;
	Thu, 23 May 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488916; cv=none; b=SUtV9zBZRa5yZzAUTL4mxy4EQxqrXQ7BhMlIm0GQdgdMXBQJoG1zxtG8uTOL0Yh0mX+8ucK42zE+aQc3bwsT55RiMWiQIovXDmi7ji7Y7iDEIAZYtS7IxrKLf1BqVArwuNqdrwjXxOJTRzB4CiwmZUg9mnryghSZTe/H7VKHXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488916; c=relaxed/simple;
	bh=wMtXi1ojy/zbNh/xMLzFTjwEhDLQPXwqtWag8OKqC20=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAZXxJWPNQcqP6LnoLjFTc9/kG3BEh0MBvZnvEWzAAHZr6liWNdlebSoRK4u9hMcfJbm6S6ZKPHGO/6hgbippODQdtfAbrUyl0ZBzjH9fbsJTNQjDXjweqVLFupji4uo34ZrDBiqFsidPBhzZpGG9duXlb4/IHylxR7MXAkTUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZW83zNRl; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716488913; x=1748024913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wMtXi1ojy/zbNh/xMLzFTjwEhDLQPXwqtWag8OKqC20=;
  b=ZW83zNRlgYWbtYZG1j0M36PHjFJ/5b7Hu5AZHZUuw0MDAUfHS34Go3XF
   JNoK9jvn3EIsYrx9je71QEa6RweFTkSYKNPQ97uqVjaDiywXFW7ge90EW
   m0SuaggyChtjimTYKjHbIUBnGiFhnraRPHxz+wt5kCx1LY+ukvFwtSh6h
   5iqwkt1HNQhZuAmSG6HyHbfkR56+QZAbcuaaFIxlJKZBU+tm1H7JFi+NZ
   NbssH90/T9mGqhk/us44iby8wmRfGIk93xvCSHDNkaJHXzJmiZ22oIXOx
   AjJFGQj5LVvCM++AO9UE7qaUf6oRWVYnrMB8fr0BHB5jWsISVdDPHknbP
   A==;
X-CSE-ConnectionGUID: NYz41ly3QeKgfFHrRsdP7Q==
X-CSE-MsgGUID: l6DgFgS/QMydMfz7mQ9ggQ==
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="193335945"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 May 2024 11:28:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 May 2024 11:28:28 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 11:28:27 -0700
Date: Thu, 23 May 2024 20:28:27 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: micrel: Fix lan8841_config_intr after getting
 out of sleep mode
Message-ID: <20240523182827.rvavtqbsbhpcytiv@DEN-DL-M31836.microchip.com>
References: <20240523074226.3540332-1-horatiu.vultur@microchip.com>
 <f73778fe-ef01-44b4-9a8d-cd2a978c1a3d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <f73778fe-ef01-44b4-9a8d-cd2a978c1a3d@lunn.ch>

The 05/23/2024 16:32, Andrew Lunn wrote:

Hi Andrew,

> 
> On Thu, May 23, 2024 at 09:42:26AM +0200, Horatiu Vultur wrote:
> > When the interrupt is enabled, the function lan8841_config_intr tries to
> > clear any pending interrupts by reading the interrupt status, then
> > checks the return value for errors and then continue to enable the
> > interrupt. It has been seen that once the system gets out of sleep mode,
> > the interrupt status has the value 0x400 meaning that the PHY detected
> > that the link was in low power. That is correct value but the problem is
> > that the check is wrong.  We try to check for errors but we return an
> > error also in this case which is not an error. Therefore fix this by
> > returning only when there is an error.
> 
> Is the second case also broken in the same way?
> 
>         } else {
>                 err = phy_write(phydev, LAN8814_INTC, 0);
>                 if (err)
>                         return err;
> 
>                 err = phy_read(phydev, LAN8814_INTS);
>         }
> 
>         return err;
> 
> e.g. there was an outstanding interrupt as interrupts are
> disabled. This will cause the return value of the function to be not
> 0?

Yes, that is correct. In that case, it would return some positive number
which is the status, which is incorrect.
I will fix this in the new version.

> 
>         Andrew

-- 
/Horatiu

