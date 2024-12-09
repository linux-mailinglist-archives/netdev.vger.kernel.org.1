Return-Path: <netdev+bounces-150279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A376A9E9C2C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CE11886E59
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBA614BF92;
	Mon,  9 Dec 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vz68fwh9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3D1465BA;
	Mon,  9 Dec 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763263; cv=none; b=sv0m8w5N8+Ie8++U2CBoF3akfM+uPuadtD80cl8/debifIK4n/o5JMRqj+57cst2tPAd5BS7D3E3OfIbwJGgGqO50zUxldvGZXDW/rXCJYond391A6/sroEjKmXrBc7Umf/zTrJLOBsTz/ESP12pGXXTc2dxi88O+EMv/8A0g0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763263; c=relaxed/simple;
	bh=+Um87OK029W18CKSO9ksat2vlJj9Pir9wPRI/6IrrMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zj3tDoG3Pa44BbzgivpJ6kftpzLjCluDBtogEm689qPhT7aNbrug08qpx60UyNhGWYmvW7XXVvkFdkQuqqfTVvPoVvStxIu/vWFuUUeBxw13yNZVpn/4k1oaAmUZsaWIKiJkHq0n1J6qWELoCse6Til4PzCSEqpfrDKC8Q5Galo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vz68fwh9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XJ36jjyRlVWT7uD37wfdml35aQJkssXzySfHMBuIM78=; b=vz68fwh9wBi/hPRDdCemsucEPN
	GhJNjmNewPdTgeoCQ3ktEM9b62pxKhzSkg3CHiuyIkYTWBcBM9JPqyHBz1jsGkBPTO36OyDMU1j6g
	IGSJBKpvQsJqsPa+8K6yetOzduy/Cqj2E9OQsuK+v6U7O07QNJlzVJydtUhUaihbZebk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKh1Q-00FhAt-UP; Mon, 09 Dec 2024 17:54:12 +0100
Date: Mon, 9 Dec 2024 17:54:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun Alle <Tarun.Alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: Auto-negotiaion changes
 for T1 phy in phy library
Message-ID: <ad3f19b8-20fc-41c9-bfd0-e5f9996da578@lunn.ch>
References: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
 <20241209161427.3580256-2-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209161427.3580256-2-Tarun.Alle@microchip.com>

On Mon, Dec 09, 2024 at 09:44:26PM +0530, Tarun Alle wrote:
> Below auto-negotiation library changes required for T1 phys:
> - Lower byte advertisement register need to read after higher byte as
>   per 802.3-2022 : Section 45.2.7.22.

Is this a fix? Does Linux have any T1 PHYs which already support
auto-neg? Either add a comment this is not a fix because...., or
please pull this out into a patch for net, with a Fixes: tag.

	Andrew

