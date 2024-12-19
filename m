Return-Path: <netdev+bounces-153453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B263F9F80D4
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D86160720
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D683E171E7C;
	Thu, 19 Dec 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U+UNFwIs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C986337;
	Thu, 19 Dec 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627531; cv=none; b=mDzbK5CtmEMdY+7/GAQN1l/4z3RI6jBMQuPQQ8Fw2ivDq6A6YPiTw1ejvMv8eph75P6NSk1z10jrnrzVBlcTO9nBhXTGB/lCI5XkN0DaxkuuMfGxJydLmNeIkApAq9Bqn4k1xC0w9TNUyzwzDzRhZchFO/ViStlupZiVL53lBFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627531; c=relaxed/simple;
	bh=I0HukuiRg1mqSKD/Jqbk9CA8tBR0m6R6vYv1BDJgI90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tti65rz/nMA3rtl+reOyyN1IvnkO2oHDPBIk2CP5j6UvdNYp+0BTsRSS7nBkIBEmJ9J3L+xZ74DvMaowOObOOo2liFE3rqBInKyoZaGwJQgLBaMjFgJJlbHFAh+44kFZ7A1xpxw26Q0fdGhWSi26rcBk3pLVrAKhADMh/PLaYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U+UNFwIs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qannK50ZIOBaxhDQUEnZN+yd6vpiBPWPiw+Ir8fRlco=; b=U+UNFwIsto2nQpcFROREestQqn
	WrNOkPCnoToEqitBGEzv+As9mqh6cJOoMBU4yXDXo5aBufv5QYu2kmLME1p9QjtEAMuP5qzj0D3zS
	du4Q2kwu475vvmUSWbClXMH3qwD89Te8/dbAHZfpbRYEA6zIm4xZGERNcGK2JMtDZaI4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOJrG-001gkz-LX; Thu, 19 Dec 2024 17:58:42 +0100
Date: Thu, 19 Dec 2024 17:58:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: microchip: Fix LAN937X set_ageing_time
 function
Message-ID: <52b5d869-d15d-465a-878d-4693b2742eff@lunn.ch>
References: <20241218020224.70590-1-Tristram.Ha@microchip.com>
 <20241218020224.70590-3-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218020224.70590-3-Tristram.Ha@microchip.com>

On Tue, Dec 17, 2024 at 06:02:24PM -0800, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The aging count is not a simple 20-bit value but comprises a 3-bit
> multiplier and a 20-bit second time.  The code tries to use the
> original multiplier which is 4 as the second count is still 300 seconds
> by default.
> 
> As the 20-bit number is now too large for practical use there is an option
> to interpret it as microseconds instead of seconds.
> 
> Fixes: 2c119d9982b1 ("net: dsa: microchip: add the support for set_ageing_time")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

