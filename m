Return-Path: <netdev+bounces-139249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE49B12B1
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76D01C218CA
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 22:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41391CEE98;
	Fri, 25 Oct 2024 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rTOEl0bu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46AB217F22;
	Fri, 25 Oct 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895635; cv=none; b=lr4ol2yz/8CsaPfWYDGW20kBisT7+XbuxezlEsT0WsX1Xzwxv5TXkM6yq8cNRrxnc1+Sv5shMCV2OdF/QRLP7Ecm5MiPZbTq5hLEIfTnlgS9LHcgRIKoWVnehkpvGL7YEmbAQjVaI1lkGliZ7l7U/yvpUsOrgReHj6JayxEEMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895635; c=relaxed/simple;
	bh=f7uIURpi6fr6JJqRhNgdzSvSSXJTksS4llqut5V1Bh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLbN0rLw4pCirMA+SrC6Va8Oda4Cc/zi/1sLBG9y4wRft591LPX8p/E/VpgP/bDp4eG3E84hjH+HdhKwdD73j1U0cGj1NGgbar+wiieOrC4MAdrC8OgSlba6GPFqbHaELgDpH6qdjhsHyIu5ozbzy7yyd/fz+r4qwh5qLRxpitI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rTOEl0bu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=es4FZVxk6DWpqeaDD9J/7bGw6XHqkx/jUx+KUjiBHrQ=; b=rTOEl0buhHQebUB87coWe+km8O
	c5YyfeZBwt7mLLX+jphdeHhlFpZkhbZR6f2mWu2x5OXN8VmMIT3dGmtlmlJVIFhqP6iXZHRNKwTJM
	GZVCvKVVZ4oKbXn236ihrIewF5X4Yv5YWddLLdrzS2rY7RSaqL5hN4dXA559CrFb9eTY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t4SsI-00BIBe-H0; Sat, 26 Oct 2024 00:33:42 +0200
Date: Sat, 26 Oct 2024 00:33:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v4 2/7] rust: time: Introduce Delta type
Message-ID: <0b6b8e54-8364-4d97-be1d-c53416564f8e@lunn.ch>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
 <20241025033118.44452-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025033118.44452-3-fujita.tomonori@gmail.com>

> +    /// Return the number of nanoseconds in the `Delta`.
> +    #[inline]
> +    pub fn as_nanos(self) -> i64 {
> +        self.nanos
> +    }
> +
> +    /// Return the smallest number of microseconds greater than or equal
> +    /// to the value in the `Delta`.
> +    #[inline]
> +    pub fn as_micros_ceil(self) -> i64 {
> +        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
> +    }

Thanks for dropping all the unsued as_foo helpers, and adding just the
one needed.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

