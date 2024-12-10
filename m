Return-Path: <netdev+bounces-150461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823309EA4B6
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E00167DAF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A331993B9;
	Tue, 10 Dec 2024 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SW/R5NYM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9813143871;
	Tue, 10 Dec 2024 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796539; cv=none; b=ncAP6SPzQ7QqIBD6vZr/6yakFQnQ/T7W/fvBXc/0GNDAAbaQuWij1GlICSKCskaemNzwR+1gumYhnTrPcgolTg5893308yBaykSYZmoWx9/NrGB7Pdrnk9Y+dtmoXzJlxeZlPEAqmOTwS6r/Yjna0TLRVGAA6Uqn9H8B9i09kdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796539; c=relaxed/simple;
	bh=7o0K0deh3aPbCh0CTJWcwB8tY38CMwIafSGGXUQvumQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYeLoXSm8myh0U6jBqSGRgiNsz4w6xUeLZYKeEexxqaFvEUSvAo7aN06RsNP8RPIASPU57QKCTmkQDAShy5tHuJGZpfA6pIjzQ4lA09gayYl0nDJkPvlpEDlScvxJ9Ve1FKSzTChKDZAd2X8YPZkVw/qnpYlXbeon6MYX0VUVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SW/R5NYM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UMHqTznOYsHCLmjcT88TZ5gKiSqZgDMQ86jIADuyxH4=; b=SW/R5NYMFIM7hJHln+PmC+Yjda
	Dg8Zlv/Fl7iZhUBbJinOouO3OLJFTg/YExW8UZW6aLTVsvDgpPU+DZ5bfm412HwTMFXkPvNq90lTn
	YWR4pF+FxlaiBmeaQAVJbrIQb+6YEvyS6uGYHdbv9q8I2147JUnuQa5Vdg6F85oa/V9M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpgB-00Fk82-OP; Tue, 10 Dec 2024 03:08:51 +0100
Date: Tue, 10 Dec 2024 03:08:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 08/11] net: usb: lan78xx: Use
 function-specific label in lan78xx_mac_reset
Message-ID: <711fbc8c-9576-4c1e-af09-b1b19ee73243@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-9-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-9-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:48PM +0100, Oleksij Rempel wrote:
> Rename the generic `done` label to the function-specific
> `mac_reset_done` label in `lan78xx_mac_reset`. This improves clarity and
> aligns with best practices for error handling and cleanup labels.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

