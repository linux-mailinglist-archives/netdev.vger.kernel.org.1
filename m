Return-Path: <netdev+bounces-155526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA415A02E40
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC716164DC9
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064D1514F6;
	Mon,  6 Jan 2025 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3sX2H3cA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125470812
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182267; cv=none; b=u6Hjrp+sUGFtORAN3eCBmEG44TdkQLzD50yJglhl5XoA1pZbNIGiD8Zt6bnpofSlXHbmlue2okYKXBTvFycgh1BZgUxxOSwySJTgwbJXMNKHB/K7+tDV22uWNWgWzM+Vf0LADEH5Z1PFdPU2Tn/8sYi53IFARInIbxIolF5Wf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182267; c=relaxed/simple;
	bh=yZp+5W1PTYz/ftvo0vnA4tgXv0M4GENqz3hLCZvXaqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTUEXX7gP8/DXYQzJAgp/oRl4YUqUYbL2MWms+ReWAzzxlVSriaSfdC0m5mjtJkVM5aoWLReHRZdwa8QW616NZEsa9wL9dKaYc+G0bPHF6r/ydNbbgankEH90kot5qdaFbUOCsfc2aOEp6l/7mL5jlVAYPUxJcGAjEr0NOi3Dc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3sX2H3cA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C3gGizS9H5zqdUkyePmPkcQ12Bv+tJZg7mz1VA9og1w=; b=3sX2H3cAHYxI8M2VZfYJ6qcNoR
	jORffTRS3OuwSczDaTDdF02Gat+1YOyCks6Y3/yc7nR3SMqVh8i0k+nXkUjf4i0N9xPc168+RkCeH
	rNZJJ9IXU7aM3kJyqIhNRTfpFbcbqpiqF90hnU+RyaQyQFQ5sgfkiH4azr8qT0zx5dW0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqJc-001w1k-JB; Mon, 06 Jan 2025 17:50:56 +0100
Date: Mon, 6 Jan 2025 17:50:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 07/17] net: stmmac: remove
 priv->tx_lpi_enabled
Message-ID: <e0cda443-e7ce-4d01-869c-8791a77a1ec1@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAZ-007VXJ-DT@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAZ-007VXJ-DT@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:19PM +0000, Russell King (Oracle) wrote:
> Through using phylib's EEE state, priv->tx_lpi_enabled has become a
> write-only variable. Remove it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

