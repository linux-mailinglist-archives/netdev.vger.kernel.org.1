Return-Path: <netdev+bounces-153457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D12F9F81AE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8251722EF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1612919CD1E;
	Thu, 19 Dec 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hwImnKBt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CBA16CD1D;
	Thu, 19 Dec 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628732; cv=none; b=Vvx0CnoOeejI8UDgH3xdBKPI+0akg8b7FZKbXaKvdXAA2AsKwdY7h68I7g1J0S68V/YLX98+tm3l6ZoNt9s6eCewh3MA4csEMVwz50k3hCogMYw4A5O4id7ro775DKZrc2YLeBx763/07N4QPfoYNMBjzxfhZE5LNEvvnikuZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628732; c=relaxed/simple;
	bh=+CJD9rqKmY1LYwzuly8F3TbOl/Tbkiv5716yA0T+biA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUYKyifNgyx3gUvm82Pjdk7+N+jljzqU0yFxuUJUfJQ0EKuKu2Rl2Kkq9DRMJqmZQQHYEsRgzLHPymvkdiJTdJ9flH/iJRJb4+Q1AlrcYuJ4DmtAidYRpiVhy04m4l3KIiZyJaR8o5rsb8EQAQTv/ZVlomkmVTo9FZVDZhxHr6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hwImnKBt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b8bzFozVIiRjivIdEqpSWoYNYqayq64rz5POIYHbbcw=; b=hwImnKBtXWed377wihmw/M6S4Z
	ti2Z1SAEj0FUyqDwaMSuTIUk9gy7ITloryHhVawWaE02gKoHyxxZIYls6ADE2dcrPHtNFx653/cRi
	kzPmCV/KDMtKr9GokeSCqcMbPGRdLlFwsC3n+OQwiNmdzqrQTLVb0NFzOjKMgTMg2TnI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOKAc-001hCk-VL; Thu, 19 Dec 2024 18:18:42 +0100
Date: Thu, 19 Dec 2024 18:18:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: microchip: Add suspend/resume support
 to KSZ DSA driver
Message-ID: <64300c21-59af-4971-a82f-1dde3edff755@lunn.ch>
References: <20241218020311.70628-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218020311.70628-1-Tristram.Ha@microchip.com>

On Tue, Dec 17, 2024 at 06:03:11PM -0800, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The KSZ DSA driver starts a timer to read MIB counters periodically to
> avoid count overrun.  During system suspend this will give an error for
> not able to write to register as the SPI system returns an error when
> it is in suspend state.  This implementation stops the timer when the
> system goes into suspend and restarts it when resumed.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

