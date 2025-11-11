Return-Path: <netdev+bounces-237392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA00C4A2B9
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD44C3AF8D3
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7CD253944;
	Tue, 11 Nov 2025 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mu4Mu/km"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFF246768;
	Tue, 11 Nov 2025 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823043; cv=none; b=htFhWEJZfDh9MCnDYvXj4GuHO77wAalN24jthtCUxzxVeBmoElE/xiWxII9BR6jIizDb0fznZyyU+7ktxkbl2ISjaGjMK7GN6m5nFl4+m7aqMg9/Nmb//uRlBkQIATouk/AcYUXCLUDGPcH4CbcTB1eLCKYUIa09sYp/s+SWBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823043; c=relaxed/simple;
	bh=zxFxDfCO/gBSNJc/mQ8zLk1LNviKOC4iAX+yygvGpbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2yuCA7f0q5PLmFfWW97GxBYDN3cjUYphIjc7IGax/wBNC56yEg2FIRxc6JMkDAuZapy8igbK0zIq6C3gqMuyKdKBP41dDtyJIwCa2+0TCl0d2NepQCmSppkisnENBI94fXYOdyjO++urxO5p1QyJKarDnMKhPmisxGglao32SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mu4Mu/km; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DlWJxmWku9DDHewc8Fqu1R47P+5D2ez4FYUnTE83BCM=; b=mu4Mu/km0CsKrksq0EGmB5hm/9
	eciyVrbFM1Pxr5EqrnnNLSQuHfQJWg1EYy1HpfkuCM7KifhgXIQFUA5x7wIQMS1wTKbOdHjT28PQN
	+TwxglW+N5QLmEd6lrSyzH+puSLrEqwMrfgA8XdUtwK3PSCjZZvTjiqB2KI/bBxaeLUc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vIcnY-00DZcK-R7; Tue, 11 Nov 2025 02:03:52 +0100
Date: Tue, 11 Nov 2025 02:03:52 +0100
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
Subject: Re: [PATCH net-next v2 2/3] net: phy: dp83869: ensure
 FORCE_LINK_GOOD is cleared
Message-ID: <bcf5a9d5-408b-4dd2-9fa3-47861c038183@lunn.ch>
References: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
 <20251110-sfp-1000basex-v2-2-dd5e8c1f5652@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-sfp-1000basex-v2-2-dd5e8c1f5652@bootlin.com>

On Mon, Nov 10, 2025 at 10:24:54AM +0100, Romain Gantois wrote:
> The FORCE_LINK_GOOD bit in the PHY_CONTROL register forces the reported
> link status to 1 if the selected speed is 1Gbps.
> 
> According to the DP83869 PHY datasheet, this bit should default to 0 after
> a hardware reset. However, the opposite has been observed on some DP83869
> components.
> 
> As a consequence, a valid link will be reported in 1000Base-X operational
> modes, even if the autonegotiation process failed.
> 
> Make sure that the FORCE_LINK_GOOD bit is cleared during initial
> configuration.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

