Return-Path: <netdev+bounces-232515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E165C06261
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162573BB696
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91692D322F;
	Fri, 24 Oct 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tyrwNe5q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3528D8DA
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306912; cv=none; b=tiDvxbIyrODuOwoWzuoc6Lch3NgszLUgn/sBKgU4cOEwUMwt0/JDSmbSkgPyXDHAhO5PAx3U3ZofIR6XBzJodsB2gHeFMc2yo7iOWvN3axeqWQYKBpkU0tRYAWi7r0WbanHOYjTBgJr+2Vz+PKbxOD1oCM7qlcL127FKv/bG7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306912; c=relaxed/simple;
	bh=chYb5/Kbr+WJZdkUSLmbVIxXNSwWkfpNDxwMrcrlcYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzJZbFSWU0X1cHcRBtXdVfOo6fqOYhjLl5p6KAqT/RQuFHp/UADlA08hAWZTfgJLL5NllpR6AbiC1MDOKmhonGs8zsB1crMkaT/sZcyQyIDcji4YatuWoQVx5Va5jKUrbiTsKEyLY8DzDULkXZP7hn3l/1neBZwzDuRMcoanAOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tyrwNe5q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O7sz382GaRqq3wu0Mxvr8plc3nTGBMiwWUf7iSRaaA0=; b=tyrwNe5q8BXOnmVhVyoJPU6tQa
	vX8n8bXOqehCN8Yj0LthHBHK5/4Ux+zbp+/mkEsEkWlnkfR/W7fKiwJE11xTZEXRAafM7ySZ3mx5U
	f77+iNjvI/DYM/OqBaGn2T1eN5UA+PY/fjlc1Osko0XUZPVE+GPUSXOdA5Zl1uFF38Oo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vCGNj-00BzU4-0u; Fri, 24 Oct 2025 13:54:55 +0200
Date: Fri, 24 Oct 2025 13:54:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 2/8] net: stmmac: simplify stmmac_get_version()
Message-ID: <915a9b64-1d75-4f32-a3f5-17f88fb2fbd7@lunn.ch>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrlB-0000000BMPs-1eS9@rmk-PC.armlinux.org.uk>
 <81d5c1f2-e912-40de-a870-290b0cf054b3@lunn.ch>
 <aPteqZ57fWULRfNy@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPteqZ57fWULRfNy@shell.armlinux.org.uk>

> Hi Andrew,
> 
> It seems I had a typo "verison" which should've been "version" in this
> patch, which carried through patches 3 and 4. Are you happy for me to
> retain your r-b with this typo fixed please?

Sure.

	Andrew

