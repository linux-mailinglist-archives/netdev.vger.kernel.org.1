Return-Path: <netdev+bounces-193764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16285AC5D2D
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 00:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4B91BC0E07
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 22:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78F217701;
	Tue, 27 May 2025 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fIglzrAk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60F213E89;
	Tue, 27 May 2025 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385419; cv=none; b=oEn3okcx20ig3A3qQNGKmGP8wDtTRiQ9e425XCcAU8v1aE+EBc85hkWOkuf1jMrAFOW3KKZKHFuuBdTVIyOr5n7pKEOdHEYJCGwB8xQuM6oBPRHDna9+HSVoH/9sLQF3b6o5y8iDruuDI1dhXQomKH8H8UqOHQXWMiN2IQgcyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385419; c=relaxed/simple;
	bh=vWvzVfNIWrFPmkZKsQ2/Z1Cx33Nq6SHCN7YusYEnQOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO32638NyMVNzQBEuL4UF1JN08TZRcKes702FOoeSKEolw9TFfHjXSdPJawYwioFw0g141RhARD1dBhvUrVDGNRuvVmNuOkJvG2uVJQCaYc1MsPh/FN7opXz3X5ju+gFDHcY5AbY2Gop9rRfreNnFLpEHFu3UHH0XyAoZW2KD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fIglzrAk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9HKzn5D1sKcucKDjWQ0nxn7C+0oHp7/7257o8TcwJVM=; b=fIglzrAkwdMp5uiubj9GPiDCVL
	7VLxmHgry94Hd0NsL54lebSqWJ7HumnuM9hq/pubmb9UPviWiHGGPox6LEt3q1vMedbRr24fZxlQZ
	SCFuO+iVPI/hJjRnbt7urAIngC/nwe4HqO8OCglcdEhC0qFbGvokIAW6cutISBTxayFE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uK2uc-00E78z-Uq; Wed, 28 May 2025 00:36:46 +0200
Date: Wed, 28 May 2025 00:36:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 2/2] net: mdio: Add MDIO bus controller for
 Airoha AN7583
Message-ID: <e289d26e-9453-45f5-bfa6-f53f9e4647af@lunn.ch>
References: <20250527213503.12010-1-ansuelsmth@gmail.com>
 <20250527213503.12010-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527213503.12010-2-ansuelsmth@gmail.com>

> +#define AN7583_MDIO_PHY				0xd4
> +#define   AN7583_MDIO1_SPEED_MODE		BIT(11)
> +#define   AN7583_MDIO0_SPEED_MODE		BIT(10)

Is there any documentation about what these bits do? The bus should
default to 2.5Mhz.

	Andrew

