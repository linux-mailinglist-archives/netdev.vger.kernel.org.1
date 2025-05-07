Return-Path: <netdev+bounces-188506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D63AAD233
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983E21BA8AAC
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD398F4A;
	Wed,  7 May 2025 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xgPdcWUh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04410E0;
	Wed,  7 May 2025 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577186; cv=none; b=Tp67Hoj8huqkKrFkWfpZXiZ4Cn59s0Q6ft5Rkjgw7VyAi5cKmd5No+bijKUjofyoVty0+9Rv+KWzzTCMgKKPHS8nknJsUC9iWN90MKMBVB6GlHPmjODJFDEENburtXhzCSe/fPnr44qCaYZd+sTsr8SI73muXKeTZDesKOIMVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577186; c=relaxed/simple;
	bh=fZxGcNvTdZTFQLMlJzF/fwaxYwZT8e6wbu3mTrUHadg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSMO+LlMtJfEC9XJ6UoEPI+hea7MLOtnGzKnog0HJeJxx+R6gN/vn9D387SbIK7zjhfH59GpZt1l1XjjbPFOcBW9CzklfE0xn/bklg224xhMFH/Zul8D4bu/x6BcAnqIFWL28+dBfuiyematj8B4JWIRqCqdRCjOhX9ENAuLLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xgPdcWUh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xTXkZlmGU0IUIeI5o1mZLEL2Y+CPmDfnV2Cutj83nfI=; b=xgPdcWUhv4EFQcPM13XcmfmxKb
	aBP9zY+Xa7DSWHBgJrqyf7u/sw7qlCR0Bx+JRNdmgf2DqObdL1PgiPlD3I2EcCQdaz5yhx0qDV2go
	qnPTEFZTNRz/ekJxgctQ4Fo8g25YfU4FFQ42XSzEzlnjWpqW9mIY7a3szBE35MoooSm0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCSVU-00BpHj-5F; Wed, 07 May 2025 02:19:28 +0200
Date: Wed, 7 May 2025 02:19:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v3 05/11] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <90b2af4e-6c6e-41b9-be5b-ead443cd85b2@lunn.ch>
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <20250506221834.uw5ijjeyinehdm3x@skbuf>
 <d66ac48c-8fe3-4782-9b36-8506bb1da779@linux.dev>
 <20250506222928.fozoqcxuf7roxur5@skbuf>
 <39753b36-adfd-4e00-beea-b58c1e5606e3@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39753b36-adfd-4e00-beea-b58c1e5606e3@linux.dev>

> > You will need to explain that better, because what I see is that the
> > "BSD-3-Clause" portion of the license has disappeared and that applies
> > file-wide, not just to your contribution.
> 
> But I also have the option to just use the GPL-2.0+ license. When you
> have an SPDX like (GPL-2.0+ OR BSD-3-Clause) that means the authors gave
> permission to relicense it as
> 
> - BSD-3-Clause
> - GPL-2.0+
> - GPL-2.0+ OR BSD-3-Clause
> - GPL-2.0
> - GPL-2.0 OR BSD-3-Clause
> - GPL-3.0
> - GPL-3.0 OR BSD-3-Clause
> - GPL-4.0 (if it ever happens)
> 
> I want my contributions to remain free software, so I don't want to
> allow someone to take the BSD-3-Clause option (without the GPL).

Please can you give us a summary of the licenses of this file over its
complete history. Maybe it started out as GPL, and somebody wanted
their parts to be under BSD, and so added the BSD parts?

	Andrew


