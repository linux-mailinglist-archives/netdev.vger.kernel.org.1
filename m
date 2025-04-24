Return-Path: <netdev+bounces-185575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B0A9AF0A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0016194422F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0113B5AE;
	Thu, 24 Apr 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E94egB8C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE44EB51;
	Thu, 24 Apr 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501570; cv=none; b=uxh5NVW3qVAz7yEWs9m9tA2IEEIrIcmKu0Ljkta4feIF/iCAEbf0Mkl4zgQDsr0qrfYPyxsXXNn2yRSB6j7UzUI2Z2bOSW3MDtqzXKmaSb/7jRz16WDaNYAnXxToAANpKVOEIU+3KMUasN0sCZNtXq92UdSElFteiltEFHQorbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501570; c=relaxed/simple;
	bh=KQNMIAfXh49xCtRQBxsBAwyCnS6gS+XOH1q2PhlhLyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=floWsJFrYmOZSgJra0Gys/hV2/J6dB+C4O6Is1uthhhuBT9ifVyDROf5uYC1BvavACZnBJh+xwXV69WMp0XdmcNLqhsRaG4L3R+Zr2Ro8q5PEuXSR80+70eorQKZKi44eFbO0DiUn58AfABzmpNVtZfdS5rkqqh3qkOgBcCf2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E94egB8C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=gmFv+tXEHYX7Ma3ew81kmxN4G8P+6CzJSOvVgnKOh54=; b=E9
	4egB8CqtTOjDUEqJRsWVzhfzq39pm38uoijSaR8zqYVzxqKVf3UdUGAnvKpxqy+exD/orSQbqAic4
	XHev/HvOzLuJ5auj96yizY8WaPxhBqlSuh1DqYZ1nMQQFZt5C+GyPZv+hNRU8aoHnHuwMf5liMiNK
	tyhhMeyNlLvJy6c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7wgW-00AT1W-9j; Thu, 24 Apr 2025 15:32:12 +0200
Date: Thu, 24 Apr 2025 15:32:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <caad87f2-8243-4571-8236-6aa3d4fb9fab@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
 <aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
 <20250424014120.0d66bd85@minigeek.lan>
 <20250424100514-GYA48784@gentoo>
 <6e9c003e-2a38-43a7-8474-286bdb6306a0@lunn.ch>
 <20250424142006.021d6ab4@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424142006.021d6ab4@donnerap.manchester.arm.com>

> Speaking of which: do you know of a good method to verify the delay
> timing? Is there *something* which is sensitive to those timings and which
> can be easily checked and qualified?

Not really. If you are on the edge, you might get more ethernet FCS
errors. For iperf3 in UDP mode, that would translate to packet loss.
Or ethtool -S might report checksum errors, depending on the driver.

From what i've heard from others there is a pretty sharp cut off from
broken to working. Just stay away from the cliff and it should be
O.K. for −40°C to 85°C, or whatever the temperate range is supposed to
be.

	Andrew

