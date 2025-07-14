Return-Path: <netdev+bounces-206608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441EB03B72
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3664B171558
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C067246774;
	Mon, 14 Jul 2025 09:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2624676D
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486848; cv=none; b=TRTgMiotlglgIVkXt01UUek+CawsswuOZGMdNTtP4aztnhFHTf8Aq60AZKmbd0tOorFkTN5g1CFpL4iNmao9h0vbAObyTzAb0+yupdnq83jx4uN0LTVD1xKehJIvENeWGDWMth1i2kIeJiJPyek4HBI4ce8HxhPNZkeWMXI1v/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486848; c=relaxed/simple;
	bh=6IRl/mIn09xkrbWHw094gsekp4WjhdgE22sMfWIPkXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPQWjylfIaIWQXimHv1OI1IYYDakqcb6wmLVlrKJ0O1CwT8MTEK9ntjiLJgGLFw4t34ZeUCkNKV0JOy5LBBoIG3HI5wkBCa1NgoecDNLlsaCPSwoysUgQ+C9J1ss0mHYD7R1oc/6sOk7ooof4mmBJvAgyx+NUt+yypyWoE652o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ubFsj-0007JF-0r; Mon, 14 Jul 2025 11:53:57 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ubFsi-008OKx-27;
	Mon, 14 Jul 2025 11:53:56 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ubFsi-0006oc-1k;
	Mon, 14 Jul 2025 11:53:56 +0200
Date: Mon, 14 Jul 2025 11:53:56 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v3 2/3] net: phy: allow drivers to disable polling
 via get_next_update_time()
Message-ID: <aHTTtHsYDP3YXgmF@pengutronix.de>
References: <20250711094909.1086417-1-o.rempel@pengutronix.de>
 <20250711094909.1086417-3-o.rempel@pengutronix.de>
 <20250712131848.GA721198@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250712131848.GA721198@horms.kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Jul 12, 2025 at 02:18:48PM +0100, Simon Horman wrote:
> > +			if (phydev->drv->update_stats) {
> > +				WARN_ONCE("phy: %s: driver requested IRQ mode but needs polling fo=
r stats\n",
> > +					  phydev_name(phydev));
>=20
> The first argument to WARN_ONCE() should be a condition, not a format str=
ing.
>=20
> Flagged by GCC and Clang builds with KCFLAGS=3D-Wformat-security

Thank you! I added it to my build test setup.

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

