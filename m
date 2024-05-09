Return-Path: <netdev+bounces-94942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04B8C10B5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B893C282B79
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4025A15DBBB;
	Thu,  9 May 2024 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2sxGrVHY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925026AF2
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262934; cv=none; b=ALasfELNfVx6CtnwbbDLQO8WL3aYzWOTgQmwG4uEhl6qSiSC+mgSqiO4T48QnfgG52mUvt4uwIf5ccxGCq/BPbzk9Dc01WmeHFvOklAi79Au/sQYH3ch7OUf92bpha+G97pS6VYJwNU7dyJHSLVBiwrh4UzKg4boXEAueWKAk6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262934; c=relaxed/simple;
	bh=NMPwWOeNeLs/lLUBoH7SxWx3Rl4CYUwcOek6nOmHAF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP5EfZISO8ffIOHw7/cGSLYNK/4XJv9k2ft5DJw9Dhx1MMlASghGpBDJAGB69mQOcO7whtEi8EwnFHTAsBNexPjr79zpsg1JWXRwjzIH60UKmLNhOWYXOLNwNkRfhf4n98mhvRvGkfrva90SsWsvrNfwCCfwlV3eCnzgc+sAYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2sxGrVHY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0NNV8eL50WGEKv8TK3HZJ1ktWsdkD3Yg0fmK29OwJ2Y=; b=2sxGrVHY9elqsJo/0VvjdkDR39
	+id8MRriJApyDaPf2Zae7fqz8WED9g1MBYvdeDKdI4pOjd45AkVejyifz4EcJC5+1dbkRB8oB1tUN
	TY78l3ux97FcAFe4mHUnT99qudroHM0abLF3Xn01D+gZwksoJXPdkbiis8uxNtgaUydM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s54F6-00F37d-5m; Thu, 09 May 2024 15:55:28 +0200
Date: Thu, 9 May 2024 15:55:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Message-ID: <0d4fb251-c6cb-4805-b248-e9268175688c@lunn.ch>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net>
 <ZjujHw6eglLEIbxA@hog>
 <60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net>
 <ZjzJ5Hm8hHnE7LR9@hog>
 <7254c556-8fe9-484c-9dc8-f55c30b11776@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7254c556-8fe9-484c-9dc8-f55c30b11776@openvpn.net>

> > Whether you WARN or not, any remaining item is going to be leaked. I'd
> > go with WARN (or maybe DEBUG_NET_WARN_ON_ONCE) and free remaining
> > items. It should never happen but seems easy to deal with, so why not
> > handle it?

> This said, I have a question regarding DEBUG_NET_WARN_ON_ONCE: it prints
> something only if CONFIG_DEBUG_NET is enabled.
> Is this the case on standard desktop/server distribution? Otherwise how are
> we going to get reports from users?

A bit tangential, but:

https://lwn.net/Articles/969923/

	Andrew

