Return-Path: <netdev+bounces-119991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF2F957C9F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B951F22E86
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6115338D;
	Tue, 20 Aug 2024 05:11:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2602E634
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724130692; cv=none; b=hAg2a/QDmSue5JpCHzogBIKGkPKhedwwmIGbC6ekUIyFtgvuQ6JVQHxN9Y9c2v2RNWw1CFSV5xX2sQTSEtZFOBauTVDgJCrZKXhr5ni/xOrcw2NBjk2s/fVQDbwzB3bhszHKuoRvCOyGBRC+pHi40Pm6sn/OKTXbkWCLwh9enkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724130692; c=relaxed/simple;
	bh=UcFLKfqbxkiEMVskNmfc2HKFxq7gNNYJzemaHo2tlG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGwIOcXMKAGoAhGHANYUikVl/epwrnSKPLMaarFk6NYsKnhh6rEBNESeuGP8V+iRSrTmxVxepHIUY/c8eWaKCJ2dlArY6jRgglHwZ0qo2xMqY0SUhZTeGp4pqAbNcwokzkdkgvuE2i/Smkk3VGdTpMoREXM+L6aJYRyBnQRGuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sgH9K-0007fh-OC; Tue, 20 Aug 2024 07:11:18 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sgH9I-001hHs-Tw; Tue, 20 Aug 2024 07:11:16 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sgH9I-00DYhW-2Z;
	Tue, 20 Aug 2024 07:11:16 +0200
Date: Tue, 20 Aug 2024 07:11:16 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] phy: dp83tg720: Add statistics support
Message-ID: <ZsQldK9b3HIvKTMI@pengutronix.de>
References: <20240819113625.2072283-1-o.rempel@pengutronix.de>
 <654c3a17-fea7-4e28-be36-5229eb106737@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <654c3a17-fea7-4e28-be36-5229eb106737@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Aug 19, 2024 at 11:57:26PM +0200, Andrew Lunn wrote:
> If i remember correctly, some of these are part of an Open Alliance
> standard. Ideally, we want all PHYs which follow the standard to use
> the same names of these statistics.
> 
> Maybe add to the open alliance header something like
> 
> #define TC42_ESD_EVENT_COUNT "esd_event_count"

Ack. How about other counters? May be it is a good point to start
unifying them too?

> Given that the Open Alliance failed to define the registers, i don't
> think we can do much more than that?

Ack.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

