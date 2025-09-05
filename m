Return-Path: <netdev+bounces-220507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D3B46759
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634221CC5499
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84829C326;
	Fri,  5 Sep 2025 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPl+478J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D454654;
	Fri,  5 Sep 2025 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116750; cv=none; b=E/n1PPvFWDRejLKv8ldC54xlcJpb2/V0+h07vtn0BpY4D+7z8y3EO+310TzLdNKAYseqRL74OSlCXJi6JkELI+PTP0fJhLpJAwgkrzYFLNNU4L+emImjg6gdMz/6F0ao1lu0C/Y6qX01hGyNomHjKgsU2HjIV50fHBdAhbcaqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116750; c=relaxed/simple;
	bh=YvJhCsK13+5y12Tg8BXHiyPd4M1kZnLPFozMdNrGnmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MW/hM97kWkLW+BlAaL7HzmdD1DaybeyEylajJijRDygMLcfQU4/qFq3nkS4Ao15Ic6p2y45I8GI9EUpNAfts3oxPEa/C9x8tl+F0IIcxCCnrjQInb/soBT5LuKsNB6K2NIALN0grjcgbVLvuNYI9773hzWFJ7Se415+uX4f/GH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPl+478J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB80BC4CEF1;
	Fri,  5 Sep 2025 23:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757116750;
	bh=YvJhCsK13+5y12Tg8BXHiyPd4M1kZnLPFozMdNrGnmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CPl+478JhsxSlnKwEhJHHCRoBp5cR76ubXmiKStL5qIRsk1zGB6DxJ2jIo1A4czaK
	 8X1090aw5/cPM0JXfhbWckAAziREaugxifYX2pRm5vWlKnLMmOW1hzC1l+qkQzLma+
	 d1C+rJ0QncTjuWjoSf6NvbYzIXlAXHbhMgOfMJ7MNzK3CA3eOWuW+s2Qnk4rYBths0
	 WNfBL47hnjihjV54KDAoviJ1Lg2a/TH1/S65gkDbU4Adn+Bg0YDnNApaFRXKeA1mve
	 TnkUZLYD+lOSAixkdgpCGk688UMOjk6jlEiLUjUUzm+3luKjjKaEGIQcwYM+zpKbc5
	 txiIHjJziZj/A==
Date: Fri, 5 Sep 2025 16:59:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Junhui Liu
 <junhui.liu@pigmoral.tech>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, Vivian Wang <uwu@dram.page>
Subject: Re: [PATCH net-next v9 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <20250905165908.69548ce0@kernel.org>
In-Reply-To: <45053235-3b01-42d8-98aa-042681104d11@iscas.ac.cn>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
	<20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>
	<20250905153500.GH553991@horms.kernel.org>
	<0605f176-5cdb-4f5b-9a6b-afa139c96732@iscas.ac.cn>
	<20250905160158.GI553991@horms.kernel.org>
	<45053235-3b01-42d8-98aa-042681104d11@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Sep 2025 00:35:37 +0800 Vivian Wang wrote:
> >> On a closer look, these counters in ndev->stats seems to be redundant
> >> with the hardware-tracked statistics, so maybe I should just not bother
> >> with updating ndev->stats. Does that make sense?  
> > For rx/tx packets/bytes I think that makes sense.
> > But what about rx/tx drops?  
> 
> Right... but tstats doesn't have *_dropped. It seems that tx_dropped and
> rx_dropped are considered "slow path" for real devices. It makes sense
> to me that those should be very rare.

Pretty sure Simon meant the per-cpu netdev stats in general.
There are three types of them, if you need drops I think you
probably want dstats. Take a look.

