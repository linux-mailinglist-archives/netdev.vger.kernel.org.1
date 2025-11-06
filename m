Return-Path: <netdev+bounces-236384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F1C3B8F8
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F4B6270B9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C0312807;
	Thu,  6 Nov 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UKvV/2Rt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD4311C19
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437132; cv=none; b=bkEyDXaVLfNJe+WOhthP7pwKFz7hro9YLCGcJwKLj87orLoWaOoabJBSUf7B4VChlRXanlpiHMwgAqfSwqgJqzMJtWH097CvB1dMEq33Chjo5h9ToQLpi9WiJet4ul42RvMJ412b4JJ0RiU0LUqVon6Q5QLaVY1yteYuP3aUKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437132; c=relaxed/simple;
	bh=RNs6WRgXmOYgTfFparkkZdZDf77sJuMnnksEs4E08p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ+je7F2nf495DVkLAlBEOaYgIsBGsUPpFTL/fgpIFReW8oBiHi0uc6V0MYDRtw/hByBR99sBhLurfYg4R/ASI7SWcUY7pTJjcDLAXUGaqtSe9MlJUN6ww31ciXho+EU7m9No9xf7pAZashtNCkwfW1S/RIjpz6MTUwWMI4Eo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UKvV/2Rt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QQ7qcZ559SKigbdrRVimQ1Ri3kZCBtmRzZjm9CuCz+8=; b=UKvV/2Rtx0NYs3FGxzVhiAwuGq
	gn9J7ZYTlsqDdMQVpdGqUKgCkGzCgmR9PNUoOGPqTbxImvfz9QdQWNz2n6Pw31DvIqs9b+MnxAkLf
	NEzv7JSMQyxzV2PuIRzdBJOFq2cquHl767zWtZNyIZ1jSJbwCAnwGVz7JNfwVw9RUmW4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vH0PG-00D7aO-N5; Thu, 06 Nov 2025 14:52:06 +0100
Date: Thu, 6 Nov 2025 14:52:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH net-next 2/3] net: phy: realtek: eliminate has_phycr2
 variable
Message-ID: <ea476549-14e1-4208-8b5c-6659eafda988@lunn.ch>
References: <20251106111003.37023-1-vladimir.oltean@nxp.com>
 <20251106111003.37023-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106111003.37023-3-vladimir.oltean@nxp.com>

On Thu, Nov 06, 2025 at 01:10:02PM +0200, Vladimir Oltean wrote:
> This variable is assigned in rtl821x_probe() and used in
> rtl8211f_config_init(), which is more complex than it needs to be.
> Simply testing the same condition from rtl821x_probe() in
> rtl8211f_config_init() yields the same result (the PHY driver ID is a
> runtime invariant), but with one temporary variable less.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

