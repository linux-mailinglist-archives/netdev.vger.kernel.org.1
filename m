Return-Path: <netdev+bounces-77466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D00871E1F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E30B20CDA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C186156B8A;
	Tue,  5 Mar 2024 11:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6029CE9
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638860; cv=none; b=rOWt9GOubpHEkN1Xe+FoqG8yJNRyK+4qoCGtMfPlTlW3jQWH7VvO0HOm6pUQtqxOslY5K2B2dleh9xpR5p/oug4vdMBl1Dhev9wJtYZKOVtat+1SfPxwILZklCGb/qhbqFElJqRLVP3xAIpGi+R8zvfLs19jx6stsgpKbAf3a+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638860; c=relaxed/simple;
	bh=z8LCb7mV8ZuqkBDjRoGIuhNi62of8CrUvDdCiwsDE24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyrIZi3NtRRWO9Hos/qZ6aYUA1SQWzmpiCk4vXivWgcGUYqxa3JTiG8JyPBK2e5huOlJ93OlDdf1nvnenSGpKYe+v7io3/NLmcGsSaM9jm/4C3pxRt0+ePAjYYeze5pe+joJBV3l8WiGfst8faKEqIeHjQYq8Q5CL8qZ1LXy06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rhTA2-000719-UP; Tue, 05 Mar 2024 12:40:42 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rhTA0-004Xap-SV; Tue, 05 Mar 2024 12:40:40 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rhTA0-003N8P-2W;
	Tue, 05 Mar 2024 12:40:40 +0100
Date: Tue, 5 Mar 2024 12:40:40 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: tobias.jakobi.compleo@gmail.com
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix register write order in
 ksz8_ind_write8()
Message-ID: <ZecEuIgttoeXkr7T@pengutronix.de>
References: <20240304154135.161332-1-tobias.jakobi.compleo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304154135.161332-1-tobias.jakobi.compleo@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Mar 04, 2024 at 04:41:35PM +0100, tobias.jakobi.compleo@gmail.com wrote:
> From: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>
> 
> This bug was noticed while re-implementing parts of the kernel
> driver in userspace using spidev. The goal was to enable some
> of the errata workarounds that Microchip describes in their
> errata sheet [1].
> 
> Both the errata sheet and the regular datasheet of e.g. the KSZ8795
> imply that you need to do this for indirect register accesses:
> - write a 16-bit value to a control register pair (this value
>   consists of the indirect register table, and the offset inside
>   the table)
> - either read or write an 8-bit value from the data storage
>   register (indicated by REG_IND_BYTE in the kernel)
> 
> The current implementation has the order swapped. It can be
> proven, by reading back some indirect register with known content
> (the EEE register modified in ksz8_handle_global_errata() is one of
> these), that this implementation does not work.
> 
> Private discussion with Oleksij Rempel of Pengutronix has revealed
> that the workaround was apparantly never tested on actual hardware.
> 
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/Errata/KSZ87xx-Errata-DS80000687C.pdf
> 
> Signed-off-by: Tobias Jakobi (Compleo) <tobias.jakobi.compleo@gmail.com>

The subject should have [PATCH net] for stable and Fixes tag:
Fixes: 7b6e6235b664 ("net: dsa: microchip: ksz8795: handle eee specif erratum")

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

