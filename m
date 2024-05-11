Return-Path: <netdev+bounces-95627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CED8C2DEE
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804801C21112
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2127E9;
	Sat, 11 May 2024 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvEfdjAp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE88366
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715387299; cv=none; b=Axx0y+pFcjCMYyH9PJz/hTWLymJ58YG+8ywTzjLSN6tCDZloIPXNkR4BEOiR5bN7KH4MnZqpWU4ikF1h6PvPGY2aK4Ok3CjRg0Y0h7+sJKiF7wqZCLnptgj5TMfNPrdOnWNZGj+lgZyjxfOGnH/VnQSh7g5bgUGBWskZY9DYT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715387299; c=relaxed/simple;
	bh=1M7IQEfZncn9mD3DCSFlBW4usIpVyZ37QFmhNDIp1HY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5Ru9MjXWshSg6t+AnwH51IxwzIrCtEqOe38WTZAqRg8R29KP7TTdX8bhxmhRA6Z9VM6Dzu8lXBvT+p9efUKAgYxvYqlxNE1zL9FuYMC3e1UnuNqDcdwysljwQ7lqZrdmeiLuS2m+hcMHBVuvJ9HxWcjSX5lhXD5+6Lr8bfrM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvEfdjAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAE4C113CC;
	Sat, 11 May 2024 00:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715387299;
	bh=1M7IQEfZncn9mD3DCSFlBW4usIpVyZ37QFmhNDIp1HY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HvEfdjApPHC4IWYQ156GH16wGdtufh4RrHOA/8Hq7YRvJHkLXWYViHyR2dMtP3p4G
	 65vvvqXmg9gt5hhJ0u98INDqiBYfV26Bd5k0E6Z51cyx/wgCqHZVphKEhl2O3A19fM
	 nSFJHP7yYcT095E8KvF4S8I0pLmWmyPU3sFZ6SVqLamPzZDsE9VvKAPcNowqtC12f3
	 DoqoHT+6AA6QgH/HQDrxGa3NIcfdc7rw/upgNfMG6JpdeXarmQbuEalE77jBJpVQZ8
	 bQ9UGC2vVLsY/uG9cUxD9vOuxPnM2peO42GCsBjw78h1OyFg+ZgXfqPjYw57Ob6K+b
	 t2vyyUZp4u8KA==
Date: Fri, 10 May 2024 17:28:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Esben
 Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Message-ID: <20240510172818.6111de74@kernel.org>
In-Reply-To: <9ab2bee8-2123-4401-8a82-446d9bf97316@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240506011637.27272-8-antonio@openvpn.net>
	<ZjujHw6eglLEIbxA@hog>
	<60cae774-b60b-4a4b-8645-91eb6f186032@openvpn.net>
	<ZjzJ5Hm8hHnE7LR9@hog>
	<50385582-d0ae-4288-8435-8db5f5f69a13@lunn.ch>
	<9ab2bee8-2123-4401-8a82-446d9bf97316@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 20:57:33 +0200 Antonio Quartulli wrote:
> > I suspect it is more complex than that. checkpatch does not understand
> > kdoc. It just knows the rule that there should be a comment next to a
> > lock, hopefully indicating what the lock protects. In order to fix
> > this, checkpatch would need to somehow invoke the kdoc parser, and ask
> > it if the lock has kdoc documentation.
> > 
> > I suspect we are just going to have to live with this.  
> 
> since we are now requiring new code to always have kdoc, can't we just 
> drop the checkpatch warning?

I don't think we require kdoc, but I agree that the warning is rather
ineffective.

