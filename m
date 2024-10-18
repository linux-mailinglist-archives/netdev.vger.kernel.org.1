Return-Path: <netdev+bounces-137036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537E9A4105
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C841C222E3
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB013C809;
	Fri, 18 Oct 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BR3t0ppJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56444C76;
	Fri, 18 Oct 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261339; cv=none; b=brQLNaTF1WH49uO2LOtWXOtoOj+z7WjvzVS36faFDX2P6p3PysRktr4aLY63s6sSzGJpIvA1JBZMvqvPMVabjM9wvsDjX4jiXI/ZPfbmXOOCPKa4lBw9pRboQgVvDYKHBmNgLQbiukgh1hYBR+xfge1QNhAavVS8uGcbXyiQJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261339; c=relaxed/simple;
	bh=LdpZqeqmFWWw0Di7cFSEyNbx1YrDBM318K2CVuq/byM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+cHUdccgXGzgQvzlOgQ4rnR4oGZ80vaOTP431+K8X/GuA3tAs0F0FA0M7iknsprJGWDkQNzc/1BaNYUlTtbpARDUZU9+76Yr/FYj+S0wiGBmWYr7xVVcadKJThdXC3Ui4i/0R7Wi2yX1SDoawip/eRhMw2ghAj5af1UE9W7JIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BR3t0ppJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FgvxWMOqST3bKwdRS0r3lXXGtROv7pM0sqsBGR+iD+w=; b=BR3t0ppJSwe1ThjZelznehOVNa
	aWv5WGTv9HprKKuDkVT9Kz7HHmdIxRgJYkTQKfDZ/R28mdqgYUQU28ayYX0XU6lWDt3ugppt8TLtu
	4NLA9bSgbQ5V6hBxXKOOX12UnvLFV/+lawYb7Tyy5IbOGVV+1tvxhx1q5RkHQJw6Qitg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1nra-00AXjl-10; Fri, 18 Oct 2024 16:21:58 +0200
Date: Fri, 18 Oct 2024 16:21:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/8] rust: Add read_poll_timeout functions
Message-ID: <7701b5fc-1e6b-42db-8fc4-aa4b9cdddb70@lunn.ch>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-8-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016035214.2229-8-fujita.tomonori@gmail.com>

> +            // SAFETY: FFI call.
> +            unsafe {
> +                $crate::bindings::__might_sleep(
> +                    ::core::file!().as_ptr() as *const i8,
> +                    ::core::line!() as i32,
> +                )

Can this be pulled out into an easy to share macro? I expect to see
this to be scattered in a number of files, so making it easy to use
would be good.

	Andrew

