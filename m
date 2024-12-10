Return-Path: <netdev+bounces-150477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC69EA625
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA178169E10
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA76019E838;
	Tue, 10 Dec 2024 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VhPu7gN1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8F433CE
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799821; cv=none; b=qTR2c1BMNnDon5TcmZS6eIItbGmrlz0Sr4Wsf5ih7WvIquTYvtQVGJTVOHYavsnYjuSx+lvaLey72FHk4VAwiTKS91CXJ6k57GegzJWttUyxm2eaU39vo1Q3W0m1DlLH4aWnVjW0vs7zpFYo4pvhNrGcvcBAxBWHOee0rDctNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799821; c=relaxed/simple;
	bh=cQ0NOYttVuTL24JesH3cjDNK8rf09dQBYLcHh8XwbN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wgpflqrli6nq8eBmA6a2n4GPkrynoEQkdJXwtTtny+XggaSvNhznlIBuVNlzp+OHf4/a6rs6OGFOBexSZKH2PKtG3RSUYE37zwcSFog7nfQtImbqD/cVonPiuZFXtcu7Ksdf/AMjSLX7xmpzNXiR6XxPLmls86qPE541Fg67N3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VhPu7gN1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uH/xQEsyiYOz4Z57m0Q8E8Xj6NXgL5YyxzBu8mZxlR8=; b=VhPu7gN1S2jNFYpRowCyO9utKk
	8Q+vNSNyc25xtnHC4oQF91OapK+UEsDaqoJU6/+niuYJLm+OA74aQZ/ohGM1GSj3UP3XQ1HajrOQA
	fLEV/Xzpx62KyCVjVUhb8xgPPT0nc16GTqqsLiyzLM4owv3M3/Q4AMxPnm5QSi/w6vOs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKqX7-00FkSy-Ii; Tue, 10 Dec 2024 04:03:33 +0100
Date: Tue, 10 Dec 2024 04:03:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 04/10] net: phylink: add phylink_link_is_up()
 helper
Message-ID: <2a7bfccb-3c69-445f-b99b-6b59573c017c@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefd-006SMj-EI@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKefd-006SMj-EI@rmk-PC.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:23:33PM +0000, Russell King (Oracle) wrote:
> Add a helper to determine whether the link is up or down. Currently
> this is only used in one location, but becomes necessary to test
> when reconfiguring EEE.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

