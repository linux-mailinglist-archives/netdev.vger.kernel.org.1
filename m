Return-Path: <netdev+bounces-181242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11992A842BB
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C4E3BBF50
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D512836A7;
	Thu, 10 Apr 2025 12:14:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1726A1C3
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287254; cv=none; b=eYrxCbaKGT4Yjzaxejwz87kEcGouS3bxqAuJvy7/1hFw5QWXaOptU6jUecfOhIbB98sH2wTZyeIUmbQVbfThJOyznm8dxEsT32h2n1yJ3yqvViwTRZ18IcreisTO41ZU2CIA08cppbPYJIX356ER530oN/CEEYdlODvOzKOpQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287254; c=relaxed/simple;
	bh=yBgj6TSX3ktKPTDwDouO0Xsf2K/CIJ5+N+hcweBHMEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fzp/T85tKw3UJjW7MLziSnaB0PVK8mPgDrukMZUuH2FHDqNuvIVGXTx1H9+99xt4GIJ113SxjCITmr55dg9YaP6Kjl2R7nBF1mZl399tIrQ6+xkd4pLLoPv00M2c+65yZujSd1b+dUswkAbh99qpG92wf8454EooLYN7TUApUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qnI-0000d6-8K; Thu, 10 Apr 2025 14:14:08 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qnG-004Gek-2j;
	Thu, 10 Apr 2025 14:14:06 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qnG-00AN5k-22;
	Thu, 10 Apr 2025 14:14:06 +0200
Date: Thu, 10 Apr 2025 14:14:06 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: netdev <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] usbnet: asix AX88772: leave the carrier control to
 phylink
Message-ID: <Z_e2DtOnQPbQmrj1@pengutronix.de>
References: <m35xjgdvih.fsf@t19.piap.pl>
 <Z_PVOWDMzmLObRM6@pengutronix.de>
 <m3tt6ydfzu.fsf@t19.piap.pl>
 <m3plhmdfte.fsf_-_@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3plhmdfte.fsf_-_@t19.piap.pl>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Apr 08, 2025 at 01:59:41PM +0200, Krzysztof Hałasa wrote:
> ASIX AX88772B based USB 10/100 Ethernet adapter doesn't come
> up ("carrier off"), despite the built-in 100BASE-FX PHY positive link
> indication. The internal PHY is configured (using EEPROM) in fixed
> 100 Mbps full duplex mode.
> 
> The primary problem appears to be using carrier_netif_{on,off}() while,
> at the same time, delegating carrier management to phylink. Use only the
> latter and remove "manual control" in the asix driver.
> 
> I don't have any other AX88772 board here, but the problem doesn't seem
> specific to a particular board or settings - it's probably
> timing-dependent.
> 
> Remove unused asix_adjust_link() as well.
> 
> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
 
Link detection is still working on variants with copper interface.

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

