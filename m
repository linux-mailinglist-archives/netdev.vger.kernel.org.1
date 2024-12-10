Return-Path: <netdev+bounces-150458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7409EA4A8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF4C28295A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9B112DD8A;
	Tue, 10 Dec 2024 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ke0EEusi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611C2AE93;
	Tue, 10 Dec 2024 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796266; cv=none; b=DucYIF+C0tKIH2jVj9+5IKVlf7xYArmJHsbV/L7AbNVfkCtjjT78QDVee3MRgds+EY+8CzVrtUJzzb+XU4zdc6XnBPuzQTdbkEZMPWoi8qSgQ1/drrSEovxTLnj+t6uw4q28eXXWL7w1KpiafZZjSGpORU2l3ykzr1kBj9Et0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796266; c=relaxed/simple;
	bh=7PYDEBrX6UDd5urSI+9ADlPKo36XnpaS1lVqRbWxUHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iie6fYkYVRH7isQ44her4uZ4UccFVSyCTsNSMZrZ2U9c5s1793Dm1Hz7QLWS0M09bMJHT5cRN/Xt5IN3+cPVhKThy2OAP1AVfbndDa59iUGOiuwmlSsagF/BWQ9jdI0IqRdLYXXE6dOndkf+3RTSYr+Z4u/PaqcFlsH2tevsgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ke0EEusi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w5+t6XBwCajCiRcvMjJKRNt/CjZXlpUR9jDDCFEx5+I=; b=Ke0EEusi3UFGEbIFQF7YZVHWnV
	wiIR67w3AUot0oVAdhjtd0uXlMFeTx1JmaVSo6z7D7usFZ5Waj1rbq6Yo2pKw8sq8atVBWcG+fmXS
	+8+e8U3c4nhU0K512TDMfEzY/nBWGOdN08h+XLlOineYx3ns83H/NzlpupN2HSxUTRd8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpbm-00Fk4t-4S; Tue, 10 Dec 2024 03:04:18 +0100
Date: Tue, 10 Dec 2024 03:04:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 05/11] net: usb: lan78xx: Simplify
 lan78xx_update_reg
Message-ID: <2f5d56c0-b512-419e-b0d6-b2b0aeb721c4@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-6-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:45PM +0100, Oleksij Rempel wrote:
> Simplify `lan78xx_update_reg` by directly returning the result of
> `lan78xx_write_reg`. This eliminates unnecessary checks and improves
> code readability.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

