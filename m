Return-Path: <netdev+bounces-191633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA3EABC88C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9171B658F8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C4217722;
	Mon, 19 May 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GP0qDkXt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6021770A;
	Mon, 19 May 2025 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687106; cv=none; b=pwndjmV4Q7PmlRH/7N613RJ/zsYgHcVKKYeL8+KMZoj0RQ2wqtEOJ4KpEkmXzawxfS0f3iNvojIlz2gTtyaaiK/Yw1IsgwPXgrOvd7/EQ+LFJr54Cm5Q/4xNOG6fRIsppVbo6xrjj404p+1gjng+UzIGRyYJDztSZIlO9+rcvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687106; c=relaxed/simple;
	bh=/U7LrkpfpUpFNeKeDpiSOEJ2XWoMvUPa4Ey+unUtmy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKGOwashzafl9IXPPS7av3AqlmgQ1lcRKl2i6J9N0tP6ZpSHJJZeMbnpRv+bh9UX9Q/Zodcqsoae0ZDAi4QH2+agXiMU5zfYUv1Y3PcURrsJuIymPK1X+IPGkeNXTE6nMQIesZsnzNEXGIDiaz2I12anqwyEGTvfLn8smq2Lun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GP0qDkXt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O/0IcdVQE5Us1JeC/7Mie5tysbAZM3UKBVkJQ6942JA=; b=GP0qDkXtjwpwP4f1GOOTvWNQDw
	MEnvFI+0pp6nHGYpcvjNmLUV2j4HbrlArpvjLp3VunvgL2GEYDmFpxnbdIcx9sKh4lyiSKCY0cCTK
	pfmWqr1u4mtpz89N18QVW5tFQ3+tK/RFBduWyxlFtN192Ydmw1L86QUUfE5pbmopBKyQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uH7Fc-00D3Sq-9r; Mon, 19 May 2025 22:38:20 +0200
Date: Mon, 19 May 2025 22:38:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH] net: dwmac-sun8i: Use parsed internal PHY address
 instead of 1
Message-ID: <0ee2c181-1ab2-4d81-89f0-9d2992464a88@lunn.ch>
References: <20250519164936.4172658-1-paulk@sys-base.io>
 <d89565fc-e338-4a58-b547-99f5ae87b559@lunn.ch>
 <aCuLwuSliICh86SP@collins>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCuLwuSliICh86SP@collins>

> There's actually only two users of this (this code path for internal PHYs is
> only used by two chips), which are platform dtsi files that have the address
> already set to 1.
> 
> I have actually tested both with hardware and they work fine.

O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

This is something to think about for patches in general. What
questions are reviewers likely to ask, and can you answer them in the
commit message?

    Andrew

