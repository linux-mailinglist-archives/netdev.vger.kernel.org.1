Return-Path: <netdev+bounces-150484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1209EA68E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E8628591B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136421D4609;
	Tue, 10 Dec 2024 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w4Zd50mg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933DB644
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801166; cv=none; b=AgzVOG8i8ttmyDmxRFPBm28elgvTHio34j2uBIuzePkC9VnEt9pCx72ETnG/DAiLK59lzVUCUztpptP7UNWYPlx+ypTIoXrJuSWnz3rrcxNMO1mKiNzN9eumBmyy/ARdrgvY81Wzicf3zHdWTjszwMO3RgDNJnXzsSaev9hZBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801166; c=relaxed/simple;
	bh=dx/cln2K2V7L0+KAiKcvigK0qBqpr+tQWXDhGu7J8fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDwCzXYUzySiv6AJ9tflUNU0dPRte/qeULtlz/KxhKBlW8Ug5tQX+iUMJalGsW0APKmAeVjTGTt8gRP4TW3EkNuuREVo6Y5HvY0zuAe09NyuCpiij3sxImdoTbfkoHm+lIOLZ+t5pGCSfqkMPNAS0NPYUcK7PIqAdvgoeTUE2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w4Zd50mg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GznTRwEqMeqJk65KppPi2e/HbGa1yYKFHV0R7EXwC/g=; b=w4Zd50mgu0y0nTog3I5d9qIpme
	xGrwQU1269nIeQkc5nhUyEG0SEsIJ18Gn/eW4+rq5Akt0jUqjY0/OKFZj/m9aDWCeV5INHoDvIMWW
	uAQDHaqbtnGp0jmdAsp0YqiaghYH6SbhHJ7JNYWjFptxtujcT8Uo5k8h/FKKpvdY6JpY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKqsn-00FkbM-4k; Tue, 10 Dec 2024 04:25:57 +0100
Date: Tue, 10 Dec 2024 04:25:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 07/10] net: mvneta: convert to phylink EEE
 implementation
Message-ID: <e3b19964-49cd-467f-bf2e-93aa321fda1e@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefs-006SN1-PG@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefs-006SN1-PG@rmk-PC.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:23:48PM +0000, Russell King (Oracle) wrote:
> Convert mvneta to use phylink's EEE implementation, which means we just
> need to implement the two methods for LPI control, and adding the
> initial configuration.
> 
> Disabling LPI requires clearing a single bit. Enabling LPI needs a full
> configuration of several values, as the timer values are dependent on
> the MAC operating speed.
> 
> As Armada 388 states that EEE is only supported in "SGMII" modes, mark
> this in lpi_interfaces. Testing with RGMII on the Clearfog platform
> indicates that the receive path fails to detect LPI over RGMII.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

