Return-Path: <netdev+bounces-250583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B509D37935
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20A0930285E7
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B93469FE;
	Fri, 16 Jan 2026 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wSkEwOV2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5630EF7A;
	Fri, 16 Jan 2026 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584018; cv=none; b=IYgOs6GsB6egZODbX/xQq4RPAgM6CxN1srC1Zctuuw6Y64eboBlf+INasyk1+uamWw5R0QObTlD9qciOTJVEfB+5DVRZinP8eKAcOJJAFzqr71E4c4Hqvfb2uMTeYo0rGO5r7sEaxHA0JiaN0HwHS045KdFnxM0hABIVaFDnDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584018; c=relaxed/simple;
	bh=xx5Gik6h+KYWlcMNhtzfIXHUciJQIHjHz/zx1h0hXZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPZgViMDtC8eaUraZn+yyYGavWvaCrKIMMgbv2593CIY4lWKeDzRuf/EEjPZ0sRQDHvzmBBRKmBihxqRzY2rwduS/MG4HbZZVBY4JVG9+9AVz8k6S+X46ANv+X+szbMY1FS6E88O0Ct3kidcZ8jqlHuk29w103Wq0c7KpaOnApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wSkEwOV2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Zu6BgHemIMW4qE7p9Q/SzrPE/sfOtlpXPxQ3/da+CiA=; b=wSkEwOV2yAX+o0EUYzKCIxJCQx
	cat+MY49qHJHLDfV68A5LrUO8qM8LZqRBNz2nle/l+Vk4pNvmRk9L1SnSLd3oV8KKEKtZO4fzm/MQ
	wEIiqtb0VzuD7MWcGH5FBjmMboELjNWZx7pPcTf9bQ5fvLidrdCh2ILv2fKELNcucUQw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgnUT-0036BQ-HS; Fri, 16 Jan 2026 18:20:05 +0100
Date: Fri, 16 Jan 2026 18:20:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: litex: use
 devm_register_netdev() to register netdev
Message-ID: <3e326797-b4c1-424f-8cf1-f0095e33e0bc@lunn.ch>
References: <20260116003150.183070-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116003150.183070-1-inochiama@gmail.com>

On Fri, Jan 16, 2026 at 08:31:50AM +0800, Inochi Amaoto wrote:
> Use devm_register_netdev to avoid unnecessary remove() callback in
> platform_driver structure.

> -	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
> +	netdev = devm_alloc_etherdev(dev, sizeof(*priv));
>  	if (!netdev)
>  		return -ENOMEM;

The commit message does not fit the actual change.

You probably want to split this into multiple patches. Ideally you
want lots of small patches with good commit messages which are
obviously correct.

    Andrew

---
pw-bot: cr

