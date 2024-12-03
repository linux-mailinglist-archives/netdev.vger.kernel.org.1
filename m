Return-Path: <netdev+bounces-148673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 450119E2D4A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A34F282D41
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A520ADC1;
	Tue,  3 Dec 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C+YJ36PL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD9A20ADEC;
	Tue,  3 Dec 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258267; cv=none; b=hHr8BXHI5rm7NLcTtfBMXWOztkbGGL0nFpOXobQo3A5al+iR2LMlzCBO6HdSDia60biuNQLR0E8DeueyLYFkJneqFFzYOIe5/RP68b9zJl28iLtdOCtY2UZyhvzWMCAKT/rsfeHCwb78fMqRB92dvqbZ+ZKb0OBZy3Y1Ds3n7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258267; c=relaxed/simple;
	bh=YHkHvZnzCr5TBpSlsQ8UKtrQ/4QxPTkzSvSv+lE1diM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk0djAEnwm78/wGT8Kqwd9GGOyJbNinAAGFufVZASzFcUTqZNckC+9CXKQ5IRxMmv8h88eG0tdRF7mNhrRQP5qCNH6GXyAZFT+4dOQikJ4q7FmO6xNS38z4GVKkpqsGO31NcNh5UhbPgracoWvdTtRuGpBV0EMubfnJGIDHuAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C+YJ36PL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sG14fCx6XdzcEIXgviTaIQL3aL3mihrpCYmdqthB7hY=; b=C+YJ36PLfNyZmIdRKAfjkGXDKM
	TD3iIfUwVmTkkXvl4bqskw3pQfUsGL2kytYbNzkrqestyTD73wVFaePNe2j0p735jSkN+MbTcvWQC
	tNCjwHQeOOBLIakp3fG+7WUuaOR4n/n6hm/hi2jT1DNoprce5+munp95A96TpCB1ZUgE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZeO-00F8Cj-Al; Tue, 03 Dec 2024 21:37:40 +0100
Date: Tue, 3 Dec 2024 21:37:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 08/21] net: usb: lan78xx: Add error handling
 to set_rx_max_frame_length and set_mtu
Message-ID: <8467b5b4-e432-445e-b399-cf30aa32d467@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-9-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-9-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:41AM +0100, Oleksij Rempel wrote:
> Improve error handling in `lan78xx_set_rx_max_frame_length` by:
> - Checking return values from register read/write operations and
>   propagating errors.
> - Exiting immediately on failure to ensure proper error reporting.
> 
> In `lan78xx_change_mtu`, log errors when changing MTU fails, using `%pe`
> for clear error representation.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

