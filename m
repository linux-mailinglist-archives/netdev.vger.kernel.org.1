Return-Path: <netdev+bounces-230698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5715BEDBCC
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 22:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9B0E4E4B97
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260D25B30D;
	Sat, 18 Oct 2025 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w+wfa6nn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A12DC32A
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760820311; cv=none; b=r+5jh5zR0m3WORKdzvoaAOewPhlhPvI1MtgXQD7milgqp8EGUH5lp9CXNg7uvqT274heYvHUsV2u86TuOmi17meeQve4iVHAmH/o6W6gNWrJTJDlWNuBhwnf7lyTJKUh3zO19njFLOsEj2BeEXpmehaAaNvkxjeoo5gDFAGle50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760820311; c=relaxed/simple;
	bh=RJcjY4J/V89spow8ABorMH6iqHzU5gOgfKTSs0UyplE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIvF4CLTkIih/bUXQ4zzY2Xe10od0vx4zK1UsqTfe07aXpaSCLRGDICQMJ1EClOJpgZTp1QzVOKl6nAMvZQ4pPeKLVFefCL6S6bpN9SkmIJftxa7vcf+UhDcXq307Jar8pzofFir60EbjKzYXwMoWqmQEIvzpuMhbx5Or2/otGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w+wfa6nn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M8BE/inF98kPrlo4jMfLeCVrWalnzfK85oql9uKs5zs=; b=w+wfa6nn9XaNfQieOBRXpVCGS0
	KIocCTz6+kVqACoV8E+DfvOZD9Xn+FRup0EJo1XSE0ldg1snzcKwQlVWCd0/w5tZg16xpoBIgLvRg
	xCppfZ3PimGE0EKsdpfg6h0MjrjihSX1WKdP1vruH/pmu8KY8rh7b2N1ttfhMEBPB+2A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vADnH-00BOap-4N; Sat, 18 Oct 2025 22:44:51 +0200
Date: Sat, 18 Oct 2025 22:44:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 net-next] net: stmmac: mdio: use phy_find_first to
 simplify stmmac_mdio_register
Message-ID: <d262d94d-219f-4f8a-95c0-7867a8f2ad93@lunn.ch>
References: <20ca4962-9588-40b8-b021-fb349a92e9e5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20ca4962-9588-40b8-b021-fb349a92e9e5@gmail.com>

On Sat, Oct 18, 2025 at 08:48:07PM +0200, Heiner Kallweit wrote:
> Simplify the code by using phy_find_first().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

