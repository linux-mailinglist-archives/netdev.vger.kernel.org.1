Return-Path: <netdev+bounces-152117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC739F2BA4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B889C1884ED3
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2177A1FF7A1;
	Mon, 16 Dec 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L6g0QXKd"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D671D318F;
	Mon, 16 Dec 2024 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337122; cv=none; b=thMupvA3Shl6u88Nkdlwk0LCrDHwao/QCvJC7J8CYZrQiL2mbq9DRCaRcm7Ow5hMAWA8Fly5yI1TvDivO8LlHsmP6zUd3mU/YWQ7u16OJzuRmtVOBIcEyFDa3fGFBJ8fhJmAGrexlyJzYc/lmMzwP1QLwa5a+UaFuCxQhlMdPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337122; c=relaxed/simple;
	bh=4hMASgrX5XYa0CN5ZYALS+fZVUW8fHCtSqfFrH0xFOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCvnynivMolS6uCA5dtkXICjV1sp8uR2l+C5+8YrDbam7iwC6nrB2Rr2sB7P00UhefeD+R5eL4mNTpffd2LfkoVfTiFpbx3sEy9CsYn16p+tLPSJKDsVvpoPZowsdSroGj8X/3AwzkEIZtaFQnolm02fsA9q2A0sBg+dTd/A/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L6g0QXKd; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52484FF802;
	Mon, 16 Dec 2024 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734337111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxS4ncPpbKlMnJQoKFd8UWkTSQivyZ8RY8LCYQtrmNo=;
	b=L6g0QXKdxrWm0q1CYYnXC6J2ukMS3d5pJImPPr7qQ8cAMergObjjMlyk2MwqGMnTc8SCGH
	yyGyr79Fb8aXS207hHSHxL726xEHZTIC5Z8XMPbHzK0SuSLkghGPD3DJj0QgBm5Vj4w6Ls
	jKgPjmvahPDAHsoRhdwxP56NAR6njisU6iY+EUK9WRpxgASltWnc3m4E3YJYyKqR+OO/FD
	bSECcVFfm++Hv018s7qg4qJ25q7YlhhUle5G9sVksvlJ3zC0Nv40gl5yT83MJ4ZXMboV2S
	m9e6sMIKILAFiAEweWN7L0Dtmlzf4qqVHs5iTgcFgk1M9+J9JSTSdQycndxAkA==
Date: Mon, 16 Dec 2024 09:42:24 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Set interface
 modes from Lynx PCS as supported
Message-ID: <20241216094224.199e8df7@fedora.home>
In-Reply-To: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
References: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
	<20241213090526.71516-3-maxime.chevallier@bootlin.com>
	<Z1wnFXlgEU84VX8F@shell.armlinux.org.uk>
	<20241213182904.55eb2504@fedora.home>
	<Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Fri, 13 Dec 2024 19:21:38 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> > > However, maybe at this point we need to introduce an interface bitmap
> > > into struct phylink_pcs so that these kinds of checks can be done in
> > > phylink itself when it has the PCS, and it would also mean that stmmac
> > > could do something like:

[...]

> > > and not have to worry about this from individual PCS or platform code.  
> > 
> > I like the idea, I will give it a go and send a series for that if
> > that's ok :)  
> 
> I've actually already created that series!

Woaw that was fast ! I'll review and give it a test on my setup then.

Maybe one thing to clarify with the net maintainers is that this work
you've done doesn't replace the series this thread is replying to,
which still makes sense (we need the
stmmac_priv->phylink_config.supported_interfaces to be correctly
populated on socfpga).

Thanks a lot for that work Russell,

Maxime

Thanks a lot,

Maxime

