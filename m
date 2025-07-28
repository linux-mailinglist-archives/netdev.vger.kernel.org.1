Return-Path: <netdev+bounces-210618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5AB140E0
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5DF188D998
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F78273D6E;
	Mon, 28 Jul 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yVXRcdIT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F5273D83
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722272; cv=none; b=WtHzn/aUb62zY2eScDOa8ntD+umLAnrHrh/BXzGt8NvmDlmYnGPgHz/Eqdm93xG8ug98tCcDfdfIk3y14f+J0zmr1M3PF3BkZmmzWCqI0znJ3MQMBvDU6SoP2DXQqzpfhoCNVnwJZ0J4YwzhT8O86XFVkOeHl/wid4gIuNSszUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722272; c=relaxed/simple;
	bh=VzH7Yxc2zuBHKbKbrzqBhFk5Ep3VpaoG1HDBr+4N7zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hg+U/NFCf60vOfARNQZqu1B6N2ew2f98hJQ37zgWuLmqA/t8DESa6HQCNBy0CDAck+Ca0RqyYbLGMcLVLsE8vbQ2yxv4jSJgfftaS8+hzz4+w8yPCGndSPb6RalOoGpqUK7we5BFQPYVFoLLZYnJ7yUUw5iOhJVH3tnkIaA0cpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yVXRcdIT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bs3HsOd6/CNv2Ke0PIq7Aeb0o1+Qgmz7fNk4tlxLXj0=; b=yVXRcdIT9NKoi509NOF+Um9T23
	oO73RHWZBJqO1E+5ggj1MPZY0/5np7Co55daFQjUvoZsuJjZqWUjxTfOxldv5sfC+lugL/DsDmjf2
	dy6i6OKN5WbwIUJr6ecawM+pUtHHfZOr9hjyfqBzvw2+iIPH4UXbNStwgia2DDjPEZos=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugRGw-0037Fp-96; Mon, 28 Jul 2025 19:04:22 +0200
Date: Mon, 28 Jul 2025 19:04:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 2/7] net: stmmac: remove write-only mac->pmt
Message-ID: <c3e313ed-8495-4d77-aac4-cdc05de25229@lunn.ch>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ2j-006KD3-B2@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ugQ2j-006KD3-B2@rmk-PC.armlinux.org.uk>

On Mon, Jul 28, 2025 at 04:45:37PM +0100, Russell King (Oracle) wrote:
> mac_device_info->pmt is only ever written, nothing reads it. Remove
> this struct member.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

