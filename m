Return-Path: <netdev+bounces-169178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207E0A42D26
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8784C7A4AEF
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B42209F41;
	Mon, 24 Feb 2025 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C97dPNWV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DEB1FCFD9;
	Mon, 24 Feb 2025 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426957; cv=none; b=oERhp898vjoowJ9eIslWXfsSDT+VtcTUDCo4xwawgzMHU47qwAv3Wxx7lAeoZOZVTt5RfBYfGAT3aCHbvMP4ihuVU1pJGmrFzT1Ywc0+LOXvgYoh4fhr4ORPzG1PeYr2BA8+0loUi0lK7tLpRshj/8o5E9LhSFK7+74dfPlzqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426957; c=relaxed/simple;
	bh=iF8kK04gOJHW239z7An589qmuvcys7RU9DtUQXRbnXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am+qxTwmMtCMx8/xxEa/v4SthfrhtcAAUky3B0M6m7vsoKIJtEhTd2eRHrl3WyrOapVRskIa6APHSiY+8f0oV3PT/Uqt8QjsdJ8GBl+fejJWNC697gNGPxmkYVe5arSIj/32unQRby1wsnPeybvq4RRXy8qmH3VYMJ6b36AAXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C97dPNWV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2UEsh7b9kWhLmrvT2oBqu1o1dRzAizPSkkJRQrBD0uU=; b=C97dPNWVGOIo8Gun+bJssqaCjj
	rkXWJzSrHaeXaNigt0WP7h1hFmxqDtI3mUDH6HIQqyA9gRDX0T3AS2N7L1DaokQwymHocJtHcq5oC
	ra6uwLdY1zfsFRyLZQ3/RK9sylvgwcNz0R4sG9hmkmjm6825yKTw001nD65YsCWhUdfI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmeYF-00HH7k-8C; Mon, 24 Feb 2025 20:55:39 +0100
Date: Mon, 24 Feb 2025 20:55:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Qing Zhang <zhangqing@loongson.cn>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/4] stmmac: loongson: Remove surplus loop
Message-ID: <1082af86-de49-40ee-bd62-80d068e869ac@lunn.ch>
References: <20250224135321.36603-2-phasta@kernel.org>
 <20250224135321.36603-4-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224135321.36603-4-phasta@kernel.org>

On Mon, Feb 24, 2025 at 02:53:20PM +0100, Philipp Stanner wrote:
> loongson_dwmac_probe() contains a loop which doesn't have an effect,
> because it tries to call pcim_iomap_regions() with the same parameters
> several times. The break statement at the loop's end furthermore ensures
> that the loop only runs once anyways.
> 
> Remove the surplus loop.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

