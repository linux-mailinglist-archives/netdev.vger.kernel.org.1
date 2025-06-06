Return-Path: <netdev+bounces-195346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6945AACFAC5
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 03:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DD8177713
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 01:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618F347A2;
	Fri,  6 Jun 2025 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ1AjsLd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141BFA927;
	Fri,  6 Jun 2025 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749173725; cv=none; b=coD0hW0bv95baoS4HRgmWjKSYwpkniDSyDwbfoiwY/11WmShaJsQkB0Gr84inXb6N1iF9fI50wbEI4SDxhPDXpvF9i1pBnbqrRYa/6suG7rSV+EWuk60m0hvSjr0hEp5uhqHMPFl7paiCCh5QYGRYzURCGLK856anluEjjwtg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749173725; c=relaxed/simple;
	bh=fi78G2MH2x9bAllKVHYxWc1xNdcgmxScO+OXg6MdNAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+cWe3XwWMaX34+uOERzMm6q2CXOeefjcSLlObUqZFA5RpX/FC5gxYHBuCcRTE/ycgTtaMQ88/bNigE26vFWZ/B76Wk2fPRhJaBn8L/O9p0Xw4O1xWn9+Xq7TbvBEyHcRgT+MLDJUfBZwkWQRxtIvNiBfBPAhwTfid4fktU5KxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ1AjsLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6BEC4CEE7;
	Fri,  6 Jun 2025 01:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749173724;
	bh=fi78G2MH2x9bAllKVHYxWc1xNdcgmxScO+OXg6MdNAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YQ1AjsLd48A1pDJUj2NxZTVn0p7U2gr8l1/EFjnp9dwdzb0OJathsK6tPhJ+2NALF
	 EmOOBpIOpJGBU6LmCwvtnDWLwIqn2jvzzB16M9jrv4BA1jlz73OjnbO/mEacGiq55I
	 jF38OXnNDgkHc1b7IJrELo327/fYT0tvZlxWE3H8o21LKjOF6SQ4c0gvBhdos6cQVs
	 sI5XjYswbqhNl0UcfsJx7A/r3WFnpZhPSNpfDdYd5itvGjC22tqTCGpYHsrWLx1CDX
	 T5bNzZ7Lf1dM037y8g5fFYlyotwyzG/uNFbq7kgXjXJz6rkMIRDYD2ODIMr6EvIR3F
	 y1qGLNrMOxFXA==
Date: Thu, 5 Jun 2025 18:35:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Oleksij
 Rempel <o.rempel@pengutronix.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Donald Hunter <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget
 evaluation strategy
Message-ID: <20250605183522.6f16459a@kernel.org>
In-Reply-To: <20250528151715.59b8f738@kmaincent-XPS-13-7390>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
	<8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
	<20250528151715.59b8f738@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 15:17:15 +0200 Kory Maincent wrote:
> Would it be possible to review the netlink part of the series? 
> (patch 2, 7 and 8) 

I'll read the other patches when you repost, but the API in abstract
LGTM.

