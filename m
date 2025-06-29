Return-Path: <netdev+bounces-202259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1FCAECF80
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 20:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F403D7A035D
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A283E221277;
	Sun, 29 Jun 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EUutas/J"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F63B7A8;
	Sun, 29 Jun 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751221050; cv=none; b=LDitt4Qq3VFj5VvMedlOPHnyMEGXevq8GtOlwfj2NTggjpn+T2kUKvqQo1S0FbMTLtGyvAkoScinoFxxcRABCnZi4dFGvjcWj7MUPHwYeF5Z7BoL32H7sFmeRDw0ZcoyQgobqNEGlhuW2I6lVk9vJBunLGg+uvSXDvvnA48YmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751221050; c=relaxed/simple;
	bh=airbvcQKAaxaongBL3lXNson0shXCvbkudpYCzoF1Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgqyxPtKS4lfybuY1Kyc/DMwhFFg8bVOHhUDV+WOfcY3WZmGTMFlylGXVCN89hWISJv9OhB3/nVuL1Km01EjEZQ04b/aiDEtm0pT00ErxLM7r8M85wn8V9EqtokVbf3bCTSk+dW++P8YQVBF3YWJkURlvrn5d7eQ8C1N81JHc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EUutas/J; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=89j1991wXjYfJN8Z1RjyhY9TftJyvBHlmvVx7ZSjkgE=; b=EUutas/JbJdFVrSUe5dG9s5t5p
	n5k2r/wFRJw0+57Rl+luOsnJQsXw4eJ8uvFPkapaa9bWwo9soKGwdlmuXKLV3Iuk7KlNzIWhCIHEE
	C9wzKMTX8KoxQu8rAJjIIjFo8hd6s6feSvf9+7RFLmCGBuqeT8K+eKxipi8SpmhuQQrg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVwae-00HIDF-Vh; Sun, 29 Jun 2025 20:17:20 +0200
Date: Sun, 29 Jun 2025 20:17:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: Use kcalloc()
Message-ID: <362c9237-237c-4e81-81e6-c15761baacb4@lunn.ch>
References: <46040062161dda211580002f950a6d60433243dc.1751200453.git.christophe.jaillet@wanadoo.fr>
 <2f4fca4ff84950da71e007c9169f18a0272476f3.1751200453.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4fca4ff84950da71e007c9169f18a0272476f3.1751200453.git.christophe.jaillet@wanadoo.fr>

On Sun, Jun 29, 2025 at 02:35:50PM +0200, Christophe JAILLET wrote:
> Use kcalloc() instead of hand writing it. This is less verbose.
> 
> Also move the initialization of 'count' to save some LoC.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   18652	   5920	     64	  24636	   603c	drivers/net/dsa/mv88e6xxx/devlink.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   18498	   5920	     64	  24482	   5fa2	drivers/net/dsa/mv88e6xxx/devlink.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

