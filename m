Return-Path: <netdev+bounces-207193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 223DDB06280
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE283B2A91
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F82204863;
	Tue, 15 Jul 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z9PvVpBz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F1205513;
	Tue, 15 Jul 2025 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592267; cv=none; b=tkyZ1SUH6dMi+TBZleBhgLda2dZgoRfctSJ3K49Mbb1+ojXyxV6eLAII+4IAQtmQ65StCeUpwcZMFth9GbATkWj3UlcxyQOyv1VkSFF8W6/upjCpiHN1xo7kA0Cy6zHvYplhMtmOQSFbVEAiZn0aSDae4vEMkpSaXAJd8lDbZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592267; c=relaxed/simple;
	bh=S1PExuHToNEG7eKSpI1uWFzIYPtAq2H2QDvmIy2nGkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjWok4jSPln3hB60QRvpfwpVyjDOrp3yvyz2ILsYKATz0VFfROcI2APkjY2uXo9MVkuFxzIOa2f6sQ7/gKAAOtedemliwGH9sZmFCmUd5mCcLiCVEUxO1JxfbEGWXIgHxMKUl2T9WQ0an5gd3mG/r8yS3dHyO8irtZUuJbJgeHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z9PvVpBz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=lxm0BMHsTQDJY5VVN8bBo0QKdZrScIjjqvDsm2mUM54=; b=Z9
	PvVpBz0hEgqOXkhF+yiuI1ocj439iMwU8DxWZ9XrTewgSy5HO2xkaijOlzjAby3u1qCkJ8mFWjjtw
	RtRLfC35IZRqkUmdqv2HIrJJ4JNVKSJ63XEG2ftONaG6Oo9UWQA8P+mpUeir5lFjLuxN8hXZfCNVe
	xN9DOodvCcwAbsY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubhIx-001bDi-8L; Tue, 15 Jul 2025 17:10:51 +0200
Date: Tue, 15 Jul 2025 17:10:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
Message-ID: <2154c04a-b9ad-4382-95c9-1e3d7d342c9b@lunn.ch>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
 <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>

> As per the XGMAC databook ver 3.10a, GMIISEL bit of MAC_HW_Feature_0
> register indicates whether the XGMAC IP on the SOC is synthesized with
> DWCXG_GMII_SUPPORT. Specifically, it states:
> "1000/100/10 Mbps Support. This bit is set to 1 when the GMII Interface
> option is selected."
> 
> So yes, it’s likely that Serge was working with a SERDES interface which
> doesn't support 10/100Mbps speeds. Do you think it would be appropriate
> to add a check for this bit before enabling 10/100Mbps speeds?

Yes.

That is the problem with stuff you can synthesizer. You have no idea
what it actually is unless you read all the self enumerating
registers. Flexibility at the cost of complexity.

	Andrew

