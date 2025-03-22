Return-Path: <netdev+bounces-176930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD9A6CB51
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 16:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD303188E3B5
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B521230BEE;
	Sat, 22 Mar 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ULBY3rAh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB970809;
	Sat, 22 Mar 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658695; cv=none; b=J+cdKJM5/lJXw11MQmQAXHDYrXSP4wFCkA6JtM3ZnkBj4yZ/sWz6jjZNqLO71AMRwGrb0bzTaaSNuuoKJLldRuLFWQhoMO2vu5CmJAEhlIA1cROSsp7YDKYj+y9/LoZ5qGFtk5aljFKWM7U/QajvmjjqYbMJ6AB9nlcISiG+66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658695; c=relaxed/simple;
	bh=QvJ31SgxPdmOyOR2qcyE90IMOfgrSe5URx9P59r13fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxkC2Q2MAOhi60wA1DfbBZUIO+Y3mST5zAv820eoFZclhJDnnoWEo5QJxLy67/OZWStsCsDICqFxN9KCjk5cA9DTrTv+k+d44XhKkyidM7OMZfTYnv/bezkbnlLxT5VIm8M8Yo0LuVNbOMlHmtWCndyXnRsoDElI9oq6qt1oJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ULBY3rAh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wxXF6wUbpZFaG37wZlSQmHKtiEfFDKrEdOBgK694HVI=; b=ULBY3rAhim+3rXEPBSuf6bg0On
	4EJsaKz69N4a8dlIEb7A7hlAqTGkeDp1a59U1zD3//h69Y/GwcyQL6sh/Y/NhCK+bRU0Evja5CrgU
	dTSc4UDFbQGkd/XK7WbTSe6jWSvLXfB8Rj3Kx94+0Upxr55+mkqc+2QHYhxMay3xXWX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tw18A-006jeg-V0; Sat, 22 Mar 2025 16:51:26 +0100
Date: Sat, 22 Mar 2025 16:51:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Klein <michael@fossekall.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 2/3] net: phy: realtek: use __set_bit() in
 rtl8211f_led_hw_control_get()
Message-ID: <1ddd2dc2-e309-42bf-9cb8-6aeb00e4fe6f@lunn.ch>
References: <20250317200532.93620-1-michael@fossekall.de>
 <20250317200532.93620-3-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317200532.93620-3-michael@fossekall.de>

On Mon, Mar 17, 2025 at 09:05:31PM +0100, Michael Klein wrote:
> rtl8211f_led_hw_control_get() does not need atomic bit operations,
> replace set_bit() by __set_bit().
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

