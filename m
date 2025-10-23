Return-Path: <netdev+bounces-232236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19044C030FA
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37953AF900
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B602701DC;
	Thu, 23 Oct 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XcbfuMrS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D968280A51
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245292; cv=none; b=FyADbuKfFeWbKZ1wbjdiktR8LP+xRe7USNuKDQQdfA4WI/9csbiTUJ95l3RcuraGN+P4d3559y9o5Y6u4uCP19wNG15DeDhwaIvBIagdGOj9+T1xn+MJYXg9HaVVGmKxQAzAQUg9Bl33/y4ogckBS01E01WaI4EeOxq4zBXJTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245292; c=relaxed/simple;
	bh=+NF01BOvJ7RIozV/Gu3L3P0DFVWjHicQ4KTUGb6AwdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYhoB0QoP3ALd8Jic/Gr5DrgxTqZfJrCDUNxFoX/ciDm/IVC0By+BAvCtXPD2iZ5eu4dBmpk7mAi0zEyUQ12NBya+jh2UCXR+vmcKfZ+y5oZjR5iZeDWDe8DltoO+2AY88MHB8xTj+e66HFMBKbbnyYsYVDs+gB6lTzqIPW4hwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XcbfuMrS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5Fqr22ggTJV1jyun682iQwk8f5dcYH5XeO5RUl0DkB0=; b=XcbfuMrSpf3fzfDxgFHTkcDrJp
	RiLsrktBggcFKNaHGASbmS/OACEAWj5VnRj9OSriRBmY+F9qddn+mzjblr+pMOVYFwR0PQyMI82lY
	3BLxEb4KFJMZM2/68+kXli82gzhDinxtk3Vn8XbWm2+zTHE/YRlRTOai+oxgPmchCd1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0Lx-00BuZP-RF; Thu, 23 Oct 2025 20:48:01 +0200
Date: Thu, 23 Oct 2025 20:48:01 +0200
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 3/8] net: stmmac: consolidate version reading
 and validation
Message-ID: <88dfd6f5-37e8-4bd5-81f6-615b1e1cd518@lunn.ch>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrlG-0000000BMPy-29xx@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vBrlG-0000000BMPy-29xx@rmk-PC.armlinux.org.uk>

On Thu, Oct 23, 2025 at 10:37:34AM +0100, Russell King (Oracle) wrote:
> There is no need to read the version register twice, once in
> stmmac_get_id() and then again in stmmac_get_dev_id(). Consolidate
> this into stmmac_get_version() and pass each of these this value.
> 
> As both functions unnecessarily issue the same warning for a zero
> register value, also move this into stmmac_get_version().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

