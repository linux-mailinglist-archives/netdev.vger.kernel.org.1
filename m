Return-Path: <netdev+bounces-214158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC5B28610
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E27AE5E7D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0BA2F9C3A;
	Fri, 15 Aug 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vaEn0Ywi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54886334;
	Fri, 15 Aug 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283961; cv=none; b=pTbwE2lkvPnG2CVZiBU1HsmtBTKQFYMI832zyKJaYPKJX1dO17kepnZtj1o1dmp5/qqirWYTCGMkhcgttc5wIOrAYBgXxmF8EJW7yMGYGk5SRDOsiTrHOHZMSMduAbXESJACrF7sh/TcYr7OBexTLOLNVwes6E/byJEU7HgoIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283961; c=relaxed/simple;
	bh=sEqMk8QHFf4hgeELrdnV10/xmgW7eUSzcsK0TAupUiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBUzd2GZRevrCc5ROp/FNZChwUDG3ly0ScrjEa9LKHHmrmKi/Ti8zSAk1CeeP/4khXxVMwz6FwQxyTlaa2jnkXZandltTmEEGpgASUWpwPu3mS0krcDHj1kguJ20HOa5ejA5EboDY+jV3ZKXgM/l2za0rQQkiQpIRYbmv5FUO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vaEn0Ywi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GOvpen0NiUbx4wI+F57v+/bYnzNTSnRwHD9BnDvg8Ao=; b=vaEn0YwifeDwk9+Yk6E+8B3uhz
	yxQJMnUwG13F+g7p++Ae/CbIIX3iH2p3GT4pHLXR29vATOgSx5GoCBjvCCNGFmHBD6o4hSsTgI1KU
	cQMlSI27JIPoblZWNp2zTXeAEy7iFJbLCmY0KCXFe1ThUWZtIVJKUo99S3KnD68hwEg8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umzXa-004r2o-I2; Fri, 15 Aug 2025 20:52:38 +0200
Date: Fri, 15 Aug 2025 20:52:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 5/5] arm64: dts: broadcom: Enable RP1 ethernet for
 Raspberry Pi 5
Message-ID: <bd395120-c6e4-4a77-9979-caa722685263@lunn.ch>
References: <20250815135911.1383385-1-svarbanov@suse.de>
 <20250815135911.1383385-6-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815135911.1383385-6-svarbanov@suse.de>

On Fri, Aug 15, 2025 at 04:59:11PM +0300, Stanimir Varbanov wrote:
> Enable RP1 ethernet DT node for Raspberry Pi 5.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

