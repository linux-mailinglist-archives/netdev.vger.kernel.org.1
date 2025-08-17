Return-Path: <netdev+bounces-214390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30012B293D6
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCABA485AF6
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291DD2D8369;
	Sun, 17 Aug 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HFSmbdI+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944E29E106;
	Sun, 17 Aug 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444580; cv=none; b=IlvmDA1JpsQPW0blytAF7x+RK0oYYyj3pGVn+K9GEj15RJsGTzjMKjD1gGnt1SUyNgWBEZ7anIQrdfBP5v96wtSt/5aKQxWuhkyYorWDxyzwMFz/quIdkQexrkfwtJW7aXk1LWKGllA/CQ8mw6MHh+Erz7Pxi0vYDANeSp0dU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444580; c=relaxed/simple;
	bh=psfGphosyPsIGZyledyPUiB8BVVkCpkmBes47nXFPsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9AL0Z0w6FKHOlET2fkRlHNN0JSpDoRkLEKQKwripMPE4ecpFl7dch6KaexGbyORpSUHXqOcoFpitV/xhS/H8iyz4d+4YhShcKes6DIGxU1QXmWngz98a8046RfykAwAgR3EvnksJWZ5N7aIaJkekuGfNsjei8nxFhSJG+JZlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HFSmbdI+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+DB6ELci/78zEE3WyjyaSuliTnpnH+wJ+xOOx9AhjjA=; b=HFSmbdI+teq9QbzoCxqsdCKDG7
	LMCQVpWwnfVXH+h46mZ2Z/BCQ6eB0dJE/TOdAF1/HdTPGZDkfFwZ2C/P6QJddINui0iI59wJ+LOhq
	LOYhJfKu1mUVn0AkGwVx0i2+31OxjmPLvBGWEaayAeX3UxSXSZLg6ZFf+tQ223A5yL9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfJs-004yMr-E2; Sun, 17 Aug 2025 17:29:16 +0200
Date: Sun, 17 Aug 2025 17:29:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 06/23] net: dsa: lantiq_gswip: load
 model-specific microcode
Message-ID: <c8128783-6eac-4362-ae31-f2ae28122803@lunn.ch>
References: <aKDhZ9LQi63Qadvh@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKDhZ9LQi63Qadvh@pidgin.makrotopia.org>

>  
> +struct gswip_pce_microcode {
> +	u16 val_3;
> +	u16 val_2;
> +	u16 val_1;
> +	u16 val_0;
> +};
> +

I would leave this where it is, and just have

struct gswip_pce_microcode;

Since only a pointer is needed, the compiler does not need the full
type info, at this point.

The structure itself is rather opaque, and only makes some sort of
sense when next to the MAC_ENTRY macro.

    Andrew

---
pw-bot: cr
	

