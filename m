Return-Path: <netdev+bounces-157752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984CDA0B8D1
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05D01644AB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14437235C1D;
	Mon, 13 Jan 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p+SA+9Jv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD822AE7B;
	Mon, 13 Jan 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776482; cv=none; b=Xrixc3c6BiSZEyXt9XX3hOGGbAqRUVTK9D+y2R382ZHJac0Se+aS3DBEMHgNjCXzFDwowd2cOCx2vuznqvtZOtWUZlTWmMaoo01YYzGeuS2ERmgaPiPBXZewbCde+8PlcDQYktuCJQoBIhjmNdhfS6SNnt4qKOFDZeDSzbe9hgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776482; c=relaxed/simple;
	bh=QSVu8ikpHRb83it9rPy9aw1cOh86UzMbxnfwSuF8dhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/WdqyUDQyoE4l/5p6Yqk/OUwLPRCYdPlWz7/NzTUW7BchdZ2sU4GcgjhJ2I0hoFZ6Xq9zYgE7Yvpsvi22LWiAtfQL/e3oA3mr5WTmty1zMpQIcrlYW1O8pk7upqi57icV3adhWBtbxN37GS0umuSKdu9Jco6evYuj4TJFmw3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p+SA+9Jv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w4s9MNfcI/MKbZctTiFjwWHOsRoPFtm/qaeRJ0Cqt18=; b=p+SA+9JvlaxeeRgn67DfWkJcaZ
	USiTK9q+9huYjt/BNdoJGfdT4H3sKKEuf9BelxBg7xigOmTh35nApg7KEhXDHkxpf9GvHxzqKIMNb
	uvnq82WDn14mVTIU+9hcaAawdTDDFwyOoS9SU00321tWtjsD+GdNclzy0n7xLebY2iN8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXKtg-0046kJ-LT; Mon, 13 Jan 2025 14:54:28 +0100
Date: Mon, 13 Jan 2025 14:54:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next 0/2] net: phy: dp83822: Add support for changing
 the transmit amplitude voltage
Message-ID: <fcffef06-c8d1-4398-bc20-30d252cd2fd2@lunn.ch>
References: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>

On Mon, Jan 13, 2025 at 06:40:11AM +0100, Dimitri Fedrau via B4 Relay wrote:
> Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
> Add support for configuration via DT.

The commit message is supposed to answer the question "Why?". Isn't
reducing the voltage going to make the device non conforming? Why
would i want to break it? I could understand setting it a bit higher
than required to handle losses on the PCB and connector, so the
voltages measured on the RJ45 pins are conforming.

Also, what makes the dp8382 special? I know other PHYs can actually do
this. So why are we adding some vendor specific property just for
100base-tx?

	Andrew

