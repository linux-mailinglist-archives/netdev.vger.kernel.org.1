Return-Path: <netdev+bounces-111111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CA292FDE4
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9799AB220C3
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58AE1741EE;
	Fri, 12 Jul 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PrNMAGQt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1C1802B;
	Fri, 12 Jul 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799411; cv=none; b=W7E/6hIhk4bQdwKnU8lP5dn11yyYIugpl2w/dCSXmN3aO7nxevgWnAIejFwmZcZqhnl/d5cPUbX7upwbYHHExfP4k2ODS/v1GVCwR98gXGPejZWMnL5HbgaH1UTuETxXPfm7Ofb5Dz8z3g/EXePRoiTyn0TVkz1IZjb8Qo6s/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799411; c=relaxed/simple;
	bh=Mla2qp4P6f3s5qVeM8q9ZP4JyeIRnpixetFiScwef/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8YtkUoglkc0+w9XS08Qid6KOYjkqTiU1AywfBQXMl+5cFoDIcn0AILFT2PGDFoBJ0uNzGfrk4q9HT5SH1qOafMxHcb65j+RiPkxC9xE1stCeL7R8LIvHoFdDmBUV2jwYvVmOizbtTH8lLjCO4SZtnSoP8GMMrNK16SlUdLLKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PrNMAGQt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qHv8yTSFLSMtZ0q84mBoE6pXrYioa5FC1WI8FEKczCU=; b=PrNMAGQtDyPU4I3f++s9YdpEz4
	lDCdmD19nDMykbBZtgKuKWpA3LWGxZ447iSGCGAiAlGxwzHmKfUQBNo2FOFk2PxGfr0mkPe0YUrwc
	Mjr6HfzgscaryKWkvRolrwyyO8rL47XdVVEclOIH6hHpQoSCoypw/O22nNXDyCB6AMCk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sSIX4-002Puk-1w; Fri, 12 Jul 2024 17:50:02 +0200
Date: Fri, 12 Jul 2024 17:50:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: phy: dp83td510: add cable testing
 support
Message-ID: <210b2feb-5a54-4c3a-8a85-8a61334153ce@lunn.ch>
References: <20240712152848.2479912-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712152848.2479912-1-o.rempel@pengutronix.de>

On Fri, Jul 12, 2024 at 05:28:48PM +0200, Oleksij Rempel wrote:
> This patch implements the TDR test procedure as described in
> "Application Note DP83TD510E Cable Diagnostics Toolkit revC", section 3.2.
> 
> The procedure was tested with "draka 08 signalkabel 2x0.8mm". The reported
> cable length was 5 meters more for each 20 meters of actual cable length.
> For instance, a 20-meter cable showed as 25 meters, and a 40-meter cable
> showed as 50 meters. Since other parts of the diagnostics provided by this
> PHY (e.g., Active Link Cable Diagnostics) require accurate cable
> characterization to provide proper results, this tuning can be implemented
> in a separate patch/interface.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> changes v2:
> - add comments
> - change post silence time to 1000ms

Nice comments, thanks.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

