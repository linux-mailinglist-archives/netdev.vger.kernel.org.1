Return-Path: <netdev+bounces-218507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C6B3CEF9
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304E07C4143
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 19:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6732DCF7C;
	Sat, 30 Aug 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vmPOc3nP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC322A4F8;
	Sat, 30 Aug 2025 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756581863; cv=none; b=rWNPR7TY60hdkzlRM2zLuxv97aqFGZmz2QsZNl4++8gLWVYyMsQ9LzcdoLq/8hGfSwcI4fDKRwd9LjN9/5D1TAOVCKhgiIZF4Sf2C4ma0mQAIs2ow7gjfaI1gwShoJ0XJ89Kh0yRDWMy5p0784SqR+WO0Q5S2Rdc6ARaaWdz344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756581863; c=relaxed/simple;
	bh=KhCrgPypb7PZD7jnU+GsG7IH2u0c8W5XLWTpzPcJeh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMmBL1AEcYEAkfyJAZV61Os1nPEKvmkAuxAFMKwLhN7Zft4S21TgfENFApy8kfhW0fBQMx2r/YJHSg/bFmIr2lp+Qb9M6xv3gdoluHFvfwr6D0To5ZAM3nPJUBGPgaKBa4d33j6wDe9jyxY4gYoGT9lrqTczy8u0RQE5z+QNT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vmPOc3nP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+jog82d+9IMz6V10XlVgAfkryK/4rWv5Ffo0C6q9pYU=; b=vmPOc3nPB6vZolLrsJTZjeys3g
	zc+wYUV+mUPAa854+zJf0/MgBEcgCuxI7tWKpBDNTAwRserbOzbVaxEfQV1QhQU1CmYgKK7FF+i4n
	g716VgJui3rvYMXdR6lPvAWNKoJWCsA3tpkM+S/JZ4m/7XM+Wi9ffB8RGd70brobQYVw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1usRBD-006bEM-L0; Sat, 30 Aug 2025 21:24:03 +0200
Date: Sat, 30 Aug 2025 21:24:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Helmut Buchsbaum <helmut.buchsbaum@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: ks8995: Fix some error handling path in
 ks8995_probe()
Message-ID: <9c7b0cc7-2bac-474b-a0ee-d24c7954d815@lunn.ch>
References: <95be5a0c504611263952d850124f053fd6204e94.1756573982.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95be5a0c504611263952d850124f053fd6204e94.1756573982.git.christophe.jaillet@wanadoo.fr>

On Sat, Aug 30, 2025 at 07:13:59PM +0200, Christophe JAILLET wrote:
> If an error occurs after calling gpiod_set_value_cansleep(..., 0), it must
> be undone by a corresponding gpiod_set_value_cansleep(..., 1) call as
> already done in the remove function.
> 
> In order to easily do the needed clean-up in the probe, add a new
> devm_add_action_or_reset() call and simplify the remove function
> accordingly.
> 
> Fixes: cd6f288cbaab ("net: phy: spi_ks8995: add support for resetting switch using GPIO")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

