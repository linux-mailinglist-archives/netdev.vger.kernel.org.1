Return-Path: <netdev+bounces-122029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB495F9DC
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41865B22130
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A61991AD;
	Mon, 26 Aug 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lJEifTbQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F16811E2;
	Mon, 26 Aug 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701366; cv=none; b=pfdkTlgB1z8CHMGz2W46tjEWdZ9tZYMAUfbqvE7d/6cPDFcQfe2PaWIveCNrrkDu55KXWX3h8iOczTxV8+RZ6X67dgskuvgY8/dxhBJ9vaTPmZ6lcA3kJ03+30EAN+wDhgz0GAphHDloKCmhOaZay1yN+6vKmcmrIfJAIUvrrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701366; c=relaxed/simple;
	bh=WQWPUbLddyPe0qsg3KbXP8PH4EXTPOjQrbyOXfFL5R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvPm9k0w3mciegNtavGzMPQxnBNM8a5LNZuKm8MPG0CcGvyVS/qy5YjZoNLyu4R2ToO3ydu6aKT13z1ZZfxXms9DD5BUaKI7Sw8oczEGsrRTFJqJyZTdHGQQaT9aPzJuOehbf9Ug6yqadQQHMTeAHwGyBCAYl/D4qKir/S7g/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lJEifTbQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fo5uv/jFeo7McSlP1paAD+jiMJiqhe1QrEoGer2O2yc=; b=lJEifTbQ3lhv1pDlR+QnEoZ3bh
	jo9xlWFInb8CS7D+3XUzx8QBjQWl7RIbwU/kLG0A1o8CFHk0y6s7K6HAtRsmEWmaoe3MkTisxawhb
	io5tIlpPjGgx06hqGAz+NuKhyLXegJL3WsSWd+J20Y0q8LhEej+0kgxCWiYGXjLx4y4E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sifbi-005k7C-Ne; Mon, 26 Aug 2024 21:42:30 +0200
Date: Mon, 26 Aug 2024 21:42:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: vitesse: implement MDI-X
 configuration in vsc73xx
Message-ID: <1f025063-5c21-457d-8596-633c7adfd294@lunn.ch>
References: <20240826093710.511837-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826093710.511837-1-paweldembicki@gmail.com>

On Mon, Aug 26, 2024 at 11:37:10AM +0200, Pawel Dembicki wrote:
> This commit introduces MDI-X configuration support in vsc73xx phys.
> 
> Vsc73xx supports only auto mode or forced MDI.
> 
> Vsc73xx have auto MDI-X disabled by default in forced speed mode.
> This commit enables it.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

