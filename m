Return-Path: <netdev+bounces-148674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881D19E2D4E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B416699C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DDE2AF05;
	Tue,  3 Dec 2024 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dfABRdj2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE861FE473;
	Tue,  3 Dec 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258310; cv=none; b=GvFVlMptDU2QsKF//oaJpISyxDrs6xOVOXtHb/QCJ/SOTM6HdCSyBlhO9tr4SHzyKVaczTuwavMqUfrPu6IpzDnwGPIMJpggJxl9oyarFKcyE2waY0IsR+ao48LW73IFBvYxkFaLxaf8HNZ2SPgsHGjkpHH0zJF6scdh3np/urQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258310; c=relaxed/simple;
	bh=QjMlBLc4jEsjzjULoyfWR8+MpO2L+jk5PBiYO3qTM4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of6nETAvzcx2JKu/kbYUSXqXfTx738pcmkCzV45i/DcSPASp9+to7tGGcU/zELj9qsEvTQ/otsFf0l2WYTsQtOsdHVIWpfd/MhEN5yrtTbzkkw1JxK3/qRgAzJ+p98titcQct1elPiw2PXxztLByKqI9UGyAXrDG53OxeiAc48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dfABRdj2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RZvEElygZ5P6zLhmRuXXHwTgMI6annJ63P6rMkYlTRk=; b=dfABRdj2gjmrzzYbNuentaDq9E
	RJKYvOQurifADS7MX1G6WtrxNw5bfJSmWvYcR/HLrDghEGcZ+gbrHvTARfcZeqSEyXF8JGX50ybEx
	B2TrESsQfD9bTDSJOXrjqAdjHA87MBw/n4s03JvjBOIrrs/Dzqi1w9utgSm8PVfPZI48=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZf5-00F8DN-7m; Tue, 03 Dec 2024 21:38:23 +0100
Date: Tue, 3 Dec 2024 21:38:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 09/21] net: usb: lan78xx: Add error handling
 to lan78xx_irq_bus_sync_unlock
Message-ID: <1c7f1754-297c-4132-aee6-582ac8ab032b@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-10-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-10-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:42AM +0100, Oleksij Rempel wrote:
> Update `lan78xx_irq_bus_sync_unlock` to handle errors in register
> read/write operations. If an error occurs, log it and exit the function
> appropriately.  This ensures proper handling of failures during IRQ
> synchronization.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

