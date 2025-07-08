Return-Path: <netdev+bounces-204999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11DAFCD3D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B18B481DB6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE72DFA54;
	Tue,  8 Jul 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u/8Qchhg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47E2BEC28;
	Tue,  8 Jul 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984298; cv=none; b=d53zpMfaTaTF5LMAFgufur4/UfvBXHj4o9HZ5r8B0EHTvJ1yFYd8+ZLESBL8v13lFw5sHfT/rA0KzZMkjsJ1Kelb6WIeR7PIi7l9wOQiqBkIh6HQoYSfBp2TA+wI8z0p56L2OI74hGqYRBJAdYkzIXX626YxYSYJlOTlIf/j8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984298; c=relaxed/simple;
	bh=Z0fAqGkGmDO+vyOmPt5ruF7E1P3LEBpkCoCU6bS4HxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZn3ZtJKlHWMPzEOGejBXlcQJQ/tm1+eUjMd5wA4pkQGmjVxgWZj8Q6UhUKGsuch9wRD7cm8HMQgsDb8H36v17Bec3w37oRfB1HHmjj4/piEax6m1Tz9puB8n53qxr7AtkofZXVtPhyyhzU+nGhu/a9G7MyZEgPEgnBUyZDv9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u/8Qchhg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZieroGSgsV5Uoy51xSzBoB38R1YH6XLakVRbQbz5U+A=; b=u/8Qchhgg1rLZdTCTQ9QkrViPF
	OCRCO+tChhLWv3aQvPI+UK6VgnJY6ct03w/ag1GIbW22sIwObu9lJa+RwEYFH+08HIniCDa2EnEzF
	I2Idne5GDzfgjFC6pO4kPHt0QV+a6EWUmvEPyzDiyux/dhHTPagG7Mdd409ZnKp/s2Xg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ991-000pND-M5; Tue, 08 Jul 2025 16:18:03 +0200
Date: Tue, 8 Jul 2025 16:18:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6 v2] dt-bindings: net: dsa: microchip: Add
 KSZ8463 switch support
Message-ID: <46ea903b-71c9-4469-ba29-884b3cda0467@lunn.ch>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
 <20250708031648.6703-2-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708031648.6703-2-Tristram.Ha@microchip.com>

On Mon, Jul 07, 2025 at 08:16:43PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 switch is a 3-port switch based from KSZ8863.  Its register
> access is significantly different from the other KSZ SPI switches.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


