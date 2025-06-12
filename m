Return-Path: <netdev+bounces-197076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEDEAD773C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B48169A77
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D268824A06E;
	Thu, 12 Jun 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jzPOPJI6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E30298CA6
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743393; cv=none; b=BoKH2EWxP9OHUc8j+1CiURsOVwbZENtzOi5jXFWy4/ReOIifBrWTwfN9kI1mTpp3QTr52uybeI1/fjgSzSs/tcvLZHjmu4yIat/ll6BB6S5B8ODCjafePAHn85Yk8vjwoJwSlcXPEuyDPbbUCuAUECBYTK33rnCJqDiuzzfV5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743393; c=relaxed/simple;
	bh=W08OGzDFEn031n7rXDk6AaOdxKK8iHLeLrOjSGJ40XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk3FaqAbP8cOS+wWreF1+4zVJQcaZOxI7eTNKBS9/XKl565roKu/w1Na9DBK92nGzQqsPlCv5WvQbfcIH+qlkikxarwhB8vDQkScZoivVLqqLR+q7pjlntc45POO1PNoTS/QWgT0oMVjZpMIPQ88auE5lWGbVUazFh/HzF7TvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jzPOPJI6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L+yLe+ZMSf3yk77UvKkyRGyzVGUmF0OKQ+1btIxnhOE=; b=jzPOPJI6MXqNn8Yg9oLmLM9hgl
	yzAH1dQkji+RkHEuI4xGJBue/st4deUUhpkAYl65GhNEb1Bxt6HMLVpULKSOLKo0t7WfSzZTo8JmR
	809l2akNLqVgMLuNyav5dZcktHoLn2TSjIyw9eX2ufb4IyCmDUnyvZ8PO6o9jZGaEfrU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPkBT-00FZCi-NN; Thu, 12 Jun 2025 17:49:43 +0200
Date: Thu, 12 Jun 2025 17:49:43 +0200
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
Subject: Re: [PATCH net-next 5/9] net: stmmac: rk: combine clk_mac_speed rate
 setting functions
Message-ID: <65b9f847-7b94-406d-acc8-45e692beb507@lunn.ch>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
 <E1uPk34-004CFZ-3y@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPk34-004CFZ-3y@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:41:02PM +0100, Russell King (Oracle) wrote:
> rk3568_set_gmac_speed() and rv1126_set_clk_mac_speed() are now
> identical. Combine these so we have a single copy of this code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

