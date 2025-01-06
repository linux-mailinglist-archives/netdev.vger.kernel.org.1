Return-Path: <netdev+bounces-155527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2180CA02E46
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA533A34C9
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987881DE4DE;
	Mon,  6 Jan 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uEGv49UA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D521DE4DB
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182316; cv=none; b=eJG92su0GlFdh5TZXD1JvTEOtXRZMbDMaZRwiFcQpz17Q29M4rtW4WDnTYJ1ZQTUJJcmvkWhCPW6SHzD2A2QKryEOUCr3iia1Cy0AyxZ43s7j2h136XXkcnawamrmJQkepYl8cux/mWhF/YWdxet/20Vg33tbJplvclUNbZF6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182316; c=relaxed/simple;
	bh=NepgUpvWSVi5lj4sgmzYTPtkV2A2JFySj/lccoU6WHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY9fFZRsIwkhgpTLqHHI7YNe2q+AMn5WilxRKQic6m6rtHxN63Mp1C1Qm5Hzt0kATLLSz65tairAE4EcArbcP4k4+dcj+yi7Cs46Wt3O8Y2E3eeslF6h7yuTQS8lE67/JBtWjxkw8M7KaDbLz5aUb+ON1dvqmps5cTDY4EEkNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uEGv49UA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EGk3XnDVBBgGI23iHvUxp5yLbTGC9ExrtL/00GwpF7Y=; b=uEGv49UAPICl7wgeWt00F/clnm
	KEFPnPsFwc4v48nHmw4rNqYeJ7CVdSXL975hV9MSdyr7zKaeulHvjTgN42bfExye1fdpuigqF8SDJ
	WoZ3OM5sDmjoO/DwnQzBbL/JQSuIpSX2H4lEr7NTNzW3j38/LHX5ptfe5DpObV5BzIKI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqKM-001w3I-Pl; Mon, 06 Jan 2025 17:51:42 +0100
Date: Mon, 6 Jan 2025 17:51:42 +0100
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
Subject: Re: [PATCH net-next v2 08/17] net: stmmac: report EEE error
 statistics if EEE is supported
Message-ID: <a72bd3d3-9cfe-4f25-a9e8-c6dccaf21a15@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAe-007VXP-Hm@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAe-007VXP-Hm@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:24PM +0000, Russell King (Oracle) wrote:
> Report the number of EEE error statistics in the xstats even when EEE
> is not enabled in hardware, but is supported. The PHY maintains this
> counter even when EEE is not enabled.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

