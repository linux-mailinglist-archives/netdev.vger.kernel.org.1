Return-Path: <netdev+bounces-111540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43F29317DE
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3C8283AC6
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A8DDA6;
	Mon, 15 Jul 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qalh41+G"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD6134AB;
	Mon, 15 Jul 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058636; cv=none; b=fUR7GNA8T9xVoZ+anxBvveKzegarGXFSg7JxZSWmW142vsJccEJjsPCGq+CB40/gMBQTraIljAl5E/Yxke0ma74IfeAUP2O9xNJDTkmougHcFuvTu4qDp1RSQIf1ELlK0o0/xxBTLhtB7TJnMDLPoUv/bI8HWw11M35u/e9feg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058636; c=relaxed/simple;
	bh=DHu76Zualp60MP+W/T8d10cmV4dteM/1Lm1v9ubEMSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU/f+iXmdDybEDEJqRAN0t3t4siUFW34FK4UT79a9J6IBrNN0/1BFLBpLDPOIRMU87PnQGpJylUB1TxQJLYEY6PJQ6vtEOgbFS8PmhkXVVy6EbKFNcrANvrvpD1e6fPFVlKklB7cxAChwbEpws9bV7WmHBNRjlDzqfAsZ5Dridg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qalh41+G; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DCf5PUVGJarugMnXR95gCBJ03gopIvHTOKZp1WNO0aw=; b=qalh41+G5hwVr6sXawosVBqXL2
	goIsEuLwCVz1tbxOWz+P7lLW4G3kRADXLOnDjyUJBIbLFwQrkaj3vD2mu2VmMDwSxRXeBT2Rg8Nhl
	BGUZZwiCrLES2Ypk/H9V6Kl5R1zfMzM5cvxlJkFC2a2LznKYWmJktS7HNsW5M9wXRyB3WtcBnRk4H
	hveNFS2byYSyWEmD2Kkg+e4up40C3n6KB9g/alm+4LPf5vaTb9FshKRPU4vUAZ/ept8cXPAGpz/jm
	X1yUKYfL9bE4udmzzYIPElp2guFdz0DvtYH/x/BVrnRvdOwZZTro9sJ8nEYqnBzcgw/+XkV0bRHsh
	f8vtnI3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36608)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sTNrr-0006bt-0R;
	Mon, 15 Jul 2024 16:43:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sTNrt-0006va-97; Mon, 15 Jul 2024 16:44:01 +0100
Date: Mon, 15 Jul 2024 16:44:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: marcin.s.wojtas@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvpp2: Improve data types and use min()
Message-ID: <ZpVDVHXh4FTZnmUv@shell.armlinux.org.uk>
References: <20240711154741.174745-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711154741.174745-1-thorsten.blum@toblux.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jul 11, 2024 at 05:47:43PM +0200, Thorsten Blum wrote:
> Change the data type of the variable freq in mvpp2_rx_time_coal_set()
> and mvpp2_tx_time_coal_set() to u32 because port->priv->tclk also has
> the data type u32.
> 
> Change the data type of the function parameter clk_hz in
> mvpp2_usec_to_cycles() and mvpp2_cycles_to_usec() to u32 accordingly
> and remove the following Coccinelle/coccicheck warning reported by
> do_div.cocci:
> 
>   WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead
> 
> Use min() to simplify the code and improve its readability.
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

I'm still on holiday, but it's a wet day today. Don't expect replies
from me to be regular.

I don't think this is a good idea.

priv->tclk comes from clk_get_rate() which returns an unsigned long.
tclk should _also_ be an unsigned long, not a u32, so that the range
of values clk_get_rate() returns can be represented without being
truncted.

Thus the use of unsigned long elsewhere where tclk is passed into is
actually correct.

If we need to limit tclk to values that u32 can represent, then that
needs to be done here:

                priv->tclk = clk_get_rate(priv->pp_clk);

by assigning the return value to an unsigned long local variable,
then checking its upper liit before assigning it to priv->tclk.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

