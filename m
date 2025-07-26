Return-Path: <netdev+bounces-210293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B475CB12B10
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 17:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBEA179B7A
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE97226CE5;
	Sat, 26 Jul 2025 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jk3eJ2UO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237721ABB7;
	Sat, 26 Jul 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753542449; cv=none; b=SGFUzwcAQd4hLTkj2qY2Roo0iNnGA0lr2cPA681bE0HY9pGlEsNPYle60y9hsQ8Kg7pJBuElujS6VW2yve3vQ1ZCPYsHdNTtTFfAwIo9p7qrAXvtGMSnelphP5jo+uEk258R1IpOXUGJo4SFYsc2LcEvk6b0Ob1cdV22HbHYs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753542449; c=relaxed/simple;
	bh=OQvGWPkddB4yMS2MsglRAhmTk90wiurJrqAtALbkAD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB49V9HwFlpegboAjF60S9xAiMTB6BmT2K8ULDZ1jtIlY9XMHjIdvTLGsUlDHTQqRTMctxSttXmhhqrwZv1gdKhP27Yf3dwS4Gw1GXEJ5O/b840U5r/OXZL+wVrTqd4Pu6cXxWNqnyFWv9EuFT+o0swJDj9rPEtKte2SeucnuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jk3eJ2UO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fpg0L8x954O05unhtjdbixC/fvlQh13Hj4+Uk3NzWmM=; b=jk3eJ2UO8l9pAfgHcqhtQGoqbB
	goCdqKF4/epBEsJRPksfzpxPEflv8en6+XL+ygoT2lFNqTtK7nZ0/TAWWjZ4nzr6bS2ixIbPZ7yzD
	opHPzpnOrlQbPbdenrUj77hkk3zfDlEXL4l2NtqIR3qoQnS8wNJKqs5os1+jg9grltGY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ufgUJ-002wvL-V8; Sat, 26 Jul 2025 17:07:03 +0200
Date: Sat, 26 Jul 2025 17:07:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, viro@zeniv.linux.org.uk,
	quentin.schulz@bootlin.com, atenart@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] phy: mscc: Fix parsing of unicast frames
Message-ID: <19313759-91e8-49c8-bff7-089baea8c97b@lunn.ch>
References: <20250726140307.3039694-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726140307.3039694-1-horatiu.vultur@microchip.com>

On Sat, Jul 26, 2025 at 04:03:07PM +0200, Horatiu Vultur wrote:
> According to the 1588 standard, it is possible to use both unicast and
> multicast frames to send the PTP information. It was noticed that if the
> frames were unicast they were not processed by the analyzer meaning that
> they were not timestamped. Therefore fix this to match also these
> unicast frames.
> 
> Fixes: ab2bf9339357 ("net: phy: mscc: 1588 block initialization")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

