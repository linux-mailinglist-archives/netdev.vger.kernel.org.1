Return-Path: <netdev+bounces-224792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B437B8A3C8
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9A817AE0F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956993168ED;
	Fri, 19 Sep 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N+Q4DP9K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A0268690;
	Fri, 19 Sep 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295031; cv=none; b=bPeQWtpgD89shT1l6Y5IPhe7FIH9He8ioy5c6DUHdXY384aQwhOIniXHw6/Hbq68D3DvHYFpA9yilWIff7YgpPOxzL9kb0JTMDJIs+CWKOzeSvpmkaQz+6d2H9jq9pzfsHdxMNnFOXNNiZ/jqb1lxokmLNw5iQhvm3Bll+uEMqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295031; c=relaxed/simple;
	bh=V70liMTgOdsh8fqty3trsRiujCQNSlKtuaCgmoPdBPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh/2y0pZn79M1cmTonrGQXSlJf+QvfJymuO1jJXsNmvsuAjnqtxz7cYuaP5X2Ow7TtOp+pFd41s9RHRbG8/rreX0konpwY5MiwJqOQWDfQFNB2SS8XoF8/hmk7xSB7uabSDff8xkdRkGb+kO0B2RZbrnuxE4ttP3+RmmJwZk5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N+Q4DP9K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FdEf0qKVbU2EtYYZhow9HnPU9m8Q/ulmCXNvCbPV8TI=; b=N+Q4DP9KKnlBLdN3il02HnpReX
	NJhzqDPKpAL1+uTMM1A8r1m4bzmmz3TYqv+JECYGX50qWCUIK0eRaPr7dqjdDCFk1U0AbVKyo9gLP
	h/62mQV4mwW7nK2bVEGAd97SqeHuJKlzpxms/iwX57c0W68lOIqcSxUxuz0HCyLVobGQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzcqP-008wm9-Np; Fri, 19 Sep 2025 17:16:17 +0200
Date: Fri, 19 Sep 2025 17:16:17 +0200
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
Message-ID: <43490b38-5d8c-4dfc-a37a-8f34f99e2d3c@lunn.ch>
References: <20250919112007.940061-2-thorsten.blum@linux.dev>
 <d1fe6fa4-da50-4899-8e2c-0721851c4e0d@lunn.ch>
 <A17B492B-0EAD-4CCE-9889-6D559401D3D3@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A17B492B-0EAD-4CCE-9889-6D559401D3D3@linux.dev>

> There's obviously nothing wrong with local variables. This patch is not
> about performance improvements, but writing consistent and idiomatic
> Rust code.
> 
> Currently, dev.set_duplex() uses a local variable and is called once,
> whereas dev.set_speed() doesn't use a local variable and is called
> twice.

I would suggest the opposite change if you want to make the code
consistent:

	let speed = if ret & BMCR_SPEED100 != 0 {
		uapi::SPEED_100
	} else {
		uapi::SPEED_10
	}
	dev.set_speed(speed)

	Andrew

