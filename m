Return-Path: <netdev+bounces-120187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907FF958835
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D0AB21548
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CE5190485;
	Tue, 20 Aug 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n/PzeqF6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC919005B;
	Tue, 20 Aug 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161611; cv=none; b=eM3H3T7yFI7GyEdh61g7Sg32tzOY1T5JPyQg3IjRTY1vROsuZIcgSAjV0EVp+6ZYR033LGhd1Xj5tR1OgKgTVUtWRxnZwzNf/U+bw2tEgD0ohnU6ZtLby3o46/o0Cr2V8CAxO6zcOFLQGpfFr7Hddbkx2RRakdqu1CVmAvIY8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161611; c=relaxed/simple;
	bh=5jYPsT7x1ef1+TADp6WLMW0i/PkRLxGruyn0Mo2D8q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd32asef3fplaPM9rzVYmtfePh9IvubvyCzPiv2vW8Rl3mvqM60tCZB6EBkOK27knRgjyU25+FtuCnj9DQj6d20mH3Aeei2ZYHf+0m01jLIEijecjBTjB0fCEnTlQLFxn1eB0ST0XQSRB3y2C08Yac/A+xOnbR26Q2ag9eXSUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n/PzeqF6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=39Td1pTzBPNeFSCBptUSCrPDBOdiaeYh6NlrePsrACI=; b=n/PzeqF6USosaggPBuVvXFB3AT
	fVolpgJuqfS9TdAupWyIjfRNhXbO0pbgonFWsx8WhjlS7BiPYLdL4gTt2NEydmulAlDfwiG/74WFi
	npIHUTtjrJoD012RNE4MTtmYftu3OMLhHZHyJI4dJpn5hxb9yFqkFkF3dGzgOzOmAzBI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgPC4-005E7t-FX; Tue, 20 Aug 2024 15:46:40 +0200
Date: Tue, 20 Aug 2024 15:46:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, robimarko@gmail.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: b53: Use dev_err_probe()
Message-ID: <8180513f-422e-4424-b4b4-0d70acdb1988@lunn.ch>
References: <20240820004436.224603-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820004436.224603-1-florian.fainelli@broadcom.com>

On Mon, Aug 19, 2024 at 05:44:35PM -0700, Florian Fainelli wrote:
> Rather than print an error even when we get -EPROBE_DEFER, use
> dev_err_probe() to filter out those messages.
> 
> Link: https://github.com/openwrt/openwrt/pull/11680
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

