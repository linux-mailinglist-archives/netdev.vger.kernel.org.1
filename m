Return-Path: <netdev+bounces-123451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8281964E84
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84ECF2818D4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A07B1B9B55;
	Thu, 29 Aug 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ8/cXRB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9E1B8E92
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958783; cv=none; b=gg173BwhgngWMPt/hAhlUANnEwWVAe8LKjpjqkVIBIiUqVRSb44jzodPuYcWrDDZMSvj6OpvzKoTSylynHd/cePEShA39OJlxCCAWczWwGC75xgpSZfpKk3N0PYSRrB/CPu7g0gFiFb8g36CaNfxvCCDzQjXuAZAY3e4lqWAa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958783; c=relaxed/simple;
	bh=IOQVgSSoW5CWkbf0tW4lCJMBqs3Ah0avP5dC0pmIVzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8oD3CeiPiUueJmLcSVyzY3/t3+ta+q9jr9UZVI+D4Pdq1ixvEgvzyvt/NFgh6KZTUxThTDopc4dWMCfwLAnEXessZ/3ekLW9fjSjhOWxZNDlmcJ3EjAlGiBfI4Nc/9Z6/QKyzcF66MScMFhoOFCvdYw0wiTTTtun/FsviKK66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ8/cXRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A90C4CEC1;
	Thu, 29 Aug 2024 19:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724958782;
	bh=IOQVgSSoW5CWkbf0tW4lCJMBqs3Ah0avP5dC0pmIVzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LJ8/cXRB3BSJ8Z5p3H9nfiBwg7l+HXGUhfaW59MVXkpqwxdeahwlenQkVSpiDfs3V
	 ACTAjd2a1blOa2030OLDMh6dPCezBtUTHj9/fM1rI5V2GXZkROit94Y1FQFrmHfpdL
	 3CWhCibFhBLzpgiKAq/EfT12Rv1odPm7PB4Jd9p67W9yoGnmjUX/4XwIgVYytpFn4W
	 lonwNKenJkoNGHu1s6PNnpeyL7G5GYbfBBwKFnKweAZ3c6sWS0ood19ZSeQjDz+UZA
	 igvr3EWceO50CwES+bh9hfMOB4z3jnAXe9K2EsG4WzXwKu5wtHnap4vHC8LY92NR5G
	 pFbIIC0VDoXsQ==
Date: Thu, 29 Aug 2024 12:13:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Vladimir Oltean <olteanv@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, woojung.huh@microchip.com
Subject: Re: [RFC net-next 1/2] net: ethtool: plumb PHY stats to PHY drivers
Message-ID: <20240829121301.4b6d51aa@kernel.org>
In-Reply-To: <ZtC5eLe8GQRE5dU_@pengutronix.de>
References: <20240829174342.3255168-1-kuba@kernel.org>
	<20240829174342.3255168-2-kuba@kernel.org>
	<ZtC5eLe8GQRE5dU_@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 20:10:00 +0200 Oleksij Rempel wrote:
> On Thu, Aug 29, 2024 at 10:43:41AM -0700, Jakub Kicinski wrote:
> > Feed the existing IEEE PHY counter struct (which currently
> > only has one entry) and link stats into the PHY driver.
> > The MAC driver can override the value if it somehow has a better
> > idea of PHY stats. Since the stats are "undefined" at input
> > the drivers can't += the values, so we should be safe from
> > double-counting.
> > 
> > Vladimir, I don't understand MM but doesn't MM share the PHY?
> > Ocelot seems to aggregate which I did not expect.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Huh.. it is completely different compared to what I was thinking.
> If I see it correctly, it will help to replace missing HW stats for some
> MACs like ASIX. But it will fail to help diagnose MAC-PHY connections
> issues like, wrong RGMII configurations or other kind of damages on the
> PCB. Right?

This is just a pre-req for the next patch, to let phy drivers report
the (very few) stats we have already defined for integrated NIC drivers.
What statistics we choose to add later is up to us, this is just
groundwork.

BTW the series is primarily to allow you to report the packet / error
and OA stats in a structured way, it's not related directly by the
discussion on T1L troubleshooting.

