Return-Path: <netdev+bounces-216312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E30B3312E
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5343E446395
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A1277017;
	Sun, 24 Aug 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2X3zNeGt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5751F4C96;
	Sun, 24 Aug 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756049173; cv=none; b=GuWUQLZOdkj+5gioypEVB0uQLDclv0J0/jdYtmxQE4tq+QlmG6QqEZQd51MU6mk5OqqkkM/pdOTf6OJH1cT//h1HPDbH+yrr3gmpHiVF7CiEau61aQZpd4IJvZ7p8QPgQIglcwqlzNv4D1lP23fmsFUkanAhtYuM+oKnKfezbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756049173; c=relaxed/simple;
	bh=NDsbkcxVgInlfzgr07RiDDsGSSz67LENAxxnUp1kUbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG+O2s43vW6ZYfwZlbHTmyJztkeHOnFwN9NbI7q11t00qwup2fZE+BlQX8AB6CWyLoiQrW+XtGMHUidqxGP4Og6lSq2z0u0MWV6MiQQAeR6nK3sD5ftg2vX8CVQO2yVHZxJRFDTzc0rsuyflOW8m7Hj5B91T9hyLrc+xt47dk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2X3zNeGt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tLUW+tRS5SWYfz5ZkZx3v6UAGyyEC+juyc+tith6m0k=; b=2X3zNeGt3pDGLjO7FlusvrjJTG
	lpb5LUPKEGlKxK+dKdqRxbgIIuvPhXNjAu8Sup0pQkoQ9TqpCZO4m2w2VuSbpJRGHBAWSlXzfwqvT
	u7QK6tI1TC8XeyxwJQAnCbV9ezzXURb8OG2uJu3LS3wfP8dTPLpQLuoGuRPuNMoompoA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqCbc-005qCa-Ay; Sun, 24 Aug 2025 17:26:04 +0200
Date: Sun, 24 Aug 2025 17:26:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <08d551df-555f-4cde-b73b-0f2593c84823@lunn.ch>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824005116.2434998-4-mmyangfl@gmail.com>

> +#define yt921x_port_is_internal(port) ((port) < 8)
> +#define yt921x_port_is_external(port) (8 <= (port) && (port) < 9)

> +#define yt921x_info_port_is_internal(info, port) \
> +	((info)->internal_mask & BIT(port))
> +#define yt921x_info_port_is_external(info, port) \
> +	((info)->external_mask & BIT(port))

Do we really need two sets of macros?

And is there a third state? Can a port be not internal and not
external?

Maybe the code can just use !yt921x_info_port_is_internal(info, port)

	Andrew

