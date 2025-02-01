Return-Path: <netdev+bounces-161938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE70A24B7B
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 19:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61B3163978
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696B1CAA8D;
	Sat,  1 Feb 2025 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OpVjJuug"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C80A1BD01D
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738436107; cv=none; b=YuH7QKaA8ZyZqAidQyVXiZsVxMvPy+nm5yPjnGAHfV/P6a5EPXUM+y5YVy8c6TJPfNrqn4Lz5cIqeNRACixqTs8IXE07SuYKPv50/s8Ic+waEOQ6Ci4Khs3h0lT+vRG17rzPIRHhckl0ooMdO0FEtg72M48ANOEzRL+izQPpDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738436107; c=relaxed/simple;
	bh=R7OS/MXFMUXwhvz7Kc4TGuoxR0IYMlfMZ9Ad1ajvLvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSV88LR15LH3UfplP6KypaLZqlGFyCE64eyNsouhXJTL8iQGabzW26Pfnq9sEusjlI3X2xjsLAS5fNC+/gzYMml/dh6eI1RyFJHc34cE97RLmgrWP7vrqn+AD6Wj4VEtOa6GuxLtsqeTIf5I8vc28QOU3JxowBetOcPhYSv+sLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OpVjJuug; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X5ZT/h+p89qeEa5RIXxfCBGj1xjBO6R4oKcKC+7A56I=; b=OpVjJuugpl1+0AnhDi9Ooogtcw
	XOFTC9tsx5XeS2h9+DwnDU/FJCC1as2V9YZ8Jpjnx6+79jd3sGrTAMMhnafxsL6upLGxhrnXC928/
	a9j/QIK5423Usqeej45tYqFrQkbDh5kP3FWKoV1G6JmLdW/Rtvi3wseRaF/fptNprNZU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1teIdp-00A2ZF-Uq; Sat, 01 Feb 2025 19:54:53 +0100
Date: Sat, 1 Feb 2025 19:54:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v2] net: ethernet: actions: Use
 of_get_available_child_by_name()
Message-ID: <278e8d0c-e4bd-4126-8617-be2b7134b307@lunn.ch>
References: <20250201172745.56627-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201172745.56627-1-biju.das.jz@bp.renesas.com>

On Sat, Feb 01, 2025 at 05:27:40PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> owl_emac_mdio_init().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v3:
>  * Dropped duplicate mdio_node declaration.

And version 2?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Also

1.6.7. Resending after review

Allow at least 24 hours to pass between postings. This will ensure
reviewers from all geographical locations have a chance to chime in.

and section

1.6.6. Clean-up patches

Netdev discourages patches which perform simple clean-ups, which are
not in the context of other work. For example:

o Addressing checkpatch.pl warnings
o Addressing Local variable ordering issues
o Conversions to device-managed APIs (devm_ helpers)

This is because it is felt that the churn that such changes produce
comes at a greater cost than the value of such clean-ups.

    Andrew

---
pw-bot: cr

