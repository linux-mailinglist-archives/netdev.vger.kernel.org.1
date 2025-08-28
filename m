Return-Path: <netdev+bounces-218013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE0B3AD4C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B624985DEC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDA62C237C;
	Thu, 28 Aug 2025 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPkiKqNU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF82C235A;
	Thu, 28 Aug 2025 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419141; cv=none; b=rpfx61LGCNakNuxdhw7CNRgypitYeG0HPCFl59G/hgMc2OGOpeAAjRkkWbgDCuzMJL3l9vK/xHEBq5ypndRFalvJnpvtU7SZM/z0I4xTTGV+CowHqgOMbH8aYIZJ+1NXDTMqT/lgTMK1hpSZ/t+ZZqEEOgODo6I7L4v4e249JTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419141; c=relaxed/simple;
	bh=UWlu8QsOTsA1mS5L1if06hZxrHH8H1VotXtHS8zn000=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGuri2JAL++I614YlPVCg+Q2yXl1k3IoxTWNqc0JdQV2fpf0/3liPC0GduBmJ8o22//d0du9qp9PVxif5AHR18xSw30fWYxdMsz/ldIwHuTGNSM4FaU0XcPlgL12+IeKFzkfBJ7mQpOzs+viYD1EbOLvP6EwkypUFYDufqKDRpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPkiKqNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3143CC4CEEB;
	Thu, 28 Aug 2025 22:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756419139;
	bh=UWlu8QsOTsA1mS5L1if06hZxrHH8H1VotXtHS8zn000=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iPkiKqNUWOD72UkoCAhcymJY9XjYukLbNSFVS65ZJAJkrdUMIMTp+Aspvoslsq5hz
	 d0Pnl852spGmWH3PI/hQvz72prXDWdAGMfAAb2pW2dWHY2hk6018YHjkSmZZJ2wjeZ
	 N6p9R8VU/sy/zfddYu/QDwfGCXsJmaPWHpTPuhyaNm3vE+ZP1mR/GE3h60SBIkmTBq
	 AacK2H+VfpPHRUYP7AwShEJdzY9S6IhAGS66L7YquSiFbQ92Rp8jFsj9D4tzgfF3RQ
	 K7lm7XSEBaRgXUx5wp7PL8pYKY0gm0lP8JIGIS9jYpHx7ieluW8JJCII/VjtVGy13X
	 RZO5GST21uQRw==
Date: Thu, 28 Aug 2025 15:12:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/2] net: pse-pd: pd692x0: Separate
 configuration parsing from hardware setup
Message-ID: <20250828151218.1c187938@kernel.org>
In-Reply-To: <20250828104612.6b47301b@kmaincent-XPS-13-7390>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-1-dcd41290254d@bootlin.com>
	<20250825151001.38af758c@kernel.org>
	<20250828104612.6b47301b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 10:46:12 +0200 Kory Maincent wrote:
> > On Fri, 22 Aug 2025 17:37:01 +0200 Kory Maincent wrote:  
> > >  	manager = kcalloc(PD692X0_MAX_MANAGERS, sizeof(*manager),
> > > GFP_KERNEL); if (!manager)
> > >  		return -ENOMEM;
> > >  
> > > +	port_matrix = devm_kcalloc(&priv->client->dev, PD692X0_MAX_PIS,
> > > +				   sizeof(*port_matrix), GFP_KERNEL);
> > > +	if (!port_matrix)
> > > +		return -ENOMEM;    
> > 
> > Leaking manager..  
> 
> I don't think so, as manager is declared like the following it should not.
> struct pd692x0_manager *manager __free(kfree) = NULL;

Please consult documentation on the user of __free() within networking.

