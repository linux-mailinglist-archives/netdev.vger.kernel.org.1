Return-Path: <netdev+bounces-237391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C7C4A271
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203183A9107
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF164204E;
	Tue, 11 Nov 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O1I9dYGe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F2248883;
	Tue, 11 Nov 2025 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822988; cv=none; b=rto9HRIg0i+xBoAFMMTOV29szEpGheER2PjMVv/Xf4j50aS20uyP+duHiAduhxsjVpA39afAb27OMW1UZJDksLf3qOWKfhhXTalOyMhwklobhExxy3oVM+zacA/W4n1HXddW7w8cDbNyoYD05A/tvj4pH6zwYwfI7pO9s5YTllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822988; c=relaxed/simple;
	bh=9Fs0oNkjA7wtiD5FJEKVmR+8bAGbBjg3y9Ep63XAvEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD8rmJp294dnastfybTfWWPysU/Nfue/i0kwH0Fxk5uBTe0x117pLKT6JcqERHu1Fpx3GHc2F5mysnD0e2t2ef2e3WuIDY/vDcCKVTDSiQetDTaYL5CjgH3GZiNrVlcW5DcbPPn6wwC5FOZr3uithIgt/PDZwD7jXhBAIV2tZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O1I9dYGe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HnN8PEoLNm7nZNzwRVrJ7gG6TkHaHIjcUK5pdx4q6Bw=; b=O1I9dYGeBlruCci9+jd/1lRD1G
	OCyGUGO6d15317LY5ZCRCBqHVE9QlmomLxwEFPF32cDSfiWLiYPN9OGV5C8okHHN+2+hLOVJJdBah
	8v1nwRFTyqU2GDJX0n+cSEoa4+Gmkg2Hb/SDGVmfkK3awiI7mrpUXuptW5UxKqap+irg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vIcma-00DZbX-L8; Tue, 11 Nov 2025 02:02:52 +0100
Date: Tue, 11 Nov 2025 02:02:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: phy: dp83869: Restart PHY when
 configuring mode
Message-ID: <f82320cb-6467-4abf-b1d5-4463b121e936@lunn.ch>
References: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
 <20251110-sfp-1000basex-v2-1-dd5e8c1f5652@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-sfp-1000basex-v2-1-dd5e8c1f5652@bootlin.com>

On Mon, Nov 10, 2025 at 10:24:53AM +0100, Romain Gantois wrote:
> The DP83869 PHY requires a software restart when the OP_MODE is changed.
> 
> Add this restart in dp83869_configure_mode().
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

