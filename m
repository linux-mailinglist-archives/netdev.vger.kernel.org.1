Return-Path: <netdev+bounces-104895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41090F067
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3181C21534
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB89517C64;
	Wed, 19 Jun 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QfMRxcTV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC303BA2F;
	Wed, 19 Jun 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807260; cv=none; b=YEN451yyp/FQe/zlLvhfD1VoNb/NymnmU+GqED60otKthMwxuKnc3ojK5dBYZIBSEtLZ+NzDCjL3uq42FccbxXm2KJ7BIBoLgxSRH+aOKCbyFmaaYUuU5qe7EBDsU6BgRyupIxMhMwPHf/6t00DaRrwDQV2EhOYs1kL0a8pdzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807260; c=relaxed/simple;
	bh=IkiduiijLkVgV/bSv5r8vwtQTPo5N92a3qp7G86Umqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBS1ubPxXZZVeypygH7Cp8Z+UvjAJsxgf/WrJv1LL0He3+lzM/iyxspkcmCJU+eDVVCDCKEcaulLV8QrXQAgeIn58p0HOGHqC6RW18L3WzmYf9Zs5lXiD6hUhHlgq1vDDxg9cTmWCyUZ7W4jftVRWqh3xKZhopTJZtoJXElC0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QfMRxcTV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=23ThqQ+vY+UW638OME0meTnsHSF60P7gNQHbZ6O+nQw=; b=QfMRxcTVMHIFQ/DOnlEv/sAwcB
	gGIKs+hRi+h9+fn/Jbd45UrPvHFp7pyn4DfeX1QRzSXZNcHpqtZ+3k9qnhdRz5Lhz5i285wUQR69B
	PRPxUlULQbI5p6lR1ms6P0fmvHNgQwjJTTzN/o0gls5atNL9uOEOmrzfQAOejPmdSw+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sJwHE-000TV0-Th; Wed, 19 Jun 2024 16:27:08 +0200
Date: Wed, 19 Jun 2024 16:27:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <8ee63f71-9aea-431c-b289-8a353925d31a@lunn.ch>
References: <20240619134248.1228443-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619134248.1228443-1-lukma@denx.de>

> +	/* KSZ9477 can only perform HSR offloading for up to two ports */
> +	if (hweight8(dev->hsr_ports) >= 2) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot offload more than two ports - use software HSR");

Bit of a nit pick. 'use' suggests it is a directive, you need to
changing the configuration to make it work. 'using' would indicate
nothing needs changing, it has decided to use software HSR for you.

Other than that:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

