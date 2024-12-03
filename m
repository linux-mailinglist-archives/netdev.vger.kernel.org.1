Return-Path: <netdev+bounces-148670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCD9E2D36
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4662821D0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C7B1EF081;
	Tue,  3 Dec 2024 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QKQo2a1n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA743189F56;
	Tue,  3 Dec 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258152; cv=none; b=Px9FzYo0qZVrQ5VXOpAeV83rIHhOU56kD0jLRPUNwdKx4x1cGgbv1isaTpfQzCuY7VZmXYm1kTYv7gRhFegW3q354gjUggSl9z+DbaWn8GVIsJ9jW30G8Na3EVBNg5VOmWZ0BLzcgToy7xo8i+0mR9TVl/p/TLPwIrudw5yhdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258152; c=relaxed/simple;
	bh=3XFuyDVd24VNId3mtojt/s2zg943OWmadIp5MN1XvSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpEZuGAdcx9plywsu4L4P5GbZFzBr92GkDM16EvgrbBsn/ArADnZv0hvtrrATBpyHrd12P69smZclC60sW5pdxYBXYKXbfqMc3gtIp+RKO/UVncjgl4laK42r4dNKmRuZqlwXaxsxQ8BlGBa5LPlvcR9t0kUgzRO+PHPCzceJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QKQo2a1n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XNUfzojEoIvPMsw7o5EQsm4flrwBcXxoTxbRJXaPFAY=; b=QKQo2a1nk6P25Xj4/v/PVvI61b
	U+IcTWv8NQcLQJVs1rn516ArAyXOtvfrrpRMhBX06ALJ+gn3ZqVb2MSbDZx6+dQ+n6qJmx035Gw3z
	lxBgDGZCD6jlXf9eLy8pG269wUo4f0tM9PAc5Ba8z7ZxFs/0t/5rTalBR4BRw3V9e9Y4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZcV-00F8BB-T5; Tue, 03 Dec 2024 21:35:43 +0100
Date: Tue, 3 Dec 2024 21:35:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 06/21] net: usb: lan78xx: Improve error
 handling in EEPROM and OTP operations
Message-ID: <ce20c7c4-0cbd-4c19-b695-4916c2d63f78@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-7-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:39AM +0100, Oleksij Rempel wrote:
> Refine error handling in EEPROM and OTP read/write functions by:
> - Return error values immediately upon detection.
> - Avoid overwriting correct error codes with `-EIO`.
> - Preserve initial error codes as they were appropriate for specific
>   failures.
> - Use `-ETIMEDOUT` for timeout conditions instead of `-EIO`.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

