Return-Path: <netdev+bounces-259358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFN8NNsjlmkXbAIAu9opvQ
	(envelope-from <netdev+bounces-259358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:40:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C602B1597E2
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F2E23022977
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D27334C2C;
	Wed, 18 Feb 2026 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rGhWU5xb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591102F1FEA;
	Wed, 18 Feb 2026 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447255; cv=none; b=mNaGRDkiaeQRr9EPUH6wdnpbHq+yCpiEUwr191zi2E86iLSLa3LV7KE5ZNRFL/2I6VxEVeB2uye/Rw186NFvHOPvWwAlbv95kiwQEEJx87phF33FDrSkjUc20JO/sllCuamw6pbKpEtQ1kF2287LJrZuKbiumZk+TWVpz4iRyiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447255; c=relaxed/simple;
	bh=P/iXblGhR1e/v2Eo+QuUX4Y6Zlr6LZW/P9XFOX4VgEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGwqF8a1c392mqlMM+hCGm1+MXx4XuZl4RYdOCfKoOjk0Z3Cn9XdLu5oorn6LRcDtRPt0DMsFIhr98XzHI++O0MqZGH+LgxYLe/cLZldAb8P/aLrXgHsalHT8+DHEZ1WXFOvzl5WtOT4OiDo5ciWriZHV0+cnHauHrI87beloq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rGhWU5xb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4wQOH8NzAHkbNASrXgLE5ls4s9xTHcF8zXUipE4sqEY=; b=rGhWU5xbeEtyW+EUNCGraUTIMu
	0nXqX6maYZTMitx+hQ9iphUgobmaUvqXxP8hi16IpO6ENXASchYULf7iQ2UmX2MwoG5wPlwM4Spei
	DBQGS22Z69BrcGljIPv8ds9fZ2WgcIpONMEpiFbKaxrp0Dut6MnvBBOPEw9I7bvec98w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsoLV-007p9s-Og; Wed, 18 Feb 2026 21:40:29 +0100
Date: Wed, 18 Feb 2026 21:40:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: microchip: lan743x: add ethtool nway_reset support
Message-ID: <401df128-e253-4196-bec6-d9e52c8eb1cb@lunn.ch>
References: <20260218195615.25655-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218195615.25655-1-nb@tipi-net.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259358-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: C602B1597E2
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 08:56:15PM +0100, Nicolai Buchwitz wrote:
> Wire phylink_ethtool_nway_reset() as the .nway_reset ethtool operation,
> allowing userspace to restart PHY autonegotiation via 'ethtool -r'.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

We are in the merge window at the moment, so patches are not being
accepted.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Also, please indicate in the subject line which tree this is for.

The change itself looks O.K.

    Andrew

---
pw-bot: cr

