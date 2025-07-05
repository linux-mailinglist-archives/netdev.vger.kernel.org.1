Return-Path: <netdev+bounces-204311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB09AFA0BF
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C607ABCF8
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFC11F5828;
	Sat,  5 Jul 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dMcCa3Mu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422291EBFFF;
	Sat,  5 Jul 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751730690; cv=none; b=hSD8LleURKaEii/yLahirM5MTBtGOGYUjwgu0mOnHq1KFHASd3r+dTj4RaykH0+EUIWWPw7F9B74lcTUAcZ6N/FGohX74alByQ8Ej2nHrpxO6UbSykhB3oMKl9IE5sHmZUBzysNzwrSzopD7O7s2TURoUlf1KzFzSw2lxiDuucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751730690; c=relaxed/simple;
	bh=/jPjScsDqmeGNrPa/kPk5CIs0a4qEj0NlqE9jP5SEQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjHaKGoRskeNSezr7aZnW2fAdRJp52MHNbkC1I236XoKnfiPLaLSJyzUV681MdFyJAWbhfHOtVj8C/EI0pktNhSyRTJIfDElcl5EGib+lh6HTU66fqUz2xt0qLKDi4+GrP7QTBAJ2GUWc9eSD5aQJ8qqU2uBcQdb9gLoyiMIsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dMcCa3Mu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HxRaCG1X7LiYWlk995M+Piqie6DvkdIvQz3SJFMxuqY=; b=dMcCa3MurUM2DjZP9e8YTUhqVk
	x8x/Ywpva/nD7YwqLLH8grBJ4MrZl9FgceaDHKGns27SndyGlzN96TJgg8+8n+T6DMfND8cyWmu2F
	SVxAb7Wh7RuQDsx+6Oo4qy/RPoP0St+7CNhDsfnpMHbGK6j6dsE3HDOG3yD1UsOE/FCQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uY5AV-000QZ4-Is; Sat, 05 Jul 2025 17:51:11 +0200
Date: Sat, 5 Jul 2025 17:51:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: add support for dwmac 5.20
Message-ID: <b4091f34-8901-4a30-937a-a9aac35310b7@lunn.ch>
References: <20250705090931.14358-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705090931.14358-1-jszhang@kernel.org>

On Sat, Jul 05, 2025 at 05:09:30PM +0800, Jisheng Zhang wrote:
> The dwmac 5.20 IP can be found on some synaptics SoCs. Add a
> compatibility flag for it.

Is a compatible flag enough to make it actually work?

	Andrew

