Return-Path: <netdev+bounces-224773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6DDB898DA
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C8B1CC17DF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E5422541B;
	Fri, 19 Sep 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SA752FVk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA0135942;
	Fri, 19 Sep 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286501; cv=none; b=j+Jrf+4BKxqNi3AlR1dXv940DkW819JhenfuVFolRwtidjqwxRVDiwzdMOuPXcffP6YcOzq6lrMt0o5546LmJE+/2gsOmUQ04WkWYGK0eJoZxa/bLFpJCYmL+ZEc4ypGjoFeJrPBHcUkH6otpsPsISXryaNvkhQYKXeFp/Dk81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286501; c=relaxed/simple;
	bh=P9O+uKYrNCQvlYmvG/GeHErGmRke6M9S1hqFkm9RfvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK5JQVMy80TUa3NhZXbm7L9ZIpqF/CCezDmzsJ2MmbfFDb2E0/f3LkN89cLdNs/tsTNA2l0u3RukMzcj1/cUNpp8M8jcZXcICbFgAcXNcZY81b0qrFUckNCBd8uCFdzmcDlk7HHO3xhzdwMue7cLv5PTws7merAOfWs2GCVpQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SA752FVk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pU5P+cOwzVnPymtF7+1qAqf6msbrSgTd7Jhc/pEZRXw=; b=SA752FVkQlNvUlfrzU5xfjt9Ct
	XQapcBVl9zZ2fg4hnd0J2+8TbVG7SZW2X/QirPZE8OPkFLlzx0lHcKV9mA42LczeYulmEDj/t+nXS
	gl76lOGOFVyx/LDkKTTTWCRWVCMGGJvF6iKUE40b3fm6bWbrAnxQHjn21py/g6L24HT0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzadM-008wAe-15; Fri, 19 Sep 2025 14:54:40 +0200
Date: Fri, 19 Sep 2025 14:54:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rust: net::phy inline if expressions to improve
 read_status
Message-ID: <d1fe6fa4-da50-4899-8e2c-0721851c4e0d@lunn.ch>
References: <20250919112007.940061-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919112007.940061-2-thorsten.blum@linux.dev>

On Fri, Sep 19, 2025 at 01:20:08PM +0200, Thorsten Blum wrote:
> Inline the if expressions for dev.set_speed() and dev.set_duplex() to
> improve read_status(). This ensures dev.set_speed() is called only once

What is the issue of calling it twice, or 42 times??

> and allows us to remove the local variable 'duplex'.

And what is wrong with local variables?

And did you disassemble the code? What is the compiler actually doing?
Does it actually have a stack variable, or is it just a register? Does
the optimiser end up with just a single call to set_speed()?

This is slow path code. It gets called at most once per
second. Performance does not matter. Which means readability has much
higher preference. And i find the older version much easier to read.

	Andrew

