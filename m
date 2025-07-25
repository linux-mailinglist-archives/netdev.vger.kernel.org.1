Return-Path: <netdev+bounces-210013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEBCB11E93
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6892C3BFD68
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0A2EBB88;
	Fri, 25 Jul 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="khvdXs4I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183223F405;
	Fri, 25 Jul 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446742; cv=none; b=MaVpK5fdAdfKCjybZBmq5UPT0djxYInqkqvLNSSBJquqdH2jnAEMC+BATc/bJcGsJIO6yajGe+BEqbI46eUC2sxX5sVe8KqjQWYGEHKlxqU4+Eg9m0hHszGePiNG0mqzMr1RqP4on0CtGh+/vCrQSQpQXVeJpAjodC/CAqlvGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446742; c=relaxed/simple;
	bh=nMlPkwsAMV4zsv1SR1rJywivQ/nB9JGVIMG3o4p2u3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwKtEjwtEqEh12940Z9QTyenyyq3UhkM3XWNxdQAj7jJpd6Bag1v0jWP8ziSvWhtPNeY0EQpmQgMaI7sJeVaxN4v67V1nCmaDXxzrp2tvurmNdQSz0uhwT8eykJnRdOMD/IzYdzljA0JPVb0jn9Xebd8/q617h9+SqQimYArMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=khvdXs4I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xXom04G3tyIWIn7peV2JwwmBl1LRS3vKTDv0z/MPZeU=; b=khvdXs4I4lUKdLhfh84wANAxuw
	bLQrpkB331OPXsXNyroobpxR56FC4v2TLXzBnJAXMpPd5y58R3sOiCN+Uy9iU0N/KDqRXFyfGQQkD
	J8CpOC7m6kEE/nDtpCXdASRDdAYevgvzFlpQhyNOe7wW8PJX5MZgJTAHadYJA/y3ni9A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ufHau-002reR-GV; Fri, 25 Jul 2025 14:32:12 +0200
Date: Fri, 25 Jul 2025 14:32:12 +0200
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
Subject: Re: [PATCH net-next v6 5/6] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Message-ID: <15302f26-8671-420b-b5f1-77d8a7a0968a@lunn.ch>
References: <20250725001753.6330-1-Tristram.Ha@microchip.com>
 <20250725001753.6330-6-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725001753.6330-6-Tristram.Ha@microchip.com>

On Thu, Jul 24, 2025 at 05:17:52PM -0700, Tristram.Ha@microchip.com wrote:
61;8003;1c> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The fiber ports in KSZ8463 cannot be detected internally, so it requires
> specifying that condition in the device tree.  Like the one used in
> Micrel PHY the port link can only be read and there is no write to the
> PHY.  The driver programs registers to operate fiber ports correctly.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

