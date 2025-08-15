Return-Path: <netdev+bounces-214215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEB1B288A8
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E430DAA27ED
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE72D0C6C;
	Fri, 15 Aug 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ULNHFy0M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DFF2D0C6B
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299561; cv=none; b=P+wKs8PufGX8w1dey4dm5+zrJWPDuSONMhjT98avZBCwoX3ujYqsc6NPihY84oN1t/mvQNzltzJ4P8X/9RbNSbJwEpjUeW5+aVJr6vbMU7Kz6hK/q7f1B2Fhe3YAVqvwFKnz0vFloClknZuaNC4fjLilCaqCq7eNxLLxuM+ffF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299561; c=relaxed/simple;
	bh=QSix3uDaR526bkEUVnh7i+OdtZ2v8j0JHddJBCNsEwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI3+HtUaQcnLwNaZNOhlxkp1Z6TmdMw+C0JcT5KmLg5kQOA49qAL+RzOsu140W8oQmah6GXg1u6eWDZ2dUjv38k7dJL6gPGTp1yL1lEHn955XC7vSdnN4kdIWJhbjOtmkrxC9sfEBg+2yiazT/pEf91BMq8PM5ztTFLtA1s6aCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ULNHFy0M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YTiDjOzIxaJjd1AysesrPKQZVoliERjUxcTwg3Tg+vI=; b=ULNHFy0MpqVZLiccvfPIq6tyZF
	w0C2tI8MXL0i66pS6OrzfhpXx/LRI3uKgGXFbE+t4aSdzpJ9taU01yuDSON3KQ4OJQxNxHoGzWyvJ
	gWjLUsqmw1CLi5NFG0txMOfn++omw/fJ3lqELeZIj5fiywV406DDvSWxHnsVsuDkd2EE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un3b4-004s0O-2g; Sat, 16 Aug 2025 01:12:30 +0200
Date: Sat, 16 Aug 2025 01:12:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: dsa: ks8995: Add basic switch set-up
Message-ID: <3282289c-2cc4-43ac-a187-ca8ab6011015@lunn.ch>
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
 <20250813-ks8995-to-dsa-v1-4-75c359ede3a5@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-ks8995-to-dsa-v1-4-75c359ede3a5@linaro.org>

> +static enum
> +dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds,
> +					 int port,
> +					 enum dsa_tag_protocol mp)
> +{
> +	/* This switch actually uses the 6 byte KS8995 protocol */
> +	return DSA_TAG_PROTO_NONE;

Is this protocol documented somewhere?

	Andrew

