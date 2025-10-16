Return-Path: <netdev+bounces-230210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5386BE5596
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851C73AEF73
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB44469D;
	Thu, 16 Oct 2025 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q0Q4e/vJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D51C28E
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645753; cv=none; b=apida+Mvi5DZJHscqRe+SvRZi65+/U6g8pOaK2qQKj8vUEeQIF5+fqVmdn8QgqpDrVUv5X3A6oVGo2GPwqyXaCytkm+Cksku+HkkCEoQ+YkVmpjVPFlFeUw+sbmx8pZuA4o8ZYTeEv1F2s0Fkq40vF20xQaeiE1TN1fzLFAZmtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645753; c=relaxed/simple;
	bh=VNvuWYsrj1f9G3muMuqKw/bXP10I/1G8smer438sHo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnxfHZSjGz7/sPJO/Gjw/Xn+h3njVQEL8BSRfVTUq9epf3VBe3+urNUagBGuiNdHZE/SzHwKZG4qRwV2HhgbK5w7QRkAeXeRQAWa60I0IxzXLOsP7crGXhCG1zw+0Wf/CX27DGl5tyuCKxc5imLcP7/Q033UhyEjv57lxP8U9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q0Q4e/vJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6CrXeVHCCjWAnUHKzdRq5G94t14tfPK4no6FrPxZGYw=; b=q0Q4e/vJgMozlhWcnumOuOJYFJ
	GvKGIg+N7XvWRNfzA94l0+H16ee2tKF7shqGNLB1lVaHSM15FcjZ4Bc2uzZljHBUYLyAHz/4IKgiK
	WgzP0TnQGBfX8/JMQ2pLgN9M67EX2Nv3VLIjkZn5hiBRE3E+6J+/Z9n0mdUtdGeY71fI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9UNy-00BCfC-FC; Thu, 16 Oct 2025 22:15:42 +0200
Date: Thu, 16 Oct 2025 22:15:42 +0200
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
Subject: Re: [PATCH net-next 2/5] net: stmmac: place .mac_finish() method
 more appropriately
Message-ID: <43d3c43c-ad4c-4a4e-96fa-d6cb026bf63f@lunn.ch>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
 <E1v945O-0000000AmeP-1k0t@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1v945O-0000000AmeP-1k0t@rmk-PC.armlinux.org.uk>

On Wed, Oct 15, 2025 at 05:10:46PM +0100, Russell King (Oracle) wrote:
> Place the .mac_finish() initialiser and implementation after the
> .mac_config() initialiser and method which reflects the order that
> they appear in struct phylink_mac_ops, and the order in which they
> are called. This keeps logically similar code together.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

