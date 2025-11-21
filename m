Return-Path: <netdev+bounces-240656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B7C7765F
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AC4322BD31
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 05:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9E2EA16A;
	Fri, 21 Nov 2025 05:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E4274FEF
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703704; cv=none; b=YwBjiY+iR2lWQpnVUjOBfzsFCJocJD2tnfAtqcpkBkt5Gq7R0gHb1fa7tfPcfKB3n/r11H7OHm1JeyTR9uhzXQur0zCm9lY0W6y5ASFHfEiXBKS/fe5ybc6ovpaXNYqHvq1aC5S6nRQ8qh7gTbRECXQt/PCdf3P3xdy3/BR7G5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703704; c=relaxed/simple;
	bh=Kn3J28aVMmGq6lo21uh5ZYTWPzceqvcAiZtS9zxPeYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBht1L3KebFh2UoYQuCZ2LXVa1aAjFwPIemXWvGdsLTNEHQ6gQyUjPMklAKR4HUTYcM2E53JYbuN3qS0ykiJ4uTv515i9niUSmW6CS0SwWSRdo+9qus1P/z29rJCogyxckRE62VMFe2PgOOXoBl3jM1ZNfz70WozYANlmpdxrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vMJtW-0000dd-I7; Fri, 21 Nov 2025 06:41:18 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMJtV-001XGc-0k;
	Fri, 21 Nov 2025 06:41:17 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMJtV-00FpBF-0D;
	Fri, 21 Nov 2025 06:41:17 +0100
Date: Fri, 21 Nov 2025 06:41:17 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Ma Ke <make24@iscas.ac.cn>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: microchip: fix mdio parent bus reference leak
Message-ID: <aR_7fXEMhNeIhRwZ@pengutronix.de>
References: <20251121042000.20119-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121042000.20119-1-make24@iscas.ac.cn>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi,

On Fri, Nov 21, 2025 at 12:20:00PM +0800, Ma Ke wrote:
> In ksz_mdio_register(), when of_mdio_find_bus() is called to get the
> parent MDIO bus, it increments the reference count of the underlying
> device. However, the reference are not released in error paths or
> during switch teardown, causing a reference leak.
> 
> Add put_device() in the error path of ksz_mdio_register() and
> ksz_teardown() to release the parent bus.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9afaf0eec2ab ("net: dsa: microchip: Refactor MDIO handling for side MDIO access")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

