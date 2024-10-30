Return-Path: <netdev+bounces-140381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA329B643F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61654281173
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D21E9065;
	Wed, 30 Oct 2024 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h3y2hE7M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFD185B62;
	Wed, 30 Oct 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295424; cv=none; b=TkCKtJVSMM1MSMj5ciijOY+k8OBLrEg8Z5n5Aa5PtsCmvXiOmzBaTMRssxRaACvbTJ50Sy9DSxTZTYMJs1bbxBHf+HKs5jFODzfg1CelfvaEqdmrZpLHw79Yw9dYT9f/6i8qey4FgZw1Fps3KHTjn5oq1/JaGbHwfJ8rybOm0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295424; c=relaxed/simple;
	bh=w+bRyFLCfgbalPcf2XBZFQXVbf4WySOrYutfs2HA1gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGT2AuwwWRSXupOzgW1fJiaDjFpVA8gqK6Fa8t5gQ9ZzARh3M3ZyjSfm+WUW8sM65H9DpluYmV8NeIIoZUIHjOjbCZMdwNMF2BFU+5yJ9hsLDElX/gPBmG9vS22T9E5T+r5RpXINmDJc/PtkzJ1MWEHKYypXy1nUqyTVXwpcjS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h3y2hE7M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rFYdceKXDgCkB1eWoyB4v0sbXnj3dG6xD5e+ahyD6Nc=; b=h3y2hE7M6pJN0LOc1QR6YPyeqw
	HAPu3Kf7FjVlgl5uATvthYVWdI1Znj+dazRb8WXS/m3nltyA2VS/ktovhhH0CrIRe2o3Fp6Ftr6bh
	rOKqZ7YoiICzRv7TN8lqdCcrjq/cPtf9pdblBOUrnocBD0P51grCjGpHkatlX6DG03K0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t68sW-00Bh0Q-Sz; Wed, 30 Oct 2024 14:36:52 +0100
Date: Wed, 30 Oct 2024 14:36:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, havasi@efr.de
Subject: Re: [PATCH net-next v1] net: macb: avoid redundant lookup for "mdio"
 child node in MDIO setup
Message-ID: <92cec21a-4c90-4fa9-9597-9a4a568459aa@lunn.ch>
References: <20241030085224.2632426-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030085224.2632426-1-o.rempel@pengutronix.de>

On Wed, Oct 30, 2024 at 09:52:24AM +0100, Oleksij Rempel wrote:
> Pass the "mdio" child node directly to `macb_mdiobus_register` to avoid
> performing the node lookup twice.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

