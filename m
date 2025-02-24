Return-Path: <netdev+bounces-169182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93800A42D53
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FA83AB9D2
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B54E155CB3;
	Mon, 24 Feb 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hiJM3wSh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A9EEA9
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427559; cv=none; b=E8OjwIek3QLf0Usj6lmjnl5Vo20fHPpu/XqguSoR2PtV1Ghi/vlUbwMKSNlDWLSPln1wBrJstqylbW2P0bW5iCIcqC8p6juPwU+ewDrEmJ8wgqFi+kE9wg35VNXhOeonUudcmkS6RWWDlN4VsBavccN70mSkcFOcfaMDETc8OB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427559; c=relaxed/simple;
	bh=rRttOE5xHaovTtkAHf6I+4ajnDCoU/LBOQJ7+lK/GIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcAAuOj0F1irB9QCZlvV27xFWhoD9O0x8obRiQqNH6wQPs4n220HdFX7w79W3vGzZsOfTxoEyJ+SMcP3IvjgyQt9O9O6Ox4e3LBLmgVAoGJpQJlhU4WWgyo1GySKcAylMq4DcECKiA5Wm87NqgoBVsCUPXHZtJqDhNSgHVrnSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hiJM3wSh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8v+VH5qHJ9s8s5Z5uS138U4uFYC8T8PcRHjdrcA0cR4=; b=hiJM3wShZ1F6hQpNG6O5e6tdzx
	liLjE0PO4fhNah/NHBzsmkK7ZvMVvyR41x86x6eyBT9i11DssvhJd+4tln34zkg4VW1lR2zHeufsA
	pW8KXOqR+Nupxk+pxToKpdFFIXJZhweIaOIJeiQVPn8rblXCaY3DQXskY5QkIqJMCAkY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmei4-00HHMQ-Hw; Mon, 24 Feb 2025 21:05:48 +0100
Date: Mon, 24 Feb 2025 21:05:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <drew@pdp7.com>, Eric Dumazet <edumazet@google.com>,
	Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: stmmac: thead: use rgmii_clock() for
 RGMII clock rate
Message-ID: <09e0ee41-f061-4e24-a58d-477758812f74@lunn.ch>
References: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
 <E1tlTo8-004W3a-CO@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tlTo8-004W3a-CO@rmk-PC.armlinux.org.uk>

On Fri, Feb 21, 2025 at 02:15:12PM +0000, Russell King (Oracle) wrote:
> Switch to using rgmii_clock() to get the RGMII TXC rate, and calculate
> the divisor from the parent clock rate and the rate indicated by
> rgmii_clock().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

