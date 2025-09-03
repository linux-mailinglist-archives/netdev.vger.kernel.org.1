Return-Path: <netdev+bounces-219456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4DB41565
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C172A188DF9B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203732D73B0;
	Wed,  3 Sep 2025 06:46:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E92C375E
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881998; cv=none; b=AqgexJZ/TFZxA2SiAEjNiE14Eb+ins7WalBnFVG2o7bh2imXaO3wQRNef0iNJudTadh0gHXZNEbTTVK7F/ct8ZxTDoUjn2UDdi33pW5v2hVAQ8oc6jfha+XTX7qwrJ+PY3Li3hVE3154Zj8AA/m6nh46+zMVIbfuZcmGk/IAoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881998; c=relaxed/simple;
	bh=1Ai3J0OtNFLrQkIvtX6zHQqcvy0P1Ph7PXPl85zrnb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuIo6Mi1xjhUKn2cAxVm/LPT25UKoXJ3FWB2IUv3J/dVcmk/oMdf998yTVcUrjauAjBX1nLYmIgDSlDbwG+VaodO3I9cRSioPHhdrZ3vmqSkn/uLrbzsgU8DInbK5CJ6hoLPr5va+Mzb0mhZ3XHv2wzK7oyAOebKM9S6s+Vyn0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uthG9-00042x-7J; Wed, 03 Sep 2025 08:46:21 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uthG7-003W5b-2M;
	Wed, 03 Sep 2025 08:46:19 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uthG7-00HVQ8-1u;
	Wed, 03 Sep 2025 08:46:19 +0200
Date: Wed, 3 Sep 2025 08:46:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <linux@rempel-privat.de>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] net: usb: asix: deadlock on interface setup
Message-ID: <aLfkOyYFY5ZGG6lZ@pengutronix.de>
References: <DCGHG5UJT9G3.2K1GHFZ3H87T0@gmail.com>
 <20250902163511.181fa76a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902163511.181fa76a@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Sep 02, 2025 at 04:35:11PM -0700, Jakub Kicinski wrote:
> On Sun, 31 Aug 2025 10:50:35 +0200 Hubert Wiśniewski wrote:
> > Trying to bring an AX88772B-based USB-Ethernet adapter up results in a
> > deadlock if the adapter was suspended at the time. Most network-related
> > software hangs up indefinitely as a result. This can happen on systems
> > which configure USB power control to 'auto' by default, e.g. laptops
> > running `tlp`.
>  
> Oleksij, this seems to date back to commit e0bffe3e6894 ("net: asix:
> ax88772: migrate to phylink"). Taking rtnl_lock in runtime resume
> callbacks is known to result in unhappiness :(
> 
> Could you check if commit e110bc825897 ("net: usb:
> lan78xx: Convert to PHYLINK for improved PHY and MAC management")
> isn't similarly flawed?

Yes, sorry for delay answer.  I'll investigate it at Friday.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

