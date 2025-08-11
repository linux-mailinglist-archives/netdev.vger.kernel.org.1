Return-Path: <netdev+bounces-212454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1BDB208E5
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF433AF513
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83FE2DBF43;
	Mon, 11 Aug 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o4MPdHMw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97325D558;
	Mon, 11 Aug 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915810; cv=none; b=IX0VVHVe2mCV6otnUMKz0yK23BQ7DBWdLUq9RoGzDPGkLk5K08w4++Gs+zZC78zCpAffoik1C2LDYO13UvVR8vRIaYEMFC2uytESHZMa3IWcuM1Chfy6EY8oIdJrF+EkwNdvbpcQvSLBnoD9o4plbh+1L4hn+9ii6QSj5kB5aT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915810; c=relaxed/simple;
	bh=d9aCnhhSWiL8e1FAw1+MrFJ+tsJO88UKiZaU3SONiDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arA46nkeQsb5s8m9z4LLAJcGZK8uvy2eQ/85fAReSUNGx16HODGmI9XWMMHYOMpfY9rO1kPOtBR/F6I1w6GpCZEtbpz7/xCXeEzKKQ7pmuPwS7cz9OFP8jNKs81z2hnyRafDtmaR31Vh4b68ZIwcrp5LWv9I2x9dJs+pwyZe9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=o4MPdHMw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=akg1VPYncJQYtJga7vyBFrDG32QQSfTrI/1dhFFl3BU=; b=o4MPdHMwnmCiOadxyyWvcFCZo0
	D5kqPdZu1Dvty7VJewOzG62G1zaeIh+Z7ulAfFaKPVV9fcSfUXcJwzZ1wCe4Wl3kS1G89ImbjHAHk
	IckHFPeVP6RNr/RG2sf5Adaz4aN4oOHldJvWad0OPNG85bkfc8sJOnnoUhVZCYoQN2a8a21kdVNL+
	BXtZeoNHXFGtlQErARdOwNuNqx9ANkWt96a4IxVH+UwBByFNsME5MFjZtm12U1u7slPFJ6j4qhTNH
	OWvYevGBGT/BmP1YFAAZtZoVU7qN/r10xuuf5zhfx4jsH93FMoJClbo9o73SEoKViTksc3SfpnY6f
	Gu+DQDTA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33394)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ulRlV-0002vA-1L;
	Mon, 11 Aug 2025 13:36:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ulRlR-0003hh-1q;
	Mon, 11 Aug 2025 13:36:33 +0100
Date: Mon, 11 Aug 2025 13:36:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: make variable data a u32
Message-ID: <aJnj0e8P8ttlRf1r@shell.armlinux.org.uk>
References: <20250811111211.1646600-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811111211.1646600-1-colin.i.king@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 11, 2025 at 12:12:11PM +0100, Colin Ian King wrote:
> Make data a u32 instead of an unsigned long, this way it is
> explicitly the same width as the operations performed on it
> and the same width as a writel store, and it cleans up sign
> extention warnings when 64 bit static analysis is performed
> on the code.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

