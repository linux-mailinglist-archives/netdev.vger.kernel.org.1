Return-Path: <netdev+bounces-210012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BBEB11E90
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FCA5A1FDA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC22EB5BA;
	Fri, 25 Jul 2025 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wMd7Rqth"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9E23FC66;
	Fri, 25 Jul 2025 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446716; cv=none; b=F1QMbyafaHubnircZNaY3imIZRNbx1uiBdO8ZbszK+z4zsLspHuo0rZznGI30k5bXHHjJSgAWv+x5Js3/t0RulvajQKnnUy6NBwCRXsbK5+oVaZufhe/aYSKhm/dBgWUG0S/Q+utpbhjsm1oc2k3yRTibrLi6wWLtguj5CJzJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446716; c=relaxed/simple;
	bh=21kdazm3dA3uRM7RId50d1DTdGjM3+Yf2AZT3zzuox0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHJURE3hqA7JCzUmdO6HG7LwU7ym+RZF+h5U7jy5PyrUAZp2W00zzm4dRxeQGZYrwZ9sKme7XvfqAo8V+7Dje3v18hc4GRXzOMNwYwlsjBRGfE4V0wMwvmyKMBZRn/5oXC1HHv45Pwdww7FUoTNIYnNH6/rHn/PUxln2XP0lrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wMd7Rqth; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X28c8kclYQj09tLPR7kfmrE6WQfR+ZPhLx6YmKTd5uc=; b=wMd7Rqtha2mbw7yGB/GvWpqFSz
	74Hyygr24XJIxIJ+eplQFR3ImhR2CedabENr4AdU9K5rxZLIx122RGyRdgtPCaqMKPQf5+2elQoRr
	EdAtvDZ76x260UitEWFJZwg5vSjIj6/X6AmHxjpc6yIe/hTjqPEksP1/F62jo+mrPjJ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ufHaU-002rdk-H5; Fri, 25 Jul 2025 14:31:46 +0200
Date: Fri, 25 Jul 2025 14:31:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 6/6] net: dsa: microchip: Disable PTP
 function of KSZ8463
Message-ID: <15b7c9e5-ea7c-4efd-8ee6-c8562feffb9b@lunn.ch>
References: <20250725001753.6330-1-Tristram.Ha@microchip.com>
 <20250725001753.6330-7-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725001753.6330-7-Tristram.Ha@microchip.com>

On Thu, Jul 24, 2025 at 05:17:53PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The PTP function of KSZ8463 is on by default.  However, its proprietary
> way of storing timestamp directly in a reserved field inside the PTP
> message header is not suitable for use with the current Linux PTP stack
> implementation.  It is necessary to disable the PTP function to not
> interfere the normal operation of the MAC.
> 
> Note the PTP driver for KSZ switches does not work for KSZ8463 and is not
> activated for it.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

