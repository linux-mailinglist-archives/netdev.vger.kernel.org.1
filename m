Return-Path: <netdev+bounces-149051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F52E9E3EA4
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F92F2812BA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6902B20C46E;
	Wed,  4 Dec 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wXP9JVK9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D1768FD;
	Wed,  4 Dec 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327312; cv=none; b=WxwVZ7D+WGiczVbVLBY9GZqx1CFxLAeLXrg97trdH+m9s/MRE/mF/XG3Vg3SEyc8vPhL+wJA4hmlWxkc3DYuP0S7owTT7zCxoMWXl0Z5FXl0+i9iosHv98MOKu3i86kvTzHe6xtWcYPRwsYhcCXCWzTtXIzmepaK74FF/5gm7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327312; c=relaxed/simple;
	bh=WyVwOXbEbLOHvXOlA0Zg/YSNUMqxvNUXgbxJRVH3qqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hld4gAuKLXYo2WtS54RBvFUuz4JuFZU0pezPOIBoq6tfuMJ/gCYrCAmzP5k/XfwWYOX/V7ANEUkzx6okeYCwbt+HrtZVvVCdrMtpnls0nbRqYfT4ord8NA9bBFpzQ501/0IJYqwuFUDlFyS82ARc8jh8TJm95R+poe/udj62yEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wXP9JVK9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SiIlk/FEAmgdvplpgvduA7wwa6KAo49gIMe+ijciV2U=; b=wXP9JVK9S2ioX6EyNKlr+dmzS2
	mYdH7i78kdizKRgc569heQlzOBvygoPMqcAGtglYh2BU1jAyFbSoyTRiTNFOQZ+kgPXAYqFg3e5MQ
	jIBNm2/yl7xysLVtzrkB52We+Lvbpk+86HPRefEsEN+L+0h3RHD7qia5oyMpxDtoXLqk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIrbt-00FE2Z-5y; Wed, 04 Dec 2024 16:48:17 +0100
Date: Wed, 4 Dec 2024 16:48:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v8 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <af078f6a-08ba-4a68-ae54-2d49a59ce1bb@lunn.ch>
References: <20241204072427.17778-1-ansuelsmth@gmail.com>
 <20241204072427.17778-4-ansuelsmth@gmail.com>
 <20241204100922.0af25d7e@fedora.home>
 <67501d7b.050a0220.3390ac.353c@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67501d7b.050a0220.3390ac.353c@mx.google.com>

> Added 5000 as this is present in documentation bits but CPU can only go
> up to 2.5. Should I drop it? Idea was to futureproof it since it really
> seems they added these bits with the intention of having a newer switch
> with more advanced ports.

The other way to future proof this is to have a dev_err() and
-EINVAL. Testing will then quickly find any missing places in the
code.

	Andrew

