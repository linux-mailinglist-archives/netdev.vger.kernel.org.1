Return-Path: <netdev+bounces-242759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BF0C94A08
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 02:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6F2034670C
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 01:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3A81D5CFE;
	Sun, 30 Nov 2025 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GMYFzAUF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442446B5;
	Sun, 30 Nov 2025 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764465079; cv=none; b=bT+LpzgiYgE1CJIauYK6Wx6E3bQTD6jWekto7EFISRfrddpcEN5bL2vvNlIl6//mAPwpogk+1irJgKMNn4l+2MOPHD7SJlcc+I+Tfh0Z67mAA1dTVIecgsjn/J3752jeeYmsDO4p2nchZzACrNhXYzyQiSkurjp1VH7FE2uloPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764465079; c=relaxed/simple;
	bh=m6v5tKCDwVl/YSgTd3zQtgkVx5vZKyDzH+okmE6c5aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8WBlwjyP9B8xE6NT52cozCA7yYRQlkGrSDbAI9skjs42e4oUjjYMykc4egsxMpPkv/xuNinx9d7SihVA7sWU3m1aH1yNuDqKf5wtXTy0ONaTQ5LnneS6k/bvuKfdMQD41WncNTlOQuccV/m4EV8+mQ7A4Y69UTLYlAhPtW6FoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GMYFzAUF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4ZxstrwqiBcyWOqJuW+tJREFzkMchdfJApHbYGANKJ4=; b=GMYFzAUF75LvBe+8epBvBJ/3ja
	TkbmT8k7NQsb0bFDJKfHzSEjIyT4FwEzhH1WwkiBBVK6/JkanxBvrQ375fbijzjHgZ9OnwYrIP9DM
	xKcFtvwKmGbzVfi3u6Zzpcy802Q1J+Dd9+ePG4K5CRbC2Uj6jaA3Sl6zUclY7UggNILA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vPVxx-00FR86-6b; Sun, 30 Nov 2025 02:11:05 +0100
Date: Sun, 30 Nov 2025 02:11:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chen Minqiang <ptpt52@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129234603.2544-2-ptpt52@gmail.com>

> -		gpiod_set_value_cansleep(priv->reset, 0);
> +		int is_active_low = !!gpiod_is_active_low(priv->reset);
> +		gpiod_set_value_cansleep(priv->reset, is_active_low);

I think you did not correctly understand what Russell said. You pass
the logical value to gpiod_set_value(). If the GPIO has been marked as
active LOW, the GPIO core will invert the logical values to the raw
value. You should not be using gpiod_is_active_low().

But as i said to the previous patch, i would just leave everything as
it is, except document the issue.

	Andrew

